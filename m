Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4768F67CE32
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jan 2023 15:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbjAZOda (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Jan 2023 09:33:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbjAZOd0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Jan 2023 09:33:26 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBD062782
        for <linux-wireless@vger.kernel.org>; Thu, 26 Jan 2023 06:33:20 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30QESJkC017884;
        Thu, 26 Jan 2023 14:33:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=TLAytvOvXoEJzc+E1XvqDfnxoJR6WwJkjPNLQYZJMGM=;
 b=DZ8jtZRYywD9wZWV9NGSnQk93WfRsNDRQQHwkvs/5KcIqDYBko3tyzUyeyBRjh63fLQ+
 ofCXWKM+16w/B0gkdffy+QXQEbjiXSedHQqHK4WKgB1LA+BfsgPY9LN6WtgsCBaFSeQt
 jn6IXZzEXQaBblptuCLrHIrlvpJj3GEYoQcsXknZI9//OQ/ycLruTAvUTIgpYnw9MWUb
 WNZZBepTaLLKGBoGKO5SO1D0Rw3uYg02CpU++qmVuMi74Fi9cxRCFWuGB6Zhj+hOC8Ph
 gqjT+iEaMPf85KHS5KW3jsXbnklR7l/GzEP5ASiDfq6sElfUP5CD5PM3oRJjBzhCGVd0 4w== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3najkhc6pg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 14:33:17 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30QEXGEK022547
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 14:33:16 GMT
Received: from cnss-mw-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 26 Jan 2023 06:33:15 -0800
From:   Veerendranath Jakkam <quic_vjakkam@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>, <quic_vjakkam@quicinc.com>
Subject: [PATCH v2 0/2] wifi: changes for MLD AP when SME offload to driver
Date:   Thu, 26 Jan 2023 20:02:54 +0530
Message-ID: <20230126143256.960563-1-quic_vjakkam@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: udGrBISLlWSzNM-uuhrSRxHogUYXtiNt
X-Proofpoint-GUID: udGrBISLlWSzNM-uuhrSRxHogUYXtiNt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-26_06,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=529 clxscore=1015
 lowpriorityscore=0 impostorscore=0 mlxscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301260139
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This series contains changes needed for MLD AP when driver's SME in use.

Veerendranath Jakkam (2):
  wifi: cfg80211: Extend cfg80211_new_sta() for MLD AP
  wifi: cfg80211: Extend cfg80211_update_owe_info_event() for MLD AP

 .../net/wireless/quantenna/qtnfmac/event.c    |  1 +
 include/net/cfg80211.h                        | 34 +++++++++++++++++++
 net/wireless/nl80211.c                        | 27 +++++++++++++++
 net/wireless/trace.h                          | 14 +++++---
 4 files changed, 72 insertions(+), 4 deletions(-)

-- 
2.25.1

