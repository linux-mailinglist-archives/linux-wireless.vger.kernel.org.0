Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E13C78237C
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Aug 2023 08:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233342AbjHUGOz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Aug 2023 02:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbjHUGOz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Aug 2023 02:14:55 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427ECA2
        for <linux-wireless@vger.kernel.org>; Sun, 20 Aug 2023 23:14:53 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37L69Tos023141;
        Mon, 21 Aug 2023 06:14:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=wS2gz4qWNMO1J13T8lzU2svIo7IAYpG2tQumZUhsKP8=;
 b=glSw36buA3nVFDyDhiN+lSgaXxZP6rW8UoAb9bKerAReJiFZ7kF8wq1KGKd5HIggAPL4
 Vf1p6th39RE3knAQvr+pPzcPcFbKjiF2U86POsi0N25owhNsMy3muRWmEBgwSr+l+2fl
 BldNzeRgzlbPz/dOzkIFO6BXqzUZQl4oZvRn66BkDD9EzTmoS81MWjOxE9CRmC9d1268
 umOru8x7tQLg+Q0YC0Nd0H8AgiPZZyHwN9+giIBmR5OG96+cn/irgvEheiph52a6Tv66
 dvynxZKbqHpd/bnw8r/efQuB/+hjOxlYhwjXcrV6ga60qZOZI2bEklywidx/H2Lk2n++ /g== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sjnu12rfp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Aug 2023 06:14:46 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37L6EjbA027897
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Aug 2023 06:14:45 GMT
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Sun, 20 Aug 2023 23:14:43 -0700
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <johannes@sipsolutions.net>, <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH] wifi: mac80211: fix cfg80211_bss always hold when assoc response fail for MLO connection
Date:   Mon, 21 Aug 2023 02:13:55 -0400
Message-ID: <20230821061355.18168-1-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: -hsVrYKt2akLK0hAkZFKy7k0D-37pUEd
X-Proofpoint-GUID: -hsVrYKt2akLK0hAkZFKy7k0D-37pUEd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-20_15,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 impostorscore=0 clxscore=1015 mlxlogscore=999 suspectscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2308210056
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 net/mac80211/mlme.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index f93eb38ae0b8..370b2cd0cc6d 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -5429,17 +5429,22 @@ static void ieee80211_rx_mgmt_assoc_resp(struct ieee80211_sub_if_data *sdata,
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
 		resp.links[link_id].status = assoc_data->link[link_id].status;
 
+		link = sdata_dereference(sdata->link[link_id], sdata);
+
+		if (!link) {
+			/* use the addr of assoc_data link which is set in ieee80211_mgd_assoc() */
+			resp.links[link_id].addr = assoc_data->link[link_id].addr;
+			continue;
+		}
+
+		resp.links[link_id].addr = link->conf->addr;
+
 		/* get uapsd queues configuration - same for all links */
 		resp.uapsd_queues = 0;
 		for (ac = 0; ac < IEEE80211_NUM_ACS; ac++)

base-commit: 3f257461ab0ab19806bae2bfde4c3cd88dbf050e
-- 
2.40.1

