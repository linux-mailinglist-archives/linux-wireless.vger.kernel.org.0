Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04867B455A
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Sep 2019 03:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391891AbfIQBsp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Sep 2019 21:48:45 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35231 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391882AbfIQBso (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Sep 2019 21:48:44 -0400
Received: by mail-qk1-f195.google.com with SMTP id w2so2187965qkf.2
        for <linux-wireless@vger.kernel.org>; Mon, 16 Sep 2019 18:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=edT1MwEV0Yvt3Eaj1HjVvWX2OiCmS2l00yghhSQmhh8=;
        b=aSP3I+0I+nRIj+73SiztqkTLRBYipxWxVa/2eCQpJX2zav0Vt2t57egFxrhJXLJN4T
         O9I/rutgX3kq2wLwfAuMftmT+yN3onzIGaQ/Cd5rlDXR/SQQztigJqKDjlIigsoZVZj+
         vmSCZYh/1v1+IldHyE7nga5tStmq7w1vkrO8F4A5wyq0hBaQeW6F2vcrbwGEbdX/MjJJ
         uIKyvkGH4hO8JMTnfQZvTShrcMGkvFA6csXm93BTeHBMzJkSkrX9PZdw6rAMxIyP5BWB
         ihsHObJmLtOl8WpR0Xp9cyE2kapAPxmjLdcrBVDaMWS+/rbpDhhfaZvC/6jaMmTmGzFX
         g47w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=edT1MwEV0Yvt3Eaj1HjVvWX2OiCmS2l00yghhSQmhh8=;
        b=jY5LnwsdkrPlIumCYYeoGf/4hC4duwqfTph+XxroPz88ce7gMnrZZbxf7si8Tnfree
         i0defAKe0evDkMCMQ1RNIUi8n0LWxQgt6U2E41UJ+mXnmEifxeVAC4S2YgUbTsA+nng1
         Un0R/TGS9ZJB05SMoMz2DpF403xAnJJKrwV6oetGvSUrn12NLguC0jiMXCx9+BNj2575
         GyOOp2nyz9GamT8OWoSdxz8bPSqZhFF3mvoKr3VRSRME35etQDM9PqH2FwJ93XKC94JV
         O1idmEBc4nVtbosfoOUCqTEmBp6zJr52/RYFPjwyubNj3gtxvdSt1mE69txhcepsZ01A
         H10A==
X-Gm-Message-State: APjAAAWK5HHc0/AE9JAHajGiUz96thq9JjViCEfNQHyCTIirbSiH/6nq
        dpdXGU19ORvA1VRk/Zmipt517I0QL2YdHOhD+14XMg==
X-Google-Smtp-Source: APXvYqxB9RUk2shXtPH36lM2sXDH6jnQgPup4a+emMeOnlShQR82DfRnnbGWl4+ZDJFFnKeHKMeuZgn7jU+QI6sHw2U=
X-Received: by 2002:a37:7403:: with SMTP id p3mr1286816qkc.366.1568684923337;
 Mon, 16 Sep 2019 18:48:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190805131452.13257-1-chiu@endlessm.com> <d0047834-957d-0cf3-5792-31faa5315ad1@gmail.com>
 <87wofibgk7.fsf@kamboji.qca.qualcomm.com> <a3ac212d-b976-fb16-227f-3246a317c4a2@gmail.com>
In-Reply-To: <a3ac212d-b976-fb16-227f-3246a317c4a2@gmail.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Tue, 17 Sep 2019 09:48:32 +0800
Message-ID: <CAB4CAweWoFuXPci5Re6sdN_kB0i4DkpsYxux+GAHyRHWhC+hhA@mail.gmail.com>
Subject: Re: [RFC PATCH v7] rtl8xxxu: Improve TX performance of RTL8723BU on
 rtl8xxxu driver
To:     Jes Sorensen <jes.sorensen@gmail.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        David Miller <davem@davemloft.net>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Daniel Drake <drake@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Aug 12, 2019 at 11:21 PM Jes Sorensen <jes.sorensen@gmail.com> wrote:
>
> On 8/12/19 10:32 AM, Kalle Valo wrote:
> >> Signed-off-by: Jes Sorensen <Jes.Sorensen@gmail.com>
> >
> > This is marked as RFC so I'm not sure what's the plan. Should I apply
> > this?
>
> I think it's at a point where it's worth applying - I kinda wish I had
> had time to test it, but I won't be near my stash of USB dongles for a
> little while.
>
> Cheers,
> Jes
>

Gentle ping. Any suggestions for the next step?

Chris
