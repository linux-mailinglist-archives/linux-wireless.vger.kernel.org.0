Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B10643E01
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Dec 2022 09:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbiLFICz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Dec 2022 03:02:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbiLFICw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Dec 2022 03:02:52 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63C32FF
        for <linux-wireless@vger.kernel.org>; Tue,  6 Dec 2022 00:02:50 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B67EnLl020825;
        Tue, 6 Dec 2022 08:02:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=FJZTd7KoSSAbnfCcJnV2j/PtmnU+lwCNrn6g+8pYtR4=;
 b=O866bi6Uk37KkJbF/DO5smLcObYzgmNN5zZYu3jtiLZbkUZuKgCYdZFpUTyf9NF7mvJd
 tTUW9RUVBg57XZCov0ifsudKF0BS7Wi7QKnvLqAVQX30yhzaroqletWWCT1DDd9eML3F
 8/faLiLfTwAdk4WNbl5anki5Ps7/6HF0YsR/NfCaocIE3DYdjZyZp+eE2Zkww26sKwrk
 3Eqke0MvhqQ057JFjaUGG1hi8E8GgeTILk1BXxP4bGOkP2+ztwJnR0skJleRl8yq5f+e
 0dBwdN0Z5Bevm3eO7+B4XNxGaH0YUBfsiiWHFuXGf+B22c3Yt3iIfqXbhNjhIgbWvrNo oQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ma1660600-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Dec 2022 08:02:47 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2B682kBA011971
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 6 Dec 2022 08:02:46 GMT
Received: from cnss-mw-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 6 Dec 2022 00:02:44 -0800
From:   Veerendranath Jakkam <quic_vjakkam@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/3] wifi: changes for MLD AP when SME offload to driver
Date:   Tue, 6 Dec 2022 13:32:23 +0530
Message-ID: <20221206080226.1702646-1-quic_vjakkam@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: yfNp8jgBQZhh_rxFOq2EG940Z7A-S9K1
X-Proofpoint-GUID: yfNp8jgBQZhh_rxFOq2EG940Z7A-S9K1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-06_05,2022-12-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1011 mlxscore=0
 suspectscore=0 priorityscore=1501 adultscore=0 spamscore=0 mlxlogscore=571
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212060065
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This series contains changes needed for MLD AP when driver's SME in use.

Veerendranath Jakkam (3):
  wifi: cfg80211: Extend cfg80211_new_sta() for MLD AP
  wifi: cfg80211: Extend cfg80211_update_owe_info_event() for MLD AP
  wifi: cfg80211: Use MLD address to indicate MLD STA disconnection

 .../net/wireless/quantenna/qtnfmac/event.c    |  1 +
 include/net/cfg80211.h                        | 33 +++++++++++++++++--
 include/uapi/linux/nl80211.h                  |  3 +-
 net/wireless/nl80211.c                        | 27 +++++++++++++++
 net/wireless/trace.h                          | 14 +++++---
 5 files changed, 71 insertions(+), 7 deletions(-)

-- 
2.25.1

