Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB3DC27A898
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Sep 2020 09:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgI1H30 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Sep 2020 03:29:26 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:30567 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726559AbgI1H30 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Sep 2020 03:29:26 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601278166; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=f0dzop7uPBp/ODKleTomdf37qYvd0WrXnnbCkdNXfng=; b=g8P6JP6bBaAgW5hdlEfC0IvQpCVr7x81q+8FchFi0ZI7zgRSZS3bi+LslYhh8nFu81BMg8R9
 ALGACQvkN+MzznmxsSwNZE3RarYFueg8RfpX/06YILXD7JPuDuMI8ttbDxpXNxIF7cZw5ZXQ
 eSKtr6ouiNCFov8SKUDDQFBILmg=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5f7190ca356bcc21fbe4b51d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 28 Sep 2020 07:29:14
 GMT
Sender: rmanohar=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8C3C9C433F1; Mon, 28 Sep 2020 07:29:13 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from rmanohar-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rmanohar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C2BC6C433CA;
        Mon, 28 Sep 2020 07:29:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C2BC6C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=rmanohar@codeaurora.org
From:   Rajkumar Manoharan <rmanohar@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Rajkumar Manoharan <rmanohar@codeaurora.org>
Subject: [PATCH 2/2] nl80211: extend support to config spatial reuse parameter set
Date:   Mon, 28 Sep 2020 00:28:11 -0700
Message-Id: <1601278091-20313-2-git-send-email-rmanohar@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1601278091-20313-1-git-send-email-rmanohar@codeaurora.org>
References: <1601278091-20313-1-git-send-email-rmanohar@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Allow the user to configure below Spatial Reuse Parameter Set element.
  * Non-SRG OBSS PD Max Offset
  * SRG BSS Color Bitmap
  * SRG Partial BSSID Bitmap

Signed-off-by: Rajkumar Manoharan <rmanohar@codeaurora.org>
---
 include/linux/ieee80211.h    |  7 +++++--
 include/net/cfg80211.h       | 10 ++++++++++
 include/uapi/linux/nl80211.h | 11 +++++++++++
 net/wireless/nl80211.c       | 27 +++++++++++++++++++++++++++
 4 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 53fba39d4ba6..456ec64de747 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -2294,8 +2294,11 @@ ieee80211_he_6ghz_oper(const struct ieee80211_he_operation *he_oper)
 }
 
 /* HE Spatial Reuse defines */
