Return-Path: <linux-wireless+bounces-37853-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +EZ4KDRcMmo/zAUAu9opvQ
	(envelope-from <linux-wireless+bounces-37853-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jun 2026 10:35:00 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C30697994
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jun 2026 10:35:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=m9rCVOj2;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37853-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37853-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realtek.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D9C59303E13A
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jun 2026 08:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A956138736E;
	Wed, 17 Jun 2026 08:34:08 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0822F31A813;
	Wed, 17 Jun 2026 08:34:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781685248; cv=none; b=EKDcHj8Wo7+EGa7MTlIpEoKqH0Phxf0ra3hXSdWuyCrbhhmS72hLrRBc0PIMBweEy/ZyQWO+Hupu5z4ey575aOXTotpj5Q/AH1Z0uzjfJL5dDKgnyiTGyHPmFahVKbcd2dAJXA10h3DNFpYDsFl4GV/LPhhyxvOgsUwSPuXRFiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781685248; c=relaxed/simple;
	bh=VNCbHQg5Qrsnj35x6teMZJAQNOJ6kX8DZ7xM+8qBSMs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NGaQQX5udx1r/stTM7Dvj4fitLMOtoEgAcMoFC+pS6QUnjQb3XGG6pNqKFLhFxEiXixaaYx7/E40CzNayuBjNQZNuE6KyNTqBz34OiO6bx9+i4giU4XwVSDP43dJ0YCgTW3qZC8ghvoi0mv7zYggOZxUWdncprrRKuPzYPIZGJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=m9rCVOj2; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 65H8XhIO22587399, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1781685223; bh=VNCbHQg5Qrsnj35x6teMZJAQNOJ6kX8DZ7xM+8qBSMs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=m9rCVOj2aK0OxqJGQZ8kTOgQcHykEGWVzxgzsqejYrO31SS+mOHMjZfnOZc7VnzOP
	 hzKO9wSJ++HtwVO+Pv0q9ITbbtzhtv98oEA7wC+lAqZqx9JWoTk55JyBfkLok3lx3g
	 z2sV9iCQVslTdyvqOoLl5MkCaDZrLhz0n/ugo9CD/Hc9O9UwMrSax96i1G/zjbWCgS
	 3wIPNtCRh3HMUCJW+ReVE99IsyY6DBeQWNd1mqfxGHhw2kWArbvtb6irT4qDjOtWVf
	 vqykbJdmfQpezIka02O54fM+cEQUxBZeW0VZV1TTsffJv027atUq1ylAUE4FbfcB/Q
	 ivqbTNhB5JmrA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 65H8XhIO22587399
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 17 Jun 2026 16:33:43 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 17 Jun 2026 16:33:43 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 17 Jun 2026 16:33:43 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Wed, 17 Jun 2026 16:33:43 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Dawei Feng <dawei.feng@seu.edu.cn>
CC: "leitao@debian.org" <leitao@debian.org>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "jianhao.xu@seu.edu.cn"
	<jianhao.xu@seu.edu.cn>, "zilin@seu.edu.cn" <zilin@seu.edu.cn>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH wireless] wifi: rtw88: pci: fix resource leak on failed
 NAPI setup
Thread-Topic: [PATCH wireless] wifi: rtw88: pci: fix resource leak on failed
 NAPI setup
Thread-Index: AQHc/fmIAcGrEcSAmkm2jiCazgmzlLZCa/QQ
Date: Wed, 17 Jun 2026 08:33:43 +0000
Message-ID: <459e4dfeb2f048c3bff97028d8c1f3a2@realtek.com>
References: <20260617013502.114057-1-dawei.feng@seu.edu.cn>
In-Reply-To: <20260617013502.114057-1-dawei.feng@seu.edu.cn>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37853-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dawei.feng@seu.edu.cn,m:leitao@debian.org,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jianhao.xu@seu.edu.cn,m:zilin@seu.edu.cn,m:stable@vger.kernel.org,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,realtek.com:dkim,realtek.com:email,realtek.com:mid,realtek.com:from_mime,vger.kernel.org:from_smtp,seu.edu.cn:email];
	FORGED_SENDER(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 31C30697994

Dawei Feng <dawei.feng@seu.edu.cn> wrote:
> rtw_pci_probe() allocates PCI resources through
> rtw_pci_setup_resource() before it sets up NAPI. If
> rtw_pci_napi_init() fails, the error path jumps straight to
> err_pci_declaim and skips rtw_pci_destroy(), leaving the PCI
> resources allocated by rtw_pci_setup_resource() behind.
>=20
> Add a dedicated cleanup label for the NAPI setup failure path so probe
> destroys the PCI resources.
>=20
> The bug was first flagged by an experimental analysis tool we are
> developing for kernel memory-management bugs while analyzing current
> mainline kernels. The tool is still under development and is not yet
> publicly available. Manual inspection confirms that the bug is still
> present in v7.1-rc7.
>=20
> An x86_64 allyesconfig build showed no new warnings. As we do not have a
> suitable rtw88 PCI board to test with, no runtime testing was able to be
> performed.
>=20
> Fixes: d0bcb10e7b94 ("wifi: rtw88: Un-embed dummy device")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>



