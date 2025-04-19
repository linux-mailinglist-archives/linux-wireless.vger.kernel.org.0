Return-Path: <linux-wireless+bounces-21748-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 050E8A941EC
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Apr 2025 08:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83FA119E2A47
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Apr 2025 06:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E50F15B135;
	Sat, 19 Apr 2025 06:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Zw10cy70"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAD929D0B
	for <linux-wireless@vger.kernel.org>; Sat, 19 Apr 2025 06:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745042804; cv=none; b=CfD9UuK8TSycStSxrfGEJZaf/galOcLcQi59j5t2O03WNu3/BG0ZFb444Ca5IGI26ay2OaTc/JBZuwVGhfHLTK4+oTJRYKf0yB7XDcw2nsWQbjhD2HQzl5pNzSK0gMLBAWeBhRtvMj2wx/aqzlH7MP/fGj4aed5QYrpAodOsbQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745042804; c=relaxed/simple;
	bh=Tyh0dToRA4LXQ+7rErKSQD4NTqAXsx7LjjWIXmKSpcQ=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=EaTaaHR4e+k84FZBQFKndGvmM5yhL6dCUI675iPPdgIcXzNOPnXYidR2MNZr8FqKtPdVaJEU1IZObTl8T1/ngDUpvUbExC6J5IEmW3NCsMNkP/RqdHY5n55tlNTMmGy9rvFBT3JnS7jB81VQEQU877TW53cScUmZNCjW0lWUgyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Zw10cy70; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7300069c447so927619a34.2
        for <linux-wireless@vger.kernel.org>; Fri, 18 Apr 2025 23:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1745042801; x=1745647601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UMui0WVzyvwckCcYsYVmQtsamfg6AQcG6hkaFt/QLv8=;
        b=Zw10cy70tdLCtGPTzYmnA8OzoE8hjI+4CnuBPxGQr8wxP1Yf/D979yGk69dC9akBia
         Fhw2HhkYxptKPWuNogX8McJ1v2e/NiqJzXQoiWh0RFxrFdq+zyEAYyNR1xcgp5IdfC6w
         uzI3fsB1z69MjsICqvSZ+kmDeN169gyunP/Qo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745042801; x=1745647601;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UMui0WVzyvwckCcYsYVmQtsamfg6AQcG6hkaFt/QLv8=;
        b=QngE4R7qNgcwhCM0d/XEMuOoD2WavWSlE/phLD0PmXVOTkC429+cVo6a5A6fUTAeTf
         sKFLnDjRES9gSHnbNFlJHeNbeRbevvsZ5dASkTVQ+v7P6+Bn9Ou4wcZxPErkoYsGsALM
         sagBhnsBS7noGC7uWDaLGSI3vJTHPglMALnz6/cnxFWtNGNpStiRrW2AweUJhqreK1Yo
         Jwm1szGuwtSyxFmEe6OhGFDPQLBdc55tbu+VB0M0HrKGSQVKc3vTIhrakgPnszJ5nQvi
         cf9S7cWAmT7maSiYrZhUoya5OmXKttuP3lbNN7Dx7qxODuzDMC6TS61HxcSwLRf0KEAT
         sOlA==
X-Gm-Message-State: AOJu0YynVUrv70n7ia0OprX2W0bXtDNmGl7oSLZh8ZGP50JzgSMovFgY
	+GgNe0NP7NFumqpfhPR8cecONDhuC0UnxluEGltqRJN3dNCBh84gvab74TtSuQ==
X-Gm-Gg: ASbGncugR8itbCxhcyq1y4+x5unifErRK6BhTTlDwRfnKiGP0j8Dz3w5oQF2ggg2eA2
	DUIsZTnwjPAtzIgyBjXugVjSvKMyXCYJGfNpVb2DJKK1mJ4DJka/zFAxPugLpdqrmGhB/MffBh+
	XoSqIPGYKT1OQwDVKC/MlDhzhJd20vxXGGmMbQJBu4F17uLigmpnff0ATDAf2U11iI1QKfp9y0Z
	+r9XBaBpIBSCo8NdaCgTKhtav6RGbCuA2tb2xiAeg9MGlT8Vt/duLr38TfFcfupIp+MRwBAsfxO
	5Ye5mYd2iv/tBrVnwXlgvq2FGrjZ/f9HnZQuJcYbz3hYQJz2Md6oxVayT1BJcMuJ4cwnnDwrnQ4
	Vlb8=
X-Google-Smtp-Source: AGHT+IFlLEKvpLqnuHbDUzvn/PT9WKfv6eVYKzAsmWNCfAbMgloyVQnne0ZQOsSTM0cm9LoRSa6c2w==
X-Received: by 2002:a05:6830:7001:b0:72b:8000:d487 with SMTP id 46e09a7af769-730061f3b94mr2921182a34.3.1745042801368;
        Fri, 18 Apr 2025 23:06:41 -0700 (PDT)
