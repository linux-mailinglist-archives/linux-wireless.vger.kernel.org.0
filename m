Return-Path: <linux-wireless+bounces-36971-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AUPAsx1FmqemgcAu9opvQ
	(envelope-from <linux-wireless+bounces-36971-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 06:40:44 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B52235DF356
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 06:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 650BA302EA94
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 04:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7142E2850;
	Wed, 27 May 2026 04:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ddms8OkL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14382C030E
	for <linux-wireless@vger.kernel.org>; Wed, 27 May 2026 04:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779856840; cv=none; b=QwlClniF644UO60WUmxm7agrDb1QK8rJaa8d18Hez3rA/OMLVjy0hlNL+yatovTsdSvIP+RQxcUXIxfh2ZVDrNJpJxg7nzUvo1yrf0fjWFein0IUNy0cUaBIAkSn6gZJM9LRIVQasdXyjTz0R1mSt2KgC9ub3/2WhHYho5VKlhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779856840; c=relaxed/simple;
	bh=x+8xAlO7AmV29xhuZaf7AsO2gdO25YSoAIBuSIcVy7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q+jOrPvPwxPBa0IB3kNj0lgFs+n7FUNfxEHFk/dPtLSNzU7JbwwJ78WMtKm2U09WotCHGjd+Xz82tOrNWYe8SoYRVYXwBuhOw9lZMw42NSSmyWh4PjgMXbeebLwbkN4EYhcHNFJJQ59505bs74V9fMiDSZx7A340OzmzZRcE2Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ddms8OkL; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82f8b60e485so4795285b3a.0
        for <linux-wireless@vger.kernel.org>; Tue, 26 May 2026 21:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779856838; x=1780461638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PkQIc9nnDAC8Ipe8grf9T7HhxQA/wAN0WHCn158rw98=;
        b=Ddms8OkLe+EqWYVtuOL2Ol+13twC2cLHthUNuydmM/6g91X2UVGcau5FbgNNmLJcdE
         Iq6zuMdcRZ9IONmrTUXgaSXPQrXhtXdNV4gToSO0caWBIHdMmgRhiwps8Ncvxl0W5v+d
         dYv65UKP85JhYAXxyjG99eOfSi/mZu1DnCol8i2fW44tActtCs84O183Y+YtPmEAqAnu
         czJRE6RDldoU/eO4gIqYD92HzsQmvoNk28+dT8Odo8+jXhd5CF8LFqei1APkI/r1b8i5
         Dd4u8rT4qx69+scYvjaLjSxZmEJE/kI4pU6N74tQ/w7SAOdh9U5smtIVibiwDma9+q+R
         LCeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779856838; x=1780461638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PkQIc9nnDAC8Ipe8grf9T7HhxQA/wAN0WHCn158rw98=;
        b=k0kBWegQ4eqHmfq5Vk0CMDjEsolVVUqYZYEsCaTiChb8kisDgoON97k7z69BlRAj8W
         mmDxaKhLUkDcAG0ggNp9nQPbXqAgsl1AZIOdAXFD1+NaB6cUzB9fJB8bl9FRvfCxHeNn
         d9p56A/7upEafwYT9jQGl+N9k+OHROC45tI66rWOCzmJnyD+Lf1YlyZu+EpQ3T6gRM33
         cd8pAs/ackX7fpT7m2SRmvloEPj6DyUCfsP67gZ0AV4PeyvUMoi8uPz1/cgRHKJSSm78
         w+pjiR+6eNUiofqlnwLhVdSBJgkTELmA5NHxiJLRKJN1b/L7R3iwSjUUNE4UsPefYSR+
         Ohlg==
X-Gm-Message-State: AOJu0YxmoV/B/cDOrCWeLG/ToXwYUSYnkT/1ytD0Ismr0naLj8w9xncQ
	aGpDj8Sxx7ZxSlCL8wvkJRy7lvYHWS3hEzoeOvVME8ZJsF+X4G8Y8r3K5EwKDapl
X-Gm-Gg: Acq92OE6e1FAzhr0JLAsHlM2o9E4Tp5Rqp5agc4BUcpwJq0gXtU69crRFxsm+PVIits
	mydiTFQGlobdhpJcqvqJ/RYUzkvhXJQ0wLFXnLZNBZeDdLFFdQqKd+NTJBlv9MzYDvecnCQM80o
	46Gt4hfH675f1JMCEKERxBjUnPca1HX8F514afpEUwx84lgxTL1MOE54rWyKIA1PNbmaH9IDFLJ
	ntPj7+EkjOJeyRfB2l8BPb1SxIfrhpcVvjlUwHwN0f53Zct1gV0YcNVCmasLF8jPcG+dOsyi9d4
	T3kEz+4G8vVOI8+OpIEnISUOkx/jRYp1HeZSg/TW+wGDm3cbZEM4JgAzWlk9Bt5CoPC8xkZn0qj
	ObofwcRaMMPHq5nZ9z50jmlIf01WhP98lmI/JOQG/qP7XtacYjWnHCgMyD3A8n9e+mlrPHTxuJX
	ER/2vRI9qcMFHqtBzieAXOXVFT0SHimBziWfe+LO4oiDooCYfA8qDb1k8=
X-Received: by 2002:a05:6a00:189e:b0:82c:d6d3:3190 with SMTP id d2e1a72fcca58-8415f363760mr21104766b3a.38.1779856838144;
        Tue, 26 May 2026 21:40:38 -0700 (PDT)
Received: from BM5220 (123-194-40-181.dynamic.kbronet.com.tw. [123.194.40.181])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-841d6e806c7sm907522b3a.1.2026.05.26.21.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 21:40:37 -0700 (PDT)
From: Zenm Chen <zenmchen@gmail.com>
To: linux-wireless@vger.kernel.org,
	pkshih@realtek.com,
	rtl8821cerfe2@gmail.com
Cc: zenmchen@gmail.com
Subject: [PATCH rtw-next 5/5] wifi: rtw89: 8912au: Add support for Mercusys MA37BEH
Date: Wed, 27 May 2026 12:40:19 +0800
Message-ID: <20260527044019.9192-5-zenmchen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260527044019.9192-1-zenmchen@gmail.com>
References: <20260527044019.9192-1-zenmchen@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,realtek.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-36971-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zenmchen@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B52235DF356
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add the id 2c4e:0125 into the device table to support Mercusys MA37BEH,
a new 8912au-based adapter.

Compile tested only.

https://github.com/morrownr/rtw89/commit/73cd715afee2dda3f670cdae5e40fbeba7d9be36
Signed-off-by: Zenm Chen <zenmchen@gmail.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8922au.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922au.c b/drivers/net/wireless/realtek/rtw89/rtw8922au.c
index 347bde171..8d22bb387 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922au.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922au.c
@@ -56,6 +56,8 @@ static const struct usb_device_id rtw_8922au_id_table[] = {
 	  .driver_info = (kernel_ulong_t)&rtw89_8922au_info },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x2001, 0x332b, 0xff, 0xff, 0xff),
 	  .driver_info = (kernel_ulong_t)&rtw89_8922au_info },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2c4e, 0x0125, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&rtw89_8922au_info },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x3625, 0x010a, 0xff, 0xff, 0xff),
 	  .driver_info = (kernel_ulong_t)&rtw89_8922au_info },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x37ad, 0x0100, 0xff, 0xff, 0xff),
-- 
2.53.0


