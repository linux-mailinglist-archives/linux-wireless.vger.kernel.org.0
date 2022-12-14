Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10FE664CEC4
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Dec 2022 18:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237756AbiLNRRN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Dec 2022 12:17:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239208AbiLNRQu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Dec 2022 12:16:50 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7B7221
        for <linux-wireless@vger.kernel.org>; Wed, 14 Dec 2022 09:16:42 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id g7so11572698lfv.5
        for <linux-wireless@vger.kernel.org>; Wed, 14 Dec 2022 09:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xWCj22CRjlrmpNDVrcK0EUJz8cbcNL2SuErAhoSs+4A=;
        b=cpVp936PlIx0A1jeRRtyXG0IVsU4TFlYDqPK/MiG74DTxnWKgnniLOhNfAG8NE4MHA
         zRnncTKAqkpF/dk8Z0IAqtEfqGvKgDwQQEcjdAP+acr9sr3VC4fCP5TqyRRkH46jeIUM
         rXr/FWje8wpSPXOT2Oo8PQFkIoX4zN8OZim62XkxzBOS2HZReH3E/C5hUJBpQgcZOjv8
         sOU/NJyLEFAboc7GQwUZ2kshGeO9Hx9Q0NrNz8OE6DdD+fenKvS3lioBUYQisozfP37f
         1sEMQK/4zGtrWAqBEshzfj/+hh415nHaXIeZNhLfvgrSdlUNHrQwRJnfnOSbLjA8MUua
         8F6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xWCj22CRjlrmpNDVrcK0EUJz8cbcNL2SuErAhoSs+4A=;
        b=fTjfxrVRuUvLa0IvEBmavmCJveeJTcrKHbI9p7acT/k5w/BMk7SnPmlwzYV2ILbKNM
         up1zu1H6ecH4SQnTS548rsncKSTr6mgrwtjSdXjcbuQeSajV1cvJ0JyfK+VS6UB7y/0U
         BGmvBZe7l0LeE5WuPUeX1MvbCU3sAYluDv+UsXt125v+yMXkYr22x1ug5TzOVEPGlogU
         UDJl3JI1vCiCbzFyDE1o/vUvGLu/6J72CmLp1b5HRtEcA4WfGIKHGpnt631eXVJm4H3z
         CIKjIG9R73UxTJL/gSykUApdY/bHHX/NgCVd3dHByq7jf8tLW9Q7ncHWaWk1nR2CsX3w
         nDlg==
X-Gm-Message-State: ANoB5pkuETNwl+P/RrlVkXDAPh2CJg255JIOIfWFTqSZmv5BkUNynqiA
        CHXScPECUGvk4XNxwtFrwfXbHBGTh3aPR5u2bbCNwc96
X-Google-Smtp-Source: AA0mqf6Bmn55SN1hL5nVLU0akORk2/vJua/nXrfy9PFy11M9cPi0oqf1sYwz6+AvJ7sjInJmNK9KOUIYKEkMoHbvI7A=
X-Received: by 2002:a05:6512:1043:b0:4b0:efed:e3a8 with SMTP id
 c3-20020a056512104300b004b0efede3a8mr31671371lfb.650.1671038200583; Wed, 14
 Dec 2022 09:16:40 -0800 (PST)
MIME-Version: 1.0
References: <a2a454c5-3940-52d0-77b7-e5f8376720ae@charlespiekarski.com>
 <1f878b2ec793443f96685773c6599591@realtek.com> <87y1ral8jp.fsf@kernel.org>
In-Reply-To: <87y1ral8jp.fsf@kernel.org>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Wed, 14 Dec 2022 18:16:03 +0100
Message-ID: <CA+icZUVfTqukO4cvjHLLp2yKN9nUxaL2y_Tfz1am05cgWCm32w@mail.gmail.com>
Subject: Re: Realtek 8852BE support
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Ping-Ke Shih <pkshih@realtek.com>,
        Charles Piekarski <contact@charlespiekarski.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DEAR_SOMETHING,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Dec 14, 2022 at 9:00 AM Kalle Valo <kvalo@kernel.org> wrote:
>
> Ping-Ke Shih <pkshih@realtek.com> writes:
>
> >> -----Original Message-----
> >> From: Charles Piekarski <contact@charlespiekarski.com>
> >> Sent: Monday, December 12, 2022 7:11 PM
> >> To: linux-wireless@vger.kernel.org
> >> Subject: Realtek 8852BE support
> >>
> >> Dear Sir or Madam,
> >>
> >> I would like to kindly ask for information if Realtek 8852BE Wi-Fi 6
> >> module is supported or will be supported by the Linux kernel.
> >> Regrettably, the module does not work under Ubuntu 22.04.1 and 22.10, at
> >> least out of the box, and I was unable to find any useful information to
> >> get it working in a safe way (with Secure Boot enabled).
> >>
> >
> > 8852BE got merged into kernel 6.2 that will release about 3 months
> > later.
>
> Related to this, we have a crystal ball service which tries to predict
> merge window and release schedules:
>
> https://phb-crystal-ball.sipsolutions.net/
>
> I should add a link to that in our wiki, I don't think it's mentioned
> anywhere.
>

Huh, a crystal-ball for the future... the past and the present and
from JoHill :-).

-Sedat-

> --
> https://patchwork.kernel.org/project/linux-wireless/list/
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
