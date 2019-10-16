Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C94B9D97F3
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2019 18:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406509AbfJPQxY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Oct 2019 12:53:24 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43449 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406479AbfJPQxX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Oct 2019 12:53:23 -0400
Received: by mail-qk1-f196.google.com with SMTP id h126so23399730qke.10
        for <linux-wireless@vger.kernel.org>; Wed, 16 Oct 2019 09:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vbf2jr/JDDqbj9QeMSOR2Sm/HO2E7m/FtsJ62e/Cquk=;
        b=SgnYlzteSEDL6KMKkljl8h2XrjlmA4dX3teKW005qDYWPeYwV12TOB+l+gkOFX+uJx
         AN46B1If921/dmZVDZp448B3guKbuIMLQKDls58FJD43TmJfZNljIoAdb0IrGK0NUyM6
         /Thk555CGjZDy6LJjyS17bCw+Z67gU37bSZnI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vbf2jr/JDDqbj9QeMSOR2Sm/HO2E7m/FtsJ62e/Cquk=;
        b=sYQ7X5Zwvu8IXuzBKbIDoKS/OHGoS2Dh4QvvKxI41amjMeLWkDi3Q3NWD7lLhpZZI6
         OgZL/bTumDvRjc5I/pyzegdGMGFLREqjEyLdaP/vi4bLaTFVi+o+EYKfh/n7S9F6V/ss
         Rwvklk5kgJukHdlOK/pc4MLLObz1YEkgmLBIuul2kGZwZ6xosa/DeAYPkw3POvPsCjHp
         T7r/2LAHtNKzKGGTwVKyYfyOfgx1os5dwTuht2JjukI+fq1eL6Bpq5I/2kBx5+UpMOdL
         mxUe+2wtymcgkmZl3QwOkScBysCnrtQOVq6cvpdd92ZVcSL8HJnyUyVYTNx3LkEb1yVm
         h+Ug==
X-Gm-Message-State: APjAAAX21s8d1rl8Q1Tg7bO6yisho6bURcTFT219qgp3bs7aMsbT2HtX
        A8wgXQIJtntZGL5/zsfXJItYUlYmpdc=
X-Google-Smtp-Source: APXvYqwq2CEwtVe/husfcFprKypNXZzEAttUSYnnz6vorkqv0seQ2AEV0D4xD5rJQSRA4OKkPpdpzw==
X-Received: by 2002:a37:4a87:: with SMTP id x129mr41127627qka.43.1571244801347;
        Wed, 16 Oct 2019 09:53:21 -0700 (PDT)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com. [209.85.160.179])
        by smtp.gmail.com with ESMTPSA id l189sm11516935qke.69.2019.10.16.09.53.19
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2019 09:53:20 -0700 (PDT)
Received: by mail-qt1-f179.google.com with SMTP id r5so37165033qtd.0
        for <linux-wireless@vger.kernel.org>; Wed, 16 Oct 2019 09:53:19 -0700 (PDT)
X-Received: by 2002:aed:3847:: with SMTP id j65mr46621346qte.124.1571244799397;
 Wed, 16 Oct 2019 09:53:19 -0700 (PDT)
MIME-Version: 1.0
References: <20191016123301.2649-1-yhchuang@realtek.com> <20191016123301.2649-5-yhchuang@realtek.com>
In-Reply-To: <20191016123301.2649-5-yhchuang@realtek.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Wed, 16 Oct 2019 09:53:08 -0700
X-Gmail-Original-Message-ID: <CA+ASDXMj_f9q1aKgkcqd+2NPmxQfcQsJK8zQLUQSu8DSUW7Fsw@mail.gmail.com>
Message-ID: <CA+ASDXMj_f9q1aKgkcqd+2NPmxQfcQsJK8zQLUQSu8DSUW7Fsw@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] rtw88: update regulatory settings implementaion
To:     Tony Chuang <yhchuang@realtek.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Oct 16, 2019 at 5:33 AM <yhchuang@realtek.com> wrote:
> This also supports user regulatory hints, and it should only be
> enabled for specific distributions that need this to correct
> the cards reglutory.

s/cards/card's/
s/reglutory/regulatory/

There should be a pretty high bar for introducing either new CONFIG_*
options or module parameters, in my opinion, and I'm not sure you
really satisfied it. Why "should only be enabled" by certain
distributions? Your opinion? If it's the technical limitation you
refer to ("efuse settings"), then just detect the efuse and prevent
user hints only on those modules.

Brian
