Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F30F2524B8
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Aug 2020 02:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbgHZA2B (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Aug 2020 20:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726570AbgHZA2A (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Aug 2020 20:28:00 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6783DC061574
        for <linux-wireless@vger.kernel.org>; Tue, 25 Aug 2020 17:28:00 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id i10so340945ljn.2
        for <linux-wireless@vger.kernel.org>; Tue, 25 Aug 2020 17:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0RLbIHhzJWC9vCxPstzO75d+NmpabbCBp5xKdkj1CaU=;
        b=O57CImDdH1ClxTceQRs306qzuCCRk1GoRBhAGp3WeBsn9oH0gwf7W37XhWmPaVz/Nr
         CeHmWAV8n521pJ1EaILXnFbUQUMPDekJ64hBN8z9t5ZDBXKLyIrIxg7Tfo5tPxZ1dGIJ
         yTg6RbFzRWQxVeIq/Gx3gQveGc1HPDph9cLw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0RLbIHhzJWC9vCxPstzO75d+NmpabbCBp5xKdkj1CaU=;
        b=I7OML2HyTQ7Lf6IOH5mbodvBdKV5C0zw3WsjODPtAmW9lDtO22/aO/DMvf1uiva0aj
         3JoG2S01DNCcJS1caF7PztDUXHIEyefcnNcePufWk64pj01JnY6Vz+WDq0u+HiXV0NIq
         e7Cqb9b8pzPFZakIf7Ee0BaZeZS3X03BQFf8MfF8/BwSHaHl0C/fnkd6fVT5oKiNND/C
         mk4fl2VDHqpBx++rph/1QLPIWFste4xpx6QQtKX1/9xzAPtfDx7uG3+Qk+abjg/WKZz4
         HLZfP5nZLUtWnjvPSPRCwnFDWrQEKJbkblJm3//UDfLJ/bDE008xhqpp1cTuE0mMYR6V
         YDIQ==
X-Gm-Message-State: AOAM5312dAGkp5Qhtl8DU8s19OvxGcz/B8m0Mh87sO1+O2sfyHVX+/cJ
        BwpnaWK05NjOD5hX3wOrYzBNrqOLLS5K2w==
X-Google-Smtp-Source: ABdhPJyjsfI5P5tudrQ+LLjP8V0VSNJNNDnu+1PnDGA4vYcURhR/Jd64ySlVOsY+B8rWaaEax4KNhQ==
X-Received: by 2002:a2e:b175:: with SMTP id a21mr6060679ljm.385.1598401678437;
        Tue, 25 Aug 2020 17:27:58 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id e29sm110173ljp.136.2020.08.25.17.27.57
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2020 17:27:57 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id s9so16798lfs.4
        for <linux-wireless@vger.kernel.org>; Tue, 25 Aug 2020 17:27:57 -0700 (PDT)
X-Received: by 2002:a19:3:: with SMTP id 3mr5956730lfa.121.1598401677254; Tue,
 25 Aug 2020 17:27:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200824093225.13689-1-kai.heng.feng@canonical.com>
In-Reply-To: <20200824093225.13689-1-kai.heng.feng@canonical.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Tue, 25 Aug 2020 17:27:45 -0700
X-Gmail-Original-Message-ID: <CA+ASDXOizniWUk3pUM1X5UHyGcrJy=ybAwp6_jjXfEGjNPe27g@mail.gmail.com>
Message-ID: <CA+ASDXOizniWUk3pUM1X5UHyGcrJy=ybAwp6_jjXfEGjNPe27g@mail.gmail.com>
Subject: Re: [PATCH] rtw88: pci: Power cycle device during shutdown
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Tony Chuang <yhchuang@realtek.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        "open list:REALTEK WIRELESS DRIVER (rtw88)" 
        <linux-wireless@vger.kernel.org>,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Aug 24, 2020 at 2:32 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> Sometimes system freeze on cold/warm boot when rtw88 is probing.
>
> According to [1], platform firmware may not properly power manage the
> device during shutdown. I did some expirements and putting the device to
> D3 can workaround the issue.
>
> So let's power cycle the device by putting the device to D3 at shutdown
> to prevent the issue from happening.
>
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=206411#c9
>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Can you at least include some more details, like which hardware
version and firmware? And which platform? It seems a bit harsh to
include a platform workaround to run for everyone, unless there's
truly no downside. But even then, it's good to log what you're working
with, in case there are ever problems with this in the future.

Brian
