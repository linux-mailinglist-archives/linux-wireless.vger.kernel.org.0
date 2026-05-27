Return-Path: <linux-wireless+bounces-36969-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AN5dFM91FmqemgcAu9opvQ
	(envelope-from <linux-wireless+bounces-36969-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 06:40:47 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DAAC5DF35E
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 06:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6AAFC302E92D
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 04:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478DD45039;
	Wed, 27 May 2026 04:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDNjAOrQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9DD27BF7C
	for <linux-wireless@vger.kernel.org>; Wed, 27 May 2026 04:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779856836; cv=none; b=TGYcWKHaFJDRqvCy++6EcTKekOwNqsycFiYJtwFI6R3pLl8bLjWDVcMMblNN4JWRGezycJVwvfQkd9qj5OC96nc4+rCg0AepW06yaVJnmJ/LXx6lsG9DGXJp7WzLYwqTW/iNPsVqioUtyoTZir4ZfYJVoQYy5G4pdH/jhJKfXTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779856836; c=relaxed/simple;
	bh=I79vrdJ0YuLDle72iJ33WaTTLLWQo5iXusCeP5PS3fo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s9lBlDFCS3qUb6toLsWVdNh5j/wtSssd9lmy76IuTeWNu721F5jD4WvTqNrC6M3/a8pS6dHI+myy7coO1mPKDdCwEACXJGMLFBU6TlXL0CcFqkU0kUMtxben0nXJ0/bDTpkFBWGger2ruM7cd9XsSBPiU+8qTNVm/88WShDZIaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TDNjAOrQ; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8353ca0f1f1so4996552b3a.1
        for <linux-wireless@vger.kernel.org>; Tue, 26 May 2026 21:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779856834; x=1780461634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kd7bzvFHSba8IzvbBYoSVdmlrckNt5UQDKgAB0Vk7/0=;
        b=TDNjAOrQg8tTjczj1zQajIi16fR8QqL1bSgpDNHoMUB9uzXytc2qhbToTCxjGl9GG2
         jcKeHYZNF6WPA3wGfWppsui75HaKsre46JeJwt7eQcbi9+s08BJGUPWE0ltAH5y8iSb1
         wkDGcMMqFMdJ7X8vN0rAMf08eD+UtwdhW/QmTIXwP95P/trvbWx3MlOOhi0hU5Auy4Zy
         lnNdLyF5es3JhIOoma9qL60CnFO69uRkDO2BmcFbN7/MSUErtgH2hiHLOcQUtuEf3/b9
         9W6mQH9u5RBCzBoqU6T6edRf8ISVpEEi/AWXNTKwWsiU6Ck4m9BD+VtB9HqTL7IAnR2x
         d+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779856834; x=1780461634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kd7bzvFHSba8IzvbBYoSVdmlrckNt5UQDKgAB0Vk7/0=;
        b=lXLbL478r3aYAXCGMmQGTXXA1BGVLvoFEo/xQAhP6HtvVXP5YLVMK83dMU9wLMgjAX
         POIHh8mdZ8kGySchGCQmSXlH0HzD8oP5KOHjRPJ2l6olkKoOhGNzip755JMeG22nfl0k
         kzhkcpzsveRCOPMHEnslehRXYwMmWMjAAzwaneU9oJQcDz9xP36pT6hMWFPBQpfsUaIi
         3EZNh56DDqKBnF2fmuUIk/HOLE9DlWfTcVaRfdfV7DPiR/iGYkafphfFWWC7q6DNqil7
         lrPCrQIbcNpGe/DVZDU0aGm3wTJqtTqBmP+1nE6J5+NTfTe7oqAgBiY2d7Xii1fKEWMG
         BSig==
X-Gm-Message-State: AOJu0YyUK7eUQlcJzB2E4CdNPyUeY30FLlV2I10Qm1jbPK+eFmbpzGzs
	iPW7aOVfI3p6NS06WXrQ+Hosi46pJ9ax5xwCzOpSAFpPBMECerRLIqPoNLb4d+My
X-Gm-Gg: Acq92OF+LR7wytNUB+8XhgbHZOjXXWGVpStpl9SY8jx3M8U9Ed7xD21MdioxtFwcN66
	Xhd5X9uq9CKiYrHj1HyNpPpO2JJ7qmmALQnqtCL0r9ORorRxHaxxMG4ahR0t8U2YN+0UaAsKCrV
	W3MZmKqum3mUFmkJHEM8wQznqdZNuYuy/Otxmlf5RdxSjaTDa7thQRPNww+OuwHkIMoKusSu4L3
	D4nKcKrasXDiPpDhqxj3eEgK8yczh5kxSq1WVFQ9fUOGW23wjHna66CCekYTyeGNySUrK+n4WNF
	0tYNWmCdQTRsAqVNMlj+NhToo/xyMHrAq7gXG4G1tzridvYQOMGOYo8NCK/fGZNh9IDaaoHPoG7
	2w8IGkp3D4s6MFp4Bp0Q/gR4NHqveG75GdJ6kOZ6JAiYp3KlAc9evmkCyO7ZETHvzkJD1Yb6DuU
	oAJIsKAY/BUeR+JMueY/16eoguhgYlE3/QwIDwgabZ1FQdDgcHCs2F3HbQWqRPD7/Q6A==
X-Received: by 2002:a05:6a00:4291:b0:835:51fd:b7ea with SMTP id d2e1a72fcca58-8414b5005dcmr19192158b3a.19.1779856834144;
        Tue, 26 May 2026 21:40:34 -0700 (PDT)
Received: from BM5220 (123-194-40-181.dynamic.kbronet.com.tw. [123.194.40.181])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-841d6e806c7sm907522b3a.1.2026.05.26.21.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 21:40:33 -0700 (PDT)
From: Zenm Chen <zenmchen@gmail.com>
To: linux-wireless@vger.kernel.org,
	pkshih@realtek.com,
	rtl8821cerfe2@gmail.com
Cc: zenmchen@gmail.com
Subject: [PATCH rtw-next 3/5] wifi: rtw89: 8832bu: Add support for I-O DATA WN-DAX1200U
Date: Wed, 27 May 2026 12:40:17 +0800
Message-ID: <20260527044019.9192-3-zenmchen@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,realtek.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-36969-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9DAAC5DF35E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add the id 04bb:095b into the device table to support I-O DATA WN-DAX1200U,
an 8832bu-based adapter.

Compile tested only.

https://github.com/morrownr/rtw89/commit/b22949056cfccf85a96540b2c0bd4d32e76cab0f
Signed-off-by: Zenm Chen <zenmchen@gmail.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8852bu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bu.c b/drivers/net/wireless/realtek/rtw89/rtw8852bu.c
index 37111fed2..35fdde1cf 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bu.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bu.c
@@ -37,6 +37,8 @@ static const struct rtw89_driver_info rtw89_8852bu_info = {
 };
 
 static const struct usb_device_id rtw_8852bu_id_table[] = {
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x04bb, 0x095b, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&rtw89_8852bu_info },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x0bda, 0xb832, 0xff, 0xff, 0xff),
 	  .driver_info = (kernel_ulong_t)&rtw89_8852bu_info },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x0bda, 0xb83a, 0xff, 0xff, 0xff),
-- 
2.53.0


