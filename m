Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34F271F592
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2019 15:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbfEON3l (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 May 2019 09:29:41 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44133 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfEON3l (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 May 2019 09:29:41 -0400
Received: from mail-it1-f199.google.com ([209.85.166.199])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <seth.forshee@canonical.com>)
        id 1hQtyU-0008Bc-W0
        for linux-wireless@vger.kernel.org; Wed, 15 May 2019 13:29:39 +0000
Received: by mail-it1-f199.google.com with SMTP id q1so27102itc.3
        for <linux-wireless@vger.kernel.org>; Wed, 15 May 2019 06:29:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=6cgQlcbb9aXV/GA3B+f3Bva0l7ApZcRd+LWzuJ2R/Eg=;
        b=kM0imf2GoJ1iJkRGjwogtgVMzWQyJ9QluySCYND56WKG7c0bnVCet4eYZGFuoKePXT
         ZxmBZN9zPhhVc6ZYcNBEPYee7i+9yMlxJRrhzuw82NgmyDxK7bCvls+8P8d3fQlbFbTi
         VNHr0KbCL9K8LHET3Eh2VYB/dVMYhEIkEYwT3/gcPHhw0QRxEksYxM8M014ikMFxDg6k
         X9Ft0lIVNvd62zWUZJi5auHrIi52IY51qBmPlQY2gibkSGy2uowll+m+U2X+nAjhvbu3
         kQb2T9/BTjNhzqinK6H69iDjSApKNvHPUdFIdGOsdi3eIpW1jdI9PI3ZQS9ZvXOVuBda
         hQqA==
X-Gm-Message-State: APjAAAXQvGryRNuYzzkByCGLoF6ONGzXbePk629tldaBADfz0RcvHKpd
        ATzrptmOYD7Wja0ZBEH1EVZl7QYHK0q5fkWxFBB72zhMCBPs/3uVdmh9xgevSQsmaXd7Wg5Ibty
        1xttItS0Td8DCXPd6AbUW2x+imVwt9ouLEqxhNZhBq+7Z
X-Received: by 2002:a6b:ea02:: with SMTP id m2mr21942382ioc.270.1557926978001;
        Wed, 15 May 2019 06:29:38 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw+zh7g/J5bKOHx/HcDukNew1s1rQAZmiNk8AaI/cXffwbFRuKR4IPNtMFXOzs9/KV2tvH9Ww==
X-Received: by 2002:a6b:ea02:: with SMTP id m2mr21942366ioc.270.1557926977752;
        Wed, 15 May 2019 06:29:37 -0700 (PDT)
Received: from localhost ([2605:a601:ac2:fb20:4dea:9e3c:35e:c3dc])
        by smtp.gmail.com with ESMTPSA id m64sm112332itg.4.2019.05.15.06.29.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 May 2019 06:29:37 -0700 (PDT)
Date:   Wed, 15 May 2019 08:29:36 -0500
From:   Seth Forshee <seth.forshee@canonical.com>
To:     Xose Vazquez Perez <xose.vazquez@gmail.com>
Cc:     WIRELESS ML <linux-wireless@vger.kernel.org>,
        REGDB ML <wireless-regdb@lists.infradead.org>
Subject: Re: [PATCH] wireless-regdb: update source of information for ES
Message-ID: <20190515132936.GA4357@ubuntu-xps13>
References: <20190504191817.3668-1-xose.vazquez@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190504191817.3668-1-xose.vazquez@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, May 04, 2019 at 09:18:17PM +0200, Xose Vazquez Perez wrote:
> Cc: Seth Forshee <seth.forshee@canonical.com>
> Cc: WIRELESS ML <linux-wireless@vger.kernel.org>
> Cc: REGDB ML <wireless-regdb@lists.infradead.org>
> Signed-off-by: Xose Vazquez Perez <xose.vazquez@gmail.com>

Applied, thanks!
> ---
>  db.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/db.txt b/db.txt
> index 4fb1948..fe909a8 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -432,7 +432,7 @@ country EG: DFS-ETSI
>  
>  # Source:
>  # Cuadro nacional de atribución de frecuencias (CNAF)
> -# http://www.mincotur.gob.es/telecomunicaciones/espectro/paginas/cnaf.aspx
> +# https://avancedigital.gob.es/espectro/Paginas/cnaf.aspx
>  country ES: DFS-ETSI
>  	(2400 - 2483.5 @ 40), (100 mW)
>  	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI

Applied, thanks!
