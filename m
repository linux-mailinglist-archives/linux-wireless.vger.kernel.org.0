Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC532AE1F4
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Nov 2020 22:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731813AbgKJVmh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Nov 2020 16:42:37 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:55341 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731788AbgKJVlQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Nov 2020 16:41:16 -0500
Received: from mail-oo1-f71.google.com ([209.85.161.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <seth.forshee@canonical.com>)
        id 1kcbO7-0003Q1-7m
        for linux-wireless@vger.kernel.org; Tue, 10 Nov 2020 21:41:15 +0000
Received: by mail-oo1-f71.google.com with SMTP id s12so3731227ooi.15
        for <linux-wireless@vger.kernel.org>; Tue, 10 Nov 2020 13:41:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q/djiqG9Pi5zrzDasDd7yPyRTlES71+RB1ajbt/jzT0=;
        b=EwsgdDljlbzdwEQoG5LqYYzPbgdNZz2rgdatn6eLc4NLU069yIkWJM4dx83otKnev5
         havqgXuXor/zxBJe0c7ueW9dInhbddLSAY54XC9sBRCJBNsJXXvjigf62f9bUz54Txo6
         E8NYdtMPJmTJqtRduY2vl8BtHeFfaXIKemw04X7csQaPkIRRJeiNUxeDGcPvtFFkmSOE
         vpl0pmQ4jwhqA2lTf5F6zT/k8ydOYGxFBcbQmApHb7poCpTUQTYd4a5XbiEZRz4JOjbW
         +q4IFqP0i3gXehjZ9aRdTSUZZnjrVA/PaTKSUnxkhbywEnxqpxzfgkjt8UECfFafZbGD
         vyfg==
X-Gm-Message-State: AOAM531L0hcHAkbNhaCOawOU1wMul8ml8IdAiusXC89zumYmWChHhN9V
        BzXPK+FwuHctziMqI9h0yT+mmOqSghkBe7Iw5xxzj/6rItiHdPbTZeIHSRFZJX/t3QTooncJu+d
        z9Iq4Udrmd+42CYL311iipFRNPnsIu/rs8Q946OGAmlyk
X-Received: by 2002:aca:5dc2:: with SMTP id r185mr108784oib.106.1605044474205;
        Tue, 10 Nov 2020 13:41:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwcTAEw5c7iDav8QQVvEw0S1d7hc8EMLO7N66rENcYnMrDNtwFC4bFGLHlHvYpAH9wkHbAsVQ==
X-Received: by 2002:aca:5dc2:: with SMTP id r185mr108776oib.106.1605044473978;
        Tue, 10 Nov 2020 13:41:13 -0800 (PST)
Received: from localhost ([2605:a601:ac0f:820:59ea:bfb1:548d:1c70])
        by smtp.gmail.com with ESMTPSA id w18sm37972otl.38.2020.11.10.13.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 13:41:13 -0800 (PST)
Date:   Tue, 10 Nov 2020 15:41:12 -0600
From:   Seth Forshee <seth.forshee@canonical.com>
To:     wireless-regdb@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wireless-regdb: update 5.8 GHz regulatory rule for GB
Message-ID: <20201110214112.GO6125@ubuntu-x1>
References: <20201106215324.91265-1-seth.forshee@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106215324.91265-1-seth.forshee@canonical.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Nov 06, 2020 at 03:53:24PM -0600, Seth Forshee wrote:
> Based on [1], the 5.8 GHz limit for GB is 200 mW and requires DFS
> and TPC. Update the rule accordingly.
> 
> While at it, expand the 5470 - 5725 rule to 5730 as specified in
> the same document to allow channel 144 to be used.
> 
> [1] https://www.ofcom.org.uk/__data/assets/pdf_file/0028/84970/ir-2030.pdf
> 
> Signed-off-by: Seth Forshee <seth.forshee@canonical.com>

Applied.

> ---
>  db.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/db.txt b/db.txt
> index 699bce9fb9d8..39e1928fe384 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -593,9 +593,9 @@ country GB: DFS-ETSI
>  	(2400 - 2483.5 @ 40), (100 mW)
>  	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
>  	(5250 - 5350 @ 80), (100 mW), NO-OUTDOOR, DFS, AUTO-BW, wmmrule=ETSI
> -	(5470 - 5725 @ 160), (500 mW), DFS, wmmrule=ETSI
> +	(5470 - 5730 @ 160), (500 mW), DFS, wmmrule=ETSI
>  	# short range devices (ETSI EN 300 440-1)
> -	(5725 - 5875 @ 80), (25 mW)
> +	(5725 - 5875 @ 80), (100 mW), DFS
>  	# 60 GHz band channels 1-6
>  	(57000 - 71000 @ 2160), (40)
>  
> -- 
> 2.27.0
> 
