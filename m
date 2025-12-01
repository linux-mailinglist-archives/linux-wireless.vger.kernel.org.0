Return-Path: <linux-wireless+bounces-29445-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFC7C9763E
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Dec 2025 13:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8CCC74E534B
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Dec 2025 12:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4783D3112B2;
	Mon,  1 Dec 2025 12:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XR1PcdKX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ePDStvoo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF7A31B810
	for <linux-wireless@vger.kernel.org>; Mon,  1 Dec 2025 12:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764593028; cv=none; b=Q7NUeuopIfZIDu0dAiy2JC5U8V1MyiEOoAdMXV5YED7PQCS5RrYxNNgUzg0Wa6tGwkaQhwKvxrf0EpQeucRBZsljLxq1a+xvBjJ50znw2CyB9dFVW9rlCu8jFPxbLHP7qbEt17nu0NmSHRNM7VE0efl+XEj2V0j0jmCl11y/CS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764593028; c=relaxed/simple;
	bh=rbqwP2YI4CzGHgLkC6DPKf/HhJhVBMMGwEXYBUIoF6k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OjrGtB0lzne677vbUkNsZwEYnbcXVNXfc5GcT1LFc1T7A2WuYHPr8DCp3KmH5QfgoXOv0XpHXc+BlMmqEHvRu9IIGh3qErcfh3/3dC8XpDx2VZoo15nLwuhT+gP79vsfW94gdw+9Ld7fyjGBC3d9GhGkPemeQOdy+Q5NYjEWkWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XR1PcdKX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ePDStvoo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B16ieda3689170
	for <linux-wireless@vger.kernel.org>; Mon, 1 Dec 2025 12:43:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fpnTx2DCpn5NW+7UCBeMn/SqdtMDI0Y8uRPDmg+UDbk=; b=XR1PcdKXJkx1y7lP
	1hl+9CzAqtSL+e2kFxF9sah35MGnmVSLivazrLvPrWo8zhkg7+7F3Yc0qBvAdw0D
	0Rcx9XHoC33Q8YGhzsSr2ctUULz9VLVFpwG90cz3XFjuC08JTXw8+X8F//dQ6yUO
	EUI8HizI6XGSjaSydbEGKq/bfDn3etKvt+Y+kjdW42c124s11HPFXwt3c/iPxi9v
	LpGNA6GsTRNY+gUhwKKygIq+XJRpipG6W8++QY32QNS9U9UR5SeZ5Mud0gWSY+9U
	3IzOsDms4kTgtONn4rgbYXruSqffW5sCfJeh2IzcdSiUw+glechcoP9Yr8sdEhnz
	gkzUyQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4as6141204-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 01 Dec 2025 12:43:45 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-297e1cf9aedso70452015ad.2
        for <linux-wireless@vger.kernel.org>; Mon, 01 Dec 2025 04:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764593025; x=1765197825; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fpnTx2DCpn5NW+7UCBeMn/SqdtMDI0Y8uRPDmg+UDbk=;
        b=ePDStvoogr9MtFo9amofY1dpQK+AMd5pUnt5aMUtWbOYYlKpu8HwcZtKUOZOtAt+aF
         GtQVWLa5IOKjhY53Do5WPieDxbqwWgtiozb5/jC2WQnX/RAwj1JtvuveFY5K+OVdRfff
         2IchMF/RdeT9aPtLrL/3cIyFL2C33fjgjPwlZVUX7C/eWcCFWrgz4kkfC5BwIaWStn/J
         Xu8yFz/VwaYK9euJFNhaS+xzXkTwrDYDbVSk4ffL0bsQBy+3+zWp4PMY/DMMshxqpRvA
         aLEH/8Ss6qZEtWmkTonmiPuQlKeN3WqJMo26BLuT4G6WqPKXQlBm84gf6BcE2gvaDAX9
         cEVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764593025; x=1765197825;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fpnTx2DCpn5NW+7UCBeMn/SqdtMDI0Y8uRPDmg+UDbk=;
        b=KyHkFgwvTQ0vIOOx0aZ1yNBjko35LlQuNDT336zPr7vO+2mpgTrv/fWu4t47o/+dky
         eviTae4cp/e60F7ICk0U+eqMBa7Fz4avcNI/7Im+k4oOsKDfTGJY1GO/k2DsQ7qyNRdB
         y0h3YJn+/7dTcMEkiqEl08VO3KFuC73gVEMFY24VZYGfbDUVkKYFy6S7D2h2D6mAPztF
         GQbBWwauCbWHh4dKdA8Pl0u0+b2OztThLCdpgd0kQ6EC7ALKCoqQG6HrRQoxHjWsrZiv
         UaHjnNQkxfvFOSbBxVdEq1DyIP7uHqLwur6dKsiX5G9V9fmRp9uXZbvZTRdAtIGYLa+c
         1lFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUn2Ci08cIRqFNtnkfKqlZwlavUnr6YSxtkYMvm6TS9YzOOBXHBjxlfuZ9ZH1Da+1Go1nMZrmq7bz1ZL6ctZQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrjqg0x1L5DfRN6J7Lh6Kl3WLXdvbqNLBrGfthGn69bGE+jJkp
	HUSxZcdq+I/JMGOcu09H+LLiefPuVXMNfTWkXiS0lXtfZbsf4cPItJPUch0+MV3dfWi1xj4uCbR
	VNQXS8FHxHD+44ZI3R0Vy459CRQtqa1mh/Jz0YkFd2an3ctmL/CHEjLe85p4/5LCM/v/m4g==
