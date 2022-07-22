Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF2257E242
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Jul 2022 15:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234722AbiGVNVP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Jul 2022 09:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231807AbiGVNVO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Jul 2022 09:21:14 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0ED27E026
        for <linux-wireless@vger.kernel.org>; Fri, 22 Jul 2022 06:21:11 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26MDG8aY005814;
        Fri, 22 Jul 2022 13:21:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=PsjBVppf4u8wtiLHj1yIapplrUKshHm9mRTsX6+S70U=;
 b=Mg0AkB2vZLfuORvo/iNl0J3xNNySN5ZlxvPcE1d36/vhCGwEXpf9ABCx4hw0faDjx+wP
 BslxmHQNM7e8PJHIkmDFIl5xUGnOeMj2vCIxj6ap3myxn0WFmwFCH74V/qASG/OeWP1g
 7mraAcxwkp6p58zkElL8ehQQ4UeWZy1dB6e9t4mSgkdy8gccxnBR68lGDTLmwgotmEf5
 C9IcMQSFH5xKLQMAibH01/isGGEflVj5vRrDYHPS8dtLDJIXX9W3miP/m7WWwc8NQC2t
 qzNZ1yme3Pdb7JawxB80MZF/9j79wfgTKwdyD671z4TzQ2Lt7NGPZoAGf6qhBlhg9xy3 kw== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hf716kcj7-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Jul 2022 13:21:08 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.47.97.222])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 26MDB5fp012864
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Jul 2022 13:11:05 GMT
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 22 Jul 2022 06:11:05 -0700
Received: from cnss-mw-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 22 Jul 2022 06:11:03 -0700
From:   Veerendranath Jakkam <quic_vjakkam@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/3] nl80211: send MLO links channel info in NL80211_CMD_GET_INTERFACE
Date:   Fri, 22 Jul 2022 18:40:00 +0530
Message-ID: <20220722131000.3437894-1-quic_vjakkam@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ggKU82KkYm9iCT3L6HgTrLeGowmsejml
X-Proofpoint-GUID: ggKU82KkYm9iCT3L6HgTrLeGowmsejml
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-22_04,2022-07-21_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 mlxlogscore=999 bulkscore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207220056
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently, MLO link level channel information not sent to userspace when
NL80211_CMD_GET_INTERFACE requested on MLD.

Add support to send channel information for all valid links for
NL80211_CMD_GET_INTERFACE request.

Signed-off-by: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
---
 net/wireless/nl80211.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index b6e640437568..3580fe2f2f31 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -3848,12 +3848,19 @@ static int nl80211_send_iface(struct sk_buff *msg, u32 portid, u32 seq, int flag
 
 		for_each_valid_link(wdev, link_id) {
 			struct nlattr *link = nla_nest_start(msg, link_id + 1);
+			struct cfg80211_chan_def chandef = {};
+			int ret;
 
 			if (nla_put_u8(msg, NL80211_ATTR_MLO_LINK_ID, link_id))
 				goto nla_put_failure;
 			if (nla_put(msg, NL80211_ATTR_MAC, ETH_ALEN,
 				    wdev->links[link_id].addr))
 				goto nla_put_failure;
+
+			ret = rdev_get_channel(rdev, wdev, link_id, &chandef);
+			if (ret == 0 && nl80211_send_chandef(msg, &chandef))
+				goto nla_put_failure;
+
 			nla_nest_end(msg, link);
 		}
 
-- 
2.25.1

