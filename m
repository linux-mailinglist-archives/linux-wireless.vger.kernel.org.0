Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B78295F1D
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2019 14:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729137AbfHTMr1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Aug 2019 08:47:27 -0400
Received: from webmail.newmedia-net.de ([185.84.6.166]:52214 "EHLO
        webmail.newmedia-net.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbfHTMr1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Aug 2019 08:47:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=newmedia-net.de; s=mikd;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:Subject; bh=2gnhK4xbdHAFlvVKqlM4Mz19FA53uH5ppVjRMviGBJE=;
        b=v6G91CqvFYB/I32H9b0iXASJsIxvdKC8QsfVWKfGJ/d0L0LzWpvap0S2ReFYqkQVPgWEPXEQx/dm53HomZdZObLb7C8zgzeG1SjyeIJyHicOETJWjxIpmKvIEP77c01QdbXq9DXdQioIAFJ/SgoMXpPPe8DYW6JcpZsK95vV+6s=;
Subject: Re: Implementing Mikrotik IE
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
References: <20190815152844.k5mmddvbwrohkzr6@pepin-laptop.localdomain>
 <3a079683-6f57-3b42-f909-90c46e14f14f@newmedia-net.de>
 <20190816111044.4ntizgmpa3twbzcg@pepin-laptop.localdomain>
 <e8129acb-fc32-c85c-b504-ab8777a3f1a3@newmedia-net.de>
 <20190816113818.ohktykc4fyetzyvq@pepin-laptop.localdomain>
 <9985fddfb059640f36665efc9c1ef2dc0bdb7662.camel@sipsolutions.net>
 <b8009787-a182-d5f2-6dde-ee540c65a03b@newmedia-net.de>
 <bb0d7dd87a7821df245919c86458bd50a3d1a81e.camel@sipsolutions.net>
From:   Sebastian Gottschall <s.gottschall@newmedia-net.de>
Message-ID: <ac1a7224-4732-4b6e-aa91-81e9d4b99142@newmedia-net.de>
Date:   Tue, 20 Aug 2019 14:46:26 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <bb0d7dd87a7821df245919c86458bd50a3d1a81e.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Received:  from [212.111.244.1] (helo=[172.29.0.186])
        by webmail.newmedia-net.de with esmtpsa (TLSv1:AES128-SHA:128)
        (Exim 4.72)
        (envelope-from <s.gottschall@newmedia-net.de>)
        id 1i03Xx-0006yi-HE
        for linux-wireless@vger.kernel.org; Tue, 20 Aug 2019 14:47:33 +0200
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


Am 20.08.2019 um 14:22 schrieb Johannes Berg:
> On Tue, 2019-08-20 at 13:53 +0200, Sebastian Gottschall wrote:
>
>> i was talking about a different scenario. its not about adding a
>> element, but to read it back for gui for instance. this is why i made a
>> patch which parses this special ie
>> and adds the radioname as extra element to the station table. this works
>> for ap as well of course. so iw ath0 station dump will print out the
>> radio name if available
> Oh. That's something I'd argue should just be implemented in hostapd
> then? No need to do anything in the kernel for that.
i know. thats why i never even tried to contribute it upstream. but from 
hostapd side it was more complicated than just hacking mac80211
and from stations a second mod for wpa_supplicant would be needed and 
since the dd-wrt webgui just uses nl80211 to show the station table
its more comportable and takes less code just todo it within the driver
i there is special interest in it i could of course try to clean it up 
and make a upstream patch out of it
>
> johannes
>
>
