Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C708B1C0A50
	for <lists+linux-wireless@lfdr.de>; Fri,  1 May 2020 00:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgD3WVc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Apr 2020 18:21:32 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:34947 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726697AbgD3WVc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Apr 2020 18:21:32 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588285291; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=qI0MCgapxJM2yN2WArwQzjt/VfFHUH0kGqFscZOMrHg=; b=bJxOktyvzojdlgaxDWggx3HI0iKhRcolTb4ZrjrzSiOrnxKQIGbxJCp0Y94jrB0HebCw2Wz/
 NGnVKZfyaBu6W746rVAl0P99hYBYvwg37Qh4YBKoN0o7B+qaVMKWCYXf2dmF1xXJYvP4CtZ5
 hpNd2i8N7mwB95J9XNLCYgbeHSI=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eab4f5a.7f7d50e2a148-smtp-out-n01;
 Thu, 30 Apr 2020 22:21:14 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8665BC433CB; Thu, 30 Apr 2020 22:21:13 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from rmanohar-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rmanohar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C367AC433D2;
        Thu, 30 Apr 2020 22:21:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C367AC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rmanohar@codeaurora.org
From:   Rajkumar Manoharan <rmanohar@codeaurora.org>
To:     johannes@sipsolutions.net, kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Rajkumar Manoharan <rmanohar@codeaurora.org>
Subject: [PATCH v2 05/11] mac80211: fix memory overlap due to variable length param
Date:   Thu, 30 Apr 2020 15:20:46 -0700
Message-Id: <1588285252-30034-5-git-send-email-rmanohar@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588285252-30034-1-git-send-email-rmanohar@codeaurora.org>
References: <1588285252-30034-1-git-send-email-rmanohar@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

As of now HE operation element in bss_conf includes variable length
optional field followed by other HE variable. Though the optional
field never be used, actually it is referring to next member of the
bss_conf structure which is not correct. Fix it by declaring needed
HE operation fields within bss_conf itself.

Signed-off-by: Rajkumar Manoharan <rmanohar@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/mac.c |  3 +--
 include/net/mac80211.h                |  7 +++++--
 net/mac80211/he.c                     | 13 +++++--------
 3 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 9f8bc19cc5ae..06d063274eea 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -1168,8 +1168,7 @@ static void ath11k_peer_assoc_h_he(struct ath11k *ar,
 	       sizeof(arg->peer_he_cap_macinfo));
 	memcpy(&arg->peer_he_cap_phyinfo, he_cap->he_cap_elem.phy_cap_info,
 	       sizeof(arg->peer_he_cap_phyinfo));
-	memcpy(&arg->peer_he_ops, &vif->bss_conf.he_operation,
-	       sizeof(arg->peer_he_ops));
+	arg->peer_he_ops = vif->bss_conf.he_oper.params;
 
 	/* the top most byte is used to indicate BSS color info */
 	arg->peer_he_ops &= 0xffffff;
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 97fec4d310ac..2af956bdf80c 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -603,7 +603,7 @@ struct ieee80211_ftm_responder_params {
  *	nontransmitted BSSIDs
  * @profile_periodicity: the least number of beacon frames need to be received
  *	in order to discover all the nontransmitted BSSIDs in the set.
- * @he_operation: HE operation information of the AP we are connected to
+ * @he_oper: HE operation information of the AP we are connected to
  * @he_obss_pd: OBSS Packet Detection parameters.
  * @he_bss_color: BSS coloring settings, if BSS supports HE
  */
@@ -666,7 +666,10 @@ struct ieee80211_bss_conf {
 	u8 bssid_indicator;
 	bool ema_ap;
 	u8 profile_periodicity;
-	struct ieee80211_he_operation he_operation;
+	struct {
+		u32 params;
+		u16 nss_set;
+	} he_oper;
 	struct ieee80211_he_obss_pd he_obss_pd;
 	struct cfg80211_he_bss_color he_bss_color;
 };
diff --git a/net/mac80211/he.c b/net/mac80211/he.c
index 1087f715338b..f520552b22be 100644
--- a/net/mac80211/he.c
+++ b/net/mac80211/he.c
@@ -57,17 +57,14 @@ ieee80211_he_cap_ie_to_sta_he_cap(struct ieee80211_sub_if_data *sdata,
 
 void
 ieee80211_he_op_ie_to_bss_conf(struct ieee80211_vif *vif,
-			const struct ieee80211_he_operation *he_op_ie_elem)
+			const struct ieee80211_he_operation *he_op_ie)
 {
-	struct ieee80211_he_operation *he_operation =
-					&vif->bss_conf.he_operation;
-
-	if (!he_op_ie_elem) {
-		memset(he_operation, 0, sizeof(*he_operation));
+	memset(&vif->bss_conf.he_oper, 0, sizeof(vif->bss_conf.he_oper));
+	if (!he_op_ie)
 		return;
-	}
 
-	vif->bss_conf.he_operation = *he_op_ie_elem;
+	vif->bss_conf.he_oper.params = __le32_to_cpu(he_op_ie->he_oper_params);
+	vif->bss_conf.he_oper.nss_set = __le16_to_cpu(he_op_ie->he_mcs_nss_set);
 }
 
 void
-- 
2.7.4
