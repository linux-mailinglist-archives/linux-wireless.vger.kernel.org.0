Return-Path: <linux-wireless+bounces-35999-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iG1DHM4B+2kbVQMAu9opvQ
	(envelope-from <linux-wireless+bounces-35999-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 10:54:38 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FA74D825C
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 10:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0779430151F4
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2026 08:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C94E3C871B;
	Wed,  6 May 2026 08:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="s1o5WvoN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FBD35B631
	for <linux-wireless@vger.kernel.org>; Wed,  6 May 2026 08:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778057344; cv=none; b=uUtKDAxBcDRlBP1NCU90X7I95+zDNHUKxrdCZpr8G3XJuSaB8r0RiZ4a7SPR3ePff/ebPZFgYeabhD1qQqRjoxT2JnGC/NrE0SxX+G1vyHp69TlZY20+BC57zEhZXHtNYcIgbKuU1KKkrv2+lMGmoihX63fBt6eJzNX3Ctdq27g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778057344; c=relaxed/simple;
	bh=aYgDZ/yEChyJOo37LQeXBASHjCwO01ZezhCKsoNlkvQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SIxl1iyUjDuJonQTpbDgjdgI0J1CNmSVioVDcSNGlYyXySfJuoaUdxcNEveZ7pYTzS5SINJXUcm32MP9gA/9W4pXS5gz2HqvFOZ03uWTt/H2csjDuWCiAFPqD3qoFt2hWw5B1WpHok27tyNqVcpdL/gfGLv7rR/HkAWT3eIweLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=s1o5WvoN; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6468mr0E31884086, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1778057333; bh=K+ox7pCEQdaBF63R2tEHRAYlAJ5oDWmP3NvLRmBWX6I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=s1o5WvoNdUkRbQ2Uk9Eswv6WQFsGh/KNqHOLyn+4oFGJGssRxQfdQPbeO6iM4osxf
	 FvrdLyxaw8GF0/KmnvJMGfJFBfMPQA2k2IZnxAOpBg8y+7bS4v9js+qf9Qa41AuNeC
	 gyK4zk1dP3Easd3PWUYerD4bQtgZiydvu1JXEqKGrGQp8uFpanlS2yCW1KS5xEIkyc
	 guvXZ50+DcSzf83uCAhtWuNHUQ7arwMjqgZIVPTUmGJaQbWqHaI3jcix+b+4eqQmqd
	 SiE6boGlwsb08jkOvvjsmAxKvVhfRQUJGKozxbexgMNQvPA7jo/LQcLmt5f3VBYqzG
	 3ox2AQj6CcIRQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 6468mr0E31884086
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 May 2026 16:48:53 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 6 May 2026 16:48:53 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 6 May 2026 16:48:53 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Wed, 6 May 2026 16:48:53 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Gabriel Maia <gabrielvinicius.damaia@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: "kvalo@kernel.org" <kvalo@kernel.org>,
        Gabriel Maia
	<gabriel_v_maia@estudante.sesisenai.org.br>
Subject: RE: [PATCH] wifi: rtw88: add quirk to disable deep LPS for ASUS
 VivoBook X515JA
Thread-Topic: [PATCH] wifi: rtw88: add quirk to disable deep LPS for ASUS
 VivoBook X515JA
Thread-Index: AQHc2xzjD6zt3JEWlUKqZSzpebDyrbYAs5lg
Date: Wed, 6 May 2026 08:48:53 +0000
Message-ID: <af328c8d6bdc4047b08a33a4246c1061@realtek.com>
References: <20260503164944.27114-1-gabriel_v_maia@estudante.sesisenai.org.br>
In-Reply-To: <20260503164944.27114-1-gabriel_v_maia@estudante.sesisenai.org.br>
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
X-Rspamd-Queue-Id: C7FA74D825C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35999-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,realtek.com:dkim,realtek.com:mid];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]

Gabriel Maia <gabrielvinicius.damaia@gmail.com> wrote:
> On ASUS VivoBook X515JA laptops equipped with a Realtek RTL8821CE
> 802.11ac PCIe adapter (PCI ID: 10ec:c821, subsystem: 1a3b:3040),
> the driver periodically emits the following messages:
>=20
>   rtw88_8821ce 0000:01:00.0: firmware failed to leave lps state
>   rtw88_8821ce 0000:01:00.0: failed to send h2c command
>=20
> The firmware fails to leave the Low Power State (LPS) in time,
> causing subsequent h2c commands to be dropped. Disable deep LPS
> to avoid this issue.

Just want to know that messages become absolutely silent with this patch?

>=20
> Signed-off-by: Gabriel Maia <gabriel_v_maia@estudante.sesisenai.org.br>

WARNING: From:/Signed-off-by: email address mismatch:=20
'From: Gabriel Maia <gabrielvinicius.damaia@gmail.com>' !=3D=20
'Signed-off-by: Gabriel Maia <gabriel_v_maia@estudante.sesisenai.org.br>'

> ---
>  drivers/net/wireless/realtek/rtw88/pci.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wirel=
ess/realtek/rtw88/pci.c
> index bba370ad510c..b0eae0971ef4 100644
> --- a/drivers/net/wireless/realtek/rtw88/pci.c
> +++ b/drivers/net/wireless/realtek/rtw88/pci.c
> @@ -1770,6 +1770,15 @@ static const struct dmi_system_id rtw_pci_quirks[]=
 =3D {
>                 .driver_data =3D (void *)(BIT(QUIRK_DIS_CAP_PCI_ASPM) |
>                                         BIT(QUIRK_DIS_CAP_LPS_DEEP)),
>         },
> +       {
> +               .callback =3D rtw_pci_disable_caps,
> +               .ident =3D "ASUS VivoBook X515JA",
> +               .matches =3D {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."=
),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "VivoBook_ASUSLaptop =
X515JA_X515JA"),
> +               },
> +               .driver_data =3D (void *)BIT(QUIRK_DIS_CAP_LPS_DEEP),
> +       },
>         {}
>  };
>=20
> --
> 2.53.0


