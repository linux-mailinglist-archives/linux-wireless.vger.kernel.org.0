Return-Path: <linux-wireless+bounces-33918-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOx8E8jPxGli4AQAu9opvQ
	(envelope-from <linux-wireless+bounces-33918-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 07:18:48 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A503632FAF9
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 07:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 526AE3016917
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 06:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C31342538;
	Thu, 26 Mar 2026 06:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KrdoafSQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1C4217704
	for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 06:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774505708; cv=none; b=TRIfRsFqBN/mm/EE8jEAjrU0/egKGOdyKZNnqJqMMmrPBo8DmKJ4S9Ua1MLEkSUl3D5HOSIDxFKn85fwks2Vd0aetd25AN/hA3swtQyOlx0FqqPGtsxcYb8ay239Y4r6VqPt6fQzPsxGm9SwA24cvDwnLaBl3L0Ho2vjL2tnfmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774505708; c=relaxed/simple;
	bh=qNPDzY1c3zPMJCL6JgWJwXs7dJyiTLP5CKNIBdYLW2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nOinf12nMTRIg3YJ2T6XelT3W9sfELfm99OGSYucYuDXbZGI6m4u5oS6sgyTGLOWaWWCSvd9tphRiMOnqkaV4ORSr1kmzNyncAU/l+htwpefYXNVf2CXhgcVg2wFAyp+8Ud0Vpnq+ZzVzvA4tqKFhoojW2FicptJoKGoecowUZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KrdoafSQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6D43C2BCB5
	for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 06:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774505707;
	bh=qNPDzY1c3zPMJCL6JgWJwXs7dJyiTLP5CKNIBdYLW2E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KrdoafSQp/PoGdrRZrHSdDIbUO3qnqh4298eJxgPd58fUG9mGedPkOEWKbzYL/fSz
	 knapw+oWNpV6otfvqTOA97un0IcFxNztV3IRnO3egICzYCtMXekXIiBraTfbVJzlDM
	 LwQ6oacGYegjnPHUDC+4oMISal/9t8FfaKFVSgy9bNm18pjET6KRT81yN9ZHnOHUlq
	 ypHTL+I6NvrJM7EIZFeeT6XyzOKtZElOSTFqKHPjuACyxhw/uF8+2rmHBXEq/5jDiX
	 x8xsfl2J1V4Jf5hA/RD/lLS8VXequw9rbvU4f55++hwT9mN//ge+ArmHLcWKl7XOik
	 GXxvbCLQe0awQ==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-38ad26e3992so4466581fa.1
        for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 23:15:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWqtD0xfMZyrSI/CNnfCLU+9SBsubwjdqNyrqq8IJYzviaopSQEgph1E1LUp/WWsK3WbH+Mlw3sgjqjFK8HcA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxNauvbUxt1NT9du/GfENBfJHIDA5tJBTZy0QZlFTx/Y9uXtMoa
	44GmW9Ym8kgDTL/U/FdtIR8rdO3M/eVS5cgVYoA/L4chVy6USPIIXEbeGwfckjK+x2OdKKnS7Ku
	Jzp0Jg3BHZEhF5uo1G+NnDxaAeswGCnc=
X-Received: by 2002:a05:651c:4081:b0:389:f13f:8082 with SMTP id
 38308e7fff4ca-38c4320f5e3mr14222931fa.37.1774505705946; Wed, 25 Mar 2026
 23:15:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325-mt7927-wifi-support-v2-v3-0-5ca66c97a755@jetm.me> <20260325-mt7927-wifi-support-v2-v3-12-5ca66c97a755@jetm.me>
In-Reply-To: <20260325-mt7927-wifi-support-v2-v3-12-5ca66c97a755@jetm.me>
From: Sean Wang <sean.wang@kernel.org>
Date: Thu, 26 Mar 2026 01:14:56 -0500
X-Gmail-Original-Message-ID: <CAGp9LzpdV3TEK2LNrjotgJX10a-WyAb_8P_kpTNYVtUta2Q2MQ@mail.gmail.com>
X-Gm-Features: AQROBzB7OndRY6rEIWjHQOhEVzDIfM5J7pucQeFuRa7TwBdAyjB6Crc6NPXHqfI
Message-ID: <CAGp9LzpdV3TEK2LNrjotgJX10a-WyAb_8P_kpTNYVtUta2Q2MQ@mail.gmail.com>
Subject: Re: [PATCH v3 12/13] wifi: mt76: mt7925: disable ASPM and runtime PM
 for MT7927
To: Javier Tia <floss@jetm.me>
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, 
	Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Ming Yen Hsieh <mingyen.hsieh@mediatek.com>, Deren Wu <deren.wu@mediatek.com>, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [8.84 / 15.00];
	URIBL_BLACK(7.50)[jetm.me:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-33918-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[kernel.org:s=k20201202];
	GREYLIST(0.00)[pass,meta];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[nbd.name,kernel.org,mediatek.com,gmail.com,collabora.com,vger.kernel.org,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.699];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,jetm.me:email]
X-Rspamd-Queue-Id: A503632FAF9
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spam: Yes

Hi, Javier

On Wed, Mar 25, 2026 at 5:13=E2=80=AFPM Javier Tia <floss@jetm.me> wrote:
>
> Disable PCIe ASPM unconditionally for MT7927. The CONNINFRA power
> domain and WFDMA register access are unreliable with PCIe L1 active,
> causing throughput to drop from 1+ Gbps to ~200 Mbps.
>
> Disable runtime PM and deep sleep for MT7927. The combo chip shares
> a CONNINFRA power domain between WiFi (PCIe) and BT (USB).
> SET_OWN/CLR_OWN transitions on the LPCTL register crash the BT
> firmware, requiring a full power cycle to recover. PM enablement will
> be addressed in a follow-up once safe power state transitions are
> determined.
>
> Signed-off-by: Javier Tia <floss@jetm.me>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7925/init.c | 6 +++++-
>  drivers/net/wireless/mediatek/mt76/mt7925/pci.c  | 9 +++++++--
>  2 files changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/init.c b/drivers/n=
et/wireless/mediatek/mt76/mt7925/init.c
> index c4c99380f5b5..89140fc6a2b6 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7925/init.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
> @@ -243,7 +243,11 @@ int mt7925_register_device(struct mt792x_dev *dev)
>         dev->pm.idle_timeout =3D MT792x_PM_TIMEOUT;
>         dev->pm.stats.last_wake_event =3D jiffies;
>         dev->pm.stats.last_doze_event =3D jiffies;
> -       if (!mt76_is_usb(&dev->mt76)) {
> +       /* MT7927: runtime PM disabled. The combo chip shares a CONNINFRA
> +        * power domain between WiFi (PCIe) and BT (USB). SET_OWN/CLR_OWN
> +        * transitions on the LPCTL register crash BT firmware.
> +        */

I think this level of detail is better kept in the commit message. For
the code itself, a short comment should be enough, or even no comment
if the condition is already clear enough.

> +       if (!mt76_is_usb(&dev->mt76) && !is_mt7927(&dev->mt76)) {
>                 dev->pm.enable_user =3D true;
>                 dev->pm.enable =3D true;
>                 dev->pm.ds_enable_user =3D true;
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7925/pci.c
> index 393d9f408b84..693e08f35d68 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
> @@ -530,7 +530,13 @@ static int mt7925_pci_probe(struct pci_dev *pdev,
>         if (ret)
>                 goto err_free_pci_vec;
>
> -       if (mt7925_disable_aspm)
> +       is_mt7927_hw =3D (pdev->device =3D=3D 0x6639 || pdev->device =3D=
=3D 0x7927);
> +
> +       /* MT7927: CONNINFRA power domain and WFDMA register access are
> +        * unreliable with PCIe L1 active, causing throughput to drop
> +        * from 1+ Gbps to ~200 Mbps. Disable ASPM unconditionally.
> +        */

Ditto

> +       if (mt7925_disable_aspm || is_mt7927_hw)
>                 mt76_pci_disable_aspm(pdev);
>
>         ops =3D mt792x_get_mac80211_ops(&pdev->dev, &mt7925_ops,
> @@ -562,7 +568,6 @@ static int mt7925_pci_probe(struct pci_dev *pdev,
>         dev =3D container_of(mdev, struct mt792x_dev, mt76);
>         dev->fw_features =3D features;
>         dev->hif_ops =3D &mt7925_pcie_ops;
> -       is_mt7927_hw =3D (pdev->device =3D=3D 0x6639 || pdev->device =3D=
=3D 0x7927);
>         dev->irq_map =3D is_mt7927_hw ? &mt7927_irq_map : &irq_map;
>         dev->dma_config =3D is_mt7927_hw ? &mt7927_dma_cfg : &mt7925_dma_=
cfg;
>         mt76_mmio_init(&dev->mt76, pcim_iomap_table(pdev)[0]);
>
> --
> 2.53.0
>
>

