Return-Path: <linux-wireless+bounces-29114-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF84C6C58C
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Nov 2025 03:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C9F91358757
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Nov 2025 02:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321571A23AC;
	Wed, 19 Nov 2025 02:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q1BOaZk5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GPyz7W2t"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDFA11713
	for <linux-wireless@vger.kernel.org>; Wed, 19 Nov 2025 02:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763518586; cv=none; b=fqgYu+Nrwq617bWMSfMRIEFxXzaFZBxJxChkBSZ5S/9rzJfcJRGzgoc9AHXAw6GWFvbgBHxhODnkR3ajginGROxLbxpvTub52j8euZ0p81lM8J5RrTPolFubCs/Y4gTBqpzCYmzjtgMeljXhPzYJn7U0bCBup35vMf+E/xW3NO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763518586; c=relaxed/simple;
	bh=6rzMD1/Xmm5ffaZRS2LhdXfY1C5LqfSV8YAHLZE0LtY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=l7G2krW4ct0jhC+w6tbN+13CzQ5e7BMbXIvn0IGSZxfKDtRlhqqz+qiHg5zXHMkOeyZv6j++MMp4z20j9OvVRT7yC7lXjN+TAI5sNpumXfef2lB6nNvr2RjkEddfgAWYTlpYC7S4WbBWaBp01uqGUhqlLZQOqIVyt8pWrLfMP80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q1BOaZk5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GPyz7W2t; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AJ0f9SU3412654
	for <linux-wireless@vger.kernel.org>; Wed, 19 Nov 2025 02:16:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=s0HIdUkI7dBen/MxX1fT/g
	Qqc/PAqY0IKPsj+Sxwa7o=; b=Q1BOaZk5qTC/E+9n5lQ8ir6JjuKuzYXHa7qH/Y
	/bEqQkbts+MmPFysvwBVsA0vDyPcqka1lmVe9ToFWLubeXZ+7mJyNavRRCxXVkIJ
	Y7qMhGLK2AzYnTHbNmtkEt4H59oct6IpKsoFrbYBpC4K7Uyj+hEnsDc08zXZOkQY
	JJEKZZDZubn23fwAktlb2QbhM/B8VYN0PGwir/J4Mrr2v3GR8v8Ygr3HKf9ZFyUz
	p3CyD9b6y6vk0Cq3S2ErDX7xdyxKU3mQ+LYylqKjXeeBUTjVNdThmKemrHk339Q+
	d5PHhKeKxP839dZ/U5Wgff0reWszI+EkuVTOc49nmBIlirJQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4agv0v1ken-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 19 Nov 2025 02:16:23 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3438b1220bcso7268223a91.2
        for <linux-wireless@vger.kernel.org>; Tue, 18 Nov 2025 18:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763518582; x=1764123382; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s0HIdUkI7dBen/MxX1fT/gQqc/PAqY0IKPsj+Sxwa7o=;
        b=GPyz7W2tAYPHEVPIu2KUOB5foz9T+ucHkKG/SpbBmol/U2hl39/SNfa7jLnq5CvK3h
         ScxpRMW9YJxdqwv7VO4BEbdSk4VlpdD7TAEIer2UsQR6HaceKLthL/qe5o+LK1eQLuE6
         +gAueOQP20XXs1TWCxxupHhIcUB5JET7x/bRv0T3M+V/B1QVhNIQChr9f+vOUGkvYymA
         rAM53f6bGD2eImR5+anuhlAQnM77XBbUzv26USMpYypK8vjSMRl0syCK/ExBRD7KS0Pf
         vrpzL4mIbq2QGbN8eW0qKfnBEmrCYXF/d398K97sH+tupt3eG5KNjDAcXDm8hdmlwZl4
         2pNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763518582; x=1764123382;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s0HIdUkI7dBen/MxX1fT/gQqc/PAqY0IKPsj+Sxwa7o=;
        b=RyDKwtGrYM+w8qqZpW/FK8mpwcPEOK2koV2RS8lUoHoOYYALtqfCppLmEvep+nlx5a
         RbzC2nVk5iCnLwhgWOFEunI3mRcaRgyYg97Com4J6ogSaaqrO2Tj74yUINh8VHqUVuu6
         Bb5gq9KnkP4OsC6a9I4G6rz/f9HBBaGeSaNB0KjtQc3x04wSo8shAS5gpAXDQAnRm8cU
         a9b6l91s1zOxZK1YRd13qkoMFay8BA5H4I5HxLbAee8p8sZ9lOXFAO11zjyOqcQ+4XAe
         qSDfwGqI9n60BG7rzY4BdaQXWSr/HK4gCCDG5ICRf04mJHkJ0X4wmv7c1ImRh8dnNx4E
         x40Q==
