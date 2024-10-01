Return-Path: <linux-wireless+bounces-13366-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2961698B855
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 11:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB5E31F23278
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 09:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4F119D8BB;
	Tue,  1 Oct 2024 09:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="e6tN1/vp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733CE19DF52
	for <linux-wireless@vger.kernel.org>; Tue,  1 Oct 2024 09:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727774862; cv=none; b=nbd8fAzx7QTk4OOLc1yQQVzRP5Xs7YXhbKS8j46fqDPOC+P7dPwPIHi17aRaUaQ01z1ROqGitPLeLvh7uQR5/zmsTkWQpTRzbsEXzOzM3oP4HHcTQPStW/tasDhkNzyp/W4pYAgvGJwpOD1SP0oxekdtONy8I2E5PujC39+1NSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727774862; c=relaxed/simple;
	bh=j9eZbNHNJoTpBSYNi257vpEpW7cvu76o7o3uHwGKn1o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qsYEVSuuJh/J7o8VGi7R/MPMQF9rSnMxV5yCxQpTbZK+RDebcjC/eHVLG875j+Sk1OXNQaV5wsTbNOi6XKE7hJxKZ20ACf45K/DflIcxYkUyuNtm4ly3k9/px66cUgUDBTYFGdaUfalZUHXwno847McFHGdZGf8YdudjzZjXBoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=e6tN1/vp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48UNr61p017398;
	Tue, 1 Oct 2024 09:27:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=77KAl9WNIh+ryKl/Z/b0mL
	IrSKbidlpmzl11FBr6qrQ=; b=e6tN1/vpEWaCFzMRwWRDsScHwp9/pilif5V639
	J3Gry28qGcRNqSxjBUFe1eMPgrCoNAQMurK5bcphk04pjPn6CO7y6NsmMEdUZliM
	ghyUgLWxiU1p1E63OwqTtJMHQuFNqK5SGhYLgjnNYsGLCQJVg1Tnd9UU9tccjxpN
	K/FJG+rjzVeYmZ+ovmR1kTjsM1tJ85tbohIcljLS/4+wGoi0dxCXhcj4myHG/A20
	83zbWFybemRAriajbrBUQlo5Uq3uPw9tcsKnipshRJ4lJxIba6kx9OFXvLZw42sy
	zUgLv87iJcUGgjVcUs57J03UTXGT2lbRXgsgas39dQoPb6vg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41xa12qsc5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 09:27:36 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4919RZAY028680
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 1 Oct 2024 09:27:35 GMT
Received: from hu-ramess-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 1 Oct 2024 02:27:33 -0700
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Rameshkumar Sundaram
	<quic_ramess@quicinc.com>
Subject: [PATCH v2] wifi: ath12k: fix use-after-free in ath12k_dp_cc_cleanup()
Date: Tue, 1 Oct 2024 14:56:52 +0530
Message-ID: <20241001092652.3134334-1-quic_ramess@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 4t2yKACM63F7Pda9huGAcN9LBBXPwE0C
X-Proofpoint-GUID: 4t2yKACM63F7Pda9huGAcN9LBBXPwE0C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 spamscore=0 clxscore=1015 mlxscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2410010061

During ath12k module removal, in ath12k_core_deinit(),
ath12k_mac_destroy() un-registers ah->hw from mac80211 and frees
the ah->hw as well as all the ar's in it. After this
ath12k_core_soc_destroy()-> ath12k_dp_free()-> ath12k_dp_cc_cleanup()
tries to access one of the freed ar's from pending skb.

This is because during mac destroy, driver failed to flush few
data packets, which were accessed later in ath12k_dp_cc_cleanup()
and freed, but using ar from the packet led to this use-after-free.

BUG: KASAN: use-after-free in ath12k_dp_cc_cleanup.part.0+0x5e2/0xd40 [ath12k]
Write of size 4 at addr ffff888150bd3514 by task modprobe/8926
CPU: 0 UID: 0 PID: 8926 Comm: modprobe Not tainted
6.11.0-rc2-wt-ath+ #1746
Hardware name: Intel(R) Client Systems NUC8i7HVK/NUC8i7HVB, BIOS
HNKBLi70.86A.0067.2021.0528.1339 05/28/2021

