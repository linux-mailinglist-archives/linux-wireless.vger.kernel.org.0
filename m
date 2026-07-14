Return-Path: <linux-wireless+bounces-39095-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5l6eM2R4VmqZ6QAAu9opvQ
	(envelope-from <linux-wireless+bounces-39095-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 19:56:52 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C434757A7F
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 19:56:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b="U/EX9a4X";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39095-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39095-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 517D2318EA1D
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 17:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C743191D0;
	Tue, 14 Jul 2026 17:52:18 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EE93128B6
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 17:52:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784051537; cv=none; b=jivxYVzNb+MMtkMHHz4apKXC/o+9ZzWMHVq5d+z6W7TpQJh7D/DXjRbA9sZ/hHjue3I1kzAgAH42w/kghSY8Sc1o73BdfgiKN7KtQEj8E+EB6v8xy6X296ypsoWwOeRHPfmv/CLdAERUxIFoChPZBUznheVJC/MiwiypJCcSZl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784051537; c=relaxed/simple;
	bh=Rn/Dv4dPQpHwIL9Mpu3mdoed2AHF0zLTyiTdnBkMBkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JZF/6AEdiKX6DTdZ8jf6h1hvyYSuOa85z41+Nmc588/eIHFBl6iKHgr0/pUAxl3fl7TU4FeMWmvZX3sYyDo25CkRt9x5Q4QZV0hwL48jBeZpjIEgY8a8yf/7KTOY4137qUcJFMldrAvxoenQLBtEUp/HnPVRGQnUJULZCTsfIRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=U/EX9a4X; arc=none smtp.client-ip=95.215.58.178
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784051531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6sU86FyXQ63B960w6tvcJM6JHwSQ9yAwZejoq8tzotc=;
	b=U/EX9a4X3aecC4DIXLiEbo84wwFoNwL38VNseiFzivrACkBPbybbETfDTgkAsLTB0MpbGL
	WKYyTg03zKbqAknJhBPSBZWxcqk4t8+idITQeZu0bGy7JZf06yL3uvRFDSRevGxAhPxIU6
	yMpWySxjHiZgEahYfFCQJL+E0ftDxyc=
From: luka.gejak@linux.dev
To: linux-wireless@vger.kernel.org
Cc: pkshih@realtek.com,
	straube.linux@gmail.com,
	luka.gejak@linux.dev
Subject: [RFC PATCH v1 9/9] MAINTAINERS: add entry for the RTL8723B rtw88 driver
Date: Tue, 14 Jul 2026 19:51:07 +0200
Message-ID: <c965013543e399bdd08fc8eafffe9bc8c0914ea7.1784047561.git.luka.gejak@linux.dev>
In-Reply-To: <cover.1784047561.git.luka.gejak@linux.dev>
References: <cover.1784047561.git.luka.gejak@linux.dev>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[luka.gejak@linux.dev,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[realtek.com,gmail.com,linux.dev];
	TAGGED_FROM(0.00)[bounces-39095-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:pkshih@realtek.com,m:straube.linux@gmail.com,m:luka.gejak@linux.dev,m:straubelinux@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luka.gejak@linux.dev,linux-wireless@vger.kernel.org]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1C434757A7F

From: Luka Gejak <luka.gejak@linux.dev>

Add Luka Gejak as the maintainer for the RTL8723B/RTL8723BS support in
rtw88.

Signed-off-by: Luka Gejak <luka.gejak@linux.dev>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 15011f5752a9..c9fbf99be92f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22735,6 +22735,14 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/net/dsa/realtek.yaml
 F:	drivers/net/dsa/realtek/*
 
+REALTEK RTL8723B WIRELESS DRIVER (rtw88)
+M:	Luka Gejak <luka.gejak@linux.dev>
+L:	linux-wireless@vger.kernel.org
+S:	Maintained
+F:	drivers/net/wireless/realtek/rtw88/rtw8723b*.c
+F:	drivers/net/wireless/realtek/rtw88/rtw8723b*.h
+F:	drivers/net/wireless/realtek/rtw88/rtw8723bs.c
+
 REALTEK SPI-NAND
 M:	Chris Packham <chris.packham@alliedtelesis.co.nz>
 S:	Maintained
-- 
2.55.0


