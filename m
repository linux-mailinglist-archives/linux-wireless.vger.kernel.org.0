Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46979E8B2D
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2019 15:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389730AbfJ2OsV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Oct 2019 10:48:21 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43052 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389444AbfJ2OsU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Oct 2019 10:48:20 -0400
Received: from mail-yb1-f197.google.com ([209.85.219.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <seth.forshee@canonical.com>)
        id 1iPSnD-0006vo-A2
        for linux-wireless@vger.kernel.org; Tue, 29 Oct 2019 14:48:19 +0000
Received: by mail-yb1-f197.google.com with SMTP id 6so10761453ybu.4
        for <linux-wireless@vger.kernel.org>; Tue, 29 Oct 2019 07:48:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8VcU8xUmaPVpH6yRKfIHrTiU2Q4D+jfyrJSSLOYWAR8=;
        b=YVyAE5tNO/VUZHBAZau08lEGOGYvKKBGRZQWTiFKyaf/o57YPKB9Gk4Q9ULvDIxu+D
         x1577AxZKbqwBSkvRkop/jkCEzEPK92NDLUg2s/wfREub1hBJ4YeFPxk6pDCqbZ3BApZ
         kiOYQ2jGJA4+5N6wxi7bCtclts6tDycRPnCDF/NSZsX5Qz3zLRX3dOu7G/FaKwA0HKL9
         KDWuCvgVHqYZwgsQANr4ItMlDYXXeFakbKm4WdumoLz1Yyw4QdoUI3d+mbJdkVO3bIRR
         jKHLD06ImI68R1vMFeGAEH3OA/a/kxaE6TW8BYvxsit4sfn6L2Ps/TSpQOyvWf7eNPAQ
         fV4A==
X-Gm-Message-State: APjAAAViORsuM8W0d1RJ5/knjQzHFpHa83Qjw53f3d5U/aVYwEEa6/kf
        4ooS9f2rltcxVx1g2Lh8RVphZHu3s0ZYKbGK/AdBQdSiArlZaK328yAbQ5i/2vovK8J1VsIbGQu
        R0RBCJ1lJu7ISmuTm4xOFF4UHvyRa13W/+aKni1TtdTxD
X-Received: by 2002:a81:2a46:: with SMTP id q67mr18290614ywq.384.1572360498337;
        Tue, 29 Oct 2019 07:48:18 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyG2Co/AdrPLTC/kADGrb/7HDi/6I+6bT/BPr39uZR0wi99pi5tDH1HuUAIaUz8vaxsB5ZJ/Q==
X-Received: by 2002:a81:2a46:: with SMTP id q67mr18290581ywq.384.1572360497919;
        Tue, 29 Oct 2019 07:48:17 -0700 (PDT)
Received: from localhost ([2605:a601:ac3:9720:f461:b9b9:429:65bd])
        by smtp.gmail.com with ESMTPSA id z196sm20753066ywz.30.2019.10.29.07.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 07:48:16 -0700 (PDT)
Date:   Tue, 29 Oct 2019 09:48:15 -0500
From:   Seth Forshee <seth.forshee@canonical.com>
To:     Dmitry Tunin <hanipouspilot@gmail.com>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2] wireless-regdb: update regulatory rules for
 Kazakhstan (KZ)
Message-ID: <20191029144815.GR30813@ubuntu-xps13>
References: <1567189484-27536-1-git-send-email-hanipouspilot@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567189484-27536-1-git-send-email-hanipouspilot@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Aug 30, 2019 at 09:24:44PM +0300, Dmitry Tunin wrote:
> Update according to the regulatory rule of January 21, 2015
> 
> http://egov.kz/cms/ru/law/list/V1500010730
> https://tengrinews.kz/zakon/pravitelstvo_respubliki_kazahstan_premer_ministr_rk/svyaz/id-V1500010730/
> 
> No DFS or TPC is mentioned in the document. Neither is 80 MHz channel width.
> 
> Signed-off-by: Dmitry Tunin <hanipouspilot@gmail.com>

Thanks for the patch. I don't agree with all of your changes though,
please see details below.

> ---
>  db.txt | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/db.txt b/db.txt
> index 37393e6..491598e 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -717,13 +717,13 @@ country KY: DFS-FCC
>  	(5735 - 5835 @ 80), (30)
>  
>  # Source:
> -# http://mic.gov.kz/sites/default/files/pages/pravila_prisvoeniya_polos_chastot_no34.pdf
> -# http://adilet.zan.kz/rus/docs/P000001379_
> -country KZ: DFS-ETSI
> -	(2402 - 2482 @ 40), (20)
> -	(5150 - 5250 @ 80), (20), NO-OUTDOOR, AUTO-BW
> -	(5250 - 5350 @ 80), (20), NO-OUTDOOR, DFS, AUTO-BW
> -	(5470 - 5725 @ 80), (20), NO-OUTDOOR, DFS
> +# http://egov.kz/cms/ru/law/list/V1500010730
> +# https://tengrinews.kz/zakon/pravitelstvo_respubliki_kazahstan_premer_ministr_rk/svyaz/id-V1500010730/
> +country KZ:
> +	(2400 - 2483.5 @ 40), (20)
> +	(5150 - 5350 @ 160), (23), NO-OUTDOOR
> +	(5470 - 5850 @ 160), (20), NO-OUTDOOR

The documents you provided reference this document:

https://egov.kz/wps/poc?uri=mjnpa:document&language=ru&documentId=V1500010375#z7

Which says that bands 5150-5350 MHz and 5470-5725 MHz should conform to
WRC-12 resolution 229:

https://www.itu.int/dms_pub/itu-r/opb/act/R-ACT-WRC.9-2012-PDF-E.pdf

This indicates that 5250-5350 MHz and 5470-5725 MHz must either have TPC
or reduce the maximum EIRP by 3 dBm, which for this database means
reducing the maximum power by 3 dBm for these bands. It also states that
these bands must implement the mitigation measures from ITU-R M.1652-1
in these bands, i.e. DFS.

So it appears to me that the existing DFS requirements are correct.
I think 5150-5250 MHz can be raised to 23 dBm, and 5250-5350 MHz needs
to remain at 20 dBm due to the TPC requirement. WRC-12 does mandate TCP
for 5470-5725 MHz, but also a maximum EIRP of 1W, so since 100 mW is far
less than half of that I suspect we can leave that at 20 dBm.

> +	(57000 - 66000 @ 2160), (40), NO-OUTDOOR

This addition looks fine to me.

Thanks,
Seth

>  
>  country LB: DFS-FCC
>  	(2402 - 2482 @ 40), (20)
> -- 
> 2.7.4
> 
