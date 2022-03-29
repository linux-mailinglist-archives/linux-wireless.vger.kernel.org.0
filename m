Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D9E4EAC1B
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Mar 2022 13:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235658AbiC2LVY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Mar 2022 07:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233731AbiC2LVX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Mar 2022 07:21:23 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB4D56C17
        for <linux-wireless@vger.kernel.org>; Tue, 29 Mar 2022 04:19:40 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id h1so20317675edj.1
        for <linux-wireless@vger.kernel.org>; Tue, 29 Mar 2022 04:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uygd4Y21vFPgFtGjF66QK3tzxXRqwd+Noy3a22cMjxg=;
        b=LHuBGkFabiQuSIu8pIp3+M1/WgpKMjruvF/Mbjtl+Pe+DdhIJ2IJk97RtywrZ3rVXh
         wg6SBGT8cwkcFY/mlbIsxDCbAV5M1Ho/3UkuBNGIb4hMe02ZY+mUXr2afJ99mlzbxWjy
         yV6RQ1k4cDPvvh6g1hp/JFCKyKt1HjzPERcKpRA4p9ozaU3p78LEM+J3qJlxyw4XN5oF
         ANftue55UKiVhteJ77Y3812V7laVh6eQKXFcIKEX3+639gz0r3extL/DtL5CsGl+nacf
         qYTf9lcZ3U+YlwdvSs7kMj8T0SJgxIDUTziHi1nYUP+j8ejJStBSllxIls4/30+KVQwm
         RQHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uygd4Y21vFPgFtGjF66QK3tzxXRqwd+Noy3a22cMjxg=;
        b=Z4sYJ7OVYwNEoVQpVzvrxjaIs2nUXYRRaH2PXMKeOfgE/07METIWfUh4ZV/XVcbFth
         8BiMtCczcv4cZsCDQGGQI5uTE0LiVLxqy3X5fS0qMY1Lur8hkYFipunqA7B1VZafab7y
         TJZ+hqX3tNQXFYf3QPCwDeSWOJRcszyrONewqqx3sTQ8RV6dQwewRkG8G17TakCqUQ08
         NnyN7emI6iSNY7TPnG6Oulj4c3nhYw+XNZHZb10eaxVVTki+nxz6uAUZiMl4xLuu+jGp
         ssrn0H/9O0QebtDqm0kRB1MEjxHhHmV8Vqv0vwZ6lR1/iczj7xKEfPnivdDQFjmVlesK
         3usg==
X-Gm-Message-State: AOAM531pCXhHVaVUBFlsmxqMkcypYT67WM6HileTOVN/mKsaWpEVShoG
        aFh4opkf+9R+Ff3j2Gs9Gg1dMi2YP0r9bgozwdsuu4vuN+8=
X-Google-Smtp-Source: ABdhPJyld05IdK+yUkoCHMPnFFv+zBo1LS4CBuZFHgbSxksJDfWKmSgYSfIIWQC3uJU9ZOs6wFIOjHs9Ui/9GS25Xr8=
X-Received: by 2002:a50:9d0f:0:b0:416:95a3:1611 with SMTP id
 v15-20020a509d0f000000b0041695a31611mr3875658ede.77.1648552779054; Tue, 29
 Mar 2022 04:19:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAA=hcWRay+5Xqz+RO_EX1-Yr2Ef_uXcLUL7dZE45d6wBga4mzA@mail.gmail.com>
In-Reply-To: <CAA=hcWRay+5Xqz+RO_EX1-Yr2Ef_uXcLUL7dZE45d6wBga4mzA@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 29 Mar 2022 08:19:26 -0300
Message-ID: <CAOMZO5ANFhewyN4TB7bXacipdOmAabz422nx5AhHrBrY87w1oQ@mail.gmail.com>
Subject: Re: [OE-core] Which vendors maintain SDIO WiFi in mainline stable kernel
To:     JH <jupiter.hce@gmail.com>
Cc:     yocto <yocto@lists.yoctoproject.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        oe-core <openembedded-core@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Jupiter,

On Tue, Mar 29, 2022 at 3:16 AM JH <jupiter.hce@gmail.com> wrote:
>
> Hi,
>
> I could not understand why so many large WiFi chip vendors retreat to
> stop maintaining WiFi SDIO chips to mainline Linux kernel, and to
> settle it's chip support to out of the tree, use its own SDK and
> proprietary kernel tree to source.codeaurora.org or private repository
> which are not compatible to mainline stable kernel, the kernel
> configures are also different.
>
> I looked at the following link, the mwifiex and mwifiex_sdio support
> the Marvell (NXP) 88W88 chipset, but only kernel 4.19 was able to
> build and to run, kernel 5 cannot support 88W88 chipset, any more.
> Same to Qualcomm, the old Atheros WiFi modules are supported, the
> QCA-9377-3 chipset is in source.codeaurora.org only supported by old
> kernel 4.9.

The QCA9377 is well supported in the mainline kernel by the ath10k driver:
drivers/net/wireless/ath/ath10k/

Just use 5.10 or 5.15 stable tree and there will be no need to use an
out-of-tree driver for QCA9377.
