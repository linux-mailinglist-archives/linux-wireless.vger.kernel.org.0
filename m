Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B189A11F464
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Dec 2019 23:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfLNWAP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 14 Dec 2019 17:00:15 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57142 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726713AbfLNWAP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 14 Dec 2019 17:00:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576360813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3RaYgybIB5LdwY6KgrjBQCvjk6q9t8Rk6RU0GRLpATU=;
        b=I3D8oSKTM8I+jjnjfAwEtWP2oMJS7nWVZbI6VZwD2MRPp31I/45q5ONWZT42vXJgOLgWtx
        zG0B8zlakWKOZRLBolUYHzQCMwEScz8UJ8yY/lAHM+VpKzKqyJJvEokDvDsD7ummm6KJ0X
        kIhbLcEl45clkKHh6kgntXj6QS+5EFI=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-117-5SRX7NPGMBCFvohl2Sp3Dg-1; Sat, 14 Dec 2019 17:00:10 -0500
X-MC-Unique: 5SRX7NPGMBCFvohl2Sp3Dg-1
Received: by mail-il1-f199.google.com with SMTP id s9so2937477ilk.0
        for <linux-wireless@vger.kernel.org>; Sat, 14 Dec 2019 14:00:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3RaYgybIB5LdwY6KgrjBQCvjk6q9t8Rk6RU0GRLpATU=;
        b=snrwU+/lGYk99lYm4/1U/Dr9TpYAQt1fbYNVXzjlRquvSVvIh4AMTg77mVIn+XenXw
         6Ffa3EuUEc/ocOuyGjYCbZfU58QE1xq9zzbfJ/ndmHWtEDVij0J4lc+1SIswpHMcSIHv
         mBE/EisseWwV0CN2BTjBUljLDT9Q1bNzHjl2OV8fO7QvmH4Ob7heRf+Y26Yn+7uzdFjC
         eljXuTSS7j7n1eNROWzoRaGJTW2EbO0ht6bsQLeYQrjTAdoQP5reFoKufrqMSHluwvD/
         8H1LHmXtLEBkbJXsLORa5NqX2kjQxw4w3MBGjeQf/y/8NaZC5nX+7TxzR4FE6EAF49eY
         KVaA==
X-Gm-Message-State: APjAAAXyWEaGSvXs4L3GXtB0O/55rFNHFgJ/1HSVpmFPjlmt49s63VcR
        i+ZsN4N3QYjST2Yrbn09QFh5PbuDEPzKOmFiVlPpITMomg04qKEhuBYFvKR1flWq7YAlaaO7T3L
        7VhZYmcGsctoCgdNXdIqAgRpz1WCmlarG1VrXu+3EQug=
X-Received: by 2002:a92:8991:: with SMTP id w17mr1130414ilk.12.1576360809573;
        Sat, 14 Dec 2019 14:00:09 -0800 (PST)
X-Google-Smtp-Source: APXvYqyFXqVrqiCQlYhYXDpz8wA+PwbY/JboDE5ZEYUKZDeW90leCu26ViDAnaw+K8W8eqlfn/1o1xV7dUzX2a+o8vE=
X-Received: by 2002:a92:8991:: with SMTP id w17mr1130394ilk.12.1576360809344;
 Sat, 14 Dec 2019 14:00:09 -0800 (PST)
MIME-Version: 1.0
References: <378747af00fdd3e64e9f5d7724f1b84759f95e8f.1576074028.git.lorenzo@kernel.org>
 <20c2faaa-7709-8486-a799-02e6ce5b7ef9@nbd.name>
In-Reply-To: <20c2faaa-7709-8486-a799-02e6ce5b7ef9@nbd.name>
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Date:   Sat, 14 Dec 2019 22:59:59 +0100
Message-ID: <CAJ0CqmXqqu1UC610vG9sMBdw4ZZn5uvJ09=m7SXpegZkcMP=MA@mail.gmail.com>
Subject: Re: [PATCH] mt76: mt7615: introduce LED support
To:     Felix Fietkau <nbd@nbd.name>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

>
> On 2019-12-11 15:21, Lorenzo Bianconi wrote:
> > Initialize brightness_set and blink_set callbacks to
> > mt7615_led_set_brightness and mt7615_led_set_blink in order to enable
> > LED support in mt7615 driver
> >

[...]

> >  #define MT_TX_AGG_CNT(n)             MT_WF_MIB(0xa8 + ((n) << 2))
> >
> > +#define MT_LED_BASE_PHYS             0x80024000
> > +#define MT_LED_PHYS(_n)                      (MT_LED_BASE_PHYS + (_n))
> > +
> > +#define MT_LED_CTRL                  MT_LED_PHYS(0x00)
> > +
> > +#define MT_LED_CTRL_REPLAY(_n)               BIT(0 + (8 * (_n)))
> > +#define MT_LED_CTRL_POLARITY(_n)     BIT(1 + (8 * (_n)))
> > +#define MT_LED_CTRL_TX_BLINK_MODE(_n)        BIT(2 + (8 * (_n)))
> > +#define MT_LED_CTRL_TX_MANUAL_BLINK(_n)      BIT(3 + (8 * (_n)))
> > +#define MT_LED_CTRL_TX_OVER_BLINK(_n)        BIT(5 + (8 * (_n)))
> > +#define MT_LED_CTRL_KICK(_n)         BIT(7 + (8 * (_n)))
> > +
> > +#define MT_LED_STATUS_0(_n)          MT_LED_PHYS(0x10 + ((_n) * 8))
> > +#define MT_LED_STATUS_1(_n)          MT_LED_PHYS(0x14 + ((_n) * 8))
> > +#define MT_LED_STATUS_OFF_MASK               GENMASK(31, 24)
> > +#define MT_LED_STATUS_OFF(_v)                (((_v) << \
> > +                                       __ffs(MT_LED_STATUS_OFF_MASK)) & \
> > +                                      MT_LED_STATUS_OFF_MASK)
> > +#define MT_LED_STATUS_ON_MASK                GENMASK(23, 16)
> > +#define MT_LED_STATUS_ON(_v)         (((_v) << \
> > +                                       __ffs(MT_LED_STATUS_ON_MASK)) & \
> > +                                      MT_LED_STATUS_ON_MASK)
> > +#define MT_LED_STATUS_DURATION_MASK  GENMASK(15, 0)
> > +#define MT_LED_STATUS_DURATION(_v)   (((_v) << \
> > +                                       __ffs(MT_LED_STATUS_DURATION_MASK)) &\
> > +                                      MT_LED_STATUS_DURATION_MASK
>
> Why are you using separate _MASK fields and macros using __ffs in
> bitshift instead of FIELD_PREP like the rest of the code?
>

ack, I will fix it in v2.

Regards,
Lorenzo

> - Felix
>