X-Gm-Message-State: AOJu0YxdLDgYnrTruAYuKZ3NbscMYmbRIzzwXc7ooU2DiEwHID73Wkox
	qvxkdY/punslm1W47GrfacA5E6ckmn4S1dQqK6K63ivozBsPlg34Z3DedsHqi3FgqbYqg0FWiCq
	UjE9hHu5HBgYWBbF0dTmqYMep4LL7eJ8CItFu2zxYV2K7U4ssTk6nD7HQ1hMdsjl4yhLbyg==
X-Gm-Gg: ASbGncuMsmxLavxePNv12l+9Y5GDGuL6bFezOJUKbkEKpB+UbONcBzg42r5nl+uNnNv
	wMR2unAvE2X5Vxxx3PNge5mNarBLwxibaQrbrYXqWUcOkoUbmpfeFNiEQDWsIDb+ga3MaLEnZNk
	ZBu6G5x/MdoYbWpE8g5WAUotT5ayY4oLsR2OXGpciyqbSDqy8Hco0E7w6DgMdpfxiBJ4S7wsbKe
	KjODxiP419hxMrQX72wLrQvUpbcJ24nnfO3p2vRFjfti8Ne1DsnxPixX6hFX+sr5rm6chxrDq2X
	lXL/ZNh0LFqflXTICrpExitOfNa0E3Kbkjftu3g/6ZJPZmENbDrYwCbCnIOeK+iCgkFEqOqIL79
	vr6VcYoquqjU1IHjAL1His4yw6AOtVcia7QbbhMXlNVW9cRn/sVABp+bWijYWOJM=
X-Received: by 2002:a17:90a:da8f:b0:32e:3829:a71c with SMTP id 98e67ed59e1d1-343f9ec8d4dmr23030954a91.16.1763518582189;
        Tue, 18 Nov 2025 18:16:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFjFwhJwn2q5r+kloWWxFwZrr4LwJEQHZ4nvWLiWlma7WXZYn1lYNT/jYBKDxeT2PJ1pzbFvg==
X-Received: by 2002:a17:90a:da8f:b0:32e:3829:a71c with SMTP id 98e67ed59e1d1-343f9ec8d4dmr23030923a91.16.1763518581684;
        Tue, 18 Nov 2025 18:16:21 -0800 (PST)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-345bc24f941sm799890a91.10.2025.11.18.18.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 18:16:20 -0800 (PST)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Wed, 19 Nov 2025 10:15:57 +0800
Subject: [PATCH ath12k-ng] wifi: ath12k: add the missing RCU lock in
 ath12k_dp_tx_free_txbuf()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-ath12k-fix-missing-rcu-lock-v1-1-8155de1dc4fc@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAFwoHWkC/5XNTQ7CIBAF4Ks0rJ2mg/2hrryHcYFAW9IWFFqia
 Xp3CXHpQjeTvMybbzbildPKk1O2EaeC9tqaGPCQETFw0yvQMmZCC1ohIgO+DEhH6PQTZu29Nj0
 4scJkxQgVlqxUtGKStyQKd6diL+kX8jk0PbnG1aD9Yt0r/Q2YCj+9CAgInVRlx1vatLfibL3PH
 yufhJ3nPI7EB/oHSSPZNEKWtarZEesv5L7vb2RtVlorAQAA
