Return-Path: <linux-wireless+bounces-25145-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16053AFF563
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 01:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D4A95A1B8E
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 23:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1A1256C91;
	Wed,  9 Jul 2025 23:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gRJVrxKx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D721E55B;
	Wed,  9 Jul 2025 23:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752103642; cv=none; b=LG3fcdueSuXP0YyFOf9CsbWURWerFeEdqCHeHeiX8dzAJL5xf/x/juEIuAb3mdkF7qdG5GuZQZ0ZMPU+pD0E5+QK8hs40cSPUsxzZVXumyMPw6+HpAduzXgeTyWK/14XxYKGqucQbruHxldnqJ6/DL+CsqRbQVGiXuQOh7fKKGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752103642; c=relaxed/simple;
	bh=8eQw8pjOJ2M9gtWaF0Gx8+GFEyGWMLQbcXfz1QjKh6k=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=ideCzlxrkLwhMkx6ZkOTTOOJIsjct8i5MN7NXthpQYKubkH3+Mrm99pMoRJMHeomh/Qz6r7lHkWlhUunJrZyDv9WNHDyUga1bammCI4XtZgz3YtiWvrON9keShauCd0ob6uERUQ5IzCERe4FfTT8q9/oopBPLr14tYtTRe8vQwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gRJVrxKx; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2eb5cbe41e1so279380fac.0;
        Wed, 09 Jul 2025 16:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752103640; x=1752708440; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=syS1l/dWM+9W54tJ+GAg3I8dctucVySCycGR6Tg+6d8=;
        b=gRJVrxKxjT4+Yip1Lh1pFJBnZS7+/HAC9QQ9oqdnvz5nUoXW+y8vf5TX8U5gme6sSJ
         JrB1Z5jlXI46mnIJ02kY8t/YLq14yaQo0uHklMM0sNYHitwjZOw6uFvQGJOH8WW5jxeH
         7KZFM7lMTJrS2Wqx3CdIAs2lpxhAhPzzVLplcWkxA+OOxsqQWgpFW4JePyXyGDW2+4JH
         AOFy1qtOckQWmeuoMW8gaZ/oC+zBRX6n92WmOcNl1xIiluu3R6Se6lxmujdXzJxNxhsZ
         +m1LJCeysJ8xVg0DnB2zahRaIK/P48/9u2f9wpobIY/q4VPNqYUoZWlJIzKbLwsz0774
         mVug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752103640; x=1752708440;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=syS1l/dWM+9W54tJ+GAg3I8dctucVySCycGR6Tg+6d8=;
        b=PMBxP+cEGhJmtqvBVd2Ogd4MuXQ5b5iEJxSmYXuSnDQWHqEvCVZN5ZgcpfHeUbJnkI
         +K+lSf06fZlSm5+9PCxUOIwrQR1pijvK/KDPnEM+4U/arteDzXZfKqZbGibOPMvPmAAj
         fKFSrk7BpU371KiZ04h/nY0qq0m2/2C8upbbWqHzy9evMbnIoVk8DcqZxG/zRKHz5gvg
         HFlh8uTXobApt6bPTEwq/fspIuwIFTRcMbnrrFdpWh36cDlvEvr2dwIXBEE3Z6KwXk5z
         gAlA7D8tBBLyYdB/g2dK2e73kvj9PZ9aYX1BkDnKYxWtHONikPFg2LKzHdIm9NRS0lRM
         vj9w==
X-Forwarded-Encrypted: i=1; AJvYcCVj9M/IN7LB02nxB1wniRXhzmWiMm2RJmfwrqIBF3f5+2FxNaEwnz+xvXrFwIvhuVk7+s/uiow=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPwkngz9HdfBKLcsd4HoSFsydPF/uZAyOvDLgWI+9U1dpBVYvi
	ZPYi3ORQ1Kdg2UpyE98m7pkIQ6+ef17ZpTf77XeCAeFT9im7EhiZ2cdM9RFQJuU=
X-Gm-Gg: ASbGnctZ9y8f35fmkwxkjlyOF0wqiXWU2A3SM1+RLOs76b0KDlhZ5xLZdEtLemdYJQK
	awM2SO/0goQ2wGEC0ontrC+sX99YGpEnulTLfEoLY20avxqU+gTY7VFIxiTiPi38Td6IHLrsmX3
	Xnltie/Z32tU4/J5k31OBOluaMRw3w0yk0drjJkZX3JlAjv6EmKJhrnel8bz9RYG1UcnFIABDT6
	+ETgGCwl3cSvZPhhLI6C/QEbnILbmb4j9D8WCoAGPplktFNsHXjUoZph8R7vxO1938tA2zLKWO0
	p/END9Otb4i8sUblOzboa8WlyfVc7WQMOom1Iyuv8FGTMrZ/XXpz+Ad7uxj7DMClIDveo5RCjeA
	DjUMdenct4E/5IzrqdGSCYQtxoUWC
X-Google-Smtp-Source: AGHT+IGk7gvv5kRWSXuro4vUjS5h9HTjNYMVNtzCZod+WSsbUNCf3a1CTxPoy0vuB8yUrXBRJmDi6Q==
X-Received: by 2002:a05:6870:e24b:b0:2d5:d5c:a851 with SMTP id 586e51a60fabf-2fef848f00emr3114845fac.6.1752103639904;
        Wed, 09 Jul 2025 16:27:19 -0700 (PDT)
Received: from ?IPV6:2600:8804:8c40:ef:e529:73bf:275e:58f6? ([2600:8804:8c40:ef:e529:73bf:275e:58f6])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2ff11681bcdsm65006fac.32.2025.07.09.16.27.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jul 2025 16:27:19 -0700 (PDT)
Message-ID: <7afd3c3c-e7cf-4bd9-801d-bdfc76def506@gmail.com>
Date: Wed, 9 Jul 2025 18:27:17 -0500
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-wireless <linux-wireless@vger.kernel.org>,
 Felix Fietkau <nbd@nbd.name>, stable@vger.kernel.org
From: Nick Morrow <morrownr@gmail.com>
Subject: [PATCH v2 wireless-next] wifi: mt76: mt7925u: Add VID/PID for Netgear
 A9000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

From 17bf632a10e843af7a5f80d9e1449c5c26bb8486 Mon Sep 17 00:00:00 2001
From: Nick Morrow <morrownr@gmail.com>
Date: Tue, 8 Jul 2025 16:40:42 -0500
Subject: [PATCH v2 wireless-next] wifi: mt76: mt7925u: Add VID/PID for Netgear A9000

Add VID/PID 0846/9072 for recently released Netgear A9000.

Signed-off-by: Nick Morrow <morrownr@gmail.com>
Cc: stable@vger.kernel.org
---
v2:
 - No change.
---
 drivers/net/wireless/mediatek/mt76/mt7925/usb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/usb.c b/drivers/net/wireless/mediatek/mt76/mt7925/usb.c
index 4dfbc1b6cfdd..bf040f34e4b9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/usb.c
@@ -12,6 +12,9 @@
 static const struct usb_device_id mt7925u_device_table[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x0e8d, 0x7925, 0xff, 0xff, 0xff),
 		.driver_info = (kernel_ulong_t)MT7925_FIRMWARE_WM },
+	/* Netgear, Inc. A9000 */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x0846, 0x9072, 0xff, 0xff, 0xff),
+		.driver_info = (kernel_ulong_t)MT7925_FIRMWARE_WM },
 	{ },
 };
 
-- 
2.48.1

