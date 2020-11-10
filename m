Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2612ACA9A
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Nov 2020 02:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731267AbgKJBmJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Nov 2020 20:42:09 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:42613 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729452AbgKJBmH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Nov 2020 20:42:07 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <seth.forshee@canonical.com>)
        id 1kcIfc-00010R-UJ
        for linux-wireless@vger.kernel.org; Tue, 10 Nov 2020 01:42:05 +0000
Received: by mail-io1-f70.google.com with SMTP id z7so2974928iom.14
        for <linux-wireless@vger.kernel.org>; Mon, 09 Nov 2020 17:42:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E880HvGjLzSgwj76eQwFny2hAi4BxIyxarhqics3gS4=;
        b=oK7AvCDCEMT/1ALaDX+F1thd5TgulsM+UkcUgfbg5n2Am4K7kYlQ/94eniAbhzGrcQ
         90sXbSIxUfnfTplZkNVD282rKsr44lq0dpO+KTui8ao5gvHQGqj0JEu0bK/vm85HinXH
         DyLsIRurEUAtSZseXa95+GjuRDfh16KogJcIly9IEi8uV9I6BRg31hUEHO6JwrfP5456
         DU5HS2aJkCYZSkA5gJ0+96RBZFYjb8BaBkHRhDKW6Zbpdg8o6X0tvoMzLQlIGYB3FAt0
         N2WQ6DvhSRB6jU/oM2wtsBs3fIRFF2cVKw9N8U13eUXjTWIJPaKL+6m/V3CDt/VYS+iU
         IGQg==
X-Gm-Message-State: AOAM533O30i1KAIsTgWlO1KaS46mvCnm8cz2SDoKzCdVeZ0ja6wcc+75
        aYBbj6SPnVVKu4x6ayNVn2tGI5FcSVS4lip7xXoA3Qgpxww/HuTiSebGlqq06vnL+FPGWfQNav+
        Wov4BwM+nECnF+ni8wXN8XfBe7/VMOYFP2B/EekCMYvyK
X-Received: by 2002:a92:9a1d:: with SMTP id t29mr12787591ili.85.1604972523653;
        Mon, 09 Nov 2020 17:42:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx40fA0IVPO0GxSAC87bsI26T5A/GGSoJ2ghk7gQJCDWjTZRZI6Ag8bUOjKdXGiouQglqDKpQ==
X-Received: by 2002:a92:9a1d:: with SMTP id t29mr12787585ili.85.1604972523469;
        Mon, 09 Nov 2020 17:42:03 -0800 (PST)
Received: from localhost ([2605:a601:ac0f:820:89a:1dd3:9ddb:b24d])
        by smtp.gmail.com with ESMTPSA id k18sm6441811iow.4.2020.11.09.17.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 17:42:02 -0800 (PST)
Date:   Mon, 9 Nov 2020 19:42:02 -0600
From:   Seth Forshee <seth.forshee@canonical.com>
To:     wireless-regdb@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Ahmed Kamal <email.ahmedkamal@googlemail.com>
Subject: Re: [PATCH] wireless-regdb: update regulatory rules for Egypt (EG)
Message-ID: <20201110014202.GI6125@ubuntu-x1>
References: <20200528210607.16154-1-seth.forshee@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528210607.16154-1-seth.forshee@canonical.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, May 28, 2020 at 04:06:07PM -0500, Seth Forshee wrote:
> Update the rules to the frequency ranges and power limits
> documented in [1], and update 5GHz rules to comply with
> EN 301 893.
> 
> [1] https://www.tra.gov.eg/en/industry/importing-of-equipment/Pages/Regulations-for-use-of-Wireless-Networks-Devices.aspx
> 
> Signed-off-by: Seth Forshee <seth.forshee@canonical.com>

Applied.

> ---
>  db.txt | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/db.txt b/db.txt
> index ac3248350956..699bce9fb9d8 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -516,10 +516,11 @@ country EE: DFS-ETSI
>  	# 60 GHz band channels 1-4 (ETSI EN 302 567)
>  	(57000 - 66000 @ 2160), (40)
>  
> +# https://www.tra.gov.eg/en/industry/importing-of-equipment/Pages/Regulations-for-use-of-Wireless-Networks-Devices.aspx
>  country EG: DFS-ETSI
> -	(2402 - 2482 @ 40), (20)
> -	(5170 - 5250 @ 40), (20)
> -	(5250 - 5330 @ 40), (20), DFS
> +	(2402 - 2483.5 @ 40), (20)
> +	(5150 - 5250 @ 80), (23), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
> +	(5250 - 5330 @ 80), (20), NO-OUTDOOR, DFS, AUTO-BW, wmmrule=ETSI
>  
>  # ES as part of EU/CEPT accepted decisions 2005/513/EC (5GHz RLAN, EN 301 893)
>  # and 2006/771/EC (amended by 2008/432/EC, Short-Range Devices, EN 300 440)
> -- 
> 2.25.1
> 
