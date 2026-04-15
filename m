Return-Path: <linux-wireless+bounces-34856-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FUDGf0Q4Gk4cQAAu9opvQ
	(envelope-from <linux-wireless+bounces-34856-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:28:13 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 41238408A09
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1495B30A31B6
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 22:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7078F38E13D;
	Wed, 15 Apr 2026 22:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sMYue4v7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F5E38C429
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 22:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776291884; cv=none; b=XHRtjZfVFNe/+IE4uqKgSjyg2LJfKsGL8HPNFP0XWfF1MLjN2AEBSxr5R8SDGReDw8hEkzb5u+ECnWrjOnwsRDEvbE6olosX/6q8UUwcwFy0AQHrEXY4tcM6WV8GwroNh7h4r5Haw4A5gaxxP/uPjNM72Aiuis1PDXmoANqgBg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776291884; c=relaxed/simple;
	bh=cytMEPC6oh1k5T67H1VMwu25BE46SbxtJxsHqqISmcg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xs+h53hjx0pxy+EVgAHU+1SjBUssi+8GrRIr9l1uCDqKCITQ8uiICkXymn5CglR7xkxs+BppYBQ6CzotomQR9EOHXoOYUdf2s9rTe83ekfOYSPSvkZuSMWhuDKvdZtBdU5Ort/+8Ta6JGOvi52OMktZCMfOrJ7af1nxCUnCEuCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sMYue4v7; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4887fd35e60so50983525e9.2
        for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 15:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776291881; x=1776896681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4LmiGoBxJct/74gvgvdOopVwzfGkH2hfPjTjgcWOqho=;
        b=sMYue4v7A3lPT/Z+PqPfMZMu63CjWybamxUHGZlSqfK4HlRC/9GG8wBiADvrjTDeQ9
         9mnOIkA5fXNcemh+9FZ2bYDse9UamgkLI290peAEZmx8lNuur2qYgKj/TZJo2yYjpWNz
         lk4jll9Pb0LnPsSFfB8jWHTPCpTYCqz1EJIjFXDtKd0KdVVtgnb9Zl9C/HDWOfAywJoA
         hKbOgtIUHZzVaha8eUQuzbowkVVr1HmuXeN9/5wE8EVJWnzK0id05V+V69QFMlfMzr9u
         EgK9nYouoIpPq0BaG51KPSeWm8/Xaf3PItJ2DqvPhsgA84Pd7akizva8dNDY6t7KYgeP
         2VMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776291881; x=1776896681;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4LmiGoBxJct/74gvgvdOopVwzfGkH2hfPjTjgcWOqho=;
        b=dlidBFWBIYXOJ3ev25Hl8BsCliYG7NNqVe04wtAOpBPb7uUM+TncB40OajgnIruLXH
         WJdxRbdjaQdk0BQj4fg8I66bMvla9i2+aSTNGgZi3+RFixW0HWM/ZCKo76bMzN/0TAz3
         D7QyVWpH9x0G4DUca7RtkgHfIZvZiSBeVv2TIjMiLDWJE+EPgWK17CnarXd/lic8SW6O
         +iUgWLCocODFRr6YlrL8598g7mPom/EdU2dw5mcYlQepHeSNkOfbsjeJW1vS5aC/aTw4
         8EvIBfKydLWPZX6NedovoTyU1gmKFjPUPoT3jObCKgVo53BVkEiVIcwBCgIKmEE5xKBA
         fqcg==
X-Forwarded-Encrypted: i=1; AFNElJ+FytlEOLCNyouApZ/FM7JYt9t0EjK8xc0DLeZEtyjCKjn1Yh850qpaYfueesICsZhViQY+JQiR+8X3+ps79A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3YemXgP6bnGBbwXwwWi8ylNoaNNwiT+dDGR/B4xxWmCImwtB+
	BK2g8Rav/opLAjP/uP/7npi4zZEW5+9jsct1D4YslUrCOX8eyfo6VJFn41a0IaP04w==
X-Gm-Gg: AeBDieseETL5c9oCyC59chAH/wHLyuYrtMwMEkF658Tkq5H3xKrJM2An6AmS2zuu3s5
	xllEP8VMNSvLzqiKVku9Nh/TRvzcSo4W56JoYTy91iuvtYLgpp+XkGCZhZgbmrb7VZLVgVPr4G7
	o8zLQBDaob9XBnuVqA3JiAjbpmDLHPCFUlKlST1laDEuO6YoNOg1gXufU4WqUWGjpTMXWijVHMU
	I5YbFmdqIHyDCV/qCL2d1dAdhG/zFX5i9IRKJuWAMFFVDk2pkFgF0iIDpCVBBPkzSd/u1IlrLOj
	Uo9xxEIM09+qWAZrVWBGCu5S9WXvdjEHujk5i157JKKDlREiZ9zNVZKdgRakgwMHtiXRk+IYEc0
	DJAQ8inz2PC5bo90Jl1XMYcOk7lJoVcF5JysyIhjvoeetRRW0HW3oDMUz29j6lT0ahkGCYZ8daG
	+Ww2Q=
X-Received: by 2002:a5d:64c8:0:b0:43d:76b0:78e with SMTP id ffacd0b85a97d-43d76b0161cmr21240247f8f.14.1776291881188;
        Wed, 15 Apr 2026 15:24:41 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead3f92f4sm7154681f8f.34.2026.04.15.15.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 15:24:40 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org
Subject: [PATCH v2] wifi: rtw88: fix OOB read from firmware RX descriptor exceeding DMA buffer
Date: Wed, 15 Apr 2026 22:24:40 +0000
Message-ID: <20260415222440.1545959-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34856-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[talencesecurity.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 41238408A09
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tristan Madani <tristan@talencesecurity.com>

In rtw_pci_rx_napi(), new_len is computed as the sum of pkt_len (14-bit
descriptor field, max 16383) and pkt_offset (drv_info_sz + shift, both
firmware-controlled). The result can exceed RTK_PCI_RX_BUF_SIZE (11478),
causing an out-of-bounds read from the pre-allocated DMA buffer when
skb_put_data copies new_len bytes. The USB transport already validates
this (rtw_usb_rx_data_put checks against RTW_USB_MAX_RECVBUF_SZ); the
PCIe path does not.

Add a check that new_len does not exceed the DMA buffer size.

Fixes: e3037485c68e ("rtw88: new Realtek 802.11ac driver")
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
Note: v2 resubmission -- original sent via Gmail had HTML rendering
issues. This version uses git send-email for plain-text formatting.

Changes in v2:
  - v2: clarify field widths and maximum new_len derivation in commit
    message, per Ping-Ke Shih's feedback.

drivers/net/wireless/realtek/rtw88/pci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index XXXXXXX..XXXXXXX 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -1078,6 +1078,11 @@ static int rtw_pci_rx_napi(struct rtw_dev *rtwdev, struct rtw_pci *rtwpci,
 		new_len = pkt_stat.pkt_len + pkt_offset;
+		if (new_len > RTK_PCI_RX_BUF_SIZE) {
+			rtw_dbg(rtwdev, RTW_DBG_RX,
+				"oversized RX packet: %u\n", new_len);
+			goto next_rp;
+		}
 		new = dev_alloc_skb(new_len);
 		if (WARN_ONCE(!new, "rx routine starvation\n"))
 			goto next_rp;


