Return-Path: <linux-wireless+bounces-29506-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4DBCA5BF9
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Dec 2025 01:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 808E23105621
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Dec 2025 00:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A1418FDBE;
	Fri,  5 Dec 2025 00:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JbQdndZ8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F4B16DEB0
	for <linux-wireless@vger.kernel.org>; Fri,  5 Dec 2025 00:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764894798; cv=none; b=moxqmodNlgBbREPHhNF+T4iVD4qDxRmCKYmAa4kEUAjNpanGNFIJU0YjP6y4ZpdSeOVY1XWgfBVAmzat/LHh2UmqXKiANaAgyo67fBFCViZnXiI5Y6uHeksBs+twArqZ+A2pI6AXOmjf1gIIEtb1JxyYDfHVaWg4j1fPNYdu51s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764894798; c=relaxed/simple;
	bh=QbPZipajEq0/83jfjCQehmX2C4Z5zNxc8erPR/a/IGE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ooi+DO0f0HfcVYaoifhqG1BWvPP6t5YqBlb4/h7mM9IrKb/Si5a/9Hg3alWaFClp413J+zmeqA3+bKKlTGGRPdUUbS+2M+UDOpbqQG+fRqzlcTN96xfpg0QO6DL7NvW7hQvqyyinED+8sX99ZC9xnPvk4huW5MS9JbuScG/shxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JbQdndZ8; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7ba49f92362so975135b3a.1
        for <linux-wireless@vger.kernel.org>; Thu, 04 Dec 2025 16:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764894796; x=1765499596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JxloJdhlr8dfIXQBTNyveaWRibzvvrHbjdiZXjpwUKc=;
        b=JbQdndZ8jKmOVUuPMHLHfF27ubsiKfFrRBOhegZwCP6mtbZoJd2UujwJc236m684rE
         7RYnauLvQO/LfYaF0Y7o0bEU2+jbAQLUp0k7cMzA8McTO91/eMcgj2/ezzXlIMQ/YhEs
         KbQBXY0CODNIQ3rgQog6s2E+cPOLPqUXgi+Yz2MPVd8Rya9bKbBzpZmRmwXP01bYxt9x
         t27VtHwZiqAqXk94TiibHj1fhNDDD36hn9oDvuwM76u5bBJh3dN2UiIiswsoept5b0LG
         ePxWg8ERYxTu3z1CNtsAD5zBxscoxq/cqq9DGmQeQcKvLfC/jKk74FE9j4WNWI8SobLO
         i5kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764894796; x=1765499596;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JxloJdhlr8dfIXQBTNyveaWRibzvvrHbjdiZXjpwUKc=;
        b=n3k6fg/bR0xVZjKdQaiT5iqVmVaWArNzJ4XQ9EK3iLF3Cxjgn64Cm6/rC2SaAoC9Pd
         sVSjoR4gMbVwzzAMbX4JmzATo8t2b4DVJj9KmUIc0ObiDyuJTLs/lKhB25dIwo9ZycyI
         W1uG6Sgj/rnPz5zmSXhix0+0Idgpat0iOHm62x7ix8hv6TKwgtWUSD+MdnrtCgLxwNMO
         VBY6RVL29X7+yWKP5SJKAaU7JNNRM13NbOmwyNFL/yemJXOuCHoqzF0LJqbXtpTM+z9V
         B6dgrINdsnmC2/kMBQ1zGyW8nrvZ2iNZp+X0XnMn91paT9deJ6q93qVyMeTmymU0YBwo
         vNBw==
X-Gm-Message-State: AOJu0YyBGfG8K02icwSomJuRaKyay8MsGnk/dXEp4ar+xHZm3jvIvlBD
	6Zu193wRHuC9Di9rFvd3rc6D3fsNNfABR4AjyhmEp1b7NzoWtiSUySATYvtLDIJn+6lRKw==
X-Gm-Gg: ASbGnct+oRVQps9fZHQzSLrvtnlnlDGIEpC+1bJi/TJyqu3hmsMWKQSqRTM2MSw3zWt
	rD8a8RLbxMKBUv6r9ipoC4B22Na4a9KYQmw5zizhnbcRhDddLTEqb4LkIzQvr7ev/iYbZzUwJKn
	rt3YEbhkyi0OX11MMSu5SA3iGgWbHGXPirZQ50sxOsOAlzmFMEDYOC5ba7YvcqEA3i0O6s+pe8I
	HfzlVLbEtKPh4evXC2XAR8FMFVPFGzR2ac05bc3FdmUv8LajiuCPJha67Imdp9M+rvZAmnjRDuc
	6tuN7Ugb5zH0uFrB/urgpajCzHus5KlBmquGwuaujWFsyR/HB5RlPjzBOENq+JmXVArzcTjEWNP
	eTLBbFZn/42WbDtAue0DNhE3rPTaqYl3PfBPTRPDUfR3qXIOHacltm+BubbGSaOoGDmjvx9pBkI
	dMkZP8lDbCwCipF/N+WvvIiJ3esiEFbsF4G/1qbOa2X0Zvzo/6YX6e
X-Google-Smtp-Source: AGHT+IH/iErVDsXSgs50po60+tfSTX3zhT1mgws1ixT5tItR5b3E0qYJRdQG8vLS9DYI1ncLboOsgA==
X-Received: by 2002:a05:6a00:2292:b0:776:19f6:5d2f with SMTP id d2e1a72fcca58-7e206c626bfmr5285558b3a.11.1764894796339;
        Thu, 04 Dec 2025 16:33:16 -0800 (PST)
Received: from bill-manjaro (27-53-114-138.adsl.fetnet.net. [27.53.114.138])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7e29f2ed000sm3345075b3a.1.2025.12.04.16.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 16:33:15 -0800 (PST)
From: Hsiu-Ming Chang <cges30901@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: pkshih@realtek.com,
	cges30901@gmail.com
Subject: [PATCH RESEND] wifi: rtw88: rtw8821cu: Add ID for Mercusys MU6H
Date: Fri,  5 Dec 2025 08:32:04 +0800
Message-ID: <20251205003245.5762-1-cges30901@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for Mercusys MU6H AC650 High Gain Wireless Dual Band USB Adapter
V1.30. It is based on RTL8811CU, usb device ID is 2c4e:0105.

Signed-off-by: Hsiu-Ming Chang <cges30901@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/rtw8821cu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821cu.c b/drivers/net/wireless/realtek/rtw88/rtw8821cu.c
index 7a0fffc35..8cd09d666 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821cu.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821cu.c
@@ -37,6 +37,8 @@ static const struct usb_device_id rtw_8821cu_id_table[] = {
 	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) }, /* Edimax */
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x7392, 0xd811, 0xff, 0xff, 0xff),
 	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) }, /* Edimax */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2c4e, 0x0105, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) }, /* Mercusys */
 	{},
 };
 MODULE_DEVICE_TABLE(usb, rtw_8821cu_id_table);
-- 
2.52.0


