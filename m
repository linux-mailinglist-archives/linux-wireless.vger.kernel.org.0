Return-Path: <linux-wireless+bounces-33213-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kE0ZOwwPtGlvfwAAu9opvQ
	(envelope-from <linux-wireless+bounces-33213-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 14:20:12 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 157A2283A21
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 14:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 906433039A5C
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 13:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B52389DF0;
	Fri, 13 Mar 2026 13:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=georgmueller@gmx.net header.b="tXC21kE7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0120E386C0B;
	Fri, 13 Mar 2026 13:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773407967; cv=none; b=JXrs93gnkU5VPZbb/6m6uEBY9R8Ed65aILx7Haw3orj0a4M4ILDwWrJiVGLlKqvISkU3IsZVnW+MmFFBSZqSvVPygr4ig/K0YRZLRp11i4MjL8d7wHygRF7D3Zek7okwZzZz+IttkrFrRiRkjQ4wgoicMhvLEZaDnLHDQjZUHss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773407967; c=relaxed/simple;
	bh=Ev/C5VI3XmElXhMIXtw53Ut73SZi5/csrEWIvoB4MGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r3VzEjj50H5Kzn/NEP/M0qFFikX2gKDmovLBtjri84Fdld6VQXCryupN7UUaBgBuelyVZbrQ36DsNw5DXfPa4TtU8+a8Cat3syRZxRX73+v5MxQSjymyYItrYCL7VK4GxkQYxIwSHRT1jReP6AABn7DRD+MEoHtEojoBl2Lm2uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=georgmueller@gmx.net header.b=tXC21kE7; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1773407963; x=1774012763; i=georgmueller@gmx.net;
	bh=sVDwYWZE6JgmTFrLJ9o/fxiZ/qqbRfI8tnAaxDTv2Hk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=tXC21kE7Nx16tYjQfRMzkrMrxXPIYRW44wWq2BLSdOsHKoT5q37egEZKtuG/7irO
	 2cACTVIZtBCL4vCjZOjOemoi3kNKXkqJNnRhcdugqb+12bFlssDSuIcjuggcsiWKU
	 FSRT/PkWJ6wtlPc9jCBGW0xopZeKZ7z/PZ4VMo4EmQvfKS47/QC0gQEeQ6VXUHtjS
	 0zQKD8CvWnIumFGB2pIoqHJjjjB0U+jspBvtIlGqSIq8oTqm3Z73SdO4r9qrldv5x
	 itVzM9sELHXTpb92hTdejQ/mjE9e+34bOIcNyWagKW5lgHpVRNj4odatvgepXJSrP
	 csXz4DttE1pVfInpkg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N2DxE-1vcVxl11KQ-012VBO; Fri, 13
 Mar 2026 14:19:23 +0100
From: =?UTF-8?q?Georg=20M=C3=BCller?= <georgmueller@gmx.net>
To: Jes.Sorensen@gmail.com,
	rtl8821cerfe2@gmail.com
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Georg=20M=C3=BCller?= <georgmueller@gmx.net>
Subject: [RFC PATCH v2 4/4] wifi: rtl8xxxu: Enable AP mode for RTL8188EU
Date: Fri, 13 Mar 2026 14:18:49 +0100
Message-ID: <20260313131849.3148013-5-georgmueller@gmx.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313131849.3148013-1-georgmueller@gmx.net>
References: <20260313131849.3148013-1-georgmueller@gmx.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:srPEdkrFtFFf8LIrNQIilCDjg6Q2QpzXvqE0vONt3YSRbx4/iTN
 7ACEkWRioOwCWG5kb5+SoCpN7ZRUOic/J9jtg0aiURblc4ZE+7fvgvYlPwcI/w7DQtVh3Ds
 sN36r7Z8qgwRr/E3ampzFERw0oKcMXX6+BtSEWUVnxY8HTRXgrSDCV/u7Ew6tDhZh7ccjd0
 +06rwf/t+FyCAgh2zfRBg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hbQe0nx7j68=;vvGKcW52CJ8+zA1LTE38rKNGb+B
 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
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.net,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.net:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.net];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-33213-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[gmx.net:+];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[georgmueller@gmx.net,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmx.net];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 157A2283A21
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Allow devices with this driver to be used as a wireless access point.

Signed-off-by: Georg M=C3=BCller <georgmueller@gmx.net>
=2D--
 drivers/net/wireless/realtek/rtl8xxxu/8188e.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/8188e.c b/drivers/net/w=
ireless/realtek/rtl8xxxu/8188e.c
index 607ca62194fc..67fd77944d67 100644
=2D-- a/drivers/net/wireless/realtek/rtl8xxxu/8188e.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/8188e.c
@@ -1867,6 +1867,8 @@ struct rtl8xxxu_fileops rtl8188eu_fops =3D {
 	.init_reg_pkt_life_time =3D 1,
 	.gen2_thermal_meter =3D 1,
 	.max_sec_cam_num =3D 32,
+	.supports_ap =3D 1,
+	.max_macid_num =3D RTL8188E_MAX_MAC_ID_NUM,
 	.adda_1t_init =3D 0x0b1b25a0,
 	.adda_1t_path_on =3D 0x0bdb25a0,
 	/*
=2D-=20
2.53.0


