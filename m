Return-Path: <linux-wireless+bounces-17824-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC6FA18C9E
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Jan 2025 08:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A107816B4FF
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Jan 2025 07:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4E6143723;
	Wed, 22 Jan 2025 07:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=easyb-ch.20230601.gappssmtp.com header.i=@easyb-ch.20230601.gappssmtp.com header.b="MJDoz0+1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E887E57D
	for <linux-wireless@vger.kernel.org>; Wed, 22 Jan 2025 07:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737530141; cv=none; b=KyAG+wSYDOKBNDVFGoY+ntFUh2k0Ek/Xojp+H8JQs1GQ38SIJLkeGgzyqx6U3GYPv352QnM87sjnHi1SDKcnZYeUU4sPfjhIIyb/EVEwIFt0mGUBLqIvqSvNvXLLjhgeBmPakTuplFzWjj5aPOHWNHvjSYTQXMd5ABpLjwIP9YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737530141; c=relaxed/simple;
	bh=vWfk37iYUd2tgyOS8c7JDWSFmh5ZM74evUQpYduL8zk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dq+xQm4ZeApI5CAVZ/r9G0oFvBq7opoXCvn0RhddM3a/lh+UekWB+r9K3ywyiSARwU6OEnHOCZLW5xqdsQ2w2t+nCBpSUs+6KWzKDsqXpBq6jBYGEuSZKSMuY9wH13ThY51yxfubDwlgC05GKq/bNm+CpBkUHwXQd9GbF0IusAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=easyb.ch; spf=none smtp.mailfrom=easyb.ch; dkim=pass (2048-bit key) header.d=easyb-ch.20230601.gappssmtp.com header.i=@easyb-ch.20230601.gappssmtp.com header.b=MJDoz0+1; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=easyb.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=easyb.ch
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ef714374c0so871479a91.0
        for <linux-wireless@vger.kernel.org>; Tue, 21 Jan 2025 23:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=easyb-ch.20230601.gappssmtp.com; s=20230601; t=1737530137; x=1738134937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7UjDfBGOZJec0FX+GhR9A5zT78pHxXSu6/4RrJhJCws=;
        b=MJDoz0+1ghkAaMM3ZVSZ5vuIh6etxH5V/P0X9vB38vK9N8TU1GWafjv6IU5nayjEcT
         iXSPBd/f8SMQQg8B/3kzDnnyYYAlbcX9RIgmRxK/lv6+VGLnf0sKlpJdl7ygwF37GvZf
         QCsDKCKLgV+vg4GlCxR9uQMsw5ZPdIoNdgjkKKriDIGiPs4b6DxxXi6ieUvajapdHrBQ
         8HNLbjzjXvLrOzDt5PiTotG6Uzmmu3bOV3yKd6uqfYsroI1NqK/M6RmQT33JANxyU0Jj
         XP1DTttg5EGPYnu1vIkw7sivGpjqMI5fQRWeWqBVMRuZmq0Bl7EkjLMmf3TZwL5J5za6
         zHxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737530137; x=1738134937;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7UjDfBGOZJec0FX+GhR9A5zT78pHxXSu6/4RrJhJCws=;
        b=EHSnm1ga5CECSv5bS/Ik8SSqJFOVaB8SYyIUOB0eRiWE14CbVVC34wv762a9m8zUkx
         JLYqKzyToCwBith6EhMP+86G9A7frnFoOhIf9yaJ0SYJBO7ahG8qVTJdwTiKz3jJv+m8
         Uf3ZdxDLJYLy0oVSNjNtJjTnxSs5VUe4GRNwt0G2O02v2yvq8Ql8jikInHaF5Sww6krE
         cfaRtFaTTZcYll+lhDG/aRDLitZInO/KOAKKpsXTWWQS9NWsu8DR2LsWHa2WZJxi8J8s
         ti3zNuw7GffPvyxtRYm/vXDvaPMzjBVj15OyAPU5filfM4Irs7tblymU6WRIren50cmQ
         JKDA==
