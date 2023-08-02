Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1676676C8DF
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Aug 2023 11:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbjHBI77 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Aug 2023 04:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232095AbjHBI76 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Aug 2023 04:59:58 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635EFE42
        for <linux-wireless@vger.kernel.org>; Wed,  2 Aug 2023 01:59:57 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37268oGd010953;
        Wed, 2 Aug 2023 08:59:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=c1nkLHFd+NlF61YfhQ476mA/iKW5+Fzefk0vDdVgbPg=;
 b=EQn2Hdl6rvjB5paAV+1ZN0FpXyeZDo2Sp/K3jQUb7+Vx+up3praoQszOe1OFNFGJVXEs
 EOUvaooQTozXrKeGZ4aukmbO+DYFZOPPRuc9mnU5MzW2qQNCf3PUMHYnD2FvrtGkq8DQ
 MOdKLj/GPtWbCS1+8gU3otSF+cEScobn2C/2IdQg4NBKMp8Z7gx+9YuhmR30RfTF+48o
 0lJx94nrgtAeTbJy8S4IJ9TLxB8Y8jPKaUxpsa3BnuN85OAsWPnZt+j+NMOj+MXK+Um3
 +1rR6xEtSs9ij7E+sIwd1jcwdmsOskBS4riOyxUP6O4KeoaR4yOzsdPSGD/aBtCZNg9y Mw== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s7fre0tmv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Aug 2023 08:59:43 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3728xgwP012145
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 2 Aug 2023 08:59:42 GMT
Received: from mdharane-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 2 Aug 2023 01:59:40 -0700
From:   Manish Dharanenthiran <quic_mdharane@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Manish Dharanenthiran <quic_mdharane@quicinc.com>
Subject: [PATCH 0/2] wifi: ath12k: fix radar detection in secondary 80 MHz
Date:   Wed, 2 Aug 2023 14:28:50 +0530
Message-ID: <20230802085852.19821-1-quic_mdharane@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: K5pKn2_U_PoqHOEOnOKH2qVowGx-EoqR
X-Proofpoint-ORIG-GUID: K5pKn2_U_PoqHOEOnOKH2qVowGx-EoqR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_03,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 clxscore=1011
 mlxlogscore=571 bulkscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2308020079
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch series add fix for radar detection in secondary 80 MHz when the
AP's primary 80MHz is in non-DFS region in 160 MHz. Also, adds changes for
fixing WARN_ON in ath12k_mac_update_vif_chan.

Manish Dharanenthiran (2):
  wifi: ath12k: fix WARN_ON during ath12k_mac_update_vif_chan
  wifi: ath12k: fix radar detection in 160 MHz

 drivers/net/wireless/ath/ath12k/mac.c | 47 +++++++++++++++++++--------
 1 file changed, 33 insertions(+), 14 deletions(-)


base-commit: dfa8dc118e3cef402d4fbc2ae9cab418197d103b
-- 
2.17.1