-#define IEEE80211_HE_SPR_NON_SRG_OFFSET_PRESENT			0x4
-#define IEEE80211_HE_SPR_SRG_INFORMATION_PRESENT		0x8
+#define IEEE80211_HE_SPR_PSR_DISALLOWED				BIT(0)
+#define IEEE80211_HE_SPR_NON_SRG_OBSS_PD_SR_DISALLOWED		BIT(1)
+#define IEEE80211_HE_SPR_NON_SRG_OFFSET_PRESENT			BIT(2)
+#define IEEE80211_HE_SPR_SRG_INFORMATION_PRESENT		BIT(3)
+#define IEEE80211_HE_SPR_HESIGA_SR_VAL15_ALLOWED		BIT(4)
 
 /*
  * ieee80211_he_spr_size - calculate 802.11ax HE Spatial Reuse IE size
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 10c2cc8f0efc..1738fee2f0d5 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -269,13 +269,23 @@ struct ieee80211_rate {
  * struct ieee80211_he_obss_pd - AP settings for spatial reuse
  *
  * @enable: is the feature enabled.
+ * @sr_ctrl: The SR Control field of SRP element.
+ * @non_srg_max_offset: non-SRG maximum tx power offset
  * @min_offset: minimal tx power offset an associated station shall use
  * @max_offset: maximum tx power offset an associated station shall use
+ * @bss_color_bitmap: bitmap that indicates the BSS color values used by
+ *	members of the SRG
+ * @partial_bssid_bitmap: bitmap that indicates the partial BSSID values
+ *	used by members of the SRG
  */
 struct ieee80211_he_obss_pd {
 	bool enable;
+	u8 sr_ctrl;
+	u8 non_srg_max_offset;
 	u8 min_offset;
 	u8 max_offset;
+	u8 bss_color_bitmap[8];
+	u8 partial_bssid_bitmap[8];
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 4b1ec7ad44d5..b70def9277b3 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -6982,6 +6982,13 @@ enum nl80211_peer_measurement_ftm_resp {
  *
  * @NL80211_HE_OBSS_PD_ATTR_MIN_OFFSET: the OBSS PD minimum tx power offset.
  * @NL80211_HE_OBSS_PD_ATTR_MAX_OFFSET: the OBSS PD maximum tx power offset.
+ * @NL80211_HE_OBSS_PD_ATTR_NON_SRG_MAX_OFFSET: the non-SRG OBSS PD maximum
+ *	tx power offset.
+ * @NL80211_HE_OBSS_PD_ATTR_BSS_COLOR_BITMAP: bitmap that indicates the BSS color
+ *	values used by members of the SRG.
+ * @NL80211_HE_OBSS_PD_ATTR_PARTIAL_BSSID_BITMAP: bitmap that indicates the partial
+ *	BSSID values used by members of the SRG.
+ * @NL80211_HE_OBSS_PD_ATTR_SR_CTRL: The SR Control field of SRP element.
  *
  * @__NL80211_HE_OBSS_PD_ATTR_LAST: Internal
  * @NL80211_HE_OBSS_PD_ATTR_MAX: highest OBSS PD attribute.
@@ -6991,6 +6998,10 @@ enum nl80211_obss_pd_attributes {
 
 	NL80211_HE_OBSS_PD_ATTR_MIN_OFFSET,
 	NL80211_HE_OBSS_PD_ATTR_MAX_OFFSET,
+	NL80211_HE_OBSS_PD_ATTR_NON_SRG_MAX_OFFSET,
+	NL80211_HE_OBSS_PD_ATTR_BSS_COLOR_BITMAP,
+	NL80211_HE_OBSS_PD_ATTR_PARTIAL_BSSID_BITMAP,
+	NL80211_HE_OBSS_PD_ATTR_SR_CTRL,
 
 	/* keep last */
 	__NL80211_HE_OBSS_PD_ATTR_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index e7b84e36014c..9307407c2602 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -329,6 +329,13 @@ he_obss_pd_policy[NL80211_HE_OBSS_PD_ATTR_MAX + 1] = {
 		NLA_POLICY_RANGE(NLA_U8, 1, 20),
 	[NL80211_HE_OBSS_PD_ATTR_MAX_OFFSET] =
 		NLA_POLICY_RANGE(NLA_U8, 1, 20),
+	[NL80211_HE_OBSS_PD_ATTR_NON_SRG_MAX_OFFSET] =
+		NLA_POLICY_RANGE(NLA_U8, 1, 20),
+	[NL80211_HE_OBSS_PD_ATTR_BSS_COLOR_BITMAP] =
+		NLA_POLICY_EXACT_LEN(8),
+	[NL80211_HE_OBSS_PD_ATTR_PARTIAL_BSSID_BITMAP] =
+		NLA_POLICY_EXACT_LEN(8),
+	[NL80211_HE_OBSS_PD_ATTR_SR_CTRL] = { .type = NLA_U8 },
 };
 
 static const struct nla_policy
@@ -4871,16 +4878,36 @@ static int nl80211_parse_he_obss_pd(struct nlattr *attrs,
 	if (err)
 		return err;
 
+	if (!tb[NL80211_HE_OBSS_PD_ATTR_SR_CTRL])
+		return -EINVAL;
+
+	he_obss_pd->sr_ctrl = nla_get_u8(tb[NL80211_HE_OBSS_PD_ATTR_SR_CTRL]);
+
 	if (tb[NL80211_HE_OBSS_PD_ATTR_MIN_OFFSET])
 		he_obss_pd->min_offset =
 			nla_get_u8(tb[NL80211_HE_OBSS_PD_ATTR_MIN_OFFSET]);
 	if (tb[NL80211_HE_OBSS_PD_ATTR_MAX_OFFSET])
 		he_obss_pd->max_offset =
 			nla_get_u8(tb[NL80211_HE_OBSS_PD_ATTR_MAX_OFFSET]);
+	if (tb[NL80211_HE_OBSS_PD_ATTR_NON_SRG_MAX_OFFSET])
+		he_obss_pd->non_srg_max_offset =
+			nla_get_u8(tb[NL80211_HE_OBSS_PD_ATTR_NON_SRG_MAX_OFFSET]);
 
 	if (he_obss_pd->min_offset > he_obss_pd->max_offset)
 		return -EINVAL;
 
+	if (tb[NL80211_HE_OBSS_PD_ATTR_BSS_COLOR_BITMAP]) {
+		memcpy(he_obss_pd->bss_color_bitmap,
+		       nla_data(tb[NL80211_HE_OBSS_PD_ATTR_BSS_COLOR_BITMAP]),
+		       sizeof(he_obss_pd->bss_color_bitmap));
+	}
+
+	if (tb[NL80211_HE_OBSS_PD_ATTR_PARTIAL_BSSID_BITMAP]) {
+		memcpy(he_obss_pd->partial_bssid_bitmap,
+		       nla_data(tb[NL80211_HE_OBSS_PD_ATTR_PARTIAL_BSSID_BITMAP]),
+		       sizeof(he_obss_pd->partial_bssid_bitmap));
+	}
+
 	he_obss_pd->enable = true;
 
 	return 0;
-- 
2.7.4

