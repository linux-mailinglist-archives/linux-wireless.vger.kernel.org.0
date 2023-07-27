Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAEB6765A9F
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jul 2023 19:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjG0Rl2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Jul 2023 13:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjG0Rl1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Jul 2023 13:41:27 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF77F30E2
        for <linux-wireless@vger.kernel.org>; Thu, 27 Jul 2023 10:41:21 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36RF8MQB028995;
        Thu, 27 Jul 2023 17:41:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=ycgTtGgmXD98AwRR6x5QLGExZpLWT5FH3yz+77axk+w=;
 b=PoBAqxN5iMrCKc6aiuYRnyD6KBlFdSNZe4BY8DOLW+fJyIl2D+dvE8ITQBDoPEaPSK5Y
 RqgzwMqTCH77vwUidbFaRrgz8O4jVTDqAj+gy8+KPPb8H0Hyuu4QRJsHT0XSj93u0EWg
 uCMwBGhZT6o5ciN3HWxqku+Nu0j5/5daQQgwsM4r4tEcIrERUfm83H+kee59288QddId
 EV4r6xKfuMrn5//IrOqOEZ5odlOgf/t7RjlywttCQJlFlDCj3Ap8JoKVPQCg8TAELZzI
 NWOThH2ENpXGOYWftItHC/F59WA/+KOo0VeTaU5vaPC83ms5wGfmllTQwyQOf8sopJ1P 4A== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s3f5821vx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 17:41:17 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36RHfFSs018381
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 17:41:15 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 27 Jul 2023 10:41:14 -0700
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
CC:     Aloka Dixit <quic_alokad@quicinc.com>
Subject: [PATCH v8 1/5] wifi: nl80211: fixes to FILS discovery updates
Date:   Thu, 27 Jul 2023 10:40:56 -0700
Message-ID: <20230727174100.11721-2-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230727174100.11721-1-quic_alokad@quicinc.com>
References: <20230727174100.11721-1-quic_alokad@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5I7dlBVvA5al0gbb9iPPMTr5lzOxobBB
X-Proofpoint-ORIG-GUID: 5I7dlBVvA5al0gbb9iPPMTr5lzOxobBB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_07,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 suspectscore=0 phishscore=0 clxscore=1015 adultscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307270160
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add a new flag 'update' which is set to true during start_ap() for
only if one of the following two conditions are met:
- Userspace passed an empty nested attribute which indicates that
the feature should be disabled and templates deleted.
- Userspace passed all the parameters for the nested attribute.

Existing configuration will not be changed while the flag
remains false.

