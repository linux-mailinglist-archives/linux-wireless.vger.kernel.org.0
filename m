Return-Path: <linux-wireless+bounces-15226-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B122E9C66F1
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2024 02:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 418441F23714
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2024 01:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9127080E;
	Wed, 13 Nov 2024 01:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QlDE17yK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847C42BB04
	for <linux-wireless@vger.kernel.org>; Wed, 13 Nov 2024 01:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731463010; cv=none; b=QdrtS2CQXpBTc+BnnA+W77LUkLJmUuupldRnzFFX+dgzQv/nHChaZUj/n2dIm8rRHu6BTKT9RY6paeOOD7s3XyZ3VsW7ZTHzcn3qdYPsqY8+4aZWg3REMZ6KuwQZbFpTyDM5t587BWxOVS97iSPWC8ZUF/luOvF/5IofYvpto6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731463010; c=relaxed/simple;
	bh=jl7ZtQcJqfDz/k9RWu1YF7D5dbAeWGLKZJ3UUTArqx0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uXZR43rdi2/164XMv55SqkqEpjNNJNPFDZo+FwlH5/xnJ15DVxSMEtZPXzEDwfzSTsR6nLqn7+RVhteCxCtePGRB0cG/9iBTbW8ZtauRrCkzXZmhYapSdjil5iZFUigRFSHhCjBTeaVrq45/JFVEl549Pyx0SbwLu9hrTYl2f6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QlDE17yK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACMSbEw008626;
	Wed, 13 Nov 2024 01:56:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	X3cmzogBfryPTor0SMPQKGdcaeAJEG4sRUgVUCxDqto=; b=QlDE17yKIfqUOUsZ
	0cpVkJqfNN4XqRCxsWQ8WhTgtpxY4Rz/vXfHLw3CrRSiB3maAZLvVIik9TPbHwpH
	9cbGOikv3bHMudSzW+DWsxxCemo7qvKTHSkztzJ5he7aZTOsaJeMUG+SXCmWQqIf
	Rclzyg++Lu3Z2/ReVPKirmIaU7GSEYXfQr6ujwgWt4bpQsDX8SF6RNsUeekXYHBU
	Mpf0Sixxu/wWeJm4j0vI5Nopta3vy4K50loehDck+PrC/lz9AJh1DMvLOtIEN6rV
	4tLnHThVpmnExyCCelHq9/sOBz6vYYZb8XiPcq4tEKyLycxD+4EXJkNx0DqKSfu/
	tjajHg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42sxpqh9th-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 01:56:45 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AD1ui9O020767
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 01:56:44 GMT
Received: from bqiang-SFF.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 12 Nov 2024 17:56:43 -0800
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>
Subject: [PATCH 1/6] wifi: ath11k: avoid burning CPU in ath11k_debugfs_fw_stats_request()
Date: Wed, 13 Nov 2024 09:56:26 +0800
Message-ID: <20241113015631.3105-2-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241113015631.3105-1-quic_bqiang@quicinc.com>
References: <20241113015631.3105-1-quic_bqiang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: eWA9fQduvqjgaTv7M6PDUDq0mEHyRTz7
X-Proofpoint-ORIG-GUID: eWA9fQduvqjgaTv7M6PDUDq0mEHyRTz7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxlogscore=898 phishscore=0
 suspectscore=0 impostorscore=0 mlxscore=0 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411130016

We get report [1] that CPU is running a hot loop in
ath11k_debugfs_fw_stats_request():

94.60%     0.00%  i3status         [kernel.kallsyms]                 [k] do_syscall_64
        |
         --94.60%--do_syscall_64
                   |
                    --94.55%--__sys_sendmsg
                              ___sys_sendmsg
                              ____sys_sendmsg
                              netlink_sendmsg
                              netlink_unicast
                              genl_rcv
                              netlink_rcv_skb
                              genl_rcv_msg
                              |
                               --94.55%--genl_family_rcv_msg_dumpit
                                         __netlink_dump_start
                                         netlink_dump
                                         genl_dumpit
                                         nl80211_dump_station
                                         |
                                          --94.55%--ieee80211_dump_station
                                                    sta_set_sinfo
                                                    |
                                                     --94.55%--ath11k_mac_op_sta_statistics
                                                               ath11k_debugfs_get_fw_stats
                                                               |
                                                                --94.55%--ath11k_debugfs_fw_stats_request
                                                                          |
                                                                          |--41.73%--_raw_spin_lock_bh
                                                                          |
                                                                          |--22.74%--__local_bh_enable_ip
                                                                          |
                                                                          |--9.22%--_raw_spin_unlock_bh
                                                                          |
                                                                           --6.66%--srso_alias_safe_ret

This is because, if for whatever reason ar->fw_stats_done is not set by
ath11k_update_stats_event(), ath11k_debugfs_fw_stats_request() won't yield
CPU before an up to 3s timeout.

Add 100ms sleep to avoid CPU burning.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.37

Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
Reported-by: Yury Vostrikov <mon@unformed.ru>
Closes: https://lore.kernel.org/all/7324ac7a-8b7a-42a5-aa19-de52138ff638@app.fastmail.com/ # [1]
Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/debugfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/debugfs.c b/drivers/net/wireless/ath/ath11k/debugfs.c
index 57281a135dd7..a5e0f2092da5 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs.c
+++ b/drivers/net/wireless/ath/ath11k/debugfs.c
@@ -207,6 +207,9 @@ static int ath11k_debugfs_fw_stats_request(struct ath11k *ar,
 			break;
 		}
 		spin_unlock_bh(&ar->data_lock);
+
+		/* 100ms is empirical, change if required */
+		msleep(100);
 	}
 	return 0;
 }
-- 
2.25.1


