Return-Path: <linux-wireless+bounces-29056-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CDBC659C3
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Nov 2025 18:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 89C19367ED8
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Nov 2025 17:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AAE30BB89;
	Mon, 17 Nov 2025 17:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAO/hN8D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB67E30AD0D
	for <linux-wireless@vger.kernel.org>; Mon, 17 Nov 2025 17:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763401282; cv=none; b=JgH5OsuYkzFMlJ3bKrq1UKUQLWJ0gVdV2wuUBA+r73F4mCY0B8rsNqeMfnjBmdKUF/LwzTLyUZNvsyhXbLLZtAG6DnQAo2cy+ztnMh+v1gBAU7bYKqWGXZwnWJdWUqQDZdYnKs6qsjZp90v3WeYkY713SdJHLJVWzksKXm9V084=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763401282; c=relaxed/simple;
	bh=A4F5PJLasrrm16tZ8Vvy+5mmSuMc9DptCJKcLbMf4yc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M0mi8oH0V3yhfJk6qD/yxykv7BF4Ax8AdpiSspTibT4gMpbu+w3Zg8WqllcPvbI3V6GWXrErPb65KwTeRuwwZtKgiVRnqrgRnrmsDrqtFk3tImWceL9NWrIAaLq3tsmi3/yBzuhKru1e6loTYIf6/XIuM2OEl9vD/+F/5QejxUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HAO/hN8D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 161A2C4AF10
	for <linux-wireless@vger.kernel.org>; Mon, 17 Nov 2025 17:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763401281;
	bh=A4F5PJLasrrm16tZ8Vvy+5mmSuMc9DptCJKcLbMf4yc=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:Cc:From;
	b=HAO/hN8Db9cnUBrPcLMVYoiifVsxB3HsFQuh93s87O8j1MRe8mavlmUumNpth9BLS
	 AonAbsmM7VO+QeezfqCQ8Lx19fxpBlTYlc8SQYk6vNO1xy0P8w9QAmqADXKeERTfTA
	 WLK9gk/kJQZmq6HWPs3eLZforM1SB8DbK+Omal+0RjVxPITKfP6F0sSyie6IQvcLBv
	 NVaBCCdapTZb94IvWUX79q1GzzOgiBnctP56s7QUVLTU5ZijbWGuLcIFRuojkUDJ0r
	 LNEqY5dm0oVBpZkffgmS0AaDjvouWBODiSISw5YpbIB/hgG6Mmrj3xhXmXjB68KpTZ
	 M1p+h7CcnQlVA==
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7866aca9ff4so45691907b3.3
        for <linux-wireless@vger.kernel.org>; Mon, 17 Nov 2025 09:41:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWkN3RXyVKT1btsYdecwZqO96bjDzoTWRKOz3cPZCU7mll5lU1DRRIWeIDOpKFoFjjhsJehOK8KhOhmyOibPg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7YGV2cH19RJSCMVISCwdS/X2BpbWI1imAfamQI/faaAy1ouU9
	5E8D3+uTjFKQDfPTRIN7T6BngK8Vji6CFWZvH33bqhaO1j01x2SZtRMQJoPADVTOwadf5yhWKmc
	+Ezu7ZA8rZ6GOal3LlcxHTUsIf+Yz33c=
X-Google-Smtp-Source: AGHT+IERFGmwZzvgfmQpsekA5ySepC5cWhE1RdcPAgMU6moeZ0oLlNfQdW91BxLVB/lGep7xzrsdF3YlTmu3LcwSYnc=
X-Received: by 2002:a05:690e:23c5:b0:63d:5d72:1918 with SMTP id
 956f58d0204a3-641e76adb35mr8370590d50.63.1763401279225; Mon, 17 Nov 2025
 09:41:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117144130.2214135-1-shayne.chen@mediatek.com>
