Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83D26EA860
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Apr 2023 12:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbjDUKec (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Apr 2023 06:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjDUKeb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Apr 2023 06:34:31 -0400
Received: from mx2.uni-rostock.de (mx2.uni-rostock.de [139.30.22.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61CF5272C
        for <linux-wireless@vger.kernel.org>; Fri, 21 Apr 2023 03:34:29 -0700 (PDT)
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmze; 
 t=1682073267; bh=IastHyaFuB68dQlsY1MQH49W0R/hUR4r4XyoDKcJKGw=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=ed25519-sha256; b=
 RIjYihruNK5tJDEtkIDpnP+jR4Qk0O0exurPi4Kz7sJEuIMt+OQyJQwdY3NwSoFxMgnw9LpIkqsTLsIky8CBBw==
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmz; 
 t=1682073267; bh=IastHyaFuB68dQlsY1MQH49W0R/hUR4r4XyoDKcJKGw=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=rsa-sha256; b=
 ODuh5o/gmYW0mmR1BUkgmJoyAkG/cJW1bOREJ+L0f/Y+WKmWmYMquiVtfFIJ8MOLxmPOwkfHePXdBFjgLuQfaXYWz+IfAtChO2Fb8WfNdrozZASeEZtIvvJbYBmN4Bb+byYhep/6D+4EW86OduOrF9GsdNlwDpyt5NBY1LzNSYM=
Received: from 139.30.22.84 by mx2.uni-rostock.de (Tls12, Aes256, Sha384,
 DiffieHellmanEllipticKey384); Fri, 21 Apr 2023 10:34:27 GMT
Received: from [172.16.0.2] (104.28.223.198) by mail1.uni-rostock.de
 (139.30.22.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Fri, 21 Apr
 2023 12:34:21 +0200
Message-ID: <f562b221-b702-21ac-eedf-3a428e29844d@uni-rostock.de>
Date:   Fri, 21 Apr 2023 12:34:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1] wifi: mac80211: Initialize EWMA fail avg to 1
Content-Language: de-DE
To:     Felix Fietkau <nbd@nbd.name>,
        Johannes Berg <johannes@sipsolutions.net>
CC:     Karthik M <quic_karm@quicinc.com>,
        <linux-wireless@vger.kernel.org>,
        Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
References: <4f0efc62-0ca5-fe85-fdd8-9beca7ff94d7@uni-rostock.de>
 <04A41274-08B2-4473-AFD0-7D91D3850F4B@nbd.name>
 <ad5febda1c32c0d84aa8ac509fefc5b31a8b7ed4.camel@sipsolutions.net>
 <c22ecc12-6841-e20b-0ee8-eec2e6d6e3e6@nbd.name>
From:   Benjamin Beichler <Benjamin.Beichler@uni-rostock.de>
Organization: =?UTF-8?Q?Universit=c3=a4t_Rostock?=
In-Reply-To: <c22ecc12-6841-e20b-0ee8-eec2e6d6e3e6@nbd.name>
Content-Type: text/plain; charset="UTF-8"; format=flowed
X-Originating-IP: [104.28.223.198]
X-ClientProxiedBy: EMAIL2.uni-rostock.de (139.30.22.82) To
 mail1.uni-rostock.de (139.30.22.84)
X-TM-SNTS-SMTP: 4B3BC65ED28957A43CD9BEB921E0743A512E9BB7080FF0E804907CA80B462B6F2000:8
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

Am 21.04.2023 um 11:53 schrieb Felix Fietkau:
> =5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F
> Achtung! Externe E-Mail: Klicken Sie erst dann auf Links und Anh=C3=A4nge, 
> nachdem Sie die Vertrauensw=C3=BCrdigkeit der Absenderadresse gepr=C3=BCft h=
aben.
> =5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F
>
> On 21.04.23 11:35, Johannes Berg wrote:
>> To me, the first question is if there are potentially any users that are
>> =5Frelying=5F on the current behaviour. This seems unlikely though, looking
>> at the ~30 users, most sound like signal/rssi, packet sizes, etc.
>>
>> So let's say with the bug found here that prompted this patch, chances
>> are that there aren't any users that really want 0 to be special. I also
>> can't even really think of a reason for wanting that.
>>
>>
>> So then let's say we want to fix the existing code. I can think of these
>> possible ways:
>>
>> =C2=A0 * splitting off a bit for initialized from the unsigned long
>> =C2=A0=C2=A0=C2=A0 (which at least for 64-bit should be OK since presumably=
 most code
>> =C2=A0=C2=A0=C2=A0=C2=A0 using this will run on 32-bit systems too)
>> =C2=A0 * adding another value for it, e.g. making it u32 and adding a bool 
>> for
>> =C2=A0=C2=A0=C2=A0 "first value"
>> =C2=A0 * biasing the value, like Felix proposes, could be by 1 or -1 for
>> =C2=A0=C2=A0=C2=A0 example
You forgot the possibility to introduce a separate init function, which 
boils down to a shift with an assignment statement for code, and no 
further data memory cost. Even simply extending the current init 
function (which simply always set 0) would be enough.
>>
>> All of these have a memory cost, of course, though the first two are
>> data and the second code, so for things like stations the code exists
>> only once and the data multiple times. On 64-bit we can probably make
>> the first two not have a data memory cost though.
>>
>> As for biasing the value, couldn't that lead to a similar problem=3F It's
>> clearly less likely that the end of the range is reached rather than
>> zero, but still=3F
> I don't see how it can reduce the range in any way, since the bias is
> added to the fractional part. A range reduction would seem to imply
> having an average value that's bigger than the maximum allowed shifted
> input (top bits cut off), and I don't think that's possible.
>
It does not reduce the range, but it does not matter whether your 
internal state is 0 or 2^(-precision), the non-intuitive behavior stays 
the same.


> - Felix
>

-- 
M.Sc. Benjamin Beichler

Universit=C3=A4t Rostock, Fakult=C3=A4t f=C3=BCr Informatik und Elektrotechnik
Institut f=C3=BCr Angewandte Mikroelektronik und Datentechnik

University of Rostock, Department of CS and EE
Institute of Applied Microelectronics and CE

Albert-Einstein-Str. 26
18059 Rostock
Deutschland/Germany

phone: +49 (0) 381 498 - 7278
email: Benjamin.Beichler@uni-rostock.de
www: http://www.imd.uni-rostock.de/
