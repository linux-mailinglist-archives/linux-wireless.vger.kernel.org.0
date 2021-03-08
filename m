Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A58313319E8
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Mar 2021 23:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbhCHWCQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 Mar 2021 17:02:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:53842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230169AbhCHWCA (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 Mar 2021 17:02:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2F95D65253;
        Mon,  8 Mar 2021 22:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615240920;
        bh=xcy5F5zmAlbPEHY/L5reOcPARsA0AK8g97JFiyeT1zI=;
        h=From:To:Cc:Subject:Date:From;
        b=XklG3pc4FWJpa4nW4uQHw3oB9f3gHjj0c9LcGIlz2iJ78GVZlAs3MH0aAdv4ojRzR
         lx9xq4wyvxmNJlBNHKqnabfURCkpGJQGoVBK/lkHfEGXfRImVntt61ethe+rqJ9Azq
         no99jiKAqcrlVNCHZUi7JFgJP6XdWsOEfl6SQP2VrJJFCh+nIyOm46w46ttSz9ayvH
         ldyqNxibBSNroemotG2ceMx4ttTWuYYnD57dklkbSCgMgnzuRhTo1r6V6HB0L4Ms4t
         Sb5H5XePMVaat7ZrgfEkvC5KIXHsLi3+OLieq46ZFJXzM4bbLNWHDIR/21RcxhcKtb
         FzTbf/DCc9ZWQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     linux-wireless@vger.kernel.org
Cc:     lorenzo.bianconi@redhat.com, johannes@sipsolutions.net
Subject: [PATCH mac80211-next] mac80211: set sk_pacing_shift for 802.3 txpath
Date:   Mon,  8 Mar 2021 23:01:49 +0100
Message-Id: <7230abc48dcf940657838546cdaef7dce691ecdd.1615240733.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Similar to 802.11 txpath, set socket sk_pacing_shift for 802.3 tx path.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 net/mac80211/tx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 5d06de61047a..e24e96b65dd3 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4150,6 +4150,9 @@ static bool ieee80211_tx_8023(struct ieee80211_sub_if_data *sdata,
 	unsigned long flags;
 	int q = info->hw_queue;
 
+	if (sta)
+		sk_pacing_shift_update(skb->sk, local->hw.tx_sk_pacing_shift);
+
 	if (ieee80211_queue_skb(local, sdata, sta, skb))
 		return true;
 
-- 
2.29.2

