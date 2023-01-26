Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC29767CE34
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jan 2023 15:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbjAZOdb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Jan 2023 09:33:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjAZOd1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Jan 2023 09:33:27 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADFB37561
        for <linux-wireless@vger.kernel.org>; Thu, 26 Jan 2023 06:33:24 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30QCwa9J023343;
        Thu, 26 Jan 2023 14:33:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=GHP6EDL4NuYIiPeYRReKSmien42JnQYcvzgKsxvAc3g=;
 b=ecNRKKImkkfwe6pIdTjKenvbkcOj6JXPfxyrL99nxa2gQHIJeCmLlp8jKRGtWkm3BdVD
 u2BXXl1sjbZrg6SNgq0qSSeaI9JRY7sSFINOkjQNQDoXzDuudjjTlL1HC4kjZWs/vqHv
 7r4MdDIyG5akbh8Rm7JlSo23AQhiOmuMkm1lZ0UAfgCWFh7mf8Rj8kOYc6MDoSQTcx06
 ZPXALzmLsY+kTFwKugd6SnryPEgNzuTSKguSOndPrfqIyOxx/zX8/0EelPa5Uyrj0QhK
 rs/90sUnKnOrIV4KgmvneSBac4JialWdEtIM1GiR2I51hdCZvQLco0viX0+4ia334zLk dw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3napvhkjam-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 14:33:21 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30QEXKLH022561
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 14:33:20 GMT
Received: from cnss-mw-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 26 Jan 2023 06:33:18 -0800
From:   Veerendranath Jakkam <quic_vjakkam@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>, <quic_vjakkam@quicinc.com>
Subject: [PATCH v2 2/2] wifi: cfg80211: Extend cfg80211_update_owe_info_event() for MLD AP
Date:   Thu, 26 Jan 2023 20:02:56 +0530
Message-ID: <20230126143256.960563-3-quic_vjakkam@quicinc.com>
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
X-Proofpoint-GUID: r4XFCHqzBVg1hfE13w3pkiUXIN72YK6e
X-Proofpoint-ORIG-GUID: r4XFCHqzBVg1hfE13w3pkiUXIN72YK6e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-26_06,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 malwarescore=0 mlxlogscore=691 phishscore=0
 adultscore=0 impostorscore=0 mlxscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301260139
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add support to offload OWE processing to user space for MLD AP when
driver's SME in use.

Add new parameters in struct cfg80211_update_owe_info to provide below
information in cfg80211_update_owe_info_event() call:
- MLO link ID of the AP, with which station requested (re)association.
  This is applicable for both MLO and non-MLO station connections when
  the AP affiliated with an MLD.
- Station's MLD address if the connection is MLO capable.

Signed-off-by: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
---
v2:
 - Add more detailed commit text and documentation.
---
 drivers/net/wireless/quantenna/qtnfmac/event.c |  1 +
 include/net/cfg80211.h                         | 10 ++++++++++
 net/wireless/nl80211.c                         | 11 +++++++++++
 net/wireless/trace.h                           | 14 ++++++++++----
 4 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/quantenna/qtnfmac/event.c b/drivers/net/wireless/quantenna/qtnfmac/event.c
index 4fafe370101a..f0158737aed6 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/event.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/event.c
@@ -662,6 +662,7 @@ qtnf_event_handle_update_owe(struct qtnf_vif *vif,
 	memcpy(ie, owe_ev->ies, ie_len);
 	owe_info.ie_len = ie_len;
 	owe_info.ie = ie;
+	owe_info.assoc_link_id = -1;
 
 	pr_info("%s: external OWE processing: peer=%pM\n",
 		vif->netdev->name, owe_ev->peer);
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 5686e64e13d1..57da0626f7e0 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -3886,12 +3886,22 @@ struct cfg80211_pmsr_request {
  *	the IEs of the remote peer in the event from the host driver and
  *	the constructed IEs by the user space in the request interface.
  * @ie_len: Length of IEs in octets.
+ * @assoc_link_id: MLO link ID of the AP, with which (re)association requested
+ *	by peer. This will be filled by driver for both MLO and non-MLO station
+ *	connections when the AP affiliated with an MLD. For non-MLD AP mode, it
+ *	will be -1. Used only with OWE update event (driver to user space).
+ * @peer_mld_addr: For MLO connection, MLD address of the peer. For non-MLO
+ *	connection, it will be all zeros. This is applicable only when
+ *	@assoc_link_id is not -1, i.e., the AP affiliated with an MLD. Used only
+ *	with OWE update event (driver to user space).
  */
 struct cfg80211_update_owe_info {
 	u8 peer[ETH_ALEN] __aligned(2);
 	u16 status;
 	const u8 *ie;
 	size_t ie_len;
+	int assoc_link_id;
+	u8 peer_mld_addr[ETH_ALEN] __aligned(2);
 };
 
 /**
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index d7324f6370ff..62eea4d9c803 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -19778,6 +19778,17 @@ void cfg80211_update_owe_info_event(struct net_device *netdev,
 	    nla_put(msg, NL80211_ATTR_IE, owe_info->ie_len, owe_info->ie))
 		goto nla_put_failure;
 
+	if (owe_info->assoc_link_id != -1) {
+		if (nla_put_u8(msg, NL80211_ATTR_MLO_LINK_ID,
+			       owe_info->assoc_link_id))
+			goto nla_put_failure;
+
+		if (!is_zero_ether_addr(owe_info->peer_mld_addr) &&
+		    nla_put(msg, NL80211_ATTR_MLD_ADDR, ETH_ALEN,
+			    owe_info->peer_mld_addr))
+			goto nla_put_failure;
+	}
+
 	genlmsg_end(msg, hdr);
 
 	genlmsg_multicast_netns(&nl80211_fam, wiphy_net(&rdev->wiphy), msg, 0,
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index a405c3edbc47..68b933d28070 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -3755,14 +3755,20 @@ TRACE_EVENT(cfg80211_update_owe_info_event,
 	    TP_STRUCT__entry(WIPHY_ENTRY
 			     NETDEV_ENTRY
 			     MAC_ENTRY(peer)
-			     __dynamic_array(u8, ie, owe_info->ie_len)),
+			     __dynamic_array(u8, ie, owe_info->ie_len)
+			     __field(int, assoc_link_id)
+			     MAC_ENTRY(peer_mld_addr)),
 	    TP_fast_assign(WIPHY_ASSIGN;
 			   NETDEV_ASSIGN;
 			   MAC_ASSIGN(peer, owe_info->peer);
 			   memcpy(__get_dynamic_array(ie), owe_info->ie,
-				  owe_info->ie_len);),
-	    TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", peer: " MAC_PR_FMT,
-		      WIPHY_PR_ARG, NETDEV_PR_ARG, MAC_PR_ARG(peer))
+				  owe_info->ie_len);
+			   __entry->assoc_link_id = owe_info->assoc_link_id;
+			   MAC_ASSIGN(peer_mld_addr, owe_info->peer_mld_addr);),
+	    TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", peer: " MAC_PR_FMT
+		      ", assoc_link_id: %d, peer_mld_addr: " MAC_PR_FMT,
+		      WIPHY_PR_ARG, NETDEV_PR_ARG, MAC_PR_ARG(peer),
+		      __entry->assoc_link_id, MAC_PR_ARG(peer_mld_addr))
 );
 
 TRACE_EVENT(cfg80211_bss_color_notify,
-- 
2.25.1

