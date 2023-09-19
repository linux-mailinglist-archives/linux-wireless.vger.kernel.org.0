Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 338D57A5AAE
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Sep 2023 09:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbjISHRm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Sep 2023 03:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbjISHRl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Sep 2023 03:17:41 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2D7100
        for <linux-wireless@vger.kernel.org>; Tue, 19 Sep 2023 00:17:35 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38J6UY2Q014285;
        Tue, 19 Sep 2023 07:17:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=qcppdkim1;
 bh=oBpPyqi89bKXy+pYu6EOwvxIC/OrkZ4+wMykF+vqSZI=;
 b=mS7FpZyu8eXdUM44p5aH/R4klIY7rT5xexwp9lh0zo/du4n+VWUHhHvajlca7tkhLxs7
 oQr3GBnVlI18ABTQuxlHA21k5rGdogQI0TfPTwr/HzcOTEjcQ8MS0KAvddzsi34bQbJI
 y0yQQC8hgXRgMDzCVM3hXgouB2KlAmaPqItc8jUUy9yUmj4WoFCtCBb/KSHU+eW+scD0
 0gXLJVd4pGwznPKj/PsPTIqiz/4ZocRUWX/U4DOLf8Ocl4/ZpyamjM3ZZF/eQw9/1TZ2
 qcnNWrkRVAF7h63wrBHHV9MQStPn0BxGRkho+7dAUvAsyryQLNX7l+1Gvz9GSm0DvRHZ mg== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t72pf8dyr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Sep 2023 07:17:30 +0000
Received: from pps.filterd (NASANPPMTA01.qualcomm.com [127.0.0.1])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 38J76CSP002071;
        Tue, 19 Sep 2023 07:17:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NASANPPMTA01.qualcomm.com (PPS) with ESMTP id 3t74xehgc8-1;
        Tue, 19 Sep 2023 07:17:29 +0000
Received: from NASANPPMTA01.qualcomm.com (NASANPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38J7HTxY024301;
        Tue, 19 Sep 2023 07:17:29 GMT
Received: from aisr-linux.qualcomm.com (aisr-linux.qualcomm.com [10.201.124.194])
        by NASANPPMTA01.qualcomm.com (PPS) with ESMTP id 38J7HSUr024281;
        Tue, 19 Sep 2023 07:17:29 +0000
Received: by aisr-linux.qualcomm.com (Postfix, from userid 4090849)
        id 90E78E020C5; Tue, 19 Sep 2023 12:47:27 +0530 (IST)
From:   Aishwarya R <quic_aisr@quicinc.com>
To:     ath12k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, Aishwarya R <quic_aisr@quicinc.com>
Subject: [PATCH 0/7] wifi: ath12k: add support for 6 GHz AP for various power modes
Date:   Tue, 19 Sep 2023 12:47:17 +0530
Message-Id: <20230919071724.15505-1-quic_aisr@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: v1quxEglaB6xVI_OL3qAMZZxByB-U-eq
X-Proofpoint-ORIG-GUID: v1quxEglaB6xVI_OL3qAMZZxByB-U-eq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_01,2023-09-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 clxscore=1011 impostorscore=0 lowpriorityscore=0 mlxlogscore=813
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309190060
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add support for 6 GHz for various modes. Supports various power type of
AP(STANDARD_POWER_AP, INDOOR_AP, VERY_LOW_POWER_AP), power type of
STATION(DEFAULT_CLIENT, SUBORDINATE_CLIENT) and Power Spectral Density(PSD).

Implement the new rules for 6 GHz band in ath12k.
ath12k parse the transmit power envelope element in beacon of AP
and then set new wmi cmd WMI_VDEV_SET_TPC_POWER_CMDID to firmware
when connect to 6 GHz AP, also support backward compatibility with
firmware which not support new wmi cmd WMI_VDEV_SET_TPC_POWER_CMDID.

Aishwarya R (7):
  wifi: ath12k: add support to select 6 GHz Regulatory type
  wifi: ath12k: build 6 GHz regd based on vdev type and 6 GHz power type
  wifi: ath12k: get 6 GHz power type from HE operation element
  wifi: ath12k: save power spectral density(PSD) of regulatory rule
  wifi: ath12k: add parse of transmit power envelope element
  wifi: ath12k: fill parameters for vdev_set_tpc_power wmi command
  wifi: ath12k: send TPC power to firmware for 6 GHz VDEV

 drivers/net/wireless/ath/ath12k/core.h |  39 ++
 drivers/net/wireless/ath/ath12k/mac.c  | 515 ++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath12k/mac.h  |   4 +
 drivers/net/wireless/ath/ath12k/reg.c  |  79 +++-
 drivers/net/wireless/ath/ath12k/reg.h  |   6 +-
 drivers/net/wireless/ath/ath12k/wmi.c  | 320 +++++++++++++--
 drivers/net/wireless/ath/ath12k/wmi.h  |  94 ++++-
 7 files changed, 1003 insertions(+), 54 deletions(-)

-- 
2.17.1

