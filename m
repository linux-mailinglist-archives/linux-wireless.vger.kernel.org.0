Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A66705223
	for <lists+linux-wireless@lfdr.de>; Tue, 16 May 2023 17:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbjEPPa3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 May 2023 11:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbjEPPa0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 May 2023 11:30:26 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231AF5FEB
        for <linux-wireless@vger.kernel.org>; Tue, 16 May 2023 08:30:25 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id 71dfb90a1353d-453859b6b18so2161942e0c.3
        for <linux-wireless@vger.kernel.org>; Tue, 16 May 2023 08:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684251024; x=1686843024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oCgs2LTB3dxZ4xbHOHdUNZqAn1/mmiw/ghYzbuQljZU=;
        b=V9YJEg/pEqnB3v5VcBwBpPPTgZBOsaFIS90Y6hN3+xWAgbMbfqreIs+qXZlYbW6Obw
         YO1+B6R8O0RBixptgo+6TJ4CimLm8FNE0SQQalFyjSU5FE3uaw8DYyXT2SnkZBrQyN9b
         BVoLPPqjEQAFmrMEWsdL2TJUXWoqTM0kXsWKciKRb1nVbMl//gd5QRQvET6vlPdC3kWj
         Om2GBs8L7qDddaMbNOu6qC0Hl8a9clWnDVSpPRXsWVIZZTCE1ZUjR99nl6Iv1Uw146VZ
         JZ6XPmey+krkHmpXbdu7jnmI09EdzWxMFmNpxdQwaaIdzktgx+yimkMrHYiWoxBzRhtA
         KJCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684251024; x=1686843024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oCgs2LTB3dxZ4xbHOHdUNZqAn1/mmiw/ghYzbuQljZU=;
        b=WEtB9VHE+ouRlw1ndh6HIRH549UbIn/jprXStyq/R/L2Wdae8SiEXrLL2FY522uaCS
         BW/CrJ9TdkOzpSqeDY/278KSUYdOqhbejURlOuGFduk9MOo/NiTRQ/G+DaU6ZzqwmRpy
         LHLMcuVcXX38TDzig+fVkAV6CibyGjqU6Iap+mamkgtYcxQkuGbiivB8QxKLGXxNG199
         gyqIDhQemvZ4UCmiLk64PMvyOgiAYVESbAGCb4GQtLbN0C2Futuc2yVrM3g+w8nSE3QJ
         XYrvdeQLwi2eOvgnzE5rqGh5hjseo+gafg76py1piWSigaiFrmJHouJIxslSbITyXQ6I
         mFSQ==
X-Gm-Message-State: AC+VfDz63YhsZKpZM6H0V1vDm4wurQp9+XCeue2mKTTgLzOymvRP3Ppv
        rkmljW//PbPV6JtPG+ycGXgQmV5ge/SeK2lZx/s=
X-Google-Smtp-Source: ACHHUZ4kxuYtwNEJ2Vc+kAaUbNXdY/23mc8LHFZB/pvufBQkO2ZvfY3Hdh8WcvxoMRpdXeb1GCxr0QvhY4/FyDGPPsA=
X-Received: by 2002:a1f:4d06:0:b0:44f:d1d6:1978 with SMTP id
 a6-20020a1f4d06000000b0044fd1d61978mr12665773vkb.5.1684251024008; Tue, 16 May
 2023 08:30:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230430201830.2f8f88fe49f6.I2f0076ef1d1cbe5d10010549c875b7038ec4c365@changeid>
 <CAAJw_ZuFaE-oYWQWQ+k0Lz_GcJH+adF6SZuwaKpV8UB0XGqVzw@mail.gmail.com>
 <CAAJw_ZsK5c5Y7NpFeNG6i2-kozeT9jscog57+bwwEy6RtiFm8Q@mail.gmail.com> <36eac50e-912b-a9af-2041-4d28b2eeb4e8@leemhuis.info>
In-Reply-To: <36eac50e-912b-a9af-2041-4d28b2eeb4e8@leemhuis.info>
From:   Jeff Chua <jeff.chua.linux@gmail.com>
Date:   Tue, 16 May 2023 23:30:13 +0800
Message-ID: <CAAJw_ZuzsEsoOR0HsbEfhpxnUAxyh2dmJ+37eEspv=ZTjDL9cw@mail.gmail.com>
Subject: Re: [PATCH] wifi: iwlwifi: mvm: rfi: disable RFI feature
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     gregory.greenman@intel.com, johannes@sipsolutions.net,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, May 15, 2023 at 5:10=E2=80=AFPM Linux regression tracking (Thorsten
Leemhuis) <regressions@leemhuis.info> wrote:
>
> On 04.05.23 15:30, Jeff Chua wrote:
> > On Mon, May 1, 2023 at 7:56=E2=80=AFAM Jeff Chua <jeff.chua.linux@gmail=
.com> wrote:
> >>
> >> On Mon, May 1, 2023 at 1:18=E2=80=AFAM <gregory.greenman@intel.com> wr=
ote:
> >>>
> >>> From: Gregory Greenman <gregory.greenman@intel.com>
> >>>
> >>> This feature depends on a platform bugfix. Until we have a
> >>> mechanism that can verify a platform has the required bugfix,
> >>> disable RFI.
>
> Hmm, looks from here like there was no progress with this for two weeks
> now. :-/

I've tried the latest git pull linux, applied the patch from Greg, it
works fine on WPA2, but not on EAP. Just couldn't connect. Reverted
the patch, and downgrade IWL_22000_UCODE_API_MAX from 78 to 75, and
EAP works again.


>
> >> Greg,
> >>
> >> Patch applied and worked! Thank you!
> >
> > Only issue with that is I was in the office with EAP, and couldn't
> > connect to the WIFI. I'll need more time to bisect next week at the
> > office.
>
> Jeff, did you ever look into this and check if that's due to the
> proposed patch or some other change applied for 6.4? If it's (likely)
> the latter it might be the best if we go ahead with this change and
> handle the other problem separately.
>
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
