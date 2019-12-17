Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3A91234D1
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2019 19:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfLQS3d (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Dec 2019 13:29:33 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44492 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbfLQS3d (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Dec 2019 13:29:33 -0500
Received: by mail-ot1-f66.google.com with SMTP id x3so14753197oto.11
        for <linux-wireless@vger.kernel.org>; Tue, 17 Dec 2019 10:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gTOUNDLMfirBGIuETviNmermg4Fi1PWX+tOT/7hhvC0=;
        b=HCogmDGH1vErIrcO/0X0IdNF6JHKjW5zPogCgd35FNJj5PAjwcDi/+NhNzlnC1qrXF
         ufCa9kZHBoA4dik5bQEqQVpEHvC5LqQrxXUnZtIpDzGXhP9kiw8lxjEbOu/5mF6GWvyg
         bdsuvPoGYH4+1SCN40PB/mRqHicgxmOrFBDu7D+eC298H8FDoShzKD2NNJ2wAhRgCt0x
         OZ9t84hjSown1ZQSpyqpcbHEO7Jl+gpAdZ48Y+61qiQ1GuDtm3weh0VLm1O6kyVdkVs8
         GtkZOdvZ1DSwpKhRj5pCURJnDaMu/iIE7G/EHedtqifXgYwhw0sfVjZnd6EPAVDRQcic
         wBMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gTOUNDLMfirBGIuETviNmermg4Fi1PWX+tOT/7hhvC0=;
        b=qn+yQOtlpAFGT68VYMpyL2e25mxaY3TlfzieFCTPnGt+xtHMwk4jcdAWUXtPR6va49
         osjczSym2X6YVrsXa0RprsDbENJDK6B6I+0pHikIvV0lgagnl+c6pYSPcgLrrifiDIFs
         BfCd5YTdAIsnfT58kCQ0Xp2N3LVmNLHbdsUiViMELSQQsjXNWwJVMMWCEX3W7hE5RtUw
         U8hdOb8yG6uBwI9xsdbS0z8480Lqri0PBNhL9x0ZG+k07EUu+/lqg2BRcPX+2IQgYZgy
         J1Nj11XcBgJrmrLaagdVAVNMl6qm/FgB3lt/MtPmvChBxQWFdfk+2IZPK2e1uL0WhVwl
         UW6g==
X-Gm-Message-State: APjAAAWur7zcDLxPzGlxFIX+mKd/ZVXH2XXP7ypBwfy/VhK3Hau1QSW5
        Lnxqueep9eoK8rD9QocZuJFSbEC0c1ly9e4J8D06AA==
X-Google-Smtp-Source: APXvYqwry9Qqb/tMBd9NQXiRW6IUbVnkQ42Yo1XaO3JezrZKIEL+EgLZXum4NEtRUb5Kunlua8Rf3EJLMFWVSllRP1M=
X-Received: by 2002:a9d:6b17:: with SMTP id g23mr37678551otp.265.1576607372289;
 Tue, 17 Dec 2019 10:29:32 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:350:0:0:0:0:0 with HTTP; Tue, 17 Dec 2019 10:29:31 -0800 (PST)
In-Reply-To: <11290a30-46e8-638e-4110-86e6b2eb3d3f@candelatech.com>
References: <20191216220747.887-1-greearb@candelatech.com> <a2af03e9-8b53-b297-467b-d0f07b8a002b@newmedia-net.de>
 <b5d63d96-4ba6-bbab-bf1c-a61c6c437f37@newmedia-net.de> <80700614-679a-336e-bd9a-e88622e75c9a@candelatech.com>
 <4775d91a-9719-46f8-b0f2-979b8d86cf9f@newmedia-net.de> <CAMrEMU-vGB8uR-JZbD2vj4vXgWNHfFqcbsqB=gOqBBDZWGkzQA@mail.gmail.com>
 <11290a30-46e8-638e-4110-86e6b2eb3d3f@candelatech.com>
From:   Tom Psyborg <pozega.tomislav@gmail.com>
Date:   Tue, 17 Dec 2019 19:29:31 +0100
Message-ID: <CAKR_QV+xNbAzzw12x3Ku49bHnERTxYRAK8AfUSwp_uOgNMbY4Q@mail.gmail.com>
Subject: Re: [PATCH] ath10k: Per-chain rssi should sum the secondary channels
To:     Ben Greear <greearb@candelatech.com>
Cc:     Justin Capella <justincapella@gmail.com>,
        Sebastian Gottschall <s.gottschall@newmedia-net.de>,
        linux-wireless@vger.kernel.org, ath10k <ath10k@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 17/12/2019, Ben Greear <greearb@candelatech.com> wrote:
> On 12/17/19 8:23 AM, Justin Capella wrote:
>> I believe someone recently submitted a patch that defined noise floors
>> per band (2/5).
>
> I looked at using the real noise floor.  Our radio was reporting a noise
> floor of around -102,
> where the hard-coded default is -95.  This of course would make the reported
> RSSI lower by 7db
> in that case.  I am not sure that is correct.
>

Hi

I am getting similar NF values with all my ath10k devices, I thought
default was changed since ath9k from -95 to -115 just like in the
vendor driver? There were some discussions about it on mailing list.
On some channels (5Ghz) the value goes down to about -107, even saw
-110 once.
