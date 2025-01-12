Return-Path: <linux-wireless+bounces-17362-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDF6A0A6E0
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jan 2025 02:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26A327A2B09
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jan 2025 01:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F36D79E1;
	Sun, 12 Jan 2025 01:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="Pqr8lJEl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9801779CF
	for <linux-wireless@vger.kernel.org>; Sun, 12 Jan 2025 01:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736646936; cv=none; b=ncE89UVGawJpBTuZYLgYyAYSfdePyUj+E/4cy/8rqBky3WP0VUdUnBT/td7cXGfOYcrAPidx+3uQULSIXBTBOMQ/XTkL+l7Q0ySkMIvKumP3AgnNJE+lXFktCC1F/BaOv8FjJ/pPRu0xduU7IiscWy/l+ju7GAt39Jt0f7PsM8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736646936; c=relaxed/simple;
	bh=gmfVJPUgASbcf2kQE5/KBTrG4x7ArMOnhyRLGM+z3+0=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=VOP6u78kY+WCmExLMePL/g6HWuWL/41EyCgU4RLHb8RlqONk+YUNq105INz8Ei8B10sCSOcMyVffEre9MnsNvSk/LCFrWjMmsiHvAVywoQ2nhY09x1zjDxl3PpIdnSEeyffKykMF4NgbOa9994jC+7YxrXGO9uhwae15hJzpTW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=Pqr8lJEl; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 50C1tL2I11599048, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1736646921; bh=gmfVJPUgASbcf2kQE5/KBTrG4x7ArMOnhyRLGM+z3+0=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=Pqr8lJElZmj+udq9r1Ku1t/O3vEbCX5aE9xYd1tXx1PVQUQ6O3Xo/I16ZFj7bZIHs
	 vz4O4nfP0IPih6tuwhbB7ifo6vAyqB+MVqeqTeNV8q8ofN9TAIw7Y7JtemMf1FiJP2
	 SwhoY2cQc5PsN3ORMq/cUlFIH+mQe3KXHE+Bgp+d7eJArsDQNukKfcWUjckHSuWOl5
	 2beAjjOwrXNntRHQYJ7O5c8Yp6k3E17JSbUf0HTKjQln/3mq1b7bkDHc21veYYOWr0
	 aFE8QVmJOdxjyd3Lut8QzRATOaIwHA6NF6NbVnCwPmJep4pjym/UqgkjtvZmkcfbwf
	 N/OP0W+4h9y/Q==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 50C1tL2I11599048
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 12 Jan 2025 09:55:21 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 12 Jan 2025 09:55:22 +0800
Received: from [127.0.1.1] (172.16.16.103) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sun, 12 Jan
 2025 09:55:21 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Ping-Ke Shih <pkshih@realtek.com>, Sascha Hauer <sha@pengutronix.de>
Subject: Re: [PATCH v2] wifi: rtw88: Add USB PHY configuration
In-Reply-To: <9d312b14-0146-4be8-9c50-ef432234db50@gmail.com>
References: <9d312b14-0146-4be8-9c50-ef432234db50@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <b11811e2-0fc4-4b02-9b57-4a10515d86bc@RTEXMBS04.realtek.com.tw>
Date: Sun, 12 Jan 2025 09:55:21 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> Add some extra configuration for USB devices. Currently only RTL8822BU
> version (cut) D needs this. The new code makes use of the existing
> usb3_param_8822b array from rtw8822b.c.
> 
> A user reported that TP-Link Archer T3U in USB 3 mode was randomly
> disconnecting from USB:
> 
> [ 26.036502] usb 2-2: new SuperSpeed USB device number 3 using xhci_hcd
> ...
> [ 27.576491] usb 2-2: USB disconnect, device number 3
> [ 28.621528] usb 2-2: new SuperSpeed USB device number 4 using xhci_hcd
> ...
> [ 45.984521] usb 2-2: USB disconnect, device number 4
> ...
> [ 46.845585] usb 2-2: new SuperSpeed USB device number 5 using xhci_hcd
> ...
> [ 94.400380] usb 2-2: USB disconnect, device number 5
> ...
> [ 95.590421] usb 2-2: new SuperSpeed USB device number 6 using xhci_hcd
> 
> This patch fixes that.
> 
> Link: https://github.com/lwfinger/rtw88/issues/262
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

5b1b9545262b wifi: rtw88: Add USB PHY configuration

---
https://github.com/pkshih/rtw.git


