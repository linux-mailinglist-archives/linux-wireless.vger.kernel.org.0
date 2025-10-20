Return-Path: <linux-wireless+bounces-28116-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5C5BF3BF9
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Oct 2025 23:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E32C9351C69
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Oct 2025 21:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFBE30506E;
	Mon, 20 Oct 2025 21:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+OO9ICo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C78334C17
	for <linux-wireless@vger.kernel.org>; Mon, 20 Oct 2025 21:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760995648; cv=none; b=KPt5kUeV/XIALdoOWEYbDGCo31JJbLr9buZ3VxFXSSg9n1hmKpBZ7HhCrTq0M/uay9+IdWXX+om2L/rgkKhmKC0geBFG32mzJTdI0BSIH1Y+/yy/oAvEjhZfa8UkJzSi+5zwmyUN57OncoYZq6s49O3IgONS01Tj6K+7ugy3lKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760995648; c=relaxed/simple;
	bh=U38BcMKGdvW5NErKkLzlCBerNZPRipuaazE3WhsvNz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ccjWljE+Mh3Obujc5cugE0yjTT5ZRq9LRuKK2ixFNi3LB6FdP1JkykAE6ogLXbKFLBpcT3nVXktXQsfPRbs39Mb9uZY98Keop3MnLECssya0xQx4IuHnFGrLTuLw5r5UpK+cXIvClLYv85+uVI+BEPjJFlUYNKmv9yl9eRD1K+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c+OO9ICo; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b3d50882cc2so920282766b.2
        for <linux-wireless@vger.kernel.org>; Mon, 20 Oct 2025 14:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760995644; x=1761600444; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/kbCS9wiESb1uWqxH5eCNJAW6LbwQTgu2NCgGdWG2Hw=;
        b=c+OO9ICoVxP4itvStpSm4IDk9ZXnGgJU16geAl5624N79u5QrP7EHFLKcHPQg3noD0
         sPOwa4WlA18rzOC1NatRY53K04rQO1SUlA+k4tqjoHqmuJeaXAnAmuef/yUWbmKHUsS9
         i5DQKwt+OERH/UYBmo9ocHCvPR2Csk98GSofmREqXw1gWXJoHAR5V2RgET9EGIT9dcX0
         raxRCLnXdr26uBRYs7+IfQ/yVRzvVRqSlsvZUNhetl7tzkXDeP7Th2D6yaVxYo4dAk5P
         vxN88lCsAjcL9u3WGNIm0cada+7mhFg2t+EBjEiR0eBgEjoIjOElOz0+mf8yEez+M88y
         AM0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760995644; x=1761600444;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/kbCS9wiESb1uWqxH5eCNJAW6LbwQTgu2NCgGdWG2Hw=;
        b=vIUEm91qaRELHPQcGLZRJhHmesZWNBwSbtuHbVJy/yuH/qDUFj7Ig8MwtGCqRmx2EF
         A0uQEbBmpsY+ldfAjIr9JzvDcL8KsKZ4Pidmz8KJEXzfvFipI8dYrcP8hUlSf5N5fGKN
         CG/C8UgNwQ7udwfN9JFz4dfucIFl2XvDFpwnxvTrABt11CfwKQXu26OLRsQKsk6PLlGY
         uf0gLpXhWOr/dcfjPlyyB/GvbCIHpW1a/2t1tO11vXoSMrhgzRztuplQE0jUugPJ8u7K
         3jv56bQp0BYUQCt4QmqWWm002XJ6Qf61QSoFSndlVVOE2jlSl0jNyPGGf8w7LD5kejFY
         noWQ==
X-Gm-Message-State: AOJu0YwvgTte/nJHjHQcnIQ/AOj4R7s7IZEO0E8TJnPbKMg9nLSjzcfQ
	USLE/KDi+tHbv7XejuFwpft5S0xrLTZkk+RVr4G0CcTVpTOTABKUh0qd