X-Gm-Gg: ASbGnctsBdZ5rZtU4BZcxYOw01cPG56aCVm77XMVChVsHV3vk4FllbdgXvuvPVKJRXo
	POqY7sPQ8HCHC1xS/MaHHUOcCBKBQRWMO0bIBnnP32AcW6KCMD5XB7wNCQ3lY4RenAjemAP30Na
	njA0bTdUIAApTSDqEqOjwGOLz7p4psRrYwMIW32pPes2mfAtBbDHbKTaKoEdWq+Qlgs1fD2zXQ5
	9y64mNh93jgXjfXaQt03Lfy7TcIbOYRjvkljIlgBiSHrLz9iRE3fnIRmhMfbKYCUZxE3vr7GHcb
	1tHe6X6ja7NE62W+Td5BHHGVFgKHu6vYMjDCa14dKLPx1s/H+MGx+9HwO6YiKXqIf8ODsuBMfzj
	3D6dzhzvjeAPoE/kuoZE2E/mTzjlDez8Fbuu0ob2ub1e0
X-Received: by 2002:a17:902:f712:b0:295:82c6:dac0 with SMTP id d9443c01a7336-29b6bf3b620mr427701355ad.36.1764593025052;
        Mon, 01 Dec 2025 04:43:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQRyQeaORqv6EIcBnGlMaq26A/hMlADJNn0YXR98fYBetj3iI8jUv1Ui+5YteXsBVLZPjwlA==
X-Received: by 2002:a17:902:f712:b0:295:82c6:dac0 with SMTP id d9443c01a7336-29b6bf3b620mr427701135ad.36.1764593024474;
        Mon, 01 Dec 2025 04:43:44 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3477b733381sm13146374a91.12.2025.12.01.04.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 04:43:44 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 01 Dec 2025 18:13:19 +0530
Subject: [PATCH 3/4] net: mhi_net: Implement runtime PM support
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251201-mhi_runtimepm-v1-3-fab94399ca75@oss.qualcomm.com>
References: <20251201-mhi_runtimepm-v1-0-fab94399ca75@oss.qualcomm.com>
In-Reply-To: <20251201-mhi_runtimepm-v1-0-fab94399ca75@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
        Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
        Oded Gabbay <ogabbay@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org, netdev@vger.kernel.org,
        mayank.rana@oss.qualcomm.com, quic_vbadigan@quicinc.com,
        vivek.pernamitta@oss.qualcomm.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764593001; l=3344;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=rbqwP2YI4CzGHgLkC6DPKf/HhJhVBMMGwEXYBUIoF6k=;
 b=/Y2lIbKnoetk66YeT7B0yhq+Lp6V/NhqVD5b7G9I3ctKq/8126e4MtAa3KtI53yQh650IoAtH
 yDP4z6ZpJW+BDRVzLPVbyhcZhAeBx2UtPa+G7f/CG+yfkSzgm82tWqi
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=J/KnLQnS c=1 sm=1 tr=0 ts=692d8d81 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=FGecwo-O3dF_YbjdleMA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: ctfxGa5Ee-VQ-1pHZrVBq_shy4b38iI8
X-Proofpoint-ORIG-GUID: ctfxGa5Ee-VQ-1pHZrVBq_shy4b38iI8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAxMDEwMyBTYWx0ZWRfX57m9Cnoi4WIU
 0p+RmOPTYTIYoVacz3HGplBeRkSc5trIWvH9+q0HPMFsMu1dn9SzhkOZO0QmDbApwmhjlTxCCfI
 KjKIVvYVVOsdTY6qLIvpHtA+2qJX8jx39wBLBqVneAhr39TJKCku/xNWppWdeRbw7VwNAMuUNWg
 ERzDMXN6lpM563WS7GIam0OhDN6afq2Wc/jkSQIom5kJKTfykU5meIyDbGCNdQydJoT/wVuPidq
 1qhdlw85wXQxzq1TR7W+Q1agIGgMijgGW71P9xpFnBBKzTEISeEv5xxXNnhdyLDOu+f+FMtrpJZ
 f5Rp/WtgWe9AUqTKRCVSEn/9W1Zy05RAU/Gy4lFK7yTpOMNaCr5aE0R4s7/xn+SOrX4ZHVrBvma
 dJxJ7QQbLteABEUy2JgSqn/RFqcfCw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_08,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512010103

