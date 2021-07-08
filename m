Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51A023C19FE
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jul 2021 21:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbhGHTo7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Jul 2021 15:44:59 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50105 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbhGHTo6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Jul 2021 15:44:58 -0400
Received: from mail-oo1-f69.google.com ([209.85.161.69])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <seth.forshee@canonical.com>)
        id 1m1ZuZ-0000Rp-D1
        for linux-wireless@vger.kernel.org; Thu, 08 Jul 2021 19:42:15 +0000
Received: by mail-oo1-f69.google.com with SMTP id b1-20020a4ac2810000b029024bec618157so4144435ooq.2
        for <linux-wireless@vger.kernel.org>; Thu, 08 Jul 2021 12:42:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e9RsPKTukMWDfukpCshxN15G+Av0+owLjhl9gLABaO4=;
        b=QpcEfEXg4QKSCfF3dfoAugGfeiGtzkm1bKj8c06NOuLDP5/LuqHZz6Aiy5o9kQYtq4
         lIpMtZEm6iFJm+nSUdcAEcjzerLWJoKE/E1HFZrbSMkImJlgMpZRLROt4DLhVXPKEu02
         W2ZoKRevgJ995ZcS/+CkXRHuN3Ao+oPpR8TEN2Ha6hdRLWacnun/MrU3dL6o6klCi3D3
         bLA394oqIcXhRvFLhXf8XIyUdL0HiOuunsePgrWkJ+h8Hf85PsdT5qXRkDL259dJ43kn
         Ozvr12PfEUH9PATdRXPY9nAsnmsru8jt3LGI1h+l87viPjJzXE4VUJzn2/MdD8B49FL0
         fGRg==
X-Gm-Message-State: AOAM533KaBVhOvKMfE9d+eanoRzrEn/aVpnYS0U3AFgVwV4rkA/RKLdz
        ZoFDvRx/5xBXWRS+19S0icZoUACYXyEtMxLiqoyzwqDyLKqUJdQ88vhiH5HQzh2B3FGIYlylvOd
        KknlXnSx5RsBhZDWlpAENIqeySgObn+T80cz/TRkFrlU8
X-Received: by 2002:aca:c041:: with SMTP id q62mr5070260oif.158.1625773334383;
        Thu, 08 Jul 2021 12:42:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxdCoP3f5SRuUT9OnvnXMGgrD+CDh0bvUm7MlM8gGV/8be1l4iH1W1xymnh+sOOk/dYYCLZ5g==
X-Received: by 2002:aca:c041:: with SMTP id q62mr5070241oif.158.1625773334116;
        Thu, 08 Jul 2021 12:42:14 -0700 (PDT)
Received: from localhost ([2605:a601:ac0f:820:1a5:fce9:a73f:988e])
        by smtp.gmail.com with ESMTPSA id t5sm666420otk.39.2021.07.08.12.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 12:42:13 -0700 (PDT)
Date:   Thu, 8 Jul 2021 14:42:12 -0500
From:   Seth Forshee <seth.forshee@canonical.com>
To:     bkil <b.K.il.h.u+tigbuh@gmail.com>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH v2] wireless-regdb: recent FCC report and order allows
 5850-5895 immediately
Message-ID: <YOdVFE51Wbxr80Qf@ubuntu-x1>
References: <CAPuHQ=GbacSTgyimkJtx1FXp319Df=LdrPQZ6ZDnPQ_JVXueKw@mail.gmail.com>
 <10ffaa74a0779b7c7047de70cb1db7dfb0000022.1625068999.git.b.K.il.h.u+tigbuh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10ffaa74a0779b7c7047de70cb1db7dfb0000022.1625068999.git.b.K.il.h.u+tigbuh@gmail.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Jun 30, 2021 at 06:03:20PM +0200, bkil wrote:
> The new band is called U-NII-4.
> 
> The report recommends combining it with 5725-5895 to allow 160 MHz
> bandwidth, but that's technically not that easy with regdb due to the
> differing restrictions of the two parts. Marking the line for U-NII-3
> NO-OUTDOOR and PTMP-ONLY along with extending its range would be a
> possible workaround, but this needs to be discussed.
> 
> I don't see a requirement for TPC, hence reducing EIRP by 3dB is not
> needed. I've marked it 33dBm (minus 6dB for clients) to cope with 20MHz,
> but the band can support higher power, though the logic is complicated.
> 
> The upper subband (5895-5925 MHz) of the new band is reserved for ITS.
> 
> "We limit unlicensed use to indoor operations in recognition of the
> potential that ITS licensees may currently be operating"
> 
> "We also proposed that U-NII-4 devices be permitted to operate at the same
> power levels as U-NII-3 devices."
> 
> "For the U-NII-4 band, indoor access point EIRP will be limited to
> 33 dBm/20 MHz and 36 dBm/40 MHz. When combined with U-NII-3 band spectrum,
> indoor access point EIRP can scale to 36 dBm for 80 and 160 megahertz
> channels."
> 
> "Client devices would be limited to power levels 6 dB below the power
> limits for access points."
> 
> "the First Report and Order prohibit U-NII-4 client-to-client
> communications to protect co-channel incumbent ITS"
> 
> Signed-off-by: bkil <b.K.il.h.u+tigbuh@gmail.com>
> ---
>  db.txt | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/db.txt b/db.txt
> index c71a03a..ae6ea31 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -1587,7 +1587,10 @@ country US: DFS-FCC
>  	# requirements, we can extend the range by 5 MHz to make the kernel
>  	# happy and be able to use channel 144.
>  	(5470 - 5730 @ 160), (23), DFS
> -	(5730 - 5850 @ 80), (30)
> +	(5730 - 5850 @ 160), (30), AUTO-BW
> +	# https://www.federalregister.gov/documents/2021/05/03/2021-08802/use-of-the-5850-5925-ghz-band
> +	# max. 33 dBm AP @ 20MHz, 36 dBm AP @ 40Mhz+, 6 dB less for clients
> +	(5850 - 5895 @ 160), (27), NO-OUTDOOR, PTMP-ONLY, AUTO-BW, NO-IR

I discovered a couple of problems here.

The first is that it seems I forgot to test build this patch before I
pushed it. The PTMP-ONLY flag isn't allowed by db2fw.py. This was done
by Johannes for reasons which aren't explained, so maybe he can shed
some light on it. The flag doesn't appear to be used by the kernel or
hostapd, so maybe it was deprecated long ago. Anyway, I've pushed a
change to remove this flag.

The second problem is more serious. I thought that we could allow 160
MHz bandwidth across two AUTO-BW ranges too small for this bandwidth,
but it turns out that the kernel rejects any rules with a bandwidth
greater than the frequency range of the rule. I'm not sure what we can
do about this. Even if the kernel were changed to support allowing
greater bandwidths across combined ranges, we're going to have a
backwards compatibility problem with older kernels.

Seth
