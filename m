Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21E13ACA12
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Sep 2019 01:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbfIGX4l (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 7 Sep 2019 19:56:41 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49906 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727889AbfIGX4k (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 7 Sep 2019 19:56:40 -0400
Received: from mail-qt1-f200.google.com ([209.85.160.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <seth.forshee@canonical.com>)
        id 1i6kZL-0006os-7c
        for linux-wireless@vger.kernel.org; Sat, 07 Sep 2019 23:56:39 +0000
Received: by mail-qt1-f200.google.com with SMTP id z4so11219451qts.0
        for <linux-wireless@vger.kernel.org>; Sat, 07 Sep 2019 16:56:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aGf6h4SZuPi2sJmsRHr3mY2c1Q9q2zMiZT/u4uHI654=;
        b=i2QbegsSeMv3iL6ksXuHcP0FmwIl1rwX9sZxX0xmw8L4TcDYxHVH4KbYZOd43PKeUF
         iIWdmDVKfR2LQ22GRbe0+Giref+OqhcbXj3HGbulxng/jYoUxzO7csNSBmbpDRMD6JzQ
         XSKx1I/9RVoApd2kkCqX2cp73Kob4GNEHN5b2E9JzhvsfBCtxw7YC9I4zg/UWtCnQlL+
         XRZAlz6jKBIt+UEdRp7iiyyLLLupzKFdHVIwYamIDocrpeDDyRuputaI1EM6H7C337Bh
         GAQU7CIwRJ3tZiF4OP7aI7fRQqU1UHHGD8RF4q9A7GhK+FlRm7spgYS2AUH/Z1I0lqKP
         a3Aw==
X-Gm-Message-State: APjAAAW0S+QaBFwNJdqRkdbf6lIkD9fOvhZy2ocrK9lyzX1LYQygyJjf
        nLViT7fw6mtyWkyslg69GmLJfpW+/D0TkHXI5NHxl6m2QyZl6mRB91ctRT23O449psJ9lNuvQm6
        uU+RFWs4CnvW59A73lYHjMBSthQI+wEmWWW+Z3wK1fy2P
X-Received: by 2002:ac8:54a:: with SMTP id c10mr3950484qth.12.1567900598190;
        Sat, 07 Sep 2019 16:56:38 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzf+YpEMq9oVjKmY97OzeB+Z6/k/AbMaVMDzc1knJb4HqJmsIKZu2RDKmYKEbWhmBMF8+FOjA==
X-Received: by 2002:ac8:54a:: with SMTP id c10mr3950472qth.12.1567900597920;
        Sat, 07 Sep 2019 16:56:37 -0700 (PDT)
Received: from localhost ([107.19.189.106])
        by smtp.gmail.com with ESMTPSA id o52sm6647602qtf.56.2019.09.07.16.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2019 16:56:37 -0700 (PDT)
Date:   Sat, 7 Sep 2019 19:56:36 -0400
From:   Seth Forshee <seth.forshee@canonical.com>
To:     Emil Petersky <emil.petersky@streamunlimited.com>
Cc:     linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Subject: Re: [PATCH] wireless-regdb: Fix ranges of EU countries as they are
 harmonized since 2014...
Message-ID: <20190907235636.GA8256@ubuntu-xps13>
References: <bf327181-521b-e1ce-c5c8-81b828fc65b6@streamunlimited.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf327181-521b-e1ce-c5c8-81b828fc65b6@streamunlimited.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Aug 05, 2019 at 04:19:16PM +0200, Emil Petersky wrote:
> This patch unites entries for EU countries, as they have been harmonized
> latest by July 2014...
> EU decision 2005/513/EC:
> https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02005D0513-20070213
> EU decision 2006/771/EC:
> https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02008D0432-20080611
> 
> Signed-off-by: Emil Petersky <emil.petersky@streamunlimited.com>

Thanks for this patch, and especially for all the references you
provided. Sorry it's taken a while to get back -- I've been checking the
changes against the links which took quite some time, and I have pretty
limited time for reviewing these patches.

Overall this looks good, however when I try to apply it I get an error
that the patch is corrupt. Can you try resending?

I also get warnings from git about trailing whitespace, and I've noted a
couple other trivial whitespace issues below, if you wouldn't mind
fixing those up before resending.

> @@ -167,23 +185,30 @@ country BF: DFS-FCC
>  #
>  # Note: The transmit power limits in the 5250-5350 MHz and 5470-5725 MHz bands
>  # can be raised by 3 dBm if TPC is enabled. Refer to BDS EN 301 893 for details.
> +#
> +# BG as part of EU/CEPT accepted decisions 2005/513/EC (5GHz RLAN, EN 301 893) 
> +# and 2006/771/EC (amended by 2008/432/EC, Short-Range Devices, EN 300 440)
> +#  EU decision 2005/513/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02005D0513-20070213
> +#  EU decision 2006/771/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02008D0432-20080611
> +# BG: https://crc.bg/files/_en/Electronic_Communications_Revised_EN1.pdf
> +# BG: acceptance of 2006/771/EC https://crc.bg/files/Pravila_06_12_2018.pdf
> +
>  country BG: DFS-ETSI

This is the only place where you added a blank line between the comment
and the country. Let's remove that for consistency.

>  	# Wideband data transmission systems (WDTS) in the 2.4GHz ISM band, ref:
>  	# I.22 of the List, BDS EN 300 328
> -	(2402 - 2482 @ 40), (20)
> +	(2400 - 2483.5 @ 40), (100 mW)
>  	# 5 GHz Radio Local Area Networks (RLANs), ref:
>  	# II.H01 of the List, BDS EN 301 893
> -	(5170 - 5250 @ 80), (23), AUTO-BW, wmmrule=ETSI
> -	(5250 - 5330 @ 80), (20), DFS, AUTO-BW, wmmrule=ETSI
> +	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
> +	(5250 - 5350 @ 80), (100 mW), NO-OUTDOOR, DFS, AUTO-BW, wmmrule=ETSI
>  	# II.H01 of the List, I.54 from the List, BDS EN 301 893
> -	(5490 - 5710 @ 160), (27), DFS, wmmrule=ETSI
> -	# Short range devices (SRDs) in the 5725-5875 MHz frequency range, ref:
> +	(5470 - 5725 @ 160), (500 mW), DFS, wmmrule=ETSI
> +	# short range devices (ETSI EN 300 440-1)
>  	# I.43 of the List, BDS EN 300 440-2, BDS EN 300 440-1
> -	(5725 - 5875 @ 80), (14)
> -	# 60 GHz Multiple-Gigabit RLAN Systems, ref:
> +	(5725 - 5875 @ 80), (25 mW)
> +	# 60 GHz band channels 1-4 (ETSI EN 302 567)
>  	# II.H03 of the List, BDS EN 302 567-2
> -	(57000 - 66000 @ 2160), (40), NO-OUTDOOR
> -
> +	(57000 - 66000 @ 2160), (40)
>  country BH: DFS-JP

You removed the blank line between the BG rules and BH here.

Thanks,
Seth
