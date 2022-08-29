Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9CD45A5590
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Aug 2022 22:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbiH2Uby convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Aug 2022 16:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiH2Ubu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Aug 2022 16:31:50 -0400
Received: from xmail.hs-nordhausen.de (xmail.hs-nordhausen.de [195.37.89.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98FAA88DF4
        for <linux-wireless@vger.kernel.org>; Mon, 29 Aug 2022 13:31:46 -0700 (PDT)
Received: from smtpclient.apple (10.1.10.8) by db1.ad.hs-nordhausen.de
 (10.1.10.3) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Mon, 29 Aug
 2022 22:31:43 +0200
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [RFC 0/4] mac80211: add TPC support in control path
From:   =?utf-8?Q?Thomas_H=C3=BChn?= <thomas.huehn@hs-nordhausen.de>
In-Reply-To: <D322E049-6B08-402D-AB95-982363369028@gmail.com>
Date:   Mon, 29 Aug 2022 22:31:42 +0200
CC:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "nbd@nbd.name" <nbd@nbd.name>
Content-Transfer-Encoding: 8BIT
Message-ID: <541C02C5-058F-42CD-9CBB-14926C981543@hs-nordhausen.de>
References: <20220829144147.484787-1-jelonek.jonas@gmail.com>
 <5175b7f95442eff1f8e899feee3d3aeb330fb61e.camel@sipsolutions.net>
 <5AA24131-A7E9-451D-97AB-97D925B2A53A@hs-nordhausen.de>
 <8867d4a7552fc036da51ef5451ead1fd4df7f139.camel@sipsolutions.net>
 <50d80bebabe0ce2413af89af7bf45321ac7f0d6b.camel@sipsolutions.net>
 <D322E049-6B08-402D-AB95-982363369028@gmail.com>
To:     Jonas Jelonek <jelonek.jonas@gmail.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Originating-IP: [10.1.10.8]
X-ClientProxiedBy: db1.ad.hs-nordhausen.de (10.1.10.3) To
 db1.ad.hs-nordhausen.de (10.1.10.3)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

hiho

> On 29. Aug 2022, at 17:19, Jonas Jelonek <jelonek.jonas@gmail.com> wrote:
> 
> Good point, definitely makes sense.
> 
> Would this be sufficient as an implementation for this RFC?
> 
> Greetings
> Jonas

lets stick to not doing top posts ;)

> 
>> On 29. Aug 2022, at 16:52, Johannes Berg <johannes@sipsolutions.net> wrote:
>> 
>> On Mon, 2022-08-29 at 16:52 +0200, Johannes Berg wrote:
>>> On Mon, 2022-08-29 at 16:51 +0200, Thomas Hühn wrote:
>>>>>> 
>>>>>> Compile-Tested: current wireless-next tree with all flags on
>>>>>> Tested-on PCEngines APU with ath9k WiFi device on OpenWrt Linux
>>>>>>      Kernel 5.10.137
>>>>>> 
>>>>> 
>>>>> That seems just a little old? Not sure I'd trust that given the major
>>>>> changes in the tree recently?
>>>> 
>>>> Good point, we can test this with 5.15.63 by enabling the OpenWrt testing kernel … would that be ok ?
>>>> 
>>> 
>>> Well a lot of major changes just happened 5.19 -> 6.0, so something more
>>> recent would be better?
>>> 
>> 
>> Maybe you could add support in hwsim?
>> 

hwsim support is a good idea for this patch series and probably a debugfs to annotate static power levels per sta.
We are working on a joint rate and power algorithm, but that is quit a big change on its own and probably better reviewable
in a seperate patch series after this one that enabled the tpc annotation parts.


Greetings Thomas

>> johannes
> 

—
Prof. Dr.-Ing. Thomas Hühn

Hochschule Nordhausen
Fachbereich Ingenieurwissenschaften - Institut für Informatik, Automatisierung und Elektronik 
Leitung Kommunikationstechnik und Bussysteme

Weinberghof 4
99734 Nordhausen, Germany

Tel: +49 3631 420 318
Fax: +49 3631 420 818

thomas.huehn@hs-nordhausen.de
www.hs-nordhausen.de

