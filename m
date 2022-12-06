Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA44D643E02
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Dec 2022 09:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbiLFIC6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Dec 2022 03:02:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbiLFIC4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Dec 2022 03:02:56 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE45B47
        for <linux-wireless@vger.kernel.org>; Tue,  6 Dec 2022 00:02:55 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B64t7Q6001043;
        Tue, 6 Dec 2022 08:02:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=7WDjSof6k0Jdty0K2ABmoqYTNZzxy1+gt5Odqp0asQU=;
 b=miBvVyPwJ983pgwY/Mnoi9QOq0fkp4cZF1f+GmMLv1x0IzB29YC1Py1N6InAj9H2kaQa
 QsNBMxt8RxvHHLFFYimd1uCSDy068jBrAPxBQ+m2otgaaDbE3wKPorFZuJs62ZMgT1g8
 iB9nR+mB1SN7A5HcRoXWY1X1myzvooS0ciR/6l4vlZGq0sIc8osJ4fizovrQ+U2/Nlmk
 tIZ4jF820BmQ8Eiq1Pzh5vM+/ck6pphHbyv3dyp5qkibx1KB8jct2v8JXnJbcJWAlO0c
 WGvQIiM0VbfgEYRkun3DbMLPz4fPqe+iBpQuBN/nylDrJuRqGVPFajrH/E3KmcwUxhtu HQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m7ymt6km9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Dec 2022 08:02:52 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2B682p0g000537
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 6 Dec 2022 08:02:51 GMT
Received: from cnss-mw-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 6 Dec 2022 00:02:48 -0800
From:   Veerendranath Jakkam <quic_vjakkam@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/3] wifi: cfg80211: Extend cfg80211_update_owe_info_event() for MLD AP
Date:   Tue, 6 Dec 2022 13:32:25 +0530
Message-ID: <20221206080226.1702646-3-quic_vjakkam@quicinc.com>
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
X-Proofpoint-ORIG-GUID: CWOFYWMmcBtBVltacxz7QH6bHtDdmGIL
X-Proofpoint-GUID: CWOFYWMmcBtBVltacxz7QH6bHtDdmGIL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-06_05,2022-12-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=652 phishscore=0
 suspectscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212060065
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add support to offload OWE processing to user space for MLD AP. Send
link ID and peer's MLD address to user space when reporting
NL80211_CMD_UPDATE_OWE_INFO event in MLD AP mode.

Signed-off-by: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
---
 drivers/net/wireless/quantenna/qtnfmac/event.c |  1 +
 include/net/cfg80211.h                         |  7 +++++++
 net/wireless/nl80211.c                         | 11 +++++++++++
 net/wireless/trace.h                           | 14 ++++++++++----
 4 files changed, 29 insertions(+), 4 deletions(-)

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
index 15619e0f5f0b..36cecfa217f1 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -3890,12 +3890,19 @@ struct cfg80211_pmsr_request {
  *	the IEs of the remote peer in the event from the host driver and
  *	the constructed IEs by the user space in the request interface.
  * @ie_len: Length of IEs in octets.
+ * @assoc_link_id: Indicates link ID of the AP MLD link on which (re)association
+ *	requested by peer. In non-MLD AP mode, it will be -1. Used only with OWE
+ *	update event (driver to user space).
+ * @peer_mld_addr: MLD address of the peer. For non-MLD peer, it will be all
+ *	zeros. Used only with OWE update event (driver to user space).
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
index 5a20bf8b85d6..77254ed3b054 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -19776,6 +19776,17 @@ void cfg80211_update_owe_info_event(struct net_device *netdev,
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

