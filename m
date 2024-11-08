Return-Path: <linux-wireless+bounces-15123-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A079C1404
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2024 03:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE67DB21089
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2024 02:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2311BD9E5;
	Fri,  8 Nov 2024 02:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="L/HyMBib"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7DC1BD9D1
	for <linux-wireless@vger.kernel.org>; Fri,  8 Nov 2024 02:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731032651; cv=none; b=LwA5Ys4X/apaKjRPjOGYwM/xHb2oZ99OO4UzKmUtAurXIDsefw39ALQ+bQnMrg4DnKvNqz/gk3oeEX3wSuRTl4gOvJTQcxya2FByQBECAQ+HixXptMOCH6oKi0IHe+8n4YXmyCK/EdPYFquL04Ku9V0WiCM/vlK1AAE84SyScxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731032651; c=relaxed/simple;
	bh=0kXv0rRTNkhlD26cSxK+RkowHbSAjk1/tM9bRheCoEA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NXvVZBgOjC07TvH7jF8uWULCDuUf5Rai8xHGXJePuZH8FTLjOx5jkiwj88tTGPvtiixk/YFOjkIiR649UwYCWUKYDfM+cXkyzoRSbV0fj8I2Hy+Q2gMdb/QJQALUbIRmA/rO5v3zms/KCKzHnppueMMZq+fbR3lbjVRCrUzuuyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=L/HyMBib; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4A82NnA521231689, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1731032629; bh=0kXv0rRTNkhlD26cSxK+RkowHbSAjk1/tM9bRheCoEA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=L/HyMBibiSt+FveZsu439AxmMedNmPHDOfnEaVAQi8VV8QnGaLtBUhTb25YJDbX0Y
	 QLgI5lluuy8dDy5FPD2mkGJ5xF6/bkr9c9Un3fmNCWnY/dMzxsGkodrMfZpz6iS77p
	 3jFZH/LRR44l951VgGmmGvrlOt0e+Biq0RfbBBQXzTEJbG55y+KkWfWmGbsJiU+NqI
	 o2cv0FNY6+lM01VvE9guA3MIgQji0ZSaCqnqMs+F3KWWg+oiSp0IPCKh/wnyMgByjm
	 j7Siue1BrY1RFSdBIrbLISckHS3BUI3DY6PW+X2Pici+5SNLKGp26XdrF0o5ysoSLz
	 wsy5ChyUpSmPg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4A82NnA521231689
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 Nov 2024 10:23:49 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 8 Nov 2024 10:23:49 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 8 Nov 2024 10:23:49 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Fri, 8 Nov 2024 10:23:48 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Kalle Valo <kvalo@kernel.org>,
        "kernel-dev@igalia.com"
	<kernel-dev@igalia.com>
Subject: RE: [PATCH net 5/5] wifi: rtlwifi: usb: fix workqueue leak when probe fails
Thread-Topic: [PATCH net 5/5] wifi: rtlwifi: usb: fix workqueue leak when
 probe fails
Thread-Index: AQHbMRmyetrUO5Ddvk2+060ZgCtCdrKsp0/g
Date: Fri, 8 Nov 2024 02:23:48 +0000
Message-ID: <d66c4ae9004c43058c89fcc3d97f4b41@realtek.com>
References: <20241107133322.855112-1-cascardo@igalia.com>
 <20241107133322.855112-6-cascardo@igalia.com>
In-Reply-To: <20241107133322.855112-6-cascardo@igalia.com>
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
> rtl_init_core creates a workqueue that is then assigned to rtl_wq.
> rtl_deinit_core does not destroy it. It is left to rtl_usb_deinit, which
> must be called in the probe error path.
>=20
> Fixes: 2ca20f79e0d8 ("rtlwifi: Add usb driver")
> Fixes: 851639fdaeac ("rtlwifi: Modify some USB de-initialize code.")
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> ---
>  drivers/net/wireless/realtek/rtlwifi/usb.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/net/wireless/realtek/rtlwifi/usb.c b/drivers/net/wir=
eless/realtek/rtlwifi/usb.c
> index 8ec687fab572..0368ecea2e81 100644
> --- a/drivers/net/wireless/realtek/rtlwifi/usb.c
> +++ b/drivers/net/wireless/realtek/rtlwifi/usb.c
> @@ -1039,6 +1039,7 @@ int rtl_usb_probe(struct usb_interface *intf,
>         wait_for_completion(&rtlpriv->firmware_loading_complete);
>         rtlpriv->cfg->ops->deinit_sw_vars(hw);
>  error_out:
> +       rtl_usb_deinit(hw);
>         rtl_deinit_core(hw);
>  error_out2:
>         _rtl_usb_io_handler_release(hw);

I think deinit should be in reverse order of init step by step:

--- a/drivers/net/wireless/realtek/rtlwifi/usb.c
+++ b/drivers/net/wireless/realtek/rtlwifi/usb.c
@@ -1017,7 +1017,7 @@ int rtl_usb_probe(struct usb_interface *intf,
        err =3D rtl_init_core(hw);
        if (err) {
                pr_err("Can't allocate sw for mac80211\n");
-               goto error_out2;
+               goto error_out_usb_deinit;
        }
        if (rtlpriv->cfg->ops->init_sw_vars(hw)) {
                pr_err("Can't init_sw_vars\n");
@@ -1040,6 +1040,8 @@ int rtl_usb_probe(struct usb_interface *intf,
        rtlpriv->cfg->ops->deinit_sw_vars(hw);
 error_out:
        rtl_deinit_core(hw);
+error_out_usb_deinit:
+       rtl_usb_deinit(hw);
 error_out2:
        _rtl_usb_io_handler_release(hw);
        usb_put_dev(udev);

Have you also considered PCI? It seems that rtl_pci_deinit() isn't called i=
f
PCI probe fails.=20



