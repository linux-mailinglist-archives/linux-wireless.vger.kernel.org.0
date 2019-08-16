Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFBE90095
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2019 13:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbfHPLQa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Aug 2019 07:16:30 -0400
Received: from webmail.newmedia-net.de ([185.84.6.166]:44342 "EHLO
        webmail.newmedia-net.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbfHPLQa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Aug 2019 07:16:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=newmedia-net.de; s=mikd;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject; bh=tFTfGcYy+C2a4DEjqq74yYWQrKHZc3coJrXJ95LloyE=;
        b=JhQB61d4WwFR0tLEgo2MNTmH8F66R3tcAZMWUAb3NUYIWXC0OJqP4hVyw+WvZrUBaeKhRfzeLk28QHvdFcaVw7yBoMXa9YIRHKBlbRD+uInpwva35yiup7XinouWUhT0YAnzq3LyfAY34g3ckY7Cud1qjGy6byf5ZDVfa5uS350=;
Subject: Re: Implementing Mikrotik IE
To:     Josef Miegl <josef@miegl.cz>,
        linux-wireless <linux-wireless@vger.kernel.org>
References: <20190815152844.k5mmddvbwrohkzr6@pepin-laptop.localdomain>
 <3a079683-6f57-3b42-f909-90c46e14f14f@newmedia-net.de>
 <20190816111044.4ntizgmpa3twbzcg@pepin-laptop.localdomain>
From:   Sebastian Gottschall <s.gottschall@newmedia-net.de>
Message-ID: <e8129acb-fc32-c85c-b504-ab8777a3f1a3@newmedia-net.de>
Date:   Fri, 16 Aug 2019 13:15:30 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190816111044.4ntizgmpa3twbzcg@pepin-laptop.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Received:  from [212.111.244.1] (helo=[172.29.0.186])
        by webmail.newmedia-net.de with esmtpsa (TLSv1:AES128-SHA:128)
        (Exim 4.72)
        (envelope-from <s.gottschall@newmedia-net.de>)
        id 1hyaDj-0000GN-F7; Fri, 16 Aug 2019 13:16:35 +0200
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


Am 16.08.2019 um 13:10 schrieb Josef Miegl:
> Hello,
> setting vendor elements in hostapd works great - but I need to add these
> custom elements to assoc/reassoc management frames in station mode.
> Given that the vendor elements option in hostapd works great would it be
> possible to patch wpa_supplicant for it to work in station mode too?
>
> Does nl80211 allow setting NL80211_ATTR_IE for station mode management
> frames?
in station mode you are right. you need to modify mac80211. i have a mod 
for mikrotik ie for ap and station implemented in mac80211.
i can send you a drop of my mac80211 tree which is not compatible with 
upstream. but it will allow you to take off whatever you need to patch 
it since such a

patch will never be accepted upstream. it adds a new field to the 
station table which shows the radioname and broadcasts the radioname on 
ap side. this has been tested
with ath9k and ath10k so far an works as expected. i modified also the 
iw tool to show the informations

>
> Also what are the 'evil hacks' you are talking about?
to capture the ie from station side i have to keep the information in a 
special static linked list per mac address. i cannot use the typical 
mac802.11 structures for this. so its a little bit weired design to 
bring it
to the station table finally. so not best design, but its working
>
> On Fri, Aug 16, 2019 at 06:07:02AM +0200, Sebastian Gottschall wrote:
>> Hello
>>
>> Since i already have done this for dd-wrt for mac80211 i can tell you, its
>> not easy but possible. the most easy way for broadcasting a custom IE
>> is just adding a custom IE with its properties to the hostapd configuration.
>> it does allow to set such properties
>> so you dont need to change anything in mac80211 which requires some evil
>> hacks
>>
>> Am 15.08.2019 um 17:28 schrieb Josef Miegl:
>>> I've been trying to implement Mikrotik IE. It is a vendor IE that
>>> carries stuff like radio name. Even though it is Mikrotik specific, UBNT
>>> has a patch for madwifi:
>>> https://github.com/jhairtt/ubnt-hal-0.7.379/blob/master/patches/madwifi-dfs-r3319-20080201/074-mtik-ie.patch
>>>
>>> The IE is sent in beacon and assoc/reassoc frames. I think the correct
>>> place for this is mac80211, but I'm not sure how should I expose a
>>> switch to this functionality. Is there something like ioctl, or do I have
>>> to implement a switch in nl80211, then in cfg80211 and then finally in
>>> mac80211?
>>>
>>> Any advice is greatly appreciated.
>>>
