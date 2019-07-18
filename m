Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E32F46D157
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jul 2019 17:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbfGRPsh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Jul 2019 11:48:37 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40571 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbfGRPsh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Jul 2019 11:48:37 -0400
Received: by mail-lf1-f66.google.com with SMTP id b17so19578738lff.7
        for <linux-wireless@vger.kernel.org>; Thu, 18 Jul 2019 08:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H848abaLyIwWER/gEmAO68AwOfA/THbvpS8nBllhwXw=;
        b=jv0LYAjJ3cQrNJJG4dHU14YIsAdM97SXPVhpRIr4VVu8+9iERlESrVNBKs76k6FuI4
         5MgODQxyPDbLZqr0MrLNAQSevRvEeeGHp9UlobVgpfitV+wo4l8HV8TOibYKszCq8sy5
         tp1Rbhe/dxF1BUOEUmPucLb6xWPa9oRC8faBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H848abaLyIwWER/gEmAO68AwOfA/THbvpS8nBllhwXw=;
        b=mRA4keViXaV0+9xq4yRXwG5pThX524U4SYtAyereuJv83e/emGqqrXFSjxANxtUYfC
         HvlVooW/xNYgnKknDjzKVGfqsHVyPWbCYHHPg0FTLpVsb+vnndHhzM8S4Vtf3UAdnyKP
         x0FkF/JAAGftJRd9anqJ142glcsOcUIeivBJftgei0aCj2ZIJHOdyVET7NxR8eEN6uEO
         Esfb3/inaW9EW+VdaQwvSu8k0Zt9Sr0LlGJ0MQNhcZFgaYjuHrRzAl6DaroOAFeHb7lM
         JHazAZxqk6J3ifN9YDohbVW8aqZkPBSBlZJb2AJZPaCxrTqgBXqZYSsSwCOYwZxdwrE2
         0tUg==
X-Gm-Message-State: APjAAAWkJTcTQeK/kyemNF3MACh0aMHEJvOeXVh5pd9Yoir5ecdV8PZl
        Qdz1ZEE/cTQnRfY2ETORJENYvicBguQ=
X-Google-Smtp-Source: APXvYqzPE0xlWA8rymF/ZH6DSz+KiDmds1JoV9g7S07IDmurF9hpcps06VBio0F4r4SFEGwstfSmxg==
X-Received: by 2002:a19:6602:: with SMTP id a2mr20720956lfc.25.1563464914691;
        Thu, 18 Jul 2019 08:48:34 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id s7sm5157942lje.95.2019.07.18.08.48.33
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 08:48:33 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id r15so2577116lfm.11
        for <linux-wireless@vger.kernel.org>; Thu, 18 Jul 2019 08:48:33 -0700 (PDT)
X-Received: by 2002:a19:6519:: with SMTP id z25mr21132151lfb.42.1563464913226;
 Thu, 18 Jul 2019 08:48:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190718015712.197499-1-briannorris@chromium.org> <20190718074522.GA13713@redhat.com>
In-Reply-To: <20190718074522.GA13713@redhat.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Thu, 18 Jul 2019 08:48:21 -0700
X-Gmail-Original-Message-ID: <CA+ASDXM+tN_=RbgWjfajSp9aDq0vJrbLcaYsf5+69R3b-4Y=VQ@mail.gmail.com>
Message-ID: <CA+ASDXM+tN_=RbgWjfajSp9aDq0vJrbLcaYsf5+69R3b-4Y=VQ@mail.gmail.com>
Subject: Re: [PATCH] mac80211: don't warn about CW params when not using them
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Yan-Hsuan Chuang <yhchuang@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Jul 18, 2019 at 12:45 AM Stanislaw Gruszka <sgruszka@redhat.com> wrote:
> Fix looks fine for me. However I think rtw88 should implement
> drv_conf_tx() because parameters can be different on different
> network setups and maybe more important WMM/AC parameters become
> quite recently part of ETSI regulatory.

Ack. I just figured we should stay consistent with the WARNINGs (and
we both noticed this one on earlier patch reviews). I don't know about
you, but for me, the whole wireless stack is so full of WARNINGs that
my crash reporter system separately classifies net/wireless and
drivers/net/wireless/ from the rest of the kernel when categorizing
automated problem reports. (And...most developers then ignore them.)

But I digress ;)

Brian
