Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B86C07751EA
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Aug 2023 06:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjHIE1u (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Aug 2023 00:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjHIE1u (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Aug 2023 00:27:50 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8509B19A1
        for <linux-wireless@vger.kernel.org>; Tue,  8 Aug 2023 21:27:49 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3794N2gh012381;
        Wed, 9 Aug 2023 04:27:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=zSMraO1ZfBnQqxcoJNNsj2Xo4IODwLxsQ7cHPDoHClU=;
 b=j763HbTzAXywvd5dD116Kvr0HfSxg9gf9M9hBCb5p6OW1SILlRWszrTSlp8M74ZPuSwl
 N92hK6lokmWj+FvATyPOEqEPysgZC8y7iJKsSE53WQhlRf79uPYk/bbtl42QgiyFN+vt
 18GIsElrfj7VhA+uMSWFBj6FpoROARGEJKN50GZc9VZt+DMlGEk7C+gasCqFSpJHsEvE
 V/Wsd8s6Ixoqekrl1xE+9O4FL29LC2R4KYE4UpqZmxMJN2l/Mh+2FOQwksMLEFswJI3f
 qs9CaXQf+PPLShDn5iIAYscGC+Y7o4flt1S/DOqBFzgpl7Zy6uwRfkH4iY9qpmyCipGU nw== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sbmrqhtgd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 04:27:44 +0000
Received: from pps.filterd (NASANPPMTA03.qualcomm.com [127.0.0.1])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3794RhU1015378;
        Wed, 9 Aug 2023 04:27:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NASANPPMTA03.qualcomm.com (PPS) with ESMTP id 3sbuj0kkb8-1;
        Wed, 09 Aug 2023 04:27:43 +0000
Received: from NASANPPMTA03.qualcomm.com (NASANPPMTA03.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3794RhBB015372;
        Wed, 9 Aug 2023 04:27:43 GMT
Received: from hprem-linux.qualcomm.com (hprem-linux.qualcomm.com [10.201.162.248])
        by NASANPPMTA03.qualcomm.com (PPS) with ESMTP id 3794RguM015366;
        Wed, 09 Aug 2023 04:27:43 +0000
Received: by hprem-linux.qualcomm.com (Postfix, from userid 4146166)
        id 3F3ADB00102; Wed,  9 Aug 2023 09:57:41 +0530 (IST)
From:   Harshitha Prem <quic_hprem@quicinc.com>
To:     ath12k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Harshitha Prem <quic_hprem@quicinc.com>
Subject: [PATCH 0/2]  wifi: ath12k: Ignore fragments from uninitialized peer in dp
Date:   Wed,  9 Aug 2023 09:57:36 +0530
Message-Id: <20230809042738.13394-1-quic_hprem@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mkFtPjyv7EhiKNdwraI1PrhjVGHeNEgN
X-Proofpoint-ORIG-GUID: mkFtPjyv7EhiKNdwraI1PrhjVGHeNEgN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-09_01,2023-08-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 adultscore=0 mlxscore=0 suspectscore=0 phishscore=0 mlxlogscore=657
 impostorscore=0 priorityscore=1501 clxscore=1011 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308090038
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When max virtual ap interfaces are configured in all the bands
with ACS and hostapd restart is done every 60s,
a crash is observed at random times in dp_rx path.

This patch series handles the following:
    1. Ignore the fragments of the peer which does not have its
       datapath initialized.
    2. Fix the undefined behavior of __fls which was found during
       this crash.

Harshitha Prem (2):
  wifi: ath12k: Ignore fragments from uninitialized peer in  dp
  wifi: ath12k: fix undefined behavior with __fls in dp

 drivers/net/wireless/ath/ath12k/dp.c    |  1 +
 drivers/net/wireless/ath/ath12k/dp_rx.c | 11 ++++++++++-
 drivers/net/wireless/ath/ath12k/peer.h  |  3 +++
 3 files changed, 14 insertions(+), 1 deletion(-)


base-commit: 3f257461ab0ab19806bae2bfde4c3cd88dbf050e
-- 
2.17.1

