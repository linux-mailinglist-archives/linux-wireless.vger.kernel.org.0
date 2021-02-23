Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E06B3323050
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Feb 2021 19:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233133AbhBWSKO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Feb 2021 13:10:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233083AbhBWSKN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Feb 2021 13:10:13 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254DFC061574
        for <linux-wireless@vger.kernel.org>; Tue, 23 Feb 2021 10:09:33 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id g9so14976740ilc.3
        for <linux-wireless@vger.kernel.org>; Tue, 23 Feb 2021 10:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=egauge.net; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=dXxYSj4cSlUVhqPcnLZ1myGNF0PaGDZKljNa/HlXsd4=;
        b=cEb3QbVOTWmqnImtILKwqUxSIw9IwXuVHtIUX2ExWcQ/Xu5a1nPo70OHreajOSJHYL
         6adkyWa/k3IyIzDdxT2t9fT/K8CIpaP/10xYhCXzIcXSsEeyVfhvE6FENyQVgXhf3xoy
         lAa5FaRKZByPsWM/4ywQ4IAQ/cghYzArwZK2AW9lSkrYHJ0nqDVJJEmGVF2DpiLGPCDd
         RZP2TEoEqVThmCFMf+1cDypd5IXVuXjUH1Y2gdV2q4x5zDvFxXHjuggPMnuVNtIkkaAs
         d4xtItf56nxC9dDA1yDk+O8vpbZyYOxO7rnAtCvcgLy1VtlDmV76aP+eRa9maJTbc424
         r51w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=dXxYSj4cSlUVhqPcnLZ1myGNF0PaGDZKljNa/HlXsd4=;
        b=ETZ2LXizhA8rYUNQiKq65xZjLyMdAkqWgSLvl5jAQSI6i4m0rqifmhoHIZsOhlk5wC
         Hor+9KOvl/rf1uX10alOnl8Tsp6mbxstOudcgtbJ5BlQEmdYNBBXDn/ucItsj+18b6pg
         kLGZpXnsfVSzL0sUry4CxL01nG423fuluTCrlHeqpFu7HBGRt7Cn+wKuLsI5gVLx4Hoe
         0q81ZDVtoDjbZFXxYYv5XaiqS3KRof3PHr/9PAm8efIt3mhkD/gMsaMtLyvE9DLtPcIX
         cWrrBGCswJzUGXdDP7xzpeAjRuujULkw2LzjmpsB2gz6aoRm5rw7MTBaDlf236Qocklv
         PEtg==
X-Gm-Message-State: AOAM533HZ8KWDB2satPxwiS/BSWm0ErFTMmwFRIlEcz23Vm/opTxUxcV
        EQzH/7tX9oRSqGrHY1BqHbTJ
X-Google-Smtp-Source: ABdhPJy6lPYWee4m7r36wZA69veaOTroxSbfHYXbv131zUu16rvepLvJGXn6pww3/AsKnYDF3/KLSA==
X-Received: by 2002:a92:dd82:: with SMTP id g2mr20692329iln.194.1614103772472;
        Tue, 23 Feb 2021 10:09:32 -0800 (PST)
Received: from ?IPv6:2601:281:8300:4e0:cc6b:9049:f16e:2f39? ([2601:281:8300:4e0:cc6b:9049:f16e:2f39])
        by smtp.gmail.com with ESMTPSA id a17sm16027832ilp.63.2021.02.23.10.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 10:09:31 -0800 (PST)
Message-ID: <5459ee3e0798c7a8a3b060befca5a37c75ae29b3.camel@egauge.net>
Subject: Re: wilc1000 driver
From:   David Mosberger-Tang <davidm@egauge.net>
To:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ajay.Kathat@microchip.com, linux-wireless@vger.kernel.org
Cc:     Claudiu Beznea <Claudiu.Beznea@microchip.com>
Date:   Tue, 23 Feb 2021 11:09:31 -0700
In-Reply-To: <b7074cf6-0075-6081-cb72-e97e17a0c6d7@microchip.com>
References: <e8ed97f214f6087b7ac59298c8efe2d1144f7d55.camel@egauge.net>
         <eb6c6b39-f168-7237-d220-585f99532fd9@microchip.com>
         <f3e0540462ed8bcc59787f71e3b1b258945a6142.camel@egauge.net>
         <5fc9c8ad5d93e2172f03515f8275851af285a895.camel@egauge.net>
         <b7074cf6-0075-6081-cb72-e97e17a0c6d7@microchip.com>
Organization: eGauge Systems LLC
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Nicolas,

On Tue, 2021-02-23 at 18:58 +0100, Nicolas Ferre wrote:
> Hi David,
> 
> On 23/02/2021 at 17:23, David Mosberger-Tang wrote:
> > OK, the problem below is caused by wilc_set_power_mgmt().  If I change
> > that function into a no-op, the driver actually works!  Does this make
> > any sense to you?  From what I saw so far, it looks like relevant code
> > is pretty much identical to the one in the linux-at91 tree and that one
> > works fine.
> 
> One thing that comes off the top of my head is that we use 
> power-sequencing drivers in the Linux4SAM trees. The use of pwrseq 
> drivers allow us to adapt the power/sequencing/delays/reset to the 
> actual board the wilc1000 but moreover the wilc3000 is soldered to.
> Indeed the wilc3000 needs special sequence to be up'n running if some 
> clock signals are connected to the SoC output for instance.
> 
> You can have an example of a pwrseq driver here:
> drivers/mmc/core/pwrseq_wilc.c
> (https://github.com/linux4sam/linux-at91/blob/master/drivers/mmc/core/pwrseq_wilc.c). 
> There are other pwrseq drivers for other WiFi chips and boards there.
> 
> True thing is that this sequencing seems dedicated to mmc sub-system and 
> I don't know if it can be used for SPI-based WiFi connections or if 
> another mechanism exists.

Ah, *that's* where the RESET pins are hiding.  Yeah, it wouldn't have
occurred to me to like in the MMC subsystem, but I see there is a
precedent for another WiFi chip using that place.  OK, I things are
starting to make sense and I should be able to work on the actual
patches I've been meaning to submit.

Thanks for the help!

  --david

