Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0356E7013
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Apr 2023 01:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbjDRXxX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Apr 2023 19:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjDRXxW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Apr 2023 19:53:22 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4728E7AAB
        for <linux-wireless@vger.kernel.org>; Tue, 18 Apr 2023 16:53:21 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id h30-20020a4ae8de000000b005463ee651b8so1275370ooe.3
        for <linux-wireless@vger.kernel.org>; Tue, 18 Apr 2023 16:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=seqtechllc.com; s=google; t=1681862000; x=1684454000;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vuSdsoNC1L+yzUhVXZlcxdEDx8XIcyZXW6DDKatr1Xs=;
        b=ZgAHb1pYcPx8nSg5ucUM57eu/zxwSz8fe67Oh9+tF5hHxVRnsoZ9eepJ+zjj1uEHtT
         r2t2U+R4suXG3WSuNxSRnu7TR2z5MyrNwvcsK5C331C1tiPVaK/ZGLEDNfwtofyWxVWA
         3HHbZpVc86HJpeZJIQmhRD6lIcC41zqdxHKjLaOUNnJmVNYPMMw1fOjhUSEUIFrGp0y6
         7V3BUcC+m8JOwqqJX7SKwmzvXuZsU47ETH7ELjIZXyZUve70UIpcTI/H2XfC8EZoET/V
         6ZnT96NiqV8g78HXanYlrW14Ci1hbWO7MLccHSk6qSJmFI0qohc+FwsEY8XU48Fwo3v2
         EkUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681862000; x=1684454000;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vuSdsoNC1L+yzUhVXZlcxdEDx8XIcyZXW6DDKatr1Xs=;
        b=bABRH59+NWepxaog2aKObfvEWotO9b0VnjEo/AZOb13V6qLixPxNOmPGfibEYTqoz8
         Y6y1vl2FQi08upQckOynZMlX32Xj3ZxcyLC2iiVQ6Bj3s3nqndmUAR7NsfjkVD3+hd5n
         ytpC7SJnlHyGdEg7czrttRYqqlTiisCVZX2gyZmIeWamvHEbzTvU4xfnuPyaA0WzJR0M
         Ke8cYjHwTvLjb44PtYa2zLaSxPKRMLIyqyTtExbyHDiCGdNIWeaDLcyJYkOMPWaoeJNR
         Cve9YAA6B8MnA/Hvn+cClB9eiGjve7Yz3kBhArUXcoberNjcoBKxRNzXNmgdzbv3EpSf
         crZg==
X-Gm-Message-State: AAQBX9ecrWtJ+zaQ4HEExka+CxLx71FTIcJAqejGpsVNLP8aup5ExkPD
        WHQMV0mmkQuCZYEucwRM+hbF5oJh4w136sMCq4rkiizaEwEZ/eEz4NBwViE5wNbVtCt1AQPZJe8
        2hBQYEUN8T3/sn5cubi35PEqaOSBT8pgkynFiSxM6mPd9iMlzPh81g4Sg5bCp8/MDiGW5dt0Z6W
        Nu/crxSSmjM95BCvza7X8/3lr+lMT5oL2qXW0MzgWRICj8p1bUVWphXAFTocLxdK35te0=
X-Google-Smtp-Source: AKy350bf4FLn0Vx7eygsTe/n1ZHka5cZQ5X8XO6Xj5W9VZxm2nAKRm2YxNdvaFH3uQMCF1JaVpGqWA==
X-Received: by 2002:a4a:45c5:0:b0:546:9aa2:1da2 with SMTP id y188-20020a4a45c5000000b005469aa21da2mr3958802ooa.1.1681862000492;
        Tue, 18 Apr 2023 16:53:20 -0700 (PDT)
Received: from smtpclient.apple ([2600:381:1d1c:a9c8:16f:a0c5:56d8:fcf7])
        by smtp.gmail.com with ESMTPSA id 125-20020a4a0d83000000b005251e3f92ecsm6463542oob.47.2023.04.18.16.53.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 16:53:20 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Gregg Wonderly <greggwonderly@seqtechllc.com>
