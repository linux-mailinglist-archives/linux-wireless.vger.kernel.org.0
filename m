Return-Path: <linux-wireless+bounces-32128-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGLsAZPYnGkFLwQAu9opvQ
	(envelope-from <linux-wireless+bounces-32128-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 23:45:39 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BF117E8A0
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 23:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42377302D979
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 22:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997C6378D9A;
	Mon, 23 Feb 2026 22:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q90md/KO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7603E3783DE
	for <linux-wireless@vger.kernel.org>; Mon, 23 Feb 2026 22:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771886509; cv=none; b=TBsWCCbDU0JatQTXLDqhISdcmlPLqA/rNW3BDCF8w1KpxWtC+wsA74QMqWpksjroyJROBHiSoyb9KITe+1f7WytTfWYx+BKw9R1FD0A01vqAcc7EOJT1d/Lh2AnB9R66pOoHuXs4pZ6go6YYjR9WFJcD5rOiD+twlzv+oMaq2rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771886509; c=relaxed/simple;
	bh=TeMt0AX/UmpbUNYFEiguHKbS1SjqNPE1azh8i2vqJzQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hlhEMihZbDTCaWkUGyTpqCYNKGOc9RoJpaYCCsthC+rWCRVFkECOPwYxTjF8IyIqexGrKHUq8Z/IykxpdZU9HOCf6Ws/xd4P1hKVue4uSUXt/YsC4S2SFL9XkDNwtfxvAgmk32rQ+wfXhcfOcoZ+sWb3lBamJvUcj2+jlPb7I2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q90md/KO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14FBDC2BC87
	for <linux-wireless@vger.kernel.org>; Mon, 23 Feb 2026 22:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771886509;
	bh=TeMt0AX/UmpbUNYFEiguHKbS1SjqNPE1azh8i2vqJzQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Q90md/KOfDcrfeagom1mAd7Dnb31vbELqv/0ewQ49+oNrfvDteCcF15V2QIFcXULU
	 2OLzBw2ngjDgswaMRmp1sqnGWkWuZgxtVyfBaWEfAbYBpbPKDjjEXC8iyUei9aM0kM
	 MZ3yxduWuGINQouT1LlLNajEQ65zx8t8yJhww+1Hqubax+F3Hgu1snRN4VK1QVvbTG
	 n1wHJtwowrr1tcsgwcaYYpJ5Rzb8WFOvCSC9qOIYqP451B/w3cBVq57KApTQnvk2zH
	 tI6TCQ2Xa7xn29xn0rQLAC+5jjiwCqKGuma7QANgvvRZJpSfZMEqlL5oC7qQKTLAmG
	 4ggxPjXV2EJVQ==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-385c23b88e8so40414361fa.3
        for <linux-wireless@vger.kernel.org>; Mon, 23 Feb 2026 14:41:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXpPZnXi4GUMvO06xoZVIzCAKONs5lt3W5jEGCAz67H4tmTC+95ft+OwAacIxaf+eOlGd6ZOKd4tdPf9PFM4w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxsZvRcz6lo6rav7o5h1TugH0IVb/LQ68kuPaeFxE2FBBAMtbMs
	2MSj+A1GhdSuBID7CUD9geLWQHnbnAw5wIa0/UPkph5Cu2Td/FC7ftW8X17KGdpD3WGmGzcVywO
	FU5FS0qIi5XaROO+xGBYrtPF5/NXfrgw=
X-Received: by 2002:a2e:a7cf:0:b0:386:7e61:5de1 with SMTP id
 38308e7fff4ca-389a58a71b3mr36637261fa.0.1771886507309; Mon, 23 Feb 2026
 14:41:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223073854.2464232-1-jb.tsai@mediatek.com> <20260223073854.2464232-2-jb.tsai@mediatek.com>
In-Reply-To: <20260223073854.2464232-2-jb.tsai@mediatek.com>
From: Sean Wang <sean.wang@kernel.org>
Date: Mon, 23 Feb 2026 16:41:34 -0600
X-Gmail-Original-Message-ID: <CAGp9LzoJ=bi2Ao9V2byetnNCkYunHdGV4i4VUzyYC_iHHPu7WQ@mail.gmail.com>
X-Gm-Features: AaiRm52Tkb3GZi5rcuvrRWZRAU3Z5n3dk8fj2slXJOZmMqBLAby5G5mYuaWZbxo
Message-ID: <CAGp9LzoJ=bi2Ao9V2byetnNCkYunHdGV4i4VUzyYC_iHHPu7WQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] wifi: mt76: mt7921: refactor CLC support check flow
To: JB Tsai <jb.tsai@mediatek.com>
Cc: nbd@nbd.name, lorenzo@kernel.org, linux-wireless@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, Deren.Wu@mediatek.com, 
	Sean.Wang@mediatek.com, Quan.Zhou@mediatek.com, Ryder.Lee@mediatek.com, 
	Leon.Yen@mediatek.com, litien.chang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32128-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mediatek.com:email]
X-Rspamd-Queue-Id: 58BF117E8A0
X-Rspamd-Action: no action

HI, JB

