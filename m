Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046F46034EA
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Oct 2022 23:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiJRV2w (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Oct 2022 17:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbiJRV2r (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Oct 2022 17:28:47 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA2FB7EE0
        for <linux-wireless@vger.kernel.org>; Tue, 18 Oct 2022 14:28:46 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29IKpK9S006750;
        Tue, 18 Oct 2022 21:28:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=UuJJ1Wyj8yU7mqpGUbXZPK1ImQIY8T5tunMZvhm020E=;
 b=agLmSALY6L19axxyIJMJf6Xwzp/E/qQV4RQ7v4qhu07dlCbEaEfoG9A1m2R57z1uic8p
 fKwfiExaOaaZ7XKpMsudDYti8ICOFjQXiTWkIaQq1rqP/8F82eJRM8A9mm0wCGBGHG0H
 xeuZk9Yw1AmvtctYftijfarouQ4YMriP4HDdL25yVzplboDp5rrFzaeuy5TEgAdfuoT/
 V5vkFVZZ+WjWyBIngDcpyIa/ktDVlXaRvQWSlmPgMCJUtSa09J4LkECu29N6ZLUDFmL2
 1J4excXaFaiNxvk9qaaccBngNBiBChSWBFeIgFdksly8vQRsACbI3QcsZv2hnbAQ3/Ec Zg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ka3j1r2df-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Oct 2022 21:28:40 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29ILSe3L031972
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Oct 2022 21:28:40 GMT
Received: from msinada-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 18 Oct 2022 14:28:39 -0700
From:   Muna Sinada <quic_msinada@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Muna Sinada <quic_msinada@quicinc.com>
Subject: [PATCH v2 0/4] wifi: ath11k: push MU-MIMO configurations to hardware
Date:   Tue, 18 Oct 2022 14:28:17 -0700
Message-ID: <1666128501-12364-1-git-send-email-quic_msinada@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 0XTZmuq9BpiicSaNOUALOnUXNXhJ42ON
X-Proofpoint-GUID: 0XTZmuq9BpiicSaNOUALOnUXNXhJ42ON
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-18_07,2022-10-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 phishscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210180120
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

This patchset is dependant on mac80211 patchset:
https://patchwork.kernel.org/project/linux-wireless/list/?series=683322&state=%2A&archive=both

---

v2: 
 - cleaned compilation errors
 - added mac80211 dependancy comment to commit message

---
Muna Sinada (4):
  wifi: ath11k: modify accessor macros to match index size
  wifi: ath11k: push MU-MIMO params from hostapd to hardware
  wifi: ath11k: move HE MCS mapper to a separate function
  wifi: ath11k: generate rx and tx mcs maps for supported HE mcs

 drivers/net/wireless/ath/ath11k/mac.c | 249 ++++++++++++++++++++++------------
 drivers/net/wireless/ath/ath11k/wmi.h |  27 ++--
 2 files changed, 180 insertions(+), 96 deletions(-)

-- 
2.7.4