Mime-Version: 1.0 (1.0)
Subject: Re: shift exponent 35 is too large @ ath/ath9k/ar9003_hw.c:1147
Date:   Tue, 18 Apr 2023 18:53:09 -0500
Message-Id: <334AEDAA-7703-49F0-82DC-49532348FE41@seqtechllc.com>
References: <87fs8wvllw.fsf@toke.dk>
Cc:     Peter Seiderer <ps.report@gmx.net>, linux-wireless@vger.kernel.org
In-Reply-To: <87fs8wvllw.fsf@toke.dk>
To:     =?utf-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
X-Mailer: iPhone Mail (20E252)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Thanks for picking this up Peter!  I am still a week out, at least, before I=
 could work on this!

Gregg Wonderly!

Sent from my iPhone

> On Apr 18, 2023, at 6:03 PM, Toke H=C3=B8iland-J=C3=B8rgensen <toke@kernel=
.org> wrote:
>=20
> =EF=BB=BFPeter Seiderer <ps.report@gmx.net> writes:
>=20
>> Hello Toke,
>>=20
>>> On Fri, 14 Apr 2023 00:17:04 +0200, Toke H=C3=B8iland-J=C3=B8rgensen <to=
ke@kernel.org> wrote:
>>>=20
>>> Peter Seiderer <ps.report@gmx.net> writes:
>>>=20
>>>> Hello Gregg, Toke,
>>>>=20
>>>> On Thu, 30 Mar 2023 08:44:25 -0500, Gregg Wonderly <greggwonderly@seqte=
chllc.com> wrote:
>>>>=20
>>>>> I have not tested this.  I am in the middle of testing on this machine=
 of many other things and building a kernel right now is not on my timeline.=
  Note that I have a magic 6 constant in there.  I derived this from dividin=
g 32 by the bit mask 0x1f width of 5.  But looking further at this, it seems=
 like chk_dbg should actually be a u64, and dma_dbg_4 and dma_dbg_5 placed i=
nto that value as a continuous 64bit value.  But again, I don=E2=80=99t know=
 if there are 2 bits at the top of dma_dbg_4 and 3 bits at the bottom of dma=
_dbg_5 that go together. This needs to be fixed by someone with the time and=
 the knowledge of what=E2=80=99s going on in the hardware. =20
>>>>=20
>>>> The comment from drivers/net/wireless/ath/ath9k/ar9003_hw.c only some
>>>> lines above seems to support your reasoning (for the '6' constant, not
>>>> for the packaging into an u64 - bit 30-31 unused):
>>>>=20
>>>> 1073 /*             =20
>>>> 1074  * MAC HW hang check
>>>> 1075  * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>> 1076  *
>>>> 1077  * Signature: dcu_chain_state is 0x6 and dcu_complete_state is 0x1=
.
>>>> 1078  *
>>>> 1079  * The state of each DCU chain (mapped to TX queues) is available f=
rom these
>>>> 1080  * DMA debug registers:
>>>> 1081  *     =20
>>>> 1082  * Chain 0 state : Bits 4:0   of AR_DMADBG_4
>>>> 1083  * Chain 1 state : Bits 9:5   of AR_DMADBG_4
>>>> 1084  * Chain 2 state : Bits 14:10 of AR_DMADBG_4
>>>> 1085  * Chain 3 state : Bits 19:15 of AR_DMADBG_4
>>>> 1086  * Chain 4 state : Bits 24:20 of AR_DMADBG_4
>>>> 1087  * Chain 5 state : Bits 29:25 of AR_DMADBG_4
>>>> 1088  * Chain 6 state : Bits 4:0   of AR_DMADBG_5
>>>> 1089  * Chain 7 state : Bits 9:5   of AR_DMADBG_5
>>>> 1090  * Chain 8 state : Bits 14:10 of AR_DMADBG_5
>>>> 1091  * Chain 9 state : Bits 19:15 of AR_DMADBG_5
>>>> 1092  *             =20
>>>> 1093  * The DCU chain state "0x6" means "WAIT_FRDONE" - wait for TX fra=
me to be done.
>>>> 1094  */    =20
>>>>=20
>>>> But with the same/similar bug some lines below (dma_dbg_chain is AR_DMA=
DBG_4
>>>> for queue < 6 and AR_DMADBG_5 above):
>>>>=20
>>>> 1112                 dcu_chain_state =3D (dma_dbg_chain >> (5 * queue))=
 & 0x1f; =20