X-Change-ID: 20251118-ath12k-fix-missing-rcu-lock-51484e258da9
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE5MDAxNiBTYWx0ZWRfXxj6mW3e2mwkU
 Myv2CUggDkBNgy/0aJdcIUfgf7KJL6zpF+BZeszaZ7GjazoT0iUFaXiegrwIyCod7bPr5ZjIQph
 pob1zA4FHygO/OXm3oj9czAIGz1B0FsFLrziOeCDGTGOkycmlFi93I6rNCitvAGLMMNeITayMcB
 Gp6NzoX8YxtSB/dgoo7pdHx/uKoLID97mrd9hinJfXZkV2T/w4q9PMFNrEiX2O2LDfwYpKimqBq
 sDo9PH+iMf06AeWbOaRApf3FXegq98Em7a7s9ztvfiqc2h/GYaimgq6yELvZMQ600G1+SrqBQmm
 u1CebyOvSJ8N7t96Uj4eXlgrIiP6tRP3GfHBWZFR+52rd5kXv5MclSE3lC4lt4VG/6ey1A67cEw
 Knuhb0Ttza3IWHX5Lv0YiJ636onY8g==
X-Authority-Analysis: v=2.4 cv=S8XUAYsP c=1 sm=1 tr=0 ts=691d2877 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=U-W4M1hCd-K8Or1wGFwA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: SOa5jD_ClaCGHxQtOXQIbEOIh5yfCZBO
X-Proofpoint-GUID: SOa5jD_ClaCGHxQtOXQIbEOIh5yfCZBO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_01,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511190016

RCU read lock is missing in ath12k_dp_tx_free_txbuf() before calling
ath12k_dp_to_pdev_dp(), causing below warning:

WARNING: suspicious RCU usage
-----------------------------
drivers/net/wireless/ath/ath12k/dp.h:653 ath12k dp to dp pdev called without rcu lock!
Call Trace:
 <IRQ>
 show_stack
 dump_stack_lvl
 dump_stack
 lockdep_rcu_suspicious.cold
 ath12k_dp_tx_free_txbuf
 ath12k_wifi7_dp_tx_completion_handler
 ath12k_wifi7_dp_service_srng
 ath12k_pci_ext_grp_napi_poll
 [...]
 </IRQ>

Invoke guard(rcu) to fix it.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3

Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/dp_tx.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
index 1d4444f3936f..c10da6195c9c 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
@@ -194,8 +194,6 @@ void ath12k_dp_tx_free_txbuf(struct ath12k_dp *dp,
 
 	skb_cb = ATH12K_SKB_CB(msdu);
 
-	dp_pdev = ath12k_dp_to_pdev_dp(dp, pdev_idx);
-
 	dma_unmap_single(dp->dev, skb_cb->paddr, msdu->len, DMA_TO_DEVICE);
 	if (skb_cb->paddr_ext_desc) {
 		dma_unmap_single(dp->dev, skb_cb->paddr_ext_desc,
@@ -203,6 +201,10 @@ void ath12k_dp_tx_free_txbuf(struct ath12k_dp *dp,
 		dev_kfree_skb_any(desc_params->skb_ext_desc);
 	}
 
+	guard(rcu)();
+
+	dp_pdev = ath12k_dp_to_pdev_dp(dp, pdev_idx);
+
 	ieee80211_free_txskb(ath12k_pdev_dp_to_hw(dp_pdev), msdu);
 
 	if (atomic_dec_and_test(&dp_pdev->num_tx_pending))

---
base-commit: 7cd7392a07782b8ad4aa6360e4be1967af2eab04
change-id: 20251118-ath12k-fix-missing-rcu-lock-51484e258da9

Best regards,
-- 
Baochen Qiang <baochen.qiang@oss.qualcomm.com>


