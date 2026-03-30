Return-Path: <linux-wireless+bounces-34175-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJ3rJNVEymm/7AUAu9opvQ
	(envelope-from <linux-wireless+bounces-34175-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 11:39:33 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFD4358528
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 11:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68AE8302BDED
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 09:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA60D3AC0FE;
	Mon, 30 Mar 2026 09:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4HXWDsd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E8E3AC0EE
	for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 09:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774863288; cv=none; b=hJso5dbqHPoLJ6ku57faWurnRklBg63WWCuXtE5ly4wQhcGcuPzeMDkPi4n65wsXHaRwaqdwllIJ7fCSPiNsWT8XV5RAW2EhUE+ll8995t2FF4rmk6tNjShp3ejzYPHvIL9Wrd8uEYpMJQARFxCC6MO5TKd6Tw/suT4NbQpUG9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774863288; c=relaxed/simple;
	bh=VINwoavDK9DU941cqg8iZRVirwNKWjFD1mWWpXZtQfU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HLACienLEoZXBfj1SV0Kgk/Yro3iK5z/Umtr7mCOoyt+sCPJ6IkmdlXhz8brYZreTKQNBRduLfQD48nXCLyk4PwF/7rFNzvH/56ehxsH/uq+C5keqPa/XDyEsHB9RXYpg55DLe06af+2iYot8aVGisRAPkP9SDll2Wl2wD4E4Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R4HXWDsd; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2b2589c26e3so2968025ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 02:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774863287; x=1775468087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wFV+hqOD9sKqCRhaTtbXB0/RtdapcEP2Rmsg9aDRycY=;
        b=R4HXWDsdowbuN2CZkFDHi880aXA2wca6tcUpeeTmHCVRfvKGe1hw8aOUVhCmzZ+/oV
         DB/xuh5TCTPkDCBW6Iu2T1JxR+FEMAfGPs/i/i73VHweqCAxob1dT3wR6ZLES3Ta2t3g
         0Y3gvot9xWBEfXY9QpmgyfDM+EXdL7+how4HzaA1T8PyGutxrg/q47iztI3NDF/ZA9Vz
         qgr+JupkPD/Cm/HuQaAnHVMkleE5JT4ohFDu6ZVrBA6JGHHonGNb5LMJR8V3iFUB+siN
         2p+F6tAI/c1cXEf0My9guFlDMMYKqqgiTiO8YcnsGW6q9mbSZs2nlZn+VNZ0bQjK5CBz
         xTrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774863287; x=1775468087;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wFV+hqOD9sKqCRhaTtbXB0/RtdapcEP2Rmsg9aDRycY=;
        b=XJa8Rou0/Ud6fvzEqsdAmFwpcrx2BlUSxBotiAmXX44HZN5cjOstln+0PcUN94UcrR
         MQMNHunFM/Um7fmIvamUixedAin0ejcD2EoWBenFrhQk+WAIOubK4Fq4ssI2Zasd03+Z
         +Ld+c3xniWvJUC1OzjbVQzfScRXhEBxg2dJQfQRlI/DhNqX1uAojA79ezEzgcOTx7uKY
         denz6AV9DjF3KxPzetJZZxWB+htw8XNPMGqKGddhEjlHRe+Hnp8+2YjccB79EQgbdgr3
         1H5Kaqc9z7lPuLVQKflFcNCCN7qyrq1UaQ0CGnqHR/B5hKIUc2Wt8Xom+uUMSP1rFR3k
         TCuQ==
X-Gm-Message-State: AOJu0YyAvYaDArls5PZ2X1CSCU5QnOdfeGXRKWYkrgYu1WnUjh3+/9y0
	Eon3rEW7h6EFf4Mr4EZ5TELMlflY/ykKMrQv1bg5gqX4NClTNZJ9zdOWwM8RtOOv
X-Gm-Gg: ATEYQzwskwfk24DFs/EKEy8VxG3HVNl5riaMuM/ZmK6+XBTJuDqL664kLMGo0xrgh4+
	cqYiWOoCzSjFgt51gkMshaZijsbJj4fIXlH5PYIIxJiH77S5k1YHHOXknRqrYitNu0WO9WqUgT9
	aeeQPlug50WCrPylw/pDRq4omentTzMblin94y/W+dFFhJj2ml+QbWY5CNQwhtt2HyORUmB9eLR
	0MdYH2WBuAyza8tt3nTFopNZLFHQhj+r5WSxPaW2AxZFPYcQzC2ugOlozCqsziCbhbOev7G6AHh
	TdqTF1G7M/f7qYu4tRcBLrtDjqtmOyxl74LOSM96bZ9brqevPSO6mWsRNr28v+WQCvDx+Wny9sc
	9W/5z3Z6oY0lGMhLue01nCz+2gRphrU26PkepfhXFKtl6nGCEMwLwWpJ2yRNXUjiVIAErnsi/un
	2/f0FRHYtQINhOiG9VParYaIok/1PKXrt4OdnWI+uXzFgxjKXyAiAB/z4sQcb4N8tE
X-Received: by 2002:a17:902:ea0f:b0:2ae:55eb:f82d with SMTP id d9443c01a7336-2b0cdc1fa6cmr121626765ad.1.1774863286680;
        Mon, 30 Mar 2026 02:34:46 -0700 (PDT)
Received: from BM5220 (118-232-8-190.dynamic.kbronet.com.tw. [118.232.8.190])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2b24265e7basm96283015ad.21.2026.03.30.02.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 02:34:46 -0700 (PDT)
From: Zenm Chen <zenmchen@gmail.com>
To: linux-wireless@vger.kernel.org,
	pkshih@realtek.com,
	rtl8821cerfe2@gmail.com
Cc: zenmchen@gmail.com
Subject: [PATCH rtw-next] wifi: rtw89: Add support for Elecom WDC-XE2402TU3-B
Date: Mon, 30 Mar 2026 17:34:39 +0800
Message-ID: <20260330093440.3615-1-zenmchen@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,realtek.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-34175-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: 1CFD4358528
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add the ID 056e:4024 to the table to support an additional RTL8832CU
adapter: Elecom WDC-XE2402TU3-B.

Link: https://github.com/morrownr/rtw89/commit/55c059e2bd49acd5cf93edbc8eda7b9e042f4efd
Signed-off-by: Zenm Chen <zenmchen@gmail.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8852cu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852cu.c b/drivers/net/wireless/realtek/rtw89/rtw8852cu.c
index de3f8358b..092d2812a 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852cu.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852cu.c
@@ -41,6 +41,8 @@ static const struct rtw89_driver_info rtw89_8852cu_info = {
 static const struct usb_device_id rtw_8852cu_id_table[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x0411, 0x03a6, 0xff, 0xff, 0xff),
 	  .driver_info = (kernel_ulong_t)&rtw89_8852cu_info },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x056e, 0x4024, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&rtw89_8852cu_info },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x0bda, 0xc832, 0xff, 0xff, 0xff),
 	  .driver_info = (kernel_ulong_t)&rtw89_8852cu_info },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x0bda, 0xc85a, 0xff, 0xff, 0xff),
-- 
2.53.0


