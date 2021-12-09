Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5906A46F3F0
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Dec 2021 20:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbhLITbu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Dec 2021 14:31:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhLITbt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Dec 2021 14:31:49 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4805BC061746
        for <linux-wireless@vger.kernel.org>; Thu,  9 Dec 2021 11:28:15 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id a11so6359657ilj.6
        for <linux-wireless@vger.kernel.org>; Thu, 09 Dec 2021 11:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=egauge.net; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=12YUwrSj1PqnQilYz/13K5JT1svwUqEZqcnYHxBXGew=;
        b=pnqEJlF2e1pimA+drtOpQRVBFJFMUpt1sCiq+BVFodV9ZNaw0dvrgfgQGLmcPlgB0n
         q6kyscLAfkThC8PwOH2WGJZoSI3aS4au2QZ4H9Ssz7qCLbZsdT5GYuourc03Z10SsLKl
         zRwEw1Yfjc/0eq6BgDJAZN6iYlkw4r3eEzFiMlOexk6JarbAwMaZAdLq0d7ZqnqGyUpJ
         /VtvFB2Hxnbvn88JBv3tt6i0aeVifhyLq/0Q9brvoSiDqxdEeUmkPJbleY/7pUdiFJQy
         P/HGUj3e6FOfTX3aIKJuikS1amBQjdLV0QsycxSU+Yg/DVP2wTatK1A+jzE7VbS83r7H
         E0SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=12YUwrSj1PqnQilYz/13K5JT1svwUqEZqcnYHxBXGew=;
        b=jtY0RwBZ3mUJ80GmPLJNF/m6sapuYAHBkBc5urfUYwAxzAIY+09SOG0oEovIGL+TCY
         GECAJsULz0FW3oiKoeXU3wbRpFXZl5akAFOxF0YUpBhZ4RzdWlEQkMaTwY1nqyuR/CyT
         0JQTrRzNS85k10ryqJMwM5ptjObCY78RmYhoIAhyfyzuHhC/1sotYIemDqiAUb+zsI2S
         E3srOzzom6s/P5jDZYmY1sqiEsU50Jk8mp8aJokVj0Hq7ffPoPfyOlpl/+JG395UvCp/
         TBOGI1BkMdTADSC91BEdI4fjliiKdZTORZoB5aJ1cAGjK/vIhunzfoXavk5DQKZUCAPz
         2NqQ==
X-Gm-Message-State: AOAM533R6ysGrc65rtxEKNMpMz7f5KLCFcSme91NjnylEoytzPddnzqk
        SEBxwiK1GuW6e6/E4tz0B0H7
X-Google-Smtp-Source: ABdhPJzq1dw4J8J7D57YvBdwwCJWqBalvnbpf8jwXuBLOB4vzYvswXR25S4/Sn/7SFLL/dPPJRnX/g==
X-Received: by 2002:a05:6e02:1c88:: with SMTP id w8mr16996162ill.318.1639078094547;
        Thu, 09 Dec 2021 11:28:14 -0800 (PST)
Received: from bixby.lan (c-73-181-115-211.hsd1.co.comcast.net. [73.181.115.211])
        by smtp.gmail.com with ESMTPSA id k10sm438376ilu.80.2021.12.09.11.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 11:28:13 -0800 (PST)
Message-ID: <dcbbd9fce1f12393c5e2cd1271c60507a8475bc6.camel@egauge.net>
Subject: Re: RFC: wilc1000 module parameter to disable chip sleep
From:   David Mosberger-Tang <davidm@egauge.net>
To:     Ajay.Kathat@microchip.com
Cc:     Claudiu.Beznea@microchip.com, linux-wireless@vger.kernel.org
Date:   Thu, 09 Dec 2021 12:28:11 -0700
In-Reply-To: <efee7360e8be88d58251e38c848637c8163bdf19.camel@egauge.net>
References: <0baed35e98144bc7e29681264caf954b659cd481.camel@egauge.net>
         <4bf158ac-18d0-6feb-fbef-dc0739d74487@microchip.com>
         <a03e133e46ff305dbad796913b79c994c91581d5.camel@egauge.net>
         <efee7360e8be88d58251e38c848637c8163bdf19.camel@egauge.net>
Organization: eGauge Systems LLC
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2021-12-09 at 12:12 -0700, David Mosberger-Tang wrote:
> On Thu, 2021-12-09 at 11:15 -0700, David Mosberger-Tang wrote:
> 
> > > Did you test by enabling the power-save mode with "wpa_supplicant" or 
> > > using "iw" command. For power consumption measurement, please try by 
> > > disabling the PSM mode.
> > 
> > No, I have not played with power-saving mode.  There are some disconcerting
> > messages when turning PSM on:
> > 
> > [ 1764.070375] wilc1000_spi spi1.0: Failed cmd, cmd (ca), resp (00)
> > [ 1764.076403] wilc1000_spi spi1.0: Failed cmd, read reg (000013f4)...
> 
> As far as I can see, chip_wakeup() can trigger this legitimately:
> 
> 		do {
> 			h->hif_read_reg(wilc, WILC_SPI_WAKEUP_REG, &reg);
> 			h->hif_write_reg(wilc, WILC_SPI_WAKEUP_REG,
> 					 reg | WILC_SPI_WAKEUP_BIT);
> 			h->hif_write_reg(wilc, WILC_SPI_WAKEUP_REG,
> 					 reg & ~WILC_SPI_WAKEUP_BIT);
> 
> 			do {
> 				usleep_range(2000, 2500);
> 				wilc_get_chipid(wilc, true);
> 			} while (wilc_get_chipid(wilc, true) == 0);
> 		} while (wilc_get_chipid(wilc, true) == 0);
> 
> Actually, the above looks rather gross.  wilc_get_chip() reads both WILC_CHIPID
> and WILC_RF_REVISION_ID and we do this at least three times in a row on each
> chip_wakeup().  Wow.  Is this really necessary?

Looks like I'm on to something.  If I replace the gross code with:

		h->hif_read_reg(wilc, WILC_SPI_WAKEUP_REG, &reg);
		h->hif_write_reg(wilc, WILC_SPI_WAKEUP_REG, reg | WILC_SPI_WAKEUP_BIT);
		h->hif_write_reg(wilc, WILC_SPI_WAKEUP_REG, reg & ~WILC_SPI_WAKEUP_BIT);

		while (1) {
			if (wilc->hif_func->hif_read_reg(wilc, WILC_CHIPID, &chipid) == 0)
				break;
			usleep_range(2000, 2500);
		}

Look what happens to TX throughput:

[  4]   0.00-120.00 sec   142 MBytes  9.92 Mbits/sec    6             sender

This is with power_save mode turned on.  Almost exactly 3 times faster than the
3.33 Mbits/sec I was seeing before.

  --david


