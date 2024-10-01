Return-Path: <linux-wireless+bounces-13372-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 843CD98BB6B
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 13:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B63231C232EB
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 11:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64C81BF81B;
	Tue,  1 Oct 2024 11:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQMkQDxD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E621A00EE
	for <linux-wireless@vger.kernel.org>; Tue,  1 Oct 2024 11:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727782952; cv=none; b=MSCuphlkGNlgidocIA4oMcScvP3Fav/eivHHpK1gj25BHCVReYlhYPJ5fhyRN6M57PZIFCs8A2wOMIHAjRiNHoDo1ozZalosLtst/kygCaiOc3x7h0lcfyEJayHfVY5JSzUZO7LLqF8REGhrvD0f4lmffQulFHa2ziXaHUkTggE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727782952; c=relaxed/simple;
	bh=ARtefMh24v7+jgn+p21E+waDQzHelUX4A47ryHja1Uw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CFJvQ6g2N7ZXEi6Li9Rmm/F+iUWaIjUt7ITDJmXetmC2YU/VIvA3NBuXa0GhH5srqMbJ1VV10SxySmdzOzefV+XXbhdXATakWklmnjcbUCPgpM6gHz107SLI4AfZM5/IxtwIj2VH4P3/yzjjJ2Hcf1vEthJm7w94iBmVfPDrMfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQMkQDxD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36AB9C4CECE
	for <linux-wireless@vger.kernel.org>; Tue,  1 Oct 2024 11:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727782952;
	bh=ARtefMh24v7+jgn+p21E+waDQzHelUX4A47ryHja1Uw=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:Cc:From;
	b=YQMkQDxDugSAL16nBCD41yZkFQC+DivDisIstJIwOvPllMPCD8f9K8uyY5678NWQ3
	 GCL8CwmefvCOBhKsOE3i9Q7oCpA4FXlJgkyLS5Hg5+qv5j5vSBjr2MVWwxzF3gLvKg
	 H1joeushCLPIzNmcDXwuxA/OcrcSi5p+s7TFd96Q9Znu1x6I7AUtM9hgNXQfmjSWCv
	 9Qr7dGTKG8rWBw1JQG0TFQyYKXU5q/zHt5PB1zNlZtCwE6BQL63bd+3rCZqfyau6AZ
	 togxn9GdZujmROFT3Y18Lr+DhbJ1aEn9hUFGeTgoPjUlp2hd3WcldgTTGK6DDWZceZ
	 bAT164TI9BKsw==
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6e129c01b04so42955837b3.1
        for <linux-wireless@vger.kernel.org>; Tue, 01 Oct 2024 04:42:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVN5Fha3amrpzxNLTJtllIQPA5XS5WAMvKQWC4EqijyKdlUJ79DsOjfqG/e9aPFJ5btBk9LzCeXMlmaOsgCBA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzUM8Lfh6y4WtEni/RPL/24L3gGJaF5SxIW1MSPb7Wz8c5aBnGA
	dpzu3ajSAKfPHsfutCL6BDudrOBPiWyD/W/2ntxW3/sgwwT/AmAaYQf68U5SkAiU3D9I2cxYnWx
	TmGcanDNJ9tjpKVghn1/w1Zt5iMg=
X-Google-Smtp-Source: AGHT+IGJeeAdGIP87cC95cStz9qeE3dupp7klnnAVTcjKHX6vpKBoLiUQEfoXRFEvhZrgtMMb6LXot438NCltsrGMdk=
X-Received: by 2002:a05:690c:60c7:b0:6dd:d407:4568 with SMTP id
 00721157ae682-6e24dc611f1mr87383497b3.26.1727782951444; Tue, 01 Oct 2024
 04:42:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926034802.28294-1-shayne.chen@mediatek.com>
In-Reply-To: <20240926034802.28294-1-shayne.chen@mediatek.com>
From: Josh Boyer <jwboyer@kernel.org>
Date: Tue, 1 Oct 2024 07:42:20 -0400
X-Gmail-Original-Message-ID: <CA+5PVA7EvtafLhceuZoXzb9n57of0q4gz5khgKA7JWjOWFzPCg@mail.gmail.com>
Message-ID: <CA+5PVA7EvtafLhceuZoXzb9n57of0q4gz5khgKA7JWjOWFzPCg@mail.gmail.com>
Subject: Re: [PULL,linux-firmware] mt76 firmware 20240926
To: Shayne Chen <shayne.chen@mediatek.com>
Cc: linux-firmware <linux-firmware@kernel.org>, Felix Fietkau <nbd@nbd.name>, 
	Evelyn Tsai <evelyn.tsai@mediatek.com>, linux-wireless <linux-wireless@vger.kernel.org>, 
	linux-mediatek <linux-mediatek@lists.infradead.org>, Daniel Golle <daniel@makrotopia.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 11:48=E2=80=AFPM Shayne Chen <shayne.chen@mediatek.=
