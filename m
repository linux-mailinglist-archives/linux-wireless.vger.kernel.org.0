Return-Path: <linux-wireless+bounces-15768-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4FD9DB042
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Nov 2024 01:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18F7D281EFB
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Nov 2024 00:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E23946F;
	Thu, 28 Nov 2024 00:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="NOlz87wO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC799460
	for <linux-wireless@vger.kernel.org>; Thu, 28 Nov 2024 00:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732753509; cv=none; b=sjPMZaSJDeORM4F4xCQLoltPSy2n5P1YoV94xQJ/VBln/4yB78yVXvLtGHR4jD06GZwZT0Q6U7+wbpp8YBko9fd0YF5I1Fxu98RdafVIg6YQCrjgdO1dg6YmQHx1ShRctoOB7W/uvgtJxoiBkaLonmRGYnswDQaeXEPJVwYN2uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732753509; c=relaxed/simple;
	bh=FHPALMTf6MCep8ThMIcNPqbxvQTPCez3J2KrKrWlclI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PkxHif0d/wD4PM8LebBm5FqDSH1nfIn+pA33K0bnN/jjtuyKZB5hHnYQWOpwEIBUCxooOtwLrxTOaV3JM/UETpFAKI2OHwlHtwapDScyXxwYAiHfinhi4zN4QQYhrgRstzEJlGwqAPYlnwXzvIrlsJTGM3ntP1XYKKekA+40fr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=NOlz87wO; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AS0ONUJ03512670, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1732753463; bh=FHPALMTf6MCep8ThMIcNPqbxvQTPCez3J2KrKrWlclI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=NOlz87wOVvVuJTVBH0vSj+0907R4QaVV9IL2pyZgjnMqjcIGSnn3qeam5niHIKmgk
	 STi/7Ny6m3cViKXu9fqbS28paEmGNZejcy6WYjNwnDXucJMMuq4ZyUMJdTPYSOmx1B
	 JE22iTyuMYS49aCfd1gGVHBPBWqluwzbbf7ZmY7XSVjR7+ixVqoAb7tCsgv7+ypy7E
	 p1eu1LhlzIJ3oY6ATrFL3GjpoX4208LzH5GcCectQB7aXU6EJhPdnJ756O5pWa/Oh2
	 +fo5+wL3cyotRMBNSoq57j50sdjWFyTuaK5Z2nQ+C6W7cj5kp34rh4GEiArShq7i2o
	 2IiPZekbXJrmQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AS0ONUJ03512670
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Nov 2024 08:24:23 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 28 Nov 2024 08:24:23 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 28 Nov 2024 08:24:23 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Thu, 28 Nov 2024 08:24:23 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Kalle Valo <kvalo@kernel.org>,
        "ath12k@lists.infradead.org"
	<ath12k@lists.infradead.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 06/10] wifi: ath12k: do not return invalid link id for scan link
Thread-Topic: [PATCH 06/10] wifi: ath12k: do not return invalid link id for
 scan link
Thread-Index: AQHbQCaF7nhqx2zVwkywGVOr5GZ5ILLL1rHg
Date: Thu, 28 Nov 2024 00:24:23 +0000
Message-ID: <88c1e8dd79344ec1ad414de78d2977e0@realtek.com>
References: <20241126171139.2350704-1-kvalo@kernel.org>
 <20241126171139.2350704-7-kvalo@kernel.org>
In-Reply-To: <20241126171139.2350704-7-kvalo@kernel.org>
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

Kalle Valo <kvalo@kernel.org> wrote:
> @@ -7688,10 +7698,19 @@ int ath12k_mac_vdev_create(struct ath12k *ar, str=
uct ath12k_link_vif *arvif)
>         u16 nss;
>         int i;
>         int ret, vdev_id;
> +       u8 link_id;
>=20
>         lockdep_assert_wiphy(hw->wiphy);
>=20
> -       link_conf =3D wiphy_dereference(hw->wiphy, vif->link_conf[arvif->=
link_id]);
> +       /* If no link is active and scan vdev is requested
> +        * use a default link conf for scan address purpose.
> +        */
> +       if (arvif->link_id =3D=3D ATH12K_DEFAULT_SCAN_LINK && vif->valid_=
links)
> +               link_id =3D ffs(vif->valid_links) - 1;

link_id =3D __ffs(vif->valid_links);

since it checked vif->valid_links against 0 first.


> +       else
> +               link_id =3D arvif->link_id;
> +
> +       link_conf =3D wiphy_dereference(hw->wiphy, vif->link_conf[link_id=
]);
>         if (!link_conf) {
>                 ath12k_warn(ar->ab, "unable to access bss link conf in vd=
ev create for vif %pM link %u\n",
>                             vif->addr, arvif->link_id);


