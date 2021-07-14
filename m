Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D54DD3C7DFC
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jul 2021 07:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237911AbhGNFl4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Jul 2021 01:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237903AbhGNFlz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Jul 2021 01:41:55 -0400
Received: from mail.as201155.net (mail.as201155.net [IPv6:2a05:a1c0:f001::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE2D4C0613DD
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jul 2021 22:39:04 -0700 (PDT)
Received: from smtps.newmedia-net.de ([2a05:a1c0:0:de::167]:33180 helo=webmail.newmedia-net.de)
        by mail.as201155.net with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <s.gottschall@dd-wrt.com>)
        id 1m3XbU-0006Lw-1n; Wed, 14 Jul 2021 07:38:40 +0200
X-CTCH-RefID: str=0001.0A782F1A.60EE7860.0036,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=dd-wrt.com; s=mikd;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID; bh=hg3oPq25LK7mumyAQR3rHjMbizy2SNDDhrpngLZvRt8=;
        b=rzy0fFtw7CCfrcl3lCdsXKmxa1ldDa+Nw/lpx9eZ2kF+XcBgl8L9szPNDjsTW0Wky1Q+SalSW6OGfROvOOjccWoQgvJuOBLZW5PtI2rZmfaAlnlUZhtDIG9TukHlDjReR3HF5bNhXUyDpDCRAAORw6MZlaVNmxeC30kEUCbYvl8=;
Message-ID: <8a147d51-9dc0-5767-5d17-793845b9c5f7@dd-wrt.com>
Date:   Wed, 14 Jul 2021 07:38:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:90.0) Gecko/20100101
 Thunderbird/90.0
Subject: Re: [Bugreport] ath9k dynack not working/low performance on 5 & 10MHz
 Bandwidth
To:     Koen Vandeputte <koen.vandeputte@citymesh.com>,
        Petrosilius <petrosilius@posteo.de>,
        linux-wireless@vger.kernel.org
References: <dd49d9f7-db40-4ab7-f24d-6ab4bbd0bb54@posteo.de>
 <fd620847-9786-07d2-23be-dba4cedc9089@citymesh.com>
 <2ffcf571-7068-c06f-3879-d02eacdc4895@posteo.de>
 <8a3718e1-e988-c24a-d94f-34ba0f5349f4@citymesh.com>
 <339f7aa7-b7ee-b7a8-2e87-a96634c00a32@posteo.de>
 <bba886f3-4ce1-94b0-ea44-89ddc8c84e2b@citymesh.com>
 <ca99a4cc-eb7d-dfca-1d26-5b504a57e31f@posteo.de>
 <a7e37fa2-5fe7-6a39-d72d-9e3723540331@citymesh.com>
From:   Sebastian Gottschall <s.gottschall@dd-wrt.com>
In-Reply-To: <a7e37fa2-5fe7-6a39-d72d-9e3723540331@citymesh.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ACL-Warn: RATELIMIT reached, please don't send to many emails per minute
X-Received:  from [81.201.155.134] (helo=[172.29.0.186])
        by webmail.newmedia-net.de with esmtpsa (TLSv1:AES128-SHA:128)
        (Exim 4.72)
        (envelope-from <s.gottschall@dd-wrt.com>)
        id 1m3XbU-0007CW-93; Wed, 14 Jul 2021 07:38:40 +0200
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


>
>
> Above log is with an iperf session running in the background. :-s
>
> Will look further into this ..
>
> Regards,
>
> Koen
some cents from me. the chipset has a hw delay/latency which doubles and 
quadroubles depending on the channel width. this special offset needs to 
be considered for ack
timing calculation. especially at very short distances you will run into 
a problem that if this calculation is wrong, the ack timing register 
contains a lower value than the hw delay/latency.
this will result in a effective negative ack value. maybe its worth to 
check if the values used for this latency offset are correct?
i found also a patch in my own code which i made many years ago (i 
cannot remember why) but maybe it helps
@@ -1128,11 +1110,10 @@

                 slottime = ah->slottime;
         }
+
         /* As defined by IEEE 802.11-2007 17.3.8.6 */
         slottime += 3 * ah->coverage_class;
         acktimeout = slottime + sifstime + ack_offset;
+       eifs += (6 * ah->coverage_class);
         ctstimeout = acktimeout;

         /*

Sebastian

>
>
