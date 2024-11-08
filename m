Return-Path: <linux-wireless+bounces-15122-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F8B9C13E3
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2024 03:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F88CB21F4F
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2024 02:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D5C1BD9D5;
	Fri,  8 Nov 2024 02:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="mkjvwKca"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F658A41
	for <linux-wireless@vger.kernel.org>; Fri,  8 Nov 2024 02:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731032093; cv=none; b=R4olM3n0z2aUsKtE79KkZiYHaE4mZ/aM5/1Zp7Tv7f2Z1/UAZKYjn2cc4bWxATHKiDL78WB5Kbc2zOBR54I3c9Dc5ZMEWfbCq7S73J21l3x6EHv9pqOFJBCFckMl8DyekbxXl3tKMjSmaDwKl1L96x2XS3QwmfdxMv7WFKYnpNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731032093; c=relaxed/simple;
	bh=3cztTihYZo4xA9hygtvWhr5TpY6hvzAesyX8VU5QESQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aJKgFVceMfXe27PT06YZuklZgaC5GbJofGvhFj0xMKRYb06dsajnQMEfVuz6TxLPzwgexTYuBL3Fizhey2+uJgqWl6fiFNPw++H6iyq1d9/KJ2ac1Xil88ihPDRIE0bB1xqXOFUQ89g82eby3ki+H+Tc9Dk8pnOKwgZnSCSGswU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=mkjvwKca; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4A82EWtzC1202723, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1731032072; bh=3cztTihYZo4xA9hygtvWhr5TpY6hvzAesyX8VU5QESQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=mkjvwKcaWQzXgNAfMpFaTdfzcNjPhxLwdoTfeIgWHwZJ8PenjzvfSliy8U4EXKEcg
	 SRpRM+JDxed2hsTVWviZTVPx6cMEymGxaUs6r7LsxC48EaxznxNCXIiGzqKckY4u5F
	 CAy26FPzTikJh05fh2lW2cwkZxBTw8wdBuGLHkED++1UKTJdOekC0ZBbHRU1FyvvHG
	 pP+PbhhM9IP3Eur3PtXDey7dhty5N6uarCsKwB04imfKdPsc2oGAFd+7R087p+/REs
	 NnCCw+flm9t2Pk68G89RbwQ3hCkN0xqQHq0pF90iN0HhWPk/QmSdhSLPYkOKCA3lJP
	 0r8EAlhIhjWfw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4A82EWtzC1202723
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 Nov 2024 10:14:32 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 8 Nov 2024 10:14:32 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 8 Nov 2024 10:14:31 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Fri, 8 Nov 2024 10:14:30 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Kalle Valo <kvalo@kernel.org>,
        "kernel-dev@igalia.com"
	<kernel-dev@igalia.com>
Subject: RE: [PATCH net 4/5] wifi: rtlwifi: fix init_sw_vars leak when probe fails
Thread-Topic: [PATCH net 4/5] wifi: rtlwifi: fix init_sw_vars leak when probe
 fails
Thread-Index: AQHbMRmw89WnohoICUq24jjuRahFUrKspUNA
Date: Fri, 8 Nov 2024 02:14:30 +0000
Message-ID: <422766e176204da8bf4c511f4df4c669@realtek.com>
References: <20241107133322.855112-1-cascardo@igalia.com>
 <20241107133322.855112-5-cascardo@igalia.com>
In-Reply-To: <20241107133322.855112-5-cascardo@igalia.com>
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

Thadeu Lima de Souza Cascardo <cascardo@igalia.com> wrote:
> If ieee80211_register_hw fails, the memory allocated for the firmware wil=
l
> not be released. Call deinit_sw_vars as the function that undoes the
> allocationes done by init_sw_vars.
>=20
> Fixes: cefe3dfdb9f5 ("rtl8192cu: Call ieee80211_register_hw from rtl_usb_=
probe")
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> ---
>  drivers/net/wireless/realtek/rtlwifi/usb.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/net/wireless/realtek/rtlwifi/usb.c b/drivers/net/wir=
eless/realtek/rtlwifi/usb.c
> index c27b116ccdff..8ec687fab572 100644
> --- a/drivers/net/wireless/realtek/rtlwifi/usb.c
> +++ b/drivers/net/wireless/realtek/rtlwifi/usb.c
> @@ -1037,6 +1037,7 @@ int rtl_usb_probe(struct usb_interface *intf,
>=20
>  error_init_vars:
>         wait_for_completion(&rtlpriv->firmware_loading_complete);
> +       rtlpriv->cfg->ops->deinit_sw_vars(hw);

Ah. You did this in this patch. Seemingly we can combine these two small
patches.=20

>  error_out:
>         rtl_deinit_core(hw);
>  error_out2:
> --
> 2.34.1


