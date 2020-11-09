Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7737B2AC931
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Nov 2020 00:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730087AbgKIXQz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Nov 2020 18:16:55 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:40250 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbgKIXQz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Nov 2020 18:16:55 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <seth.forshee@canonical.com>)
        id 1kcGP6-0001I2-HU
        for linux-wireless@vger.kernel.org; Mon, 09 Nov 2020 23:16:52 +0000
Received: by mail-io1-f72.google.com with SMTP id y17so6886148iot.1
        for <linux-wireless@vger.kernel.org>; Mon, 09 Nov 2020 15:16:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yWOh058py9Z1yCKFlGUJbeKB5vRPnrW3Yx1obVhiW9c=;
        b=lPxKHHNHFhrjXIVuDWmJGyEXHkVG5S0mS58bOpMNKW8HuovQeEKOyJBo+KAxdSn1C5
         CBwDUhIzLNRe6s+/AehbZ+D4x5ADUZd+xH5qj+pMc1/3Tz7sM1aBe1c0qP5frRuQJSc/
         iRzEJ+gHX94aOCaSg/KdltNlQT0dnovY4WvIiHQ1RcYxbbKqmiKIvTjw2BGCjKtbvc0M
         a2RMbrllsA7MqLWDDu3+QxrWPpzKDPQSDdMfsyT+IyXAyDfg4z2TpRjboJU/IpXPDqJV
         /2DsfRfRXCaiZ5ws2SuNL+xKNiIy6XcqkTm6iVT1m5jenrp2O7/tJNOnkudtGfX/SrTE
         PNsQ==
X-Gm-Message-State: AOAM5333PdDQYOJOHGJUeBztLp8HRn2miYynum4DflzyMoVeZz/o3XwZ
        PX0TWSbvT/Cepf3+CS5+Mtot/j7UU+yl4a8W9eoseV+0f6kdvVsur+AVgWAtgtFYhH+ZZo2RHTo
        gpRomzw7EHR7PsG/sfAbJ0SPg0i3zAgqqv2nWGu4KM5Xf
X-Received: by 2002:a02:3849:: with SMTP id v9mr12971797jae.23.1604963811431;
        Mon, 09 Nov 2020 15:16:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxGcZsfRvnr6fhEXkXQImea9heFzhzuJBw81LlBL76xMVghIzqjTfoWTzKH9BelfllHjgXU9Q==
X-Received: by 2002:a02:3849:: with SMTP id v9mr12971782jae.23.1604963811187;
        Mon, 09 Nov 2020 15:16:51 -0800 (PST)
Received: from localhost ([2605:a601:ac0f:820:da74:bc22:6cb3:9db0])
        by smtp.gmail.com with ESMTPSA id 192sm8178352ilc.31.2020.11.09.15.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 15:16:50 -0800 (PST)
Date:   Mon, 9 Nov 2020 17:16:49 -0600
From:   Seth Forshee <seth.forshee@canonical.com>
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org,
        Luka Perkov <luka.perkov@sartura.hr>
Subject: Re: [PATCH] wireless-regdb: Update regulatory rules for Croatia (HR)
Message-ID: <20201109231649.GH6125@ubuntu-x1>
References: <20200913172140.66439-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200913172140.66439-1-robert.marko@sartura.hr>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, Sep 13, 2020 at 07:21:40PM +0200, Robert Marko wrote:
> Croatian Regulatory Authority for Network Industries (HAKOM) has
> updated the general licenses OD-85 and OD-86 with the new OD-85a
> and OD-86a versions.
> 
> These introuduce the following changes:
> * Outdoor usage for 5150-5250 and 5250-5350 MHz ranges is permitted
> * 5150-5250 MHz range TPC requirment was dropped and power output raised to 200mW
> 
> OD-85a: https://www.hakom.hr/UserDocsImages/op%C4%87e%20dozvole%20prosinac%202009.g/Opca_dozvola_85a.pdf
> OD-86a: https://www.hakom.hr/UserDocsImages/op%C4%87e%20dozvole%20prosinac%202009.g/Opca_dozvola_86a.pdf
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> Cc: Luka Perkov <luka.perkov@sartura.hr>
> ---
>  db.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/db.txt b/db.txt
> index ac32483..52d0fab 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -693,8 +693,8 @@ country HR: DFS-ETSI
>  # Harmonized CEPT countries (July 2019): https://www.ecodocdb.dk/download/25c41779-cd6e/Rec7003e.pdf
>  # HR: http://tablice.hakom.hr:8080/vis?lang=en
>  	(2400 - 2483.5 @ 40), (100 mW)
> -	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
> -	(5250 - 5350 @ 80), (100 mW), NO-OUTDOOR, DFS, AUTO-BW, wmmrule=ETSI
> +	(5150 - 5250 @ 80), (200 mW), AUTO-BW, wmmrule=ETSI

Based on the translation I'm reading the 200 mW applied to elevations
from 5 degrees to 30 degrees, and for elevations above 30 degress the
limit is 125 mW. I'm not expeienced with regulations that vary with the
elevation angle. Why should we use 200 mW instead of 125 mW, which is
allowed for any elevation?

> +	(5250 - 5350 @ 80), (200 mW), DFS, AUTO-BW, wmmrule=ETSI

The translation of OD-86a I'm reading says "use mostly indoors." Is that
an accurate translation? How does this compare to the language from
OD-86? I'm a little unsure how to interpret it.

Thanks,
Seth

>  	(5470 - 5725 @ 160), (500 mW), DFS, wmmrule=ETSI
>  	# short range devices (ETSI EN 300 440-1)
>  	(5725 - 5875 @ 80), (25 mW)
> -- 
> 2.26.2
> 
