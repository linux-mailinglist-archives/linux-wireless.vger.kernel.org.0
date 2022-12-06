Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14386445D1
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Dec 2022 15:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234364AbiLFOhp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Dec 2022 09:37:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233120AbiLFOhl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Dec 2022 09:37:41 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD4962D8
        for <linux-wireless@vger.kernel.org>; Tue,  6 Dec 2022 06:37:38 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B6D30kc007602;
        Tue, 6 Dec 2022 14:37:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=Ux7QzhCQUL19UXiH3sEmsVSk5ouxlh8mVymnhqNzxoE=;
 b=BPOT0eoi3LLbMALNuIlPE0BlweO6EgrNC8LUXa38BH0880EKAHr9glPN28L750+DCWdi
 fEChdCsQt1rJQyXgoUA4lAsgu7XVDlTsNid5JnEWb2K6kBNRgdRECp5HPpbyVF2tWxar
 xqLhGSMdHBZw5YQG/4ejMSpkaPnyu5W75DrdyZ7H6x4sf2KQWCnVLVX0/23IYjM4NolP
 pZyj7uSCiuzHTuvr8oEWcxMpF9n2UkvE1G/51GqPyAvADDZR0oMlUFIHmIcjbe1VEers
 hsaYb+kqMXtqslUpUsU7jcgAnkJg/r+7c1kfiPVZmKbLcWmVTg0e5CFtQBgmC2b9tNTl hA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m9uk99mtv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Dec 2022 14:37:35 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2B6EbYrk032039
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 6 Dec 2022 14:37:34 GMT
Received: from cnss-mw-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 6 Dec 2022 06:37:33 -0800
From:   Veerendranath Jakkam <quic_vjakkam@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/2] wifi: cfg80211: Support 32 bytes KCK key in GTK rekey offload
Date:   Tue, 6 Dec 2022 20:07:15 +0530
Message-ID: <20221206143715.1802987-3-quic_vjakkam@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221206143715.1802987-1-quic_vjakkam@quicinc.com>
References: <20221206143715.1802987-1-quic_vjakkam@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: gNx1CCGQEfgLv1hb5zQO2InHYWN2fR34
X-Proofpoint-GUID: gNx1CCGQEfgLv1hb5zQO2InHYWN2fR34
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-06_09,2022-12-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212060119
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shivani Baranwal <quic_shivbara@quicinc.com>

Currently, maximum KCK key length supported for GTK rekey offload is 24
bytes but with some newer AKMs the KCK key length can be 32 bytes. e.g.,
00-0F-AC:24 AKM suite with SAE finite cyclic group 21. Add support to
allow 32 bytes KCK keys in GTK rekey offload.

Signed-off-by: Shivani Baranwal <quic_shivbara@quicinc.com>
Signed-off-by: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
---
 include/net/cfg80211.h       | 3 ++-
 include/uapi/linux/nl80211.h | 1 +
 net/wireless/nl80211.c       | 6 ++++--
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 03d4f4deadae..21bf8262fdf9 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4690,6 +4690,7 @@ struct cfg80211_ops {
  *	in order to not have them reachable in normal drivers, until we have
  *	complete feature/interface combinations/etc. advertisement. No driver
  *	should set this flag for now.
+ * @WIPHY_FLAG_SUPPORTS_EXT_KCK_32: The device supports 32-byte KCK keys.
  */
 enum wiphy_flags {
 	WIPHY_FLAG_SUPPORTS_EXT_KEK_KCK		= BIT(0),
@@ -4702,7 +4703,7 @@ enum wiphy_flags {
 	WIPHY_FLAG_CONTROL_PORT_PROTOCOL	= BIT(7),
 	WIPHY_FLAG_IBSS_RSN			= BIT(8),
 	WIPHY_FLAG_MESH_AUTH			= BIT(10),
-	/* use hole at 11 */
+	WIPHY_FLAG_SUPPORTS_EXT_KCK_32          = BIT(11),
 	/* use hole at 12 */
 	WIPHY_FLAG_SUPPORTS_FW_ROAM		= BIT(13),
 	WIPHY_FLAG_AP_UAPSD			= BIT(14),
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index c14a91bbca7c..429bdc399962 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -5869,6 +5869,7 @@ enum plink_actions {
 #define NL80211_KEK_LEN			16
 #define NL80211_KCK_EXT_LEN		24
 #define NL80211_KEK_EXT_LEN		32
+#define NL80211_KCK_EXT_LEN_32		32
 #define NL80211_REPLAY_CTR_LEN		8
 
 /**
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 02b9a0280896..64cf6110ce9d 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -883,7 +883,7 @@ nl80211_rekey_policy[NUM_NL80211_REKEY_DATA] = {
 	},
 	[NL80211_REKEY_DATA_KCK] = {
 		.type = NLA_BINARY,
-		.len = NL80211_KCK_EXT_LEN
+		.len = NL80211_KCK_EXT_LEN_32
 	},
 	[NL80211_REKEY_DATA_REPLAY_CTR] = NLA_POLICY_EXACT_LEN(NL80211_REPLAY_CTR_LEN),
 	[NL80211_REKEY_DATA_AKM] = { .type = NLA_U32 },
@@ -13809,7 +13809,9 @@ static int nl80211_set_rekey_data(struct sk_buff *skb, struct genl_info *info)
 		return -ERANGE;
 	if (nla_len(tb[NL80211_REKEY_DATA_KCK]) != NL80211_KCK_LEN &&
 	    !(rdev->wiphy.flags & WIPHY_FLAG_SUPPORTS_EXT_KEK_KCK &&
-	      nla_len(tb[NL80211_REKEY_DATA_KCK]) == NL80211_KCK_EXT_LEN))
+	      nla_len(tb[NL80211_REKEY_DATA_KCK]) == NL80211_KCK_EXT_LEN) &&
+	     !(rdev->wiphy.flags & WIPHY_FLAG_SUPPORTS_EXT_KCK_32 &&
+	       nla_len(tb[NL80211_REKEY_DATA_KCK]) == NL80211_KCK_EXT_LEN_32))
 		return -ERANGE;
 
 	rekey_data.kek = nla_data(tb[NL80211_REKEY_DATA_KEK]);
-- 
2.25.1

