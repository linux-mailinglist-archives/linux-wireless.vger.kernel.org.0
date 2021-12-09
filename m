Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D891146F4AE
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Dec 2021 21:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbhLIUMj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Dec 2021 15:12:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbhLIUMi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Dec 2021 15:12:38 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C56C061746
        for <linux-wireless@vger.kernel.org>; Thu,  9 Dec 2021 12:09:04 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id m9so8109734iop.0
        for <linux-wireless@vger.kernel.org>; Thu, 09 Dec 2021 12:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=egauge.net; s=google;
        h=message-id:subject:from:to:cc:in-reply-to:references:organization
         :mime-version:date:user-agent:content-transfer-encoding;
        bh=zmSBXN2/YunKNrGUqzY771sP7Ckl/JfQzYkdgbgUyw0=;
        b=ckWL9nbSUylf8ZTvp1cOfqtMQb4Rit9dq5OfjH9zQNfeXvkFcwzKeQwOr0wITAvkIo
         Y15qPmcWsJjYN/3yHclxXPAEmBtl5xyTusxhCEvqd/tpL+miPNDXIOSzHnL5jOxZeFyZ
         KetGK+OY5l6SOHFrIPNexAtDFFVVsDFHBX6KEDwqHOEEQEDtnH/s4i7fcKfUXTVSePTO
         cXP5FlNsDbkOTTu36Cx1hUXuM6TX53zucAes5H58l9vpour0yLOjsXpNneFveprxOh2s
         fhYGhyI3zA+eGL9cCwMwpNl/0M0vsTD+GXAG0p+Yw5kveHE9Pz4j8IlBTUawuxT5Zg/J
         GTiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:organization:mime-version:date:user-agent
         :content-transfer-encoding;
        bh=zmSBXN2/YunKNrGUqzY771sP7Ckl/JfQzYkdgbgUyw0=;
        b=oTHmx/hIzmn9GYiG6fsdfuUvoQfDGg0x3a3BE8taABswn7YOsKSKNGdzqH1gxH8qez
         h+eXkSymt+HlZNeUhuF+0a//soh63yl8aPOpL2EnRBGY0Oq5oFwIewwDefWneXdzn5OC
         Chvv8LumTgMUnfc3BAjUqwaJJyFqLwj89gN7xLVUA9Y+CgDbshgLjsE3hR56Usuz4JS7
         l7KN0IcrL54sL4WCiaqzPTxHX1EzU7VHl7dAne0iY1bp93oqRfp7Td7Df1OW5+zUppcB
         UYoryBunn8fjyH5U0tKGk0z3S5s4tnaxj4Wq1xl4sQK2PDVbAHkGbNeF2DMEy4d09tgD
         GECg==
X-Gm-Message-State: AOAM531qjp+G1YcSyYbajcYFwSvlfth15dBl0gUtEZsuRwwoeMqZ4SXo
        BTtDn/UUFlwdZr/PSGZ7KxzZzbMScBlo2bk=
X-Google-Smtp-Source: ABdhPJxlUE4lOlea/ZLpFQnQsYl2qpjwKXkk5OEX9rP2wOf1DX/GZOuOXtp7UAzQKsl2IpL6ets1LQ==
X-Received: by 2002:a6b:8bc2:: with SMTP id n185mr17020516iod.174.1639080543081;
        Thu, 09 Dec 2021 12:09:03 -0800 (PST)
Received: from bixby (c-73-181-115-211.hsd1.co.comcast.net. [73.181.115.211])
        by smtp.gmail.com with ESMTPSA id i1sm588760iov.10.2021.12.09.12.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 12:09:02 -0800 (PST)
Message-ID: <ea0cd2faee9ff61c2e822f4df37d6a9ce59dd3f0.camel@egauge.net>
Subject: Re: RFC: wilc1000 module parameter to disable chip sleep
From:   David Mosberger-Tang <davidm@egauge.net>
To:     Ajay.Kathat@microchip.com
Cc:     Claudiu.Beznea@microchip.com, linux-wireless@vger.kernel.org
In-Reply-To: <dcbbd9fce1f12393c5e2cd1271c60507a8475bc6.camel@egauge.net>
References: <0baed35e98144bc7e29681264caf954b659cd481.camel@egauge.net>
         <4bf158ac-18d0-6feb-fbef-dc0739d74487@microchip.com>
         <a03e133e46ff305dbad796913b79c994c91581d5.camel@egauge.net>
         <efee7360e8be88d58251e38c848637c8163bdf19.camel@egauge.net>
         <dcbbd9fce1f12393c5e2cd1271c60507a8475bc6.camel@egauge.net>
Organization: eGauge Systems LLC
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Date:   Thu, 09 Dec 2021 13:08:04 -0700
User-Agent: Evolution 3.36.5-0ubuntu1 
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I took linux-wireless off the CC list...

