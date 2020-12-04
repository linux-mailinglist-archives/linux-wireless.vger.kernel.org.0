Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8D72CF081
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Dec 2020 16:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbgLDPM1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Dec 2020 10:12:27 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:40670 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728626AbgLDPM0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Dec 2020 10:12:26 -0500
Received: from mail-oo1-f71.google.com ([209.85.161.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <seth.forshee@canonical.com>)
        id 1klCkK-0001Bv-41
        for linux-wireless@vger.kernel.org; Fri, 04 Dec 2020 15:11:44 +0000
Received: by mail-oo1-f71.google.com with SMTP id w11so2747019ooi.6
        for <linux-wireless@vger.kernel.org>; Fri, 04 Dec 2020 07:11:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=dq4LBV56aBTRyth+Na87XQg04nbLfsTv/j3SjfddMyY=;
        b=JmLmnt2yf6Cx50OqEiee6vk39UFcI4xEBFsHA+HiLFH8EcWvZH3kZF72hsEDYPQxZp
         k79kjFUxTU3Zx3XVK+nTsmrRfYNlymp2DahRlwVquInisMAHfBdP4e/jJLzjVLw47Ox2
         hGtCGpAZ700/PLOiLrX5bDKux6BJnez/MLoVc6xGoV1JOOBpkmA9fbx48gQpDTjqBmS0
         C032OZTJOIPi1coJ/PXYy8nFsXp4JffaWl0qdnP9St88UN4N+rUXWHUR6Q0KmkKM+T5Y
         A5jyo1swM+Vi7MxUs/900UaT8+sD1Udf0Sla+ANn0jRedhZlYa2Y3x8TTwrvK/0gTNb7
         c+Cw==
X-Gm-Message-State: AOAM530omu23PDLSWwbvmVwWlenk9kVv/5+sRKyXbQelIh2G/Yb5pEQp
        arxOne5MQfc4S+IRG2qpR93iDYUPxOLBGEj3qAf7K4DBYKN/bZtU+OOXLaF8tUrlyYTHz7NaL9U
        nrbdyp8VSRCnaEfSbeY0ebINow5a3LhcjyOPNAPE5DJVi
X-Received: by 2002:aca:cc01:: with SMTP id c1mr3549486oig.18.1607094702769;
        Fri, 04 Dec 2020 07:11:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxQVF12aDlIdugOVvkOJYFtiQBL2+iheMGDnBi3XGxi36A+q+UaxmDVoDcpoqpBoXx3Ft08Wg==
X-Received: by 2002:aca:cc01:: with SMTP id c1mr3549462oig.18.1607094702403;
        Fri, 04 Dec 2020 07:11:42 -0800 (PST)
Received: from localhost ([2605:a601:ac0f:820:6b8d:b00f:e1e3:321a])
        by smtp.gmail.com with ESMTPSA id f20sm658754otp.70.2020.12.04.07.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 07:11:41 -0800 (PST)
Date:   Fri, 4 Dec 2020 09:11:41 -0600
From:   Seth Forshee <seth.forshee@canonical.com>
To:     bkil <b.K.il.h.u+tigbuh@gmail.com>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wireless-regdb: recent FCC report and order allows
 5850-5895 immediately
Message-ID: <X8pRrWfZPhLdguu8@ubuntu-x1>
References: <a79286b90cdfdee3a83397008c0f7b6d67bc7f69.1607035229.git.b.K.il.h.u+tigbuh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a79286b90cdfdee3a83397008c0f7b6d67bc7f69.1607035229.git.b.K.il.h.u+tigbuh@gmail.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Dec 03, 2020 at 11:40:30PM +0100, bkil wrote:
> The new band is called U-NII-4.

The report states in paragraph 203 that the order is effective 60 days
from publication in the Federal Register, and it looks like they haven't
even been published in the Federal Register yet. We will need to wait
for the rules to go into effect before applying any updates.

> The report recommends combining it with 5725-5895 to allow 160 MHz
> bandwidth, but that's technically not that easy with regdb due to the
> differing restrictions of the two parts. Marking the line for U-NII-3
> NO-OUTDOOR and PTMP-ONLY along with extending its range would be a
> possible workaround, but this needs to be discussed.

I think it should be sufficient to set the bandwidth of both 5730-5850
and 5850-5895 to 160 MHz with AUTO-BW. The kernel will see the AUTO-BW
flags and calculate a combined rule where 160 MHz is allowed, and for
the original rules any bandwidth exceeding the available bandwidth of
the rule will be disallowed.

> I don't see a requirement for TPC, hence reducing EIRP by 3dB is not
> needed. I've marked it 33dBm (minus 6dB for clients) to cope with 20MHz,
> but the band can support higher power, though the logic is complicated.

I believe we have an additional requirement from § 15.407 (a)(3)(v):

  In the 5.850-5.895 GHz band, client devices must operate under the
  control of an indoor access point. In all cases, an exception exists
  for transmitting brief messages to an access point when attempting to
  join its network after detecting a signal that confirms that an access
  point is operating on a particular channel.

This sounds like a requirement for passive scanning, if so the range
should also have the NO-IR flag.

Thanks,
Seth

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
> index c71a03a..e6dd063 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -1587,7 +1587,10 @@ country US: DFS-FCC
>  	# requirements, we can extend the range by 5 MHz to make the kernel
>  	# happy and be able to use channel 144.
>  	(5470 - 5730 @ 160), (23), DFS
> -	(5730 - 5850 @ 80), (30)
> +	(5730 - 5850 @ 80), (30), AUTO-BW
> +	# https://www.fcc.gov/document/fcc-modernizes-59-ghz-band-improve-wi-fi-and-automotive-safety-0
> +	# max. 33 dBm AP @ 20MHz, 36 dBm AP @ 40Mhz+, 6 dB less for clients
> +	(5850 - 5895 @ 40), (27), NO-OUTDOOR, PTMP-ONLY, AUTO-BW
>  	# 60g band
>  	# reference: section IV-D https://docs.fcc.gov/public/attachments/FCC-16-89A1.pdf
>  	# channels 1-6 EIRP=40dBm(43dBm peak)
