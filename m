Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B14DE890E
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2019 14:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732534AbfJ2NI6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Oct 2019 09:08:58 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39312 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728735AbfJ2NI6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Oct 2019 09:08:58 -0400
Received: from mail-yb1-f197.google.com ([209.85.219.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <seth.forshee@canonical.com>)
        id 1iPRF2-0000ZG-6r
        for linux-wireless@vger.kernel.org; Tue, 29 Oct 2019 13:08:56 +0000
Received: by mail-yb1-f197.google.com with SMTP id w69so10492710ybe.18
        for <linux-wireless@vger.kernel.org>; Tue, 29 Oct 2019 06:08:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ynxqVtdsqhywDBe6wAHrwjnabrfK53FCpzKt+2e+JE4=;
        b=auV95qD+7vghphQj3lP1dR3EY4YeGO5JdtW7Ubv//y8HHXFgR+Lv33dzGULQmkr+61
         LoVYXjyaM1EzRfH2iBqT0B88VczbFqEn1+hztc9/1yJeUQmGz/Zb9XXCWMmXOaV5mQf8
         mfCfc9WhF7GKCJqEXkpQTjr2mLY1sozwK0gJbVgMhyzraVFEtnG8Uls6p6uclIxchEqj
         prO2KT2bw3PqCc3a2VD2KxEFzzWl3cX0f+29a4V4qgHga2WDK18GDP6AKW1ZAA9UYreO
         9qQ3tH7Q9bpvjmHG4OCoAmLzFd0RaiHyChU2VBbkpxDSx4XIRI8zyEc7R4Z4st0ye90j
         wUig==
X-Gm-Message-State: APjAAAWLJvbExH9Io9Ge+3D27iGRZ8sg+xwfGfW/qRCl+1zjOz7axGnQ
        Q5Dl+FfIrDqm7K03Abpe+yOgEBnPvVYYlkBX92QCmb1NiVB7LRZivGocSlQ8yReLIF8bD57lKri
        vvYx7y89myPghcASWZG82jibg9ayUEGoxaL2AJgltUdFW
X-Received: by 2002:a81:ab42:: with SMTP id d2mr16395655ywk.370.1572354535253;
        Tue, 29 Oct 2019 06:08:55 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx/F6r/epETralitde1F17o8erCsCTrVKtZRQHYbBFii8Dmenid/q3z3w3fNP6k1RKrBnLH8A==
X-Received: by 2002:a81:ab42:: with SMTP id d2mr16395627ywk.370.1572354534920;
        Tue, 29 Oct 2019 06:08:54 -0700 (PDT)
Received: from localhost ([2605:a601:ac3:9720:f461:b9b9:429:65bd])
        by smtp.gmail.com with ESMTPSA id k67sm635653ywa.71.2019.10.29.06.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 06:08:54 -0700 (PDT)
Date:   Tue, 29 Oct 2019 08:08:53 -0500
From:   Seth Forshee <seth.forshee@canonical.com>
To:     Emil Petersky <emil.petersky@streamunlimited.com>
Cc:     linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Subject: Re: [PATCH] wireless-regdb: Create entry for united European region
Message-ID: <20191029130853.GN30813@ubuntu-xps13>
References: <bf327181-521b-e1ce-c5c8-81b828fc65b6@streamunlimited.com>
 <20190907235636.GA8256@ubuntu-xps13>
 <a5bdfce7-e974-37bb-c1d1-956d4572703c@streamunlimited.com>
 <39933518-6a65-fab3-4a66-8f44fc319d57@streamunlimited.com>
 <76f464e9-8806-ecbf-2dc8-67bb4190ecc7@streamunlimited.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <76f464e9-8806-ecbf-2dc8-67bb4190ecc7@streamunlimited.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Sep 17, 2019 at 11:55:07AM +0200, Emil Petersky wrote:
> Create entry for united European region, as usage of frequency bands
> is harmonized over EU and almost all CEPT countries as well.
> 
> All EU countries and almost all CEPT countries accepted decisions
> 2005/513/EC (5GHz RLAN, EN 301 893)
> and 2006/771/EC (amended by 2008/432/EC, Short-Range Devices, EN 300 440)
>  EU decision 2005/513/EC:
> https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02005D0513-20070213
>  EU decision 2006/771/EC:
> https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02008D0432-20080611
> Harmonized CEPT countries:
> https://www.ecodocdb.dk/download/25c41779-cd6e/Rec7003e.pdf
> Such decision make sense to create united European region (EU) in regdb
> 
> United region for EU in regdb will enable much easier handling of proper
> wlan parameters on embedded devices sold across the Europe.

I'm a little curious about this one. I do agree that it would simplify
things, but is an EU contry code something standard that wireless APs
generally will advertise, or that clients will understand?

And we do still have all the individual countries to maintain. Maybe it
would make sense to define an EU region as rules that countries could
inherit, and then have rules for any deviations from the common EU
rules. Thoughts?

Thanks,
Seth