Add similar changes for unsolicited broadcast probe response
transmission.

Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
---
v8: New patch in this series.

 include/net/cfg80211.h       |  4 ++++
 include/uapi/linux/nl80211.h | 11 +++++++----
 net/wireless/nl80211.c       | 16 +++++++++++++++-
 3 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 7c7d03aa9d06..5317f67da67f 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1286,6 +1286,7 @@ struct cfg80211_acl_data {
  * struct cfg80211_fils_discovery - FILS discovery parameters from
  * IEEE Std 802.11ai-2016, Annex C.3 MIB detail.
  *
+ * @update: Set to true if the feature configuration should be updated.
  * @min_interval: Minimum packet interval in TUs (0 - 10000)
  * @max_interval: Maximum packet interval in TUs (0 - 10000)
  * @tmpl_len: Template length
@@ -1293,6 +1294,7 @@ struct cfg80211_acl_data {
  *	frame headers.
  */
 struct cfg80211_fils_discovery {
+	bool update;
 	u32 min_interval;
 	u32 max_interval;
 	size_t tmpl_len;
@@ -1303,6 +1305,7 @@ struct cfg80211_fils_discovery {
  * struct cfg80211_unsol_bcast_probe_resp - Unsolicited broadcast probe
  *	response parameters in 6GHz.
  *
+ * @update: Set to true if the feature configuration should be updated.
  * @interval: Packet interval in TUs. Maximum allowed is 20 TU, as mentioned
  *	in IEEE P802.11ax/D6.0 26.17.2.3.2 - AP behavior for fast passive
  *	scanning
@@ -1310,6 +1313,7 @@ struct cfg80211_fils_discovery {
  * @tmpl: Template data for probe response
  */
 struct cfg80211_unsol_bcast_probe_resp {
+	bool update;
 	u32 interval;
 	size_t tmpl_len;
 	const u8 *tmpl;
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 88eb85c63029..97909e5fa959 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2690,11 +2690,13 @@ enum nl80211_commands {
  *
  * @NL80211_ATTR_FILS_DISCOVERY: Optional parameter to configure FILS
  *	discovery. It is a nested attribute, see
- *	&enum nl80211_fils_discovery_attributes.
+ *	&enum nl80211_fils_discovery_attributes. Userspace should pass an empty
+ *	nested attribute to disable this feature and delete the templates.
  *
  * @NL80211_ATTR_UNSOL_BCAST_PROBE_RESP: Optional parameter to configure
  *	unsolicited broadcast probe response. It is a nested attribute, see
- *	&enum nl80211_unsol_bcast_probe_resp_attributes.
+ *	&enum nl80211_unsol_bcast_probe_resp_attributes. Userspace should pass an empty
+ *	nested attribute to disable this feature and delete the templates.
  *
  * @NL80211_ATTR_S1G_CAPABILITY: S1G Capability information element (from
  *	association request when used with NL80211_CMD_NEW_STATION)
@@ -7606,7 +7608,7 @@ enum nl80211_iftype_akm_attributes {
  * @NL80211_FILS_DISCOVERY_ATTR_INT_MIN: Minimum packet interval (u32, TU).
  *	Allowed range: 0..10000 (TU = Time Unit)
  * @NL80211_FILS_DISCOVERY_ATTR_INT_MAX: Maximum packet interval (u32, TU).
- *	Allowed range: 0..10000 (TU = Time Unit)
+ *	Allowed range: 0..10000 (TU = Time Unit). If set to 0, the feature is disabled.
  * @NL80211_FILS_DISCOVERY_ATTR_TMPL: Template data for FILS discovery action
  *	frame including the headers.
  *
@@ -7639,7 +7641,8 @@ enum nl80211_fils_discovery_attributes {
  *
  * @NL80211_UNSOL_BCAST_PROBE_RESP_ATTR_INT: Maximum packet interval (u32, TU).
  *	Allowed range: 0..20 (TU = Time Unit). IEEE P802.11ax/D6.0
- *	26.17.2.3.2 (AP behavior for fast passive scanning).
+ *	26.17.2.3.2 (AP behavior for fast passive scanning). If set to 0, the feature is
+ *	disabled.
  * @NL80211_UNSOL_BCAST_PROBE_RESP_ATTR_TMPL: Unsolicited broadcast probe response
  *	frame template (binary).
  *
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 0da2e6a2a7ea..487a34cbc6fb 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -5683,6 +5683,13 @@ static int nl80211_parse_fils_discovery(struct cfg80211_registered_device *rdev,
 	if (ret)
 		return ret;
 
+	if (!tb[NL80211_FILS_DISCOVERY_ATTR_INT_MIN] &&
+	    !tb[NL80211_FILS_DISCOVERY_ATTR_INT_MAX] &&
+	    !tb[NL80211_FILS_DISCOVERY_ATTR_TMPL]) {
+		fd->update = true;
+		return 0;
+	}
+
 	if (!tb[NL80211_FILS_DISCOVERY_ATTR_INT_MIN] ||
 	    !tb[NL80211_FILS_DISCOVERY_ATTR_INT_MAX] ||
 	    !tb[NL80211_FILS_DISCOVERY_ATTR_TMPL])
@@ -5692,7 +5699,7 @@ static int nl80211_parse_fils_discovery(struct cfg80211_registered_device *rdev,
 	fd->tmpl = nla_data(tb[NL80211_FILS_DISCOVERY_ATTR_TMPL]);
 	fd->min_interval = nla_get_u32(tb[NL80211_FILS_DISCOVERY_ATTR_INT_MIN]);
 	fd->max_interval = nla_get_u32(tb[NL80211_FILS_DISCOVERY_ATTR_INT_MAX]);
-
+	fd->update = true;
 	return 0;
 }
 
@@ -5715,6 +5722,12 @@ nl80211_parse_unsol_bcast_probe_resp(struct cfg80211_registered_device *rdev,
 	if (ret)
 		return ret;
 
+	if (!tb[NL80211_UNSOL_BCAST_PROBE_RESP_ATTR_INT] &&
+	    !tb[NL80211_UNSOL_BCAST_PROBE_RESP_ATTR_TMPL]) {
+		presp->update = true;
+		return 0;
+	}
+
 	if (!tb[NL80211_UNSOL_BCAST_PROBE_RESP_ATTR_INT] ||
 	    !tb[NL80211_UNSOL_BCAST_PROBE_RESP_ATTR_TMPL])
 		return -EINVAL;
@@ -5722,6 +5735,7 @@ nl80211_parse_unsol_bcast_probe_resp(struct cfg80211_registered_device *rdev,
 	presp->tmpl = nla_data(tb[NL80211_UNSOL_BCAST_PROBE_RESP_ATTR_TMPL]);
 	presp->tmpl_len = nla_len(tb[NL80211_UNSOL_BCAST_PROBE_RESP_ATTR_TMPL]);
 	presp->interval = nla_get_u32(tb[NL80211_UNSOL_BCAST_PROBE_RESP_ATTR_INT]);
+	presp->update = true;
 	return 0;
 }
 
-- 
2.39.0