X-Gm-Gg: ASbGnctHs+5C0zMNJMYNis9W4w1ebaJcCEYcAVwdnTpgYUY/AqGQkFoaZY4CnpaFAKY
	9swUaIu9uU6xaZhXi5l9dtoerPRLtDp1XRy8j6ua/BA7ZJOhjyaJr/mUTqRIRFnsVVfvt6Hhplc
	Vo/9H18nexN8grI3mCGSDV+jX4kwBxUKTkZdLWIr3h6VPDz0pjzbLPguqai+3+17Lajn5FMARni
	0In8Hbg+nrczpYL/D7px3AF+71SG8HeTh4G/rdxKG6v3k1bCBEzjBIHZbMGSLqcHdf1kcUQahOp
	8rfDcbbfXK5+aAMTw0HVOMjZ7GITq0Pbq2b3IM7T4eC+G1T6ETAONi+0maO17X1tULqNDC6dYEz
	xXUcz0FEUMHS6djnORAkIR2JT/tlYnV/QAIp3ooc3A5dzrtizVVcSX7U0VEU/2tCGdBzPfSeMc+
	PSmQKAmCTDnJwvtxpnCAs=
X-Google-Smtp-Source: AGHT+IHh8o3UrZL/g02zWsf3+m7Hfwoh/I+h73zVuyKsvu31+cueZtItlmsT2zMgORyvmkAbReInVQ==
X-Received: by 2002:a17:907:bb49:b0:b04:9ad9:5b29 with SMTP id a640c23a62f3a-b6474241271mr1870656166b.54.1760995643508;
        Mon, 20 Oct 2025 14:27:23 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.71])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65eb526490sm889230666b.65.2025.10.20.14.27.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 14:27:23 -0700 (PDT)
Message-ID: <0d807f54-7579-43a2-99c7-2a19cf715ec3@gmail.com>
Date: Tue, 21 Oct 2025 00:27:21 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 6.14] wireless: aic8800: add support for AIC8800 WiFi
 chipset
To: "he.zhenang" <he.zhenang@bedmex.com>, johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org
References: <20251020092144.25259-1-he.zhenang@bedmex.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <20251020092144.25259-1-he.zhenang@bedmex.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/10/2025 12:21, he.zhenang wrote:
> Add driver support for the AIC8800 WiFi chipset family.
> 
> Driver features:
> - Supports 802.11ax (Wi-Fi 6) and backward compatible modes
> - PCIe/USB/SDIO interface support
> - Hardware encryption offload (WPA3 support)
> - Enhanced power management for mobile devices
> - Integrated Bluetooth coexistence (if applicable)
> 
> Signed-off-by: he.zhenang <he.zhenang@bedmex.com>

I have two USB adapters from Brostrend with AIC chips. It's
nice to see someone try to add support. However, there are some
problems with this patch.

1) Where did the source code come from? The driver provided by
Brostrend doesn't have any license information in it. Only the
files aic_br_ext.{c,h} have a license header, and that's because
they were copied from a Realtek driver. Presumably Brostrend got
the code from AIC. So then I wonder who added the license headers
we can see in this patch, and did AIC agree to that? They did
write MODULE_LICENSE("GPL"); but is that enough? Also, a good
chunk of the code published by Brostrend is actually Copyright
(C) RivieraWaves, not AIC.

https://linux.brostrend.com/aic8800-dkms.deb

2) Who will maintain this new driver?

3) AIC has several chips. Which ones did you test?

