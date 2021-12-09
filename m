Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF2F46F3AD
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Dec 2021 20:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbhLITPl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Dec 2021 14:15:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhLITPl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Dec 2021 14:15:41 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE29C061746
        for <linux-wireless@vger.kernel.org>; Thu,  9 Dec 2021 11:12:07 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id z18so7837273iof.5
        for <linux-wireless@vger.kernel.org>; Thu, 09 Dec 2021 11:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=egauge.net; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=ZrxHaaAYmAMpwmJhOrJaTXgv0i1E7p5aJjXvKcoo2A4=;
        b=QJZE6/MFczgSBacJpXYenG2q+3nW+/7g7P8WjHC5P4DtZuSDxywEkDCorBIITKvDW8
         HLvHHH85vqph0fL4nRO8jDuqdI8WabpyAjpDnnYkwarMNf7XNjuJEYH26q/VElDQX8qi
         Ubxtf6yi57Idi5rIVY8GodY8EysF+hvTF7r/ueESz0VOuAq/8D0/mf5abkcU6vHi4A4E
         l63eYQZXHVw+g9USSfocAf2YvgHuSHeZZtO3IgS3eroRfmZVB39I1/bCYe5AiMWPTb2i
         AEaxmN/o2Uci/TD684PGS/Q1boRS+Fha+BmpyCOAth9zmOBPhMciVGIpQPSbcf2Uas/h
         wlGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=ZrxHaaAYmAMpwmJhOrJaTXgv0i1E7p5aJjXvKcoo2A4=;
        b=Fqj3cPZq+rrqJLj17N9nQRIRNwpL8M3+VaZ8S4jsaa98C04DV6dDLcMA+wkfvMOYEK
         juVheNZMnPVSX+TwWBh25N7Zgqa0yqgE/IU9hm/Tui0adyFwwMtK0G8EWHr5V/D0J82F
         oiKL0WstgBpBbEyjM/ZZNA5hKu/Tu/7Zs5kQU0t6MCVXxBDB7LYZ5HTvoxe1gamsdhmf
         G2CqjPWjKoKJ7SAxr0/sRiz28AX9j9ah+PXsFKBvYYJxSYm7WFMb7D8Wj5hjVmL7mO3u
         SgHj7AkceVIZap5YGw0/csu7W27F6zIpTYmHYZh6rz6KswhgJtwFXp5AG6+u7hhQG+3w
         T+iA==
X-Gm-Message-State: AOAM531ljHs5hyCGJHKB4K3yymPECmPIsq9ZAgl5cU0RAmReBdFjdp6+
        n64yDbswMkTB1roPLQl4PDRm
X-Google-Smtp-Source: ABdhPJxBGZnMbQw1TkprpCSxgARoq2xVXPy2PWd3RIr7IZxUdFhO65gw3LubfDJYXqEaOeE8cWMo2g==
X-Received: by 2002:a02:c6c5:: with SMTP id r5mr11958392jan.110.1639077126104;
        Thu, 09 Dec 2021 11:12:06 -0800 (PST)
Received: from bixby.lan (c-73-181-115-211.hsd1.co.comcast.net. [73.181.115.211])
        by smtp.gmail.com with ESMTPSA id e25sm327430ioc.43.2021.12.09.11.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 11:12:05 -0800 (PST)
Message-ID: <efee7360e8be88d58251e38c848637c8163bdf19.camel@egauge.net>
Subject: Re: RFC: wilc1000 module parameter to disable chip sleep
From:   David Mosberger-Tang <davidm@egauge.net>
To:     Ajay.Kathat@microchip.com
Cc:     Claudiu.Beznea@microchip.com, linux-wireless@vger.kernel.org
Date:   Thu, 09 Dec 2021 12:12:04 -0700
In-Reply-To: <a03e133e46ff305dbad796913b79c994c91581d5.camel@egauge.net>
References: <0baed35e98144bc7e29681264caf954b659cd481.camel@egauge.net>
         <4bf158ac-18d0-6feb-fbef-dc0739d74487@microchip.com>
         <a03e133e46ff305dbad796913b79c994c91581d5.camel@egauge.net>
Organization: eGauge Systems LLC
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2021-12-09 at 11:15 -0700, David Mosberger-Tang wrote:

> > Did you test by enabling the power-save mode with "wpa_supplicant" or 
> > using "iw" command. For power consumption measurement, please try by 
> > disabling the PSM mode.
> 
> No, I have not played with power-saving mode.  There are some disconcerting
> messages when turning PSM on:
> 
> [ 1764.070375] wilc1000_spi spi1.0: Failed cmd, cmd (ca), resp (00)
> [ 1764.076403] wilc1000_spi spi1.0: Failed cmd, read reg (000013f4)...

As far as I can see, chip_wakeup() can trigger this legitimately:

		do {
			h->hif_read_reg(wilc, WILC_SPI_WAKEUP_REG, &reg);
			h->hif_write_reg(wilc, WILC_SPI_WAKEUP_REG,
					 reg | WILC_SPI_WAKEUP_BIT);
			h->hif_write_reg(wilc, WILC_SPI_WAKEUP_REG,
					 reg & ~WILC_SPI_WAKEUP_BIT);

			do {
				usleep_range(2000, 2500);
				wilc_get_chipid(wilc, true);
			} while (wilc_get_chipid(wilc, true) == 0);
		} while (wilc_get_chipid(wilc, true) == 0);

Actually, the above looks rather gross.  wilc_get_chip() reads both WILC_CHIPID
and WILC_RF_REVISION_ID and we do this at least three times in a row on each
chip_wakeup().  Wow.  Is this really necessary?

In any case, for now, the below supresses the error messages:

diff --git a/drivers/net/wireless/microchip/wilc1000/spi.c b/drivers/net/wireless/microchip/wilc1000/spi.c
index b778284247f7..516787aa4a23 100644
--- a/drivers/net/wireless/microchip/wilc1000/spi.c
+++ b/drivers/net/wireless/microchip/wilc1000/spi.c
@@ -498,7 +498,7 @@ static int wilc_spi_single_read(struct wilc *wilc, u8 cmd, u32 adr, void *b,
 	r = (struct wilc_spi_rsp_data *)&rb[cmd_len];
 	if (r->rsp_cmd_type != cmd) {
 		if (!spi_priv->probing_crc)
-			dev_err(&spi->dev,
+			dev_dbg(&spi->dev,
 				"Failed cmd, cmd (%02x), resp (%02x)\n",
 				cmd, r->rsp_cmd_type);
 		return -EINVAL;
@@ -754,7 +754,8 @@ static int wilc_spi_read_reg(struct wilc *wilc, u32 addr, u32 *data)
 
 	result = wilc_spi_single_read(wilc, cmd, addr, data, clockless);
 	if (result) {
-		dev_err(&spi->dev, "Failed cmd, read reg (%08x)...\n", addr);
+		/* Register reads may fail legitimately, e.g., during chip_wakeup(). */
+		dev_dbg(&spi->dev, "Failed cmd, read reg (%08x)...\n", addr);
 		return result;
 	}
 

Maybe a parameter should be added to hif_read_reg() to indicate whether failure is an option?

  --david


