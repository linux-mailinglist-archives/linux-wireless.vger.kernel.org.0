Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9916015A25A
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2020 08:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbgBLHqE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Feb 2020 02:46:04 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45273 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728322AbgBLHqE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Feb 2020 02:46:04 -0500
Received: by mail-ed1-f66.google.com with SMTP id v28so1288487edw.12
        for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2020 23:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BU8l4vAmAKTeTD0QT9iL9wOBya4IH7jqnzK3wQNaFME=;
        b=Qm02zGwHi4fflp000hXUPa2zAY/wifsLNfAwAflHgtPFCa6uWROwGXiF/u13gk8uqX
         JQieJcY1n0K3xdeXf2ehfJJUJuCG/gEptqqJfxEqMCuMVxSBqT1w8KyE57DlsjcyN4YG
         Bc2J8R/cRUcmTQK1GJ6xn0hOVL2BNXI1LSUGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BU8l4vAmAKTeTD0QT9iL9wOBya4IH7jqnzK3wQNaFME=;
        b=peiQqB0cPHWBqT6SuWeUdxEenwtWWhNdXpX8SsERXffTkc9mlNVSB8FCPQ1a+MK9W/
         QCEVS4oyWYhSuI5LUJSLym6yu+G7Jv0ijFM8Qd0XISSn41t4llOszxrx/IZFuU7QI8bf
         nJwZAEH/HaU9G5OhCXPhU+iN1y8pdexcZ97thhkwbvwZGlMtgcLrpdfosVSZzZWfThSx
         erodk9ScYUjbEgG0DNKjJxFUbExVbeLyPH6F+sGAJ+McFoyuyjkACtPUyXlOEoHSfXOo
         2dXYT+9uXgyvAYpbeCAnudWLbtHlhN3IbifWYJwD4z4XNLKng86qecrpSLWTpb4qH8Uc
         sWlQ==
X-Gm-Message-State: APjAAAW4Lf75MLnQk0mlkHYet49+C+9/2XBJBI4gj95JLXrN70xa5v1P
        hPbPtSUiKsUnwuVlSOIkU1OuxXowFF65waLHeoRSbQ==
X-Google-Smtp-Source: APXvYqztmbguEsE0G7pcUgY7JGpLSKrJp00pBhITptlLjZHEzRs7+7l5Zoo4XatDNMEBr2rVAf5gV19NAt2QeYrEeSw=
X-Received: by 2002:a17:906:b7c4:: with SMTP id fy4mr9962864ejb.139.1581493561147;
 Tue, 11 Feb 2020 23:46:01 -0800 (PST)
MIME-Version: 1.0
References: <20191128103030.6429-1-wgong@codeaurora.org> <0101016eb1903db0-ef7063b4-0f42-4a01-8886-327541e6c1a4-000000@us-west-2.amazonses.com>
 <76bce8e3-e05b-ace6-3edd-54f522be3fe6@chromium.org> <25fd4f59b39c56b2fee208713c7cbc57@codeaurora.org>
 <CANdKZ0eWJtSuOdZp6Djne21maoBtmSsEm9Rmq9HbLfriY1goWw@mail.gmail.com>
 <47925cde59e1b94766720d20ddbb4191@codeaurora.org> <CANdKZ0dtnvL66jps41UC+dkybuXA0NMEu=9p2N2T08YDLHb2UQ@mail.gmail.com>
 <222dd9c33e2afa94cd1ee80c03c7b00d@codeaurora.org> <CANdKZ0fOEZ-Ng1p4FUy6WDC2DKGUMmTQE+JhcTwrf9TjACborA@mail.gmail.com>
 <e2afd62c108d66fdb3aa590f5ded61a4@codeaurora.org>
In-Reply-To: <e2afd62c108d66fdb3aa590f5ded61a4@codeaurora.org>
From:   Pi-Hsun Shih <pihsun@chromium.org>
Date:   Wed, 12 Feb 2020 15:45:25 +0800
Message-ID: <CANdKZ0dTwO7XQQjJ+NKO5jO4qBRJxZPNQu=-UEQOiRPc+dpd=A@mail.gmail.com>
Subject: Re: [PATCH v8 1/4] ath10k: disable TX complete indication of htt for sdio
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Feb 12, 2020 at 3:31 PM Wen Gong <wgong@codeaurora.org> wrote:
>
> On 2020-02-12 15:08, Pi-Hsun Shih wrote:
> > Tested that the patch fix the kernel panic, thanks.
> >
> > For the fixed version:
> > Tested-by: Pi-Hsun Shih <pihsun@chromium.org>
> >
> Thanks Pi-Hsun's quick test,
> could you also give me the message log:
> dmesg | grep ath

[   11.462398] ath10k_sdio mmc1:0001:1: qca6174 hw3.2 sdio target
0x05030000 chip_id 0x00000000 sub 0000:0000
[   11.472131] ath10k_sdio mmc1:0001:1: kconfig debug 1 debugfs 1
tracing 1 dfs 0 testmode 1
[   11.481490] ath10k_sdio mmc1:0001:1: firmware ver
WLAN.RMH.4.4.1-00042 api 6 features wowlan,ignore-otp crc32 ac2d4918
[   11.667020] ath10k_sdio mmc1:0001:1: board_file api 2 bmi_id 0:4
crc32 e74847dc
[   12.035056] ath10k_sdio mmc1:0001:1: msg_type: 0
[   12.036919] ath10k_sdio mmc1:0001:1: htt-ver 3.73 wmi-op 4 htt-op 3
cal otp max-sta 32 raw 0 hwcrypto 1
[   12.039878] ath10k_sdio mmc1:0001:1: msg_type: 2
[   12.053816] ath10k_sdio mmc1:0001:1: msg_type: 5
[   12.235403] ath: EEPROM regdomain: 0x6c
[   12.239895] ath: EEPROM indicates we should expect a direct regpair map
[   12.247223] ath: Country alpha2 being used: 00
[   12.251973] ath: Regpair used: 0x6c
