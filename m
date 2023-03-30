Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6FC6D0C00
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Mar 2023 18:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbjC3Q41 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Mar 2023 12:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjC3Q40 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Mar 2023 12:56:26 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8970319A
        for <linux-wireless@vger.kernel.org>; Thu, 30 Mar 2023 09:56:24 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id ca2-20020a056830610200b006a11ab58c3fso9671191otb.4
        for <linux-wireless@vger.kernel.org>; Thu, 30 Mar 2023 09:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=seqtechllc.com; s=google; t=1680195384;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3T3gJbpXo0fYt3osS7My/24QkU3J+yR+buDRN1kkebQ=;
        b=UBfCird6VO54bTPSNp6ZwnCetVeZdX1ASs0BbvKRcK3wCV2YfF8yNhY46eCgGnydvt
         RZJkITbTS0LBrSB2HG6+Jfp+0qVNrNAzYb6/jICkyeY27ZkiqVapVZ94TtQqzIn1o3lO
         2ANUwgGRbCPXVxckA4vXwWFZWaxdKNO0t1sME9mfKWSZNYs6k67WR5D3ENHRS/d1SSiV
         W/Vjz8SfzzQREypjsZqBSAQf1tB9ZsmI1LUWBntx4jHGkzmJNJptsixmsHOCl9PUxsu0
         vQ94cO3Fihtd21783CK88HECNv56fAvwELWowHmGFAcWCDYbnaIQ+IBAtpiNrfQ0HVNd
         wSSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680195384;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3T3gJbpXo0fYt3osS7My/24QkU3J+yR+buDRN1kkebQ=;
        b=h91CQ3jR/4zDa+C2us9CdkpTJL8Wyq/FEFIjPuTJfndrU3h/sc8zaPdYL7+kulh2J2
         Anb5WGD82zvwvib2HU72JG6ZJDOPUo8nLlwCqU5nbihdb3VwkmOujiyxuVR2CvJ29jgI
         s5XKx+eg1fTvSp8RDPTLD2L9nAmUpzqXXEuQUt/MGu5dlRCvlMvdF2ysnwTyvvO7JC4d
         vASPhjITDBVVjI98xZphQUTHloyl2TSQIWr+3Aqb6QSOGHcqYRwCscUqQLReDmT5eSwY
         JewBMzmhpAT4JBhayYQgvFLOTyyZSZlx76xlOlPfOdG96H0tfsLQLQ8FUtm4/BILLUbC
         /IXQ==
X-Gm-Message-State: AO0yUKWZoHzminjjGnO7gMwP4kEf4si0XUG8UC/TvTjGx3+CqVCzK9Hm
        cMmbpGAdaCtVWYLlMe2Fs4nihTy1crxi1LbC5Q6pmwIF8RVh8QgZ6HZd1MHZCgeNiDdD2xOHbCi
        wdf8tC4oJPk20nkZ7V0z4n6H/V34rDPT7xxyRfYnSKhBuoXTWg2naoduOgWnbeAeYlECB/9Uxx5
        z3IWBOvoTzwbDpkuV2b+q+3u8azfcwGtcMUOuv1HMuDQYDvnAbj/HBHIKG2akx38RhWnwu6w==
X-Google-Smtp-Source: AK7set9kIkqFkBtR9/uhtaRui0+f3KS0Dq1vzHwdOuemaWJLvPiaIPpsQ6CLRt61ooH56XLerR+Kiw==
X-Received: by 2002:a9d:630c:0:b0:69f:8db2:8e2b with SMTP id q12-20020a9d630c000000b0069f8db28e2bmr11027572otk.22.1680195383762;
        Thu, 30 Mar 2023 09:56:23 -0700 (PDT)
Received: from smtpclient.apple ([67.202.189.242])
        by smtp.gmail.com with ESMTPSA id d18-20020a0568301b7200b006a143873c6bsm110841ote.50.2023.03.30.09.56.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Mar 2023 09:56:23 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: Re: shift exponent 35 is too large @ ath/ath9k/ar9003_hw.c:1147
