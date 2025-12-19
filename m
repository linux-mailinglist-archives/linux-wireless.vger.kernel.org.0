Return-Path: <linux-wireless+bounces-29921-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B506DCCF309
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 10:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 24F5630161F2
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 09:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5533D1F30A9;
	Fri, 19 Dec 2025 09:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Hnvmkk/o"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out203-205-221-240.mail.qq.com (out203-205-221-240.mail.qq.com [203.205.221.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5895772617;
	Fri, 19 Dec 2025 09:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766137203; cv=none; b=WLbYdEpb6RD+LMJUTk9kwDx7koF8Rv+r0ZhAjaMRgo+oiGzbl6UkpYcHV/vfCSfvvWM/pEvCEhgDFCur5UzHoxkOiNVnvZF1i57aTaUXx9qZPs/ov3xUsDf6sTvX05xO1ZpoEUUXZxQJc5tH46EfwKzz7/jOZuyzX4b4LZqVy9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766137203; c=relaxed/simple;
	bh=EaGsMmGh8afXN0RrgpirEyzfpNhWyWB7pfofVN/283c=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=VtbMRxI6Zoe8rh8JGbeOLtcd43Ypxlhh9QR0GvAW4EWiX5sHbQe9WgkOc1QlptR1kWqUmzaRjIB212QK/wKY7ovMgSY56kwo795SnBIYm3kYYvDFhLXToCsyDm6GAGX7itDoF8PPfugLn76J6OtjuJaghRvIVUvFWcbfUaMD3tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Hnvmkk/o; arc=none smtp.client-ip=203.205.221.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1766137191; bh=2y73VA5cXJe+4Lot4NWVltV/hJepyyy5hX6CFDZpdqA=;
	h=From:To:Cc:Subject:Date;
	b=Hnvmkk/oRjVjSkXJsXVNmdA0Fhjb/lpfNLUUTBdyO2WGaqxurCAcjRx/xpnwEeYtR
	 ICtabuD2F/P+wJeBrhGFQEhf3Oh3si/TOQbxhy8O6dRf80wGPTAbX0BJauf0Rb5u0D
	 Mp1yFZrBLEAgUEweVzcVAz3o+t/snM+aJFcAPmHE=
Received: from cjz-VMware-Virtual-Platform.localdomain ([110.176.34.249])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id 9F0B74EE; Fri, 19 Dec 2025 17:39:48 +0800
X-QQ-mid: xmsmtpt1766137188tshbie9dl
Message-ID: <tencent_453BB45207600CD663A5957789EB5CEC1608@qq.com>
X-QQ-XMAILINFO: OG1iVxY1YfV2xtC71cfpqorHl6ho0nA0SztC6gwNH64mejTy8rSKeS/2qA8lBm
	 hYAbw/7R1pYcmoI/5u8hHJ5E4hifYFXK+jSDvHOuzqh+SnbL4j6dqA/bujCpJ6cYgo8qE2H6ue/4
	 HJSaR8ct0O3MemwSkYCLGkOn75V2EqvKiRFEyaNJ+jY1vlPbSpT5S/PFyVZTWhKdC4z0d94c4/KI
	 w3Ty2U5XYJTZ9CD3PhStJweDtA/9RTxWSz5iqVDoesoMiTWxezOHnXy+LBiNKMkp2mqaBKBg9C2Q
	 mydPpdOk1lrs1XSrwKcSRrv/ssQkHHD1V6DajAJhtMJZu/ce9q3iFCMxGDy9FXzakK/wfoa8jzEy
	 CINdnzNk5L1krtOOHKkihRzhnBpalAzpLM2S3zXZuINGeaRZwVHVcHfap3Ak2ZKK4vtpYckUV8XQ
	 57V6+zdZiLwZHZ0rXjcGcTjgkjcF1FVWPFDWjdTOez9Fs1LYgBIz9+udL3ajXUCgEFcSF5czFIq/
	 PFIRrJivm1r09cRDi0y39T6Za0EUtasoHMLvw72zuLdLrzHiJC+F7pbh7GBjKJNiYvrnwkEnP2SZ
	 D4U8PMgAVszNK5FIrrafyjunZO4uVLQ7mL6phSmmYCk9lclxqcP1cbDSUEKHoqXt51L2Yg509siw
	 4/4eJHuJqkqr73LzHkzj5wbEYp7Wb9GBMiBDIQXRAXZSnKe8IKKdqyBoFcCit9AklFIh3sCFAeAh
	 C4FSNhnO00xVlGEEDTlyW0X+PaElDaH4fYIni4yWX8AKQ4wVLVPTzOTDysgqx/6s/vq4Tn1c3CBn
	 lU4zYEb2KmdWpm0fTz7tFM3VvFScnBUQwFxLLdNAueWdRAf174EUinnFpAEBdUGqCQ2iS5UHcOXn
	 CrsO7Ni/zaiwHwsPI6jE7t22tr7vuoD59p/7MDoARm9D+8pyCd5AHoRUvEsLh/QFnOJ4AuNINkLN
	 hP9FYSSz7+/3yeekQL37ximDhc/+j3
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: cjz <guagua210311@qq.com>
To: linux-staging@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	changjunzheng <guagua210311@qq.com>
Subject: [PATCH v3] rtl8723bs: v3 - Remove global continual_io_error, use local count
Date: Fri, 19 Dec 2025 17:39:47 +0800
X-OQ-MSGID: <20251219093947.22068-1-guagua210311@qq.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: changjunzheng <guagua210311@qq.com>

