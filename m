Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23DFA18A3DE
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2020 21:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgCRUmD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Mar 2020 16:42:03 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44608 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbgCRUmD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Mar 2020 16:42:03 -0400
Received: by mail-ot1-f67.google.com with SMTP id a49so19362otc.11
        for <linux-wireless@vger.kernel.org>; Wed, 18 Mar 2020 13:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pQRsiCryPl6V3NAo7sXN37tpmxbYeh89CI/87fyojnk=;
        b=CMuxrgL2erpmegOomT+Tn0hIhYhoeGJVizIyJb2mQSZidCn+ThKAqtg/WQgvB0wJxi
         1CsHMP3LoiPjfB7iyTgXs9WE60pRP9K+y9DNeEsgdTiheBArbvIZeh2gOt7RUID+jMUS
         A8m+snoKdFq/ifIWmOIvGV01aYPxiDgzBUDjko1A4kHDSjeNABA1G5GwohHH6velO8ZT
         IbQBz3u0nczwx4il4nvpRkx8HUZgBnyKaDdELQnm5nKwR1t2QWhJ7Ivuhy8ZqALzrPtQ
         /BBeccoGa3VZ+MzlCG389nLlywnUPz8IXJypBXVDrWqW/K+HpUUs9GuOiIHWOOM1BKFc
         BLmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pQRsiCryPl6V3NAo7sXN37tpmxbYeh89CI/87fyojnk=;
        b=iVIVl3Xncv7VT2DLcdviRk/XpVuCtlhbBo4ZeQK/UPg/iktE39p8H5e+C0UjPBaXsr
         nteis6QFi8GbkxH86l/fTGguIukJ5gtkD0iD/YeuM5c7BDT2HQtGNZMczuh8SJT9O9zB
         yMTLnNLP2phb0GSuYQdJVBzX9Y/sY+gOb3ssodSyfZj4kJkiWl/7Sw/B2psBEzSzZySR
         j+OQNcIXAd0GVID53zYAJsZ2Ip8KknmffSXh9Z+OT43cCbHwVc3DmjOqJx/cUV8SDlii
         rNVWbDQLhFUH3kOUBckLYc7dzfLwJalD0CsahEI+sMUI8MjOMcV0lLoTTS/JForlLAme
         QZsA==
X-Gm-Message-State: ANhLgQ27NcwdMnA3jUBsxLuZy2jzliuassL4YI+M5ZZB5gt93fYsWsFy
        0VcvlGUZe/AkUB0kbqrEn2/7bEwtb6QWNG2eoGg=
X-Google-Smtp-Source: ADFU+vs2BITNC0ZQReLbOhpag2laBd61Jj/bxVA1ezKScEjxPAYqSwTUonv6J3BbGwNDbvO3iNyulxqrdUdDwnbj3Nw=
X-Received: by 2002:a9d:2c69:: with SMTP id f96mr5320817otb.62.1584564122685;
 Wed, 18 Mar 2020 13:42:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200313030545.9184-1-mark.asselstine@windriver.com>
 <CAPuovEJWzAvCwWQq0E5MACxo=1Dk5pK4YyjH+d0W-bspAMJJQA@mail.gmail.com> <3d90288f0b8c41bfcd5f44781e82eb9f62a3e48d.camel@intel.com>
In-Reply-To: <3d90288f0b8c41bfcd5f44781e82eb9f62a3e48d.camel@intel.com>
From:   Mark Asselstine <asselsm@gmail.com>
Date:   Wed, 18 Mar 2020 16:41:51 -0400
Message-ID: <CAPuovELQ3UG1nUjd4boKrxM2zGChJVquV3X-0baO2L7sfXs6_A@mail.gmail.com>
Subject: Re: [PATCH] iwlwifi: set 'free_queue' to the loop variable, not a
 meaningless bool
To:     Luciano Coelho <luciano.coelho@intel.com>
Cc:     johannes.berg@intel.com,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Mar 17, 2020 at 4:15 PM Luciano Coelho <luciano.coelho@intel.com> wrote:
>
> On Tue, 2020-03-17 at 16:12 -0400, Mark Asselstine wrote:
> > Luca,
> >
> > This is my first time sending a fix for iwlwifi and I haven't seen any
> > feedback or seen the code merged. Should I have sent this somewhere
> > else?
>
> Hi Mark,
>
> I'm sorry, I have a huge backlog of work and I'm trying to catch up.  I
> will review your patch and apply it to our internal tree and then
> upstream it according to our usual process asap.
>
> Thanks for your patch!

Thanks Luca,

I appreciate the work maintainers do and how busy you can get, so I
completely understand. Normally I would have just waited, but again
this is not an area I have worked in so just wanted to double check I
didn't screw up. Thanks for the response.

Mark

>
> --
> Cheers,
> Luca.
>
