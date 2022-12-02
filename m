Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 888CD640D5C
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Dec 2022 19:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234454AbiLBSgK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Dec 2022 13:36:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234270AbiLBSgJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Dec 2022 13:36:09 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE36EC81F
        for <linux-wireless@vger.kernel.org>; Fri,  2 Dec 2022 10:36:08 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B2GsqFw029689;
        Fri, 2 Dec 2022 18:36:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=I6thWytUWxoVEXeh6j1HDPbKmXSNxM2Yhe7vM/QMu1A=;
 b=aYKA+3jllnXinMzCyAcE410/kjFhtTatXzo/a+Nj7HhDlRVaB9aybv/gXTZSk3r/56Vx
 WYMteULVqJ8Ujum17bPX1tm9e0uCiRS9i/rsLsYVrx6s5WPkLCP5vgWqaLMyZo1VvTA+
 a4FuYN/yvVuF87isMyURwools21eT+6xvSCIK4sWUTiQQrrg4eEOagk097yWlaQy+ejG
 OfaoT3V7W23i8GjMeMX+tGcFz4ATcD6IWejMSTkWBeCEjBXpmpcsvLWGDnC7eff4M4/j
 x0JJY3JiRgWg7BMf4G19Vg6V5QFtsdPSEoD+L1wbWHNEfrav64FKbv5Tuj/HEqr5+Dz8 VQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m7f2dsbxy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Dec 2022 18:36:06 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2B2Ia5Cs022466
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 2 Dec 2022 18:36:05 GMT
Received: from msinada-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 2 Dec 2022 10:36:04 -0800
From:   Muna Sinada <quic_msinada@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Aloka Dixit <quic_alokad@quicinc.com>,
        Muna Sinada <quic_msinada@quicinc.com>
Subject: [RFC 2/4] wifi: cfg80211: RU puncturing bitmap
Date:   Fri, 2 Dec 2022 10:35:52 -0800
Message-ID: <1670006154-6092-3-git-send-email-quic_msinada@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1670006154-6092-1-git-send-email-quic_msinada@quicinc.com>
References: <1670006154-6092-1-git-send-email-quic_msinada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8l-x8AdCHT1jcV4nOUeYoI97mzLfxA0a
X-Proofpoint-ORIG-GUID: 8l-x8AdCHT1jcV4nOUeYoI97mzLfxA0a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-02_10,2022-12-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 mlxlogscore=617 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212020147
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Aloka Dixit <quic_alokad@quicinc.com>

RU puncturing bitmap consists of 16 bits, each bit corresponding to
a 20 MHz channel in the operating bandwidth. Lowest bit corresponds to
the lowest frequency. Bit set to 1 indicates that the channel is
punctured otherwise it is active.

Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
Co-developed-by: Muna Sinada <quic_msinada@quicinc.com>
Signed-off-by: Muna Sinada <quic_msinada@quicinc.com>
---
 include/net/cfg80211.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index cb856b06a3ac..b4ca8c2118ff 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -698,6 +698,11 @@ static inline void wiphy_read_of_freq_limits(struct wiphy *wiphy)
  *	belonging to that MU-MIMO groupID; %NULL if not changed
  * @vht_mumimo_follow_addr: MU-MIMO follow address, used for monitoring
  *	MU-MIMO packets going to the specified station; %NULL if not changed
+ * @ru_punct_bitmap: RU puncturing bitmap. Each bit represents a 20 MHz channel
+ *	with lowest bit corresponding to the lowest frequency. Bit set to 1
+ *	indicates that the channel is punctured, otherwise the channel is active
+ * @ru_punct_bitmap_supp_he: Indicates whether RU puncturing bitmap validation
+ *	should include OFDMA bitmaps.
  */
 struct vif_params {
 	u32 flags;
@@ -705,6 +710,8 @@ struct vif_params {
 	u8 macaddr[ETH_ALEN];
 	const u8 *vht_mumimo_groups;
 	const u8 *vht_mumimo_follow_addr;
+	u16 ru_punct_bitmap;
+	bool ru_punct_bitmap_supp_he;
 };
 
 /**
@@ -5732,6 +5739,12 @@ static inline void wiphy_unlock(struct wiphy *wiphy)
  * @links: array of %IEEE80211_MLD_MAX_NUM_LINKS elements containing @addr
  *	@ap and @client for each link
  * @valid_links: bitmap describing what elements of @links are valid
+ * @ru_punct_bitmap: (private) RU puncturing bitmap. Each bit represents a
+ *	20 MHz channel with lowest bit corresponding to the lowest frequency.
+ *	Bit set to 1 indicates that the channel is punctured, otherwise the
+ *	channel is active
+ * @ru_punct_bitmap_supp_he: (private) Indicates whether RU puncturing bitmap
+ *	validation should include OFDMA bitmaps.
  */
 struct wireless_dev {
 	struct wiphy *wiphy;
@@ -5846,6 +5859,9 @@ struct wireless_dev {
 		};
 	} links[IEEE80211_MLD_MAX_NUM_LINKS];
 	u16 valid_links;
+
+	u16 ru_punct_bitmap;
+	bool ru_punct_bitmap_supp_he;
 };
 
 static inline const u8 *wdev_address(struct wireless_dev *wdev)
-- 
2.7.4

