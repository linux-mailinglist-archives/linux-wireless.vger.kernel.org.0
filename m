Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D90E7C7E4B
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Oct 2023 09:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjJMHAV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Oct 2023 03:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjJMHAU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Oct 2023 03:00:20 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C502EBD
        for <linux-wireless@vger.kernel.org>; Fri, 13 Oct 2023 00:00:18 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39D6KAnN021676;
        Fri, 13 Oct 2023 07:00:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=Kpfk2sG8Pemv8Kx5DG6ELViPNTaaUbKwfRGfIPDOjOE=;
 b=HSyrsgQSdhIjbszdxcEr7PQgHogr5cXTwkdo+LK+tqUAnbCJwVdySFPzlLJttivCfKcE
 a+Ri6Q7IMQwVTPOq34sD0OhnwtD+Ny3x5DIYKKq1hOWT3ngwylbiSmpnNBEXOsIZSSVC
 MYZx9zD8/mD4pZK6tZdhP7LBurOsM1r/2HGNvgoynph1Fy6nC4f7VdM+lvSKV8nvwuwx
 jHQyEsljQRwKeGuNuqF2MS3IAypS5qSL7STo/5a+BS7gdidRBfVA1l7KOVoNmT7QiJnF
 sgoxto/2uYf6vDvzsu6qkNpi15FkX0OktMjBmrKVxqVvN8PSScGwVUkgD0B9ezp2+wPz SA== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tpt1k0v6s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Oct 2023 07:00:13 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 39D70Ajk020103;
        Fri, 13 Oct 2023 07:00:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3tk0dkvxwp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 13 Oct 2023 07:00:10 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39D6voA0017578;
        Fri, 13 Oct 2023 07:00:10 GMT
Received: from rgnanase-linux.qualcomm.com (rgnanase-linux.qualcomm.com [10.201.162.135])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 39D70ADS020086;
        Fri, 13 Oct 2023 07:00:10 +0000
Received: by rgnanase-linux.qualcomm.com (Postfix, from userid 2378837)
        id 3DF401101FE2; Fri, 13 Oct 2023 12:30:09 +0530 (IST)
From:   Ramya Gnanasekar <quic_rgnanase@quicinc.com>
To:     ath12k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Ramya Gnanasekar <quic_rgnanase@quicinc.com>
Subject: [PATCH 0/2] wifi: ath12k: EHT mesh support
Date:   Fri, 13 Oct 2023 12:30:05 +0530
Message-Id: <20231013070007.25597-1-quic_rgnanase@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: QbxiSEmxc-mfhY4GibwOkPIpNoThYl5k
X-Proofpoint-GUID: QbxiSEmxc-mfhY4GibwOkPIpNoThYl5k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-13_03,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=316 phishscore=0
 spamscore=0 mlxscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310130058
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch series adds mesh support for QCN9274 and 
EHT support for mesh mode by registering EHT capabilities.

Ramya Gnanasekar (2):
  wifi: ath12k: register EHT mesh capabilities
  wifi: ath12k: Enable Mesh support for QCN9274

 drivers/net/wireless/ath/ath12k/hw.c  |  6 ++--
 drivers/net/wireless/ath/ath12k/mac.c | 45 +++++++++++++++++++++++++++
 2 files changed, 49 insertions(+), 2 deletions(-)

-- 
2.17.1

