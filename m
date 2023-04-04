Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFAE06D5724
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Apr 2023 05:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbjDDDVU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Apr 2023 23:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233037AbjDDDVS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Apr 2023 23:21:18 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF28C2
        for <linux-wireless@vger.kernel.org>; Mon,  3 Apr 2023 20:21:17 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 333NIYo0005679;
        Tue, 4 Apr 2023 03:21:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=xFXk0PO49uNW17VJGC4G3LYuRBd+dH8EabkpKTjEv6s=;
 b=juPnyUXifPsavj/qNCnqDXt4fTo1J6IeHH9SmS/6vYDsh3qGgxzcPwDnAuoKPfimwR4b
 YV7WAar7erV9lv9L0LnCjAC+Idv4XqBsMSwzPnP5xJsIOa66+EE2LT/Eub6DZVNulIdi
 52/gJNRxLVXK9mRuaehe1tIwfE891+nGprPppzGEUue1zsKyFmVx5JVAx48tojLecnYv
 6Vp0L/cU8BOSmYuwxYQ+0BijCS+p3xj1nAqKhEj0BSp1ldkDnHa1GDrSAs1gW9ZU2dCb
 P1wYlxMR/hFyFe7jHhaeZocheO+NH2Aqb7VBvliy45QNIpBFjG3Gf8H6f9e248N1/EsG bw== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pqtdnaj3b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Apr 2023 03:21:14 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3343LDcJ003477
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 4 Apr 2023 03:21:13 GMT
Received: from cjhuang2-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 3 Apr 2023 20:21:11 -0700
From:   Carl Huang <quic_cjhuang@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_cjhuang@quicinc.com>
Subject: [PATCH 0/2] wifi: ath12k: Not pull PCIe PERST pin for WCN7850
Date:   Tue, 4 Apr 2023 11:20:55 +0800
Message-ID: <20230404032057.3236122-1-quic_cjhuang@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: CuzECA5mQvQE3Mgckhyq_b1JzDzYh24i
X-Proofpoint-GUID: CuzECA5mQvQE3Mgckhyq_b1JzDzYh24i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_19,2023-04-03_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 mlxscore=0 mlxlogscore=623 lowpriorityscore=0 spamscore=0 malwarescore=0
 adultscore=0 bulkscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304040029
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Notify WCN7850 firmware not to pull PCIe PERST pin so WCN7850 hardware
consumes less power.   

Carl Huang (2):
  wifi: ath12k: add qmi_cnss_feature_bitmap field to hardware parameters
  wifi: ath12k: set PERST pin no pull request for WCN7850

 drivers/net/wireless/ath/ath12k/hw.c  | 6 ++++++
 drivers/net/wireless/ath/ath12k/hw.h  | 2 ++
 drivers/net/wireless/ath/ath12k/qmi.c | 6 ++++--
 drivers/net/wireless/ath/ath12k/qmi.h | 1 +
 4 files changed, 13 insertions(+), 2 deletions(-)


base-commit: bea046575a2e6d7d1cf63cc7ab032647a3585de5
-- 
2.25.1

