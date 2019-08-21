Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF6CA98543
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2019 22:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbfHUULE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Aug 2019 16:11:04 -0400
Received: from webmail.newmedia-net.de ([185.84.6.166]:54706 "EHLO
        webmail.newmedia-net.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfHUULD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Aug 2019 16:11:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=newmedia-net.de; s=mikd;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=nWSA0ktBIQpQm7r/d7XCsFYmZ4p239izdlVvnHraIM0=;
        b=P9GMEVHd6yjp+m6S9xYhc0t/U1dGxxDFH+eQFr/IFuLzSCvgHPT1FOaOfGOzA4wx00qyMq1BJTNkD05xB82OCo/VZp6v+SVbGL//6YMv0n0FuZKYkvo2SzbG3OjiO8pnOE5pWzpJnrWed5WVXAAXvzqS4x2m2xK61LiWG2BoWtg=;
Subject: Re: Implementing Mikrotik IE
To:     Josef Miegl <josef@miegl.cz>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
References: <20190815152844.k5mmddvbwrohkzr6@pepin-laptop.localdomain>
 <3a079683-6f57-3b42-f909-90c46e14f14f@newmedia-net.de>
 <20190816111044.4ntizgmpa3twbzcg@pepin-laptop.localdomain>
 <e8129acb-fc32-c85c-b504-ab8777a3f1a3@newmedia-net.de>
 <20190816113818.ohktykc4fyetzyvq@pepin-laptop.localdomain>
 <9985fddfb059640f36665efc9c1ef2dc0bdb7662.camel@sipsolutions.net>
 <20190819113706.ujsz67sxcwt2ulmt@pepin-laptop.localdomain>
 <b3b7a99971f1512b4cd9c72920b699c252c1ae83.camel@sipsolutions.net>
 <A3C14EA9-BA2D-4745-BBB9-E10028B6DE13@miegl.cz>
From:   Sebastian Gottschall <s.gottschall@newmedia-net.de>
Message-ID: <b0868ded-c013-e295-a013-b87bf210b30b@newmedia-net.de>
Date:   Wed, 21 Aug 2019 22:09:59 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <A3C14EA9-BA2D-4745-BBB9-E10028B6DE13@miegl.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Received:  from [2003:c9:3f25:1300:a06f:f0aa:4c30:8a4c]
        by webmail.newmedia-net.de with esmtpsa (TLSv1:AES128-SHA:128)
        (Exim 4.72)
        (envelope-from <s.gottschall@newmedia-net.de>)
        id 1i0Wwn-0005O6-PH; Wed, 21 Aug 2019 22:11:09 +0200
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


Am 21.08.2019 um 22:04 schrieb Josef Miegl:
> On August 19, 2019 10:21:55 PM GMT+02:00, Johannes Berg <johannes@sipsolutions.net> wrote:
>> I don't know, try capturing over the air?
>>
>> Perhaps the vendor IEs added this way are added *first* before all the
>> RSN IEs, and that's tripping up your AP, and you'd have to add them
>> *after* the normal elements? Not really sure where/how they're added?
>>
>> johannes
> The vendor elements are added at the very end of the frame. In fact I tried moving the RSN IE to the end of the frame so that the frame is similar to the one ubnt airos produces. No luck either. One thing I've learned is that ubnt airos assoc req frames have the WMM/WME IE placed before HT Capabilities. But I'm not sure how to move it and also not sure if it would actually work.
>
> I am getting 4WAY_HANDSHAKE_TIMEOUT. From capturing I can see the station sends Key (msg 2 of 4) and a bunch of acknowledgements, but it never sends Key (msg 4 of 4) afterwards.
>
> I feel like I'm stuck.. What could be the reason for this behaviour?
i can just tell you that i added the mikrotik ie just before the wmm ie 
but after ht/vht ie

> Josef
>
