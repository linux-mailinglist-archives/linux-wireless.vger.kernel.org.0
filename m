Return-Path: <linux-wireless+bounces-2828-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F06D98427C8
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 16:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77C9EB29364
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 15:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC6F823C0;
	Tue, 30 Jan 2024 15:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJy/aMNG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5A6823B3
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jan 2024 15:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706627761; cv=none; b=pvlMnDFeF5zIC41AYr3P4u4ZJhqr1SLZH1uDh4TMAS9EPXrX1awmsQOKQfj1EDu/oxkmEdjSLawBaiwb87n3QPHGamW0mvWo0xEpFV7Y3HaycDc4CvgTP2azCA5WjbLQXeDe66nT6MSK4ZFKeHgSuoYoonvgV3P36pomH3cH/cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706627761; c=relaxed/simple;
	bh=s5Y+P0O9OKlotbVfhZrh6FsjQx6MHf41BjyaHQPEXaA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qAIw1qn3iCPIWjrQAdhTYRDEmP3E7bCCMOPE6FS/c4pBB9s5n7y6t5MwAvnRjhZpHdVdvHNJAtvCX1p9oNK3Jl3W74G66EIvSZC+23YH72kUr1QjbblYXQKEn/54NUcMDJWB8diFomJQpH+jAEQfr0xLrRApszSlHKfi81Ek1R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJy/aMNG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ADCBC43609;
	Tue, 30 Jan 2024 15:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706627760;
	bh=s5Y+P0O9OKlotbVfhZrh6FsjQx6MHf41BjyaHQPEXaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IJy/aMNGbjTo0+FhDrRHxpyV/ED4hPKh/dSnt/70ee7IDesiXinoJuOF0PWoQA7a5
	 i2NbCTowo++f7Kmyc36C7UwKuqHaOIEjzDAXx4Wg1LQ8vZbR/JTHO9aheQFcy7wbTs
	 DiP+l4t0ZHvtocPZ/vCzp3v4xqB2WE9q+mzAbFMXJN1zBq0l/JHWYKZ+tqofx58pSp
	 7xVp4RC/t0nDJtxMIccSUTYvfrOAJ1v4/aeCuTppNF0rFwzTusN/sdDGLjjNeh0fJ6
	 O49fCVPGpqgkirn0gBJuvj7TrTrR4SVnWu7bQ97QdvJ+zEIwoNPYHwDYfpMwqfhHdi
	 O0M9haVsKfZHw==
From: Kalle Valo <kvalo@kernel.org>
To: linux-wireless@vger.kernel.org
Cc: xl@wp.pl
Subject: [PATCH 2/4] wifi: rsi: fix restricted __le32 degrades to integer sparse warnings
Date: Tue, 30 Jan 2024 17:15:54 +0200
Message-Id: <20240130151556.2315951-3-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240130151556.2315951-1-kvalo@kernel.org>
References: <20240130151556.2315951-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

drivers/net/wireless/rsi/rsi_91x_usb.c:235:27: warning: restricted __le32 degrades to integer
drivers/net/wireless/rsi/rsi_91x_usb.c:236:27: warning: restricted __le32 degrades to integer
drivers/net/wireless/rsi/rsi_91x_usb.c:237:27: warning: restricted __le32 degrades to integer
drivers/net/wireless/rsi/rsi_91x_usb.c:238:27: warning: restricted __le32 degrades to integer
drivers/net/wireless/rsi/rsi_91x_usb.c:244:36: warning: restricted __le32 degrades to integer
drivers/net/wireless/rsi/rsi_91x_usb.c:245:35: warning: restricted __le32 degrades to integer

These cpu_to_le32() are not making sense. With usb_reg_buf we handle the values
byte at a time to make sure usb_reg_buf is in little endian so no need to
convert anything. And usb_control_msg() expects to have the values in native
endian anyway. So just remove these so they are not spamming our logs.

Compile tested only.

Signed-off-by: Kalle Valo <kvalo@kernel.org>
---
 drivers/net/wireless/rsi/rsi_91x_usb.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/rsi/rsi_91x_usb.c b/drivers/net/wireless/rsi/rsi_91x_usb.c
index 10a465686439..dccc139cabb2 100644
--- a/drivers/net/wireless/rsi/rsi_91x_usb.c
+++ b/drivers/net/wireless/rsi/rsi_91x_usb.c
@@ -232,17 +232,17 @@ static int rsi_usb_reg_write(struct usb_device *usbdev,
 	if (!usb_reg_buf)
 		return status;
 
-	usb_reg_buf[0] = (cpu_to_le32(value) & 0x00ff);
-	usb_reg_buf[1] = (cpu_to_le32(value) & 0xff00) >> 8;
-	usb_reg_buf[2] = (cpu_to_le32(value) & 0x00ff0000) >> 16;
-	usb_reg_buf[3] = (cpu_to_le32(value) & 0xff000000) >> 24;
+	usb_reg_buf[0] = value & 0x00ff;
+	usb_reg_buf[1] = (value & 0xff00) >> 8;
+	usb_reg_buf[2] = (value & 0x00ff0000) >> 16;
+	usb_reg_buf[3] = (value & 0xff000000) >> 24;
 
 	status = usb_control_msg(usbdev,
 				 usb_sndctrlpipe(usbdev, 0),
 				 USB_VENDOR_REGISTER_WRITE,
 				 RSI_USB_REQ_OUT,
-				 ((cpu_to_le32(reg) & 0xffff0000) >> 16),
-				 (cpu_to_le32(reg) & 0xffff),
+				 (reg & 0xffff0000) >> 16,
+				 reg & 0xffff,
 				 (void *)usb_reg_buf,
 				 len,
 				 USB_CTRL_SET_TIMEOUT);
-- 
2.39.2


