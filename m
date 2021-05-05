Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAF3373772
	for <lists+linux-wireless@lfdr.de>; Wed,  5 May 2021 11:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbhEEJ0s (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 May 2021 05:26:48 -0400
Received: from mx3.wp.pl ([212.77.101.9]:9263 "EHLO mx3.wp.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231265AbhEEJ0s (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 May 2021 05:26:48 -0400
Received: (wp-smtpd smtp.wp.pl 10517 invoked from network); 5 May 2021 11:25:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1620206743; bh=0DHFPVUStvLSlb57dCHneQ09yY+fjSTyKhaClJA57BM=;
          h=From:To:Cc:Subject;
          b=F0xjsOHrhGl1LRY851fHhuQ7K0uLH7aA8YInAlqSteBEm3UhZPTYDlZP0rSnTJ1at
           sKW82AmAauMTeQp7X590vyzmJR65wicqyryD9ctDnHNt/qxC7gUKVMi6devUWc2HWE
           gf6WvuCWHhZMmdF3xflP7Xo4xTPSyNvk/igUwkzI=
Received: from 89-64-4-144.dynamic.chello.pl (HELO localhost) (stf_xl@wp.pl@[89.64.4.144])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <rsalvaterra@gmail.com>; 5 May 2021 11:25:43 +0200
Date:   Wed, 5 May 2021 11:25:42 +0200
From:   Stanislaw Gruszka <stf_xl@wp.pl>
To:     Rui Salvaterra <rsalvaterra@gmail.com>
Cc:     lorenzo@kernel.org, kuba@kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [RFC PATCH] mt7601u: make the driver work again
Message-ID: <20210505092542.GA757514@wp.pl>
References: <20210504212828.815-1-rsalvaterra@gmail.com>
 <20210505045044.GA735251@wp.pl>
 <CALjTZvYZ8Rr-UFyqFststt+vG+Ei1avUvPVxQwHe72QU0NEeKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALjTZvYZ8Rr-UFyqFststt+vG+Ei1avUvPVxQwHe72QU0NEeKA@mail.gmail.com>
X-WP-MailID: 31bd9950263e1bacc3489e19d628ed48
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000002 [cTGx]                               
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi

On Wed, May 05, 2021 at 09:01:52AM +0100, Rui Salvaterra wrote:
> On Wed, 5 May 2021 at 05:50, Stanislaw Gruszka <stf_xl@wp.pl> wrote:
> >
> > I'm not sure if DPD calibration is needed. Maybe is ok to disable it for
> > all MT7601U devices. However safer fix would be doing it only for
> > devices that know to need it for work. For example: add dev->no_dpd_cal
> > variable, set it based on USB ID (using usb_device_id->driver_info) and
> > do not perfrom calibration when it's set.
> 
> Hm… the struct usb_device already contains a u32 quirks. Shouldn't it
> be used instead, or is it used for an entirely different set of
> quirks?

Yes, those u32 quirks are used to change behaviour of usb-core module
and we should not interfere with them. We need quirk for mt7601u driver.

> > Also please clarify "work again" in the topic. Have your device ever
> > worked with mt7601u driver in some older kernel version?
> 
> Personally, my devices never worked. I ordered a bunch of them
> dirt-cheap from AliExpress, in early 2019. I needed one for my RPi,
> running OpenWrt 19.07 (Linux 4.19), but it failed the same way. I
> thought it might be a problem with the driver on ARM, I replaced it
> with a Ralink adapter and it worked fine. I hadn't used the devices
> until a couple of days ago, when I needed to connect a x86 machine and
> saw the exact same error I had seen on the Pi.

Ok, please correct the topic of the patch when you'll be posting next
version. 

Thanks
Stanislaw
