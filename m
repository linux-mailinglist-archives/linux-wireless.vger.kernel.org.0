Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD92663E80A
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Dec 2022 03:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiLACw3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Nov 2022 21:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiLACw1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Nov 2022 21:52:27 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B9C983AA
        for <linux-wireless@vger.kernel.org>; Wed, 30 Nov 2022 18:52:26 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B12nqU3009895;
        Thu, 1 Dec 2022 02:52:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : subject
 : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=MVVgBfm4+oFMzVQULjgVt8zMQcKHEOqpbxGFLmS+db0=;
 b=gfyPmgdueHudH+XpXDRb8slgx765Dvj7/loUIJ9Fysp+U5h+yMi/AxJyXZVQrJUmGadK
 WjGT1QR+afZ2o0jIpotrdO7/b/wDyXQ4yul73+kJ1CtngbCALDD/ygaRfnc1FtacJXfl
 ho2arQpT4QtWuWsJHKhLaDo1QmlYGo63eEXDxDvmyF5V+vAHYVHtg7m7gLIb8eZ2OGf+
 iVA3uRTvjlyPLtopThWIE58FdGGXWtE+Jni569zmfJ8D2z/Yl3QUaHoWskUeAWdRyIKh
 5+MaOQnduOa5oViJSuDPjKHkBduhP92idkfKTFv6yyayXnqDNPT2mcoE8Oir0pgQfZCw nA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m6kgmg13w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Dec 2022 02:52:23 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2B12qMUZ014146
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Dec 2022 02:52:22 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 30 Nov 2022 18:52:21 -0800
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/3] wifi: mac80211_hwsim: MBSSID and EMA support
Date:   Wed, 30 Nov 2022 18:52:05 -0800
Message-ID: <20221201025208.23800-1-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: b7RbMmzJ0I3X856BCO90qRkDHyrwr3vC
X-Proofpoint-GUID: b7RbMmzJ0I3X856BCO90qRkDHyrwr3vC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-01_02,2022-11-30_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 spamscore=0 impostorscore=0 phishscore=0 bulkscore=0
 mlxscore=0 lowpriorityscore=0 mlxlogscore=525 malwarescore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212010015
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add support to test MBSSID and EMA beacon generation.

Patch #3 depends on following:
https://patchwork.kernel.org/project/linux-wireless/patch/20221114201912.22893-2-quic_alokad@quicinc.com/

Aloka Dixit (3):
  wifi: mac80211_hwsim: move beacon transmission to a separate function
  wifi: mac80211_hwsim: Multiple BSSID support
  wifi: mac80211_hwsim: EMA support

 drivers/net/wireless/mac80211_hwsim.c | 83 +++++++++++++++++++--------
 1 file changed, 58 insertions(+), 25 deletions(-)


base-commit: eceb024ee3eed1bacb5c32a4847269f2685e2ea4
prerequisite-patch-id: fcf54cc59b71b15010a88a080ee2b5f91d815d51
--
2.25.1

