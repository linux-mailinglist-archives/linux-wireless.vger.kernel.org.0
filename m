Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC9E5BE2B8
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Sep 2022 12:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiITKLD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Sep 2022 06:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbiITKKw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Sep 2022 06:10:52 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31AF696D8
        for <linux-wireless@vger.kernel.org>; Tue, 20 Sep 2022 03:10:44 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28K7xnfu003508;
        Tue, 20 Sep 2022 10:10:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=8H4nC73LoJ4Ax2XLXp/WsymmXkb/FvEhbXuD3IIf+4M=;
 b=M9j3wUGglzzaSOHQnMyLmj8X7WYhF6xTXNlbVSJ+ufrMSuusKDw1T3PmWZtHARk8BauZ
 TNWoAqP9SOCGzaYDX4LYSmhPHGHuM27AdENHvcoayD5X0224kIJso5E4rKHswNH2ild3
 tM/hNBQ3GZkGFkzMtlfe57VNRqYjwDXho0xtju8KtwIvjjU6Eqp8qnk0YKu2c6aM3/l0
 +aMZC9Us2h8cU7XMxQNeV0ZRbPZMtr+E53FLUObzM1ja2galseghRxfcL6zBY0PBigYD
 2yfwMHXXZJGGPOZvaRSZNewojfbkIF4+aqh5fwWMefMk6AOPElpUzBxTRCIirlY+CDS8 rA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jpw78anq0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 10:10:41 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28KA5eF2029178
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 10:05:40 GMT
Received: from CDCCSTEX0180100-LIN.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 20 Sep 2022 03:05:39 -0700
From:   Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
Subject: [RFC 0/4] wifi: cfg80211/mac80211: capability advertisement infra for multi-hw abstraction under one wiphy
Date:   Tue, 20 Sep 2022 15:35:14 +0530
Message-ID: <20220920100518.19705-1-quic_vthiagar@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: xXHI-WkKOZjwekPcW12SuIWYvngfm1ad
X-Proofpoint-GUID: xXHI-WkKOZjwekPcW12SuIWYvngfm1ad
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-20_02,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=2 mlxlogscore=163
 lowpriorityscore=0 spamscore=2 impostorscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 mlxscore=2 adultscore=0 suspectscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209200062
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

There may be hardware design (ath12k as of now) supporting MLO across multiple
discrete hardware each acting as a link in the MLO operation. Since the prerequisite
for MLO support in cfg80211/mac80211 is that all the links participating in MLO
must be from the same wiphy/ieee80211_hw, driver needs to handle the discreate hardware
abstraction under single wiphy.  Though most of the hw specific abstractions
can be handled with in the driver, there are some capabilities like interface
combination which can be specific to each constituent physical hardware. This patch set
tries to add an infrastructure to advertise underlying hw specific capabilities like
channel and interface combinations.

Some of the todos

- Make runtime iface combination validation logic be aware of this extension
- More than one concurrent monitor mode support each operating on different
  channels under one ieee80211_hw
- Mechanism for each underlying radio specific configurations like txpower, channel, etc. 
- Should we make the capability advertisement changes to mac80211_hwsim?
- Should we enable some of concurrent operations like allow scan on each physical
  hardware concurrently?


Vasanthakumar Thiagarajan (4):
  wifi: cfg80211: Add provision to advertise multiple radio in one wiphy
  wifi: nl80211: send underlying multi-hardware channel capabilities to
    user space
  wifi: cfg80211/mac80211: extend iface comb advertisement for
    multi-hardware dev
  wifi: nl80211: send iface combination to user space in multi-hardware
    wiphy

 include/net/cfg80211.h       | 130 +++++++++++++++++
 include/uapi/linux/nl80211.h |  78 +++++++++-
 net/mac80211/main.c          |  54 +++++++
 net/wireless/core.c          | 275 +++++++++++++++++++++++++++++------
 net/wireless/nl80211.c       | 118 +++++++++++++++
 net/wireless/util.c          |  18 +++
 6 files changed, 629 insertions(+), 44 deletions(-)

-- 
2.17.1

