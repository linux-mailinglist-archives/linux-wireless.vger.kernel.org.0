Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74FEC1DE8D4
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2020 16:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730109AbgEVO05 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 May 2020 10:26:57 -0400
Received: from mail.as201155.net ([185.84.6.188]:39865 "EHLO mail.as201155.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728947AbgEVO05 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 May 2020 10:26:57 -0400
Received: from smtps.newmedia-net.de ([2a05:a1c0:0:de::167]:39799 helo=webmail.newmedia-net.de)
        by mail.as201155.net with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <s.gottschall@dd-wrt.com>)
        id 1jc8dR-0005lm-1r; Fri, 22 May 2020 16:26:53 +0200
X-CTCH-RefID: str=0001.0A782F23.5EC7E0CA.00C7,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=dd-wrt.com; s=mikd;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=DbxJdF/fC0ie2bU2CmMmxB+eVF48vM2t3Frd0ebJjtw=;
        b=BEym4zkyhgz1ePHt/W3fF+0aJduX36+kSzQH3gTLeg9wMIXM7NlRVbd/+lyuP80uCwHuZ0RvFu5wBFZnsWy5WImI3xV7vZRCDh9OpKeF959xQ6iQiI1YcmSNoCRyhMYrtdqXAmnHtOVrXKq2gea90iqwayAprbQHwtr1NsQzutE=;
Subject: Re: [PATCH v13] ath10k: add LED and GPIO controlling support for
 various chipsets
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Sven Eckelmann <sven@narfation.org>, ath10k@lists.infradead.org,
        John Crispin <john@phrozen.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        openwrt-devel@lists.openwrt.org,
        Sebastian Gottschall <s.gottschall@newmedia-net.de>,
        linux-wireless@vger.kernel.org
References: <1523027875-5143-1-git-send-email-kvalo@codeaurora.org>
 <2468724.JaAZLprVu6@bentobox>
 <b23e65cf-4be7-72db-7955-32eae196953e@dd-wrt.com>
 <87wo549sas.fsf@codeaurora.org>
From:   Sebastian Gottschall <s.gottschall@dd-wrt.com>
Message-ID: <0fd74998-751c-6ae1-3584-fce145ec8f84@dd-wrt.com>
Date:   Fri, 22 May 2020 16:26:50 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:77.0) Gecko/20100101
 Thunderbird/77.0
MIME-Version: 1.0
In-Reply-To: <87wo549sas.fsf@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Received:  from [2a01:7700:8040:4000:c77:c0ea:fb54:feed]
        by webmail.newmedia-net.de with esmtpa (Exim 4.72)
        (envelope-from <s.gottschall@dd-wrt.com>)
        id 1jc8ZN-0004RV-DI; Fri, 22 May 2020 16:22:41 +0200
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


Am 22.05.2020 um 12:29 schrieb Kalle Valo:
> (please don't top post)
>
> Sebastian Gottschall <s.gottschall@dd-wrt.com> writes:
>
>> this code is not in use in its original form for ipq4019. i have seen
>> that his patch is also dropped from ath.git but is still in use by
>> openwrt. could somone clarify the state here and why it was dropped?
> I dropped the patch because of the bug report from openwrt.
can you show me the bug report? and openwrt is still using it as out of 
tree patch which is confusing here.
personally i'm using the patch on qca988x, qca9884 and also ipq40xx 
devices (40xx doesnt make any use of it of course)

any chipset which doesnt make use of the gpio_pin definition is unable 
to make use of it. if there is no trigger set, its also not used (hopefully)

but in any way i'm willig to fix any issue of there is a reproduceable 
issue.

Sebastian

>