In-Reply-To: <20251117144130.2214135-1-shayne.chen@mediatek.com>
From: Josh Boyer <jwboyer@kernel.org>
Date: Mon, 17 Nov 2025 12:41:07 -0500
X-Gmail-Original-Message-ID: <CA+5PVA7fLSKqr4r5GC85B2oZpayTiTYu6jNpvX0zUUBT9G8wkA@mail.gmail.com>
X-Gm-Features: AWmQ_bkl7PWjM_nLGeo0QyKIbfhI2BF4jkkjBdQ6YO7jEboEjxVYNyjE4JJh-Lw
Message-ID: <CA+5PVA7fLSKqr4r5GC85B2oZpayTiTYu6jNpvX0zUUBT9G8wkA@mail.gmail.com>
Subject: Re: pull-request: mt76 firmware 20251117
To: Shayne Chen <shayne.chen@mediatek.com>
Cc: linux-firmware <linux-firmware@kernel.org>, Felix Fietkau <nbd@nbd.name>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Evelyn Tsai <evelyn.tsai@mediatek.com>, 
	linux-wireless <linux-wireless@vger.kernel.org>, 
	linux-mediatek <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 9:41=E2=80=AFAM Shayne Chen <shayne.chen@mediatek.c=
om> wrote:
>
> Hi,
>
> This contains the WiFi firmwares for MT7996, MT7992, and MT7990 chipsets.
>
> Please let me know if there's any problem.
>
> Thanks,
> Shayne
> ---
>
> The following changes since commit fb0dbcd3011839d85920d1e4aa956f6a84700c=
af:
>
>   Merge branch 'amd-ucode' into 'main' (2025-11-13 22:26:11 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/csyuanc/linux-firmware.git mt76-20251117

Merged and pushed out.

https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/784

josh

>
> for you to fetch changes up to 05895b31008ae27cc8a8f9a44e014f09595a736c:
>
>   mt76: add firmware for MT7990 (2025-11-17 22:08:46 +0800)
>
> ----------------------------------------------------------------
> Shayne Chen (3):
>       mt76: update firmware for MT7996
>       mt76: update firmware for MT7992
>       mt76: add firmware for MT7990
>
>  WHENCE                                   |  41 +++++++++++++++++++------=
------
>  mediatek/mt7996/mt7990_eeprom.bin        | Bin 0 -> 7680 bytes
>  mediatek/mt7996/mt7990_eeprom_2i5i.bin   | Bin 0 -> 7680 bytes
>  mediatek/mt7996/mt7990_rom_patch.bin     | Bin 0 -> 12832 bytes
>  mediatek/mt7996/mt7990_wm.bin            | Bin 0 -> 1336664 bytes
>  mediatek/mt7996/mt7992_dsp.bin           | Bin 63536 -> 63572 bytes
>  mediatek/mt7996/mt7992_dsp_23.bin        | Bin 63536 -> 63536 bytes
>  mediatek/mt7996/mt7992_rom_patch.bin     | Bin 20640 -> 20896 bytes
>  mediatek/mt7996/mt7992_rom_patch_23.bin  | Bin 20640 -> 20896 bytes
>  mediatek/mt7996/mt7992_wa.bin            | Bin 536240 -> 515184 bytes
>  mediatek/mt7996/mt7992_wa_23.bin         | Bin 536240 -> 515184 bytes
>  mediatek/mt7996/mt7992_wm.bin            | Bin 1712336 -> 1742052 bytes
>  mediatek/mt7996/mt7992_wm_23.bin         | Bin 1672256 -> 1701216 bytes
>  mediatek/mt7996/mt7996_dsp.bin           | Bin 191704 -> 191728 bytes
>  mediatek/mt7996/mt7996_rom_patch.bin     | Bin 23968 -> 37216 bytes
>  mediatek/mt7996/mt7996_rom_patch_233.bin | Bin 23968 -> 37216 bytes
>  mediatek/mt7996/mt7996_wa.bin            | Bin 516272 -> 509232 bytes
>  mediatek/mt7996/mt7996_wa_233.bin        | Bin 516272 -> 509232 bytes
>  mediatek/mt7996/mt7996_wm.bin            | Bin 2622816 -> 2655416 bytes
>  mediatek/mt7996/mt7996_wm_233.bin        | Bin 2620960 -> 2681656 bytes
>  20 files changed, 25 insertions(+), 16 deletions(-)
>  create mode 100644 mediatek/mt7996/mt7990_eeprom.bin
>  create mode 100644 mediatek/mt7996/mt7990_eeprom_2i5i.bin
>  create mode 100644 mediatek/mt7996/mt7990_rom_patch.bin
>  create mode 100644 mediatek/mt7996/mt7990_wm.bin

