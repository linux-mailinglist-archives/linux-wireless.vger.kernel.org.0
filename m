Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E65C16EEE6F
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Apr 2023 08:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239515AbjDZGhA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Apr 2023 02:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239309AbjDZGg7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Apr 2023 02:36:59 -0400
Received: from mx2.uni-rostock.de (mx2.uni-rostock.de [139.30.22.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37BFE3ABC
        for <linux-wireless@vger.kernel.org>; Tue, 25 Apr 2023 23:36:21 -0700 (PDT)
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmze; 
 t=1682490979; bh=mRymR1FarXkzzHNyqndiI6x3ZGPvH2WPcwrUZh+x23c=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=ed25519-sha256; b=
 IDzYeSif1NUmgIU5P5aTTZL3KjS3hAG0VeWKLvz2nMuQUku0ns9TuXhqGWyndRAFr0B+AT0yPDl06FQ7WaI1DQ==
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmz; 
 t=1682490979; bh=mRymR1FarXkzzHNyqndiI6x3ZGPvH2WPcwrUZh+x23c=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=rsa-sha256; b=
 WzaFBg95GVnihZJmWXmq5H8LHUwdOQP+jKcyBo2OC28OcFpKFxnvOcqBv3MR6zCloptbB8uyo9nUZXmhuGv4EGr26VbyCiZy45/XnbdydxQx2HfPiKkulDXzFfK+ahVMlLLrx31Y2wOxvv1nrTsCaD2Ag/fD2x8GpssMcoKeRhQ=
Received: from 139.30.22.84 by mx2.uni-rostock.de (Tls12, Aes256, Sha384,
 DiffieHellmanEllipticKey384); Wed, 26 Apr 2023 06:36:19 GMT
Received: from [139.30.201.34] (139.30.201.34) by mail1.uni-rostock.de
 (139.30.22.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Wed, 26 Apr
 2023 08:36:19 +0200
Message-ID: <8d17c36f-c62c-5b15-b22e-cd30b71c3aa3@uni-rostock.de>
Date:   Wed, 26 Apr 2023 08:36:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH v3] average: change non-init state and add check for
 added values
Content-Language: de-DE
From:   Benjamin Beichler <Benjamin.Beichler@uni-rostock.de>
To:     Johannes Berg <johannes@sipsolutions.net>, <nbd@nbd.name>,
        <linux-wireless@vger.kernel.org>
References: <20230424210430.390592-1-benjamin.beichler@uni-rostock.de>
 <a3ac7cf40706771977138a437560475b035efee4.camel@sipsolutions.net>
 <6d672602-55b2-fb11-2707-84bd360411f2@uni-rostock.de>
Organization: =?UTF-8?Q?Universit=c3=a4t_Rostock?=
In-Reply-To: <6d672602-55b2-fb11-2707-84bd360411f2@uni-rostock.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
X-Originating-IP: [139.30.201.34]
X-ClientProxiedBy: EMAIL2.uni-rostock.de (139.30.22.82) To
 mail1.uni-rostock.de (139.30.22.84)
X-TM-SNTS-SMTP: EEF0B7C06C091DA8BC3E3324F8542727AA68C8FFF6434975DE3FF40A3797BCE72000:8
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

Am 26.04.2023 um 08:19 schrieb Benjamin Beichler:
> Am 25.04.2023 um 20:18 schrieb Johannes Berg:
>> =5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F
>> =C2=A0 Achtung! Externe E-Mail: Klicken Sie erst dann auf Links und 
>> Anh=C3=A4nge, nachdem Sie die Vertrauensw=C3=BCrdigkeit der Absenderadresse=
 
>> gepr=C3=BCft haben.
>> =5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F
>>
>> On Mon, 2023-04-24 at 21:04 +0000, Benjamin Beichler wrote:
>>> The uninitialized state 0 involves the danger of reaching that state in
>>> normal operation. Since the weight=5Frcp value needs to be bigger than 
>>> one
>>> (otherwise no averaging takes place), the final shifting in add 
>>> ensures,
>>> that the internal state never reach ULONG=5FMAX. Therefore use this value
>>> to signal, that the ewma has no initial value.
>>>
>>> The add function needs to check, that val is not to big, otherwise 
>>> the new
>>> value can overflow the internal state, which results in unexpected 
>>> outputs.
>> This seems nice to me, FWIW.
> Okay. I would split up the patch into sensible parts and send it 
> later. You are also fine with the extra init function with explicit 
> init value=3F Of course this one also needs the check, that it really 
> fits into the internal state :-D
>>
>>> Move the compile time checks into a separate macro, as they are used
>>> multiple times and noise up the functions.
>> Why do we even have those multiple times=3F Should be enough to have them
>> once, since we always compile the static inline functions=3F
>
> Good question ... my assumption was, that the build-bug macro may not 
> work, if the function is unused and maybe optimized away, but I'm not 
> that familiar with those details. I'm more in favor with the 
> static=5Fasserts of C++, which have defined semantics. :-D
>
> It would be nice to put the check into the struct, as some zero size 
> bad member, but I found no example in the kernel, so maybe this is not 
> easily doable.
>
> One may argue, that we only put it in init and if the users do not use 
> init, we call it shit-in-shit-out, but I'm not really in favor of that.
>
> Anyone with more experiences on build time asserts in the kernel=3F
>
>
I just checked out of curiosity the kernel for static=5Fassert, and voil=C3=A0=
 
it already contains it as a wrapper to the C11 =5FStatic=5Fassert, which 
should work better than BUILD=5FBUG. I will transform it and remove the 
multiple insertions.

Benjamin

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
