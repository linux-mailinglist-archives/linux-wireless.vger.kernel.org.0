Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 835AC322EA8
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Feb 2021 17:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233576AbhBWQXt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Feb 2021 11:23:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233312AbhBWQXr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Feb 2021 11:23:47 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485D9C061574
        for <linux-wireless@vger.kernel.org>; Tue, 23 Feb 2021 08:23:07 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id d15so9497022ioe.4
        for <linux-wireless@vger.kernel.org>; Tue, 23 Feb 2021 08:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=egauge.net; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:organization
         :user-agent:mime-version:content-transfer-encoding;
        bh=axrZ+5f+Ljg2I1jFNtFrhR+FtsGgjoHDQe9rWTmrf5Y=;
        b=ARscB98O0s0zQKv3HJPWzzfIWf5TTjk06k7TirNbc52LlULLtncA2t67reVdYgpaKO
         1ARQdEOl9pEgWnu1FwT4fcNGRgAz/3tvIaLMC3fFiUBS8Lf9IYZ9RbUV2IFxl7N+oLQx
         uG9LppQ68NA/cemuZtQeYtg8JMqffTmmVtesOHzl5r8xQLW8AJlTxtwgGyCYbsqObpWC
         IOEl/ILani6EgtjIogtyN4ohNkMsM/BCCQjy2nyrbU5H1n6Oqq0n+XN5Gu4dq976hJfT
         5ZOWAFw1Nzcmuf9fcXSsC1ROYooidGACmJPxwa0j33sGPMJ3wFDrZc5CfZigRou7qLMU
         Eh5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=axrZ+5f+Ljg2I1jFNtFrhR+FtsGgjoHDQe9rWTmrf5Y=;
        b=Kcb2XTwwLUF1aceWDiw1a5FqvJrN4g1NJPCmGQxyB9WZd3BFwF7udylUwTLrRAUyhn
         Tgbsnud73HNLdu/VZNnAbqQowpgQjIDdYjVib6g8vw7xg0aKp/rUGgUWqq2QjBdpzKtw
         xOHiBOSFCp0p4m0tDjpPVwZifwQHlE3/eHm2Hzg3S1rnJwON3nds8CymiBVAfDh61Tle
         pOwu8vdzKE+Uh8dDdtALQIh0Rstfkg2SXyXlSLwa0sBnx84z0WU0vH+Q41dkdsQ36FVs
         B2Foeu0QwpvjxW44RsB/fMXsZIVCVqRQAaXlOd9luv4NWIIb4QT/RdPUXTIDBeDl7/uq
         I8bQ==
X-Gm-Message-State: AOAM531zEe12yM2YBOWlHFVqtJRNVjzxguSfyQsBnBwZUN1YEo8YDkiK
        dhxdNIVgu17p15ZpKqE7uF1IeoP6AGxumCI=
X-Google-Smtp-Source: ABdhPJysrdmx/qs98eZBaBrycYs4GRqE3JWw8iq0Zp3Sedo/nDcWtWCHKTgRKIlhbfpq1TjeUaq+mw==
X-Received: by 2002:a5e:8a48:: with SMTP id o8mr12722704iom.89.1614097386545;
        Tue, 23 Feb 2021 08:23:06 -0800 (PST)
Received: from ?IPv6:2601:281:8300:4e0:cc6b:9049:f16e:2f39? ([2601:281:8300:4e0:cc6b:9049:f16e:2f39])
        by smtp.gmail.com with ESMTPSA id s9sm15462084ilt.77.2021.02.23.08.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 08:23:05 -0800 (PST)
Message-ID: <5fc9c8ad5d93e2172f03515f8275851af285a895.camel@egauge.net>
Subject: Re: wilc1000 driver
From:   David Mosberger-Tang <davidm@egauge.net>
To:     Ajay.Kathat@microchip.com, linux-wireless@vger.kernel.org
Date:   Tue, 23 Feb 2021 09:23:04 -0700
In-Reply-To: <f3e0540462ed8bcc59787f71e3b1b258945a6142.camel@egauge.net>
References: <e8ed97f214f6087b7ac59298c8efe2d1144f7d55.camel@egauge.net>
         <eb6c6b39-f168-7237-d220-585f99532fd9@microchip.com>
         <f3e0540462ed8bcc59787f71e3b1b258945a6142.camel@egauge.net>
Organization: eGauge Systems LLC
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

OK, the problem below is caused by wilc_set_power_mgmt().  If I change
that function into a no-op, the driver actually works!  Does this make
any sense to you?  From what I saw so far, it looks like relevant code
is pretty much identical to the one in the linux-at91 tree and that one
works fine.

  --david


On Mon, 2021-02-22 at 18:49 -0700, David Mosberger-Tang wrote:
> 
> Now the driver loads the firmware and generally seems to be happy.
> However, as soon as a packet is received, things go awry.  I'm seeing
> this:
> 
> WILC_SPI spi1.0 wlan0: ChipID [1003a0] loading firmware
> [atmel/wilc1000_wifi_firmware-1.bin]
> WILC_SPI spi1.0: Failed cmd response, cmd (ca), resp (09)
> 
> On the SPI bus, I see these commands:
> 
>  MOSI: 0xC8 0x00 0x00 0x00 0x00 0x00 0x38 (DMA_EXT_READ addr 0 size 56)
>  MISO: 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0xC8 0x88 (command response)
>  -----
>  MOSI: 0x00
>  MISO: 0xF3 (DATA header, last packet in this transaction)
>  -----
>  MOSI: 0x00*56
>  MISO:   xx*56 (56 data bytes that may be a legitimate packet)
> 
> So far so good.  I don't know if this matters, but the last 8 bytes of
> data all contain 0x09.
> 
> The problem from then on is that no matter what command is sent, the
> chip always returns only 0x09 bytes.  For example, the first command
> after the DMA read is:
> 
>  MOSI: 0xca 0x00 0x10 0x6c (SINGLE_READ)
> 
> but the MISO line only returns 0x09, hence the above "Failed cmd
> response" error.
> 
> It's as if the chip wants to send much more than 56 data bytes.  The
> byte-order for the DMA size matches that of the working driver though,
> so maybe that's not it.



