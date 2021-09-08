Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69BD14033FA
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Sep 2021 07:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347633AbhIHF5r (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Sep 2021 01:57:47 -0400
Received: from gw2.atmark-techno.com ([35.74.137.57]:34036 "EHLO
        gw2.atmark-techno.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233916AbhIHF5q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Sep 2021 01:57:46 -0400
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
        by gw2.atmark-techno.com (Postfix) with ESMTPS id 74D9B20D6A
        for <linux-wireless@vger.kernel.org>; Wed,  8 Sep 2021 14:56:37 +0900 (JST)
Received: by mail-pj1-f72.google.com with SMTP id mm23-20020a17090b359700b00185945eae0eso744315pjb.3
        for <linux-wireless@vger.kernel.org>; Tue, 07 Sep 2021 22:56:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=16Ef+9qt4mcc8tLdQbgm9Zrucoq1zFP1w6xO9x2EyR8=;
        b=FAuS8WaU2mcwI3rQqJ5emlAS0HQmEjTUVzkRfiu/MExfz+W0Ln5Hsb9ew6ewX3kHtO
         f8rTk6MSnsDGPg5787wSTQj6FYt9BrQWf8TcubK+gbwUKzq3PQhbGDJTtQCLKfUojax2
         7bk9SzbYX2DjtGVxzkqB01A+Lgdho1cbUHb7+Ri+bKyxZabJfahQTpQScj13JJDVVkp/
         GVcBti+cmC8vk5428C27u+A/1Lw2iUzb07tcACKwKUilMaehme2S71acqV1tgC6rusvr
         tVp4nqPsul82TiYJ88wV2bhM/ij7S3thdEDgRmIqOudsbqCqHJVIjmcsiDOz/S665OzV
         oBUA==
X-Gm-Message-State: AOAM532FAA7HROAJDzPcalR4+WD20/UHHrTp5jNNY2a9/aMyXlA9Fn0Y
        U46YgJchmXxZJ+FfaW29E+NaM9Dlw93aNDyeP/ucCieoFWCZGYRXVO/cwcbpsB2eGX0+4Q5FJTf
        eixBHY3upbm4hcgCQjoc7Ieqy1MGl
X-Received: by 2002:a62:2fc1:0:b0:3f5:176f:67c8 with SMTP id v184-20020a622fc1000000b003f5176f67c8mr1949255pfv.17.1631080596483;
        Tue, 07 Sep 2021 22:56:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzn5G9NGH5IwIxpTFTylngnI0aD4LeWMOrPFS5WIk5+YNNbuTs7V0L1Z4oasH+TfJgEnW+T8w==
X-Received: by 2002:a62:2fc1:0:b0:3f5:176f:67c8 with SMTP id v184-20020a622fc1000000b003f5176f67c8mr1949239pfv.17.1631080596299;
        Tue, 07 Sep 2021 22:56:36 -0700 (PDT)
Received: from pc-0115 (178.101.200.35.bc.googleusercontent.com. [35.200.101.178])
        by smtp.gmail.com with ESMTPSA id n1sm891261pfv.209.2021.09.07.22.56.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Sep 2021 22:56:36 -0700 (PDT)
Received: from martinet by pc-0115 with local (Exim 4.94.2)
        (envelope-from <martinet@pc-0115>)
        id 1mNqZW-00EPgo-Q3; Wed, 08 Sep 2021 14:56:34 +0900
Date:   Wed, 8 Sep 2021 14:56:24 +0900
From:   Dominique MARTINET <dominique.martinet@atmark-techno.com>
To:     Sharvari Harisangam <sharvari.harisangam@nxp.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Jonas =?utf-8?Q?Dre=C3=9Fler?= <verdre@v0yd.nl>,
        Takashi Iwai <tiwai@suse.de>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        Lee Jones <lee.jones@linaro.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Xinming Hu <huxinming820@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>
Subject: Re: [EXT] Re: mwifiex cmd timeout on one pci variant
Message-ID: <YThQiMn7YHzPRwnJ@atmark-techno.com>
References: <YTg/f5mHQ6jjHDt6@atmark-techno.com>
 <YThLznrMQ4EYUDEl@atmark-techno.com>
 <AM0PR04MB4529E0C28F43288E189D8F50FCD49@AM0PR04MB4529.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AM0PR04MB4529E0C28F43288E189D8F50FCD49@AM0PR04MB4529.eurprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sharvari Harisangam wrote on Wed, Sep 08, 2021 at 05:45:53AM +0000:
> Use firmware from https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/mrvl
> for mwifiex driver.

Thanks, that's the first firmware I was using; it's currently at
16.68.1.p179 which is why I'm surprised Jonas said the latest would be
15.68.19.p21.

I think it's just a different variant of the driver now though,
a binary grep matches 15.68.19.p21 for pcie8897_uapsta.bin but I my
driver loads pcieuart8997_combo_v4.bin
I hadn't noticed the first number didn't match, but that likely confirms
it.

Sorry for the noise on firmware version, I'm still interested in
understanding why the command timeouts.
-- 
Dominique Martinet
