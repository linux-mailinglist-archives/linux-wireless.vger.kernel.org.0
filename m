Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0BD465F648
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jan 2023 22:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236176AbjAEVzE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Jan 2023 16:55:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236149AbjAEVzA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Jan 2023 16:55:00 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1EF567BDD
        for <linux-wireless@vger.kernel.org>; Thu,  5 Jan 2023 13:54:54 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id x11so15668103ljh.12
        for <linux-wireless@vger.kernel.org>; Thu, 05 Jan 2023 13:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0H9VgDunViPVm0c06yXB3KlkmbUAVMrT7+ES0UJHmWc=;
        b=h7bTmNasTe8rhvHS84E6BpqSYiixrTRoilH4qSYJ8Os01IOxHG1GTFgNewoNQwDzdB
         X+rfUUnJnJowuvBukL7jY5yHKbjlSng40DodU4pDmAT6cT6XOxShYnaxVe4SURL1Iys+
         cbC0YvlJt/oag36lbtbQb4BrHAyqsg2Lpd8gJ4V2M9cUUi+R5SE66gtZUVMSVnPQi/Dn
         agxOGOU+OTQzeaL3VhIoYLjRjPNTf1xtW/gGvMqKnyQ5fYyDUNkQTplZnYkICxaNsbFr
         W2WsSzVWXtjFBjpV8+Svm/k2jvcXEgy4riWl6ud+vVlwl3gcs3zGT9ok0vC/LDFAWr72
         EuVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0H9VgDunViPVm0c06yXB3KlkmbUAVMrT7+ES0UJHmWc=;
        b=Kekssp6Eue2jaqKHbS1w14xE6HlfEVN2tB2dFMUCiL12ggQqV2pEmYIdBUwI/gDGyq
         76NVR1fIsSy8i2gOrsEmiG7QCIdAYM+OW/a4TL6f7upeqG4OcyotIS6tlZl/gqaMFiAk
         4XYzMZhKMejtl831zkRVR+sv3v9Eb3gpuvhfgbRstulef+Zk2nrFZJli30Ng+ZznMMXw
         d7R3OccIaYb8ml2bCTFuV9/8Nz3BgidjpG+SBC9hiDavawn7QRgkYb6htg1xr7bT4tQH
         tZpKDGm7BfEel6z1hd4w4nakpYIARN/h+isaGHlBRJ15YGDg0K5zpLxkPGYErk7J/cye
         rtdg==
X-Gm-Message-State: AFqh2kpZ2uMeJTP97lAy9ToBd7iSRlImJ66cc0ZG1uaE/4/Lo6FzulRC
        qjimgkvPsyjeCgAEJRNW5+JkLQ==
X-Google-Smtp-Source: AMrXdXug7mzvYB003Vy5Xw7LB0g5ckikyWB7YaXdSgBlzWZvACXOY1j5xtLffmAXq+H0n8M/440SOQ==
X-Received: by 2002:a05:651c:168e:b0:281:878:292 with SMTP id bd14-20020a05651c168e00b0028108780292mr1563604ljb.52.1672955693090;
        Thu, 05 Jan 2023 13:54:53 -0800 (PST)
Received: from Fecusia.lan (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id p13-20020a2eb98d000000b0027fb9e64bd0sm3471719ljp.86.2023.01.05.13.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 13:54:52 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Arend van Spriel <arend.vanspriel@broadcom.com>
Cc:     linux-firmware@kernel.org, linux-wireless@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>,
        Stefan Hansson <newbyte@disroot.org>
Subject: Re: [PATCH 0/8] brcm: add firmware files for brcmfmac driver
Date:   Thu,  5 Jan 2023 22:54:51 +0100
Message-Id: <20230105215451.135111-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221207230556.383935-1-arend.vanspriel@broadcom.com>
References: <20221207230556.383935-1-arend.vanspriel@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Arend,

thanks for this long due update! I have tested the BCM4330 SDIO
firmware on the Samsung Janice (GT-I9070) and it works like a
charm!

I notice the absence of a new BCM4334 firmware, could you send
that too, if you have a latest-and-greatest? Some people have
problems with wireless on the Skomer (GT-S7710) and maybe a
proper firmware would solve it.

Thanks,
Linus Walleij
