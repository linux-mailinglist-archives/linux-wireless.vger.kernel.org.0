Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E58B5108AD0
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2019 10:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbfKYJ1I (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Nov 2019 04:27:08 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52195 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbfKYJ1I (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Nov 2019 04:27:08 -0500
Received: by mail-wm1-f68.google.com with SMTP id g206so14329535wme.1
        for <linux-wireless@vger.kernel.org>; Mon, 25 Nov 2019 01:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GPEnZNQEI8QKSUnH82DWjy/DOlQPOIbDIUbMCpH13uc=;
        b=OOA0opZBwLH1JTUMyzqDx7FpKLojjoTy9X8fiOzRNOUWulU66lRwhIvTVGOuHvcxBl
         i/K1roaWlbflWdjCp7QQe6ijp6djt7dCmenW/J0ANIQKISO97fqvVaNTvCwg0lhWJ6dw
         rsMNCoR0PoOqpI8TWhuGSd5fiwceT33EZlFXNVJ4hGOCwK7rZNWheXzjcX69rWSqnJzj
         pYty3+YuzE/DHBIIypzKck8vwiwffrmFxLjHGH0FGMbSukhgjzqeXKpj8c+yAaQ/aa9o
         YJA70p3Q5Gq4FexTAP0jF3HKgrzvuV8v5qaM7oVAinr7H04qfxHUuPq4/Wxs6NfnA7IR
         aU9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GPEnZNQEI8QKSUnH82DWjy/DOlQPOIbDIUbMCpH13uc=;
        b=kyAXcndRn6XpBvNKBbaP23M7L679ZkJU88MDcaCg88bapMRHTZH9KjsDlmqIyP8m4W
         8sBXr3d4H5oaCPM/ueao2MzcS/JZVdMhN+mMehWNRBibi5WE1Sc9EVrdliTBlwitgyhS
         HZLky9j9INkKZ/T5M6RmgRWWJ7UvSBakaL99cTjcXc+J/UH6xnJmUqEwBy4CPVbADEGx
         8VLPHtMmd3ESb60LCl8seQgo9g60ryFwicaT72UgEBzoWmFM2g1MFjCNtP7+7Lx7RU2m
         o/XsbEO8qq16WRSUKeSFAMsCVDF/lFoTwzFl2vAqs9BuWHJLrZWOToTeV/pJU12vGOQj
         KPCg==
X-Gm-Message-State: APjAAAV7EHMzsXPp6dPuzOwjcmP1i7rN2pXsD0tvh4u5+R4RUR8LLtqZ
        JAWShMUm8Jd/D9oFSUmHJy3CfI7m8iXU+VfJTg0=
X-Google-Smtp-Source: APXvYqxzdo3Q5FMwIo3FbQht8mabp2Hsamcv3s8jm+BuubQR5plKLDThjkZYoeVig7g/1dob+nT2rjG4fWtkPMX7IRI=
X-Received: by 2002:a05:600c:228c:: with SMTP id 12mr20671074wmf.154.1574674026240;
 Mon, 25 Nov 2019 01:27:06 -0800 (PST)
MIME-Version: 1.0
References: <20191122205153.30723-1-adham.abozaeid@microchip.com>
In-Reply-To: <20191122205153.30723-1-adham.abozaeid@microchip.com>
From:   Julian Calaby <julian.calaby@gmail.com>
Date:   Mon, 25 Nov 2019 20:26:55 +1100
Message-ID: <CAGRGNgV=zW8xpgHfj99m9LHN=dtUBH_36_kQSnnBOrd_6WpDoA@mail.gmail.com>
Subject: Re: [PATCH 1/4] staging: wilc1000: use runtime configuration for sdio
 oob interrupt
To:     Adham Abozaeid <Adham.Abozaeid@microchip.com>
Cc:     linux-wireless@vger.kernel.org, devel@driverdev.osuosl.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Ajay Singh <Ajay.Kathat@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Adham,

On Sat, Nov 23, 2019 at 7:55 AM <Adham.Abozaeid@microchip.com> wrote:
>
> From: Ajay Singh <ajay.kathat@microchip.com>
>
> Set SDIO Out-of-band interrupt configuration at run time by passing
> parameter during module load.

The OOB interrupt is a GPIO and this is an SDIO card, so why not just
set the relevant pin in the devicetree and detect it based on that?

I'm pretty sure that the Broadcom fmac driver does something like this.

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
