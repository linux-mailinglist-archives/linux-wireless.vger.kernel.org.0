Return-Path: <linux-wireless+bounces-37219-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IG4dHV/EHGpNSQkAu9opvQ
	(envelope-from <linux-wireless+bounces-37219-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 01:29:35 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCAC618479
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 01:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0224B3004C8A
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 23:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FBDE233934;
	Sun, 31 May 2026 23:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rEu5z+d5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BBA377567
	for <linux-wireless@vger.kernel.org>; Sun, 31 May 2026 23:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780270167; cv=none; b=mQ5GZWkGGUL+XDJ0dxIjv4JnzD3zf9g1ZKxtBXXe7VpIKFZvwrE00f7+CEMHLPHrFB70MiXniCZOBo7ygHXgT/tWu0ciTUapZZx6zHpRu0Q4VyyLI8QO5IrnoUSeF1yyKJpbnAdlYdARzQJXnQk3Nnu7KJxy2L+FvOdqMXbWxd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780270167; c=relaxed/simple;
	bh=uY+j8ZX65K4Ukz96UhDBjC66scQpuP+369M6Xzn4/lw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kg7Z6oTvXDHcmiWm9JY+qBPHgF0SDsindxO2EmE7DfgtqlPe1esSIEnMgS3W29JicgWLtnhNoGz/924ZqI+VG+to7QGFTz4ycJK6X1as4rnxk3jtyTWtVZZ03fe+Jt+HV6OXzjpEkc33f17BMdEI3uEXZLhW4f2PbAE5/3x8QNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rEu5z+d5; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c8584e80bd3so528671a12.3
        for <linux-wireless@vger.kernel.org>; Sun, 31 May 2026 16:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780270165; x=1780874965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SYQ4jLxkqFrp5d+Bt25Ycnu8NiFOyzOUhbSZcCZQxcI=;
        b=rEu5z+d5ywcdeISWgObN2GZLb3paULKji7v/iv5uRJcYJX4OWlTziSsKB0XWjxsk+V
         w61vR0mCVzgSb75CKcWn5zqOJsLFpIA5BcupHYodsadRg6JN+A9oy5OCt2FKhjgGnPP6
         k+G/rpJ4bCAg4gD/NfwK+OMNpcT2ZMXoAolQKooKXp31tos4rJ4f8S2Ni195DVCjeDlY
         OtVQ8rSpn4aIJ9YpNGd3zMGnQ5YLNLv1KbCcmKxLw9iY/GkXziI0ORsH6szSLP34POqG
         ctSsgqdJPKPZGqR9hr9O8W2FuAZnDqX1treIa+VJOe5Zh9qw6TkkRuxAy3lp2mDzmWjr
         W97A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780270165; x=1780874965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SYQ4jLxkqFrp5d+Bt25Ycnu8NiFOyzOUhbSZcCZQxcI=;
        b=i/V6sv0+i/kIum6aqwqUyct7UOKpvZPNtU4PWb8/30tXqEdLFZ6KML8mO2xz2r3ocH
         HDu3M5kE9TyBJe7+JO/ARZW9rfyOZP6ra551PyhBJgUiAMUAQ+oR3W6qXMLzKlM+oosh
         lw6AIBOXVtQWkWIFVh3HGa3iNQ3YvOHO2tRD/BUP/kDikFsmnfwcIf2JExlPNyhhyHY4
         G23VV1l1zJnVz3TmOmDhGjL8GL83Hm4ZN4OeHGftICHrz7LaPdEKPvZWFfV0H6zGk62g
         kBKRde4DRBVe9Dnd6/cTKaJOtM8Uc5vvNBXZVHtzlif54WryLIC+bE430SXwKr4LttAN
         kh0Q==
X-Gm-Message-State: AOJu0YwCl5dzndMNjFu0uZkSJpqA4+LeW13eZkEjSkllw8BL1RSulYJG
	dXol1ECgoFl8v6FPMJAcVWYVFtMHTQD7p3Fnq93/YhYS/zhOQtfWykNIvPXGc8QD
X-Gm-Gg: Acq92OH/wYrlFA0zGNRPpAB8yAQf//1DxFHyh1Km3pYxQSOqRVE1gKT9xBS2UG+LQps
	pN3X+jB2ukDmIRIedd5IlB2a6TSSapLedM2rL6Ka5295YM1dT9uqHp3p4g9UXoZCHBQNqUntkuY
	nzrVYaIiTckbb8BAOHblFgz6bOBw5xOrO1TShfpUhTK8Nif4ZfQICCcXPUN2o69MN81uyjBX4gB
	M98054bBMVpsYVaC6skbWZY8HrxiDOtI86mdFLn11QaiF5zRQPr3zrZkkgU3PThjFYP2pDEgedA
	hDDfEku8hHA+HbyCXa1x848uLuvGZ7FJlOte/eUI4YXNgAtrrfwapVzl6yAzA9d15XgikG+L6Y+
	bGKpJsDgBJMraFJHTiFxvNn+i8vyOtjpbfKC05/sCiuv/3rJjERLlsM2CmyxVtK0lkVvRRRENEX
	Y0hvwsSRUlYs8+w0789JTXZgY1JNyouGqF5sSd1fcQLdSRWS+Im2PH1whFhQvkRwj2jvk=
X-Received: by 2002:a05:6a20:b786:b0:3b3:cea:874d with SMTP id adf61e73a8af0-3b428014460mr8924555637.18.1780270165123;
        Sun, 31 May 2026 16:29:25 -0700 (PDT)
Received: from BM5220 (123-194-40-181.dynamic.kbronet.com.tw. [123.194.40.181])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c85772d7342sm7954473a12.26.2026.05.31.16.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 16:29:24 -0700 (PDT)
From: Zenm Chen <zenmchen@gmail.com>
To: linux-wireless@vger.kernel.org,
	pkshih@realtek.com,
	rtl8821cerfe2@gmail.com
Cc: zenmchen@gmail.com
Subject: [PATCH rtw-next v2 3/5] wifi: rtw89: 8832bu: Add support for I-O DATA WN-DAX1200U
Date: Mon,  1 Jun 2026 07:29:12 +0800
Message-ID: <20260531232914.4406-3-zenmchen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260531232914.4406-1-zenmchen@gmail.com>
References: <20260531232914.4406-1-zenmchen@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,realtek.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-37219-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
X-Rspamd-Queue-Id: 7DCAC618479
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add the id 04bb:095b into the device table to support I-O DATA WN-DAX1200U,
an 8832bu-based adapter.

Compile tested only.

Link: https://github.com/morrownr/rtw89/commit/b22949056cfccf85a96540b2c0bd4d32e76cab0f
Signed-off-by: Zenm Chen <zenmchen@gmail.com>
---
v2:
 - Add missing "Link: "
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


