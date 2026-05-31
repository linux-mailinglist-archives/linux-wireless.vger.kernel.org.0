Return-Path: <linux-wireless+bounces-37218-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uEW0EVvEHGpNSQkAu9opvQ
	(envelope-from <linux-wireless+bounces-37218-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 01:29:31 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B8361846B
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 01:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 37805300DD59
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 23:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB3F37475B;
	Sun, 31 May 2026 23:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H3mgp0us"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F82D233934
	for <linux-wireless@vger.kernel.org>; Sun, 31 May 2026 23:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780270165; cv=none; b=IJyrsEIrq72ac6fghrs3+r/acJUV2tEbKaphRVKgZWPScJ9k+qQnOrriLPH/BstWUzP52xHDodrq9hxj4Axg3N7aQ9JuvCh2YPoaFS0Z5CgDwb4CzuNH3xRSUZMX7XXaTQBaZtF7bpx0VHzbALsL97WoeA+4SMbcPTc8XtsMtqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780270165; c=relaxed/simple;
	bh=IJ8y4+k4DC8Qquyh8cwdMgkv071HsqdflUcMngANEVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CIga3TMZNygJy1hGRbiVVfsvG+Br4I9hDQCeN8HUjLFcR4yuD5khcy9T3PRzQvk3U7RDXmtYFLzY6qy53DEzyZ5m6/CwxPLywBSgNHXqs2RkOeZZtdEebrTtioy97gGb3MTterEMWgh+pnXAXTqxj3Kin8p8kJs2100q+JMY4YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H3mgp0us; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c8532ba6c95so2687794a12.0
        for <linux-wireless@vger.kernel.org>; Sun, 31 May 2026 16:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780270163; x=1780874963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QxtKvNHTyAra2bO0mdC+VjlnnnlYmp362bUaBabvCds=;
        b=H3mgp0usPSRNW8mKoLs9y4rqvnfds6UXFPSKnVWNis8KtjGR678b20sGO+Y8IEiaPC
         7fcK/Ffb5Q/KEnGinMp7wkuNl9HacTylJJU33quy/Ppra1aCOD4oecSTBNfl5u3tphxp
         j/egDTQWPZSa7aQPdpRd2zkDZyjPDmvnQ3+HyljvRO3joc2Rwr88ECYZhf/DYm9jZ8F/
         /H1uxFKLegtoj6ArrkoZnpSKct+ZFRv11K1AmrWcnQv1OlDrnZac9kKAc08v2bJS/2Ck
         9JII3gxRT5FBZ/F0vO0A7rZex3bvz78SlV51EdVMQu1Py2LhtZWcu+ysbFOvwS13Vjft
         pwJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780270163; x=1780874963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QxtKvNHTyAra2bO0mdC+VjlnnnlYmp362bUaBabvCds=;
        b=GjW0fYsRXBK0oU7KZOyDnBDRUDv0Ikvv1W8HWiYSYC1FPuEl0f/dFAT2x3neG9/i/l
         vcPe1xcdM0FaYH+o6htk+1NubeSTTSMI8avrdcYN3RLuVkE68pkrkDOcj6y2pepMAEkn
         33S8jxo7GJuwkHjcLM+Rr/TRC2Z2/5RVRN0XIkqB/YcuX5zMUYp9JMKnSe1XZaAjcQ1P
         SelWbcBvTKNr9TKIwHZZ7e8yXcdE89BW2neUclRE+ANBi5SC/G+rZefgh+87GOTSAQE4
         sKIZyPfYuDRrzrWlwMM9q1Lx34jaGPFH/pord9NC++9w6f1bHF6t2CD/lEwZzFh4elgj
         gNYg==
X-Gm-Message-State: AOJu0YxxRuN+vhRKH1cGtaN/YaZsfxtPgYzH37CmMPzr1uByvjLtMH1j
	+iLGchT0bIJtS8L7lbnoogdRJKbZSXcGHpm/tNgUJW9oR5Sa/BE6Pl7xrGlMhw35
X-Gm-Gg: Acq92OEuRKTYkdopPb26Da9X2W0kseeDqoduzuHWJw3xEUx+cNZ99xU0qjeFP5uNkVT
	fOMW9ncdcNckKDPu0Z14How4K0T54tIgqrHSGloW0f6U/6D/nUCkrD7/Xr3qP+miemHp0y5rdpY
	Ykud0T899fdJz02/uP8whNgEMmKcqET0dqTOsKqVNs6t7Cn53F1pDmLeJ3Xhr8vRIJfz7Z4uV0I
	1TYWNVGr4tqb0yNtGMS9/QQJy2mGFPSmTvDat/Mc9L4RJXGZDXXQt3Co3YxGSD9TuqTmbMlTPQf
	nZHtgnDcdSyutLg4VTjmRWoeToQHplUOjI5VQa3TVXgDHry5wq4vY6bocY71gGM19if3rACIK8/
	q9uCDdLcATBxXvuxUVRRyEhA+IdtDmQSePaVsLCfYXaxOxsdLC/8CaTA4HuVOFYE5vZPjaJXWzQ
	/Wj4lfwkTxCy+tG5hS4cdR+l9VywQPK6z/Oqjur5XlYgN2e2+49IEBg71ll3AabD/b34yHyoGZ9
	5yXvw==
X-Received: by 2002:a05:6300:189:b0:39b:89e0:2e37 with SMTP id adf61e73a8af0-3b427c23375mr8726003637.14.1780270163030;
        Sun, 31 May 2026 16:29:23 -0700 (PDT)
Received: from BM5220 (123-194-40-181.dynamic.kbronet.com.tw. [123.194.40.181])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c85772d7342sm7954473a12.26.2026.05.31.16.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 16:29:22 -0700 (PDT)
From: Zenm Chen <zenmchen@gmail.com>
To: linux-wireless@vger.kernel.org,
	pkshih@realtek.com,
	rtl8821cerfe2@gmail.com
Cc: zenmchen@gmail.com
Subject: [PATCH rtw-next v2 2/5] wifi: rtw89: 8832au: Support two additional devices
Date: Mon,  1 Jun 2026 07:29:11 +0800
Message-ID: <20260531232914.4406-2-zenmchen@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,realtek.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-37218-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
X-Rspamd-Queue-Id: C9B8361846B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add two new ids into the device table to support the following 8832au-based
adapters:
 - Mercusys MA72XH (2c4e:0124)
 - TP-Link Archer TX23U (37ad:0102)

Compile tested only.

Link: https://github.com/morrownr/rtw89/commit/82b789a0f1f41e3148ecf302b4dd8f11d2d68713
Link: https://github.com/morrownr/rtw89/commit/f2e2a70eef253b4d3fc8906c99311dbc4d9f6aab
Signed-off-by: Zenm Chen <zenmchen@gmail.com>
---
v2:
 - No change.
---
 drivers/net/wireless/realtek/rtw89/rtw8852au.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852au.c b/drivers/net/wireless/realtek/rtw89/rtw8852au.c
index 4cced4619..b3f2690cd 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852au.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852au.c
@@ -63,10 +63,14 @@ static const struct usb_device_id rtw_8852au_id_table[] = {
 	  .driver_info = (kernel_ulong_t)&rtw89_8852au_info },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x2357, 0x0141, 0xff, 0xff, 0xff),
 	  .driver_info = (kernel_ulong_t)&rtw89_8852au_info },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2c4e, 0x0124, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&rtw89_8852au_info },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x3625, 0x010d, 0xff, 0xff, 0xff),
 	  .driver_info = (kernel_ulong_t)&rtw89_8852au_info },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x3625, 0x010f, 0xff, 0xff, 0xff),
 	  .driver_info = (kernel_ulong_t)&rtw89_8852au_info },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x37ad, 0x0102, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&rtw89_8852au_info },
 	{},
 };
 MODULE_DEVICE_TABLE(usb, rtw_8852au_id_table);
-- 
2.53.0


