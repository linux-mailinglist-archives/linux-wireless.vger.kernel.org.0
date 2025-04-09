Return-Path: <linux-wireless+bounces-21310-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ACF0A81F91
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Apr 2025 10:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C63019E59EE
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Apr 2025 08:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B1725A352;
	Wed,  9 Apr 2025 08:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="uuzKgUkG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F8F2550D9;
	Wed,  9 Apr 2025 08:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744186622; cv=none; b=V31DTYjhhstiR2Qe06ATQanRNi/e6VR2VevciZRpYLbUYXGLje+ZdmyscOsw0ARhxbk59RzHQIbGjL3zeBj5xZqkBKK99yFg1QDlMgIMa883nQDRZYqpRjICF231XvvCIn7eLpUCA1m685Qioq2ZQrsfW0XV5TE19pLiZxafayw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744186622; c=relaxed/simple;
	bh=h6CgCYyKE/mzMr9eg+tCZEt2jzGIbosM23RT+DB8mr8=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=GiDqChqsYCjS+2+FH/dn8sdcdsPdED++ANqPzFg3mteuilQrAObOqytJ8/VJd2R4h2i7clOAj1GNSrZy/2FgeEfP3l4IhpJCJ4yhddIPMykg9iq1kG/NUT+Kp2XKVX7EhyJCzjF7s+4WWxRC8v4P+ZCQAKKWVK1ESQv+KkPAd1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=uuzKgUkG; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1744186612; x=1744791412; i=markus.elfring@web.de;
	bh=1YJHp6epgREJ9ryf8kdlCCnU4DSI6UznrnADAXME3CU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=uuzKgUkGQVyPs66fE+1IhkN2AQ5w40Jz30r1M00YWgg4PR/3gKeg2+fsvH/M5jp2
	 6jbQubNyoyjOgQHq0PZYKLrcSEEHNPHjd8XmHgMVDVEYPa05CWIvz3dj7/1oiA62f
	 ganqsHhwsIgPtN5zJNlgGnWNA8If9rMMIV/VmCo8ZOVRlGHwBXb7T5BHYKVGNi4tl
	 jbNctl8B8XSdp+Utqk38mxTkKdMQZEFEJEL9lSvNTex86KTz8+KvKE6BawO6iNip6
	 xpqVXkqF8oJNbRwLL9RFi9dk4WyZYsgY0/mdMUTWyjlbTUpqF0lK1V7psu3mchRje
	 YTr2EPWIXByz4uK4ww==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.27]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M7Nmq-1tz8I41iQe-00F7Sz; Wed, 09
 Apr 2025 10:16:52 +0200
Message-ID: <8cf4d7d5-e9f8-4c10-810b-5c7da72db1c8@web.de>
Date: Wed, 9 Apr 2025 10:16:34 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: vulab@iscas.ac.cn, brcm80211-dev-list.pdl@broadcom.com,
 brcm80211@lists.linux.dev, linux-wireless@vger.kernel.org
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Arend van Spriel <arend.vanspriel@broadcom.com>,
 Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
 Kalle Valo <kvalo@kernel.org>, =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megi@xff.cz>,
 Sai Krishna <saikrishnag@marvell.com>
