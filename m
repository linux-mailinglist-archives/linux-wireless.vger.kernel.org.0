Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9127467CE33
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jan 2023 15:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbjAZOda (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Jan 2023 09:33:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232273AbjAZOd0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Jan 2023 09:33:26 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977B167786
        for <linux-wireless@vger.kernel.org>; Thu, 26 Jan 2023 06:33:22 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30QCa78g024410;
        Thu, 26 Jan 2023 14:33:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=SoEO3kHNYCio39/VQ7/BSOSHXQAxLrj5/tVlKNM+ZrI=;
 b=GpMgmBm68STKF9Ti+aOEFWE1rZkepvkV4kNnljauJZi/XaNaBwW95gKyLLDVH8DchLZc
 2kartyDdJAz1RgK13M8dmsnZxd25Eyy3RTjJvp/R7Pm6dGeOUZ9ReoRYtTw7mVCFmOnk
 OzVFPnUnZMJLKJkcF4uB+YujyFnp5uTHi66oz2T44Nz7gd6zuYXuzcXg1pHnbkn70yOi
 I2bWiKLrX+E2L7oBjEhYYtJ1lPxqI0RpvkILC48cSh33jTvhZmcK6lsa19jP0oNdWHVW
 NKLMFbDrUzCs0I1K8CYqxNWbiNMYapbxmJjIv6rWnggl08ennwIJhXGxr5jRIaIYcxJz Kg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3najkhc6pj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 14:33:19 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30QEXIvM022556
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 14:33:18 GMT
Received: from cnss-mw-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 26 Jan 2023 06:33:16 -0800
From:   Veerendranath Jakkam <quic_vjakkam@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>, <quic_vjakkam@quicinc.com>
Subject: [PATCH v2 1/2] wifi: cfg80211: Extend cfg80211_new_sta() for MLD AP
Date:   Thu, 26 Jan 2023 20:02:55 +0530
Message-ID: <20230126143256.960563-2-quic_vjakkam@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230126143256.960563-1-quic_vjakkam@quicinc.com>
References: <20230126143256.960563-1-quic_vjakkam@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: su8shik6w0eyC48sIbd9yGB7dUlBzg5e
X-Proofpoint-GUID: su8shik6w0eyC48sIbd9yGB7dUlBzg5e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-26_06,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=999 clxscore=1015
 lowpriorityscore=0 impostorscore=0 mlxscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301260139
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add support for drivers to indicate STA connection(MLO/non-MLO) when
user space SME (e.g., hostapd) is not used for MLD AP.

Add new parameters in struct station_info to provide below information
in cfg80211_new_sta() call:
- MLO link ID of the AP, with which station completed (re)association.
  This is applicable for both MLO and non-MLO station connections when
  the AP affiliated with an MLD.
- Station's MLD address if the connection is MLO capable.
- (Re)Association Response IEs sent to the station. User space needs
  this to determine rejected and accepted affiliated links information
  of the connected station if the connection is MLO capable.

Signed-off-by: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
---
v2:
 - Add more detailed commit text and documentation.
---
 include/net/cfg80211.h | 24 ++++++++++++++++++++++++
 net/wireless/nl80211.c | 16 ++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 54a77d906b2d..5686e64e13d1 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1876,6 +1876,24 @@ struct cfg80211_tid_stats {
  *	received packet with an FCS error matches the peer MAC address.
  * @airtime_link_metric: mesh airtime link metric.
  * @connected_to_as: true if mesh STA has a path to authentication server
+ * @mlo_params_valid: Indicates @assoc_link_id and @mld_addr fields are filled
+ *	by driver. Drivers use this only in cfg80211_new_sta() calls when AP
+ *	MLD's MLME/SME is offload to driver. Drivers won't fill this
+ *	information in cfg80211_del_sta_sinfo(), get_station() and
+ *	dump_station() callbacks.
+ * @assoc_link_id: Indicates MLO link ID of the AP, with which the station
+ *	completed (re)association. This information filled for both MLO
+ *	and non-MLO STA connections when the AP affiliated with an MLD.
+ * @mld_addr: For MLO STA connection, filled with MLD address of the station.
+ *	For non-MLO STA connection, filled with all zeros.
+ * @assoc_resp_ies: IEs from (Re)Association Response.
+ *	This is used only when in AP mode with drivers that do not use user
+ *	space MLME/SME implementation. The information is provided only for the
+ *	cfg80211_new_sta() calls to notify user space of the IEs. Drivers won't
+ *	fill this information in cfg80211_del_sta_sinfo(), get_station() and
+ *	dump_station() callbacks. User space needs this information to determine
+ *	the accepted and rejected affiliated links of the connected station.
+ * @assoc_resp_ies_len: Length of @assoc_resp_ies buffer in octets.
  */
 struct station_info {
 	u64 filled;
@@ -1935,6 +1953,12 @@ struct station_info {
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
index 64cf6110ce9d..d7324f6370ff 100644
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

