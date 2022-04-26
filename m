Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17BE0510C13
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Apr 2022 00:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355860AbiDZWh2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Apr 2022 18:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241713AbiDZWh1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Apr 2022 18:37:27 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C60D1331A6
        for <linux-wireless@vger.kernel.org>; Tue, 26 Apr 2022 15:34:15 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 88-20020a9d0ee1000000b005d0ae4e126fso14057582otj.5
        for <linux-wireless@vger.kernel.org>; Tue, 26 Apr 2022 15:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QOVruyTRY05/IB4dGodf9j5s8WkZhLYEMF1zPjhJnqU=;
        b=FJgqu7tUhGTf4pp2slwvkEMS7a5eJjGcvKCLSIztNY+14AkXepqJ0SqpdNBcZky/WX
         Fb90MZZxHTxzXlynFw3KyoxfOqTufkEYeGoGRNzqOyKWVxYAUerSB1pA3QZMrJsotXdQ
         YjIu5S4xHw9lauMzCV2DA+LrVZzjomjl/ywhc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QOVruyTRY05/IB4dGodf9j5s8WkZhLYEMF1zPjhJnqU=;
        b=7LFeoMr4Hv7UwScMD7hZL0HhSsrAggz4EQO7/mW9gT1PUqSB3TNJ5Xh3iMESQhcuot
         k6UH6kbQXPYlr6cImFYYDy0LW+kZPR9W8bgCdLkaXDtnAKNvT01lg+50uKNdDoD6x8bc
         yXG951bwcmIS57+385O73GdR4Pn5pzFXy8XlWNzYdRUSKHVqfVFK9DvyywN0NZmWE/aj
         itDVaO+P5zDfzifmM4j1rR5l0uhDgasud8qYcN5hMvGqEiUlrp61L3zmy9IPt2Ieq+I2
         tLdxbFhwdWjoKzEYFeNFRCakEQ8fbq2kYvHhOGgA0eWHFK7KAjHrnIN3WQ3NQW+jVkib
         3DtA==
X-Gm-Message-State: AOAM533kfTfHdmeBbH1DB1Ij/ObXpOzEZ0n133rF+f/8lNPqtMwe2I6B
        Bnqx1U6cl2gSekybsqhWgloG6yatNq/1mA==
X-Google-Smtp-Source: ABdhPJyVwAXLQ2/+7YL9daGTsl8FYiPsXPTMYghPs6moxgIRX613FACSMSCh4opp2yk8XzYnFgG/HQ==
X-Received: by 2002:a05:6830:2a13:b0:600:f4ef:751c with SMTP id y19-20020a0568302a1300b00600f4ef751cmr9262001otu.173.1651012454538;
        Tue, 26 Apr 2022 15:34:14 -0700 (PDT)
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com. [209.85.160.52])
        by smtp.gmail.com with ESMTPSA id i28-20020a9d4a9c000000b005ce06a77de2sm5620926otf.48.2022.04.26.15.34.13
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 15:34:13 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-e922e68b0fso186319fac.1
        for <linux-wireless@vger.kernel.org>; Tue, 26 Apr 2022 15:34:13 -0700 (PDT)
X-Received: by 2002:a05:6870:4201:b0:e6:47c4:e104 with SMTP id
 u1-20020a056870420100b000e647c4e104mr14046899oac.257.1651012453086; Tue, 26
 Apr 2022 15:34:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220426221859.v2.1.I650b809482e1af8d0156ed88b5dc2677a0711d46@changeid>
In-Reply-To: <20220426221859.v2.1.I650b809482e1af8d0156ed88b5dc2677a0711d46@changeid>
From:   Brian Norris <briannorris@chromium.org>
Date:   Tue, 26 Apr 2022 15:34:02 -0700
X-Gmail-Original-Message-ID: <CA+ASDXPNFwvYVBMHjbTNQ-uTnQrs5TvPAH2jXgPKuFLUw2GbZA@mail.gmail.com>
Message-ID: <CA+ASDXPNFwvYVBMHjbTNQ-uTnQrs5TvPAH2jXgPKuFLUw2GbZA@mail.gmail.com>
Subject: Re: [PATCH v2] ath10k: skip ath10k_halt during suspend for driver
 state RESTARTING
To:     Abhishek Kumar <kuabhs@chromium.org>
Cc:     kvalo@kernel.org, quic_wgong@quicinc.com,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        ath10k <ath10k@lists.infradead.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Apr 26, 2022 at 3:20 PM Abhishek Kumar <kuabhs@chromium.org> wrote:
>
> Double free crash is observed when FW recovery(caused by wmi
> timeout/crash) is followed by immediate suspend event. The FW recovery
> is triggered by ath10k_core_restart() which calls driver clean up via
> ath10k_halt(). When the suspend event occurs between the FW recovery,
> the restart worker thread is put into frozen state until suspend completes.
> The suspend event triggers ath10k_stop() which again triggers ath10k_halt()
> The double invocation of ath10k_halt() causes ath10k_htt_rx_free() to be
> called twice(Note: ath10k_htt_rx_alloc was not called by restart worker
> thread because of its frozen state), causing the crash.
...
> Tested-on: QCA6174 hw3.2 PCI WLAN.RM.4.4.1-00288-QCARMSWPZ-1
> Co-developed-by: Wen Gong <quic_wgong@quicinc.com>
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Signed-off-by: Abhishek Kumar <kuabhs@chromium.org>
> ---
>
> Changes in v2:
> - Fixed typo, replaced ath11k by ath10k in the comments.
> - Adjusted the position of my S-O-B tag.
> - Added the Tested-on tag.

You could have retained my:

Reviewed-by: Brian Norris <briannorris@chromium.org>

but no worries; it's just a few characters ;)
