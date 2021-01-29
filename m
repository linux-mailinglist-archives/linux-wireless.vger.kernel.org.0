Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD6983090B0
	for <lists+linux-wireless@lfdr.de>; Sat, 30 Jan 2021 00:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbhA2XkF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Jan 2021 18:40:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbhA2XkD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Jan 2021 18:40:03 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3632C061573
        for <linux-wireless@vger.kernel.org>; Fri, 29 Jan 2021 15:39:23 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id a77so11801367oii.4
        for <linux-wireless@vger.kernel.org>; Fri, 29 Jan 2021 15:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JV19cANjpLfdHa/gkRlYR/E8vwFJkEmktdsDw/as+Tg=;
        b=YS2z2+yzCDkAuo5BmnLTCUCCTaHSBrIJhkBw2ayMty3OYBUSDXpsJW2xgIAk14w8DZ
         7XvkVv+N6ZsE7FDhDNvHB1KMYBeeIUF4gtJ9M78ZqpgaC+H/ux9ZwXOKgn5WSybmZ1IP
         DSjlbCrtBqi90ylIwWFCKllNuOx2mwgu764dw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JV19cANjpLfdHa/gkRlYR/E8vwFJkEmktdsDw/as+Tg=;
        b=Z4zbJfFcU6OUh55sVcERmDW534VigX14nMeVIsAMYKYj9ZMnIJRUbRrN4tnOw3dJpZ
         C0jj7llchAG42WJxS0cJVYaXL8W+rdEupBjtwweLbT1SLbE15qaechvoiMD6D2/Adbgg
         ImueM8wmTbLddJFlF0wuZfxJtjaIDf8Lo3Oapai0l5Em2hiMAHmXlcEuirkUTX+yJ4pp
         vn8OpW/NIb6VyzHwcvsbcPTqeEFF52tuEtJ/CUsFdOiJoTwZ1wZvEv+XvJogvU/WY1au
         DEEvTmqyY+v7TVT8nTNyDrVfStt2EbGmHkkar2FMrmJsQq49prjqqtjAlZKzWeWXKP7R
         aq+Q==
X-Gm-Message-State: AOAM53077cDKEqOC0teNixdgH973VngioMas+6Ilr9cuYD4CqQqz8T8X
        A10G4ByNuWTn99m4zNJ/Q7ksz+LrnVixBw==
X-Google-Smtp-Source: ABdhPJxlk6/do6R2F8M0spaW3mqUWg4qIQNB6yDRGkdhCu+c8sZhoYYBvX/2OBKoYBWjbr7/aTSCtw==
X-Received: by 2002:aca:4c03:: with SMTP id z3mr4067148oia.21.1611963562173;
        Fri, 29 Jan 2021 15:39:22 -0800 (PST)
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com. [209.85.161.46])
        by smtp.gmail.com with ESMTPSA id z10sm2757196oid.51.2021.01.29.15.39.20
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Jan 2021 15:39:20 -0800 (PST)
Received: by mail-oo1-f46.google.com with SMTP id n19so2739651ooj.11
        for <linux-wireless@vger.kernel.org>; Fri, 29 Jan 2021 15:39:20 -0800 (PST)
X-Received: by 2002:a4a:a289:: with SMTP id h9mr4694397ool.56.1611963559740;
 Fri, 29 Jan 2021 15:39:19 -0800 (PST)
MIME-Version: 1.0
References: <20210115092405.8081-1-pkshih@realtek.com> <20210115092405.8081-4-pkshih@realtek.com>
 <CA+ASDXPtwyZMByRDaAQv9b-DEBeRgPxpDz4+mCP-zi6P_-zr7w@mail.gmail.com> <d84e1a2c0d8e481588eec7248abf5c1a@realtek.com>
In-Reply-To: <d84e1a2c0d8e481588eec7248abf5c1a@realtek.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Fri, 29 Jan 2021 15:39:08 -0800
X-Gmail-Original-Message-ID: <CA+ASDXM7e4eSiJNoVMES7=mZ3M-NGpVZ9jLbjNm4yqMSYH4r+Q@mail.gmail.com>
Message-ID: <CA+ASDXM7e4eSiJNoVMES7=mZ3M-NGpVZ9jLbjNm4yqMSYH4r+Q@mail.gmail.com>
Subject: Re: [PATCH v4 3/8] rtw88: add napi support
To:     Pkshih <pkshih@realtek.com>
Cc:     Yan-Hsuan Chuang <tony0620emma@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Bernie Huang <phhuang@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Jan 28, 2021 at 1:45 AM Pkshih <pkshih@realtek.com> wrote:
> > -----Original Message-----
> > From: Brian Norris [mailto:briannorris@chromium.org]
> > On Fri, Jan 15, 2021 at 1:26 AM Ping-Ke Shih <pkshih@realtek.com> wrote:
> > > +static u32 rtw_pci_rx_napi(struct rtw_dev *rtwdev, struct rtw_pci *rtwpci,
> > >                            u8 hw_queue)
> > ...
> >
> > Are you sure you don't want any locking in rtw_pci_rx_napi()?
> > Previously, you held irq_lock for the entirety of rtw_pci_rx_isr(),
> > but now all the RX work is being deferred to a NAPI context, without
> > any additional lock. IIUC, that means you can be both handling RX and
> > other ISR operations at the same time. Is that intentional?
> >
>
> irq_lock is used to protect TX ring->queue. The TX skb(s) are queued into the
> queue, and unlink the skb until TX_OK_ISR is received. So, RX doesn't need to
> hold this lock.

I could be misunderstanding your locking model, but IIUC, you're left
with zero locking between NAPI RX and all other operations (H2C, link
up/down -- including DMA free, etc.). irq_lock used to protect you
from that.

If I'm right, maybe it needs a rename and/or some additional comments.

Brian
