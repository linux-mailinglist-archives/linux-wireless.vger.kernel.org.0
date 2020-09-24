Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A76002777B8
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Sep 2020 19:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbgIXRZX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Sep 2020 13:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728681AbgIXRZU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Sep 2020 13:25:20 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFC3C0613D3
        for <linux-wireless@vger.kernel.org>; Thu, 24 Sep 2020 10:25:20 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kLUzd-00AI43-Ra; Thu, 24 Sep 2020 19:25:17 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 2/3] mac80211: fix some missing kernel-doc
Date:   Thu, 24 Sep 2020 19:25:11 +0200
Message-Id: <20200924192511.21411377b0a8.I1add147d782a3bf38287bde412dc98f69323c732@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200924192511.6a344ebd8d65.Ie95a47db5887b8d2faa8ca2df474a955a376c4c4@changeid>
References: <20200924192511.6a344ebd8d65.Ie95a47db5887b8d2faa8ca2df474a955a376c4c4@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Two parameters are not described, add them.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/tx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index adc83d830691..141ed8c5aa7e 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -2473,7 +2473,9 @@ static u16 ieee80211_store_ack_skb(struct ieee80211_local *local,
  * @sdata: virtual interface to build the header for
  * @skb: the skb to build the header in
  * @info_flags: skb flags to set
+ * @sta: the station pointer
  * @ctrl_flags: info control flags to set
+ * @cookie: cookie pointer to fill (if not %NULL)
  *
  * This function takes the skb with 802.3 header and reformats the header to
  * the appropriate IEEE 802.11 header based on which interface the packet is
-- 
2.26.2

