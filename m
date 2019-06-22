Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 583A84F5F6
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Jun 2019 15:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbfFVNoK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 22 Jun 2019 09:44:10 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:44116 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbfFVNoK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 22 Jun 2019 09:44:10 -0400
Received: from marcel-macpro.fritz.box (p4FEFC3D2.dip0.t-ipconnect.de [79.239.195.210])
        by mail.holtmann.org (Postfix) with ESMTPSA id 6EE3FCF184;
        Sat, 22 Jun 2019 15:52:37 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v2 2/3] nl80211: Limit certain commands to interface owner
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <b1ae8df6-c8a7-e453-aad3-e31bb2e3bd60@broadcom.com>
Date:   Sat, 22 Jun 2019 15:44:09 +0200
Cc:     Denis Kenzior <denkenz@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <011C968F-507F-4646-B206-C28BDE7EB4A0@holtmann.org>
References: <20190620220749.10071-1-denkenz@gmail.com>
 <20190620220749.10071-2-denkenz@gmail.com>
 <11852f40-67e5-9122-7d82-077bdd0b014a@broadcom.com>
 <af810765-ba1a-c7ae-abe5-35eef72eb8ce@gmail.com>
 <b1ae8df6-c8a7-e453-aad3-e31bb2e3bd60@broadcom.com>
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Arend,

>>>> If the wdev object has been created (via NEW_INTERFACE) with
>>>> SOCKET_OWNER attribute set, then limit certain commands only to the
>>>> process that created that wdev.
>>>> 
>>>> This can be used to make sure no other process on the system interferes
>>>> by sending unwanted scans, action frames or any other funny business.
>>> 
>>> The flag is a good addition opposed to having handlers deal with it. However, earlier motivation for SOCKET_OWNER use was about netlink multicast being unreliable, which I can agree to. However, avoiding 
>> ???  I can't agree to that as I have no idea what you're talking about :)  Explain?  SOCKET_OWNER was introduced mainly to bring down links / scans / whatever in case the initiating process died.  As a side effect it also helped in the beginning when users ran iwd + wpa_s simultaneously (by accident) and all sorts of fun ensued.  We then re-used SOCKET_OWNER for running EAPoL over NL80211.  But 'multicast unreliability' was never an issue that I recall?
> 
> hmm. I tried searching in memory... of my email client but to no avail. I somehow recalled that netlink multicast was not guaranteed to be delivered/seen by all listeners.
> 
>>> "funny business" is a different thing. Our testing infrastructure is doing all kind of funny business. Guess we will need to refrain from 
>> So you're going behind the managing daemon's back and messing with the kernel state...  I guess the question is why?  But really, if wpa_s wants to tolerate that, that is their problem :)  iwd doesn't want to, nor do we want to deal with the various race conditions and corner cases associated with that.  Life is hard as it is ;)
> 
> That's just it, right. This is what Marcel calls the real environment, but is it. The nl80211 is a kernel API and should that mean that there must be a managing daemon locking down APIs for other user-space tools to use. If I want a user-space app to show a radar screen with surrounding APs using scanning and FTM nl80211 commands it seems now it has to create a new interface and hope the resources are there for it to succeed. Where is my freedom in that? If I am using such an app don't you think I don't accept it could impact the managing daemon.

if you are operating on a shared radio resource you have to have some way of ensuring that nobody steals resources from you. Having an external application that will also use scanning and other off-channel operation will result in a bad experience. Especially if it involves scanning. Currently we still have 3 or more parties triggering scanning on nl80211. Essentially they are now fighting for radio time. You have wpa_supplicant scanning, you have NetworkManager scanning and you have the UI scanning. Now adding just another application that just scans at its decided time location / direction finding is not helping the situation.

If our kernel cfg80211 / nl80211 would be smart enough to handle these concurrent tasks, I would have little objection to let all clients do whatever they want, but we don’t have that. I do not want an external application messing with my planned radio time. And frankly if I am in the middle of roaming, I don’t want to be delayed because some fancy radar looking UI decides to start a full spectrum scan or blocks us via an action frame that times out.

With iwd we are moving towards the direction that we are utilizing the information from access points and surrounding networks to intelligently scan and reduce the time spent scanning to a minimum. For us that is the way to improve WiFi experience for Linux.

We have been through this with Bluetooth already years ago. You need a central daemon that watches out for your radio utilization. Doing anything behind the back of such a daemon is not going to work out long term. Same applies to 2G/3G/LTE where even more tasks need to be managed. And even wpa_supplicant has an internal mutex to control radio time.

Regards

Marcel

