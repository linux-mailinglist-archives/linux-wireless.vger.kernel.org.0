Return-Path: <linux-wireless+bounces-37795-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8KfXEldXL2qg+gQAu9opvQ
	(envelope-from <linux-wireless+bounces-37795-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2026 03:37:27 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9A2682C4C
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2026 03:37:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b="k63/4ZrN";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37795-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37795-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realtek.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2E244300147E
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2026 01:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C78F1F3BA2;
	Mon, 15 Jun 2026 01:37:24 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FB6155757;
	Mon, 15 Jun 2026 01:37:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781487444; cv=none; b=gFCxRApH2otUH3eF3YJMPgeRVwOfYa9S/lZtBZWllACUPUQWHk3zzBhPe3U6XKL5pKmMghtPCD5fkM32EKYPKUj6o8/ty1WoHbFUSgqLMNJU4/+EiaZluITfUfmlT71m2SBsobif5B4YKEoQA1DA8Ehn1lP/cmUkpaAkNnQwUqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781487444; c=relaxed/simple;
	bh=YlSpNxln56HQp9vQ/Njn8ifHEz47hyyFBatuEANc56g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jMq2wYY35xYOJMIthMJ+xljQ+4J4UHMFmZ2oGGMH/5EDEt+DQk/yV1BUVKKNePyPEwHtWGQTdmjXCoAJl8IXO4J/azPZJfpEVXnQaM6Qhvhq/tBcNZOnf7NsColqa2zbT4wo4TRbak5dqQPiapCWVm4gHpd5B0+hOVDl0MLNLhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=k63/4ZrN; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 65F1bIZe9391908, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1781487438; bh=KgHxx/dunUug6rZJsIQvflVa6unPV1ZGuPI0K0Lm9z0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=k63/4ZrNZW+RpCUYOjpwRCBWTwvUgPLbqQBnnm4zxydzDIxtP45TU9IcPpXZFmGDB
	 WtSHi4Z3wsIbcC3Jrzwc8IZ7cxe+cqw4L7x/gNU7Gycu1edpr6Uw4GaY038qcnSwmX
	 YV1HLI+EAPUkPnF7WfshL7cBTEUOoNtu4srOMJw5PI1JFRFphCSDlwGC/uBEJHFr6d
	 qOoiZww8MobO5VoNemc6AOVPsgbiOPv23CZhXkDWF9kIQuvJ0Z81t2dbF0yXMFRHfF
	 cTVfXlTLO40YBkYeJ1ntugEYSxGrLurwVNAu3+uNperDL6UU/w7x48XYatsPBM6dHI
	 XhT61/2+aBK7A==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 65F1bIZe9391908
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 15 Jun 2026 09:37:18 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 15 Jun 2026 09:37:18 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Mon, 15 Jun 2026 09:37:18 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: William Hansen-Baird <william.hansen.baird@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rtw-next 2/3] wifi: rtlwifi: convert pci ID if-statement
 to table
Thread-Topic: [PATCH rtw-next 2/3] wifi: rtlwifi: convert pci ID if-statement
 to table
Thread-Index: AQHc/AV7d8hv++F+JEmlUz56L50GHLY+1A+A
Date: Mon, 15 Jun 2026 01:37:18 +0000
Message-ID: <fe088e4d7ffe497d992db5ee09df6a43@realtek.com>
References: <20260614135508.70307-1-william.hansen.baird@gmail.com>
 <20260614135508.70307-3-william.hansen.baird@gmail.com>
In-Reply-To: <20260614135508.70307-3-william.hansen.baird@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37795-lists,linux-wireless=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:william.hansen.baird@gmail.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:williamhansenbaird@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[realtek.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,realtek.com:dkim,realtek.com:mid,realtek.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DA9A2682C4C

William Hansen-Baird <william.hansen.baird@gmail.com> wrote:

[...]

> --- a/drivers/net/wireless/realtek/rtlwifi/pci.c
> +++ b/drivers/net/wireless/realtek/rtlwifi/pci.c
> @@ -31,6 +31,11 @@ static const u8 ac_to_hwq[] =3D {
>         BK_QUEUE
>  };
>=20
> +static const struct pci_device_id rtl8723be_aspm_quirks[] =3D {
> +       { PCI_DEVICE_SUB(PCI_ANY_ID, PCI_ANY_ID, 0x11ad, 0x1723) },

Why not filling VID/PID explicitly? As there is only one listed in
rtl8723be_pci_ids[].

	{RTL_PCI_DEVICE(PCI_VENDOR_ID_REALTEK, 0xB723, ...)},

> +       { 0 }
> +};
> +
>  static u8 _rtl_mac_to_hwqueue(struct ieee80211_hw *hw, struct sk_buff *s=
kb)
>  {
>         struct rtl_hal *rtlhal =3D rtl_hal(rtl_priv(hw));
> @@ -327,14 +332,12 @@ static void rtl_pci_init_aspm(struct ieee80211_hw *=
hw)
>=20
>         _rtl_pci_update_default_setting(hw);
>=20
> -       /* RTL8723BE found on some ASUSTek laptops, such as F441U and
> -        * X555UQ with subsystem ID 11ad:1723 are known to output large
> +       /* RTL8723BE with certain subsytem IDs are known to output large
>          * amounts of PCIe AER errors during and after boot up, causing
>          * heavy lags, poor network throughput, and occasional lock-ups.
>          */
>         if (rtlpriv->rtlhal.hw_type =3D=3D HARDWARE_TYPE_RTL8723BE &&

With above opinion, here just check pci_match_id(), no need to check RTL872=
3BE.

> -           (rtlpci->pdev->subsystem_vendor =3D=3D 0x11ad &&
> -            rtlpci->pdev->subsystem_device =3D=3D 0x1723)) {
> +               pci_match_id(rtl8723be_aspm_quirks, rtlpci->pdev)) {
>                 rtl_pci_disable_aspm(hw);
>                 ppsc->support_aspm =3D false;
>         }
> --
> 2.54.0


