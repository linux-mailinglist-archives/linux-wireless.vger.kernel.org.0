Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1F771A81A
	for <lists+linux-wireless@lfdr.de>; Sat, 11 May 2019 16:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbfEKO3R (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 11 May 2019 10:29:17 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:36277 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbfEKO3Q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 11 May 2019 10:29:16 -0400
Received: by mail-it1-f193.google.com with SMTP id e184so1453443ite.1
        for <linux-wireless@vger.kernel.org>; Sat, 11 May 2019 07:29:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gHoNFZn/tHV2iQLEYewjP4dMVMvO8BrKjwh6LbCkBV4=;
        b=Xa27Gpykq0yi4cRN/7gHwLjc6RtXdrGzWmx52QFFE3qWxHW1R/6EsVtrqSe6mc8R55
         Gyo3alzCD+QtRS3M8i8VW/uAmYSt9CBIBkdMUU/rUkb+5y84xzsHmq2al8k2QtjG02Fy
         y4KIz1+WnvFFTTXJXRx4yOXejMBiF6hgKxZ0b52LT04lzHO3RBwG6yLcIfQULlBHC/7F
         jB2afTJLP7KjO8CnHPNHB14QrMLGgs7VsINOroPFLwzoVtmj1mHQbNPG1f3TcXGB6Rne
         4XUSyYJcPCeaefkCRwOTAP2h3+ZhjZKeQi0zzv38nrHEmOoQI49i4OGGpI0Glg/URbaq
         BIcQ==
X-Gm-Message-State: APjAAAXqrYP2S8EdvfqfepP5LvkhDMLva6LbPeJpdfgkDxIXvu3rm4rW
        wjm/afVc8U8w/u/VsESn1HC0vD17pELaKhgV+IKA3Q9+AwA=
X-Google-Smtp-Source: APXvYqxWJswXwdavUnMtzPUyiB9I6P/HE5CweMSCb4rue0BZQor+E5lOnHVzpZCA02yhTdBi7l7OmJQOynAlzdBbRYg=
X-Received: by 2002:a24:b109:: with SMTP id o9mr2574378itf.68.1557584956124;
 Sat, 11 May 2019 07:29:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1557567465.git.lorenzo@kernel.org> <436469e1a4c1e0c11ae43a0b002378708d31f15d.1557567465.git.lorenzo@kernel.org>
 <97ef0073-6dae-f9d1-e97f-9aadaa629628@nbd.name>
In-Reply-To: <97ef0073-6dae-f9d1-e97f-9aadaa629628@nbd.name>
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Date:   Sat, 11 May 2019 16:29:05 +0200
Message-ID: <CAJ0CqmW8RyBmn1_-M0gQGvLOsTd45kAji7wmurs-GHBLac9Dyg@mail.gmail.com>
Subject: Re: [PATCH 4/4] mt76: mt76x02: run mt76x02_edcca_init atomically in mt76_edcca_set
To:     Felix Fietkau <nbd@nbd.name>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Stanislaw Gruszka <sgruszka@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

>
> On 2019-05-11 12:17, Lorenzo Bianconi wrote:
> > Run mt76x02_edcca_init atomically in mt76_edcca_set since it runs
> > concurrently with calibration work and mt76x2_set_channel.
> > Introduce __mt76x02_edcca_init helper routine
> >
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> I don't think this is enough. To prevent issues with calibration, we
> probably need to hold the mutex for the duration of the calibration
> anyway. Otherwise it might get enabled right in the middle of it and
> screw things up.
> Also, it probably simplifies the patch if you don't add the wrapper
> function that takes the mutex, and instead just explicitly take the
> mutex where needed.

So IIUC it would be better to hold the mutex during
mt76x2_phy_calibrate processing, right?
If so, do I need to repost all the series or just this patch?

Regards,
Lorenzo

>
> - Felix
