Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA44C640D5A
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Dec 2022 19:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234275AbiLBSgJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Dec 2022 13:36:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234270AbiLBSgI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Dec 2022 13:36:08 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702C3ECE54
        for <linux-wireless@vger.kernel.org>; Fri,  2 Dec 2022 10:36:05 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B2Fe4VI032746;
        Fri, 2 Dec 2022 18:36:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=a/jeFfoPQ8uNUof/hwiBSEsC7Qb1cbbzzi84gpauTjk=;
 b=WLY7ZpL3m+TptiKjDCFa2brXPxHkbiz6dW/FHZ2qMqLlN+fcy2K3WQ2kUfi+yAt7i+F8
 KOzM+zEjLTl3aiT3ig/1MT3IVqc2qrnfttevVGM2HsVFUEivGC8JbJPEUFbmMCFMYmbh
 PkFWE9NsKeXFIpWEBGNV6/ZhYZGiA7RpLkD12jWiK14384gnkyzEYMxmPbhQjwlkiuOf
 qu0TlbX9oXiHMQwjCpuwmO2rQ9l/j66RExbn2s2H1vQAaM2b0sn8dduFN9uuPsVhddyy
 oyu+x/EU/+Xg0vN3WBaHQwKFwjOYaxB9yvLKu9mdqo6UqXRXMFnQB/1X0U20WeCyVLZY /Q== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m7k2trrqa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Dec 2022 18:36:02 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2B2Ia1Xm008274
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 2 Dec 2022 18:36:01 GMT
Received: from msinada-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 2 Dec 2022 10:36:00 -0800
From:   Muna Sinada <quic_msinada@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Muna Sinada <quic_msinada@quicinc.com>
Subject: [RFC 0/4] Static RU Puncturing
Date:   Fri, 2 Dec 2022 10:35:50 -0800
Message-ID: <1670006154-6092-1-git-send-email-quic_msinada@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: LdgIWMaNKra_Vy_eVfJMR7rFhF6B-hLz
X-Proofpoint-ORIG-GUID: LdgIWMaNKra_Vy_eVfJMR7rFhF6B-hLz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-02_11,2022-12-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 spamscore=0 suspectscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 mlxlogscore=250
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212020148
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add Static RU Puncturing feature for AP mode. This patchset is dependent on
the following RFC:
        https://patchwork.kernel.org/project/linux-wireless/patch/20220325140859.e48bf244f157.I3547481d49f958389f59dfeba3fcc75e72b0aa6e@changeid/

This feature has been tested

Aloka Dixit (3):
  wifi: nl80211: advertise RU puncturing support to userspace
  wifi: cfg80211: RU puncturing bitmap
  wifi: nl80211: validate RU puncturing bitmap

Muna Sinada (1):
  wifi: mac80211: Handle RU Puncturing information

 include/net/cfg80211.h       | 22 +++++++++++++++++
 include/uapi/linux/nl80211.h | 35 ++++++++++++++++++++++++++
 net/mac80211/cfg.c           |  8 ++++++
 net/mac80211/chan.c          | 14 +++++++++--
 net/wireless/core.c          |  4 +++
 net/wireless/nl80211.c       | 59 ++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 140 insertions(+), 2 deletions(-)

-- 
2.7.4

