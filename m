Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB67F7F21CF
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Nov 2023 00:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjKTX6r (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Nov 2023 18:58:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjKTX6q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Nov 2023 18:58:46 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605679E
        for <linux-wireless@vger.kernel.org>; Mon, 20 Nov 2023 15:58:43 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AKNr0Hx020224;
        Mon, 20 Nov 2023 23:58:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=ZXj/gw0tFQrBQIUMkbJeBTKkb9iY11+VM1rEQSWq38w=;
 b=BqeFgW/rUzQSmofZS8mdMA0Izr7cznoeOGGb/eINUkbY8p1F7EKbF/4PJBMrDebSS1iy
 QZFQTRv6HH1VKEm0rgnJLsm8lUgUuMAr/MywWHiIHyyhKdvedI3khsUuBfa5Y7IZJTDz
 GdqDBq2QI1/jD2f5rVO6Ea/dasjTzgvvGdlxYMEpQ4Q69NEyZoieV0Weqi20i56BYhM8
 tgmcP2IT8l5djAMkFw59y0q6fY1rWfuTVmrjJhkEERnlNOOAdt8S9o9Vfjb2Cy6jUt4d
 17w9qmbPKZVdHHj4RmbgxYV3u8cCYtKWbMWVPQn2nmkIJiv8egFk0K0e9Aabamb+Hv9e dQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ug2axaa64-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 23:58:29 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AKNwS3R029491
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 23:58:28 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 20 Nov 2023 15:58:26 -0800
From:   Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Subject: [PATCH 0/2] wifi: ath12k: Optimize the mac80211 hw data access
Date:   Tue, 21 Nov 2023 05:28:10 +0530
Message-ID: <20231120235812.2602198-1-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: dv9A6BP4Eh2DIb7-dsCkAgsozt9l5ZI0
X-Proofpoint-ORIG-GUID: dv9A6BP4Eh2DIb7-dsCkAgsozt9l5ZI0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_22,2023-11-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=16 clxscore=1015
 lowpriorityscore=0 bulkscore=0 spamscore=16 suspectscore=0 phishscore=0
 mlxlogscore=72 impostorscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 mlxscore=16 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311200176
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Optimize the mac80211 hw data access expression statements by avoid
the unnecessary access and repeated access statements.

Karthikeyan Periyasamy (2):
  wifi: ath12k: Optimize the mac80211 hw data access
  wifi: ath12k: avoid repeated hw access from ar

 drivers/net/wireless/ath/ath12k/mac.c | 172 +++++++++++++-------------
 drivers/net/wireless/ath/ath12k/reg.c |  19 +--
 drivers/net/wireless/ath/ath12k/reg.h |   2 +-
 3 files changed, 100 insertions(+), 93 deletions(-)


base-commit: e9e36ed2ffc1bc4ab439d992af01269f50815dde
-- 
2.34.1

