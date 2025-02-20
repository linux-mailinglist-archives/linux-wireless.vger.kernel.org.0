Return-Path: <linux-wireless+bounces-19163-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF7BA3D115
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 07:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98AF17A7E86
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 06:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5573C3C;
	Thu, 20 Feb 2025 06:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="fYbNqCht"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA39A920
	for <linux-wireless@vger.kernel.org>; Thu, 20 Feb 2025 06:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740031269; cv=none; b=u3FSH/m9Ys18s0Ab6vHAv2tzYPpZiUPuOj4nU6gq2b6p+5DkNcyhCm4UwLWh0gXwxoJaDRWiTNmgZKf3x/Iz6GVgHN5VFqzvZnfCgc8FE2epxh5R2RiTnAYCmZTUB14Slfjc2LW8/6jHVJ+UPRfUqMRZjYCJBJUtf9jwjgmBiuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740031269; c=relaxed/simple;
	bh=pFfEvkclB1SUxuIWLULlJIWw3T9z5gIhRaJKHmYiBCI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IMsvCcoRZRM3CHgNLEY2XsNIeDv80/GKv3q6Bn6DiBt06WpJW0hcl8DglwDr5qAazzZlGjB7amJ7pGPuWRUoRAcR3ebRLUwbzHRNxR2FvhgFepviaAgKzjdXp0d+pdpC++3kwAeOaWMYoJjqBaQ5sg8dLNF3wpbPQ0ETXJb3MH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=fYbNqCht; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51K60kbnE649968, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1740031246; bh=pFfEvkclB1SUxuIWLULlJIWw3T9z5gIhRaJKHmYiBCI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=fYbNqChtm1h/mO3xiXTOhmBkM++UcYK+B7V4DIuXZdtIxmTs2lMNTESmwT935yKWJ
	 yXg4AYjKM5IVK/WAI2PvUJ1uFKwCciGkeHz7l2UuePfwHzK0LOX/54LH/KO87tCI1I
	 fd6HAWZ2HZbJlG7ZCj+BcSAcTqsNIlrsHgoDAwSehW6d+lc5AD/FuyMCbNpykt41ii
	 uQytYW794as1WZHz+2yVgXWAEr16UcNQKlM25H6yJJVSkkfgMSGYiYQUeKRP6cGdpE
	 a1cVMAqAwkWbiRRiJcYE38XTnmWZumpNBs/AHG39Z8zp7L1rnaPBNV4UaL9v1lUunp
	 MnBmdm+U08aOA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51K60kbnE649968
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 14:00:46 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 20 Feb 2025 14:00:46 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 20 Feb 2025 14:00:46 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::f515:f604:42fb:a42b]) by
 RTEXMBS04.realtek.com.tw ([fe80::f515:f604:42fb:a42b%5]) with mapi id
 15.01.2507.035; Thu, 20 Feb 2025 14:00:46 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ezra Buehler <ezra@easyb.ch>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: Jes Sorensen <Jes.Sorensen@gmail.com>, Kalle Valo <kvalo@kernel.org>,
        Martin Kaistra <martin.kaistra@linutronix.de>,
        Bitterblue Smith
	<rtl8821cerfe2@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>,
        "Reto
 Schneider" <reto.schneider@husqvarnagroup.com>,
        Ezra Buehler
	<ezra.buehler@husqvarnagroup.com>
Subject: RE: [PATCH v1 2/3] wifi: rtl8xxxu: Use macid in rtl8xxxu_fill_txdesc_v1()
Thread-Topic: [PATCH v1 2/3] wifi: rtl8xxxu: Use macid in
 rtl8xxxu_fill_txdesc_v1()
Thread-Index: AQHbgvcQqwbsLOoYZk69NPCFL/JTp7NPsy/g
Date: Thu, 20 Feb 2025 06:00:46 +0000
Message-ID: <a19f9447ff694a4fa13648976a2f54fc@realtek.com>
References: <20250219175228.850583-1-ezra@easyb.ch>
 <20250219175228.850583-3-ezra@easyb.ch>
In-Reply-To: <20250219175228.850583-3-ezra@easyb.ch>
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

Ezra Buehler <ezra@easyb.ch> wrote:
> From: Ezra Buehler <ezra.buehler@husqvarnagroup.com>
>=20
> This is needed in order for AP mode to work correctly on gen1 devices
> like the RTL8192CU.
>=20
> For more information, see the corresponding change for gen2 devices,
> commit 9aa45598d054 ("wifi: rtl8xxxu: Put the macid in txdesc").
>=20
> Signed-off-by: Ezra Buehler <ezra.buehler@husqvarnagroup.com>
> ---
>  drivers/net/wireless/realtek/rtl8xxxu/core.c     | 2 ++
>  drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h | 1 +
>  2 files changed, 3 insertions(+)
>=20
> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c
> b/drivers/net/wireless/realtek/rtl8xxxu/core.c
> index cbd9efd22e3f..2fa22d3145a4 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
> @@ -5302,6 +5302,8 @@ rtl8xxxu_fill_txdesc_v1(struct ieee80211_hw *hw, st=
ruct ieee80211_hdr *hdr,
>                 dev_info(dev, "%s: TX rate: %d, pkt size %u\n",
>                          __func__, rate, le16_to_cpu(tx_desc->pkt_size));
>=20
> +       tx_desc->txdw1 |=3D cpu_to_le32(macid & TXDESC32_MACID_MASK);
> +

tx_desc->txdw1 |=3D le32_encode_bits(macid, TXDESC32_MACID_MASK);



