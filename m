Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE21694699
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Feb 2023 14:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjBMNJh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Feb 2023 08:09:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjBMNJf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Feb 2023 08:09:35 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911409001
        for <linux-wireless@vger.kernel.org>; Mon, 13 Feb 2023 05:09:34 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31DBSPDJ004107;
        Mon, 13 Feb 2023 13:09:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=cHUipU6ET/S0aJAmNFojqgGyyTKEOme+s69n5meWiTo=;
 b=K7l1uv44gRin6zYLglgTs/Rn7wY3d/2QV9xMiH0OFOU2xqIrzALAH3zDuVI4CYjU0Om6
 fwKXI361vUNycVL1BnLc/ExahddqLOpj9hf/DyIywOGdGOKyMPhUC0KV+ppiDdVZDh8w
 BpkTZSU4jH54e+NtUY5ljnnOjZrCHMa5Py9GQgD7HSZtAwHNxj8rgBGOyfegoNCxtKWb
 U62Uh1c5CDtfemHf1z0gGCxeXdezp81NF/SDX8mZrYA3sfq1L1Bfv5N17yCNa+mjEGYm
 wMmr2cmN69rmElYKnwYkpAxbu3IspZvQXaK/NU5yyxU+CzVwaLMgyk9MqxhQ4XUnzPsW GA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3np0qpv6ht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 13:09:25 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31DD9OqN008555
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 13:09:24 GMT
Received: from rajkbhag-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 13 Feb 2023 05:09:23 -0800
From:   Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Subject: [PATCH 0/2] ath11k: factory test mode support
Date:   Mon, 13 Feb 2023 18:38:52 +0530
Message-ID: <20230213130854.2473-1-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: UPeCKMRv_u3LvK8va6PqrpMMfftLnmTP
X-Proofpoint-ORIG-GUID: UPeCKMRv_u3LvK8va6PqrpMMfftLnmTP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_09,2023-02-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 clxscore=1011 bulkscore=0 mlxlogscore=850
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302130118
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Device is booted in factory test mode to calibrate the board.
The commands are sent from a userspace application, which is
sent to firmware using wmi commands. Firmware will send the
response back to the application which stores the calibration
data in caldata.bin file. This file will be loaded when the
device boots up normally next time.

Govindaraj Saminathan (1):
  wifi: ath11k: factory test mode support

Sowmiya Sree Elavalagan (1):
  wifi: ath11k: Allow ath11k to boot without caldata in ftm mode

 drivers/net/wireless/ath/ath11k/ahb.c        |   3 +-
 drivers/net/wireless/ath/ath11k/core.c       |  20 +-
 drivers/net/wireless/ath/ath11k/core.h       |  14 +-
 drivers/net/wireless/ath/ath11k/debug.h      |   2 +
 drivers/net/wireless/ath/ath11k/mac.c        |  13 +-
 drivers/net/wireless/ath/ath11k/pci.c        |   3 +-
 drivers/net/wireless/ath/ath11k/qmi.c        |  10 +-
 drivers/net/wireless/ath/ath11k/testmode.c   | 323 ++++++++++++++++---
 drivers/net/wireless/ath/ath11k/testmode.h   |  21 +-
 drivers/net/wireless/ath/ath11k/testmode_i.h |  19 ++
 drivers/net/wireless/ath/ath11k/wmi.c        |  40 ++-
 drivers/net/wireless/ath/ath11k/wmi.h        |  20 ++
 drivers/net/wireless/ath/ath11k/wow.c        |   3 +-
 13 files changed, 427 insertions(+), 64 deletions(-)


base-commit: ddd8e84e007263f3aa8993f32a3dd4dc8ec0876a
-- 
2.17.1

