Return-Path: <linux-wireless+bounces-6373-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C678A659D
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 10:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7CC91C20A46
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 08:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED7E75808;
	Tue, 16 Apr 2024 08:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="M4RACqsL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160DC82C8E
	for <linux-wireless@vger.kernel.org>; Tue, 16 Apr 2024 08:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713254600; cv=none; b=JyOv2kyNhW/Owk0W/e7qQPrMG77zk9l1GhceO3mPyMltmHYXkyh6fwAFKhr35EAZVq5zc3SCJbSn1qhhCDk0TgcWgjIDbwrsAlu8UfOrZke/JUpYMv/MLGN7GMX+4r2uMAI16euoMt6RIhSer8u8nOgf8k5YjpwL2xuvJJBsbno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713254600; c=relaxed/simple;
	bh=cEj9X7zdDCFwwTHwnLWkQeUp6EbgH8ciilBhTr75qMA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jvxqcSLJsxO3IsO5K4YEAlLoO7Sv2DgJyDeUeMaAGoWOVuA0ByBh/ut1jpznOv3BQ1HvNZGiVj0aYzJhK8QUCRTtADI43Fg7ndC1RZWWN3Xzsz9xSYkaJle9mp8jpZCrpeHoK5DgXYarXIdlWO+Yc30mudcru+xTgurV5Pzu2lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=M4RACqsL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43G7BceI014290;
	Tue, 16 Apr 2024 08:03:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=DZTdgCW
	1UKXQk4uiSGZ3i/K/Qero0bkVNwDoyB5Qjts=; b=M4RACqsLkBZqWmv5SR0Evow
	v+K8LAp7DWZfMQnOLq7PpmV2I3B6k5bIodqNmX57FMoA39FEysYZV6ENXtn1qOtt
	Zi6b8m0UXyATh9no9LpGX6YHS1JUqE3WAjgNHxCcTQnYVLNc7vIfAhWTic1E/Uw9
	HMEHX4w063+l/wgG/QrPCcCxPzCx40GSzco18yeHHGcstIqVtH3pBJTOl37kLwZn
	OZQth/vEoLCiieEX300znsnR2PKgvzCepp1EemhCSqmrBhmSkISO8l6IqmxIRKv+
	kj9W5NblXvgBTA1eFwHur55z6EsGyay7t1uVPjl9ivklBBeXlJrxPDbjUgBjSkA=
	=
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xhmqcg861-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 08:03:00 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43G82xDj019301
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 08:02:59 GMT
Received: from hu-kathirve-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 16 Apr 2024 01:02:57 -0700
From: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Kathirvel
	<quic_kathirve@quicinc.com>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: [PATCH v2] wifi: ath12k: fix out-of-bound access of qmi_invoke_handler()
Date: Tue, 16 Apr 2024 13:32:34 +0530
Message-ID: <20240416080234.2882725-1-quic_kathirve@quicinc.com>
X-Mailer: git-send-email 2.34.1
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
X-Proofpoint-GUID: C-3x-stD6uvGqDh41IoB7jAXGy1i1GiE
X-Proofpoint-ORIG-GUID: C-3x-stD6uvGqDh41IoB7jAXGy1i1GiE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_04,2024-04-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 mlxscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404160048

Currently, there is no terminator entry for ath12k_qmi_msg_handlers hence
facing below KASAN warning,

 ==================================================================
 BUG: KASAN: global-out-of-bounds in qmi_invoke_handler+0xa4/0x148
 Read of size 8 at addr ffffffd00a6428d8 by task kworker/u8:2/1273

 CPU: 0 PID: 1273 Comm: kworker/u8:2 Not tainted 5.4.213 #0
 Workqueue: qmi_msg_handler qmi_data_ready_work
 Call trace:
  dump_backtrace+0x0/0x20c
  show_stack+0x14/0x1c
  dump_stack+0xe0/0x138
  print_address_description.isra.5+0x30/0x330
  __kasan_report+0x16c/0x1bc
  kasan_report+0xc/0x14
  __asan_load8+0xa8/0xb0
  qmi_invoke_handler+0xa4/0x148
  qmi_handle_message+0x18c/0x1bc
  qmi_data_ready_work+0x4ec/0x528
  process_one_work+0x2c0/0x440
  worker_thread+0x324/0x4b8
  kthread+0x210/0x228
  ret_from_fork+0x10/0x18

 The address belongs to the variable:
  ath12k_mac_mon_status_filter_default+0x4bd8/0xfffffffffffe2300 [ath12k]
 [...]
 ==================================================================

Add a dummy terminator entry at the end to assist the qmi_invoke_handler()
in traversing up to the terminator entry without accessing an
out-of-boundary index.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
---
v2:
	Added Tested-on tag and wifi prefix
---
 drivers/net/wireless/ath/ath12k/qmi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index db8ba5fec2ae..b837639e54f8 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -3180,6 +3180,9 @@ static const struct qmi_msg_handler ath12k_qmi_msg_handlers[] = {
 		.decoded_size = sizeof(struct qmi_wlanfw_fw_ready_ind_msg_v01),
 		.fn = ath12k_qmi_msg_fw_ready_cb,
 	},
+
+	/* end of list */
+	{},
 };
 
 static int ath12k_qmi_ops_new_server(struct qmi_handle *qmi_hdl,

base-commit: 363e7193eaf258fe7f04e8db560bd8a282a12cd9
-- 
2.34.1


