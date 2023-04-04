Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912326D591C
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Apr 2023 09:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233735AbjDDHD4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 Apr 2023 03:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233736AbjDDHDx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 Apr 2023 03:03:53 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8D72111
        for <linux-wireless@vger.kernel.org>; Tue,  4 Apr 2023 00:03:47 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3343f5KD003701;
        Tue, 4 Apr 2023 07:03:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=CBBZh09oTGHfVb8tpDv1GwxJVAWNiumsiH5/PfbSkME=;
 b=hTnJTe6tCOpUZLHolujecp4UyIItX3WJCVwS+nnM+K409e7WLk2qaSbJxfvePbdEFYJ1
 A45vzSt9mtgVKDzSxADVVX+2GVc3wq94yJ5f6RtzVx6/dvHU7MV+ZsMM1nmWlltkGYZY
 sTsDU8vDE67CagJoR6s9SODPfNTOeheibLfeQc5YwT+ANzOf5YCDvziHCKIugY6xvJeJ
 TN0adUEo1ASOGYYS6sIBicqebsGVT43Qqyiq9DXWAWazK/O28DkVHdmAOcGnhhgCEyHM
 cBnwaHAr62x3qlzEchdLWRrVe/3CpQ8xOdC0/AWUXFzyfjal3KwKDELvnE0FCrJ3jvK9 jw== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pqus5as0e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Apr 2023 07:03:41 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33473eve029274
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 4 Apr 2023 07:03:40 GMT
Received: from cjhuang2-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 4 Apr 2023 00:03:32 -0700
From:   Carl Huang <quic_cjhuang@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_cjhuang@quicinc.com>
Subject: [PATCH] wifi: ath12k: send WMI_PEER_REORDER_QUEUE_SETUP_CMDID when ADDBA session starts
Date:   Tue, 4 Apr 2023 15:01:58 +0800
Message-ID: <20230404070158.3368530-1-quic_cjhuang@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ypQx7rDNufousbgwl2RU1vPbxRC1PC-c
X-Proofpoint-GUID: ypQx7rDNufousbgwl2RU1vPbxRC1PC-c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_19,2023-04-03_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=963
 adultscore=0 impostorscore=0 mlxscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304040064
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Low receive throughput is seen on WCN7850 because ADDBA related
parameters are not updated to firmware when receive ADDBA session starts.

Fix it by sending WMI_PEER_REORDER_QUEUE_SETUP_CMDID again to firmware
to update the ADDBA related parameters for chips which have false
reoq_lut_support in hw_params. For chips which have true reoq_lut_support
in hw_params don't need this command to send to firmware.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Carl Huang <quic_cjhuang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_rx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index e78478a5b978..256e4cbfae54 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -977,6 +977,9 @@ int ath12k_dp_rx_peer_tid_setup(struct ath12k *ar, const u8 *peer_mac, int vdev_
 			ath12k_warn(ab, "failed to update reo for rx tid %d\n", tid);
 			return ret;
 		}
+		if (!ab->hw_params->reoq_lut_support)
+			ret = ath12k_wmi_peer_rx_reorder_queue_setup(ar, vdev_id, peer_mac,
+								     paddr, tid, 1, ba_win_sz);
 
 		return ret;
 	}

base-commit: bea046575a2e6d7d1cf63cc7ab032647a3585de5
-- 
2.25.1

