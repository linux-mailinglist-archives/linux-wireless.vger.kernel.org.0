Return-Path: <linux-wireless+bounces-15121-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31DC29C13E0
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2024 03:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4B03283A30
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2024 02:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7775817996;
	Fri,  8 Nov 2024 02:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="WB0Oo4P+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCAD16415
	for <linux-wireless@vger.kernel.org>; Fri,  8 Nov 2024 02:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731031969; cv=none; b=Osc1FZRk0JEvXNOJbaSF2M1FJgxSA6+PJZqVyHbO3WqWPBMge1lahwyFqc10TGaWjsHRqFkFxWaeAXIP2yW0r2tIbP+r8204WR+yp4DF4Z71LSgv0+nj34194dexoqACC1WVV3HRQ/cp+J/ferKQrgvAFKiK9wuzcvv230Gsrvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731031969; c=relaxed/simple;
	bh=YF+3FaDgkyU0OUvQplDoRQXRB3JCMc4eI1WgFTGL21Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W8AUru8LA1lBSl71zB/OXVaHEkjG1/HqVXJTEt9SdfPm9wVmkcK5ZtMnZ6SJWr5mMW2eBycqf2EXGplyaqPuX2Jf3/FTOdM4TED7dhJdX0YIWXXeQOka9YXtgT642kG5e9lmhc8klAtcN5Tp9untJH10B2Yexjx8NbA+weBqcuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=WB0Oo4P+; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4A82CObgC1201486, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1731031944; bh=YF+3FaDgkyU0OUvQplDoRQXRB3JCMc4eI1WgFTGL21Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=WB0Oo4P++Adr+fBuc1xYFJvWPL24fsLFrVwggsEixfAap9X/rOPHSQui3isK3USUB
	 WuD12KkG/CQzjPw5g5IQjIBuZ4UFg2zXNeU5vDIETWhLrXHbrvaVGw36nh/BtcjTtO
	 aaLowO3dSWyz51gZw3ZdV2HyIsqVbicjzBd+8blRDF7ozPb8HVWsOGQFnGSAnr70rK
	 BTK3dZyFCLhUArm7rjB3strJ3dK9cERS5zMgKFCiRczcCS6vVEddAr6O76qnldO1tt
	 XfYwpWkNAq9L5ya05RhNzMd/3qN3QL21S08R/+jMd7mGSaSdPO3XHsUcCFdODxZW0m
	 vsyTu+yze2new==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4A82CObgC1201486
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 Nov 2024 10:12:24 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 8 Nov 2024 10:12:24 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 8 Nov 2024 10:12:24 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Fri, 8 Nov 2024 10:12:24 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Kalle Valo <kvalo@kernel.org>,
        "kernel-dev@igalia.com"
	<kernel-dev@igalia.com>
Subject: RE: [PATCH net 3/5] wifi: rtlwifi: wait for firmware loading before releasing memory
Thread-Topic: [PATCH net 3/5] wifi: rtlwifi: wait for firmware loading before
 releasing memory
Thread-Index: AQHbMRmuTPaJxz8bskiJKupHobKYwLKso7Mw
Date: Fri, 8 Nov 2024 02:12:24 +0000
Message-ID: <fe600a9588e045658ef4415e1ceb4983@realtek.com>
References: <20241107133322.855112-1-cascardo@igalia.com>
 <20241107133322.855112-4-cascardo@igalia.com>
In-Reply-To: <20241107133322.855112-4-cascardo@igalia.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

Thadeu Lima de Souza Cascardo <cascardo@igalia.com> wrote:
> At probe error path, the firmware loading work may have already been
> queued. In such a case, it will try to access memory allocated by the pro=
be
> function, which is about to be released. In such paths, wait for the
> firmware worker to finish before releasing memory.
>=20
> Fixes: a7f7c15e945a ("rtlwifi: rtl8192cu: Free ieee80211_hw if probing fa=
ils")
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> ---
>  drivers/net/wireless/realtek/rtlwifi/usb.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/wireless/realtek/rtlwifi/usb.c b/drivers/net/wir=
eless/realtek/rtlwifi/usb.c
> index c3aa0cd9ff21..c27b116ccdff 100644
> --- a/drivers/net/wireless/realtek/rtlwifi/usb.c
> +++ b/drivers/net/wireless/realtek/rtlwifi/usb.c
> @@ -1028,13 +1028,15 @@ int rtl_usb_probe(struct usb_interface *intf,
>         err =3D ieee80211_register_hw(hw);
>         if (err) {
>                 pr_err("Can't register mac80211 hw.\n");
> -               goto error_out;
> +               goto error_init_vars;
>         }
>         rtlpriv->mac80211.mac80211_registered =3D 1;
>=20
>         set_bit(RTL_STATUS_INTERFACE_START, &rtlpriv->status);
>         return 0;
>=20
> +error_init_vars:
> +       wait_for_completion(&rtlpriv->firmware_loading_complete);

The firmware request is trigged by rtlpriv->cfg->ops->init_sw_vars(hw), and
here is wait for filling rtlpriv->rtlhal.pfirmware and
rtlpriv->rtlhal.wowlan_firmware.
=20
The rtlpriv->cfg->ops->deinit_sw_vars(hw) is to free firmware. Shouldn't we
call it here? Also shouldn't PCI need this?

>  error_out:
>         rtl_deinit_core(hw);
>  error_out2:
> --
> 2.34.1


