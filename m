Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 157C9178E48
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Mar 2020 11:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbgCDKVy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Mar 2020 05:21:54 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46571 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728301AbgCDKVy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Mar 2020 05:21:54 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1j9RA0-0000XK-BK; Wed, 04 Mar 2020 11:21:52 +0100
Date:   Wed, 4 Mar 2020 11:21:52 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: Support for RTL8188FU
Message-ID: <20200304102152.a25cczvat2mujxwa@linutronix.de>
References: <20191001160305.qrl4nt2jmdsogaaz@linutronix.de>
 <3af284c7-ee46-dd42-9549-de55feae2528@lwfinger.net>
 <20191001174612.4kj3mt3h5epidyyk@linutronix.de>
 <b958b669-a683-d7cd-6bbf-bfe3e674f62d@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b958b669-a683-d7cd-6bbf-bfe3e674f62d@lwfinger.net>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-10-01 13:52:30 [-0500], Larry Finger wrote:
> The first thing I would do is clone the v5.2.2.4 branch of
> lwfinger/rtl8188eu at GitHub, add the USB ID for your device, and see if
> that works. I expect it will. If so, that would get you quite a ways toward
> the changes needed to get that driver into staging.

Adding the id didn't help. I added "hal/Hal8188FPwrSeq.o" next to
"hal/Hal8188EPwrSeq.o". Some parts were different.
After loading the firmware the driver said that the firmware wasn't
active. So I tweaked the firmware loading part a little. The signature
of the firmware in my driver is 0x88F0 instead of 0x88E0 and the
"normal-nic" firmware has 20306 bytes. By loading the "other" firmware
the firmware and driver says that it is "alive".
I disabled the "IOL" bits (like rtw_IOL_applied() which returns false).
It took long and didn't seem to succeed. My driver lacks most of the
code, rtw_IOL_applied() isn't referenced anyway and the ifdef isn't set.

I would continue to add more pieces in order to get it working unless
you have a different advice.

> Larry

Sebastian
