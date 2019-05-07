Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5E8D15CEE
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2019 08:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbfEGGIP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 May 2019 02:08:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:53022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726645AbfEGFcz (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 May 2019 01:32:55 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2EB0206A3;
        Tue,  7 May 2019 05:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557207174;
        bh=8wC/aVu90WOcgXFnnUmi4jIsKqjKe6SON/plxwCe4l4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zcYhb8NA0BvjWyGVSaldsXLoJ/GO7Q2jg5drXZBChJtO3Jhdve14OvSlJoIK4AnEX
         RWaJu+f1SH1l/MVr1FuKRo/EvP1FL6lyHYLrHobeXI03U6E0PH4QFNUiMhNK3f5ang
         j17eIQI1i9bXvVfLsaF1i6whaKTnuR1+OhBhjzy8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Felix Fietkau <nbd@nbd.name>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 14/99] mac80211: fix memory accounting with A-MSDU aggregation
Date:   Tue,  7 May 2019 01:31:08 -0400
Message-Id: <20190507053235.29900-14-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190507053235.29900-1-sashal@kernel.org>
References: <20190507053235.29900-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Felix Fietkau <nbd@nbd.name>

[ Upstream commit eb9b64e3a9f8483e6e54f4e03b2ae14ae5db2690 ]

skb->truesize can change due to memory reallocation or when adding extra
fragments. Adjust fq->memory_usage accordingly

Signed-off-by: Felix Fietkau <nbd@nbd.name>
Acked-by: Toke Høiland-Jørgensen <toke@redhat.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/tx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 928f13a208b0..714d80e48a10 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -3214,6 +3214,7 @@ static bool ieee80211_amsdu_aggregate(struct ieee80211_sub_if_data *sdata,
 	u8 max_subframes = sta->sta.max_amsdu_subframes;
 	int max_frags = local->hw.max_tx_fragments;
 	int max_amsdu_len = sta->sta.max_amsdu_len;
+	int orig_truesize;
 	__be16 len;
 	void *data;
 	bool ret = false;
@@ -3254,6 +3255,7 @@ static bool ieee80211_amsdu_aggregate(struct ieee80211_sub_if_data *sdata,
 	if (!head || skb_is_gso(head))
 		goto out;
 
+	orig_truesize = head->truesize;
 	orig_len = head->len;
 
 	if (skb->len + head->len > max_amsdu_len)
@@ -3311,6 +3313,7 @@ static bool ieee80211_amsdu_aggregate(struct ieee80211_sub_if_data *sdata,
 	*frag_tail = skb;
 
 out_recalc:
+	fq->memory_usage += head->truesize - orig_truesize;
 	if (head->len != orig_len) {
 		flow->backlog += head->len - orig_len;
 		tin->backlog_bytes += head->len - orig_len;
-- 
2.20.1