Call Trace:
  <TASK>
  dump_stack_lvl+0x7d/0xe0
  print_address_description.constprop.0+0x33/0x3a0
  print_report+0xb5/0x260
  ? kasan_addr_to_slab+0x24/0x80
  kasan_report+0xd8/0x110
  ? ath12k_dp_cc_cleanup.part.0+0x5e2/0xd40 [ath12k]
  ? ath12k_dp_cc_cleanup.part.0+0x5e2/0xd40 [ath12k]
  kasan_check_range+0xf3/0x1a0
  __kasan_check_write+0x14/0x20
  ath12k_dp_cc_cleanup.part.0+0x5e2/0xd40 [ath12k]
  ath12k_dp_free+0x178/0x420 [ath12k]
  ath12k_core_stop+0x176/0x200 [ath12k]
  ath12k_core_deinit+0x13f/0x210 [ath12k]
  ath12k_pci_remove+0xad/0x1c0 [ath12k]
  pci_device_remove+0x9b/0x1b0
  device_remove+0xbf/0x150
  device_release_driver_internal+0x3c3/0x580
  ? __kasan_check_read+0x11/0x20
  driver_detach+0xc4/0x190
  bus_remove_driver+0x130/0x2a0
  driver_unregister+0x68/0x90
  pci_unregister_driver+0x24/0x240
  ? find_module_all+0x13e/0x1e0
  ath12k_pci_exit+0x10/0x20 [ath12k]
  __do_sys_delete_module+0x32c/0x580
  ? module_flags+0x2f0/0x2f0
  ? kmem_cache_free+0xf0/0x410
  ? __fput+0x56f/0xab0
  ? __fput+0x56f/0xab0
  ? debug_smp_processor_id+0x17/0x20
  __x64_sys_delete_module+0x4f/0x70
  x64_sys_call+0x522/0x9f0
  do_syscall_64+0x64/0x130
  entry_SYSCALL_64_after_hwframe+0x4b/0x53
RIP: 0033:0x7f8182c6ac8b

Commit 24de1b7b231c ("wifi: ath12k: fix flush failure in recovery
scenarios") added the change to decrement the pending packets count
in case of recovery which make sense as ah->hw as well all
ar's in it are intact during recovery, but during core deinit there
is no use in decrementing packets count or waking up the empty waitq
as the module is going to be removed also ar's from pending skb's
can't be used and the packets should just be released back.

To fix this, avoid accessing ar from skb->cb when driver is being
unregistered.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00214-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Fixes: 24de1b7b231c ("wifi: ath12k: fix flush failure in recovery scenarios")
Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
---
v2:
 - Skipped skb accounting with UNREGISTERING flag instead of vif check.
---
 drivers/net/wireless/ath/ath12k/dp.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index ecd3b5c76d26..2ab2a7d45be9 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -1202,10 +1202,16 @@ static void ath12k_dp_cc_cleanup(struct ath12k_base *ab)
 			if (!skb)
 				continue;
 
-			skb_cb = ATH12K_SKB_CB(skb);
-			ar = skb_cb->ar;
-			if (atomic_dec_and_test(&ar->dp.num_tx_pending))
-				wake_up(&ar->dp.tx_empty_waitq);
+			/* if we are unregistering, hw would've been destroyed and
+			 * ar is no longer valid.
+			 */
+			if (!(test_bit(ATH12K_FLAG_UNREGISTERING, &ab->dev_flags))) {
+				skb_cb = ATH12K_SKB_CB(skb);
+				ar = skb_cb->ar;
+
+				if (atomic_dec_and_test(&ar->dp.num_tx_pending))
+					wake_up(&ar->dp.tx_empty_waitq);
+			}
 
 			dma_unmap_single(ab->dev, ATH12K_SKB_CB(skb)->paddr,
 					 skb->len, DMA_TO_DEVICE);

base-commit: 8ed36fe71fd60c851540839b105fd1fddc870c61
-- 
2.34.1


