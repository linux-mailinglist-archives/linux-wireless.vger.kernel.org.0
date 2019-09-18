Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE32EB5913
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2019 02:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbfIRAmP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Sep 2019 20:42:15 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42817 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbfIRAmO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Sep 2019 20:42:14 -0400
Received: by mail-lj1-f194.google.com with SMTP id y23so5367083lje.9
        for <linux-wireless@vger.kernel.org>; Tue, 17 Sep 2019 17:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9+Nb43vvEahh6EgYk9/NpOfIE7vJR686QGgI/gaAQh8=;
        b=QscSjGbI2WTdumUGXP/dz+OvEKtR2EMWBlMNR8DIIx3pdw7EMYqsYUfCI1yudvmZzB
         Gud8V5hB+OWr3DL/NyNh+RTizp3H10oD/ASWS5aIPkm26xg3vh/pjNgevqaTSsj1kK6a
         nl3vlGCTtz98VhpPEYEKpsj1Yr/VtMrRGRuvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9+Nb43vvEahh6EgYk9/NpOfIE7vJR686QGgI/gaAQh8=;
        b=osTbG0vkpXMe8xARAB+6GSXxDeTHYeoVhp20jHfRm7uRz68EtXhlHpgNVZMdiIHxRb
         YBK4PvDB+kFvWQv3Fvd5TKcHWsG/oiTcwasis125azevJPtrZ/Zc6xu+2cz3s6LCykaH
         RnVaoRNsH3Jhso9fCoPQEtynORMG/Qfwwg4RXNFYUHnuthuHkGs0l32S8fL0jLEGEfaN
         Tyi9JOFKMgZqdcMKuFnsCn8TCXWQrRL28qMILdcQ8fTH+LsTPXV/hPZJE0mZKiLKNxxS
         5Kn522JfWzKxtsondKuJlbdMEIuTI2H4IrcELYw7/VnHQ0OnOBLEHvuWFJIIi0VltZuZ
         c77w==
X-Gm-Message-State: APjAAAXCft8Nyi7OJrbB3rWvj8tpovktRWRSBsa16eaP+F1vRH46O4fY
        1sf4YQqHs7D+9MiCHuuvq9NOm7Af5no=
X-Google-Smtp-Source: APXvYqwAWtI3Nkc0MEKW6OKCL5dUJGRcoFb+Yr0SMpeYa+REh/Y02YzUliUjRcO8GSlluyhIcW5H2g==
X-Received: by 2002:a2e:89ce:: with SMTP id c14mr548283ljk.145.1568767332532;
        Tue, 17 Sep 2019 17:42:12 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id m17sm855828lje.0.2019.09.17.17.42.11
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2019 17:42:11 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id v24so5422030ljj.3
        for <linux-wireless@vger.kernel.org>; Tue, 17 Sep 2019 17:42:11 -0700 (PDT)
X-Received: by 2002:a2e:95cf:: with SMTP id y15mr547070ljh.27.1568767331232;
 Tue, 17 Sep 2019 17:42:11 -0700 (PDT)
MIME-Version: 1.0
References: <1568617425-28062-1-git-send-email-yhchuang@realtek.com> <1568617425-28062-6-git-send-email-yhchuang@realtek.com>
In-Reply-To: <1568617425-28062-6-git-send-email-yhchuang@realtek.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Tue, 17 Sep 2019 17:41:59 -0700
X-Gmail-Original-Message-ID: <CA+ASDXOMao9uucGxa6C0Q99pFvAtKTptreeshbfKqiELDKUH0Q@mail.gmail.com>
Message-ID: <CA+ASDXOMao9uucGxa6C0Q99pFvAtKTptreeshbfKqiELDKUH0Q@mail.gmail.com>
Subject: Re: [PATCH 05/15] rtw88: pci: release tx skbs DMAed when stop
To:     Tony Chuang <yhchuang@realtek.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

May be a dumb question but:

On Mon, Sep 16, 2019 at 12:03 AM <yhchuang@realtek.com> wrote:
>
> From: Yan-Hsuan Chuang <yhchuang@realtek.com>
>
> Interrupt is disabled to stop PCI, which means the skbs
> queued for each TX ring will not be released via DMA
> interrupt.

In what cases do you hit this? I think you do this when entering PS
mode, no? But then, see below.

> To avoid those skbs remained being left in
> the skb queue until PCI has been removed, driver needs
> to release skbs by itself.

Doesn't that also mean your dropping these packets? Shouldn't you be
delaying PS transitions until you've finished TX'ing?

Brian
