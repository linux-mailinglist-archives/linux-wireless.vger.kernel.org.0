Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3F25107482
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2019 16:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfKVPHA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Nov 2019 10:07:00 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45860 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfKVPG7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Nov 2019 10:06:59 -0500
Received: by mail-lf1-f67.google.com with SMTP id 203so5719802lfa.12
        for <linux-wireless@vger.kernel.org>; Fri, 22 Nov 2019 07:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VO+YLNMAIEoxRmk/UyqbdtwE0IZv6AYTlMkmcRIkEWw=;
        b=GoVDPaPI8dp0Javlb9WRbrrED+qojdCWSLNSq2xVoIJsVpGMLRI6FIJk6MbfW11LN6
         CZV7dfItncugjRKpQ/zhs5pKIMh5qYQwMBMDhMDxbjp1sbma51awpILs1ObYT7kAXHvI
         I9g2wc9xUflozsqBGiB3o/x+HqDPDEskh8caM6J3R8/9Sy/Av2dNYg3/dileLaCviBX/
         zhSWL9WFGBGKZWjfox4TXrl4h59SLRxIqJ/7ut8vbmU31/XxXUA+BxFrhDB7zA8vVeVn
         F0boU64qC350m/miTumU+ap8/llxA9o09y3/7Bqalhbx5wVAdqJKjr2KtIZvP8T75Mew
         P9Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VO+YLNMAIEoxRmk/UyqbdtwE0IZv6AYTlMkmcRIkEWw=;
        b=ThteBJVOMhyphZBLhYGZ2Z1nwGBm5S9n7i/94/uwN7dI8zdf92nrWyMX1gN4BeqceN
         VcZWZyknGKzw2BhHlSi4fRjCo2gmY3Bw3NdafWyBSTGsL5XzGxZlfwZ0Epu+LuqxPoe3
         jEse4jiNgVv4SImPUntUFAhmE6kF8UkAQUeNxuYXIk3+pnIa59CLG0I5R4nuZjfidJoL
         4mvrMWoe7IXUjJwNDn5/4zRWSeMnxav94zz7InMIMWzs1qYpPZ5I5LvH3ABg/SGobXAa
         69BGocFk0zeB+2+zKCp9MpMFYEoQNwPI3Evvje9xB0QCDQGfYX8e7xCFaeqpfXOrslov
         icyA==
X-Gm-Message-State: APjAAAUGLDG/SP4APx87CIRkBsu7YvFG3O6EJhCdjaOXGQ7ZFjQOj5Cy
        pFbHALGN5HDX0eiamHIppi2BdTlJhRlg7GkK84qmn578kedZXxug
X-Google-Smtp-Source: APXvYqzA+/7avXd3KliLtmBEkqHZhPLICoaTwTaJaH1lOiMIuP2Nwai23/kIYhQs93wTp7lBjI2b6hRkNboTOYIOfE8=
X-Received: by 2002:ac2:43c7:: with SMTP id u7mr12115978lfl.71.1574435217902;
 Fri, 22 Nov 2019 07:06:57 -0800 (PST)
MIME-Version: 1.0
References: <20191119133451.14711-1-fredrik.olofsson@anyfinetworks.com> <e28361a05a275e999be17eb7ce659423db255497.camel@sipsolutions.net>
In-Reply-To: <e28361a05a275e999be17eb7ce659423db255497.camel@sipsolutions.net>
From:   Fredrik Olofsson <fredrik.olofsson@anyfinetworks.com>
Date:   Fri, 22 Nov 2019 16:06:46 +0100
Message-ID: <CADiFmNOFfjoZ9ah-_AyrJmKUvVoYjO3EfG9LqozZDFq4tUoZ-Q@mail.gmail.com>
Subject: Re: [PATCH] mac80211: fix overwriting of qos_ctrl.tid field
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Nov 22, 2019 at 1:00 PM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> On Tue, 2019-11-19 at 14:34 +0100, Fredrik Olofsson wrote:
> > Fixes overwriting of qos_ctrl.tid field for encrypted frames injected on
> > monitor interface. qos_ctrl.tid is protected by the encryption, and
> > cannot be modified after encryption. For injected frames, the encryption
> > key may not be available.
> >
> > Before passing the frame to the driver, the qos_ctrl.tid field is
> > updated from skb->priority. Prior to dbd50a851c50 skb->priority was
> > updated in ieee80211_select_queue_80211(), but this function is no longer
> > always called. This patch tries to mimmic the previous behaviour by
> > updating skb->priority in ieee80211_monitor_start_xmit().
>
> I'm not sure I understand.
>
> If the QoS field is overwritten (where, btw?) then wouldn't that still
> be done even after this change, and if the frame is pre-encrypted it is
> corrupted?

Thanks for your response, and sorry for being too terse.

What we are doing is injecting pre-encrypted frames on the monitor interface.
This used to work without issues (prior to the commit I mentioned). But now,
the QoS field is overwritten, corrupting the frame. Actually the overwriting
happened previously as well, but the QoS.TID field was not changed since it
was always overwritten with the same value as it already had. This
overwriting with the same value happens after my patch as well.

The simplified call flow for the frame is something like this:

netdev_core_pick_tx()
  if (dev->real_num_tx_queues != 1) {
    dev->ndo_select_queue()      <<< really: ieee80211_monitor_select_queue()
  }

...

ieee80211_monitor_start_xmit()
  ieee80211_xmit()
    ieee80211_set_qos_hdr()      <<< here the tid is overwritten
    ieee80211_tx()

But after dbd50a851c50, real_num_tx_queues == 1 and
ieee80211_monitor_select_queue() is never called. Then when the frame arrives
in ieee80211_set_qos_hdr() the qos.tid field is overwritten with the wrong
value. My patch makes sure ieee80211_set_qos_hdr() writes the same QoS.TID
value as was originally in the frame. Even if ieee80211_monitor_select_queue()
is not called.

My suggested patch tries to do the same as what happened before, but it may
not be the correct way to do this. Maybe real_num_queues should not be 1?
Maybe it would be better to detect the case that the frame is already
encrypted, and make sure not to touch any protected fields at all?

BR
/Fredrik
