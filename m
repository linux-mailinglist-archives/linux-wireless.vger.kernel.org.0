Return-Path: <linux-wireless+bounces-37794-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LIM6BORUL2pa+gQAu9opvQ
	(envelope-from <linux-wireless+bounces-37794-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2026 03:27:00 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A218682BD7
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2026 03:26:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=EnhbX3CI;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37794-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37794-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realtek.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F37E4300119E
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2026 01:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1186218AB9;
	Mon, 15 Jun 2026 01:26:54 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B86155757;
	Mon, 15 Jun 2026 01:26:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781486814; cv=none; b=ZUYvv1OVcLR9Q16zAz8E6NE3VMyzytBr/wWnv5GSfGw9iJVzx2fs7MOpP89AGXPis3FdG5IL6I0a3CZxI5rb56E6Me0cwpYMhdE/EctFJ0yX6wbXjU15/PSw9WkOB6cf1kb7eZSE5ViOCuU15Pbc+G9p9F8sA9QSSTYuZkmTQHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781486814; c=relaxed/simple;
	bh=aRUB6JzvCjAkq9RzqzeY8mn192kAGdy1FWYxqQRzZL0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BeMzx/T7h6RNMuCVXjWM/C+V3QY8sCfh1wEqVbuLKCHuqWfP4yIrpW6pEUs6soTfBlmQNCPNBnnqkEImpCXheXlV50siKkrKkHjGWWvRdjqEpK+mMVw/eC0tFeV7SnFrkhiMHJyU8I/ypWCq8Jp/gVGwzlaZjMHrXtzkQ7J7YMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=EnhbX3CI; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 65F1QjxbE385797, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1781486805; bh=/WmasHGR3IWzqliPkrCDxsxPpAY7evDC8NK9FE/Kmso=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=EnhbX3CIlH8hwbQb7oytnW/CBOVj6inWKEzaGRC8t2GQA8+ac7jcSn2JVYhgqRGTG
	 icRXcRy16fSy6qpuzA8hrxgvf+fB1YZJYP7KXbebHOmpMrsbnvDg0E+FcEcmLJSy48
	 JgXlfkyVTgHd7RacaTu99OhZSoYj8PU1DHyl6CqspH/78YnRfPk65X9isaMz2eWo6H
	 8c3LaBmmpOrY6+UfEP5zfT12BE0QaPxR/BiwHm7INqaBqX7JzBbYQgukRwbu1hdiPZ
	 wahUwtsWl99FUf7FTMjeA5uMOW+8wM8VkGyVvDmn2NxpGDgFL5jrKUO/K/gbPsEky5
	 l1u9yXKA/UeCA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 65F1QjxbE385797
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 15 Jun 2026 09:26:45 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 15 Jun 2026 09:26:45 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Mon, 15 Jun 2026 09:26:45 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: William Hansen-Baird <william.hansen.baird@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rtw-next 1/3] wifi: rtlwifi: fix disabling of ASPM for
 RTL8723BE with AER flooding
Thread-Topic: [PATCH rtw-next 1/3] wifi: rtlwifi: fix disabling of ASPM for
 RTL8723BE with AER flooding
Thread-Index: AQHc/AV3JlNKZzTeGEaMZsXGTsPOfbY+0cOA
Date: Mon, 15 Jun 2026 01:26:45 +0000
Message-ID: <798730645f974a92ba5390fc8f885394@realtek.com>
References: <20260614135508.70307-1-william.hansen.baird@gmail.com>
 <20260614135508.70307-2-william.hansen.baird@gmail.com>
In-Reply-To: <20260614135508.70307-2-william.hansen.baird@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37794-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:william.hansen.baird@gmail.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:williamhansenbaird@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0A218682BD7

