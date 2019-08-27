Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF4159E8AE
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2019 15:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbfH0NJU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Aug 2019 09:09:20 -0400
Received: from webmail.newmedia-net.de ([185.84.6.166]:53227 "EHLO
        webmail.newmedia-net.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbfH0NJU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Aug 2019 09:09:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=newmedia-net.de; s=mikd;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=1uka5lm6+H8O8gpjjc+QzORwqmfq7rLlqsQrvV1+UNs=;
        b=fQFtQDJykntRasoxnQhifhNHSur+u9EWfiqKD0hTxVSHpQwc3XVPzdNwc9qvIpX5TItAYSyOTP33cXG2NzOOOTqnK8wVOPD3ye88DXYwJMTnG8vCRJHyoKOBlt/0nqOLTE8tvCqcN36asPf1x7cKVskIOfCZXXkO8eMSBkpAxas=;
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
 <6efb9b56c77cd9ea945f89c3371b49c301dc2b4e.camel@sipsolutions.net>
 <58A25955-2A17-4DE7-82FB-3B20E00C96EC@miegl.cz>
 <5ee160209eb1f9e70f6224c393389266280d7d80.camel@sipsolutions.net>
 <0452a0cbb36bcffa8371a58dfd931864c1f79eef.camel@sipsolutions.net>
 <68A3B9AF-8864-4C0F-A50B-71CCB76AE81D@miegl.cz>
From:   Sebastian Gottschall <s.gottschall@newmedia-net.de>
Message-ID: <21433c24-4860-be12-8d79-11e954e0bf9d@newmedia-net.de>
Date:   Tue, 27 Aug 2019 15:08:10 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <68A3B9AF-8864-4C0F-A50B-71CCB76AE81D@miegl.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Received:  from [212.111.244.1] (helo=[172.29.0.186])
        by webmail.newmedia-net.de with esmtpsa (TLSv1:AES128-SHA:128)
        (Exim 4.72)
        (envelope-from <s.gottschall@newmedia-net.de>)
        id 1i2bDy-0004Mc-H2; Tue, 27 Aug 2019 15:09:26 +0200
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


Am 22.08.2019 um 23:06 schrieb Josef Miegl:
> On August 22, 2019 10:08:13 PM GMT+02:00, Johannes Berg <johannes@sipsolutions.net> wrote:
>> On Thu, 2019-08-22 at 09:00 +0200, Johannes Berg wrote:
>>> Perhaps it expects the 4-way-HS to already be in 4-addr frame format,
>> or
>>> something else special in the 4-way-HS if you have WDS?
>> I think this is actually the right guess.
> Yes, it indeed it! Thank you so much Johannes!
good finding. my idea here is if we parse the wds flags field from mtik 
ie within mac80211 we could also support this special handing without 
any workaround

