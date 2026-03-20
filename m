Return-Path: <linux-wireless+bounces-33585-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KIHcMwIUvWnG6QIAu9opvQ
	(envelope-from <linux-wireless+bounces-33585-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 10:31:46 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E23932D80FE
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 10:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0F77D300602C
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 09:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479B635AC0A;
	Fri, 20 Mar 2026 09:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EU3VTnYI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A12359A7B
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 09:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773999099; cv=none; b=Qr4I8U9mxAFmVb8lxIq4lPTMCoc94NOWsgB9Qas4Fe2YuFpGXmyHkyLni9LaBSIknLHsLaBnwsDzKOzfwmVgi41SglyAL1TrKxdJf8jJ1P+k2gsZBDxK0vXhr/xAixPvA0vR6BER1Ohu6YtoG+6mqiOjbX/hyERo6GzEFNvl25Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773999099; c=relaxed/simple;
	bh=weNDgFJgtzK+f2pxm71FPZanie+7lA/p+YTPJHDorIM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=REtkFG2NipKfVYosh1T1peiorwLxJJlTveWAAz3qMNkl1NQxMCOlefVartDPh4pcEUOOSyHmxy2q3cXuzeEmAQtsmbLG3vNYi3mM3TZTM9ZsEWz70g5GxLpiZgu6+UgokS4yaemmRYxk/b8YAyi3b51ex2VOVUxtST6HJT4IOKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EU3VTnYI; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-358e3cc5e7eso1139840a91.0
        for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 02:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773999097; x=1774603897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=367UPYlYOzD2KgJXluqzV6ftmcYw+PJWqDA2UMpHH+4=;
        b=EU3VTnYICIO8pTc1fw/rt1fnGSG6VhfnKzBzR6Sw+JGb82498Eb4C4owOCOzhPwq1H
         wKgPNj5+65mFi2HxLqW+jYXVR/WQ5FXxRinIgpfFRbDEZy0QOSeHDD+dHEjIgFq5ej06
         hj19EziMd1x45OUnztFp4m6sSpCM96hQMHc4gl2UIaMQF2xunXpS0ahSNbfXlqYrliRK
         KTNTSm7bOcyx5btuZ1g7DnwhO8CO12/Y9tY1SNY5zAQ7HhPHrVNBgqBq9YJZCN/F2aXN
         UFWLT3dGKtcMeVN3/uJxcIHiJ1y8Z08VAN3G95ELibJCXmAOUhIBUqs3bAKdggHfu+ff
         Ud/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773999097; x=1774603897;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=367UPYlYOzD2KgJXluqzV6ftmcYw+PJWqDA2UMpHH+4=;
        b=H8cfppIYwlu8aXuDsuocP3FvC5N5O1+NyFMNDKiEtUSQEgimXHTdwMek8tKZZEKGw3
         qx+OdlfbV3PQnOrIY1ELJFzpLpJ4zsxTbohCzVelnlb/J226lL39LtRG3eR3JU0bJol6
         4ZwXQyTNSIhZlAwc8bZgBIJNBLm6oNhGOBGI3tMaRyY5/Vxhg4CTI2mVbFgpwmMAFmkT
         c2XSP7Zl/9LsD9+Y2Zef2C1AczA50ezeX66tOs/NP4R+gWmOmhp2Akusy4zm+UU8Eh9v
         GAz8RsgIRebSNRqyYrB78jfm6nNdpH/DtGR55FpQVY0tv0Qnhe1GCX9AYtaBMdg8RSnL
         QR+A==
X-Gm-Message-State: AOJu0YwTadDZ9pix+88R6Dg12/UaWRAPgTrswO26TtF2EdUxp82s9rk9
	hQUYQVm7brhR5NGzeUIkBySFWGEtrZD44ImoArZutJO5tkmkE8cDiP5RSPLXt1gv
X-Gm-Gg: ATEYQzyaH6KHNRyytTZUmSUWHDILMuUFpzCPmVcPMM/5nkEArjWWygEUhdjQgAggspP
	454CQSIWG7BIH75r43Pgol8lfEUCDJYeuSTRG3E9AeVnZY8RaoeLf74iGq6PeLC0XWdXWDErFyA
	Cl7ydup7X701KJkXick5GHKKw+EhQFRoe4mz+1zzkGaHWVkKV1McQPn12d6D7w5aadLlw5wKu9y
	vPlGdoU3AMMarB2PkTx43FoTQWRK2OyQLL1sJo0xBpLITZVZHuhdf3WNeS9ORpuSG4hiTqsrpbg
	MpZkeNOXsFkp2cL/Z0i9Rp/0CT28IE0Q0EYiFMFjedkzkEhAPvWjiC10fdAYEvASnjMcKaQQRKU
	Ub8qzd7rKNPWOjEY6DUPzppUt6eltAgd93Ng2HyI6WR9t02VBAkIlN6vxmxc2fKI3rtBRO4OYGo
	axD8mDZz7cIPB6CEoTJFd55kacc0emufMrxogJwbQH4Fjr/uaF4bRcYvOiYu2PsWtZ
X-Received: by 2002:a17:90b:3f83:b0:34a:9d9a:3f67 with SMTP id 98e67ed59e1d1-35bd2d400c2mr1711267a91.33.1773999097227;
        Fri, 20 Mar 2026 02:31:37 -0700 (PDT)
Received: from BM5220 (118-232-8-190.dynamic.kbronet.com.tw. [118.232.8.190])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c74443cc9edsm1429076a12.23.2026.03.20.02.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 02:31:36 -0700 (PDT)
From: Zenm Chen <zenmchen@gmail.com>
To: linux-wireless@vger.kernel.org,
	pkshih@realtek.com,
	rtl8821cerfe2@gmail.com
Cc: al.williams@awce.com,
	usbwifi2024@gmail.com,
	zenmchen@gmail.com
Subject: [PATCH rtw-next] wifi: rtw89: Add support for TP-Link Archer TX50U
Date: Fri, 20 Mar 2026 17:31:22 +0800
Message-ID: <20260320093122.6754-1-zenmchen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[awce.com,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33585-lists,linux-wireless=lfdr.de];
	FREEMAIL_TO(0.00)[vger.kernel.org,realtek.com,gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zenmchen@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.913];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E23932D80FE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add the ID 37ad:0103 to the table to support an additional RTL8832CU
adapter: TP-Link Archer TX50U.

Link: https://github.com/morrownr/rtl8852cu-20251113/issues/2
Signed-off-by: Zenm Chen <zenmchen@gmail.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8852cu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852cu.c b/drivers/net/wireless/realtek/rtw89/rtw8852cu.c
index 0c5aebaed..4755c483e 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852cu.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852cu.c
@@ -55,6 +55,8 @@ static const struct usb_device_id rtw_8852cu_id_table[] = {
 	  .driver_info = (kernel_ulong_t)&rtw89_8852cu_info },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x35bc, 0x0102, 0xff, 0xff, 0xff),
 	  .driver_info = (kernel_ulong_t)&rtw89_8852cu_info },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x37ad, 0x0103, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&rtw89_8852cu_info },
 	{},
 };
 MODULE_DEVICE_TABLE(usb, rtw_8852cu_id_table);
-- 
2.53.0


