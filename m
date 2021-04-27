Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCA8936C5B8
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Apr 2021 14:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235489AbhD0MFR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Apr 2021 08:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235391AbhD0MFR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Apr 2021 08:05:17 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA04EC061574;
        Tue, 27 Apr 2021 05:04:32 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id j10so159822lfb.12;
        Tue, 27 Apr 2021 05:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=PJPfUcrmI/ts1nrgT6EFm2T8l/O8vjn/wh3TdE9UtZ4=;
        b=jiKYXeQ77fGOYkuNW6ywk5fToVFsW3SzTelDCgkfW9PHEj+g5l+vdX2hLLuVP+3tCf
         6Cx2FPjUutw2Fpzqd/93T12/iIrCUHVt0Xco/tppVQSaEpXknC+GTJy/eUUZHuzb2v2f
         375iTGIGvgTWPpoT+qYOxnTU3Jlx4bPmkwgTofM736OvWiVk47h8szupuJDJgfF2XYrT
         WKocVhEjdrTLUcQeC1ZoT181WtYff7FibA5e//Sj2wSt8Qnr6ldUVIXOzBxQjCRVyKlU
         DaaU3vBdUTY0+Q02blMZ5lVfsOff2D7zhqpJfNEu8C3mGyiOkazzguqhIQXyT0RDmGuO
         0wMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=PJPfUcrmI/ts1nrgT6EFm2T8l/O8vjn/wh3TdE9UtZ4=;
        b=EKMkVM8aB9vLTB3SsEPR3fDXo5prt/CI0UTAIcoC61rkjkzS3FuBO9+iH04fI2jkPB
         ATLYblYNDfl5IoI1YyZ7ekq4Ufq5uS22UnJQnlOVBxS6vBLkbVfsCXGI/7Pcp8RNJq7c
         XuNt0pu19hGQiIL5bDd3xptRykeS1zN9ZuTCzqkYyeHeq8ERs+NDpoEV7B4jjKS/4IX9
         zNwiJenlLEmdNoZBTUIpykF/cG70UiL5GcsHY7c0wJSfhQuNGATR50v3aJPcQfVdMhvD
         SveJ6re5mAsI9eslQvJ7KyCaKAzU6NH+EOhpbnqtfcHESb1nUVkIEu1oybPiI119Vpmi
         kG2A==
X-Gm-Message-State: AOAM530G/k38Gp8mRR3UNQyUmIiJiI85QQaOxJ39hXjmwwEuLkYHYG77
        yDu6wUlZ+xt4iiaxejZn1Tw=
X-Google-Smtp-Source: ABdhPJxntEVZ2nlHDjJT+44NaVUAOYyfyd8/S14A+UrAcHDjuZa3SPsVvcWzfWoZod3dc9pBb6OJdA==
X-Received: by 2002:a19:c510:: with SMTP id w16mr85405lfe.433.1619525071270;
        Tue, 27 Apr 2021 05:04:31 -0700 (PDT)
Received: from [192.168.1.11] ([94.103.229.147])
        by smtp.gmail.com with ESMTPSA id u10sm1767128lfl.185.2021.04.27.05.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 05:04:30 -0700 (PDT)
Message-ID: <ec48c7d118a3093289907dc43f8dfb79d4879f7d.camel@gmail.com>
Subject: Re: Memory leak in ath9k_hif_usb_dealloc_tx_urbs()
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     Atul Gopinathan <atulgopinathan@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     brookebasile@gmail.com, ath9k-devel@qca.qualcomm.com,
        davem@davemloft.net, kuba@kernel.org, kvalo@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        syzbot+89bd486af9427a9fc605@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
Date:   Tue, 27 Apr 2021 15:04:29 +0300
In-Reply-To: <20210427113559.GA7527@atulu-nitro>
References: <20200911071427.32354-1-brookebasile@gmail.com>
         <20210330193652.10642-1-paskripkin@gmail.com> <YGQWf1lP4ZOUFiG5@kroah.com>
         <20210427113559.GA7527@atulu-nitro>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.0 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi!

On Tue, 2021-04-27 at 17:05 +0530, Atul Gopinathan wrote:
> On Wed, Mar 31, 2021 at 08:28:15AM +0200, Greg KH wrote:
> > On Tue, Mar 30, 2021 at 10:36:52PM +0300, Pavel Skripkin wrote:
> > > Hi!
> > > 
> > > I did some debugging on this
> > > https://syzkaller.appspot.com/bug?id=3ea507fb3c47426497b52bd82b8ef0dd5b6cc7ee
> > > and, I believe, I recognized the problem. The problem appears in
> > > case of
> > > ath9k_htc_hw_init() fail. In case of this fail all tx_buf->urb
> > > krefs will be
> > > initialized to 1, but in free function:
> > > 
> > > static void ath9k_hif_usb_dealloc_tx_urbs(struct hif_device_usb
> > > *hif_dev)
> > > 
> > > ....
> > > 
> > > static void ath9k_hif_usb_dealloc_tx_urbs(struct hif_device_usb
> > > *hif_dev)
> > > {
> > >     ...
> > >         list_for_each_entry_safe(tx_buf, tx_buf_tmp,
> > >                                  &hif_dev->tx.tx_buf, list) {
> > >                 usb_get_urb(tx_buf->urb);
> > >                 ...
> > >                 usb_free_urb(tx_buf->urb);
> > >                 ...
> > >                 }
> > > 
> > > Krefs are incremented and then decremented, that means urbs won't
> > > be freed.
> > > I found your patch and I can't properly understand why You added
> > > usb_get_urb(tx_buf->urb).
> > > Can You explain please, I believe this will help me or somebody
> > > to fix this ussue :)
> > 
> > I think almost everyone who has looked into this has given up due
> > to the
> > mess of twisty-passages here with almost no real-world benefits for
> > unwinding them :)
> 
> Just wanted to confirm, what is the status of this bug then, as in is
> it
> invalid (not sure if that's the correct word)? I happened to stumble
> across the same syzkaller bug report Pavel posted above, in the
> morning.
> Saw that there has been no patch tests/fixes on this yet according to
> syzkaller. Spent a couple of hours going through it before sending a
> test patch to syzbot which returned an "OK" (and the patch is exactly
> what Pavel pointed out, I simply removed the `usb_get_urb()`). Before
> sending anything to the mailing list, I made sure to search all the
> relavant networking lists to see if this topic had been brought up
> (learnt
> to do this from my preious mistakes of sending already accepted
> patches) and
> luckily I found this.
> 
> Syzbot has had 380 crashes caused by this bug, with the latest being
> today. So I wanted to confirm what should be done be about this bug. 
> 

I saw on dashboard, that Dmitry tested latest upstream commit and
syzbot returned "OK", but usb_get_urb(tx_buf->urb); is still there.

I think, this usb_get_urb prevents race condition, but I'm not sure
about it, that's why I sent an email to patch author. As You can see,
he has not responded yet :)

> Thank you!
> Atul

With regards,
Pavel Skripkin