From:   Gregg Wonderly <greggwonderly@seqtechllc.com>
In-Reply-To: <20230330181138.5a881d19@gmx.net>
Date:   Thu, 30 Mar 2023 11:56:12 -0500
Cc:     =?utf-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>,
        linux-wireless@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <5145B1A1-BE9B-419A-8BAE-35B80C3D28F1@seqtechllc.com>
References: <E3A9C354-0CB7-420C-ADEF-F0177FB722F4@seqtechllc.com>
 <87cz5079p1.fsf@toke.dk>
 <27B86217-CA79-4E4A-842B-9B2341B48B13@seqtechllc.com>
 <20230330181138.5a881d19@gmx.net>
To:     Peter Seiderer <ps.report@gmx.net>
X-Mailer: Apple Mail (2.3731.400.51.1.1)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Okay, I had not looked for that detail.  Thanks for pointing it out.  =
Clearly my initial thought would work.  The =E2=80=986=E2=80=99 should =
just be cast into a more explanatory local valued name, or a #define of =
some sort.=20

I also had not looked to see if the same logic was elsewhere.  So that =
implies there could be a small refactoring to put this logic in on place =
too.

Gregg Wonderly

> On Mar 30, 2023, at 11:11 AM, Peter Seiderer <ps.report@gmx.net> =
wrote:
>=20
> Hello Gregg, Toke,
>=20
> On Thu, 30 Mar 2023 08:44:25 -0500, Gregg Wonderly =
<greggwonderly@seqtechllc.com> wrote:
>=20
>> I have not tested this.  I am in the middle of testing on this =
machine of many other things and building a kernel right now is not on =
my timeline.  Note that I have a magic 6 constant in there.  I derived =
this from dividing 32 by the bit mask 0x1f width of 5.  But looking =
further at this, it seems like chk_dbg should actually be a u64, and =
dma_dbg_4 and dma_dbg_5 placed into that value as a continuous 64bit =
value.  But again, I don=E2=80=99t know if there are 2 bits at the top =
of dma_dbg_4 and 3 bits at the bottom of dma_dbg_5 that go together. =
This needs to be fixed by someone with the time and the knowledge of =
what=E2=80=99s going on in the hardware.
>=20
> The comment from drivers/net/wireless/ath/ath9k/ar9003_hw.c only some
> lines above seems to support your reasoning (for the '6' constant, not
> for the packaging into an u64 - bit 30-31 unused):
>=20
> 1073 /*             =20
> 1074  * MAC HW hang check
> 1075  * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 1076  *
> 1077  * Signature: dcu_chain_state is 0x6 and dcu_complete_state is =
0x1.
> 1078  *
> 1079  * The state of each DCU chain (mapped to TX queues) is available =
from these
> 1080  * DMA debug registers:
> 1081  *     =20
> 1082  * Chain 0 state : Bits 4:0   of AR_DMADBG_4
> 1083  * Chain 1 state : Bits 9:5   of AR_DMADBG_4
> 1084  * Chain 2 state : Bits 14:10 of AR_DMADBG_4
> 1085  * Chain 3 state : Bits 19:15 of AR_DMADBG_4
> 1086  * Chain 4 state : Bits 24:20 of AR_DMADBG_4
> 1087  * Chain 5 state : Bits 29:25 of AR_DMADBG_4
> 1088  * Chain 6 state : Bits 4:0   of AR_DMADBG_5
> 1089  * Chain 7 state : Bits 9:5   of AR_DMADBG_5
> 1090  * Chain 8 state : Bits 14:10 of AR_DMADBG_5
> 1091  * Chain 9 state : Bits 19:15 of AR_DMADBG_5
> 1092  *             =20
> 1093  * The DCU chain state "0x6" means "WAIT_FRDONE" - wait for TX =
frame to be done.
> 1094  */    =20
>=20
> But with the same/similar bug some lines below (dma_dbg_chain is =
AR_DMADBG_4
> for queue < 6 and AR_DMADBG_5 above):
>=20
> 1112                 dcu_chain_state =3D (dma_dbg_chain >> (5 * =
queue)) & 0x1f;
>=20
> Regards,
> Peter
>=20
>=20
>>=20
>> Gregg Wonderly
>>=20
>>> On Mar 22, 2023, at 4:33 PM, Toke H=C3=B8iland-J=C3=B8rgensen =
<toke@kernel.org> wrote:
>>>=20
>>> Gregg Wonderly <greggwonderly@seqtechllc.com> writes:
>>>=20
>>>> I am receiving a console error message from this driver that =
appears to be in the following function.  In this function, the chk_dbg =
variable is 32bits and there is logic that seems to attempt to select =
from 1 of 2 different 32bit values to get a 64bit wide mask value into =
chk_dbg from dma_dbg_4 or dmc_dbg_5.
>>>>=20
>>>> The problem is that the (5*i) shift count should be have i adjusted =
by the 6 limit used to make the check for which dma_dbg_[45] value =
selected.
>>>>=20
>>>>=20
>>>> static bool ar9003_hw_detect_mac_hang(struct ath_hw *ah)
>>>> {
>>>> 	u32 dma_dbg_4, dma_dbg_5, dma_dbg_6, chk_dbg;
>>>> 	u8 dcu_chain_state, dcu_complete_state;
>>>> 	bool dcu_wait_frdone =3D false;
>>>> 	unsigned long chk_dcu =3D 0;
>>>> 	unsigned int i =3D 0;
>>>> 	dma_dbg_4 =3D REG_READ(ah, AR_DMADBG_4);
>>>> 	dma_dbg_5 =3D REG_READ(ah, AR_DMADBG_5);
>>>> 	dma_dbg_6 =3D REG_READ(ah, AR_DMADBG_6);
>>>> 	dcu_complete_state =3D dma_dbg_6 & 0x3;
>>>> 	if (dcu_complete_state !=3D 0x1)
>>>> 		goto exit;
>>>> 	for (i =3D 0; i < ATH9K_NUM_TX_QUEUES; i++) {
>>>> 		if (i < 6)
>>>> 			chk_dbg =3D dma_dbg_4;
>>>> 		else
>>>> 			chk_dbg =3D dma_dbg_5;
>>>> 		dcu_chain_state =3D (chk_dbg >> (5 * i)) & 0x1f;
>>>> 		if (dcu_chain_state =3D=3D 0x6) {
>>>> 			dcu_wait_frdone =3D true;
>>>> 			chk_dcu |=3D BIT(i);
>>>> 		}
>>>> 	}
>>>> 	if ((dcu_complete_state =3D=3D 0x1) && dcu_wait_frdone) {
>>>> 		for_each_set_bit(i, &chk_dcu, ATH9K_NUM_TX_QUEUES) {
>>>> 			if (ath9k_hw_verify_hang(ah, i))
>>>> 				return true;
>>>> 		}
>>>> 	}
>>>> exit:
>>>> 	return false;
>>>> }
>>>>=20
>>>> The for loop seems to need to look like the following:
>>>>=20
>>>> 	for (i =3D 0; i < ATH9K_NUM_TX_QUEUES; i++) {
>>>>              int off=3Di;
>>>> 		if (i < 6) {
>>>> 			chk_dbg =3D dma_dbg_4;
>>>> 		} else {
>>>> 			chk_dbg =3D dma_dbg_5;
>>>>                      off =3D i - 6;
>>>>              }
>>>> 		dcu_chain_state =3D (chk_dbg >> (5 * off)) & 0x1f;
>>>> 		if (dcu_chain_state =3D=3D 0x6) {
>>>> 			dcu_wait_frdone =3D true;
>>>> 			chk_dcu |=3D BIT(i);
>>>> 		}
>>>> 	}
>>>>=20
>>>=20
>>> Did you test this? Please send a proper patch :)
>>>=20
>>> -Toke =20
>>=20
>=20

