Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A659F783D88
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Aug 2023 12:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234582AbjHVKEu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Aug 2023 06:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234579AbjHVKEt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Aug 2023 06:04:49 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A181BD
        for <linux-wireless@vger.kernel.org>; Tue, 22 Aug 2023 03:04:47 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37M9xVCJ005972;
        Tue, 22 Aug 2023 10:04:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=EkWtkbiFyDbPnAvu1h1QmufrWSYgk5wcqAvQ4tiJSCo=;
 b=lOS/38erqngJvauk/AUCykIt+Ipt3l1qJ5qas/DZ1+dBvGjbLvIWTmizJEY5Azo+YVBK
 Uy6PchcrJBRkUyKatuJlrZbkAXdmvE9xBOIo5LhNKOu7YP/B2K78xtpi2j76HEeF6gwy
 NSOO6FHgsARDxHY/d8uHAcwSckczjIe63Ga8DAo14Dv+GNQ/m1UAcAN+MJ/Lji3wVC5C
 WySWYKRGvomljuAtqmtVWs84qPPatqX3hmEgigst3hFjvnxUoPg+t4HUIggL5QIoxdbF
 ylLgz8AvCjl38Y3GiDUZbtvmb9gNpGWdacWBp6EnPjAB+d63ALyekUK/r8L2aO7N8tv1 FA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3smreu0awx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Aug 2023 10:04:39 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37MA4Vgs001305
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Aug 2023 10:04:31 GMT
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Tue, 22 Aug 2023 03:04:29 -0700
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <johannes@sipsolutions.net>, <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH v2] wifi: mac80211: fix cfg80211_bss always hold when assoc response fail for MLO connection
Date:   Tue, 22 Aug 2023 06:04:09 -0400
Message-ID: <20230822100409.1242-1-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jYZWzv-elIV-tyZx-1hDlnrzuJOGN1ZK
X-Proofpoint-ORIG-GUID: jYZWzv-elIV-tyZx-1hDlnrzuJOGN1ZK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-22_10,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=999
 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308220076
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When connect to MLO AP with more than one link, and the assoc response of
AP is not success, then cfg80211_unhold_bss() is not called for all the
links' cfg80211_bss except the primary link which means the link used by
the latest successful association request. Thus the hold value of the
cfg80211_bss is not reset to 0 after the assoc fail, and then the
__cfg80211_unlink_bss() will not be called for the cfg80211_bss by
__cfg80211_bss_expire().

Then the AP always looks exist even the AP is shutdown or reconfigured
to another type, then it will lead error while connecting it again.

The detail info are as below.

When connect with muti-links AP, cfg80211_hold_bss() is called by
cfg80211_mlme_assoc() for each cfg80211_bss of all the links. When
assoc response from AP is not success(such as status_code==1), the
ieee80211_link_data of non-primary link(sdata->link[link_id]) is NULL
because ieee80211_assoc_success()->ieee80211_vif_update_links() is
not called for the links.

Then struct cfg80211_rx_assoc_resp resp in cfg80211_rx_assoc_resp() and
struct cfg80211_connect_resp_params cr in __cfg80211_connect_result()
will only have the data of the primary link, and finally function
cfg80211_connect_result_release_bsses() only call cfg80211_unhold_bss()
for the primary link. Then cfg80211_bss of the other links will never free
because its hold is always > 0 now.

Hence assign value for the bss and status from assoc_data since it is
valid for this case. Also assign value of addr from assoc_data when the
link is NULL because the addrs of assoc_data and link both represent the
local link addr and they are same value for success connection.

It is 100% ratio to reproduce the issue with this change.
Add "mgmt->u.assoc_resp.status_code = 1" in ieee80211_rx_mgmt_assoc_resp().

Fixes: 81151ce462e5 ("wifi: mac80211: support MLO authentication/association with one link")
Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
v2: change logic per johannes

 include/net/cfg80211.h |  2 +-
 net/mac80211/mlme.c    | 12 +++++++-----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 7c7d03aa9d06..5a53cc0edb30 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -7229,7 +7229,7 @@ struct cfg80211_rx_assoc_resp {
 	int uapsd_queues;
 	const u8 *ap_mld_addr;
 	struct {
-		const u8 *addr;
+		u8 addr[ETH_ALEN] __aligned(2);
 		struct cfg80211_bss *bss;
 		u16 status;
 	} links[IEEE80211_MLD_MAX_NUM_LINKS];
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index f93eb38ae0b8..f36359269377 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -5429,17 +5429,19 @@ static void ieee80211_rx_mgmt_assoc_resp(struct ieee80211_sub_if_data *sdata,
 	for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS; link_id++) {
 		struct ieee80211_link_data *link;
 
-		link = sdata_dereference(sdata->link[link_id], sdata);
-		if (!link)
-			continue;
-
 		if (!assoc_data->link[link_id].bss)
 			continue;
 
 		resp.links[link_id].bss = assoc_data->link[link_id].bss;
-		resp.links[link_id].addr = link->conf->addr;
+		/* use the addr of assoc_data link which is set in ieee80211_mgd_assoc() */
+		ether_addr_copy(resp.links[link_id].addr,
+				assoc_data->link[link_id].addr);
 		resp.links[link_id].status = assoc_data->link[link_id].status;
 
+		link = sdata_dereference(sdata->link[link_id], sdata);
+		if (!link)
+			continue;
+
 		/* get uapsd queues configuration - same for all links */
 		resp.uapsd_queues = 0;
 		for (ac = 0; ac < IEEE80211_NUM_ACS; ac++)

base-commit: 3f257461ab0ab19806bae2bfde4c3cd88dbf050e
-- 
2.40.1

