Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 068D736ACA3
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Apr 2021 09:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbhDZHGy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 26 Apr 2021 03:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbhDZHGx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 26 Apr 2021 03:06:53 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94FCC061761
        for <linux-wireless@vger.kernel.org>; Mon, 26 Apr 2021 00:06:11 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id c4so15671370wrt.8
        for <linux-wireless@vger.kernel.org>; Mon, 26 Apr 2021 00:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=5RuHvbrZHVloxRo7eENq0ZIryQnDTJP0ete42G83Dm0=;
        b=rIb8+v2FAdA/HfhwuFQ6R8dphR1T0XKcem+hDmiyp8QJyiWsUG/VegWao1LxxolHOc
         ctEIXLn6mFraIjAcGx8exbmzWC852dgXWwKnm3td7C06aBOHnlsNlS160CFJsN2ch7Vj
         HWWjhQbqWx0x6IG9wItFTZ7CFHUw87oc7fyqNSc+/s7ZHgo7JuV9fKzCZn674JYEsCX6
         +JY2w1OdFXrf2gQXf6S9eNPX7nVE/EMMHAlAlr+3OXLCHkZjMdIqHV0Zr7RTiOc+GI+a
         gWafVirCtDjutoLU7lw5+fWllx0HFwPneUNauWgJcEPM4s8PQEDUE5Fz8Ws+QQ5hE5Rh
         LJag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=5RuHvbrZHVloxRo7eENq0ZIryQnDTJP0ete42G83Dm0=;
        b=kgj8r8n2/sV6eHdweVoXegToRgwaTqL0hNupsBHjZC4OLzj91SBetNdWmyj2NnniM3
         owzBW6ET6s5+Xyc5fCnkpl2xwK0ZUcBX5YnSlDropDpuSTsi1JJL2motSEhluER3Ta1F
         +RnaIZbHn7fBZ+IKFMKEZ4ZU3PfFZC5brBhpp1WiRum70pvkrqt6odH8TrlMQC4rUuBf
         qCKTwQ8IMcnDVnXtNJlLRo8Of9PJBXtbGhsuWtFq8/oyT3qW67kpj/p9QaHP8rXCkTLh
         OnJWq1d4TMfhB/FG7BXlBZ7qTGCWeVrXPWZl4Kn3z9/NKI08tz2uVCTG6oAywW6zuqLt
         h67w==
X-Gm-Message-State: AOAM533XXnHuTkDDjP8vmssX5m3T9K12NpPOqokOaPT1r+L44WgZ29Z9
        6/IY5Emik5xvlynRep9yLb1W9g==
X-Google-Smtp-Source: ABdhPJxQA11AMLyg/X551pHlVu8f4n+OUBOFc1FV8/qEkPz+6JKC49mgf31rgbpUC8pVKrxLOFj9Lw==
X-Received: by 2002:a5d:4402:: with SMTP id z2mr20396301wrq.179.1619420770263;
        Mon, 26 Apr 2021 00:06:10 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id 200sm16751584wmb.1.2021.04.26.00.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 00:06:09 -0700 (PDT)
Date:   Mon, 26 Apr 2021 08:06:07 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kalle Valo <kvalo@codeaurora.org>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        Timur Tabi <timur@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-serial@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH] firmware: replace HOTPLUG with UEVENT in FW_ACTION
 defines
Message-ID: <20210426070607.GG6446@dell>
References: <20210425020024.28057-1-shawn.guo@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210425020024.28057-1-shawn.guo@linaro.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, 25 Apr 2021, Shawn Guo wrote:

> With commit 312c004d36ce ("[PATCH] driver core: replace "hotplug" by
> "uevent"") already in the tree over a decade, update the name of
> FW_ACTION defines to follow semantics, and reflect what the defines are
> really meant for, i.e. whether or not generate user space event.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  drivers/dma/imx-sdma.c                      |  2 +-
>  drivers/media/platform/exynos4-is/fimc-is.c |  2 +-

>  drivers/mfd/iqs62x.c                        |  2 +-

Acked-by: Lee Jones <lee.jones@linaro.org>

>  drivers/misc/lattice-ecp3-config.c          |  2 +-
>  drivers/net/wireless/ti/wlcore/main.c       |  2 +-
>  drivers/platform/x86/dell/dell_rbu.c        |  2 +-
>  drivers/remoteproc/remoteproc_core.c        |  2 +-
>  drivers/scsi/lpfc/lpfc_init.c               |  2 +-
>  drivers/tty/serial/ucc_uart.c               |  2 +-
>  include/linux/firmware.h                    |  4 ++--
>  lib/test_firmware.c                         | 10 +++++-----
>  sound/soc/codecs/wm8958-dsp2.c              |  6 +++---
>  12 files changed, 19 insertions(+), 19 deletions(-)

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
