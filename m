Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBEF6EA9AA
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Apr 2023 13:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbjDULvF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Apr 2023 07:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjDULvE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Apr 2023 07:51:04 -0400
Received: from mx1.uni-rostock.de (mx1.uni-rostock.de [139.30.22.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC74C5
        for <linux-wireless@vger.kernel.org>; Fri, 21 Apr 2023 04:50:59 -0700 (PDT)
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmze; 
 t=1682077858; bh=qluRJ2N/JrsMuML1bZsgO/Av+8WWbmJY5lok3lGF5Tc=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=ed25519-sha256; b=
 rQ2xqdqeTGtHp+r+csKLXWoZD9rJhqmY4GC54R7a+20lKgO4NuCFH1HJVMhTzZV2Z0rs6CZJbpD7qaA5+UPQAg==
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmz; 
 t=1682077858; bh=qluRJ2N/JrsMuML1bZsgO/Av+8WWbmJY5lok3lGF5Tc=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=rsa-sha256; b=
 c+QwYfO/L/Xz5dYfs1D5li2TI9pCqe3N5aYFSFxSSPvnh2TJZUcQF6TKr2rU1kvUsbdpW/EUdqifmcUnmvGcDPPSVLlpnDuxwZKjkT7YW8utjZyDRc88MBMAGgesaYje+z/vkAb6dCtzXy7bNnhtydLZdTAKg3sHuvxSjOYIsNQ=
Received: from 139.30.22.84 by mx1.uni-rostock.de (Tls12, Aes256, Sha384,
 DiffieHellmanEllipticKey384); Fri, 21 Apr 2023 11:50:58 GMT
Received: from [172.16.0.2] (104.28.223.198) by mail1.uni-rostock.de
 (139.30.22.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Fri, 21 Apr
 2023 13:50:57 +0200
Message-ID: <90dfa452-b8ca-fa03-b6e8-3325ebc9fb12@uni-rostock.de>
Date:   Fri, 21 Apr 2023 13:51:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1] wifi: mac80211: Initialize EWMA fail avg to 1
Content-Language: de-DE
To:     Johannes Berg <johannes@sipsolutions.net>,
        Felix Fietkau <nbd@nbd.name>
CC:     Karthik M <quic_karm@quicinc.com>,
        <linux-wireless@vger.kernel.org>,
        Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
References: <4f0efc62-0ca5-fe85-fdd8-9beca7ff94d7@uni-rostock.de>
 <04A41274-08B2-4473-AFD0-7D91D3850F4B@nbd.name>
 <ad5febda1c32c0d84aa8ac509fefc5b31a8b7ed4.camel@sipsolutions.net>
 <c22ecc12-6841-e20b-0ee8-eec2e6d6e3e6@nbd.name>
 <f562b221-b702-21ac-eedf-3a428e29844d@uni-rostock.de>
 <5e9323647bfc25cf4e09f107348a4e79e9d5c371.camel@sipsolutions.net>
From:   Benjamin Beichler <Benjamin.Beichler@uni-rostock.de>
Organization: =?UTF-8?Q?Universit=c3=a4t_Rostock?=
In-Reply-To: <5e9323647bfc25cf4e09f107348a4e79e9d5c371.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
X-Originating-IP: [104.28.223.198]
X-ClientProxiedBy: EMAIL2.uni-rostock.de (139.30.22.82) To
 mail1.uni-rostock.de (139.30.22.84)
X-TM-SNTS-SMTP: 7D73DBC0B6B1016E9BD1C088617186ACD9557C18C3353DB0E1FF36BE3009E3A22000:8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MIME_QP_LONG_LINE,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Am 21.04.2023 um 13:13 schrieb Johannes Berg:
> =5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F
>   Achtung! Externe E-Mail: Klicken Sie erst dann auf Links und Anh=C3=A4nge,=
 nachdem Sie die Vertrauensw=C3=BCrdigkeit der Absenderadresse gepr=C3=BCft ha=
ben.
> =5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F
>
> On Fri, 2023-04-21 at 12:34 +0200, Benjamin Beichler wrote:
>>>> So then let's say we want to fix the existing code. I can think of these
>>>> possible ways:
>>>>
>>>>    * splitting off a bit for initialized from the unsigned long
>>>>      (which at least for 64-bit should be OK since presumably most code
>>>>       using this will run on 32-bit systems too)
>>>>    * adding another value for it, e.g. making it u32 and adding a bool
>>>> for
>>>>      "first value"
>>>>    * biasing the value, like Felix proposes, could be by 1 or -1 for
>>>>      example
>> You forgot the possibility to introduce a separate init function, which
>> boils down to a shift with an assignment statement for code, and no
>> further data memory cost. Even simply extending the current init
>> function (which simply always set 0) would be enough.
> Sort of. Yeah I should've mentioned it, but that means you actually have
> to know the first value, and track "first time usage" separately in the
> user code.
>
> Or you init to something useful at the first value, e.g. saying for
> signal strength "let's assume -45dBm average if we don't know". That
> doesn't seem very practical=3F
I think (at least for the usages I dig into), either those values are 
already defined and applied with a bogus *=5Fadd.
>
> The behaviour of "first value inserted will init" seems sensible.

Okay, my suggestion, as this is a c-macro version, which is generated 
for each user: why not offer both=3F If it is unused, the compiler will 
sort that out. Then we simply keep the zero as special value for init 
(and document it) and otherwise for the more mathematically defined 
usage. But my feeling is, that most users do not care about the first 
values that much and wait to let the ewma settle to some value.

I try to do a RFC patch, with what I mean.


Benjamin
