Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDE22A9F4E
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Nov 2020 22:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728411AbgKFVox (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Nov 2020 16:44:53 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:59161 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728258AbgKFVox (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Nov 2020 16:44:53 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <seth.forshee@canonical.com>)
        id 1kb9XO-0001Cj-C7
        for linux-wireless@vger.kernel.org; Fri, 06 Nov 2020 21:44:50 +0000
Received: by mail-il1-f198.google.com with SMTP id g2so2085404ilb.23
        for <linux-wireless@vger.kernel.org>; Fri, 06 Nov 2020 13:44:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=T2dd4BzI19vKtKlfZK+CZxKK1NYNZzIFzcWzjF2Eijk=;
        b=s+kfk/5YYRpr9fqpnVldsPnWZepttwoWj57xycSzR60wthwo+QVMQeXUH1xHersta2
         UsxtPrXZEML6S+BwMV3PXXUEncGaeOKyTT8O0q72iBfnFsv6DYpqo2T4ZQ1ShCVHGPYU
         8sEFkokWqk6pBmkI3tc/jcYpLhod6fOApF5pZR6Ey3CzpMkEKE7RnNJGEVO/PhyV1DqR
         U7HZqLj+uCFKp0d5pr6VoELvoevN/+zNXUUYJjFOYwqRuvSrmOr/lvOnuPlLg/ZB8vEX
         0U+2QnOAosdTP2jDogyZXvmDYcWh85kD4pOuosNFOCuswEvl17ozzhr5KggmxwDuRx/Z
         /VRQ==
X-Gm-Message-State: AOAM530pfaDgA7eH9mfWqx4BFxtgAFpaERPsCGlevGvj9sNLuxmUbJ3w
        Ch8mf9Mvsqvn6tO6scz0abMKzqDdGTMCUzefNixJSzgzUSKptFzXuDzcnvjySlLBpeNNeVNTTDD
        oKdo4icJTu0Sk+6oTDGxiIsILLqGrg6bVUDvkfqq6Zq9e
X-Received: by 2002:a6b:be84:: with SMTP id o126mr3034395iof.56.1604699088872;
        Fri, 06 Nov 2020 13:44:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxJP+tBZEiRVAGDblWrOZyqysmY74mjVPOWnvEFaJPHpFNYoJHzNcITW/K5DhTgKye5FNTfFg==
X-Received: by 2002:a6b:be84:: with SMTP id o126mr3034381iof.56.1604699088572;
        Fri, 06 Nov 2020 13:44:48 -0800 (PST)
Received: from localhost ([2605:a601:ac0f:820:e814:e33:9bb4:dad3])
        by smtp.gmail.com with ESMTPSA id i8sm1794843ilj.1.2020.11.06.13.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 13:44:47 -0800 (PST)
Date:   Fri, 6 Nov 2020 15:44:46 -0600
From:   Seth Forshee <seth.forshee@canonical.com>
To:     Ed W <lists@wildgooses.com>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [wireless-regdb] Correction of wireless-regdb for GB
Message-ID: <20201106214446.GG6125@ubuntu-x1>
References: <4d07581c-a3be-a3c6-bf32-7007eb45d541@wildgooses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4d07581c-a3be-a3c6-bf32-7007eb45d541@wildgooses.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sorry for not responding sooner. I had started to look into this when
you sent the message, but I had to set it aside and then forgot to pick
it back up.

On Thu, Jul 02, 2020 at 08:50:41PM +0100, Ed W wrote:
> Hi, I think that the wireless regdb for GB domain can be corrected:
> 
> According to Ofcom, in 2017 the rules were updated for the 5725-5850Ghz
> range to allow a power output of 200mW (the max power output is much higher
> still for fixed wireless where a £50 licence is purchased)
> 
> Reference to the latest Ofcom document is here (IR-2030):
> 
> https://www.ofcom.org.uk/__data/assets/pdf_file/0028/84970/ir-2030.pdf
> 
> 
> My reading of this is that DFS is currently required and I *assume* also the
> wmm would be the same as the rest of the range. I'm not sure if this rule
> needs an AUTO-BW?

AUTO-BW doesn't make sense here, however it does look like the 5470 -
5725 rule could be expanded to 5730 to allow channel 144 to be used.

I agree that it looks like DFS is required, and also TPC which will
require us to use 100 mW as the max EIRP. Afaik the wmmrule doesn't
apply to the 5.8 GHz band, so I think that isn't required.

I'll send out a patch soon with these updates.

Thanks,
Seth

> (Note also that Ofcom opened a proposal to remove the DFS requirement on
> this frequency band (and to add new 5Ghz bands). Results of this are due
> later in 2020.)
> 
> 
> Therefore I think that the db.txt should say:
> 
> 
> |
> 
> country GB: DFS-ETSI
> ...
> 
> 	# Reference (IR-2030)
> 	(5725 - 5875 @ 80), (200 mW), DFS, AUTO-BW, wmmrule=ETSI
> 
> |
> 
> |Could someone appropriate please check this and update upstream.|
> 
> |
> |
> 
> |Thanks|
> 
> |Ed W
> |
> 
> ||
> 
> 
> _______________________________________________
> wireless-regdb mailing list
> wireless-regdb@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/wireless-regdb
