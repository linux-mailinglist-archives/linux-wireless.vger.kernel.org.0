Return-Path: <linux-wireless+bounces-37217-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id PBYbCVvEHGpNSQkAu9opvQ
	(envelope-from <linux-wireless+bounces-37217-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 01:29:31 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C8F61846A
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 01:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3310A3002D29
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 23:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C77311977;
	Sun, 31 May 2026 23:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AWOZ1jeF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A83233934
	for <linux-wireless@vger.kernel.org>; Sun, 31 May 2026 23:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780270162; cv=none; b=gNF+vE06vrN64yiWMvdMt8N4Z+ewqyqeYFHPC9WeN3r2pTRmr3lOH4pKig850Hy4T1nvr+wXI+bCs0TwLSV7jNNfCDW3e8W+ZIe2p6wtwLxi8fdJmLxQQ7sfl25JRSmXRIZMahV+LNnc40fyIOU5UfAMGKA+BbP9TVJijIKBn3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780270162; c=relaxed/simple;
	bh=euuPkT9Q3LW3NV3ZEElbM+p4ZzTQi43Br/qCIjYZH3U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G8T4U7/WaQVAon80mUdLNuH+k+hN6Dvk5oS0A2EnbhY9uqlzF3tUGZVtW6ezOEglRCP5m8NMlqV65mBKC2Hp5OHYBUTcik30eIbTM62+KBYQE52/XRtiPB0+waa3d+AO/j7Q3KL0LSLZ9BmKztpLkjiw0eFPRUumGDPkpxmPDJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AWOZ1jeF; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2c0bd02d97eso9841495ad.2
        for <linux-wireless@vger.kernel.org>; Sun, 31 May 2026 16:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780270161; x=1780874961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hsBt+sDiXwgLAGV6AGq6h1QTJOhCDDy/H3QW5XAubp0=;
        b=AWOZ1jeF0J8CRPE9HIGL3lR76aXWYEfA0i0bGROq0IiJI3V0JPvrLnH2uqqwK5olWa
         PdILrbTFBHGukyDuWrkmz0IEhr1QtIm5B627hAN1nRNiw7qwCtmRnYzTOZTV1zYUv4pK
         07hMjfCqFKK/z1a4y2OltY5RBxTAMH82Saz6EainDRKiRt+WNv26CNmr810Ow2DLHfFZ
         mr35IT5hNvbRwvOSl4LktDqk2RVgVyENVnJwMgqgT7N4x6S1cxShdfsOeyHmT90eyZ4s
         ydMxLPI7rkJdFd/coqWl9OxZQ3jSd/99CJMta/AyZDKv479xgY6BI6FFSGFopopfYK3K
         PraQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780270161; x=1780874961;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hsBt+sDiXwgLAGV6AGq6h1QTJOhCDDy/H3QW5XAubp0=;
        b=VDIMuRv2uayssIIf5o4rIpvMTrgE0DmwHQkGHJSS+NKPIAm0yfHAGzoxtC/XBOuoye
         uy+9NcHb9V7KTfOsd9QQuotlT3QGAVphYps5gyD5A83rIiELZzDC4nJii3R3aofrMd5F
         zgqzxQ533TNtXn9Qv/8wv//d+Vs/rIIvxLClbhnyBZVNyZ3B3hnDOMBi88qVzlDTCCha
         KYbniFfdOPJbr/R1ToKh5mmOnrb+HZ9L0ZTLK3TAVUE6K5o5uFFDk0CWGu3+DmhOWa+n
         S5OjNkpYrnLiWENwmuxK0aePWpOfZcBhmFxm64r/I0LT+JB+bzETCUK8wqXkynb6qgL5
         Z7wQ==
X-Gm-Message-State: AOJu0YxIESFNyepxlkDpQLP+UY1KzBstGno0jZrd3/Vazvy+p4KDC2/a
	dScwCBe5nfwFVqa+GsLAGNnuXgltDyTUceXGtUeFvSDkoPQ4N7rFHpJOLVYegZUW
X-Gm-Gg: Acq92OHFUysGpoG9DJrXgGl8XUEiRtKT83eIgly/L14Wu87LSLkLjm8m9Uyr0vzubaD
	rLwXDMRU62oD+aehZ/A+ie/8ov60T67JuO62fge2m4psu27SGkc6Pf5n72Ak7pgc611WYfanc/T
	ELolc3GzlSbsChk+T8NzkBFu+k4XybPz7OMJE5Md4LKAv2sxl3pOQl4kn5eQ0oRk3WewtBQ8wyh
	0vf2qx+aSwLSyDUEZD6QZ+nvGHSnpvvuMm1SXgLGdsJgwk58WpZX1+lXm/lZ/RpMU5Q77Wc5vQ2
	mV+Y5/nJ8yGT6F0Mj2K9MeCoYSvM+0Zw070PsLltjjyhCQuQe34V6fp/40pCPsGdakG8i0v+UdX
	1IogHzaeXD1TYePTt1EURDbovW1m0bTuui9ys9EHtbxiVxLjYrY80WAcrShyAjrF4jrDe5TNf1q
	R0ooyuwkIJIimLOcB+6BsFH7z2RsKRZ2K4OkWM/X6G3tKX4V9P/nu53aS7SqfL3Mj+Aa4=
X-Received: by 2002:a17:902:fc43:b0:2c0:a555:80e6 with SMTP id d9443c01a7336-2c0a555946cmr65698295ad.6.1780270160982;
        Sun, 31 May 2026 16:29:20 -0700 (PDT)
Received: from BM5220 (123-194-40-181.dynamic.kbronet.com.tw. [123.194.40.181])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c85772d7342sm7954473a12.26.2026.05.31.16.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 16:29:20 -0700 (PDT)
From: Zenm Chen <zenmchen@gmail.com>
To: linux-wireless@vger.kernel.org,
	pkshih@realtek.com,
	rtl8821cerfe2@gmail.com
Cc: zenmchen@gmail.com
Subject: [PATCH rtw-next v2 1/5] wifi: rtw89: 8831bu: Add support for ELECOM WD{B,C}-X600DU2M-B
Date: Mon,  1 Jun 2026 07:29:10 +0800
Message-ID: <20260531232914.4406-1-zenmchen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,realtek.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-37217-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zenmchen@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 16C8F61846A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add the ids 056e:4027 and 056e:4028 into the device table to support
ELECOM WD{B,C}-X600DU2M-B, two new 8831bu-based adapters.

Compile tested only.

Link: https://github.com/morrownr/rtw89/commit/9e2db2834b37c6adfc4b872a9ef56c927df22bea
Signed-off-by: Zenm Chen <zenmchen@gmail.com>
---
v2:
 - Add missing "Link: "
---
 drivers/net/wireless/realtek/rtw89/rtw8851bu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851bu.c b/drivers/net/wireless/realtek/rtw89/rtw8851bu.c
index 6a8d31544..343941ccb 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851bu.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851bu.c
@@ -37,6 +37,12 @@ static const struct rtw89_driver_info rtw89_8851bu_info = {
 };
 
 static const struct usb_device_id rtw_8851bu_id_table[] = {
+	/* ELECOM WDC-X600DU2M-B */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x056e, 0x4027, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&rtw89_8851bu_info },
+	/* ELECOM WDB-X600DU2M-B */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x056e, 0x4028, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&rtw89_8851bu_info },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x0bda, 0xb831, 0xff, 0xff, 0xff),
 	  .driver_info = (kernel_ulong_t)&rtw89_8851bu_info },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x0bda, 0xb851, 0xff, 0xff, 0xff),
-- 
2.53.0


