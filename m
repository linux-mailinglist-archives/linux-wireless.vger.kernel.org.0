Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB88675BE14
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jul 2023 07:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjGUF7U (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Jul 2023 01:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjGUF7S (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Jul 2023 01:59:18 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9500DE65
        for <linux-wireless@vger.kernel.org>; Thu, 20 Jul 2023 22:59:17 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36L4Hite030001;
        Fri, 21 Jul 2023 05:59:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=RXYK7uYTPYx3uYtbgrMZErzAz6eAMS2Xr9OkenEW2gI=;
 b=LLFT9rT8KSJ5QK/uxyFWzOWwCP0UpcLetNnHnDE41Z05vcSK6YWaJ/757KF+WaE/SnLV
 uE6yE1A6vC33kBG1j/DYDv7u1RdJ6G4Cj6GrOjtjDHqTmgYVAXIvx4eAFgGmtRq2sV1t
 Wu3mONVoMDZGZ/02wtoR7bLzPS8zU9KDD+1mi82dE0otHPZgBLkvgmoZydV3sj9hAXbJ
 XQPb/PAo6gkKb5va1ko0ttJcIvlWfaYHqiymxZ3bvOyXEcWLi19Bkcs9I//Nz2TO+5m+
 Ni4bBHOOe2QDDMPAQ7kNaUbnB6VgdrUazOyUBLikiAY2P8LPakYHexgZ7Ci4eOZ6b5lO qQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rxup4k69a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 05:59:11 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36L5x9vI005316
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 05:59:09 GMT
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 20 Jul 2023 22:59:07 -0700
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <johannes@sipsolutions.net>, <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH] wifi: mac80211: avoid buffer overflow by adding clear data of VHT Tx power envelope
Date:   Fri, 21 Jul 2023 01:58:51 -0400
Message-ID: <20230721055851.20525-1-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 03civB66477Hzs-zqCBEpgcFMi7N7fEr
X-Proofpoint-ORIG-GUID: 03civB66477Hzs-zqCBEpgcFMi7N7fEr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-21_02,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 adultscore=0 mlxlogscore=999 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 mlxscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307210053
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

While connecting to a 6 GHz AP, the tx_pwr_env_num of struct
ieee80211_bss_conf is increased (e.g. from 0 to 1) in function
ieee80211_prep_channel().

when AP send authentication with status which is not 0 to station, then
the connection failed here, and the tx_pwr_env_num is not reset to 0,
because it is only reset to 0 in ieee80211_set_disassoc() which will not
entered for this fail. Then connect to AP again and hit same fail again,
the tx_pwr_env_num will increased again and become to 2, then it is an
invalid number because it should be 1.

When connect-fail again and again, finally it will exceed the max length
tx_pwr_env[] in struct ieee80211_bss_conf, when driver use the value of
tx_pwr_env_num to run loop to access the tx_pwr_env[], then overflow
happened here.

There are many steps while connecting to AP for station, and any one step
failure will lead connect failure, so it is hard to do reset the value of
tx_pwr_env_num for each failure case.

And the next connection maybe change to NON-6G Hz and NON-11AX-HE AP after
connection failure with 6 GHz AP, then the check of flag is_6ghz and flag
of IEEE80211_CONN_DISABLE_HE will not matched in ieee80211_prep_channel().

Hence change to assign value of tx_pwr_env_num each time in function
ieee80211_prep_channel(), then the tx_pwr_env_num will be 1 when the next
AP is still 6 GHz AP, and it will be 0 for NON-6 GHz AP , and then it
will be always avoid buffer overflow and invalid value of tx_pwr_env_num.

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
 net/mac80211/mlme.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 959695ed7649..d8ca7f18028e 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -4712,6 +4712,7 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 	int ret;
 	u32 i;
 	bool have_80mhz;
+	u8 j = 0;
 
 	rcu_read_lock();
 
@@ -4789,10 +4790,7 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 		he_oper = elems->he_operation;
 
 		if (link && is_6ghz) {
-			struct ieee80211_bss_conf *bss_conf;
-			u8 j = 0;
-
-			bss_conf = link->conf;
+			struct ieee80211_bss_conf *bss_conf = link->conf;;
 
 			if (elems->pwr_constr_elem)
 				bss_conf->pwr_reduction = *elems->pwr_constr_elem;
@@ -4805,7 +4803,6 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 				    sizeof(bss_conf->tx_pwr_env[j]))
 					continue;
 
-				bss_conf->tx_pwr_env_num++;
 				memcpy(&bss_conf->tx_pwr_env[j], elems->tx_pwr_env[i],
 				       elems->tx_pwr_env_len[i]);
 				j++;
@@ -4818,6 +4815,8 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 				       IEEE80211_CONN_DISABLE_EHT;
 	}
 
+	link->conf->tx_pwr_env_num = j;
+
 	/*
 	 * EHT requires HE to be supported as well. Specifically for 6 GHz
 	 * channels, the operation channel information can only be deduced from

base-commit: b21fe5be53eb873c02e7479372726c8aeed171e3
-- 
2.40.1