Add runtime power management support to the mhi_net driver to align with
the updated MHI framework, which expects runtime PM to be enabled by client
drivers. This ensures the controller remains active during data transfers
and can autosuspend when idle.

The driver now uses pm_runtime_get() and pm_runtime_put() around
transmit, receive, and buffer refill operations. Runtime PM is initialized
during probe with autosuspend enabled and a 100ms delay. The device is
marked with pm_runtime_no_callbacks() to notify PM framework that there
are no callbacks for this driver.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/net/mhi_net.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/mhi_net.c b/drivers/net/mhi_net.c
index ae169929a9d8e449b5a427993abf68e8d032fae2..c5c697f29e69e9bc874b6cfff4699de12a4af114 100644
--- a/drivers/net/mhi_net.c
+++ b/drivers/net/mhi_net.c
@@ -9,6 +9,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
+#include <linux/pm_runtime.h>
 #include <linux/skbuff.h>
 #include <linux/u64_stats_sync.h>
 
@@ -76,6 +77,7 @@ static netdev_tx_t mhi_ndo_xmit(struct sk_buff *skb, struct net_device *ndev)
 	struct mhi_device *mdev = mhi_netdev->mdev;
 	int err;
 
+	pm_runtime_get(&mdev->dev);
 	err = mhi_queue_skb(mdev, DMA_TO_DEVICE, skb, skb->len, MHI_EOT);
 	if (unlikely(err)) {
 		net_err_ratelimited("%s: Failed to queue TX buf (%d)\n",
@@ -94,6 +96,7 @@ static netdev_tx_t mhi_ndo_xmit(struct sk_buff *skb, struct net_device *ndev)
 	u64_stats_inc(&mhi_netdev->stats.tx_dropped);
 	u64_stats_update_end(&mhi_netdev->stats.tx_syncp);
 
+	pm_runtime_put_autosuspend(&mdev->dev);
 	return NETDEV_TX_OK;
 }
 
@@ -261,6 +264,7 @@ static void mhi_net_ul_callback(struct mhi_device *mhi_dev,
 	}
 	u64_stats_update_end(&mhi_netdev->stats.tx_syncp);
 
+	pm_runtime_put_autosuspend(&mdev->dev);
 	if (netif_queue_stopped(ndev) && !mhi_queue_is_full(mdev, DMA_TO_DEVICE))
 		netif_wake_queue(ndev);
 }
@@ -277,6 +281,7 @@ static void mhi_net_rx_refill_work(struct work_struct *work)
 
 	size = mhi_netdev->mru ? mhi_netdev->mru : READ_ONCE(ndev->mtu);
 
+	pm_runtime_get_sync(&mdev->dev);
 	while (!mhi_queue_is_full(mdev, DMA_FROM_DEVICE)) {
 		skb = netdev_alloc_skb(ndev, size);
 		if (unlikely(!skb))
@@ -296,6 +301,7 @@ static void mhi_net_rx_refill_work(struct work_struct *work)
 		cond_resched();
 	}
 
+	pm_runtime_put_autosuspend(&mdev->dev);
 	/* If we're still starved of rx buffers, reschedule later */
 	if (mhi_get_free_desc_count(mdev, DMA_FROM_DEVICE) == mhi_netdev->rx_queue_sz)
 		schedule_delayed_work(&mhi_netdev->rx_refill, HZ / 2);
@@ -362,12 +368,19 @@ static int mhi_net_probe(struct mhi_device *mhi_dev,
 
 	SET_NETDEV_DEV(ndev, &mhi_dev->dev);
 
+	pm_runtime_no_callbacks(&mhi_dev->dev);
+	devm_pm_runtime_set_active_enabled(&mhi_dev->dev);
+	pm_runtime_set_autosuspend_delay(&mhi_dev->dev, 100);
+	pm_runtime_use_autosuspend(&mhi_dev->dev);
+	pm_runtime_get(&mhi_dev->dev);
 	err = mhi_net_newlink(mhi_dev, ndev);
 	if (err) {
 		free_netdev(ndev);
+		pm_runtime_put_autosuspend(&mhi_dev->dev);
 		return err;
 	}
 
+	pm_runtime_put_autosuspend(&mhi_dev->dev);
 	return 0;
 }
 

-- 
2.34.1


