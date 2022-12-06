Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A367643E04
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Dec 2022 09:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbiLFIDC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Dec 2022 03:03:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbiLFICy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Dec 2022 03:02:54 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785F4616F
        for <linux-wireless@vger.kernel.org>; Tue,  6 Dec 2022 00:02:52 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B67eo3C008798;
        Tue, 6 Dec 2022 08:02:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=O8eHqCqnTSmaRzEVQxzCPxxOsKkuN8jinLZDrJYVKGc=;
 b=hhqh6k+g6wgIsyQIxtiN4eI4WFxnU4jvediV9QsB+be2UnozZTCeKy2KU8BCV4QUj48j
 qoXD82TmLj1VoIdzn7qg1LMjmQDkJlT3/2qTccuLhK4TF1uORfP6zEbIxtwD6H7D781N
 7ugOGWeF97sCRUQYfv8jJIilBeLJK8AhCfuyQrjqoiFC2n/QvSM3OM9UMsgJXcV4SCqy
 siJah3YxA0N5b60wxmziRd0E+GASADBdxn4l+JIq/8KTpkYlBKIcllGbTlsgvy3f0vt/
 hKHw/Z+H/gBkIg6urQhpGNEr0kh5GyU08WUF16W1VOMSyK1HuARYpfz2cvYKFxNjChiN BQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m9trk0way-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Dec 2022 08:02:48 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2B682mjZ011987
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 6 Dec 2022 08:02:48 GMT
Received: from cnss-mw-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 6 Dec 2022 00:02:46 -0800
From:   Veerendranath Jakkam <quic_vjakkam@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/3] wifi: cfg80211: Extend cfg80211_new_sta() for MLD AP
Date:   Tue, 6 Dec 2022 13:32:24 +0530
Message-ID: <20221206080226.1702646-2-quic_vjakkam@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221206080226.1702646-1-quic_vjakkam@quicinc.com>
References: <20221206080226.1702646-1-quic_vjakkam@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: K5OU6r2NLvKHYJiOQ9WVG6vUxu9rBsAL
X-Proofpoint-ORIG-GUID: K5OU6r2NLvKHYJiOQ9WVG6vUxu9rBsAL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-06_05,2022-12-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 suspectscore=0 bulkscore=0 clxscore=1015 phishscore=0
 malwarescore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212060065
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add support for drivers to indicate STA connection when user space SME
(e.g., hostapd) is not used for MLD AP. Add new parameters in struct
station_info to provide (re)association link ID, station's MLD address
and (Re)Association Response IEs in cfg80211_new_sta().

Signed-off-by: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
---
 include/net/cfg80211.h | 22 ++++++++++++++++++++++
 net/wireless/nl80211.c | 16 ++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 03d4f4deadae..15619e0f5f0b 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1882,6 +1882,22 @@ struct cfg80211_tid_stats {
  *	received packet with an FCS error matches the peer MAC address.
  * @airtime_link_metric: mesh airtime link metric.
  * @connected_to_as: true if mesh STA has a path to authentication server
+ * @mlo_params_valid: Indicates @assoc_link_id and @mld_addr fields are valid.
+ *	Drivers use this only in cfg80211_new_sta() calls when AP MLD's MLME/SME
+ *	is offload to driver. Drivers won't fill this information in
+ *	cfg80211_del_sta_sinfo(), get_station() and dump_station() callbacks.
+ * @assoc_link_id: Indicates link ID of the AP MLD link on which the station
+ *	association happened.
+ * @mld_addr: MLD address if the station is an MLD. Otherwise, set to all zeros.
+ * @assoc_resp_ies: IEs from (Re)Association Response.
+ *	This is used only when in AP mode with drivers that do not use user
+ *	space MLME/SME implementation. The information is provided only for the
+ *	cfg80211_new_sta() calls to notify user space of the IEs. Drivers won't
+ *	fill this information in cfg80211_del_sta_sinfo(), get_station() and
+ *	dump_station() callbacks. Userspace needs this information to determine
+ *	the other affiliated link stations information when MLD station is
+ *	connected.
+ * @assoc_resp_ies_len: Length of @assoc_resp_ies buffer in octets.
  */
 struct station_info {
 	u64 filled;
@@ -1941,6 +1957,12 @@ struct station_info {
 	u32 airtime_link_metric;
 
 	u8 connected_to_as;
+
+	bool mlo_params_valid;
+	u8 assoc_link_id;
+	u8 mld_addr[ETH_ALEN] __aligned(2);
+	const u8 *assoc_resp_ies;
+	size_t assoc_resp_ies_len;
 };
 
 /**
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 33a82ecab9d5..5a20bf8b85d6 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -6527,6 +6527,22 @@ static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
 		    sinfo->assoc_req_ies))
 		goto nla_put_failure;
 
+	if (sinfo->assoc_resp_ies_len &&
+	    nla_put(msg, NL80211_ATTR_RESP_IE, sinfo->assoc_resp_ies_len,
+		    sinfo->assoc_resp_ies))
+		goto nla_put_failure;
+
+	if (sinfo->mlo_params_valid) {
+		if (nla_put_u8(msg, NL80211_ATTR_MLO_LINK_ID,
+			       sinfo->assoc_link_id))
+			goto nla_put_failure;
+
+		if (!is_zero_ether_addr(sinfo->mld_addr) &&
+		    nla_put(msg, NL80211_ATTR_MLD_ADDR, ETH_ALEN,
+			    sinfo->mld_addr))
+			goto nla_put_failure;
+	}
+
 	cfg80211_sinfo_release_content(sinfo);
 	genlmsg_end(msg, hdr);
 	return 0;
-- 
2.25.1

