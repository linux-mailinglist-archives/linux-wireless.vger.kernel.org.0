Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFD0917A73E
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Mar 2020 15:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbgCEOS6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Mar 2020 09:18:58 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:50949 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbgCEOS6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Mar 2020 09:18:58 -0500
Received: from marcel-macpro.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 91136CECEC;
        Thu,  5 Mar 2020 15:28:24 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH] mac80211_hwsim: add frame transmission support over
 virtio
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <eab92ed50b403437786244b664a99f04e341ecc1.camel@sipsolutions.net>
Date:   Thu, 5 Mar 2020 15:18:56 +0100
Cc:     linux-wireless@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <2C212BF0-D7EF-4BB3-940E-95F47A96704E@holtmann.org>
References: <20200305143212.c6e4c87d225b.I7ce60bf143e863dcdf0fb8040aab7168ba549b99@changeid>
 <2F7ADB4C-8C2C-4DEC-80AF-9E2D6B55CA88@holtmann.org>
 <c5319f6630be431c8680051fd4c33d59524683a2.camel@sipsolutions.net>
 <E37B1033-8525-422A-AF10-5EEE5988FE57@holtmann.org>
 <eab92ed50b403437786244b664a99f04e341ecc1.camel@sipsolutions.net>
To:     Johannes Berg <johannes@sipsolutions.net>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,

>> can we just make it a Kconfig option that defaults to 2, but gets set
>> to 0 when virtio support is included.
> 
> We could, I guess, but I don't understand why?
> 
> I don't understand why you think there should be any relation between
> virtio and the number of fake radios?
> 
> Basically, hwsim works like this:
> 
> There are a number of virtual radios (defaulting to two), which can
> communicate with each other. This communication can be
> 
> 1) handled inside the hwsim driver itself, "perfect" medium simulation
>   without any latency etc.
> 2) handled over netlink with wmediumd (running inside the same kernel),
>   i.e. calling out to userspace for all frame transmissions etc.
> 
> With this patch, in addition, the communication can be
> 
> 3) handled over virtio to wmediumd running *outside* the qemu (untested)
>   or user-mode-linux virtual machine.
> 
> 
> So you still need virtual radios inside, and virtio doesn't *create* any
> new virtual radios, it just provides the wmediumd communication
> mechanism. Regardless of virtio, you can have any number of virtual
> radios inside the kernel.

of course and I would prefer they are created by using genl or when you set the kernel module option to the number you want.

The default of 2 radios is just bugging me. I refrained from adding genl autoloading to mac80211_hwsim because of this 2 radios default. I would like to get that added as well.

Regards

Marcel


