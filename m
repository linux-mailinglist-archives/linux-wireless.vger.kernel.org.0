Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76939122DF2
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2019 15:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728768AbfLQOFj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Dec 2019 09:05:39 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35035 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728546AbfLQOFj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Dec 2019 09:05:39 -0500
Received: by mail-lj1-f193.google.com with SMTP id j6so11094616lja.2
        for <linux-wireless@vger.kernel.org>; Tue, 17 Dec 2019 06:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a8f3Bpq6dFoGf8pYbLbjxw846b7BaA25DVfJ6Nk16sc=;
        b=YlWv4l3cvCBom1ZjEksgQv2qzCt2Jd0OoZin9Npb73ERISkEQAocWKtHJilag6iOrX
         goaxcROUc+rmbSf+fo1r61jsVRGPze1Az1OZGsiyW6K+I/jo32k/e+eCb4nJoOTzZQZ3
         wykECaBVLpeqA6ovKInzbNwherieK+HrXKOKlqKulMK+BXMzWRuWm+jNosKgoWUBjmno
         6F2kDGMi17CaI+Io0qjbic9Ufxi0YKFaylEr3yVOHQbEn9vJfXxaX2UmztFIv56ZxzZB
         asAODUfm6EWkdjVuxWfB0aKaDCvxonjFctdoJqBBaOEdunNCfgFr7Au4l5bjiQZadMnR
         D8Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a8f3Bpq6dFoGf8pYbLbjxw846b7BaA25DVfJ6Nk16sc=;
        b=LRYlaUNppYcevSaYBu2sfx7HiM+wjtoI8mE/tHPh75nhveFYgzG0xp+x4wl+nn4ty3
         Bjq1fW7XX3BYpEcr9pdKSvtuPuIgQkUqnOKu6o4t6SmQdX+JekYbnW2B27yBIzVHgZT7
         w7MmNcxqcFv4l1Aig3xomsP/v/AnNAHfHwJAH/0TEoA6hPKUB7uBlGvQOjrej6BjSbwF
         esrQa7QPjXf9QJleX3k7uo2JKDMPUyOoEsLnCRDzVUKeCk/+yX0jS6tS3MttdByXuV/G
         lBlqUCUQ2Fa351DcXKOhY7AMUlg3Clnhboeu8nvBypKluc4JWo19FnyudPf6LFNXc35W
         BJYg==
X-Gm-Message-State: APjAAAXnVrrv6cH51JQ0j672mYP/iST58jqwP7H4IWYKMgyRgbYIcMUq
        Gs58sNGlgWWvx3LbqdkDxz+Vo2407dUoRwstN2w=
X-Google-Smtp-Source: APXvYqz1nyuAC4GOKP9YL55S219dezJuQ79pjaZJZl2egNjjMOVt0QOXOvRGOQnl1FG1kZ/db035gOoLF1RIBSZd0sk=
X-Received: by 2002:a2e:b0c4:: with SMTP id g4mr3286033ljl.83.1576591536918;
 Tue, 17 Dec 2019 06:05:36 -0800 (PST)
MIME-Version: 1.0
References: <20191205061922.1801-1-eduardoabinader@gmail.com>
 <0101016ed4f1db3a-e6a9458a-676e-48b1-bf5b-120a4a8d4ab7-000000@us-west-2.amazonses.com>
 <CAGoNHngJQteebGkq2dwofhm819xD9u=zTgFD0xV4WfbgiwR+AQ@mail.gmail.com>
In-Reply-To: <CAGoNHngJQteebGkq2dwofhm819xD9u=zTgFD0xV4WfbgiwR+AQ@mail.gmail.com>
From:   Eduardo Abinader <eduardoabinader@gmail.com>
Date:   Tue, 17 Dec 2019 15:05:26 +0100
Message-ID: <CAGoNHnixgDE3mm=8AhUXye0SoPRuuGB48Pzh1vm-r1VphxGyxA@mail.gmail.com>
Subject: Re: [PATCH] wcn36xx: disconnect timeout
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Thanks for the hint, Kalle.

The disconnection procedure seems more steady by delegating it to mac80211.
I'm gonna send a patch with such change then.


On Tue, 17 Dec 2019 at 15:03, Eduardo Abinader
<eduardoabinader@gmail.com> wrote:
>
> Thanks for the hint, Kalle.
>
> The disconnection procedure seems more steady by delegating it to mac80211.
> I'm gonna send a patch with such change then.
>
>
>
> On Thu, 5 Dec 2019 at 08:24, Kalle Valo <kvalo@codeaurora.org> wrote:
>>
>> Eduardo Abinader <eduardoabinader@gmail.com> writes:
>>
>> > Whenever the signal stregth decays smoothly and physical connnection
>> > is already gone and no deauth has arrived, the qcom soc is not
>> > able to indicate neither WCN36XX_HAL_MISSED_BEACON_IND nor
>> > WCN36XX_HAL_MISSED_BEACON_IND. It was noticed that such situation gets
>> > even more reproducible, when the driver fails to enter bmps mode - which is
>> > highly likely to occur. Thus, in order to provide proper disconnection
>> > of the connected STA, a disconnection timeout based on last time seen
>> > bss beacon is here given.
>> >
>> > Signed-off-by: Eduardo Abinader <eduardoabinader@gmail.com>
>>
>> Wouldn't it be better to disable IEEE80211_HW_CONNECTION_MONITOR and let
>> mac80211 handle it entirely?
>>
>> --
>> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
