Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 465B95FCABE
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Oct 2022 20:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiJLShJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Oct 2022 14:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiJLShH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Oct 2022 14:37:07 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2FA6F546
        for <linux-wireless@vger.kernel.org>; Wed, 12 Oct 2022 11:37:06 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29CI9QWM005484;
        Wed, 12 Oct 2022 18:36:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=K5YgqxPyAj9tedu5bRREtlroD2p6CS+qGRkQihRNgi4=;
 b=Gnuupe0vPyz7jbenDBluey3+ImFoFSZoQeCtoAUEu87OHuTZ8frdOs+6fhoQhcKLgsBQ
 xXsRXgrVEb4k+jphj7ni51H8TBC/BlNDETl8XimdfLIGJaKsmwssy23aiHlhFnVfQwj2
 t+pEHkMVka04GsOdDRJxwqap+L8Bny0aF+fEX3Y8eGsia+sUcUD5h8wC8Fs62ygrCCiZ
 4ZHyXEB8DDHi9npRf8GAlNzyYBnYRdV9fhMQYDBgjhOMGM0RAk0HSwiB/OfhRQK7dZSO
 e5OinoxohdQpC9DQ2r73Z/g6HvpAdjdqSr0TQyb4MGrKb6RdK9GNzftFwnK0h7AYoCbm bw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k5qns1qrs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 18:36:55 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29CIasmC026520
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 18:36:54 GMT
Received: from msinada-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 12 Oct 2022 11:36:53 -0700
From:   Muna Sinada <quic_msinada@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Muna Sinada <quic_msinada@quicinc.com>
Subject: [PATCH 0/4] wifi: ath11k: push MU-MIMO configurations to hardware
Date:   Wed, 12 Oct 2022 11:36:43 -0700
Message-ID: <1665599807-12908-1-git-send-email-quic_msinada@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: bHj6icmpPb7gxgkiHPCn2xYsgXufnplw
X-Proofpoint-ORIG-GUID: bHj6icmpPb7gxgkiHPCn2xYsgXufnplw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-12_09,2022-10-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 spamscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=825 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210120120
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently enable/disable configurations for MU-MIMO in hostapd are 
only reflected in beacon, probe response and assoc response. These 
configurations are not present in hardware.

The change is parsing MU-MIMO configurations in beacon IE and pushing 
the configurations to the hardware.

Muna Sinada (4):
  wifi: ath11k: modify accessor macros to match index size
  wifi: ath11k: push MU-MIMO params from hostapd to hardware
  wifi: ath11k: move HE MCS mapper to a separate function
  wifi: ath11k: generate rx and tx mcs maps for supported HE mcs

 drivers/net/wireless/ath/ath11k/mac.c | 248 ++++++++++++++++++++++------------
 drivers/net/wireless/ath/ath11k/wmi.h |  27 ++--
 2 files changed, 179 insertions(+), 96 deletions(-)

-- 
2.7.4

