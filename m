Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF77A5BCE05
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Sep 2022 16:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiISOHK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Sep 2022 10:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiISOHH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Sep 2022 10:07:07 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA7A2DABE
        for <linux-wireless@vger.kernel.org>; Mon, 19 Sep 2022 07:07:06 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id l10so27994038plb.10
        for <linux-wireless@vger.kernel.org>; Mon, 19 Sep 2022 07:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date;
        bh=x3Z8YTGg9iveLHioK5rEjRtU8KnlnXpDSqiw9lx+wTw=;
        b=le/8dhfnvZpn69mbgeGgDk1x2UvaijOpmUDyFyjbhMo+Prwe6RpwsA9v6h90M7YiLq
         kiCFWVIwk8zIueVJQOR4MYfPXCmRB8woBcI1X5SBgMey1+ddVroyDyXCqD0rANVha0Ep
         O1RyGi5NvmXHSIiIJCMaCku3hjx6HD3r1anAvwcbp0VznAQtpn6H1zDnZGaNfUd9O6Ys
         tvS8YHVKrd1vRjchndTz7sDFP27ObgYRVPAotAPJijYRTHeyKpJ9W/caD0GCKaKvepN9
         McPVuVbWBPNbUETcxlPYgk1oTgKVwirLJKCxZh0IrQOe9vVPu43bvLsaUh41UCAYJ62E
         kouQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=x3Z8YTGg9iveLHioK5rEjRtU8KnlnXpDSqiw9lx+wTw=;
        b=UFWak2ssTzWBeHVtyUObpSrD4Ho508/1+wT6GilccIPEXb8lama0WnSWoCQFN7ztIm
         590D40k9F+j6f4mNWB4iSrx1P870fKE5zvWzEffm0KrMA5yGcG1KePYLmH7RAnMLToDc
         tiBSfzxcWgd/kw8LJr7CQeRSFDU55L7QNJTwPMTE/VUSQ+UubRsR8hhRSn7s0bGoSn5V
         egIe/KmXkDqdpoLCE+B2MSxmaDQLiY793Jbrj5oyje0j6H6/3cDra/F4ymNNpZoDq9Eq
         IbCUXi9EsrfxsU39aglZoLOtzt8TWT45agmtXOpMRLmfOoIcYanaBaBFN1epDmZcDi4B
         z3vg==
X-Gm-Message-State: ACrzQf2VW41QS1NE4RPnbl5MPNIWJi1pihaqX/yJw3LX4yrgyjFddnlf
        tQkgs9lnAjThy3P22d8AJzA+BGuYEM+5xrMgbHlFj2ca
X-Google-Smtp-Source: AMsMyM5xX0RNeHt/evkRqisW32ojEaa1Tzha4lFqGRlJH0KKtw7MuOlPnrHjkqSzuO/PbLR0rTTSXxNYaLpctAx4x8o=
X-Received: by 2002:a17:902:e5c9:b0:178:5a6f:6eb8 with SMTP id
 u9-20020a170902e5c900b001785a6f6eb8mr13459946plf.42.1663596425694; Mon, 19
 Sep 2022 07:07:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAPwNHCE_LOMOKdHN7zr-MveDCN3ij0KMyhfi+nmU2v3kQff5Xw@mail.gmail.com>
In-Reply-To: <CAPwNHCE_LOMOKdHN7zr-MveDCN3ij0KMyhfi+nmU2v3kQff5Xw@mail.gmail.com>
From:   bommy985 <turkenlurken@gmail.com>
Date:   Mon, 19 Sep 2022 14:06:50 +0000
Message-ID: <CAPwNHCEocoFinaGTP9_g2e9psczdHR2vmxZ5SZK3_mu6r2Oh_g@mail.gmail.com>
Subject: Re: wifi
To:     linux-wireless@vger.kernel.org, Larry.Finger@lwfinger.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

decided to recompile my backup of the previous working driver to test
it as the driver seemed to be a little spotty for me turning off at
times, could be explained by the fact i was connecting to a network
that required login but still it was being inconsistent for a bit

it works fine after recompiling and rebooting after a sudo make
install, didn't even need to modprobe

This is still on the 5.19.9-arch1-1 kernel, i would've tried ignoring
the version magic thing if it failed, but as far as I can see, it
didn't

i dont know whats being changed or if they are suppose to be
meaningful, but in my use case, your current updated version of the
driver, as well as 2 versions prior, seem to have this spotty problem
with the "create virtual connection" condition to even get it
workingthe first one was more noticeable and evident, whereas this
time it seemed to only do it after a while, or maybe my internet at a
university building requireing a login page is just being stupid, but
at the very least, it allowed me to send this very email i am sending,
so i guess it works, right?

Thanks for the driver, and thanks for the help in a previous email
bommy


On Sun, Sep 18, 2022 at 7:32 PM bommy985 <turkenlurken@gmail.com> wrote:
>
> over the last while, i have been using your rtw8852be linux driver
> which started working again...
> following an update to your driver on github, your driver started
> acting wonky again
> by that i mean it did the same as it did before your revert in the
> makefile, require a virtual connection/hotspot(kde) to be made in
> order to show networks, let along connect
> previously this also made it extremely inconsistent, but now it just
> seems to work fine, i just have to make the virtual connection thing
> happen.
> i am using endeavors on arch 5.19.9 and did a git pull following the
> update, and also have a backup of the previous perfectly functioning
> version, if this is important
>
> not exactly a problem, but it is evident that the weird virtualization
> wifi connection thing has returned after your recent update, and i
> just thought id email you on it
>
>
>
> oh also
> my email that i previously sent to you was publicized and showed up in
> google results a while back, not sure if that was just internal error
> on your server, assuming it was(i cant find that anymore), but it
> yeah it was public for a time, if its not anymore.
