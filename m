Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1204D39D455
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Jun 2021 07:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbhFGF1O (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Jun 2021 01:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbhFGF1N (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Jun 2021 01:27:13 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46887C061766
        for <linux-wireless@vger.kernel.org>; Sun,  6 Jun 2021 22:25:23 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id w4so809356qvr.11
        for <linux-wireless@vger.kernel.org>; Sun, 06 Jun 2021 22:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x5arvQU1DizToyW3eVdhkmF3gRpIcNCRfe6EmSM59DA=;
        b=XpN+YDaE3LmExa5E2xgVQ7XUldAbiC7dAV0l7B67r/9jgApyZ0m6q0aJa6oNo+X2e+
         RwONfPWHxxHFCs4tTpjTVsQeTTC2w69y2JXT8ySHXVCx3Aw1di8QWroSZSvm4cBZfjjY
         xaGTBUyXnOSweWmV/u/aG49OxDXRHBxtKz/H+RAECYlByps+6Pa4OTjiBqI4csMghcwC
         EpdWC6KrxpgOMA/ctiaTvz1OgWhRbuRxzdromXMEGlkai31nC3797to0y6jc+vH4vbGu
         DcdVsah/OMCJiRXzxx4y3s0zj8svoM18YjXBclE9V95ZUCbfi4fpN7BbD1xivK6kzJDr
         U2eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x5arvQU1DizToyW3eVdhkmF3gRpIcNCRfe6EmSM59DA=;
        b=IdFhZGb4YYG7sKm2wClQyoA4JCWIR223VadxMfzF/eKSL+0IADtwlcdA3fgKvx+o7U
         k8DfZwP1DRUlRa23jnrzghVBghBbxzQMuaqa4karAosCC/lflHSVebTqjiQtT/acjj8S
         694H2OKh/0iE8ebgJEp/toR4LyMEPt/KoJkXwVUjI+xzuvPRT0G4pyNi2UFL3vnSkkCn
         Y/rpNrYjpUg9Datbs9o2HsAMZu7b2Ku9PYc8+spBGpzFKv4fvsL6uRgk02ApJZnw3pEr
         S6yRr/RwLp6bxAJaMtk160LZy0i+7qMlm0dRVCh9bRBmebmMUuEciaNx9AV58EFp0hMK
         Tyew==
X-Gm-Message-State: AOAM532Sb7/nXV4EJQ4Ox/j9jjPhulxc2fABTD7PQ81XzsgQG02SVvS1
        cWPbLM5VL5+nphoWU2A09dGUgY0Pxaqp8YYZzP/Ogw==
X-Google-Smtp-Source: ABdhPJxtKVg6D8ZZ0d7JoS4CAcp8CotJlXNW3tNQolEhFWJR3pOIfB3+n5EVyJ26egNuqkf3wZo8ebbRxVUZRD2aE3g=
X-Received: by 2002:a0c:d409:: with SMTP id t9mr16246286qvh.18.1623043520610;
 Sun, 06 Jun 2021 22:25:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAD-N9QUSMmsCtM3CcbQ4jKwHVuG+woxqGpz3h9ygKvuy73DC0Q@mail.gmail.com>
In-Reply-To: <CAD-N9QUSMmsCtM3CcbQ4jKwHVuG+woxqGpz3h9ygKvuy73DC0Q@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 7 Jun 2021 07:25:09 +0200
Message-ID: <CACT4Y+Yk614rYkVBF2k8toGM5fOuoMjBqGMtNjnKfsBxCVS6XA@mail.gmail.com>
Subject: Re: Comment on the patch of "memory leak in ath9k_hif_usb_firmware_cb"
To:     Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     syzbot <syzbot+6692c72009680f7c4eb2@syzkaller.appspotmail.com>,
        ath9k-devel@qca.qualcomm.com,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Jun 7, 2021 at 5:58 AM Dongliang Mu <mudongliangabcd@gmail.com> wrote:
>
> Hi Dmitry,
>
> I saw you have tested one patch [1] for "memory leak in
> ath9k_hif_usb_firmware_cb". And it does not trigger any bugs on the
> patched version. This is great. However, I find there are other
> similar code patterns in the same file below. Shall we fix other sites
> as well in the same patch?

Hi Dongliang,

Sure, if there are more bugs, it would be good to fix them.
It's always a good idea to check for similar code around when a bug is fixed.

> static void ath9k_hif_usb_dealloc_tx_urbs(struct hif_device_usb *hif_dev) [2]
>
> list_for_each_entry_safe(tx_buf, tx_buf_tmp,
> &hif_dev->tx.tx_buf, list) {
> usb_get_urb(tx_buf->urb);
> spin_unlock_irqrestore(&hif_dev->tx.tx_lock, flags);
> usb_kill_urb(tx_buf->urb);
> list_del(&tx_buf->list);
> usb_free_urb(tx_buf->urb);
> kfree(tx_buf->buf);
> kfree(tx_buf);
> spin_lock_irqsave(&hif_dev->tx.tx_lock, flags);
> }
>
> list_for_each_entry_safe(tx_buf, tx_buf_tmp,
> &hif_dev->tx.tx_pending, list) {
> usb_get_urb(tx_buf->urb);
> spin_unlock_irqrestore(&hif_dev->tx.tx_lock, flags);
> usb_kill_urb(tx_buf->urb);
> list_del(&tx_buf->list);
> usb_free_urb(tx_buf->urb);
> kfree(tx_buf->buf);
> kfree(tx_buf);
> spin_lock_irqsave(&hif_dev->tx.tx_lock, flags);
> }
>
> static void hif_usb_stop(void *hif_handle) [3]
>
> list_for_each_entry_safe(tx_buf, tx_buf_tmp,
> &hif_dev->tx.tx_pending, list) {
> usb_get_urb(tx_buf->urb);
> spin_unlock_irqrestore(&hif_dev->tx.tx_lock, flags);
> usb_kill_urb(tx_buf->urb);
> list_del(&tx_buf->list);
> usb_free_urb(tx_buf->urb);
> kfree(tx_buf->buf);
> kfree(tx_buf);
> spin_lock_irqsave(&hif_dev->tx.tx_lock, flags);
> }
>
> [1] https://syzkaller.appspot.com/text?tag=Patch&x=14107bbdd00000
> [2] https://elixir.bootlin.com/linux/latest/source/drivers/net/wireless/ath/ath9k/hif_usb.c#L769
> [3] https://elixir.bootlin.com/linux/latest/source/drivers/net/wireless/ath/ath9k/hif_usb.c#L439
>
> --
> My best regards to you.
>
>      No System Is Safe!
>      Dongliang Mu