1. Remove global 'continual_io_error' variable from struct dvobj_priv (eliminate cross-function dependency)
2. Replace global count logic with local 'error_count' in sd_read32/sd_write32
3. Delete redundant rtw_inc_and_chk/rtw_reset_continual_io_error functions
4. Add independent bool rtw_check_continual_io_error() (single responsibility)
5. Comply with kernel coding style (whitespace, indentation, variable declaration)

Signed-off-by: changjunzheng <guagua210311@qq.com>
---
 drivers/staging/rtl8723bs/core/rtw_io.c         | 17 ++---------------
 drivers/staging/rtl8723bs/include/drv_types.h   |  1 -
 drivers/staging/rtl8723bs/include/rtw_io.h      |  3 +--
 .../staging/rtl8723bs/os_dep/sdio_ops_linux.c   | 16 +++++++++-------
 4 files changed, 12 insertions(+), 25 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_io.c b/drivers/staging/rtl8723bs/core/rtw_io.c
index 0f52710e6d3a..33023ae45196 100644
--- a/drivers/staging/rtl8723bs/core/rtw_io.c
+++ b/drivers/staging/rtl8723bs/core/rtw_io.c
@@ -131,20 +131,7 @@ int rtw_init_io_priv(struct adapter *padapter, void (*set_intf_ops)(struct adapt
 
 	return _SUCCESS;
 }
-
-/*
- * Increase and check if the continual_io_error of this @param dvobjprive is larger than MAX_CONTINUAL_IO_ERR
- * @return true:
- * @return false:
- */
-int rtw_inc_and_chk_continual_io_error(struct dvobj_priv *dvobj)
-{
-	dvobj->continual_io_error++;
-	return (dvobj->continual_io_error > MAX_CONTINUAL_IO_ERR);
-}
-
-/* Set the continual_io_error of this @param dvobjprive to 0 */
-void rtw_reset_continual_io_error(struct dvobj_priv *dvobj)
+bool rtw_check_continual_io_error(int error_count)
 {
-	dvobj->continual_io_error = 0;
+    return (error_count > MAX_CONTINUAL_IO_ERR) ? true : false;
 }
diff --git a/drivers/staging/rtl8723bs/include/drv_types.h b/drivers/staging/rtl8723bs/include/drv_types.h
index bd7bb5828d56..de4bec961671 100644
--- a/drivers/staging/rtl8723bs/include/drv_types.h
+++ b/drivers/staging/rtl8723bs/include/drv_types.h
@@ -279,7 +279,6 @@ struct dvobj_priv {
 	u8 Queue2Pipe[HW_QUEUE_ENTRY];/* for out pipe mapping */
 
 	u8 irq_alloc;
-	int continual_io_error;
 
 	atomic_t disable_func;
 
diff --git a/drivers/staging/rtl8723bs/include/rtw_io.h b/drivers/staging/rtl8723bs/include/rtw_io.h
index adf1de4d7924..8ae8849f5fd9 100644
--- a/drivers/staging/rtl8723bs/include/rtw_io.h
+++ b/drivers/staging/rtl8723bs/include/rtw_io.h
@@ -48,8 +48,6 @@ struct	intf_hdl {
 #define SD_IO_TRY_CNT (8)
 #define MAX_CONTINUAL_IO_ERR SD_IO_TRY_CNT
 
-int rtw_inc_and_chk_continual_io_error(struct dvobj_priv *dvobj);
-void rtw_reset_continual_io_error(struct dvobj_priv *dvobj);
 
 struct io_priv {
 
@@ -70,5 +68,6 @@ extern int rtw_write32(struct adapter *adapter, u32 addr, u32 val);
 extern u32 rtw_write_port(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
 
 int rtw_init_io_priv(struct adapter *padapter, void (*set_intf_ops)(struct adapter *padapter, struct _io_ops *pops));
+bool rtw_check_continual_io_error(int error_count);
 
 #endif	/* _RTL8711_IO_H_ */
diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_ops_linux.c b/drivers/staging/rtl8723bs/os_dep/sdio_ops_linux.c
index 5dc00e9117ae..571a2c6fc37a 100644
--- a/drivers/staging/rtl8723bs/os_dep/sdio_ops_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/sdio_ops_linux.c
@@ -207,7 +207,7 @@ u32 sd_read32(struct intf_hdl *pintfhdl, u32 addr, s32 *err)
 
 	if (err && *err) {
 		int i;
-
+		int error_count = 0;
 		*err = 0;
 		for (i = 0; i < SD_IO_TRY_CNT; i++) {
 			if (claim_needed)
@@ -217,13 +217,13 @@ u32 sd_read32(struct intf_hdl *pintfhdl, u32 addr, s32 *err)
 				sdio_release_host(func);
 
 			if (*err == 0) {
-				rtw_reset_continual_io_error(psdiodev);
+				error_count=0;
 				break;
 			} else {
 				if ((-ESHUTDOWN == *err) || (-ENODEV == *err))
 					padapter->bSurpriseRemoved = true;
-
-				if (rtw_inc_and_chk_continual_io_error(psdiodev) == true) {
+				error_count++; 
+				if (rtw_check_continual_io_error(error_count) == true) {
 					padapter->bSurpriseRemoved = true;
 					break;
 				}
@@ -284,7 +284,7 @@ void sd_write32(struct intf_hdl *pintfhdl, u32 addr, u32 v, s32 *err)
 
 	if (err && *err) {
 		int i;
-
+		int error_count = 0; 
 		*err = 0;
 		for (i = 0; i < SD_IO_TRY_CNT; i++) {
 			if (claim_needed)
@@ -292,14 +292,16 @@ void sd_write32(struct intf_hdl *pintfhdl, u32 addr, u32 v, s32 *err)
 			sdio_writel(func, v, addr, err);
 			if (claim_needed)
 				sdio_release_host(func);
+
 			if (*err == 0) {
-				rtw_reset_continual_io_error(psdiodev);
+				error_count = 0; 
 				break;
 			} else {
 				if ((-ESHUTDOWN == *err) || (-ENODEV == *err))
 					padapter->bSurpriseRemoved = true;
 
-				if (rtw_inc_and_chk_continual_io_error(psdiodev) == true) {
+				error_count++; 
+				if (rtw_check_continual_io_error(error_count) == true) { 
 					padapter->bSurpriseRemoved = true;
 					break;
 				}
-- 
2.43.0


