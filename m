Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 795D795DE7
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2019 13:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbfHTLyn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Aug 2019 07:54:43 -0400
Received: from webmail.newmedia-net.de ([185.84.6.166]:48579 "EHLO
        webmail.newmedia-net.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728771AbfHTLyn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Aug 2019 07:54:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=newmedia-net.de; s=mikd;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=VuoE3t0KeuPRrsMQRcqh6KVC581VByHkQ/fvcQi8doc=;
        b=NFt/Id4UnENqr/xOLSFJ7u3RfOQgQyvvUTZJg8RsJqsKBSuuBk9Gbx8bq5U6ZSDGEHZFyXkrYQ22GLE+/bM7Qt9pHcgW0kML/W38zT0VqZgbCFtnEAPx2Sv7Sz1WViJYgewBokJTFhOYGKTJl1NyffEP/uIoPM1yKbQcZYDkuho=;
Subject: Re: Implementing Mikrotik IE
To:     Johannes Berg <johannes@sipsolutions.net>,
        Josef Miegl <josef@miegl.cz>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
References: <20190815152844.k5mmddvbwrohkzr6@pepin-laptop.localdomain>
 <3a079683-6f57-3b42-f909-90c46e14f14f@newmedia-net.de>
 <20190816111044.4ntizgmpa3twbzcg@pepin-laptop.localdomain>
 <e8129acb-fc32-c85c-b504-ab8777a3f1a3@newmedia-net.de>
 <20190816113818.ohktykc4fyetzyvq@pepin-laptop.localdomain>
 <9985fddfb059640f36665efc9c1ef2dc0bdb7662.camel@sipsolutions.net>
From:   Sebastian Gottschall <s.gottschall@newmedia-net.de>
Message-ID: <b8009787-a182-d5f2-6dde-ee540c65a03b@newmedia-net.de>
Date:   Tue, 20 Aug 2019 13:53:41 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <9985fddfb059640f36665efc9c1ef2dc0bdb7662.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Received:  from [212.111.244.1] (helo=[172.29.0.186])
        by webmail.newmedia-net.de with esmtpsa (TLSv1:AES128-SHA:128)
        (Exim 4.72)
        (envelope-from <s.gottschall@newmedia-net.de>)
        id 1i02iv-0005tk-02; Tue, 20 Aug 2019 13:54:49 +0200
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


Am 19.08.2019 um 12:12 schrieb Johannes Berg:
> On Fri, 2019-08-16 at 13:38 +0200, Josef Miegl wrote:
>> On Fri, Aug 16, 2019 at 01:15:30PM +0200, Sebastian Gottschall wrote:
>>> in station mode you are right. you need to modify mac80211.
>> Even if I don't need to capture the IE back? All I want is to include
>> extra vendor IE in client assoc/reassoc frames. If this is something the
>> current wireless stack cannot do, perhaps it should be implemented.
> Contrary to what Sebastian states, it certainly is possible today,
> although not through wpa_supplicant's config file, only through the
> wpa_cli interface, using the VENDOR_ELEM_ADD command. There are various
> tests showing how to use this.
>
> johannes
i was talking about a different scenario. its not about adding a 
element, but to read it back for gui for instance. this is why i made a 
patch which parses this special ie
and adds the radioname as extra element to the station table. this works 
for ap as well of course. so iw ath0 station dump will print out the 
radio name if available
>
>
>
