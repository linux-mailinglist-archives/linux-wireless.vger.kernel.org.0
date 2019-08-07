Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4620F850F3
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2019 18:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388692AbfHGQU5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Aug 2019 12:20:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:56524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387922AbfHGQU5 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Aug 2019 12:20:57 -0400
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A7C9222FC
        for <linux-wireless@vger.kernel.org>; Wed,  7 Aug 2019 16:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565194856;
        bh=oPAKNVBLvVOYekNlp4K5LNtM6tv5QzJcTPrxkrhmPD4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=o1e8Va+8G7trBYQXukc5n+bkxLZitYguotrp97cC4/buFp7Vgc/9+LXwkqpL1P5CF
         +qyMz0yoynVzyAMGjG4dWqcF5ZXfpOm+n789jlmVD2up2dHVsSe7vUxZhUnKoEq+sA
         LJ+wXX887D2r2W1cHELg5oB26OgHPJzEkAOfBlDY=
Received: by mail-qk1-f180.google.com with SMTP id r6so66306004qkc.0
        for <linux-wireless@vger.kernel.org>; Wed, 07 Aug 2019 09:20:56 -0700 (PDT)
X-Gm-Message-State: APjAAAXhc1SrovIXlfT5cYLulRl6/fwXqlNDKMlZMPgA3i5WFR0O7g6w
        PYSLCMiC2oWYRuCrpYF1gNxKcVBSVUscLZvcweU=
X-Google-Smtp-Source: APXvYqxkZ27nH0xwKhynE7bN28PwJV+Ig3Ceu7Va6OEhiPsdT5UOm4k7OtxRbo+cTe9+siSLV20QjRXz2l5Wkjbbcko=
X-Received: by 2002:a05:620a:1329:: with SMTP id p9mr9187371qkj.224.1565194855263;
 Wed, 07 Aug 2019 09:20:55 -0700 (PDT)
MIME-Version: 1.0
References: <1565167700-22501-1-git-send-email-yhchuang@realtek.com>
 <1565167700-22501-2-git-send-email-yhchuang@realtek.com> <3307e4b7-c92d-e1d2-b896-26e45fb69a9b@broadcom.com>
 <F7CD281DE3E379468C6D07993EA72F84D188A068@RTITMBSVM04.realtek.com.tw> <7bbbe3be-1f6f-8f38-45f3-54f25a5b2f38@broadcom.com>
In-Reply-To: <7bbbe3be-1f6f-8f38-45f3-54f25a5b2f38@broadcom.com>
From:   Josh Boyer <jwboyer@kernel.org>
Date:   Wed, 7 Aug 2019 12:20:44 -0400
X-Gmail-Original-Message-ID: <CA+5PVA4LDjCtPW8HAve79inmihT_6BDp899HGx_7P-4U3H7NaA@mail.gmail.com>
Message-ID: <CA+5PVA4LDjCtPW8HAve79inmihT_6BDp899HGx_7P-4U3H7NaA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] rtw88: RTL8822C: add WoW firmware v7.3
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc:     Tony Chuang <yhchuang@realtek.com>,
        "linux-firmware@kernel.org" <linux-firmware@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
        "briannorris@chromium.org" <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Aug 7, 2019 at 6:15 AM Arend Van Spriel
<arend.vanspriel@broadcom.com> wrote:
>
>
>
> On 8/7/2019 11:53 AM, Tony Chuang wrote:
> >> From: Arend Van Spriel [mailto:arend.vanspriel@broadcom.com]
> >>
> >> On 8/7/2019 10:48 AM, yhchuang@realtek.com wrote:
> >>> From: Yan-Hsuan Chuang <yhchuang@realtek.com>
> >>>
> >>> Add WoW firmware to support entering Wake on WirelessLAN mode
> >>>
> >>> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
> >>> ---
> >>>
> >>> v1 -> v2
> >>>      * update WHENCE file for new added firmware
> >>>
> >>>    WHENCE                    |   1 +
> >>>    rtw88/rtw8822c_wow_fw.bin | Bin 0 -> 138720 bytes
> >>>    2 files changed, 1 insertion(+)
> >>>    create mode 100755 rtw88/rtw8822c_wow_fw.bin
> >>
> >> Just wondering: Is this a good approach? What firmware should distros
> >> pick? Is there a trade-off affecting other wifi functionality when using
> >> WoW firmware?
> >>
> >
> > If distros want to use WOW, they should pick both.
> >
> > For Realtek devices such as RTL8822CE, it needs to "change/re-download"
> > the wow firmware to suspend with WOW functionalities. When resume,
> > switch back to normal firmware to run "normally".
> >
> > I think the reason is the firmware size restriction. For newer devices,
> > maybe there is a larger space for firmware, and we don't need to swap
> > the FW like this :)
>
> Interesting approach and I would mention this in the commit message or
> add a README in rtw88 folder explaining it. Not sure whether distros
> look at commit messages.

A README would indeed be nice.  Can you do a v3 with that included?

josh
