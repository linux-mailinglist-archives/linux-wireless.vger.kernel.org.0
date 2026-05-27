Return-Path: <linux-wireless+bounces-36972-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDHQLsh3Fmr3mgcAu9opvQ
	(envelope-from <linux-wireless+bounces-36972-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 06:49:12 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3135DF3A2
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 06:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7C1F3034E1C
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 04:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA252DECBA;
	Wed, 27 May 2026 04:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kfqGdCQU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1199A126C17
	for <linux-wireless@vger.kernel.org>; Wed, 27 May 2026 04:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779857331; cv=none; b=aQ86GpyV5cvAMmKKODcnlGPoq+OZzu5BidoF7pZKIvP5LIzUt0Z1X0IqD9xAJrCJUraM976RXfThAUxoeRHwzWMnKMLA5efHWKrt49RSfpm1luD9LqxyIw+rcbeGrb2K6KWyGmg5HWKT34B5HYytSHqQuVokMSE81kNqr9ztc+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779857331; c=relaxed/simple;
	bh=gcXOw0+4VPlXnoQ3zjfVOMLGEHjJZkGy66gqMGI3BLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B2A5GZ+/oDSTcLbP2zZbscVujYeFvMyAHF22/96CRPclWUHQ3jKqO61FHma4BOF3c7GmHDqryKn5Jvsb8E0/NNvatfVs7ssejlqr/+pZ/2ogtfP11/tDn7eqYGJNlRuq75Fm+lj4ENyiq/shLncpKoc3KbNA4JaK1z6n95WmhEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kfqGdCQU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D01141F00ACF
	for <linux-wireless@vger.kernel.org>; Wed, 27 May 2026 04:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779857329;
	bh=7tcqr7MQL0zVS1iggjXewT5XwoMIhxNcBR9iISEez5U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=kfqGdCQUuAaBiaTBh3y9ct9XAO1y+AKkBZMqZ4H2SaloagRykPxJ0R+LSm/5MmI08
	 r1zv+XFg8cuVIwejzMDeJTKAjnYdmnYLXpx2cRqBvWimcwyFQj511vVNBDAkxdc45K
	 G/vXDhWYDYhh3q7ltZcBxavTOnJ8BZkyzC6FPW560HXG1VOv5ZfxUBPzI7Q/zQCw9t
	 Vbrtam07tYTDe+Dj3jmtVvAn6zi9yfy6SOPFklSc/nRoyk+mwloOr+mQVtPLivihoH
	 eGZTi0nOfLGMGnMs6dg7nd11JatMrD8f0o7CdZQJAFIfZgPMMOAppO8tKqHySJKBXs
	 E+Xw0xJ8F9f9w==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5a858881ad2so14045081e87.3
        for <linux-wireless@vger.kernel.org>; Tue, 26 May 2026 21:48:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9ApNgexHGlR3gshAlIgT2ClD7gdetcDyk1EpRChjgO4kpoKhl8HayvUbGfWiHyEMVVsG6k+OpDDwpOc/CWtQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyDzUKv7GQq7fkpCgJr/c39wwI5kT14m9eNNswMEfagF8ldEl88
	a5DTK7WfZJXUUSNBA1qNM643QJd2YMRBvy6PMbgOoR7+Qe9O6f7yfca7j6UmdfHXceL77d94Uex
	+dQOUZkMKg9NsV3sWycuWgDn0fLCKmCQ=
X-Received: by 2002:a05:6512:1452:10b0:5a6:31e9:1e56 with SMTP id
 2adb3069b0e04-5aa323263a9mr4824355e87.18.1779857328106; Tue, 26 May 2026
 21:48:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527034350.527482-1-zenghongling@kylinos.cn>
In-Reply-To: <20260527034350.527482-1-zenghongling@kylinos.cn>
From: Sean Wang <sean.wang@kernel.org>
Date: Tue, 26 May 2026 23:48:36 -0500
X-Gmail-Original-Message-ID: <CAGp9LzruaD57tE5XHHAM8mKoPc-JQSAcaTdgvdSfESJjz-9XnA@mail.gmail.com>
X-Gm-Features: AVHnY4Kn3PRAO-yghCTyjcaeRLsdka-fBpVL84WPL3a52LfxGBU64M6Iy9-CHoY
Message-ID: <CAGp9LzruaD57tE5XHHAM8mKoPc-JQSAcaTdgvdSfESJjz-9XnA@mail.gmail.com>
Subject: Re: [PATCH v2] wifi: mt76: mt7921: fix resource leak in probe error path
To: Hongling Zeng <zenghongling@kylinos.cn>
Cc: nbd@nbd.name, lorenzo@kernel.org, ryder.lee@mediatek.com, 
	shayne.chen@mediatek.com, sean.wang@mediatek.com, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, xiong.huang@mediatek.com, 
	madhurkumar004@gmail.com, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, zhongling0719@126.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36972-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[nbd.name,kernel.org,mediatek.com,gmail.com,collabora.com,vger.kernel.org,lists.infradead.org,126.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,kylinos.cn:email]
X-Rspamd-Queue-Id: 1E3135DF3A2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On Tue, May 26, 2026 at 10:44=E2=80=AFPM Hongling Zeng <zenghongling@kylino=
s.cn> wrote:
>
> When pcim_iomap_region() or devm_kmemdup() fail, the code returns
> directly without cleaning up previously allocated resources:
>   - mt76_device allocated by mt76_alloc_device()
>   - pci irq vectors allocated by pci_alloc_irq_vectors()
> Fix this by jumping to the existing error cleanup path instead of
> returning directly.
>
> To avoid using an uninitialized variable in the error path, move the
> dev initialization before the error checks.
>
> Fixes: 234738ea3390 ("phy: ti-pipe3: move clk initialization to a separat=
e function")
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
>

The code change itself looks correct, but commit message Fixes: tag is wron=
g.

It points to 234738ea3390 ("phy: ti-pipe3: move clk initialization to
a separate function"), which is unrelated to mt76/mt7921.

The two direct-return leaks appear to come from:
      - ee5bb35d2b83 ("wifi: mt76: mt7921: Replace deprecated PCI
function") for the pcim_iomap_region() path.
      - 222606f43b58 ("wifi: mt76: mt7921: handle MT7902 irq_map quirk
with mutable copy") for the MT7902 devm_kmemdup() path.

> ---
>  Change in v1
>    --fix uninitialized variable warning
> ---
>  drivers/net/wireless/mediatek/mt76/mt7921/pci.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7921/pci.c
> index 7a790ddf43bb..49a37185f056 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> @@ -343,11 +343,14 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
>
>         pci_set_drvdata(pdev, mdev);
>
> +       dev =3D container_of(mdev, struct mt792x_dev, mt76);
> +
>         regs =3D  pcim_iomap_region(pdev, 0, pci_name(pdev));
> -       if (IS_ERR(regs))
> -               return PTR_ERR(regs);
> +       if (IS_ERR(regs)) {
> +               ret =3D PTR_ERR(regs);
> +               goto err_free_dev;
> +       }
>
> -       dev =3D container_of(mdev, struct mt792x_dev, mt76);
>         dev->fw_features =3D features;
>         dev->hif_ops =3D &mt7921_pcie_ops;
>         dev->irq_map =3D &irq_map;
> @@ -359,8 +362,10 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
>                 /* MT7902 needs a mutable copy because wm2_complete_mask =
differs */
>                 map =3D devm_kmemdup(&pdev->dev, &irq_map,
>                                    sizeof(irq_map), GFP_KERNEL);
> -               if (!map)
> -                       return -ENOMEM;
> +               if (!map) {
> +                       ret =3D -ENOMEM;
> +                       goto err_free_dev;
> +               }
>
>                 map->rx.wm2_complete_mask =3D 0;
>                 dev->irq_map =3D map;
> --
> 2.25.1
>
>

