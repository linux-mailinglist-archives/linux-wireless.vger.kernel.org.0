Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49A9A6EEE2D
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Apr 2023 08:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239383AbjDZGTU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Apr 2023 02:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239359AbjDZGTT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Apr 2023 02:19:19 -0400
Received: from mx2.uni-rostock.de (mx2.uni-rostock.de [139.30.22.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A7FC2134
        for <linux-wireless@vger.kernel.org>; Tue, 25 Apr 2023 23:19:13 -0700 (PDT)
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmze; 
 t=1682489951; bh=e4TxUWFbHfbxvmEdNhXFdc4Bx4m+GTB7XKhuCjCdmvQ=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=ed25519-sha256; b=
 4r9Iz4VW2Md+l+GPrfI55YosPbl17VILRz/uRh7jXg6yc42OS4BotQq6GNqrqWKv2hbsKvuFU15V8wQo1GOLDA==
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmz; 
 t=1682489951; bh=e4TxUWFbHfbxvmEdNhXFdc4Bx4m+GTB7XKhuCjCdmvQ=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=rsa-sha256; b=
 k0Z9365x/Q6VwP2qUm/Wnn6tInqWRWyGxpk+pv2q28B2hF6C9DtQLYx41eaJkSxmFGZau3cMbQuQ8aFQ++3Y4aOTwxZv4sC6c0CHjRXSMTlFPdlJjIllZcN1wyqJcWNF2KVH3QTgqFf2NbiP4KaOWbXOvOnpwU6aQ5LK1O1xXg8=
Received: from 139.30.22.84 by mx2.uni-rostock.de (Tls12, Aes256, Sha384,
 DiffieHellmanEllipticKey384); Wed, 26 Apr 2023 06:19:10 GMT
Received: from [139.30.201.34] (139.30.201.34) by mail1.uni-rostock.de
 (139.30.22.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Wed, 26 Apr
 2023 08:19:09 +0200
Message-ID: <6d672602-55b2-fb11-2707-84bd360411f2@uni-rostock.de>
Date:   Wed, 26 Apr 2023 08:19:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH v3] average: change non-init state and add check for
 added values
Content-Language: de-DE
To:     Johannes Berg <johannes@sipsolutions.net>, <nbd@nbd.name>,
        <linux-wireless@vger.kernel.org>
References: <20230424210430.390592-1-benjamin.beichler@uni-rostock.de>
 <a3ac7cf40706771977138a437560475b035efee4.camel@sipsolutions.net>
From:   Benjamin Beichler <Benjamin.Beichler@uni-rostock.de>
Organization: =?UTF-8?Q?Universit=c3=a4t_Rostock?=
In-Reply-To: <a3ac7cf40706771977138a437560475b035efee4.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
X-Originating-IP: [139.30.201.34]
X-ClientProxiedBy: EMAIL2.uni-rostock.de (139.30.22.82) To
 mail1.uni-rostock.de (139.30.22.84)
X-TM-SNTS-SMTP: F98BB533A878CA01E4A04554030DAFC7F7BB3035E533284687BB5988F4E7C00D2000:8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MIME_QP_LONG_LINE,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Am 25.04.2023 um 20:18 schrieb Johannes Berg:
> =5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F
>   Achtung! Externe E-Mail: Klicken Sie erst dann auf Links und Anh=C3=A4nge,=
 nachdem Sie die Vertrauensw=C3=BCrdigkeit der Absenderadresse gepr=C3=BCft ha=
ben.
> =5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F
>
> On Mon, 2023-04-24 at 21:04 +0000, Benjamin Beichler wrote:
>> The uninitialized state 0 involves the danger of reaching that state in
>> normal operation. Since the weight=5Frcp value needs to be bigger than one
>> (otherwise no averaging takes place), the final shifting in add ensures,
>> that the internal state never reach ULONG=5FMAX. Therefore use this value
>> to signal, that the ewma has no initial value.
>>
>> The add function needs to check, that val is not to big, otherwise the new
>> value can overflow the internal state, which results in unexpected outputs.
> This seems nice to me, FWIW.
Okay. I would split up the patch into sensible parts and send it later. 
You are also fine with the extra init function with explicit init value=3F 
Of course this one also needs the check, that it really fits into the 
internal state :-D
>
>> Move the compile time checks into a separate macro, as they are used
>> multiple times and noise up the functions.
> Why do we even have those multiple times=3F Should be enough to have them
> once, since we always compile the static inline functions=3F

Good question ... my assumption was, that the build-bug macro may not 
work, if the function is unused and maybe optimized away, but I'm not 
that familiar with those details. I'm more in favor with the 
static=5Fasserts of C++, which have defined semantics. :-D

It would be nice to put the check into the struct, as some zero size bad 
member, but I found no example in the kernel, so maybe this is not 
easily doable.

One may argue, that we only put it in init and if the users do not use 
init, we call it shit-in-shit-out, but I'm not really in favor of that.

Anyone with more experiences on build time asserts in the kernel=3F

Benjamin