On Mon, Feb 23, 2026 at 1:40=E2=80=AFAM JB Tsai <jb.tsai@mediatek.com> wrot=
e:
>
> Move the disable_clc module parameter to regd.c and introduce
> mt7925_regd_clc_supported() to centralize CLC support checks.

typo, s/7925/7921/

>
> Signed-off-by: JB Tsai <jb.tsai@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7921/mcu.c  | 14 ++++++++------
>  drivers/net/wireless/mediatek/mt76/mt7921/regd.c | 13 +++++++++++++
>  drivers/net/wireless/mediatek/mt76/mt7921/regd.h |  1 +
>  3 files changed, 22 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7921/mcu.c
> index 8442dbd2ee23..1e2afa736cdf 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
> @@ -4,6 +4,7 @@
>  #include <linux/fs.h>
>  #include <linux/firmware.h>
>  #include "mt7921.h"
> +#include "regd.h"
>  #include "mcu.h"
>  #include "../mt76_connac2_mac.h"
>  #include "../mt792x_trace.h"
> @@ -11,10 +12,6 @@
>  #define MT_STA_BFER                    BIT(0)
>  #define MT_STA_BFEE                    BIT(1)
>
> -static bool mt7921_disable_clc;
> -module_param_named(disable_clc, mt7921_disable_clc, bool, 0644);
> -MODULE_PARM_DESC(disable_clc, "disable CLC support");
> -
>  int mt7921_mcu_parse_response(struct mt76_dev *mdev, int cmd,
>                               struct sk_buff *skb, int seq)
>  {
> @@ -422,8 +419,7 @@ static int mt7921_load_clc(struct mt792x_dev *dev, co=
nst char *fw_name)
>         u8 *clc_base =3D NULL, hw_encap =3D 0;
>
>         dev->phy.clc_chan_conf =3D 0xff;
> -       if (mt7921_disable_clc ||
> -           mt76_is_usb(&dev->mt76))
> +       if (!mt7921_regd_clc_supported(dev))
>                 return 0;
>
>         if (mt76_is_mmio(&dev->mt76)) {
> @@ -470,6 +466,9 @@ static int mt7921_load_clc(struct mt792x_dev *dev, co=
nst char *fw_name)
>         for (offset =3D 0; offset < len; offset +=3D le32_to_cpu(clc->len=
)) {
>                 clc =3D (const struct mt7921_clc *)(clc_base + offset);
>
> +               if (clc->idx >=3D ARRAY_SIZE(phy->clc))
> +                       break;
> +

I=E2=80=99d keep the refactor logic-preserving. This bounds check is a
correctness fix (prevents OOB on phy->clc[clc->idx])
so please send it as a separate hardening patch and describe the failure an=
d fix
Also, ARRAY_SIZE() is for compile-time arrays only if phy->clc were a
pointer, it would be invalid/misleading I guess.

>                 /* do not init buf again if chip reset triggered */
>                 if (phy->clc[clc->idx])
>                         continue;
> @@ -1403,6 +1402,9 @@ int mt7921_mcu_set_clc(struct mt792x_dev *dev, u8 *=
alpha2,
>         struct mt792x_phy *phy =3D (struct mt792x_phy *)&dev->phy;
>         int i, ret;
>
> +       if (!ARRAY_SIZE(phy->clc))
> +               return -ESRCH;
> +

Ditto,  to keep the refactor logic-preserving, send it as a separate
hardening patch and describe the failure and fix and also
!ARRAY_SIZE(phy->clc) isn=E2=80=99t a meaningful runtime check I guess.

>         /* submit all clc config */
>         for (i =3D 0; i < ARRAY_SIZE(phy->clc); i++) {
>                 ret =3D __mt7921_mcu_set_clc(dev, alpha2, env_cap,
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/regd.c b/drivers/n=
et/wireless/mediatek/mt76/mt7921/regd.c
> index 6e6c81189222..70440ab8ba82 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/regd.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/regd.c
> @@ -7,6 +7,19 @@
>  #include "regd.h"
>  #include "mcu.h"
>
> +static bool mt7921_disable_clc;
> +module_param_named(disable_clc, mt7921_disable_clc, bool, 0644);
> +MODULE_PARM_DESC(disable_clc, "disable CLC support");
> +

should we explicitly include <linux/moduleparam.h> ?

> +bool mt7921_regd_clc_supported(struct mt792x_dev *dev)
> +{
> +       if (mt7921_disable_clc ||
> +           mt76_is_usb(&dev->mt76))
> +               return false;
> +
> +       return true;
> +}
> +
>  static void
>  mt7921_regd_channel_update(struct wiphy *wiphy, struct mt792x_dev *dev)
>  {
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/regd.h b/drivers/n=
et/wireless/mediatek/mt76/mt7921/regd.h
> index 0ba6161e1919..74bc2fdd532c 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/regd.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/regd.h
> @@ -9,5 +9,6 @@
>  void mt7921_regd_update(struct mt792x_dev *dev);
>  void mt7921_regd_notifier(struct wiphy *wiphy,
>                           struct regulatory_request *request);
> +bool mt7921_regd_clc_supported(struct mt792x_dev *dev);
>
>  #endif
> --
> 2.45.2
>
>

