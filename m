Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 115291DD70E
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2020 21:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729796AbgEUTTe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 May 2020 15:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729475AbgEUTTe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 May 2020 15:19:34 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F2EC061A0E
        for <linux-wireless@vger.kernel.org>; Thu, 21 May 2020 12:19:33 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id a11so2956355uah.12
        for <linux-wireless@vger.kernel.org>; Thu, 21 May 2020 12:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EyoFZ4dmdciWtiXtguApgg8PRjuC+oxamztI41cmu+M=;
        b=aivUCAlXYCrUActoPXzGexM6BS9q92mEqj8DCzXqJPTNON84CkPEpnAUDs15zRNoRd
         gRg3CbNaSfWCU52hJWDNFa7voXZ8xmLxnEFCzuW1IfHyoZp4aU6DiM7APNUvW6KRWF02
         5M2GZyISc6J0CQNTONNS/vw+Xf9sqOiVuVSSC216nnLbb/XHtEdr33UOG0ASSqF+UVwd
         xrC76yI92kROHbBicFakIWO74Y8WbBi6wWWlgHTQ5/uMFGYZdOpoZROIW3eLluwP2NvZ
         iZVUfsEWXKfS61rNLdv7oYkR7EEYeTkKx+2/3VJD0cSZima8o9/h94ZD0PDZoKNRfOjU
         f/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EyoFZ4dmdciWtiXtguApgg8PRjuC+oxamztI41cmu+M=;
        b=F7H5dYFiPJpHfeD/WE8oNeU72+XKKBgSJoxjlYXf7v/1ENL0YF+W21BRur7AeIE2D9
         JV1uQK6BlIYpmt3oepXusZok5ZuJ62PTYZn3yeOffPaVRf0ocWctVWybw9nrJmN2LJgx
         5tqIQRUDfvFnmr1rNhnKJcwomltzOHCPhLMg987x61zFUEw6OPSeEcqCq3vZCIuJgp3c
         bUHZq1RDQlBhNlKAowuB/be8nr5gavOhzIi27POGys3Fk28Zg+3kzijfU0W+M8JqHQRP
         PaEsJ+6skpdwGBk/s0NOHRzpU2QxmlFI1p0PoLCHjnpG9ySPU54b5q/HJyWogpLvJbp5
         o6zg==
X-Gm-Message-State: AOAM5321MaSAFEZ9+StqjSYHaSZO0+5UCIg+th51T3uOM0ica++gHIGv
        FQ7r6/l6Fji/cAIA1vF+5CY/A2ITq8DvwniYh7mS4L22pI3V
X-Google-Smtp-Source: ABdhPJxLDPTG0B6ntRS4v7pMDuTumi/xiCJhUBkGgwrLBxEVsZzSfB+BPzIlhTO8D26vl/3iwRfZ2rHFy1GEfQlOE1E=
X-Received: by 2002:ab0:238f:: with SMTP id b15mr8429583uan.32.1590088772931;
 Thu, 21 May 2020 12:19:32 -0700 (PDT)
MIME-Version: 1.0
References: <CALjTZvbLOr5zAYyp75Cs6Zo8mWNUVq3ZRJu56G1iHdiihFejWQ@mail.gmail.com>
 <CALjTZvatxQ2BvUeZGcTFijBf1PiLizJuDdENxg2b=tPQL_NAzQ@mail.gmail.com>
 <CALjTZvYSJOx0xeMVkN6dHcGTdgW9O9NVbgXPKK4d6-31VX+0JQ@mail.gmail.com>
 <29f5e3de-a32c-6292-9197-19dcc57fa6a3@lwfinger.net> <CALjTZvaroTrgK9=W8uTwq9YcYayfuEU31BUc0qNYJr+08hevfg@mail.gmail.com>
 <CALjTZvaPi2FL-epk-Vd2wOLye2O0J8G5aZPsqzHXt2b7u=HyuQ@mail.gmail.com>
 <263e247c-3bf9-6d42-996b-bc513efe4b71@lwfinger.net> <CALjTZvauK0Hh+aoabcDX9kkQZ4zN2ZjPnB+aq7YrJ9+-4ihiAg@mail.gmail.com>
 <87fffd5d-242a-7195-c4cc-80260dbd53c5@lwfinger.net> <CALjTZvYCFNSQ6HMN4owkiGTVrYaiU8R-P1KXgvkwGqcOo8uMuw@mail.gmail.com>
 <CALjTZvYMF_ERBfzkhaHvsTu6kt7MW+L_979sOVs8hcH7zF_Nyg@mail.gmail.com>
 <20200521124608.4b5c78f2@wiggum> <CALjTZvan46UTwcUxOSN=RiE6XHm-29Ln8B6wiv40V_RVxWewtA@mail.gmail.com>
 <20200521134011.656381ad@wiggum> <CALjTZvZcfT-aURMa=j-1ksWyVdu42bLEsGOaq+Hw39ioiPFKAA@mail.gmail.com>
 <CALjTZvY3_wjAx9DOEgYxpc4_fG-HWh_=O7veFxeEoygPzTJptw@mail.gmail.com> <2b22b778-2f89-9c42-93a0-5c165de26f35@lwfinger.net>
In-Reply-To: <2b22b778-2f89-9c42-93a0-5c165de26f35@lwfinger.net>
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Thu, 21 May 2020 20:19:21 +0100
Message-ID: <CALjTZva70Ni-s5VjRZL5BPswEtz5VZsX+dvE6rq2ztLJQ9v3kA@mail.gmail.com>
Subject: Re: [BUG?] b43: can't connect to WPA3 network (nohwcrypt=1)
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     =?UTF-8?Q?Michael_B=C3=BCsch?= <m@bues.ch>,
        linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 21 May 2020 at 20:00, Larry Finger <Larry.Finger@lwfinger.net> wrot=
e:
>
> I did only a rough test, but turning off hardware encryption increased th=
e b43
> interrupt routine from a maximum of 10% of a cpu to about 20%. Even on a =
fast
> cpu, it seems that hw encryption should be used if possible.

I didn't pay attention to the interrupt rate. I wonder if NAPI would help=
=E2=80=A6? :)

> I have one additional test for you. With the attached patch, do you get t=
he
> message that software crypto is required? It should appear only once.

Sure, I'll give it a spin. I'm now compiling the kernel for the laptop
with the other b43 card (BCM4311).

Thanks,
Rui
