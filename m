Return-Path: <linux-wireless+bounces-17825-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A87DBA18DD2
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Jan 2025 09:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC2177A52F5
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Jan 2025 08:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF8F153824;
	Wed, 22 Jan 2025 08:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DwwyfIoA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD2420F082
	for <linux-wireless@vger.kernel.org>; Wed, 22 Jan 2025 08:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737535713; cv=none; b=ZSPypZk0i02IwbiKhdstOMYcMnN/Dz6BirIfuDfxQcQedLXmwG9Sl7uXAwK6AyxEQ5uuRp+oXrZMbMZrcPNtvqXlNTOrBcAJOVpG4eUscRwcyRvY3gl/b2exutlkiX12Grpyu4tO1JYJYR8PjZFSkkogd5CcjiGfiDC1i5z+oQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737535713; c=relaxed/simple;
	bh=acHJtgLd2sImWZsqyJ3d16UYiI/taSFKMGHQvu8uecQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rtXQsuYxSHKBWHzX2CX6Vras8lIYFiycGcKz1XF++E8G/9N/XopsWKRh8zvFwWI8V2HEKSRz4oQf3ZtnN40BzppRQUX+9xA6ibiricXHcLfi5hH07apYNDy+PMph2rNZmxuDd8Fzrnmj3Jil3tmGsP1praJlUacEnwxpbD3BDM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DwwyfIoA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50M4XvGe029827;
	Wed, 22 Jan 2025 08:48:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=5oLtSJOxxB/cCS7EBavWs5
	m3edIgGaP2xff8r9TH7F0=; b=DwwyfIoALryuh6jM7lmteUKG0LbdKL2TKGJyZJ
	OZWhU0F9Dx8en6TtPZi3QpypbqESry18FbcCyvjkyNJKwhcQ6hAYHrfjFhk1woq5
	/jVhXI4y4VWZxXZLLyhgHdMQYz+1mSY/Q4HwXUsH5M/ytXxgwKms9oUd4v5lBSJR
	S1n84KfYUwP4f7BUEME51IoEZ08oxQZ2+PIHHudZ6Ca0C2/bD8aZ2pNvCnCY12Q+
	CszvcygSPsvAlE+/hg109sPtz+hoSDDy+qpV6K0UalpI8GK6kwE+0ujpjzIW2VRQ
	lmFbFpGyuXvuLuPkeAu72A6N1BtPU0HVL4c4uix3rjil1URw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44asrnrjb3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 08:48:26 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50M8mPqR015821
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 08:48:25 GMT
Received: from Z2-SFF-G9-MQ.ap.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 22 Jan 2025 00:48:23 -0800
From: Miaoqing Pan <quic_miaoqing@quicinc.com>
To: <kvalo@kernel.org>, <quic_jjohnson@quicinc.com>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        "Miaoqing
 Pan" <quic_miaoqing@quicinc.com>
Subject: [PATCH v2] wifi: ath12k: fix memory leak in ath12k_pci_remove()
Date: Wed, 22 Jan 2025 16:47:56 +0800
Message-ID: <20250122084756.817548-1-quic_miaoqing@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SShnQvHfD6t-ijXIALJCF2UcDqtk4kz6
X-Proofpoint-ORIG-GUID: SShnQvHfD6t-ijXIALJCF2UcDqtk4kz6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_03,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0 mlxscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1011 adultscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501220062

Kmemleak reported this error:

  unreferenced object 0xffff1c165cec3060 (size 32):
    comm "insmod", pid 560, jiffies 4296964570 (age 235.596s)
    backtrace:
      [<000000005434db68>] __kmem_cache_alloc_node+0x1f4/0x2c0
      [<000000001203b155>] kmalloc_trace+0x40/0x88
      [<0000000028adc9c8>] _request_firmware+0xb8/0x608
      [<00000000cad1aef7>] firmware_request_nowarn+0x50/0x80
      [<000000005011a682>] local_pci_probe+0x48/0xd0
      [<00000000077cd295>] pci_device_probe+0xb4/0x200
      [<0000000087184c94>] really_probe+0x150/0x2c0

The firmware memory was allocated in ath12k_pci_probe(), but not
freed in ath12k_pci_remove() in case ATH12K_FLAG_QMI_FAIL bit is
set. So call ath12k_fw_unmap() to free the memory.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.2.0-02280-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1

Signed-off-by: Miaoqing Pan <quic_miaoqing@quicinc.com>
---
v2: rebased as Jeff required
---
 drivers/net/wireless/ath/ath12k/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index 06cff3849ab8..7a30abda22cd 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -1725,6 +1725,7 @@ static void ath12k_pci_remove(struct pci_dev *pdev)
 	if (test_bit(ATH12K_FLAG_QMI_FAIL, &ab->dev_flags)) {
 		ath12k_pci_power_down(ab, false);
 		ath12k_qmi_deinit_service(ab);
+		ath12k_fw_unmap(ab);
 		ath12k_core_hw_group_unassign(ab);
 		goto qmi_fail;
 	}
-- 
2.25.1