References: <20250406081930.2909-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] brcm80211: fmac: Add error check for brcmf_usb_dlneeded()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250406081930.2909-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yMPQ9G5ZsbpKYU067fpj1wYqk1uW/OnPvh6SXiN2B7pwB5kHnXT
 AOlBTXLf8JMQFbiIZoCU26LjvgCIJ32cd0eamP9twA/+MLzo8hwcCYVp31RtCAJrsnwF7uZ
 M7A2Imz2lYbajLG5/I66n+mV1HhgESfzqL+x8EFY1TMI6awlgMAowjYzl4YbPknKssAwOHs
 SB9NjgRm1PC6YSDxpEs8A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/QrlraN5r0k=;iZ33Kw0PCBy1LINLZzn/xnbJ0Zh
 g5xcTMqUz3kS9YQZtAQ507pA4VC5YiS5dExWcU5I9bkUBZRTZ+zshPEDYaPKMdtfJm/xbvFpt
 Iv8mP2lX+g/oIGhziOldg/kLwq67h9xq7zhB34AyyL0vBQ+8QOABmUtf7u+XJLbsIyzm9kroY
 XbwERg6HrHJKelvPaPl5LdbxrUS7DMsp7fn/68Rkiha16WZa3Tzbd3qfemYWswrX5UEzLQew+
 qX+GmtzuJmiq+rBl8E0BQw4X8v/i1kjqS0JJxhTaIfJC+O0Aisr1z8hiyAKYpGovFcs39Z/GC
 aO/1RC40/TtsJEVJceVzBPN1pl90EyS73k3EsLd8rfg9r2W2IfqSK0qOlKhhmYVAD+Y3KfvA6
 YmqACZddDF4/bIfGNcKg2qBrDHNzPpxmYNDw18ftwqeGZoZ4LHyxj78Nm+E4RH3WxuM0dAlZl
 4d+UKEoXX2U6aipayfwchW5FhNIVViUdgzLJZJr3M9jMnnn7YbSNTRdClQcL4I+BGEllfDniA
 VTqrgdKaxGP49TjTbCffUygQPG9CQoX8eFRiX7qV9MH20XwLrwpaIJS9YAHVORnWnsmyjZBb2
 rjTQdmAC9mASZ0JR669n6jORj6nyXdouydsfdYd5HrMBGzv/hBGyHvULGMxLSGs9sDQHnzkyO
 wmhjPqT9ezbaqF4IV/YEWJZX4CtGyHKli3mM+wqadxnboV80Whc+i2rnXArvuOstM3W53Drdl
 1mJNJm2kxLMaVTF8fEkMYVj2Is5WZETgo4Drc1xXr+1iI4dCpPFptNOrhVbTPmjM3lI2IO07p
 xxUt1FYCO5WtbO8a+0U2P74UZ5k2+5nq0z8/CHZuv/LS3Fu0zZA2ckRrMDxcHFnxUkJTJVU6x
 Lc8ZbUW/1N+QldL9YKyL7BB4SUTAYMUl8Dh/WfLJ3OM54+VHrf7xXs3lh7qHT0a4WLA2yJY0s
 wsZ3rap9uHXX9tfhmqgJpfmsVj+hx9TcpWgXqm7cGR+O2Em5vt9FAhnukpOiWmx6qJbtPQ6mC
 XMbk/HpBAiY/9XzVZX9vbzLiOWoQW/vCFEvo0sZ4TRoCEP1PAx1Nx7Lgau80QAXu61Vayi7sM
 4RJ19dLBA0ZBuaOLk+U4hrblL6Wm47Xg2MqbxMF2lYTs4ezolE2uclZ4F5A3DudZYlHmoaU8m
 3VCkO3oZx/cMV2zuvHC1l1/bBiDguU2VW5cgshJGdBlvkpfx2xNcTeMR/yIKJ46VNelYz4mLK
 u/UaCJhgNuRNjvzZtbvdDSgML3Fwlp686ioFPTtdLWzwJvkhjCQyfXsCkaMsku+kzP/3NkiMd
 6diezPdeUdJ/y7ZGa0ThIaFC2aVdzVuow9T1aRao8BsishaXOBZiqcUzur9l+zxEEK4GxHu4f
 17nPPQ5zIsZ+KCmEkAWOOP2PFwX01Mq6bs9ekJ5GtDtq04gMvGwceH8kw3CWatI7hUjXUupMi
 bvIKx4PCiejdhulZTY8Nj8JJvOQEneeF+c3eTnUoonS8t/f52Kbs6rMqZOD1q0oHdP+ukCg==

=E2=80=A6
> Add error handling for brcmf_usb_dl_cmd() to return the function if the
> 'id.chiprev' is uninitialized.

* Please reconsider the offered conclusion once more.

* I propose to replace the word =E2=80=9Cfor=E2=80=9D by =E2=80=9Cin=E2=80=
=9D (before function names)
  in some summary phrases.


=E2=80=A6
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
=E2=80=A6
> @@ -798,7 +799,11 @@ brcmf_usb_dlneeded(struct brcmf_usbdev_info *devinf=
o)
>
>  	/* Check if firmware downloaded already by querying runtime ID */
>  	id.chip =3D cpu_to_le32(0xDEAD);
> -	brcmf_usb_dl_cmd(devinfo, DL_GETVER, &id, sizeof(id));
> +	err =3D brcmf_usb_dl_cmd(devinfo, DL_GETVER, &id, sizeof(id));
> +	if (err) {
> +		brcmf_err("DL_GETID Failed\n");
> +		return false;
> +	}
=E2=80=A6

Would an error hint like =E2=80=9CDL_GETVER failed\n=E2=80=9D be more appr=
opriate here?

Regards,
Markus