William Hansen-Baird <william.hansen.baird@gmail.com> wrote:
> Commit 77a6407c6ab2 ("wifi: rtlwifi: disable ASPM for RTL8723BE with subs=
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
> This was discovered through testing on a Razer Blade 14 2017, where ASPM
> was enabled by default for the pci device.
>=20
> Move the code added in the previous commit to rtl_pci_init_aspm() to
> allow the adding of a call to rtl_pci_disable_aspm(hw) prior to disabling
> ppsc->pci_support. This makes sure ASPM is disabled before disabling
> driver control of ASPM to block it from being enabled later.
>=20
> Fixes: 77a6407c6ab2 ("wifi: rtlwifi: disable ASPM for RTL8723BE with subs=
ystem ID 11ad:1723")
> Signed-off-by: William Hansen-Baird <william.hansen.baird@gmail.com>
> ---
>  drivers/net/wireless/realtek/rtlwifi/pci.c | 23 +++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/net/wireless/realtek/rtlwifi/pci.c
> b/drivers/net/wireless/realtek/rtlwifi/pci.c
> index 73018a0498b4..4ef1faf649e9 100644
> --- a/drivers/net/wireless/realtek/rtlwifi/pci.c
> +++ b/drivers/net/wireless/realtek/rtlwifi/pci.c
> @@ -156,15 +156,6 @@ static void _rtl_pci_update_default_setting(struct i=
eee80211_hw *hw)
>                                 PCI_EXP_LNKCTL_ASPM_L1 | PCI_EXP_LNKCTL_C=
CC))
>                 ppsc->support_aspm =3D false;
>=20
> -       /* RTL8723BE found on some ASUSTek laptops, such as F441U and
> -        * X555UQ with subsystem ID 11ad:1723 are known to output large
> -        * amounts of PCIe AER errors during and after boot up, causing
> -        * heavy lags, poor network throughput, and occasional lock-ups.
> -        */
> -       if (rtlpriv->rtlhal.hw_type =3D=3D HARDWARE_TYPE_RTL8723BE &&
> -           (rtlpci->pdev->subsystem_vendor =3D=3D 0x11ad &&
> -            rtlpci->pdev->subsystem_device =3D=3D 0x1723))
> -               ppsc->support_aspm =3D false;
>  }
>=20
>  static bool _rtl_pci_platform_switch_device_pci_aspm(
> @@ -330,10 +321,24 @@ static void rtl_pci_parse_configuration(struct pci_=
dev *pdev,
>=20
>  static void rtl_pci_init_aspm(struct ieee80211_hw *hw)
>  {
> +       struct rtl_priv *rtlpriv =3D rtl_priv(hw);
>         struct rtl_ps_ctl *ppsc =3D rtl_psc(rtl_priv(hw));
> +       struct rtl_pci *rtlpci =3D rtl_pcidev(rtl_pcipriv(hw));
>=20
>         _rtl_pci_update_default_setting(hw);
>=20
> +       /* RTL8723BE found on some ASUSTek laptops, such as F441U and
> +        * X555UQ with subsystem ID 11ad:1723 are known to output large
> +        * amounts of PCIe AER errors during and after boot up, causing
> +        * heavy lags, poor network throughput, and occasional lock-ups.
> +        */
> +       if (rtlpriv->rtlhal.hw_type =3D=3D HARDWARE_TYPE_RTL8723BE &&
> +           (rtlpci->pdev->subsystem_vendor =3D=3D 0x11ad &&
> +            rtlpci->pdev->subsystem_device =3D=3D 0x1723)) {
> +               rtl_pci_disable_aspm(hw);

The rtl_pci_disable_aspm() check condition of ppsc->support_aspm, so we
should consider the order seriously. I'd introduce a __rtl_pci_disable_aspm=
()
without checking, like:

--- a/drivers/net/wireless/realtek/rtlwifi/pci.c
+++ b/drivers/net/wireless/realtek/rtlwifi/pci.c
@@ -203,7 +203,7 @@ static void _rtl_pci_switch_clk_req(struct ieee80211_hw=
 *hw, u16 value)
 }

 /*Disable RTL8192SE ASPM & Disable Pci Bridge ASPM*/
-static void rtl_pci_disable_aspm(struct ieee80211_hw *hw)
+static void __rtl_pci_disable_aspm(struct ieee80211_hw *hw)
 {
        struct rtl_priv *rtlpriv =3D rtl_priv(hw);
        struct rtl_pci_priv *pcipriv =3D rtl_pcipriv(hw);
@@ -215,9 +215,6 @@ static void rtl_pci_disable_aspm(struct ieee80211_hw *h=
w)
        u16 aspmlevel =3D 0;
        u16 tmp_u1b =3D 0;

-       if (!ppsc->support_aspm)
-               return;
-
        if (pcibridge_vendor =3D=3D PCI_BRIDGE_VENDOR_UNKNOWN) {
                rtl_dbg(rtlpriv, COMP_POWER, DBG_TRACE,
                        "PCI(Bridge) UNKNOWN\n");
@@ -240,6 +237,14 @@ static void rtl_pci_disable_aspm(struct ieee80211_hw *=
hw)
        _rtl_pci_platform_switch_device_pci_aspm(hw, linkctrl_reg);
 }

+static void rtl_pci_disable_aspm(struct ieee80211_hw *hw)
+{
+       if (!ppsc->support_aspm)
+               return;
+
+       __rtl_pci_disable_aspm(hw);
+}
+

Here, rtl_pci_init_aspm() can call

	__rtl_pci_disable_aspm(hw);

> +               ppsc->support_aspm =3D false;
> +       }
> +
>         if (ppsc->reg_rfps_level & RT_RF_PS_LEVEL_ALWAYS_ASPM) {
>                 /*Always enable ASPM & Clock Req. */
>                 rtl_pci_enable_aspm(hw);
> --
> 2.54.0