On Thu, 2021-12-09 at 12:28 -0700, David Mosberger-Tang wrote:
> On Thu, 2021-12-09 at 12:12 -0700, David Mosberger-Tang wrote:
> > On Thu, 2021-12-09 at 11:15 -0700, David Mosberger-Tang wrote:
> > 
> > As far as I can see, chip_wakeup() can trigger this legitimately:
> > 
> > 		do {
> > 			h->hif_read_reg(wilc, WILC_SPI_WAKEUP_REG, &reg);
> > 			h->hif_write_reg(wilc, WILC_SPI_WAKEUP_REG,
> > 					 reg | WILC_SPI_WAKEUP_BIT);
> > 			h->hif_write_reg(wilc, WILC_SPI_WAKEUP_REG,
> > 					 reg & ~WILC_SPI_WAKEUP_BIT);
> > 
> > 			do {
> > 				usleep_range(2000, 2500);
> > 				wilc_get_chipid(wilc, true);
> > 			} while (wilc_get_chipid(wilc, true) == 0);
> > 		} while (wilc_get_chipid(wilc, true) == 0);
> > 
> > Actually, the above looks rather gross.  wilc_get_chip() reads both WILC_CHIPID
> > and WILC_RF_REVISION_ID and we do this at least three times in a row on each
> > chip_wakeup().  Wow.  Is this really necessary?
> 
> Looks like I'm on to something.  If I replace the gross code with:
> 
> 		h->hif_read_reg(wilc, WILC_SPI_WAKEUP_REG, &reg);
> 		h->hif_write_reg(wilc, WILC_SPI_WAKEUP_REG, reg | WILC_SPI_WAKEUP_BIT);
> 		h->hif_write_reg(wilc, WILC_SPI_WAKEUP_REG, reg & ~WILC_SPI_WAKEUP_BIT);
> 
> 		while (1) {
> 			if (wilc->hif_func->hif_read_reg(wilc, WILC_CHIPID, &chipid) == 0)
> 				break;
> 			usleep_range(2000, 2500);
> 		}
> 
> Look what happens to TX throughput:
> 
> [  4]   0.00-120.00 sec   142 MBytes  9.92 Mbits/sec    6             sender
> 
> This is with power_save mode turned on.  Almost exactly 3 times faster than the
> 3.33 Mbits/sec I was seeing before.

Over 120 seconds of iperf3, a histogram of the number of WILC_CHIPID reads
required to get a successful read looked like this:

[  493.918785] hist[  0]=70417
[  493.921609] hist[  1]=0
[  493.923997] hist[  2]=0
[  493.926424] hist[  3]=0
[  493.928957] hist[  4]=0
[  493.931359] hist[  5]=0
[  493.933781] hist[  6]=0
[  493.936210] hist[  7]=0
[  493.938702] hist[  8]=0
[  493.941097] hist[  9]=0
[  493.943523] hist[ 10]=0
[  493.945951] hist[ 11]=0
[  493.948418] hist[ 12]=0
[  493.950812] hist[ 13]=0
[  493.953238] hist[ 14]=0
[  493.955667] hist[ 15]=0
[  493.958126] hist[ 16]=0
[  493.960527] hist[ 17]=0
[  493.962954] hist[ 18]=1
[  493.965382] hist[ 19]=7
[  493.967840] hist[ 20]=1
[  493.970242] hist[ 21]=13

Based on this, I changed the above code to:

		while (1) {
			h->hif_read_reg(wilc, WILC_SPI_WAKEUP_REG, &reg);
			h->hif_write_reg(wilc, WILC_SPI_WAKEUP_REG,
					 reg | WILC_SPI_WAKEUP_BIT);
			h->hif_write_reg(wilc, WILC_SPI_WAKEUP_REG,
					 reg & ~WILC_SPI_WAKEUP_BIT);

			if (wilc->hif_func->hif_read_reg(wilc, WILC_CHIPID, &chipid) == 0)
				break;
			usleep_range(2000, 2500);
		}

This gets me:

   TX/PSM off: [  4]   0.00-120.00 sec   198 MBytes  13.8 Mbits/sec    9             sender
   TX/PSM on : [  4]   0.00-120.00 sec   140 MBytes  9.78 Mbits/sec    9             sender
   RX/PSM off: [  5]   0.00-120.10 sec   304 MBytes  21.2 Mbits/sec                  receiver
   RX/PSM on : [  5]   0.00-120.11 sec   288 MBytes  20.1 Mbits/sec                  receive

Ajay, I'm guessing your kernel is either configured for tickless timer or
HZ=1000?  That would explain why you'd see higher throughput with the original
code.  My system is configured for HZ=100, so the usleep_range() would typically
take 10ms.

Any objections to the latest code?

  --david



