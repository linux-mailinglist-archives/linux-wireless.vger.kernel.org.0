Return-Path: <linux-wireless+bounces-22226-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C01AA420C
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 06:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E55951B666FE
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 04:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C2E1C8611;
	Wed, 30 Apr 2025 04:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="peKPTdr0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521B57405A;
	Wed, 30 Apr 2025 04:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745988986; cv=none; b=KNDeLJYVtUe+q9ZCPMamu4MsC4uuhLJzuNWl8FszTlt2l79iLmm46tE4Gy4vPFtGfnTxNXVcksxVJahe9rBc1v55NxarmX8zpZHuzD93PN0pGTTAqDS/AFoO8vb818MYvlNtkgr7yhjH4KSeJFtL+Pv33t0IcQx+/tsGDsVBQiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745988986; c=relaxed/simple;
	bh=2WN5UivIV0HPsCOboTk/YLB2hjQ7WLv1xRihiCGh/uE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=OKs8ZIgXAn8knxeCfyjVvpYzIgltZJgCU6phzF6ORozWMOTNIFJFQrdqEVwhXPiMpuqN4V2QApJ5QmSxL2qJcvJj+CVT8q9/Ez7KhdLycR0XYBRxZSMjWCJw3T3GFoo65VeXc1esdr9F9wim2TxtNt5TNYLm/aqpPvcvV+MxwI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=peKPTdr0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53TLao2p000482;
	Wed, 30 Apr 2025 04:56:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=GfWT2ob87oaBiZjoFpLKYD
	EFBhLPBILsPWBHPcZgMKc=; b=peKPTdr0EEdLBpnYsupOb/mwCz3Zadzd4fXDlC
	y1i3WxY/R1Lf5x3smNuoVvfbmJO/LXkmZzTkvDGaAUCQhl6yQnonBWPVRlozB1Pm
	UW6PMEuMdWJMgLy+yqOSNagVUDzZ3cZ+E6oyMfyDkYjhVTIgKjKYI2rrZkZvFbc2
	WrFDOXXmXGczmrESYi2Su+HXEin17a+YOis++d8dTo/S0B/QV72gm14XMriRKaDs
	/vEUaxb8yPNgFr/jeQieXW2QcMmzHWpMvgn4qUZdhAUPWfmeO4AkLHEhJ8yjfFbd
	xyHAE4NGWTpzsGSCDWs1nK4Y6or28mdpqKo+YuzDyuiGATMQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46b6u70u2m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Apr 2025 04:56:20 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53U4uJgc012019
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Apr 2025 04:56:19 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 29 Apr 2025 21:56:17 -0700
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Date: Wed, 30 Apr 2025 10:25:38 +0530
Subject: [PATCH ath-next] wifi: ath12k: fix memory leak in
 ath12k_service_ready_ext_event
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250430-wmi-mem-leak-v1-1-fcc9b49c2ddc@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAEmtEWgC/x3MQQqDMBBG4avIrDsQTW3RqxQXMf7RoU2URKwg3
 t3g8lu8d1BCFCRqi4MiNkkyh4zyUZCdTBjBMmRTpapaPbXivxf28PyD+fJLN868e1jXW8rJEuF
 kv3cfMuvEAftK3XleJY15H2gAAAA=
X-Change-ID: 20250430-wmi-mem-leak-639fa7becfbc
To: Jeff Johnson <jjohnson@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Rajat Soni <quic_rajson@quicinc.com>,
        "Raj
 Kumar Bhagat" <quic_rajkbhag@quicinc.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDMwMDAzMiBTYWx0ZWRfX7HQlpWbUGL87 36XGdsaJ1TvaEON5Ks407OUTOXY5sbFAgcgj7+uaGfaPP3FE1Y61uBkluRtm0wQi0h3UZnPZvP2 ciOtpN8kjRvoH6mqs5T8VvRtA9Ab/iwfEm3lL1ldW2lyIXrye9L0/ot4Uy5iDTfceCToV7zviRJ
 f3icsnaYn9STrr2dmKLR57vt7WtOFFFsOPP05U/yffxq4S1e6xmUX4b1C1XSH6jDf8iNmsCD1V3 EvPsmKmD1dgcLWyVLVahnx/0l90nDoKsl/U0rguDPXaXXvInCDIP71eTh+rS1AOeYbbVcHcYzae ySAxLxgPGRNlEuCfKkhGbgXq2DUCh/CWwjXCXv8/ExQvJcLx4w6UxQX1tTrjvq6Lcnr7cC79ty9
 pq/3rY4oJ1KV3weFXM6Q/qISMkxgEkybZ1Q1JJD5v8DZ6l2ucFiS9Jkrf5w99do3BgiiYnV8
X-Proofpoint-GUID: 3dPGE6YOWR9ErMDrazDH-nrGWe10qeev
X-Authority-Analysis: v=2.4 cv=W404VQWk c=1 sm=1 tr=0 ts=6811ad74 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=R0VpaglY2llq_AbDoOAA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 3dPGE6YOWR9ErMDrazDH-nrGWe10qeev
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-30_01,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 bulkscore=0 spamscore=0
 clxscore=1015 phishscore=0 impostorscore=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504300032

From: Rajat Soni <quic_rajson@quicinc.com>

Currently, in ath12k_service_ready_ext_event(), svc_rdy_ext.mac_phy_caps
is not freed in the failure case, causing a memory leak. The following
trace is observed in kmemleak:

unreferenced object 0xffff8b3eb5789c00 (size 1024):
 comm "softirq", pid 0, jiffies 4294942577
 hex dump (first 32 bytes):
   00 00 00 00 01 00 00 00 00 00 00 00 7b 00 00 10  ............{...
   01 00 00 00 00 00 00 00 01 00 00 00 1f 38 00 00  .............8..
 backtrace (crc 44e1c357):
   __kmalloc_noprof+0x30b/0x410
   ath12k_wmi_mac_phy_caps_parse+0x84/0x100 [ath12k]
   ath12k_wmi_tlv_iter+0x5e/0x140 [ath12k]
   ath12k_wmi_svc_rdy_ext_parse+0x308/0x4c0 [ath12k]
   ath12k_wmi_tlv_iter+0x5e/0x140 [ath12k]
   ath12k_service_ready_ext_event.isra.0+0x44/0xd0 [ath12k]
   ath12k_wmi_op_rx+0x2eb/0xd70 [ath12k]
   ath12k_htc_rx_completion_handler+0x1f4/0x330 [ath12k]
   ath12k_ce_recv_process_cb+0x218/0x300 [ath12k]
   ath12k_pci_ce_workqueue+0x1b/0x30 [ath12k]
   process_one_work+0x219/0x680
   bh_worker+0x198/0x1f0
   tasklet_action+0x13/0x30
   handle_softirqs+0xca/0x460
   __irq_exit_rcu+0xbe/0x110
   irq_exit_rcu+0x9/0x30

Free svc_rdy_ext.mac_phy_caps in the error case to fix this memory leak.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Signed-off-by: Rajat Soni <quic_rajson@quicinc.com>
Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index ea303dca38b51f98399079cd3ac06a48fd9cc025..460837f61894b05b1356d3dfdecfbf7b06f8a3e6 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -4733,6 +4733,7 @@ static int ath12k_service_ready_ext_event(struct ath12k_base *ab,
 	return 0;
 
 err:
+	kfree(svc_rdy_ext.mac_phy_caps);
 	ath12k_wmi_free_dbring_caps(ab);
 	return ret;
 }

---
base-commit: 21346cd925c2567d5f56cdb1421c94815ac10221
change-id: 20250430-wmi-mem-leak-639fa7becfbc


