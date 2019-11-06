Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4702F132B
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2019 11:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbfKFKBk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 Nov 2019 05:01:40 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35004 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfKFKBk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 Nov 2019 05:01:40 -0500
Received: by mail-oi1-f194.google.com with SMTP id n16so20437806oig.2
        for <linux-wireless@vger.kernel.org>; Wed, 06 Nov 2019 02:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6EGX28wEFZgUP2ViykHhowm1UZd+iCJ5kGWB7RqLO4I=;
        b=cze9xOjKjae6ndO91v7yCelIYgKCcUEG1jKrdVfJN8rrivk0/ztpPnRmgRs19lBHbd
         Xc6YUjknUdd2ur0TXgHntHW5k2tjqBUmLhzhKYLqqnNUX196/W2uqARpFio6wMKaMAE3
         ++pKayavbRONNUo0L/ccOK7bzUrXRoUIg56BkPn0JYGWqFxX0FHoopOVWuwlXFfTGX6K
         594+bJ/KWPUsmKCZ3HKoTVc5R2b+PQmEpeoNxmTvwxCjhIgv62Uro/5/r70SSWgJp1GZ
         K80ynAh0nOfz2ZOebvtY7mCh4BASNe5PX6eSjJksreCpvQc8FrF/jFgAXLEqv1e8tacV
         QsAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6EGX28wEFZgUP2ViykHhowm1UZd+iCJ5kGWB7RqLO4I=;
        b=s7RQgXB15Yd0XHaLmR6+l22B+q3IYPg5QVIkLjbSqMhyg254K/pFezNOWuJcN4g4bX
         J7uVQn/UsjVO2Xpwg2aXy9wl51omYUFIxIWc9K8R7vdhasLzQxVeA6AA/FdcNEH8a7On
         dtLCktv7qet5qIr3l09wzG4ozfWdDZ1D9x+WM76RTNlsbPtaaTL6hk59Yh36nhb/pcS1
         os/PTSJp6XCsGPP488zr1xkzPR8t+cGvuXFOa8fR2IuHayDBodpg2ZqWUrNSwxGi8Mn6
         VsXSNaYzzDwIgKwOf+N7LybznYmQ3zpacfk5fRVlHts8mnJqt0r8D8riq/3Jpows5YRp
         zz5w==
X-Gm-Message-State: APjAAAV/+h2HWBtjv7biDy5WcAobKHXkJR1YeCndDowyrX4Z6iNY/lzs
        NY4hV1GT56if8/HJyPna1jhVOJK6s0wQmszDZ30FeUqC
X-Google-Smtp-Source: APXvYqyApwUy7IhVKtaGYyAk/3krLYde4B27R95zSTjANWbyG7AVqhn4RAL+NtjCz+xBqBUAZHjFIXvCQ+FLiF0wW5k=
X-Received: by 2002:a54:4f83:: with SMTP id g3mr1523053oiy.24.1573034499461;
 Wed, 06 Nov 2019 02:01:39 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:384:0:0:0:0:0 with HTTP; Wed, 6 Nov 2019 02:01:38 -0800 (PST)
In-Reply-To: <9bb484b94c43f7c9aa08345ad89d7b2c@codeaurora.org>
References: <1571734629-18028-1-git-send-email-zhichen@codeaurora.org>
 <CAKR_QVLDFBVMDDP4mPYVNdpT9TA3podNeQMpVJQwE7A5eG=0kA@mail.gmail.com> <9bb484b94c43f7c9aa08345ad89d7b2c@codeaurora.org>
From:   Tom Psyborg <pozega.tomislav@gmail.com>
Date:   Wed, 6 Nov 2019 11:01:38 +0100
Message-ID: <CAKR_QVL9QLE72y0HBD_miLYAD4qx73u3FK33=oNCHp_S8H6JOw@mail.gmail.com>
Subject: Re: [PATCH RFC] Revert "ath10k: fix DMA related firmware crashes on
 multiple devices"
To:     zhichen@codeaurora.org
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 30/10/2019, zhichen@codeaurora.org <zhichen@codeaurora.org> wrote:
> On 2019-10-22 18:07, Tom Psyborg wrote:
>
>> What about main and 10x firmware branch?
>
> There is no code changes in firmware. It's a configuration change of
> host memory access.
>
> Zhi
>

Please change it for main and 10x branch too. Dumping hw1.0 regs with
QCA driver shows DMA burst value set to 1