X-Gm-Message-State: AOJu0Yy2FNgn4/oCagOXoGVokI43KmsULqweRDlIO1aQBcc//6Z1sTyl
	vF4uf9RvUYOmTyMFIPHqnr+XsXczuEuFE1IClVkU2P1a/46p193wbx///aei4dOxtmz6pziFvA3
	5
X-Gm-Gg: ASbGnctYZ5uFkyNktW+qnPO5HFk3S6kwRagbrw0WUgOnJs9Tcj5mWFR12sBOSvpo50h
	0oc35iI14nxybx1oc9lhfKw5BikAelzY2AfoEAHWJxgpeYheJoQj8k8CFW+nyUorOrW35g6KMom
	vstTtVcsgEzdc2NyKemUtsJxTvzIHHeVvJNIEwFSSfnAO8Verm+9EWHaihI2ul105lT3d6BFude
	YDtTW4Ywnmr/N3EubsCwbD3yHD+8lS9Q3T4fqk6dkSlAAZurPcSF09MgdYb
X-Google-Smtp-Source: AGHT+IEKQWcF3LGTIQxp4rM07dyUhqCrGi20Kq7I3HLLKP2YnnZRu97lXz3gCf33hXzIzKgReCoMsA==
X-Received: by 2002:a17:90b:2e4a:b0:2ee:7504:bb3d with SMTP id 98e67ed59e1d1-2f782a8e9a6mr33213822a91.0.1737530136680;
        Tue, 21 Jan 2025 23:15:36 -0800 (PST)
Received: from pikachu.lan ([101.128.97.26])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7e6a5e347sm806491a91.6.2025.01.21.23.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 23:15:36 -0800 (PST)
From: Ezra Buehler <ezra@easyb.ch>
To: linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Martin Kaistra <martin.kaistra@linutronix.de>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Reto Schneider <reto.schneider@husqvarnagroup.com>,
	Ezra Buehler <ezra.buehler@husqvarnagroup.com>
Subject: [PATCH v2] wifi: rtl8xxxu: Enable AP mode for RTL8192CU (RTL8188CUS)
Date: Wed, 22 Jan 2025 15:15:11 +0800
Message-ID: <20250122071512.10165-1-ezra@easyb.ch>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ezra Buehler <ezra.buehler@husqvarnagroup.com>

This allows the driver to be used in wireless access point mode on the
AT91SAM9G25-based GARDENA smart Gateway.

Unfortunately, the data throughput in AP mode appears to be lower than
with the vendor driver (or in STA mode). Especially when sending, the
data rate is significantly lower. My measurements performed with iperf3
and an Edimax EW-7811Un (VID: 7392, PID: 7811) showed a maximum TX rate
of about 4 Mbits/sec compared to the ~24 Mbits/sec measured with the
rtl8192cu driver.

Although the performance might be good enough for our use case, this is
something that should be further looked into.

Signed-off-by: Ezra Buehler <ezra.buehler@husqvarnagroup.com>
---
When comparing the register values dumped for the two drivers in AP
mode, there are quite some differences. So, no idea where to start
digging deeper. Any pointers would be highly appreciated.

Cheers,
Ezra.
---
Changes in v2:
- Set max_macid_num to correct value
- Make commit message more elaborate, mention bad TX performance
- Link to v1: https://lore.kernel.org/20241108195511.1338147-1-ezra@easyb.ch
---
 drivers/net/wireless/realtek/rtl8xxxu/8192c.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/8192c.c b/drivers/net/wireless/realtek/rtl8xxxu/8192c.c
index 0abb1b092bc2..73034e7e41d1 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/8192c.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/8192c.c
@@ -644,6 +644,8 @@ struct rtl8xxxu_fileops rtl8192cu_fops = {
 	.rx_agg_buf_size = 16000,
 	.tx_desc_size = sizeof(struct rtl8xxxu_txdesc32),
 	.rx_desc_size = sizeof(struct rtl8xxxu_rxdesc16),
+	.supports_ap = 1,
+	.max_macid_num = 32,
 	.max_sec_cam_num = 32,
 	.adda_1t_init = 0x0b1b25a0,
 	.adda_1t_path_on = 0x0bdb25a0,

base-commit: 361cb056e2468be534f47c1a6745f96581a721e3
-- 
2.47.1


