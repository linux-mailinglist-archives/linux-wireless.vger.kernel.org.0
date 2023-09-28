Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F02387B1236
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Sep 2023 07:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjI1Fuy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Sep 2023 01:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjI1Fux (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Sep 2023 01:50:53 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA8FF9
        for <linux-wireless@vger.kernel.org>; Wed, 27 Sep 2023 22:50:51 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38S5kTjM009353;
        Thu, 28 Sep 2023 05:50:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=80+iWJsqL31O97GIPcsVD9nCK11R1yFQTCl21puXvqE=;
 b=piPHRwR/wjDKgaiEYX9qnd13I5kuPsPShFkVBkJxiwzweL5Jp7Oa2zuSsGpeCbyzhtMc
 qtslhi0d2t2C2k2bjH82S4xxPQKgHsuvdebsCi/0BX90UrmLMHbYXOH6WcBNzhLhsdNg
 UtmIReSWecnpyChVfElXZOsiDsoQ5svpJ/dD/iPzW9o7tr8x2HQvDcwKhO7afTbmAdbB
 e5ieKSUSQyOpvTQRC4fQbKi36Otawu15aRtO89n61vUpoLdGy99pL2kQMlE40/hl1urW
 8HbkVKfeh6wzrjTAgTVyTTpmkiGPJG241RhqEZPv4y8m22kvBht85R5wVU3joKhSYEIL 7Q== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3td24u84rs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 05:50:44 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38S5oguI016421
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 05:50:42 GMT
Received: from yk-E5440.qca.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Wed, 27 Sep 2023 22:50:41 -0700
From:   Kang Yang <quic_kangyang@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH 0/4] dynamically update puncturing bitmap
Date:   Thu, 28 Sep 2023 13:50:18 +0800
Message-ID: <20230928055022.9670-1-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: JEKTZUFs9fCixfZwqJF2nbgrPu7QG1G3
X-Proofpoint-ORIG-GUID: JEKTZUFs9fCixfZwqJF2nbgrPu7QG1G3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-28_03,2023-09-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=462 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309280048
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

After connection, puncturing bitmap maybe change. AP will include the
related changes in beacon.

So update the related changes dynamically.

Kang Yang (4):
  wifi: mac80211: mlme: fix verification of puncturing bitmap obtained
    from AP
  wifi: mac80211: mlme: correct the verification of extracted bitmap
  wifi: mac80211: mlme: enable tracking bandwidth changes for 6 GHz band
  wifi: ath12k: dynamically update puncturing bitmap

 drivers/net/wireless/ath/ath12k/mac.c | 50 +++++++++++++++++++
 drivers/net/wireless/ath/ath12k/wmi.h | 17 +++++++
 net/mac80211/mlme.c                   | 72 ++++++++++++++++++++-------
 3 files changed, 121 insertions(+), 18 deletions(-)


base-commit: 73e13f6a439b75a9dbc84bbfa0b0d6624b354853
-- 
2.34.1