Received: from [192.168.178.39] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7300478c51asm616461a34.8.2025.04.18.23.06.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Apr 2025 23:06:39 -0700 (PDT)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
CC: <linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>, <wlan-kernel-dev-list@infineon.com>
Date: Sat, 19 Apr 2025 08:06:36 +0200
Message-ID: <1964ca7ede0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <20250416060128.15703-1-gokulkumar.sivakumar@infineon.com>
References: <20250416060128.15703-1-gokulkumar.sivakumar@infineon.com>
User-Agent: AquaMail/1.54.1 (build: 105401536)
Subject: Re: [PATCH] brcmfmac: fix compilation error seen while building only brcmfmac sub-directory
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On April 16, 2025 8:01:58 AM Gokul Sivakumar 
<gokulkumar.sivakumar@infineon.com> wrote:

> The function prototypes of brcmf_debug_create_memdump(), 
> brcmf_debugfs_get_devdir()
> and brcmf_debugfs_add_entry() are protected by the "DEBUG" config MACRO in 
> debug.h,
> while the corresponding function definitions remains unprotected in 
> debug.c, so add
> the missing MACRO definition check.
>
> Compilation error seen while building brcmfmac sub-directory with 
> CONFIG_BRCMDBG=y
> is captured below.
>
> $ make M=drivers/net/wireless/broadcom/brcm80211/brcmfmac
>
> make[1]: Entering directory 
> '/root/wireless-next/drivers/net/wireless/broadcom/brcm80211/brcmfmac'
> CC [M]  debug.o
> debug.c:17:5: error: redefinition of ‘brcmf_debug_create_memdump’
> 17 | int brcmf_debug_create_memdump(struct brcmf_bus *bus, const void *data,
> |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
> In file included from bus.h:12,
>        from debug.c:13:
> debug.h:136:5: note: previous definition of ‘brcmf_debug_create_memdump’ 
> with type
> ‘int(struct brcmf_bus *, const void *, size_t)’ {aka ‘int(struct brcmf_bus 
> *, const void *, long unsigned int)’}
> 136 | int brcmf_debug_create_memdump(struct brcmf_bus *bus, const void *data,
> |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
> debug.c:45:16: error: redefinition of ‘brcmf_debugfs_get_devdir’
> 45 | struct dentry *brcmf_debugfs_get_devdir(struct brcmf_pub *drvr)
> |                ^~~~~~~~~~~~~~~~~~~~~~~~
> debug.h:127:30: note: previous definition of ‘brcmf_debugfs_get_devdir’ 
> with type
> ‘struct dentry *(struct brcmf_pub *)’
> 127 | static inline struct dentry *brcmf_debugfs_get_devdir(struct 
> brcmf_pub *drvr)
> |                              ^~~~~~~~~~~~~~~~~~~~~~~~
> debug.c:50:6: error: redefinition of ‘brcmf_debugfs_add_entry’
> 50 | void brcmf_debugfs_add_entry(struct brcmf_pub *drvr, const char *fn,
> |      ^~~~~~~~~~~~~~~~~~~~~~~
> debug.h:132:6: note: previous definition of ‘brcmf_debugfs_add_entry’ with type
> ‘void(struct brcmf_pub *, const char *, int (*)(struct seq_file *, void *))’
> 132 | void brcmf_debugfs_add_entry(struct brcmf_pub *drvr, const char *fn,
> |      ^~~~~~~~~~~~~~~~~~~~~~~
> make[3]: *** [/root/wireless-next/scripts/Makefile.build:203: debug.o] Error 1
> make[2]: *** [/root/wireless/wireless-next/Makefile:2006: .] Error 2
> make[1]: *** [/root/wireless/wireless-next/Makefile:248: __sub-make] Error 2
> make[1]: Leaving directory 
> '/root/wireless-next/drivers/net/wireless/broadcom/brcm80211/brcmfmac'
> make: *** [Makefile:248: __sub-make] Error 2

To be honest I am not sure whether to accept this patch or not. The way the 
makefiles are setup was never intended to support this usage. The cause of 
the failure lies within the fact that the makefile in 
drivers/net/wireless/broadcom/brcm80211 passes -DDEBUG to the subdirs. Also 
I recall using the M=<dir> option result in out-of-tree taint. That said 
the following does work:

$ make M=drivers/net/wireless/broadcom/brcm80211 modules

So I tend to discard this patch.

Regards,
Arend

> Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
> ---
> drivers/net/wireless/broadcom/brcm80211/brcmfmac/debug.c | 2 ++
> 1 file changed, 2 insertions(+)
>
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/debug.c 
> b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/debug.c
> index eecf8a38d94a..3cb50140eb2f 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/debug.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/debug.c
> @@ -14,6 +14,7 @@
> #include "fweh.h"
> #include "debug.h"
>
> +#ifdef DEBUG
> int brcmf_debug_create_memdump(struct brcmf_bus *bus, const void *data,
> size_t len)
> {
> @@ -54,3 +55,4 @@ void brcmf_debugfs_add_entry(struct brcmf_pub *drvr, 
> const char *fn,
> debugfs_create_devm_seqfile(drvr->bus_if->dev, fn,
> drvr->wiphy->debugfsdir, read_fn);
> }
> +#endif
> --
> 2.47.0




