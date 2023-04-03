Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69E16D503E
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Apr 2023 20:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbjDCSZD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Apr 2023 14:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233101AbjDCSY4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Apr 2023 14:24:56 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB5D170A
        for <linux-wireless@vger.kernel.org>; Mon,  3 Apr 2023 11:24:40 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 333CpfKB027040;
        Mon, 3 Apr 2023 18:24:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=mQuo5gZYMZ53IJaHn39A+7pE35b8Ceybxka+rvsmmSA=;
 b=dXWjewmc+mHoIjSa24GNP7LAXS7wLTDNy9hSfXmN7NHuNhvAmDiQnrYigRZPbnw6bqgU
 VZguyqjKdeR7QMLdCXzr5D9UZo0mzndIODXxl7PLN+8MJtOlgWlsqtYuKHeHmiuNhpUE
 /Yo0ZvlOmYZX6QWtGD1Oyvn/Q3pn4s0Jf+kvR7PN1v6FjGjnzTfqP9UR64EiZsoPg/ID
 wUDiCeGsss/dea8zfLsHmuHcwFehU8fzKtejU9j4JhPBMjQDNH5l43Bxvq9p1RDGNX18
 OxmtYaaDnsSUxl6+LF0Ect0hAJGrm3j69sYn6MfIJrv/0cxWRFZw1nNzy90SJrkGO90q mA== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pqy620uas-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Apr 2023 18:24:26 +0000
Received: from pps.filterd (NASANPPMTA05.qualcomm.com [127.0.0.1])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 333ILB7s028556;
        Mon, 3 Apr 2023 18:24:25 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NASANPPMTA05.qualcomm.com (PPS) with ESMTP id 3pr3e7red9-1;
        Mon, 03 Apr 2023 18:24:25 +0000
Received: from NASANPPMTA05.qualcomm.com (NASANPPMTA05.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 333IOP4E001872;
        Mon, 3 Apr 2023 18:24:25 GMT
Received: from hprem-linux.qualcomm.com (hprem-linux.qualcomm.com [10.201.162.248])
        by NASANPPMTA05.qualcomm.com (PPS) with ESMTP id 333IOOwM001504;
        Mon, 03 Apr 2023 18:24:25 +0000
Received: by hprem-linux.qualcomm.com (Postfix, from userid 4146166)
        id 3DA7AB003D4; Mon,  3 Apr 2023 23:54:23 +0530 (IST)
From:   Harshitha Prem <quic_hprem@quicinc.com>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Harshitha Prem <quic_hprem@quicinc.com>
Subject: [PATCH 0/3] wifi: ath11k: fix double free of peer rx_tid
Date:   Mon,  3 Apr 2023 23:54:17 +0530
Message-Id: <20230403182420.23375-1-quic_hprem@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9jr4brrW-CzCLBb4HJHwdBR0OlcoIuLA
X-Proofpoint-ORIG-GUID: 9jr4brrW-CzCLBb4HJHwdBR0OlcoIuLA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_15,2023-04-03_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_spam policy=outbound score=67 priorityscore=1501
 suspectscore=0 bulkscore=0 mlxlogscore=-30 phishscore=0 mlxscore=67
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 spamscore=67 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304030141
X-Spam-Status: No, score=-0.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

During stability testing, double free crash was seen while handling
reo flush command. To handle the same, this patch series includes
changes to address the double free and to avoid the issue case

Harshitha Prem (3):
  wifi: ath11k: fix double free of peer rx_tid during reo cmd failure
  wifi: ath11k: Prevent REO cmd failures
  wifi: ath11k: add peer mac information in failure cases

 drivers/net/wireless/ath/ath11k/dp.h    |  2 +-
 drivers/net/wireless/ath/ath11k/dp_rx.c | 59 +++++++++++++++++--------
 drivers/net/wireless/ath/ath11k/hw.c    |  1 +
 3 files changed, 43 insertions(+), 19 deletions(-)


base-commit: bea046575a2e6d7d1cf63cc7ab032647a3585de5
-- 
2.17.1

