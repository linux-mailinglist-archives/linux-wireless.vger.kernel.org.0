Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE637939FC
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Sep 2023 12:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239173AbjIFKf0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 Sep 2023 06:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjIFKfZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 Sep 2023 06:35:25 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC43CE2
        for <linux-wireless@vger.kernel.org>; Wed,  6 Sep 2023 03:35:21 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3867J85I006022;
        Wed, 6 Sep 2023 10:35:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=6x6AGspnHuDuxZLjKxPbmmN6vd+DuLBpY9FOhXhZ28s=;
 b=aZU6rK1v8IbJHsh2Lfn7CT++sLyNLuoUrEt9Zkll+JX7xwfhquH/KpfD6RNCHNvtINge
 2W+3GeWtfjkKgpMK3UA9iuwNXXgb5dKv3iYQ0x40vD13kL2EB4i3JKTOttV1gM/pEzGB
 1qGmYSc0E2Wq74b8NCHU3jaGKI4dp/O66TpaUjTRuAt7ScL9fsqtSYBwuLHNWJj7LbyC
 r/0w1MABejSdGAIT6QLJAOzqNf/aACb0OiP3tWguMbjBmBJHCVvcJ+IdrRq0sS8kemJD
 RaBbi2quDBNv65d1VuoCDcyn2oGQlf8C8f2ekYIVuzUVCqFk/PnzaWYqr9uTUPB6GwWe zQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sxfrkh609-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Sep 2023 10:35:15 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 386AZDqj029305
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 6 Sep 2023 10:35:13 GMT
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Wed, 6 Sep 2023 03:35:12 -0700
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <johannes@sipsolutions.net>, <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH 0/3] wifi: mac80211: change to match driver to support MLO connection
Date:   Wed, 6 Sep 2023 06:34:55 -0400
Message-ID: <20230906103458.24092-1-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2O8OCoCjQtzVvvSxYAthHARFxcvJ3jr8
X-Proofpoint-ORIG-GUID: 2O8OCoCjQtzVvvSxYAthHARFxcvJ3jr8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-06_03,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 adultscore=0
 phishscore=0 mlxlogscore=858 mlxscore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309060089
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently mac80211 use its default settings, it does not meet requirement
of some driver such as ath12k. So extend its interface to driver for MLO 
connection.

The default settings in mac80211 are:
1. all link address are random for station
2. active link is only for primary link for station.

primary link: the link used by the latest exchange of successful
(Re)Association Request/Response frames.

Wen Gong (3):
  wifi: mac80211: add support to allow driver to generate local link
    address for station
  wifi: mac80211: add support to allow driver to set active link while
    connection for station
  wifi: mac80211: update link RX NSS by ieee80211_sta_set_rx_nss() in
    ieee80211_assoc_config_link()

 include/net/mac80211.h    | 17 +++++++++++++
 net/mac80211/driver-ops.h | 42 ++++++++++++++++++++++++++++++++
 net/mac80211/link.c       |  8 +++++++
 net/mac80211/mlme.c       | 26 +++++++++++++++-----
 net/mac80211/trace.h      | 50 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 137 insertions(+), 6 deletions(-)


base-commit: 3f257461ab0ab19806bae2bfde4c3cd88dbf050e
-- 
2.40.1