> ---
>  .../bindings/serial/aic,aic-bt.yaml           |    45 +
>  .../bindings/serial/aic,btlpm-wake-host.yaml  |    37 +
>  .../devicetree/bindings/vendor-prefixes.yaml  |     2 +
>  drivers/net/wireless/Kconfig                  |     1 +
>  drivers/net/wireless/Makefile                 |     1 +
>  drivers/net/wireless/aic/Kconfig              |    17 +
>  drivers/net/wireless/aic/Makefile             |     7 +
>  drivers/net/wireless/aic/aic8800/.gitignore   |     5 +
>  drivers/net/wireless/aic/aic8800/Kconfig      |   176 +
>  drivers/net/wireless/aic/aic8800/Makefile     |    69 +
>  .../aic/aic8800/aic8800_bsp/.gitignore        |    10 +
>  .../wireless/aic/aic8800/aic8800_bsp/Kconfig  |    65 +
>  .../wireless/aic/aic8800/aic8800_bsp/Makefile |    16 +
>  .../aic8800/aic8800_bsp/aic8800d80_compat.c   |   290 +
>  .../aic8800/aic8800_bsp/aic8800d80_compat.h   |    11 +
>  .../aic8800/aic8800_bsp/aic8800dc_compat.c    |  1241 +
>  .../aic8800/aic8800_bsp/aic8800dc_compat.h    |    39 +
>  .../aic/aic8800/aic8800_bsp/aic_bsp_driver.c  |  2123 ++
>  .../aic/aic8800/aic8800_bsp/aic_bsp_driver.h  |   617 +
>  .../aic/aic8800/aic8800_bsp/aic_bsp_export.h  |    70 +
>  .../aic/aic8800/aic8800_bsp/aic_bsp_main.c    |   496 +
>  .../aic/aic8800/aic8800_bsp/aicsdio.c         |  1985 ++
>  .../aic/aic8800/aic8800_bsp/aicsdio.h         |   165 +
>  .../aic/aic8800/aic8800_bsp/aicsdio_txrxif.c  |   470 +
>  .../aic/aic8800/aic8800_bsp/aicsdio_txrxif.h  |   224 +
>  .../aic8800_bsp/aicwf_firmware_array.c        | 26874 ++++++++++++++++
>  .../aic8800_bsp/aicwf_firmware_array.h        |     2 +
>  .../aic8800/aic8800_bsp/aicwf_txq_prealloc.c  |    66 +
>  .../aic8800/aic8800_bsp/aicwf_txq_prealloc.h  |     8 +
>  .../wireless/aic/aic8800/aic8800_bsp/md5.c    |   165 +
>  .../wireless/aic/aic8800/aic8800_bsp/md5.h    |    77 +
>  .../aic8800/aic8800_bsp/rwnx_version_gen.h    |     5 +
>  .../aic/aic8800/aic8800_btlpm/.gitignore      |    10 +
>  .../aic/aic8800/aic8800_btlpm/Kconfig         |    12 +
>  .../aic/aic8800/aic8800_btlpm/Makefile        |     5 +
>  .../aic/aic8800/aic8800_btlpm/aic8800_btlpm.c |   936 +
>  .../aic/aic8800/aic8800_fdrv/.gitignore       |    10 +
>  .../wireless/aic/aic8800/aic8800_fdrv/Kconfig |   404 +
>  .../aic/aic8800/aic8800_fdrv/Makefile         |   137 +
>  .../aic/aic8800/aic8800_fdrv/aic_br_ext.c     |  1598 +
>  .../aic/aic8800/aic8800_fdrv/aic_br_ext.h     |    69 +
>  .../aic/aic8800/aic8800_fdrv/aic_bsp_export.h |    63 +
>  .../aic/aic8800/aic8800_fdrv/aic_btsdio.c     |  1164 +
>  .../aic/aic8800/aic8800_fdrv/aic_btsdio.h     |   472 +
>  .../aic/aic8800/aic8800_fdrv/aic_priv_cmd.c   |  2314 ++
>  .../aic/aic8800/aic8800_fdrv/aic_priv_cmd.h   |   124 +
>  .../aic/aic8800/aic8800_fdrv/aic_vendor.c     |   948 +
>  .../aic/aic8800/aic8800_fdrv/aic_vendor.h     |   370 +
>  .../aic8800_fdrv/aicwf_compat_8800d80.c       |    98 +
>  .../aic8800_fdrv/aicwf_compat_8800d80.h       |    16 +
>  .../aic8800_fdrv/aicwf_compat_8800dc.c        |   505 +
>  .../aic8800_fdrv/aicwf_compat_8800dc.h        |    17 +
>  .../aic/aic8800/aic8800_fdrv/aicwf_debug.h    |    33 +
>  .../aic/aic8800/aic8800_fdrv/aicwf_genl.c     |   819 +
>  .../aic/aic8800/aic8800_fdrv/aicwf_genl.h     |   115 +
>  .../aic8800/aic8800_fdrv/aicwf_rx_prealloc.c  |   102 +
>  .../aic8800/aic8800_fdrv/aicwf_rx_prealloc.h  |    32 +
>  .../aic/aic8800/aic8800_fdrv/aicwf_sdio.c     |  2728 ++
>  .../aic/aic8800/aic8800_fdrv/aicwf_sdio.h     |   264 +
>  .../aic/aic8800/aic8800_fdrv/aicwf_tcp_ack.c  |   568 +
>  .../aic/aic8800/aic8800_fdrv/aicwf_tcp_ack.h  |   104 +
>  .../aic/aic8800/aic8800_fdrv/aicwf_txrxif.c   |   864 +
>  .../aic/aic8800/aic8800_fdrv/aicwf_txrxif.h   |   265 +
>  .../aic/aic8800/aic8800_fdrv/aicwf_usb.c      |   954 +
>  .../aic/aic8800/aic8800_fdrv/aicwf_usb.h      |    92 +
>  .../aic8800/aic8800_fdrv/aicwf_wext_linux.c   |  1138 +
>  .../aic8800/aic8800_fdrv/aicwf_wext_linux.h   |    13 +
>  .../aic/aic8800/aic8800_fdrv/hal_desc.h       |   362 +
>  .../aic/aic8800/aic8800_fdrv/ipc_compat.h     |    25 +
>  .../aic/aic8800/aic8800_fdrv/ipc_host.c       |    42 +
>  .../aic/aic8800/aic8800_fdrv/ipc_host.h       |   169 +
>  .../aic/aic8800/aic8800_fdrv/ipc_shared.h     |   781 +
>  .../aic/aic8800/aic8800_fdrv/lmac_mac.h       |   470 +
>  .../aic/aic8800/aic8800_fdrv/lmac_msg.h       |  3150 ++
>  .../aic/aic8800/aic8800_fdrv/lmac_types.h     |    37 +
>  .../wireless/aic/aic8800/aic8800_fdrv/md5.c   |   175 +
>  .../wireless/aic/aic8800/aic8800_fdrv/md5.h   |    82 +
>  .../aic/aic8800/aic8800_fdrv/reg_access.h     |   146 +
>  .../wireless/aic/aic8800/aic8800_fdrv/regdb.c |  2770 ++
>  .../aic/aic8800/aic8800_fdrv/rwnx_bfmer.c     |    93 +
>  .../aic/aic8800/aic8800_fdrv/rwnx_bfmer.h     |   100 +
>  .../aic/aic8800/aic8800_fdrv/rwnx_cfgfile.c   |   264 +
>  .../aic/aic8800/aic8800_fdrv/rwnx_cfgfile.h   |    33 +
>  .../aic/aic8800/aic8800_fdrv/rwnx_cmds.c      |   506 +
>  .../aic/aic8800/aic8800_fdrv/rwnx_cmds.h      |   123 +
>  .../aic/aic8800/aic8800_fdrv/rwnx_compat.h    |    93 +
>  .../aic/aic8800/aic8800_fdrv/rwnx_debugfs.c   |  2585 ++
>  .../aic/aic8800/aic8800_fdrv/rwnx_debugfs.h   |   136 +
>  .../aic/aic8800/aic8800_fdrv/rwnx_defs.h      |   760 +
>  .../aic/aic8800/aic8800_fdrv/rwnx_dini.c      |   292 +
>  .../aic/aic8800/aic8800_fdrv/rwnx_dini.h      |    14 +
>  .../aic/aic8800/aic8800_fdrv/rwnx_events.h    |   936 +
>  .../aic/aic8800/aic8800_fdrv/rwnx_fw_trace.c  |    50 +
>  .../aic/aic8800/aic8800_fdrv/rwnx_fw_trace.h  |    28 +
>  .../aic/aic8800/aic8800_fdrv/rwnx_gki.c       |   406 +
>  .../aic/aic8800/aic8800_fdrv/rwnx_gki.h       |    47 +
>  .../aic/aic8800/aic8800_fdrv/rwnx_irqs.c      |    44 +
>  .../aic/aic8800/aic8800_fdrv/rwnx_irqs.h      |    12 +
>  .../aic/aic8800/aic8800_fdrv/rwnx_main.c      |  5545 ++++
>  .../aic/aic8800/aic8800_fdrv/rwnx_main.h      |    37 +
>  .../aic/aic8800/aic8800_fdrv/rwnx_mesh.c      |    33 +
>  .../aic/aic8800/aic8800_fdrv/rwnx_mesh.h      |    35 +
>  .../aic8800/aic8800_fdrv/rwnx_mod_params.c    |  1282 +
>  .../aic8800/aic8800_fdrv/rwnx_mod_params.h    |    70 +
>  .../aic/aic8800/aic8800_fdrv/rwnx_msg_rx.c    |  1772 +
>  .../aic/aic8800/aic8800_fdrv/rwnx_msg_rx.h    |    14 +
>  .../aic/aic8800/aic8800_fdrv/rwnx_msg_tx.c    |  3861 +++
>  .../aic/aic8800/aic8800_fdrv/rwnx_msg_tx.h    |   286 +
>  .../aic/aic8800/aic8800_fdrv/rwnx_mu_group.c  |   646 +
>  .../aic/aic8800/aic8800_fdrv/rwnx_mu_group.h  |   159 +
>  .../aic/aic8800/aic8800_fdrv/rwnx_pci.c       |    94 +
>  .../aic/aic8800/aic8800_fdrv/rwnx_pci.h       |     8 +
>  .../aic/aic8800/aic8800_fdrv/rwnx_platform.c  |  3211 ++
>  .../aic/aic8800/aic8800_fdrv/rwnx_platform.h  |   185 +
>  .../aic/aic8800/aic8800_fdrv/rwnx_prof.h      |   142 +
>  .../aic/aic8800/aic8800_fdrv/rwnx_radar.c     |  1965 ++
>  .../aic/aic8800/aic8800_fdrv/rwnx_radar.h     |   278 +
>  .../aic/aic8800/aic8800_fdrv/rwnx_rx.c        |  2447 ++
>  .../aic/aic8800/aic8800_fdrv/rwnx_rx.h        |   358 +
>  .../aic/aic8800/aic8800_fdrv/rwnx_strs.c      |   268 +
>  .../aic/aic8800/aic8800_fdrv/rwnx_strs.h      |    37 +
>  .../aic/aic8800/aic8800_fdrv/rwnx_tdls.c      |   776 +
>  .../aic/aic8800/aic8800_fdrv/rwnx_tdls.h      |    57 +
>  .../aic/aic8800/aic8800_fdrv/rwnx_testmode.c  |   218 +
>  .../aic/aic8800/aic8800_fdrv/rwnx_testmode.h  |    68 +
>  .../aic/aic8800/aic8800_fdrv/rwnx_tx.c        |  1855 ++
>  .../aic/aic8800/aic8800_fdrv/rwnx_tx.h        |   193 +
>  .../aic/aic8800/aic8800_fdrv/rwnx_txq.c       |  1403 +
>  .../aic/aic8800/aic8800_fdrv/rwnx_txq.h       |   372 +
>  .../aic/aic8800/aic8800_fdrv/rwnx_utils.c     |    38 +
>  .../aic/aic8800/aic8800_fdrv/rwnx_utils.h     |   137 +
>  .../aic/aic8800/aic8800_fdrv/rwnx_v7.c        |   182 +
>  .../aic/aic8800/aic8800_fdrv/rwnx_v7.h        |    21 +
>  .../aic/aic8800/aic8800_fdrv/rwnx_version.h   |    14 +
>  .../aic8800/aic8800_fdrv/rwnx_version_gen.h   |     5 +
>  .../aic/aic8800/aic8800_fdrv/rwnx_wakelock.c  |   111 +
>  .../aic/aic8800/aic8800_fdrv/rwnx_wakelock.h  |    24 +
>  .../aic/aic8800/aic8800_fdrv/sdio_host.c      |   132 +
>  .../aic/aic8800/aic8800_fdrv/sdio_host.h      |    39 +
>  .../aic/aic8800/aic8800_fdrv/usb_host.c       |   129 +
>  .../aic/aic8800/aic8800_fdrv/usb_host.h       |    36 +
>  .../wireless/aic/aic8800/hci_aic/.gitignore   |    10 +
>  .../net/wireless/aic/aic8800/hci_aic/Kconfig  |    12 +
>  .../net/wireless/aic/aic8800/hci_aic/Makefile |    36 +
>  .../net/wireless/aic/aic8800/hci_aic/Readme   |    28 +
>  .../net/wireless/aic/aic8800/hci_aic/btaic.h  |    93 +
>  .../aic/aic8800/hci_aic/hci_aic_uart.c        |  1184 +
>  .../net/wireless/aic/aic8800/hci_aic/hci_h4.c |   266 +
>  .../wireless/aic/aic8800/hci_aic/hci_ldisc.c  |   846 +
>  .../wireless/aic/aic8800/hci_aic/hci_serdev.c |   391 +
>  .../wireless/aic/aic8800/hci_aic/hci_uart.h   |   147 +
>  151 files changed, 99029 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/aic,aic-bt.yaml
>  create mode 100644 Documentation/devicetree/bindings/serial/aic,btlpm-wake-host.yaml
>  create mode 100644 drivers/net/wireless/aic/Kconfig
>  create mode 100644 drivers/net/wireless/aic/Makefile
>  create mode 100644 drivers/net/wireless/aic/aic8800/.gitignore
>  create mode 100644 drivers/net/wireless/aic/aic8800/Kconfig
>  create mode 100644 drivers/net/wireless/aic/aic8800/Makefile
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_bsp/.gitignore
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_bsp/Kconfig
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_bsp/Makefile
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_bsp/aic8800d80_compat.c
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_bsp/aic8800d80_compat.h
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_bsp/aic8800dc_compat.c
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_bsp/aic8800dc_compat.h
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_bsp/aic_bsp_driver.c
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_bsp/aic_bsp_driver.h
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_bsp/aic_bsp_export.h
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_bsp/aic_bsp_main.c
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_bsp/aicsdio.c
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_bsp/aicsdio.h
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_bsp/aicsdio_txrxif.c
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_bsp/aicsdio_txrxif.h
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_bsp/aicwf_firmware_array.c
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_bsp/aicwf_firmware_array.h
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_bsp/aicwf_txq_prealloc.c
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_bsp/aicwf_txq_prealloc.h
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_bsp/md5.c
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_bsp/md5.h
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_bsp/rwnx_version_gen.h
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_btlpm/.gitignore
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_btlpm/Kconfig
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_btlpm/Makefile
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_btlpm/aic8800_btlpm.c
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/.gitignore
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/Kconfig
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/Makefile
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/aic_br_ext.c
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/aic_br_ext.h
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/aic_bsp_export.h
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/aic_btsdio.c
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/aic_btsdio.h
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/aic_priv_cmd.c
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/aic_priv_cmd.h
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/aic_vendor.c
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/aic_vendor.h
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/aicwf_compat_8800d80.c
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/aicwf_compat_8800d80.h
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/aicwf_compat_8800dc.c
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/aicwf_compat_8800dc.h
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/aicwf_debug.h
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/aicwf_genl.c
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/aicwf_genl.h
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/aicwf_rx_prealloc.c
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/aicwf_rx_prealloc.h
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/aicwf_sdio.c
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/aicwf_sdio.h
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/aicwf_tcp_ack.c
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/aicwf_tcp_ack.h
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/aicwf_txrxif.c
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/aicwf_txrxif.h
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/aicwf_usb.c
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/aicwf_usb.h
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/aicwf_wext_linux.c
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/aicwf_wext_linux.h
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/hal_desc.h
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/ipc_compat.h
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/ipc_host.c
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/ipc_host.h
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/ipc_shared.h
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/lmac_mac.h
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/lmac_msg.h
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/lmac_types.h
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/md5.c
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/md5.h
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/reg_access.h
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/regdb.c
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/rwnx_bfmer.c
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/rwnx_bfmer.h
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/rwnx_cfgfile.c
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/rwnx_cfgfile.h
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/rwnx_cmds.c
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/rwnx_cmds.h
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/rwnx_compat.h
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/rwnx_debugfs.c
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/rwnx_debugfs.h
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/rwnx_defs.h
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/rwnx_dini.c
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/rwnx_dini.h
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/rwnx_events.h
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/rwnx_fw_trace.c
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/rwnx_fw_trace.h
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/rwnx_gki.c
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/rwnx_gki.h
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/rwnx_irqs.c
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/rwnx_irqs.h
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/rwnx_main.c
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/rwnx_main.h
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/rwnx_mesh.c
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/rwnx_mesh.h
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/rwnx_mod_params.c
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/rwnx_mod_params.h
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/rwnx_msg_rx.c
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/rwnx_msg_rx.h
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/rwnx_msg_tx.c
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/rwnx_msg_tx.h
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/rwnx_mu_group.c
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/rwnx_mu_group.h
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/rwnx_pci.c
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/rwnx_pci.h
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/rwnx_platform.c
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/rwnx_platform.h
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/rwnx_prof.h
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/rwnx_radar.c
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/rwnx_radar.h
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/rwnx_rx.c
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/rwnx_rx.h
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/rwnx_strs.c
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/rwnx_strs.h
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/rwnx_tdls.c
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/rwnx_tdls.h
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/rwnx_testmode.c
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/rwnx_testmode.h
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/rwnx_tx.c
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/rwnx_tx.h
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/rwnx_txq.c
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/rwnx_txq.h
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/rwnx_utils.c
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/rwnx_utils.h
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/rwnx_v7.c
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/rwnx_v7.h
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/rwnx_version.h
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/rwnx_version_gen.h
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/rwnx_wakelock.c
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/rwnx_wakelock.h
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/sdio_host.c
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/sdio_host.h
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/usb_host.c
>  create mode 100644 drivers/net/wireless/aic/aic8800/aic8800_fdrv/usb_host.h
>  create mode 100644 drivers/net/wireless/aic/aic8800/hci_aic/.gitignore
>  create mode 100644 drivers/net/wireless/aic/aic8800/hci_aic/Kconfig
>  create mode 100644 drivers/net/wireless/aic/aic8800/hci_aic/Makefile
>  create mode 100644 drivers/net/wireless/aic/aic8800/hci_aic/Readme
>  create mode 100644 drivers/net/wireless/aic/aic8800/hci_aic/btaic.h
>  create mode 100644 drivers/net/wireless/aic/aic8800/hci_aic/hci_aic_uart.c
>  create mode 100644 drivers/net/wireless/aic/aic8800/hci_aic/hci_h4.c
>  create mode 100644 drivers/net/wireless/aic/aic8800/hci_aic/hci_ldisc.c
>  create mode 100644 drivers/net/wireless/aic/aic8800/hci_aic/hci_serdev.c
>  create mode 100644 drivers/net/wireless/aic/aic8800/hci_aic/hci_uart.h
> 

