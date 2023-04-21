Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9101A6EADDE
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Apr 2023 17:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbjDUPQG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Apr 2023 11:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjDUPQF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Apr 2023 11:16:05 -0400
Received: from mx1.uni-rostock.de (mx1.uni-rostock.de [139.30.22.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492BA93F6
        for <linux-wireless@vger.kernel.org>; Fri, 21 Apr 2023 08:16:02 -0700 (PDT)
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmze; 
 t=1682090160; bh=oHO0ZIn7nhiCUlXAjnguKWwzOIRSomeBe0HbzEeUUD0=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=ed25519-sha256; b=
 F4+f7QO/2R2qBvU4nFnHhJQAWjGaeoI5AtFc1QefbPHVDqG+qh7WmQzDPrn1rWgYfrAEiewVUj2oxXzhX9+UBQ==
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmz; 
 t=1682090160; bh=oHO0ZIn7nhiCUlXAjnguKWwzOIRSomeBe0HbzEeUUD0=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=rsa-sha256; b=
 Swey5TTHr3on4/yrTbRuYGTHA/k8yQWK+D3W1NV/zpEa35aRW10U2bmIjILY6SJrvWwprva7byAcq1/kqHpes8aPjnU+6MYqXrvYDuAXyCHeUqEW1aA++JxM6IubdJ+VhKWYsM+Cl6ZqSsRK1wGCYg3Mw8xN8R3khPDtE6Ugyo0=
Received: from 139.30.22.84 by mx1.uni-rostock.de (Tls12, Aes256, Sha384,
 DiffieHellmanEllipticKey384); Fri, 21 Apr 2023 15:16:00 GMT
Received: from [139.30.201.34] (139.30.201.34) by mail1.uni-rostock.de
 (139.30.22.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Fri, 21 Apr
 2023 17:15:59 +0200
Message-ID: <bea043c3-1cee-e2a6-ca4b-83e80404358c@uni-rostock.de>
Date:   Fri, 21 Apr 2023 17:16:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC v2] average: rewrite for clearity
Content-Language: de-DE
To:     Johannes Berg <johannes@sipsolutions.net>, <nbd@nbd.name>,
        <linux-wireless@vger.kernel.org>
References: <20230421134604.211128-1-benjamin.beichler@uni-rostock.de>
 <3f505aba559d4ce068ef6d2fd7743045e0d93b9f.camel@sipsolutions.net>
From:   Benjamin Beichler <Benjamin.Beichler@uni-rostock.de>
Organization: =?UTF-8?Q?Universit=c3=a4t_Rostock?=
In-Reply-To: <3f505aba559d4ce068ef6d2fd7743045e0d93b9f.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
X-Originating-IP: [139.30.201.34]
X-ClientProxiedBy: EMAIL2.uni-rostock.de (139.30.22.82) To
 mail1.uni-rostock.de (139.30.22.84)
X-TM-SNTS-SMTP: 35B229DEEE8DAEF882B2533E0B56CDD00B4902532E4D6C4151FD4B822FCE37452000:8
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

Am 21.04.2023 um 16:37 schrieb Johannes Berg:
> =5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F
>   Achtung! Externe E-Mail: Klicken Sie erst dann auf Links und Anh=C3=A4nge,=
 nachdem Sie die Vertrauensw=C3=BCrdigkeit der Absenderadresse gepr=C3=BCft ha=
ben.
> =5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F
>
> On Fri, 2023-04-21 at 13:46 +0000, Benjamin Beichler wrote:
>> Move the former *=5Fadd function with its implicit initialization into a
>> separate function, when the user explicitly wants to init with the first
>> added value, although this creates issues, when 0 is a expected value for
>> the internal value.
>>
>> Add a separate init function with value parameter to allow init with
>> distinct value, which was formerly done by the implicit init of old
>> *=5Fadd function.
>>
> Sure, this is what you said :-)
>
> I still don't really think it's feasible. First, this breaks all the
> users, because if you have e.g. virtio's DECLARE=5FEWMA(pkt=5Flen, 0, 64)
> then it will take a long time to get away from 0.
>
> So then we could say we'll just fix them, but what value actually makes
> sense to init with=3F You don't necessarily know, right=3F Initially biasing
> towards the first value makes a lot more sense than initially biasing
> towards zero, no=3F And then if you want to achieve that, now you have to
> either use =5Fadd=5For=5Finit(), which is probably what people will do, but
> that continues having the problem ...

I left out the the individual fixes for users, but for the samples I 
looked into, either start values were given, or they were semantically 
extractable.

e.g. virtios pkt=5Flen=C2=A0 ewma is clamped anyways, so using the clamp borde=
r 
or in between will be safe.

Most others are signals-strengths, many of them also only for 
statistics, where a slow convergence is okay in my opinion.

> I don't really see how this is a net improvement - we'd still have to
> fix the individual users with it, e.g. maybe the mesh case that started
> this investigation could bias towards success (init with 100) and then
> use =5Fadd() rather than =5Fadd=5For=5Finit(), but then again we're back to
> having to make individual choices with the users. I don't really see how
> that's better than fixing it for real with the existing behaviour of
> biasing towards the first value=3F

IMHO the net improvement is, that if you do not use the convenience 
add=5For=5Finit function, it simply resembles the ewma filter of a math or 
CS-textbook. The original problem was, that the ewma had a surprising 
output in a special situation.

But while writing the commit, I recognized, that the current ewma 
implementation is only for unsigned values, which means the problem 
really only happens for many consecutive 0 values. I try to think over, 
what this means for the proposal of Felix, but I'm not able to think 
about unsigned C-arithmetics today :-D

If we use that fix, then we should have an additional compile time 
check, that the precision has at least 2 or 4 bits, to really avoid the 
problem, shouldn't we=3F

Benjamin