>>>=20
>>> Okay, here is a patch fixing both places; could one of you please test
>>> it?
>>=20
>> Sorry for the delayed answer..., did prepare already a similar patch (but=

>> without the optimization of moving out the dbg_reg/offset out of the for-=

>> loop in ath9k_hw_verify_hang) and tested it via some additional debug
>> output....
>>=20
>> In IBSS mode with iperf running in both directions all 1 to 3 hours
>> ar9003_hw_detect_mac_hang() triggers the additional check/call
>> to ath9k_hw_verify_hang() but always without real hang outcome...
>=20
> Great, thanks!
>=20
>> Some (minor) style questions below...
>>=20
>>>=20
>>> -Toke
>>>=20
>>> diff --git a/drivers/net/wireless/ath/ath9k/ar9003_hw.c b/drivers/net/wi=
reless/ath/ath9k/ar9003_hw.c
>>> index 4f27a9fb1482..2e8570baabf6 100644
>>> --- a/drivers/net/wireless/ath/ath9k/ar9003_hw.c
>>> +++ b/drivers/net/wireless/ath/ath9k/ar9003_hw.c
>>> @@ -1099,17 +1099,22 @@ static bool ath9k_hw_verify_hang(struct ath_hw *=
ah, unsigned int queue)
>>> {
>>>    u32 dma_dbg_chain, dma_dbg_complete;
>>>    u8 dcu_chain_state, dcu_complete_state;
>>> +    unsigned int dbg_reg, offset;
>>>    int i;
>>>=20
>>> -    for (i =3D 0; i < NUM_STATUS_READS; i++) {
>>> -        if (queue < 6)
>>> -            dma_dbg_chain =3D REG_READ(ah, AR_DMADBG_4);
>>> -        else
>>> -            dma_dbg_chain =3D REG_READ(ah, AR_DMADBG_5);
>>> +    if (queue < 6) {
>>> +        dbg_reg =3D AR_DMADBG_4;
>>> +        offset =3D queue;
>>=20
>> Or calculate the 'real' offset here:
>>=20
>>        offset =3D queue * 5;
>>=20
>>> +    } else {
>>> +        dbg_reg =3D AR_DMADBG_5;
>>> +        offset =3D queue - 6;
>>=20
>>        offset =3D (queue - 6) * 5;
>>> +    }
>>>=20
>>> +    for (i =3D 0; i < NUM_STATUS_READS; i++) {
>>> +        dma_dbg_chain =3D REG_READ(ah, dbg_reg);
>>>        dma_dbg_complete =3D REG_READ(ah, AR_DMADBG_6);
>>>=20
>>> -        dcu_chain_state =3D (dma_dbg_chain >> (5 * queue)) & 0x1f;
>>> +        dcu_chain_state =3D (dma_dbg_chain >> (5 * offset)) & 0x1f;
>>=20
>> And a slightly simpler calculation here:
>>=20
>>        dcu_chain_state =3D (dma_dbg_chain >> offset) & 0x1f;
>=20
> Sure, SGTM.
>=20
>> Or alternative (without offset var) solution:
>>=20
>>        dcu_chain_state =3D (dma_dbg_chain >> (5 * (queue % 6))) & 0x1f;
>=20
> Was trying to avoid the divide (in %) by defining the offset above
> (probably a useless optimisation, but, well :)).
>=20
>> Do you prefer to convert your suggestion into a complete patch/commit or
>> should I update mine (incorporating the optimization of moving out the
>> dbg_reg/offset out of the for-loop) and send to the mailing list?
>=20
> I mostly wrote that because I wasn't sure any of y'all would send a
> patch; so sure, please go ahead and submit a proper one :)
>=20
> -Toke
