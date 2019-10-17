Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97437DA44A
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2019 05:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392264AbfJQDRs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Oct 2019 23:17:48 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33665 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730479AbfJQDRs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Oct 2019 23:17:48 -0400
Received: by mail-qt1-f195.google.com with SMTP id r5so1511087qtd.0
        for <linux-wireless@vger.kernel.org>; Wed, 16 Oct 2019 20:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zfG7ZLV6gt6IG6KOv7MQIlUlPONYymvz8IlPeVuwwCg=;
        b=nMwzx3K3NL3cQy45ief6pSitotCCjIl+6ftpWEUcLTDocPexdcW2GlmyidBcrsCJvs
         IoJ2khLA5w9tvB0HaAqTo7nS8I0QJAum2Oiwbl0U9cr9NSdnvJi0Nyw4a4ttRt2MsUkT
         0Dn07vOWEuGo+P5jiToi8NuEvLzlHZkKPtdc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zfG7ZLV6gt6IG6KOv7MQIlUlPONYymvz8IlPeVuwwCg=;
        b=r9VYHrK9yHCj12uWWGz2R8FOOZ7lWpOCIhNNsYPIr+68voo0hZfaNgFpB9fDDkFinQ
         AdHgz+FgSPZFb++A58WCWbFCM/Raw0mzZhVAZqnDFmSZRRaxMd+w8oPNsQJJ40MVOb3D
         +MV11oguFs0h9Zk6d+OA1xyCKSExBt5EiIhRfMjeC8zI3h1db/EBWC54JXM2AeYJzif2
         N+ghzR4BvYwArqNpPcFs6gUI12FgwcLD8T9X0AgoXT/8N7wQzLKYkCrvG38rUO2b0Cjb
         bdzpxBKRyK2D6j5BEUJS/4nihT5kNxP2VDSUinK7l4OoCKvd1Q1UEKNhkwN2pUAm/4YL
         7pfQ==
X-Gm-Message-State: APjAAAWnakPGFOxvGqLfGUe6+VSkRalCullXeVMPZeKJcCakFfiCAm03
        +LhH+yYRZdPpu9XlmXdAe99B3/Qfhuk=
X-Google-Smtp-Source: APXvYqw6wsCIl5K1MVGorR2r/nDmQoK/HFVqE5OaTSWJucXhljRxqeMfWq+X2jOUt1ObxZqP3WOgkg==
X-Received: by 2002:a0c:fa49:: with SMTP id k9mr1563173qvo.239.1571282266475;
        Wed, 16 Oct 2019 20:17:46 -0700 (PDT)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com. [209.85.160.177])
        by smtp.gmail.com with ESMTPSA id x8sm407541qkx.77.2019.10.16.20.17.45
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2019 20:17:45 -0700 (PDT)
Received: by mail-qt1-f177.google.com with SMTP id n17so1470006qtr.4
        for <linux-wireless@vger.kernel.org>; Wed, 16 Oct 2019 20:17:45 -0700 (PDT)
X-Received: by 2002:ac8:529a:: with SMTP id s26mr1575999qtn.238.1571282265026;
 Wed, 16 Oct 2019 20:17:45 -0700 (PDT)
MIME-Version: 1.0
References: <20191016123301.2649-1-yhchuang@realtek.com> <20191016123301.2649-5-yhchuang@realtek.com>
 <CA+ASDXMj_f9q1aKgkcqd+2NPmxQfcQsJK8zQLUQSu8DSUW7Fsw@mail.gmail.com> <F7CD281DE3E379468C6D07993EA72F84D1900CF3@RTITMBSVM04.realtek.com.tw>
In-Reply-To: <F7CD281DE3E379468C6D07993EA72F84D1900CF3@RTITMBSVM04.realtek.com.tw>
From:   Brian Norris <briannorris@chromium.org>
Date:   Wed, 16 Oct 2019 20:17:32 -0700
X-Gmail-Original-Message-ID: <CA+ASDXPkU8+8haHbyiQ5gf2e6rZ-2ks=D6zfV0CDnAzaWPZXFA@mail.gmail.com>
Message-ID: <CA+ASDXPkU8+8haHbyiQ5gf2e6rZ-2ks=D6zfV0CDnAzaWPZXFA@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] rtw88: update regulatory settings implementaion
To:     Tony Chuang <yhchuang@realtek.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Oct 16, 2019 at 7:55 PM Tony Chuang <yhchuang@realtek.com> wrote:
>
> From: Brian Norris
> >
> > On Wed, Oct 16, 2019 at 5:33 AM <yhchuang@realtek.com> wrote:
> > > This also supports user regulatory hints, and it should only be
> > > enabled for specific distributions that need this to correct
> > > the cards reglutory.
...
> > There should be a pretty high bar for introducing either new CONFIG_*
> > options or module parameters, in my opinion, and I'm not sure you
> > really satisfied it. Why "should only be enabled" by certain
> > distributions? Your opinion? If it's the technical limitation you
> > refer to ("efuse settings"), then just detect the efuse and prevent
> > user hints only on those modules.
> >
>
> Because the efuse/module does not contain the information if the
> user's hint is allowed. But sometimes distributions require to set the
> regulatory via "NL80211_CMD_SET_REG".
> So we are leaving the CONFIG_* here for some reason that needs it.

Is there ever a case where user hint is not allowed? For what reason?
If not efuse, then what?

Or alternatively: if someone sets CONFIG_RTW88_REGD_USER_REG_HINTS=y,
then what problems will they have? Technical problems (e.g., firmware
will crash on certain modules) or <other> problems?

(If "<other>" means "legal", then just blink twice to acknowledge. Or
just don't answer.)

Brian
