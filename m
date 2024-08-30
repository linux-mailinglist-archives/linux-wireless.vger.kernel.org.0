Return-Path: <linux-wireless+bounces-12261-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 292CA9660C0
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 13:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D887328B4D2
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 11:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C211F199920;
	Fri, 30 Aug 2024 11:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=email.cz header.i=@email.cz header.b="V81u2sWo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mxe.seznam.cz (mxe.seznam.cz [77.75.78.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E54196C6C
	for <linux-wireless@vger.kernel.org>; Fri, 30 Aug 2024 11:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.75.78.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725017385; cv=none; b=RxnE8y8lnTE3GPmfTw+tmZSruFGP7Ta9/DRc2BDJ7CApDChrmr9doN6EIyMF6Hs2m1uXPU7fbJgvJ2kotlZUZVGaM0vffYxZH5oE0J6vhY+cjNx/9GKwl9J4ysN/TTA/HBY+TFKnt1i4FuSDudVnjIofZ0owja19NwqpySa2ROA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725017385; c=relaxed/simple;
	bh=y28fIsCbMg9cM9oRIS9rOSfIkALMoBa6nwUyo4OGA7I=;
	h=From:To:Cc:Subject:Date:Message-Id:Mime-Version:Content-Type; b=WsmmV/QcpVszmHKChXV9UIdtpNM9rTArytqzVS22GyfBNCfjQ7H9FiZt1mzxW5UjJfS9OhJ5yGicmKImIWjgvAAttMgtZaVu7NDBuhRd7vgqHlvXCi9B8iP/Xp3AA+OekCDW+Zxun5urwaSIgDgoVr/JdSykkYMEN7uVVMmZDDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.cz; spf=pass smtp.mailfrom=email.cz; dkim=pass (2048-bit key) header.d=email.cz header.i=@email.cz header.b=V81u2sWo; arc=none smtp.client-ip=77.75.78.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=email.cz
Received: from email.seznam.cz
	by smtpc-mxe-7df5484c66-k4bzx
	(smtpc-mxe-7df5484c66-k4bzx [2a02:598:64:8a00::1000:ad2])
	id 23947e68dd60ccc2231af070;
	Fri, 30 Aug 2024 13:29:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cz;
	s=szn20221014; t=1725017378;
	bh=KUov3Z81Hs56a02WNzMi3BbAn9lhj4cQzXERbDFkdc4=;
	h=Received:From:To:Cc:Subject:Date:Message-Id:Mime-Version:X-Mailer:
	 Content-Type:Content-Transfer-Encoding;
	b=V81u2sWo2yciCSIgAZ1/wHewvkeCGNy8izF+D99QC+EG1GSaEdHMb3tk/FAoTQUYZ
	 BrKkMrjdyDvTeGsLC6U61hm8utHAwUku12IJaBnHdWV1LAP9LoHMgZvKlVLHHSiJvi
	 P/uhuBa86a9RrlfqsVOMkPwUwHRdFyIJLEnbLmfHrtcIzgthL3gzaoH+enyncac0DW
	 K1YJ5y534O3BzN5N7uXYoVDIsdfPDud8DDl0ovPpBR5LvcaDJZn8ihs0P+QYliHuJA
	 cy2Cm81g1QUz5tZEAkONghQHkPlDlRkQKYbskEQXoV2MGxOKxdo3DcYltS8FAVtKu2
	 ZUKwV+RR4U+CQ==
Received: from 215-143.ktuo.cz (215-143.ktuo.cz [82.144.143.215])
	by email.seznam.cz (szn-UNKNOWN-unknown) with HTTP;
	Fri, 30 Aug 2024 13:28:15 +0200 (CEST)
From: "Tomas Paukrt" <tomaspaukrt@email.cz>
To: <ath10k@lists.infradead.org>
Cc: <linux-wireless@vger.kernel.org>
Subject: [PATCH] wifi: ath10k: add USB device ID for Atheros QCA9377-7 
Date: Fri, 30 Aug 2024 13:28:15 +0200 (CEST)
Message-Id: <22t.ZbsX.5bWREDtSGGB.1cqQpF@seznam.cz>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (szn-mime-2.1.61)
X-Mailer: szn-UNKNOWN-unknown
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

Add USB device ID for modules based on Atheros QCA9377-7 chipset like
8devices BLUE bean or SparkLAN WUBQ-159ACN.

Tested-on: QCA9377 hw1.1 USB
Signed-off-by: Tomas Paukrt <tomaspaukrt@email.cz>
---
 drivers/net/wireless/ath/ath10k/usb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath10k/usb.c b/drivers/net/wireless/=
ath/ath10k/usb.c
index 3b51b7f..60441ff 100644
--- a/drivers/net/wireless/ath/ath10k/usb.c
+++ b/drivers/net/wireless/ath/ath10k/usb.c
@@ -1106,6 +1106,7 @@ static int ath10k_usb_pm_resume(struct usb_interface=
 *interface)
 
 /* table of devices that work with this driver */
 static struct usb_device_id ath10k_usb_ids[] =3D {
+	{USB_DEVICE(0x0cf3, 0x9378)}, /* Atheros QCA9377-7 */
 	{USB_DEVICE(0x13b1, 0x0042)}, /* Linksys WUSB6100M */
 	{ /* Terminating entry */ },
 };
-- 
2.7.4
 

