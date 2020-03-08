Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B28F17D42F
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Mar 2020 15:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgCHO3H (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 8 Mar 2020 10:29:07 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:33670 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbgCHO3H (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 8 Mar 2020 10:29:07 -0400
Received: by mail-wr1-f44.google.com with SMTP id a25so4066673wrd.0
        for <linux-wireless@vger.kernel.org>; Sun, 08 Mar 2020 07:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LGCJ5Fv9cMVy5gUfr0I8ksC/X/tEsiH1YY8JTBHu1sY=;
        b=lXZPalEslWW34ITNJgFKGGnM8dFE+TCoH2fiVjYyJR+D1gbKmKKQNfDvK/joaERSk9
         W9kayzUz1YNyecheHjFnV1pnuawAeK1ZxwvOkXE3/Q7Svo/RGPJj6azQ+Qwnb3ze/QlB
         mm4j1w3CA1D3ogHEvFMsiH05ghctGkQ6BzMVnw9MxujE6d0qICA+aMgaS2C3n5DQbYxV
         4CwCcgVxIH3f6ZwNMWErY2Bb3pxS+7xvKreQxX6SBp+EEz80jHeopg3AcAPJegS9QAAc
         /ZM52RgzFm0DGlaRBahm5Z4F7n94tT2OSedJ024as60MV74oADlQPSwPr4PXXTkYlZGk
         LgVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LGCJ5Fv9cMVy5gUfr0I8ksC/X/tEsiH1YY8JTBHu1sY=;
        b=A26fluxCwvSu1n96W6+046hfyaDKE1+SVW/ECwe1dOxuwYyH3zJJqi86I0Uh6oF1WJ
         unGdXhicQwQ+yhUhxA5YIGuQ3IZlYjE3JTrZwcf1MVF3O2lkTXnVXmKEfbTrRyJgDBS5
         xkrE36OaqUN5qXm/KMHjRFAIgCHyN3QdEGCeO/6YYj7qH4yELVCGW/ZGa283KirabS6k
         P757szJ+AiVv1hJvO4XpVs5Z71DmJBGflq2elMq5TCnuzVSvKRaRSQkLUP5ApHB1r0MP
         6r6j4uqxNvXaCfyzHOPu0cdv8c7qTus6alaTFOGTmR6ZP4FwT4LpYpKIXf58WbsIiPQ3
         WyuA==
X-Gm-Message-State: ANhLgQ13YI7e6CdXZ3qyk/I7W1OR7aPFBA7r8t9RCFLZtOdXk+7WlH1i
        kcdEBoUSK7WyfWYqCjP1b+I=
X-Google-Smtp-Source: ADFU+vuQPjsrj0zPnuo1mCBYgobXqx+ZS44jD1HI0iTtJFqSeHZA3d70u8sAbcLIo3Hxf0V2ejOZnw==
X-Received: by 2002:adf:8b1b:: with SMTP id n27mr15720073wra.324.1583677745303;
        Sun, 08 Mar 2020 07:29:05 -0700 (PDT)
Received: from t2b3 ([109.175.104.3])
        by smtp.gmail.com with ESMTPSA id q1sm15571036wrx.19.2020.03.08.07.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2020 07:29:04 -0700 (PDT)
Date:   Sun, 8 Mar 2020 15:29:03 +0100
From:   Tobias Predel <tobias.predel@gmail.com>
To:     yhchuang@realtek.com, Bjoern Franke <bjo@schafweide.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        linux-wireless@vger.kernel.org
Subject: Re: [rtw88] Linux 5.6-rc1 / RTL8822BE WiFi adapter
Message-ID: <20200308142903.GA8798@t2b3>
References: <20200214214134.GA12764@t2b3>
 <c76d37cc-2cab-a8f2-e570-a444c06ad020@schafweide.org>
 <028ea5d3-1459-b37e-f996-72958be0ff4c@lwfinger.net>
 <dcd22888-4a60-59f4-3a8e-0b1a49b1e922@schafweide.org>
 <20200218094514.GA13937@t2b3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218094514.GA13937@t2b3>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

well, now I get troubles back with Network controller: 
Realtek Semiconductor Co., Ltd. RTL8822BE 802.11a/b/g/n/ac WiFi adapter,
still on 5.6.0-rc2-next-20200217.

Using HP ProBook 430 g5, connected to 802.11n/g AP in 2.4 GHz band.

Are there any *other* firmware files for testing or update?

I get a lot of timed out to flush queue 1 and
firmware failed to restore hardware setting together with poor performance,
100 kbps and so on. Not a router issue, because tethering with smartphone 
works fine (800 kbps).

So this might be a firmware issue?

Kind regards,
Tobias

On Tue, Feb 18, 2020 at 10:45:14AM +0100, Tobias Predel wrote:
> Hi,
> 
> I withdraw my issue. Linux-next has been working well so far.
> 
> Regards
> Tobias
> 
> On Sun, Feb 16, 2020 at 02:40:17PM +0100, Bjoern Franke wrote:
> > Hi Larry,
> > 
> > > I deliberately stay behind the official kernel repo so as to avoid implementing
> > > any regressions. As you are the one with the problem, you need to perform a
> > > bisection to discover which change to rtw88 introduces your difficulty!!
> > 
> > Somebody commented the DKMS-package for your rtw88-branch with
> > 
> > "Thank you so much for this ! After kernel 5.5, that's the only way i can
> > get functional wifi on my machine. (RTL8822BE) Deeply appreciate it."
> > 
> > So I assume I'm not the only one experiencing this issue.
> > 
> > But I can do a bisect if I find some time.
> > 
> > Regards
> > Bjoern
> > 
> > [1]https://aur.archlinux.org/packages/rtlwifi_new-rtw88-dkms/
> 
> -- 
> Bitte denken Sie an die Umwelt, bevor Sie diese E-Mail ausdrucken.

-- 
Bitte denken Sie an die Umwelt, bevor Sie diese E-Mail ausdrucken.
