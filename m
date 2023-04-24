Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3016ED6C7
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Apr 2023 23:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbjDXVco (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Apr 2023 17:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbjDXVcm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Apr 2023 17:32:42 -0400
Received: from mx2.uni-rostock.de (mx2.uni-rostock.de [139.30.22.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104C65B90
        for <linux-wireless@vger.kernel.org>; Mon, 24 Apr 2023 14:32:39 -0700 (PDT)
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmze; 
 t=1682371958; bh=IvtypT1wnhsTEJlXbgCW1bpKlFU6w7k53ppPD2Wldf8=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=ed25519-sha256; b=
 365Yrc3fYswR6lK7/Uciw4PFLf9e6N8t4UBkNqaslt4X8hkPZYxhPu/QMLEnlAmPZIJ7MiATnWar3kKhS55MAA==
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmz; 
 t=1682371958; bh=IvtypT1wnhsTEJlXbgCW1bpKlFU6w7k53ppPD2Wldf8=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=rsa-sha256; b=
 B46pixawHqYpdFIGs8MoZjdMe3v6IGcX7nQ5ZrJGB9FhyQz8bKkYCGDvaZ6RZ3OfKlrLavAfh94V/IR5+5nJohFqblDt5OFkLcHymdOxlYUrbO3NjdXxBVqqWpSIRrwkZpmPFVd/dY4y2SGxnPyoBeRFzziHbi9020p74sdYUQE=
Received: from 139.30.22.84 by mx2.uni-rostock.de (Tls12, Aes256, Sha384,
 DiffieHellmanEllipticKey384); Mon, 24 Apr 2023 21:32:38 GMT
Received: from [192.168.0.112] (91.59.48.80) by mail1.uni-rostock.de
 (139.30.22.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Mon, 24 Apr
 2023 23:32:37 +0200
Message-ID: <7a942044-1932-7596-b43b-4337a706d82c@uni-rostock.de>
Date:   Mon, 24 Apr 2023 23:32:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC v2] average: rewrite for clearity
Content-Language: de-DE
To:     Johannes Berg <johannes@sipsolutions.net>, <nbd@nbd.name>,
        <linux-wireless@vger.kernel.org>
References: <20230421134604.211128-1-benjamin.beichler@uni-rostock.de>
 <3f505aba559d4ce068ef6d2fd7743045e0d93b9f.camel@sipsolutions.net>
 <bea043c3-1cee-e2a6-ca4b-83e80404358c@uni-rostock.de>
 <bf641b6343baf9a810df41a5d68e0c073a059548.camel@sipsolutions.net>
From:   Benjamin Beichler <Benjamin.Beichler@uni-rostock.de>
Organization: =?UTF-8?Q?Universit=c3=a4t_Rostock?=
In-Reply-To: <bf641b6343baf9a810df41a5d68e0c073a059548.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
X-Originating-IP: [91.59.48.80]
X-ClientProxiedBy: EMAIL2.uni-rostock.de (139.30.22.82) To
 mail1.uni-rostock.de (139.30.22.84)
X-TM-SNTS-SMTP: 425237728A62B7E8768CE4A148602B08559B6E2810B5D8EA54E7EA9423ACE0A02000:8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MIME_QP_LONG_LINE,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Am 24.04.2023 um 17:55 schrieb Johannes Berg:
> =5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F
>   Achtung! Externe E-Mail: Klicken Sie erst dann auf Links und Anh=C3=A4nge,=
 nachdem Sie die Vertrauensw=C3=BCrdigkeit der Absenderadresse gepr=C3=BCft ha=
ben.
> =5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F
>
> On Fri, 2023-04-21 at 17:16 +0200, Benjamin Beichler wrote:
>> IMHO the net improvement is, that if you do not use the convenience
>> add=5For=5Finit function, it simply resembles the ewma filter of a math or
>> CS-textbook.
> Not sure I see that as a good argument. The practical engineering side
> tends to always be more complex than the theory, and that's not really
> unexpected. We can comment why it's different :-)
In my opinion, the behavior was without good reason unexpected, but I 
think I found a solution, that we are all happy with. See v3.
>
>> The original problem was, that the ewma had a surprising
>> output in a special situation.
> Right, but that's an implementation issue, because we thought 0 =3D=3D
> uninit was clever, without realizing the corner case.
>
>> But while writing the commit, I recognized, that the current ewma
>> implementation is only for unsigned values, which means the problem
>> really only happens for many consecutive 0 values. I try to think over,
>> what this means for the proposal of Felix, but I'm not able to think
>> about unsigned C-arithmetics today :-D
> Not much really, I think=3F It eases thinking about it though :)
>
>> If we use that fix, then we should have an additional compile time
>> check, that the precision has at least 2 or 4 bits, to really avoid the
>> problem, shouldn't we=3F
> Yes. I think 1 bit is enough, but yes, it can't be 0 bits.

I have wrapped my head around it again, and just send a new version 
(which I may split in two patches for the final round). I played around 
with the fixed point arithmetic and came to the conclusion, that 
ULONG=5FMAX is a better candidate for initial state, since for valid EWMA 
configurations, i.e. a weight=5Frcp bigger than 1, ULONG=5FMAX is never 
reached. Actually, a precision (or fraction) bigger than 0 seems to be 
not needed. However, this means maybe some unexpected oscillation at the 
lower bits, so we may enforce it by another compile time check, but 
actually I' not really concerned about that :-D

In contrast, I recognized, that if val is too big for the 
weight=5Frcp/precision combination, it can overflow the internal state and 
result into much lower values and unexpected jumps of the state. 
Currently, I just added a WARN=5FONCE for this. For all current users, 
this problem should never happen, but a separate clamping of the input 
val is maybe too much, and could also be easily implemented by the user 
of the function.

Benjamin
