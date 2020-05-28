Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7651E6482
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2020 16:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391132AbgE1Ouf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 10:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728600AbgE1Oua (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 10:50:30 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC22C08C5CA
        for <linux-wireless@vger.kernel.org>; Thu, 28 May 2020 07:50:29 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jeJrW-004vYI-Fe; Thu, 28 May 2020 16:50:26 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 04/24] ieee80211: add code to obtain and parse 6 GHz operation field
Date:   Thu, 28 May 2020 16:50:00 +0200
Message-Id: <20200528165011.42ca72c45ca9.Id74bc1b03da9ea6574f9bc70deeb60dfc1634359@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200528165011.993f108e96ca.I0086ae42d672379380d04ac5effb2f3d5135731b@changeid>
References: <20200528165011.993f108e96ca.I0086ae42d672379380d04ac5effb2f3d5135731b@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Add some code to obtain and parse the 6 GHz operation field
inside the HE operation element.

While at it, fix the required length using sizeof() the new
struct, which is 5 instead of 4 now.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/linux/ieee80211.h | 52 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index c29184bf9416..2bd9e757167d 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -2209,6 +2209,28 @@ ieee80211_he_ppe_size(u8 ppe_thres_hdr, const u8 *phy_cap_info)
 #define IEEE80211_HE_OPERATION_PARTIAL_BSS_COLOR		0x40000000
 #define IEEE80211_HE_OPERATION_BSS_COLOR_DISABLED		0x80000000
 
+/**
+ * ieee80211_he_6ghz_oper - HE 6 GHz operation Information field
+ * @primary: primary channel
+ * @control: control flags
+ * @ccfs0: channel center frequency segment 0
+ * @ccfs1: channel center frequency segment 1
+ * @minrate: minimum rate (in 1 Mbps units)
+ */
+struct ieee80211_he_6ghz_oper {
+	u8 primary;
+#define IEEE80211_HE_6GHZ_OPER_CTRL_CHANWIDTH	0x3
+#define		IEEE80211_HE_6GHZ_OPER_CTRL_CHANWIDTH_20MHZ	0
+#define		IEEE80211_HE_6GHZ_OPER_CTRL_CHANWIDTH_40MHZ	1
+#define		IEEE80211_HE_6GHZ_OPER_CTRL_CHANWIDTH_80MHZ	2
+#define		IEEE80211_HE_6GHZ_OPER_CTRL_CHANWIDTH_160MHZ	3
+#define IEEE80211_HE_6GHZ_OPER_CTRL_DUP_BEACON	0x4
+	u8 control;
+	u8 ccfs0;
+	u8 ccfs1;
+	u8 minrate;
+} __packed;
+
 /*
  * ieee80211_he_oper_size - calculate 802.11ax HE Operations IE size
  * @he_oper_ie: byte data of the He Operations IE, stating from the byte
@@ -2235,7 +2257,7 @@ ieee80211_he_oper_size(const u8 *he_oper_ie)
 	if (he_oper_params & IEEE80211_HE_OPERATION_CO_HOSTED_BSS)
 		oper_len++;
 	if (he_oper_params & IEEE80211_HE_OPERATION_6GHZ_OP_INFO)
-		oper_len += 4;
+		oper_len += sizeof(struct ieee80211_he_6ghz_oper);
 
 	/* Add the first byte (extension ID) to the total length */
 	oper_len++;
@@ -2243,6 +2265,34 @@ ieee80211_he_oper_size(const u8 *he_oper_ie)
 	return oper_len;
 }
 
+/**
+ * ieee80211_he_6ghz_oper - obtain 6 GHz operation field
+ * @he_oper: HE operation element (must be pre-validated for size)
+ *	but may be %NULL
+ *
+ * Return: a pointer to the 6 GHz operation field, or %NULL
+ */
+static inline const struct ieee80211_he_6ghz_oper *
+ieee80211_he_6ghz_oper(const struct ieee80211_he_operation *he_oper)
+{
+	const u8 *ret = (void *)&he_oper->optional;
+	u32 he_oper_params;
+
+	if (!he_oper)
+		return NULL;
+
+	he_oper_params = le32_to_cpu(he_oper->he_oper_params);
+
+	if (!(he_oper_params & IEEE80211_HE_OPERATION_6GHZ_OP_INFO))
+		return NULL;
+	if (he_oper_params & IEEE80211_HE_OPERATION_VHT_OPER_INFO)
+		ret += 3;
+	if (he_oper_params & IEEE80211_HE_OPERATION_CO_HOSTED_BSS)
+		ret++;
+
+	return (void *)ret;
+}
+
 /* HE Spatial Reuse defines */
 #define IEEE80211_HE_SPR_NON_SRG_OFFSET_PRESENT			0x4
 #define IEEE80211_HE_SPR_SRG_INFORMATION_PRESENT		0x8
-- 
2.26.2

