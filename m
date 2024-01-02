Return-Path: <linux-wireless+bounces-1391-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C99C82206B
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jan 2024 18:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D52DD1F22A9B
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jan 2024 17:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A6F154AB;
	Tue,  2 Jan 2024 17:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=email.cz header.i=@email.cz header.b="Tp8hY5eW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mxe.seznam.cz (mxe.seznam.cz [77.75.78.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A22154AA;
	Tue,  2 Jan 2024 17:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=email.cz
Received: from email.seznam.cz
	by smtpc-mxe-54579945bb-28bjw
	(smtpc-mxe-54579945bb-28bjw [2a02:598:64:8a00::1000:563])
	id 069d608cf869d2260613ee94;
	Tue, 02 Jan 2024 18:31:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cz;
	s=szn20221014; t=1704216680;
	bh=VPqVL0dmRjTnHtTSRbX4H2e8aFz/9nWPxdm6mZwDmT0=;
	h=Received:From:To:Subject:Date:Message-Id:Mime-Version:X-Mailer:
	 Content-Type:Content-Transfer-Encoding;
	b=Tp8hY5eW+82f6gAezw1QR3CBQ6zv6KuUk9zU+pdLrTMG2r3vDJ8Z7sfdRx8GUVWG7
	 lA+EjGaJiGjcZlu/2LGHD7gMuODv98Kj3GLiXdaLukFuKF+tZ4ns9hfc1/J0rI+lJl
	 PItTZaRzoZzLoJTOtiNUErJZMj/d+dln/NcSQsLUgqN5spHkubeWqJNWRnQhG8ykjS
	 W2lZS8e3vuAtomIopYgCYfoihqdVzlCiveWsrMRwt/Hzh55G2hjG15vk3yONE4K5ms
	 /v+oKe4jTjf5d70JjvgrHdQ4JVApfTkiKV0Fu3lcOB+xgrnOEYrCZCsAlPXgMr4Ma5
	 0LkBoUROMHTxA==
Received: from 184-143.gtt-net.cz (184-143.gtt-net.cz [82.144.143.184])
	by email.seznam.cz (szn-UNKNOWN-unknown) with HTTP;
	Tue, 02 Jan 2024 18:29:59 +0100 (CET)
From: "Tomas Paukrt" <tomaspaukrt@email.cz>
To: "Kalle Valo" <kvalo@kernel.org>,
	"Jeff Johnson" <quic_jjohnson@quicinc.com>,
	<ath10k@lists.infradead.org>,
	<linux-wireless@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: ath10k: add USB device ID for Atheros QCA9377-7
Date: Tue, 02 Jan 2024 18:29:59 +0100 (CET)
Message-Id: <BBh.ZZQj.57mzV1Mb9h2.1bb4WN@seznam.cz>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (szn-mime-2.1.33)
X-Mailer: szn-UNKNOWN-unknown
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

Add USB device ID for modules based of Atheros QCA9377-7 chipset.

Signed-off-by: Tomas Paukrt <tomaspaukrt@email.cz>
---
 drivers/net/wireless/ath/ath10k/usb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath10k/usb.c b/drivers/net/wireless/=
ath/ath10k/usb.c
index 3c482ba..5d5cc0c 100644
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


