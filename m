Return-Path: <linux-wireless+bounces-32991-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oC80LtCIsWnkDAAAu9opvQ
	(envelope-from <linux-wireless+bounces-32991-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 16:22:56 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C453266634
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 16:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB09330BA3D6
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 15:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A6D3DF010;
	Wed, 11 Mar 2026 15:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gN4YsFTs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF643DF013
	for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2026 15:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773242446; cv=pass; b=ojIH8uVpfD/YnseP+kr2pAXD8IvLFDGkhzWlfkzPpAMAPNAEis91BAlO334D0DFySa37YmdUR0vtKAYlL4bZ85QaOt9Cc260iiu/lYEh/LzED9nHG2Ifcxm3SgP5bDoPH/H/vAVWc1lPkaxRUbkmCaN/HxBNegEKXjTFCKyOSVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773242446; c=relaxed/simple;
	bh=V+22eRHrigWrYxkHiqR9vOlR+K4gkNszfN3+2Xq9nl0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ii1bNGXtIJSMH0oz3fK7/ggJxx1BQfSGdexozSwTHww2fn7iajx8JCbDTit8Nj2ML38f3qm3Lxsd+ClYIm/yfT9T94koVewmSfzUnCoFnXe9rAxv/p6lwxxgu/GEpzqsw+WoVdBf7lvkS8s4WUolEwwU3TQDQFeEr7JRnK1lKsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gN4YsFTs; arc=pass smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-40f1a1f77a6so5943122fac.2
        for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2026 08:20:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773242442; cv=none;
        d=google.com; s=arc-20240605;
        b=TS8BYdJweKOwSMy9RoL7V8P2DGMz227J0KRpNjlwpc+VOcfNKCbPLJPDFTzHnn0IKy
         llqGaA7UNxcn27bd3pBjBemkihB8u2U9A3xhtPassNt75zneNIVWrAGkj7CzKGQx9MU9
         /Kk16tvNOFZJGNofaWpYdHl/KCrx8iXdYprpf38iElDhL57vcWZgVBC8WrM+hxAHb52Q
         ++54jTiDR3eNcSCSenkaHuWsdkJj6M5a7z3GlXcq4tRKvEZOnj3aj2pELys+7h+7mUWn
         yTBy5NZMQi6wVmDGA5o2X7mUJ5NjcVi1CcX42Cr7xRpj5m5nvsjTPgwSyS3lDyTBMaUa
         5V8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tVwkSbkn9G+vast5MTGqqJFGzMUmMHKoqYfYCiwNZ6k=;
        fh=E0TB4y4LMaoFv6/Nw7x0a0BXVcSkrLpEywfy4qTdIUc=;
        b=NTlHgWR1r51AAav7QW8v506jO/OA8sc7bMhA9JnmfgXxUgBfTCjvimrcJ3IStIngja
         OQ51Q79yPZr9MVPHwz0gQvzrpM7ZCBpA3jFkxeLpPMENpJUhlklH1uE8sW4vBKFpFgqp
         dn8eWrWhYH6jeoFqPY8WommIVbiLiapKjJYopE3jotnR/r0kw2Nf2sc5V0OdViN2279R
         0N/+roCmADUIyaJXtYfhUi6ZZjQhfo3xvdZvUorJ+Bjl1xfqBvtIobF7U+llQfQQaiV/
         jl8256uoqBpqJucvfxXtIqEuyBKsGlUF7Je9Gd+4WZyTVkibWpIEzVLCnDyLUwZxfTKG
         HroA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773242442; x=1773847242; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tVwkSbkn9G+vast5MTGqqJFGzMUmMHKoqYfYCiwNZ6k=;
        b=gN4YsFTszXiKIoVJB+haLG8WmjMXpRP+/lh+ulB7HKCOLFZdbYkCXpKIdw7q6cfyUZ
         2Io0gQHW+3tLUzbDp8Nn2gaDm2h0B5+Z16a5VRpNoPMLr/gas2vVxyhe2doTj6bTGRPy
         AlSjGvpGeL1zZzr79uvpCi/j1GA8tOrJnugLjkHpIpa7jmsPwgnyhcE9YoSqDSj3ZUzr
         crcHOU2Y8XsDkf6rqL9oXwE6Lv2oktZM6EKjjiktFa08mwV0i64FW+ErY4Rcyt91c1tw
         I58DKHW5luyCd/TsZTNnL4sWPYsZd4RX+yIZCavSKGB4nb1GsLRyoR2FD04wWZ7zTp0H
         j8ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773242442; x=1773847242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tVwkSbkn9G+vast5MTGqqJFGzMUmMHKoqYfYCiwNZ6k=;
        b=LLtYWAL51TtfGU7A2bB3kR+97YDu4zCGp/nG5pyRUUxNYkXCAv36v+MMGkyIfNFzKz
         ilHIx+LDfv+yHxzAYTe7QqTbVMkLArVv0C8cj894iMAKt4ASe8U9+oBzY26OB6TcX+/0
         9Tw2bn90JZJHK2pBfAvIJeOBB1joB/MpiQpmpAkRMsVBLZVoRPNsB9MbkhcgJZiFZvG5
         i4i4u7UKMl0drPMaI2XAMRlzi0GUYUdfObZinTKdLk4UVL3cwt4rkm2ZfVZLadE7vob/
         gTuyEl7leRvdWVWxRZ67iZtsKmw1/GZeGfz4D2WAzI6U4iP3J0DO9tKoCp5ztJeJFPU+
         ES9Q==
X-Gm-Message-State: AOJu0YzmhMrKM8VkkvRR1pB5c43SvUE8XGLoVAMDhihotdRHAHV9dnDH
	34bncYIqinBnpl3fzL4N63JG2vNHI8p+UtvTGaqsCxGIFSXcWrs2Q8AJlAUVOy85FNJxyjEJ09e
	dKVA+6LKGzJzIcstGizgtM/2bwJIHCRydk+GyQmkOKK0S
X-Gm-Gg: ATEYQzzY6vU60qCHgoNLvLlP5zUP+pGoEF+oIJvtGkS3Pg9SIuKD8E6Ize8hh1EuwPt
	4jx3vMI2FeDzRjjsN+QG1YH3H5ts15X3rnErAdeiA4rGteep9jQOTXNPr72s9eyID6m55609vo1
	VJVMC57FurROstOCZ3m/uA0xJ5i3hBw115bw/WRsdjfAO0ePveVj1TMXfYhNIIFS8+/kjznHqEd
	oap+oAdMHLi0T3LxH0ImGYnKBxVHANJPpvai1k1vZYeM6vfaajyMA+WW/VAUNxJeBut2rBqMU5p
	FTcFi7qZrZEo9jiwZNg8cv120g==
X-Received: by 2002:a05:6870:9381:b0:3ec:3d37:87da with SMTP id
 586e51a60fabf-4177c623092mr1789249fac.3.1773242441444; Wed, 11 Mar 2026
 08:20:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311020816.7065-1-pkshih@realtek.com>
In-Reply-To: <20260311020816.7065-1-pkshih@realtek.com>
From: LB F <goainwo@gmail.com>
Date: Wed, 11 Mar 2026 17:19:55 +0200
X-Gm-Features: AaiRm50J_8ykD35zTZ0w2h1lCtMFhV3gupPw-MTK7i5ytHZz2CnsThxHer5WOng
Message-ID: <CALdGYqTgNLLUNhB1_tRmZ0DBCgLXiB+REt6L1_CMm0QgjjMaAQ@mail.gmail.com>
Subject: Re: [RFT rtw-next] wifi: rtw88: add quirks to disable PCI ASPM for HP P3S95EA#ACB
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32991-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[goainwo@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,realtek.com:email]
X-Rspamd-Queue-Id: 1C453266634
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Ping-Ke,

I successfully applied your patch out-of-tree and performed rigorous
testing on the host machine.

I can officially confirm that the patch works flawlessly. The DMI
quirk triggered correctly and successfully prevented the
hardware-level PCIe bus lockups on my HP P3S95EA#ACB.

Testing Environment & Methodology:
- Kernel: CachyOS Linux 6.19.6-2-cachyos x86_64
- Toolchain: Clang/LLVM 21.1.8 (`make CC=3Dclang LLVM=3D1 modules`)
- Extraction: We fetched the strict
`drivers/net/wireless/realtek/rtw88` sub-tree out of the
torvalds/linux `v6.19` tree utilizing `git sparse-checkout` to cleanly
apply the patch without having to compile the entire 2.5GB+ kernel.
- The resulting `.ko` object files were compressed to `.zst` and
installed successfully over the generic CachyOS system driver objects.

Verification Conditions:
- Removed ALL local workarounds. `disable_aspm=3DY` is no longer forced
via `/etc/modprobe.d/` overrides.
- Power saving remains natively ON `wifi.powersave =3D 3` (managed by
NetworkManager).
- Left the laptop in multiple 5-10 minute complete idle states to
enforce sleep modes.

Post-Boot Log Analysis & Potential Improvement Proposition:
The system remained 100% stable without any kernel panics or UI freezes.
However, I continuously monitored the `dmesg` ring buffer and noticed
an intriguing behavior. While the laptop sits completely idle
(NetworkManager connected, but no active traffic), the `rtw88` driver
starts flooded the logs with thousands of firmware errors:

[ 1084.746485] rtw88_8821ce 0000:13:00.0: firmware failed to leave lps stat=
e
[ 1084.749662] rtw88_8821ce 0000:13:00.0: failed to send h2c command
[ 1084.752895] rtw88_8821ce 0000:13:00.0: failed to send h2c command

If my understanding of this architecture is correct, previously, when
ASPM wasn't disabled, this exact failure of the adapter firmare inside
`LPS_DEEP_MODE_LCLK` would violently lock up the PCIe bus and crash
the host. Now, thanks to your DMI ASPM quirk at the `rtw88_pci` level,
the host PCIe controller doesn't enter `L1` and is perfectly shielded
from the adapter locking itself up! The OS handles the timeouts
gracefully and driver recovery prevents a hard freeze.

A question for your consideration: Given the immense volume of these
`h2c` timeout errors (and the underlying firmware's fundamental
inability to cleanly enter/exit its own sleep states without L1
participation on this HP model), do you think it would be beneficial
to *also* dynamically disable LPS Deep sleep when this specific ASPM
quirk is triggered?

For example, dynamically forcing `rtwdev->lps_conf.deep_mode =3D
LPS_DEEP_MODE_NONE` when the DMI ASPM flag is active, strictly to
prevent the firmware from attempting a sleep cycle that is doomed to
fail and polluting the queues and logs? Perhaps this might also save
microscopic CPU interrupts from continuous H2C polling timeouts?

If you believe that simply letting the driver recover and tolerating
the error spam in `dmesg` is the preferred/safer upstream approach, I
am perfectly happy. The patch functions as advertised and system
stability is unequivocally restored!

Thank you immensely for your rapid debugging and definitive patch for
this long-standing issue and for bringing stability to this model.

Tested-by: Oleksandr Havrylov <goainwo@gmail.com>

*(Note: I was a bit unsure which of the two active mailing list
threads was the most appropriate place for this final report =E2=80=94 the
original bug discussion or the new RFT patch submission thread =E2=80=94 so=
 I
replied to both just to ensure it is correctly attached to the patch.
Apologies for the duplicate email!)*

Best regards,
Oleksandr Havrylov

=D1=81=D1=80, 11 =D0=BC=D0=B0=D1=80. 2026=E2=80=AF=D0=B3. =D0=B2 04:08, Pin=
g-Ke Shih <pkshih@realtek.com>:
>
> On an HP laptop (P3S95EA#ACB) equipped with a Realtek RTL8821CE 802.11ac
> PCIe adapter (PCI ID: 10ec:c821), the system experiences a hard lockup
> (complete freeze of the UI and kernel, sysrq doesn't work, requires
> holding the power button) when the WiFi adapter enters the power
> saving state.
>
> Add a quirk to disable ASPM.
>
> Reported-by: LB F <goainwo@gmail.com>
> Closes: https://lore.kernel.org/linux-wireless/CALdGYqSQ1Ko2TTBhUizMu_FvL=
MUAuQfFrVwS10n_C-LSQJQQkQ@mail.gmail.com/
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
>  drivers/net/wireless/realtek/rtw88/pci.c | 30 ++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wirel=
ess/realtek/rtw88/pci.c
> index ec0a45bfb670..0b60a0ce96a1 100644
> --- a/drivers/net/wireless/realtek/rtw88/pci.c
> +++ b/drivers/net/wireless/realtek/rtw88/pci.c
> @@ -2,6 +2,7 @@
>  /* Copyright(c) 2018-2019  Realtek Corporation
>   */
>
> +#include <linux/dmi.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
>  #include "main.h"
> @@ -1744,6 +1745,34 @@ const struct pci_error_handlers rtw_pci_err_handle=
r =3D {
>  };
>  EXPORT_SYMBOL(rtw_pci_err_handler);
>
> +enum rtw88_quirk_dis_pci_caps {
> +       QUIRK_DIS_PCI_CAP_ASPM,
> +};
> +
> +static int disable_pci_caps(const struct dmi_system_id *dmi)
> +{
> +       uintptr_t dis_caps =3D (uintptr_t)dmi->driver_data;
> +
> +       if (dis_caps & BIT(QUIRK_DIS_PCI_CAP_ASPM))
> +               rtw_pci_disable_aspm =3D true;
> +
> +       return 1;
> +}
> +
> +static const struct dmi_system_id rtw88_pci_quirks[] =3D {
> +       {
> +               .callback =3D disable_pci_caps,
> +               .ident =3D "HP Notebook - P3S95EA#ACB",
> +               .matches =3D {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "HP"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "HP Notebook"),
> +                       DMI_MATCH(DMI_PRODUCT_SKU, "P3S95EA#ACB"),
> +               },
> +               .driver_data =3D (void *)BIT(QUIRK_DIS_PCI_CAP_ASPM),
> +       },
> +       {}
> +};
> +
>  int rtw_pci_probe(struct pci_dev *pdev,
>                   const struct pci_device_id *id)
>  {
> @@ -1808,6 +1837,7 @@ int rtw_pci_probe(struct pci_dev *pdev,
>             bridge && bridge->vendor =3D=3D PCI_VENDOR_ID_INTEL)
>                 rtwpci->rx_no_aspm =3D true;
>
> +       dmi_check_system(rtw88_pci_quirks);
>         rtw_pci_phy_cfg(rtwdev);
>
>         ret =3D rtw_register_hw(rtwdev, hw);
> --
> 2.25.1
>

