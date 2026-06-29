Return-Path: <linux-wireless+bounces-38231-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Bb5fGJnRQWocuwkAu9opvQ
	(envelope-from <linux-wireless+bounces-38231-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 03:59:53 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 596BB6D5738
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 03:59:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=qkXYbvXz;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38231-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38231-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realtek.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 61FF83002B41
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 01:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD891349AF6;
	Mon, 29 Jun 2026 01:59:47 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87AC245012;
	Mon, 29 Jun 2026 01:59:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782698387; cv=none; b=CS/MBbsZkaMHZua8BcPXPG5tWm2ZcJUIx3yzatyZ7DVxyDYN1l50Kmj5y8ahkgzcwnfTLCdxIb4DwMn6yRd1cP8AbifBR4LM7c3O8GhDhpwRfm3BN6lwr0Y+L0SiW9zr8pTvN5jOKmNdedfD267BN7lo3i24jYbysRrdeG8Kkpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782698387; c=relaxed/simple;
	bh=p4rSi6GhvDznhHiygPQRbMSVJR3PQ82yvniXVqKu/wg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iTuL5c/N7ZYP3trtH87Pv1CUi1sZMThVjPypSAKMk/FV515OmSTo4SxOaV/DHtgwLlfOEWYTJdz/mK53E+ODmADez9r2H5woQWYdTtam06NKzJf8Pr0TkaF+d2zDcu6VkrZZGt0isYcxwznZvOtkRnCXMDbr92trzrjsrB43Na0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=qkXYbvXz; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 65T1xf4H33307814, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1782698381; bh=mieHX18Ixn8L7iTs/QJsGQhDlkLgGvxqOgg1UMPCKJo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=qkXYbvXzzTEHSP607Z/aUDqaS8uTaYAdnDqcghk8UDi9W0C+W/dZphfXU5J98VFyv
	 pGDRgEPLCDjowgLzELETPEOc/T9/fIsrBiop8SRtG5+7hUgxQYwwBifOipqCKjT9XJ
	 tk4XKiiuprmjujmSA+JTVGIXPCik4nWesAJLN2zunrGFNY/4cjCG6pVTXq6bwSS/qB
	 +DwCExgnjwKYqIZ7yiM6c9ROc4n1oCLnHDQGPWoAq70XPEPQVRrORBtu75AIdZyPWh
	 DYBBqMk2qubEDxxx48t/Eqf2teL8jSGw5ZtERcpXtaRqgNeyBzIE85xiD2EBgST+YR
	 vzCWxgrWcOOxQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 65T1xf4H33307814
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Jun 2026 09:59:41 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 29 Jun 2026 09:59:41 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 29 Jun 2026 09:59:41 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Mon, 29 Jun 2026 09:59:41 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: William Hansen-Baird <william.hansen.baird@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rtw-next v3 1/3] wifi: rtlwifi: fix disabling of ASPM for
 RTL8723BE with AER flooding
Thread-Topic: [PATCH rtw-next v3 1/3] wifi: rtlwifi: fix disabling of ASPM for
 RTL8723BE with AER flooding
Thread-Index: AQHdBVIiiw7m7/d3sEK1KpAODQ6uErZUyjUg
Date: Mon, 29 Jun 2026 01:59:41 +0000
Message-ID: <3fa1f46796eb461ea0ec34a2c1a88447@realtek.com>
References: <20260626095648.1124924-1-william.hansen.baird@gmail.com>
 <20260626095648.1124924-2-william.hansen.baird@gmail.com>
In-Reply-To: <20260626095648.1124924-2-william.hansen.baird@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38231-lists,linux-wireless=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:william.hansen.baird@gmail.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:williamhansenbaird@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,realtek.com:dkim,realtek.com:email,realtek.com:mid,realtek.com:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 596BB6D5738

William Hansen-Baird <william.hansen.baird@gmail.com> wrote:
> commit 77a6407c6ab2 ("wifi: rtlwifi: disable ASPM for RTL8723BE with subs=
ystem ID 11ad:1723")
> adds code which sets ppsc->support_aspm to false in
> _rtl_pci_update_default_setting() in order to disable ASPM.
> This does not, however, disable ASPM. Rather, it disables driver
> control of ASPM, and blocks calls to rtl_pci_enable_aspm()
> and rtl_pci_disable_aspm().
>=20
> In some cases, the pci device supplied to the probe function has
> ASPM enabled. The code would therefore not disable ASPM, as it means to,
> but rather just leave it enabled.
> This was discovered through testing on a Razer Blade 14 2017.
>=20
> Implement a new __rtl_pci_disable_aspm(hw) function which does not check
> ppsc->support_aspm before disabling and call it from
> rtl_pci_disable_aspm().
>=20
> Then move the code added in the previous commit to rtl_pci_init_aspm() to
> allow adding a call to __rtl_pci_disable_aspm(hw).
> This makes sure ASPM is disabled while still disabling
> driver control of ASPM to block it from being enabled later.
>=20
> Signed-off-by: William Hansen-Baird <william.hansen.baird@gmail.com>

A minor warning. Otherwise, looks good to me.

Acked-by: Ping-Ke Shih <pkshih@realtek.com>


> @@ -330,10 +328,25 @@ static void rtl_pci_parse_configuration(struct pci_=
dev *pdev,
>=20
>  static void rtl_pci_init_aspm(struct ieee80211_hw *hw)
>  {
> +       struct rtl_pci *rtlpci =3D rtl_pcidev(rtl_pcipriv(hw));
>         struct rtl_ps_ctl *ppsc =3D rtl_psc(rtl_priv(hw));
> +       struct rtl_priv *rtlpriv =3D rtl_priv(hw);
>=20
>         _rtl_pci_update_default_setting(hw);
>=20
> +       /*

.git/rebase-apply/patch:71: trailing whitespace.
        /*
warning: 1 line adds whitespace errors.

> +        * RTL8723BE found on some ASUSTek laptops, such as F441U and
> +        * X555UQ with subsystem ID 11ad:1723 are known to output large
> +        * amounts of PCIe AER errors during and after boot up, causing
> +        * heavy lags, poor network throughput, and occasional lock-ups.
> +        */
> +       if (rtlpriv->rtlhal.hw_type =3D=3D HARDWARE_TYPE_RTL8723BE &&
> +           (rtlpci->pdev->subsystem_vendor =3D=3D 0x11ad &&
> +            rtlpci->pdev->subsystem_device =3D=3D 0x1723)) {
> +               __rtl_pci_disable_aspm(hw);
> +               ppsc->support_aspm =3D false;
> +       }
> +
>         if (ppsc->reg_rfps_level & RT_RF_PS_LEVEL_ALWAYS_ASPM) {
>                 /*Always enable ASPM & Clock Req. */
>                 rtl_pci_enable_aspm(hw);
> --
> 2.54.0


