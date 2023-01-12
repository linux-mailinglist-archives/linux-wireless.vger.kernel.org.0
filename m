Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF78666858
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jan 2023 02:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234039AbjALBYv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Jan 2023 20:24:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjALBYt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Jan 2023 20:24:49 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3137440850
        for <linux-wireless@vger.kernel.org>; Wed, 11 Jan 2023 17:24:48 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30C1G9Dq031565;
        Thu, 12 Jan 2023 01:24:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=t8wCcgD1DqD50x/M2WGJy5UeLUd3j4PxOJf/BXBgXAU=;
 b=Ar/6R/l4y2J+Utz5sopoNms45/8hT7H0ExsLUBuxDoVaLBXYRBXyKyTqtZOSLouWoGgS
 QiFxCRk84sDKXDOZeKAh+rvV1JzNrp/9OosSYkFEida7Nt1Yh6hXF3hsz4TiEVu1JH7d
 IRXjjoksBPfTIoprIXb/JwhPG4+0f269jGsKxBC6CKAvK9u9UuoYC92oTNbL5z9oFvV6
 Myq3XPkFoPx7dRjlPal/UJLVB9OgbXoCW9plIDy94H8e5PwVC44RMhY5dIrZPFtzFS4v
 P4BUJrglvKgddh04I04w0x6hrUpyf6AzLQ3SLP5yO7/ZXivCK1vrqaONePjXGhf3f58X xA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n1k5k2ks9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 01:24:43 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30C1OgWO003918
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 01:24:42 GMT
Received: from cnss-mw-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 11 Jan 2023 17:24:40 -0800
From:   Veerendranath Jakkam <quic_vjakkam@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>, <quic_vjakkam@quicinc.com>
Subject: [PATCH v3 0/3] Add support for randomizing TA of auth and deauth frames
Date:   Thu, 12 Jan 2023 06:54:12 +0530
Message-ID: <20230112012415.167556-1-quic_vjakkam@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: evOUOeeV-PlgtAu0HXHymil0R8SwbyZv
X-Proofpoint-GUID: evOUOeeV-PlgtAu0HXHymil0R8SwbyZv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-11_10,2023-01-11_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 mlxlogscore=583
 clxscore=1015 bulkscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301120007
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch series is to add support for randomizing transmit address of
the authentication and deauthentication frames.

The changes submitted in this patch series can be verified with
hostap.git HWSIM test case changes submitted in below link
https://patchwork.ozlabs.org/project/hostap/list/?series=335502&state=*

Veerendranath Jakkam (3):
  wifi: nl80211: Add support for randomizing TA of auth and deauth
    frames
  wifi: mac80211: Add support to randomize TA of auth and deauth frames
  wifi: mac80211_hwsim: Add support for randomizing auth and deauth
    frames TA

 drivers/net/wireless/mac80211_hwsim.c | 26 +++++++++++++
 include/net/mac80211.h                | 12 ++++++
 include/uapi/linux/nl80211.h          |  5 +++
 net/mac80211/main.c                   |  3 +-
 net/mac80211/offchannel.c             | 38 ++++++++++++++++++
 net/mac80211/rx.c                     | 18 +++++++--
 net/mac80211/util.c                   |  7 +++-
 net/wireless/mlme.c                   | 55 ++++++++++++++++++---------
 8 files changed, 139 insertions(+), 25 deletions(-)

-- 
2.25.1

