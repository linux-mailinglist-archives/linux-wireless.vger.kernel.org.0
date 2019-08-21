Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25C01980D4
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2019 18:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729627AbfHUQ7d convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Aug 2019 12:59:33 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:43766 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfHUQ7c (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Aug 2019 12:59:32 -0400
Received: from marcel-macpro.fritz.box (p4FEFC580.dip0.t-ipconnect.de [79.239.197.128])
        by mail.holtmann.org (Postfix) with ESMTPSA id BAD9CCECE5;
        Wed, 21 Aug 2019 19:08:14 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: Flag for detecting 802.11r Fast BSS Transition support
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CA+ASDXPhX3Yet=dJn8Pet_inP1uyueFZqBmuNXvmTrjv1r497g@mail.gmail.com>
Date:   Wed, 21 Aug 2019 18:59:29 +0200
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Matthew Wang <matthewmwang@google.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Kirtika Ruchandani <kirtika@google.com>,
        Jouni Malinen <j@w1.fi>
Content-Transfer-Encoding: 8BIT
Message-Id: <FB8ED8A5-6606-4818-9A44-8944C5DC0E96@holtmann.org>
References: <CAAooHFeLWrY_wmCp-HWqygh8gnKsfpoPCky7SykOBKZgXkb8OQ@mail.gmail.com>
 <20190403210200.GA93453@google.com>
 <211816ff03cf188d834a21b1fbc98b4f8c5b81f4.camel@sipsolutions.net>
 <CA+ASDXOyXb0dPGOrjQR7C-b6dyftiZhkta3cwG28B9sC5wxHxQ@mail.gmail.com>
 <7687225C-D965-479E-BAE8-769B0AEADD76@holtmann.org>
 <CA+ASDXNC0hwFzSTvZmUq-B7r_H+pZ3N=p_kjfMqKb1gftsmDKw@mail.gmail.com>
 <7CCE8D56-9E1A-4E04-9C28-E384C1B2E2EA@holtmann.org>
 <CA+ASDXPhX3Yet=dJn8Pet_inP1uyueFZqBmuNXvmTrjv1r497g@mail.gmail.com>
To:     Brian Norris <briannorris@chromium.org>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Brian,

>> And if you have a distribution or an OEM that cares, then that is what is going to happen.
> 
> I can see where you might not be particularly sympathetic to this
> concern, but where I re-started this thread, I added in Jouni, due to
> his mention of:
> 
> "There are such drivers [supporting FT] especially in number of
> Android devices and I'd
> rather not break those use cases.." [1]
> 
> That doesn't exactly sound like a case where he's willing to break
> compatibility with older kernels in new wpa_supplicant. But maybe I
> shouldn't put words in his mouth. (On the other hand, Android systems
> are likely to not ever get either kernel *or* wpa_supplicant version
> upgrades, so maybe it's not really a problem at all!)
> 
> Anyway, I'll just cook a patch, and then figure out whether/how I can
> teach wpa_supplicant to respect it. (Or, continue forking
> wpa_supplicant as we have been wont to do...)

it would be beneficial for iwd and not just wpa_supplicant.

The try-and-error method is not really working for iwd since we are 100% event driven. It is important that we get told what is supported and what not before trying to connect or roam.

Regards

Marcel

