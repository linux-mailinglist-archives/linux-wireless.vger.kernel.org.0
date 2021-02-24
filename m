Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7EB324210
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Feb 2021 17:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbhBXQ01 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Feb 2021 11:26:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhBXQ0V (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Feb 2021 11:26:21 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0B8C061786
        for <linux-wireless@vger.kernel.org>; Wed, 24 Feb 2021 08:25:38 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id p16so2602162ioj.4
        for <linux-wireless@vger.kernel.org>; Wed, 24 Feb 2021 08:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=egauge.net; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=XBZb3NOyhlFWcNuiP+wxMUI7RR1RqjN6kdHLdFUqKKo=;
        b=dT5fk5IbR5BW7OfLqlvQgOlYIQRJr3SMTXJCKB0cCPxw316A67t8NrIgJ3ZNps08Bh
         kA4bQ+f8NLKa6hNfFmJlPYS/K+bd08KJz8lzvE/KSfP3K42/5EOL7osDC5wAES8Yszk2
         bC7Ncss5iJwvCxlKtWISFLf+8SyJrS6tkt/hR63didV5+q+7VsaD7DubzlQb5rXT2pKr
         GcN2ovoQmlrHontx+zRxzA0VWBJA9f/ZBxmXfvRI1Xc0SG6GkM7DbfirgDpWarEVqsQK
         jYPhW//XcK65tnGHGDfJ8I67oqV+u2jdQX/XPVk0E29TwzwypP89DQONHVaIDxlXe+QB
         +8Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=XBZb3NOyhlFWcNuiP+wxMUI7RR1RqjN6kdHLdFUqKKo=;
        b=eswmkLK5/BWkStfolG4sg4UEaiL5KKq1KDTHvNdRTNNP0iiY0lBtzB8URZYkHUQ53L
         5bUzsRU52GpL/sBgPpGnWT1FQzjz/7ljqxwbbEyQqb9Rw42CdIsxZIiiK6eU0I+tzeGX
         LT9XrY92B1miTAuxUqxIIf/8D+465sK9LHDZGZ2P8ZHLSBwkOUU6WHI6bDp2z1fzQ9+/
         yHATyFzUNtBi6PT2ldlwG84FFeECTDijvfS5zrhWwOl/s+emJqLYSRtFkGHkpp5ufqxh
         aJpDE234Ux7xc65dY4d9cluIESuHNru0VUyq4cASz8cSv5tWtEbJcfNekiNnfjuTeBRk
         sXFA==
X-Gm-Message-State: AOAM531BjSTlIju2LOjXlQUSpdqXN1x2AEmg66iEzrvIUV9ZfsO5ZDjF
        f3+YhfAsA3b5TV+UZKP4+GJgkKLsnJ3xFyE=
X-Google-Smtp-Source: ABdhPJyQfFfxb9wkBJ5hrZ7uG9xsnKBga3ehjKLQ9kwombe5E4FDiiPfZTzoNb60c55oRx6J2qYw+g==
X-Received: by 2002:a05:6638:3803:: with SMTP id i3mr33059493jav.26.1614183938032;
        Wed, 24 Feb 2021 08:25:38 -0800 (PST)
Received: from ?IPv6:2601:281:8300:4e0:15e9:5454:c5f7:acb0? ([2601:281:8300:4e0:15e9:5454:c5f7:acb0])
        by smtp.gmail.com with ESMTPSA id o131sm1807076ila.5.2021.02.24.08.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 08:25:37 -0800 (PST)
Message-ID: <de208903375a13c31717c668f83e71b3f0f9d6f5.camel@egauge.net>
Subject: Re: [PATCH 4/4] wilc1000: Add support for enabling CRC
From:   David Mosberger-Tang <davidm@egauge.net>
To:     Ajay.Kathat@microchip.com, linux-wireless@vger.kernel.org
Cc:     Claudiu.Beznea@microchip.com
Date:   Wed, 24 Feb 2021 09:25:36 -0700
In-Reply-To: <f58ec951-4ab4-2ed4-78d4-96ebb448f494@microchip.com>
References: <20210224055135.1509200-1-davidm@egauge.net>
         <20210224055135.1509200-4-davidm@egauge.net>
         <f58ec951-4ab4-2ed4-78d4-96ebb448f494@microchip.com>
Organization: eGauge Systems LLC
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2021-02-24 at 10:01 +0000, Ajay.Kathat@microchip.com wrote:

> This patch series also looks okay to me. I just have one input which is
> captured below.
> 
> We need to disable both crc7 and crc16 while retrying on failure attempt
> by adding below line
> 
> spi_priv->crc16_enabled = false;

Ah, you're right.  We can always probe with CRC16 off since the chip
returns valid register data regardless of whether crc16_enabled is
true or false.  I'm thinking something like this:

	spi_priv->crc16_enabled = false; // ignore CRC16 during CRC-
detection
	for (crc7 = 1; crc7 >= 0; --crc7) {
		spi_priv->crc7_enabled = crc7;
		ret = spi_internal_read(wilc, WILC_SPI_PROTOCOL_OFFSET,
&reg);
		if (ret == 0)
			break;
	}
	if (ret) {
		dev_err(&spi->dev, "Failed with all possible CRC
settings.\n");
		return ret;
	}

> By default the CRC checks are disabled, so if the kernel module is
> reloaded it should reattempt with both disabled.

Are you sure about that?  My test devices resets into:

 PROTOCOL_REG = 0x2e

which should be CRC7 and CRC16 on, right?

  --david