com> wrote:
>
> Hi,
>
> Here's a pull request for adding WiFi firmware files for mt7996 and
> mt7992 chipset variants.
>
> Please let me know if there are any problems.
>
> Shayne
>
> The following changes since commit 8306534b8a7265bee2f4323b45fd2a22a7c8b9=
b6:
>
>   Merge branch '8922a' into 'main' (2024-09-23 12:36:21 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/csyuanc/linux-firmware.git mt76-20240926

Merged and pushed out.

https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/306

josh

>
> for you to fetch changes up to 85ce6f7afdd3b63398990e53f67c653fc66ad271:
>
>   mt76: mt7996: add firmware files for mt7992 chipset (2024-09-26 00:59:5=
4 +0800)
>
> ----------------------------------------------------------------
> Shayne Chen (2):
>       mt76: mt7996: add firmware files for mt7996 chipset variants
>       mt76: mt7996: add firmware files for mt7992 chipset
>
>  WHENCE                                       |  43 +++++++++++++++++++++=
+++++++++++++++++++++-
>  mediatek/mt7996/mt7992_dsp.bin               | Bin 0 -> 63536 bytes
>  mediatek/mt7996/mt7992_dsp_23.bin            | Bin 0 -> 63536 bytes
>  mediatek/mt7996/mt7992_eeprom.bin            | Bin 0 -> 7680 bytes
>  mediatek/mt7996/mt7992_eeprom_23.bin         | Bin 0 -> 7680 bytes
>  mediatek/mt7996/mt7992_eeprom_23_2i5i.bin    | Bin 0 -> 7680 bytes
>  mediatek/mt7996/mt7992_eeprom_2i5e.bin       | Bin 0 -> 7680 bytes
>  mediatek/mt7996/mt7992_eeprom_2i5i.bin       | Bin 0 -> 7680 bytes
>  mediatek/mt7996/mt7992_rom_patch.bin         | Bin 0 -> 20640 bytes
>  mediatek/mt7996/mt7992_rom_patch_23.bin      | Bin 0 -> 20640 bytes
>  mediatek/mt7996/mt7992_wa.bin                | Bin 0 -> 536240 bytes
>  mediatek/mt7996/mt7992_wa_23.bin             | Bin 0 -> 536240 bytes
>  mediatek/mt7996/mt7992_wm.bin                | Bin 0 -> 1712336 bytes
>  mediatek/mt7996/mt7992_wm_23.bin             | Bin 0 -> 1672256 bytes
>  mediatek/mt7996/mt7996_eeprom_233.bin        | Bin 0 -> 7680 bytes
>  mediatek/mt7996/mt7996_eeprom_233_2i5i6i.bin | Bin 0 -> 7680 bytes
>  mediatek/mt7996/mt7996_eeprom_2i5i6i.bin     | Bin 0 -> 7680 bytes
>  mediatek/mt7996/mt7996_rom_patch_233.bin     | Bin 0 -> 23968 bytes
>  mediatek/mt7996/mt7996_wa_233.bin            | Bin 0 -> 516272 bytes
>  mediatek/mt7996/mt7996_wm_233.bin            | Bin 0 -> 2620960 bytes
>  20 files changed, 42 insertions(+), 1 deletion(-)
>  create mode 100644 mediatek/mt7996/mt7992_dsp.bin
>  create mode 100644 mediatek/mt7996/mt7992_dsp_23.bin
>  create mode 100644 mediatek/mt7996/mt7992_eeprom.bin
>  create mode 100644 mediatek/mt7996/mt7992_eeprom_23.bin
>  create mode 100644 mediatek/mt7996/mt7992_eeprom_23_2i5i.bin
>  create mode 100644 mediatek/mt7996/mt7992_eeprom_2i5e.bin
>  create mode 100644 mediatek/mt7996/mt7992_eeprom_2i5i.bin
>  create mode 100644 mediatek/mt7996/mt7992_rom_patch.bin
>  create mode 100644 mediatek/mt7996/mt7992_rom_patch_23.bin
>  create mode 100644 mediatek/mt7996/mt7992_wa.bin
>  create mode 100644 mediatek/mt7996/mt7992_wa_23.bin
>  create mode 100644 mediatek/mt7996/mt7992_wm.bin
>  create mode 100644 mediatek/mt7996/mt7992_wm_23.bin
>  create mode 100644 mediatek/mt7996/mt7996_eeprom_233.bin
>  create mode 100644 mediatek/mt7996/mt7996_eeprom_233_2i5i6i.bin
>  create mode 100644 mediatek/mt7996/mt7996_eeprom_2i5i6i.bin
>  create mode 100644 mediatek/mt7996/mt7996_rom_patch_233.bin
>  create mode 100644 mediatek/mt7996/mt7996_wa_233.bin
>  create mode 100644 mediatek/mt7996/mt7996_wm_233.bin

