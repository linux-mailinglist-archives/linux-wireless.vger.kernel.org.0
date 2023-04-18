Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AED06E6FCE
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Apr 2023 01:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjDRXEB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Apr 2023 19:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjDRXEA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Apr 2023 19:04:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F066A8A55
        for <linux-wireless@vger.kernel.org>; Tue, 18 Apr 2023 16:03:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B31662D99
        for <linux-wireless@vger.kernel.org>; Tue, 18 Apr 2023 23:03:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2139C433D2;
        Tue, 18 Apr 2023 23:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681859038;
        bh=OqssrzDFTrOD77Fe+rdg8Q1d9TJ7aRP4VySdgP5oBfQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=m16pmfKcyN6gPoZf0TOTNzO6eD81jWa9sAM9bY3tsOvz7YSN3c8i7CFPfcHSaSJ3m
         8T2c/FjaZQtHnqwU3WRhqLrUdUKwlq3yUvOOTFZ7wGpyTlOVbbxKYWrVStuL88uYhT
         esDkdkNPEu3+nO1f8Pcb6LL/hloH9yMjRFj/N3DDlgec8/co4sgzWRrUhDCDzRkwyc
         zWxbxSPhLoNILMBHH3PfWPLtzIcay0uZ23KTOkEGO/3BaiYe0qeswedggtG16s7kW2
         0CZxxPPUtxAteabUV+E6GnH2xf6SqO6KvZ/UCcQ5L1gagbYxXfHuF7P6VcG5v2wlXY
         caBzXoT9i2PWA==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 9F4F7AA86E0; Wed, 19 Apr 2023 01:03:55 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To:     Peter Seiderer <ps.report@gmx.net>
Cc:     Gregg Wonderly <greggwonderly@seqtechllc.com>,
        linux-wireless@vger.kernel.org
Subject: Re: shift exponent 35 is too large @ ath/ath9k/ar9003_hw.c:1147
In-Reply-To: <20230418231450.7de58120@gmx.net>
References: <E3A9C354-0CB7-420C-ADEF-F0177FB722F4@seqtechllc.com>
 <87cz5079p1.fsf@toke.dk>
 <27B86217-CA79-4E4A-842B-9B2341B48B13@seqtechllc.com>
 <20230330181138.5a881d19@gmx.net> <87h6tjzau7.fsf@toke.dk>
 <20230418231450.7de58120@gmx.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 19 Apr 2023 01:03:55 +0200
Message-ID: <87fs8wvllw.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Peter Seiderer <ps.report@gmx.net> writes:

> Hello Toke,
>
> On Fri, 14 Apr 2023 00:17:04 +0200, Toke H=C3=B8iland-J=C3=B8rgensen <tok=
e@kernel.org> wrote:
>
>> Peter Seiderer <ps.report@gmx.net> writes:
>>=20
>> > Hello Gregg, Toke,
>> >
>> > On Thu, 30 Mar 2023 08:44:25 -0500, Gregg Wonderly <greggwonderly@seqt=
echllc.com> wrote:
>> >=20=20
>> >> I have not tested this.  I am in the middle of testing on this machin=
e of many other things and building a kernel right now is not on my timelin=
e.  Note that I have a magic 6 constant in there.  I derived this from divi=
ding 32 by the bit mask 0x1f width of 5.  But looking further at this, it s=
eems like chk_dbg should actually be a u64, and dma_dbg_4 and dma_dbg_5 pla=
ced into that value as a continuous 64bit value.  But again, I don=E2=80=99=
t know if there are 2 bits at the top of dma_dbg_4 and 3 bits at the bottom=
 of dma_dbg_5 that go together. This needs to be fixed by someone with the =
time and the knowledge of what=E2=80=99s going on in the hardware.=20=20
>> >
>> > The comment from drivers/net/wireless/ath/ath9k/ar9003_hw.c only some
>> > lines above seems to support your reasoning (for the '6' constant, not
>> > for the packaging into an u64 - bit 30-31 unused):
>> >
>> > 1073 /*=20=20=20=20=20=20=20=20=20=20=20=20=20=20
>> > 1074  * MAC HW hang check
>> > 1075  * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > 1076  *
>> > 1077  * Signature: dcu_chain_state is 0x6 and dcu_complete_state is 0x=
1.
>> > 1078  *
>> > 1079  * The state of each DCU chain (mapped to TX queues) is available=
 from these
>> > 1080  * DMA debug registers:
>> > 1081  *=20=20=20=20=20=20
>> > 1082  * Chain 0 state : Bits 4:0   of AR_DMADBG_4
>> > 1083  * Chain 1 state : Bits 9:5   of AR_DMADBG_4
>> > 1084  * Chain 2 state : Bits 14:10 of AR_DMADBG_4
>> > 1085  * Chain 3 state : Bits 19:15 of AR_DMADBG_4
>> > 1086  * Chain 4 state : Bits 24:20 of AR_DMADBG_4
>> > 1087  * Chain 5 state : Bits 29:25 of AR_DMADBG_4
>> > 1088  * Chain 6 state : Bits 4:0   of AR_DMADBG_5
>> > 1089  * Chain 7 state : Bits 9:5   of AR_DMADBG_5
>> > 1090  * Chain 8 state : Bits 14:10 of AR_DMADBG_5
>> > 1091  * Chain 9 state : Bits 19:15 of AR_DMADBG_5
>> > 1092  *=20=20=20=20=20=20=20=20=20=20=20=20=20=20
>> > 1093  * The DCU chain state "0x6" means "WAIT_FRDONE" - wait for TX fr=
ame to be done.
>> > 1094  */=20=20=20=20=20
>> >
>> > But with the same/similar bug some lines below (dma_dbg_chain is AR_DM=
ADBG_4
>> > for queue < 6 and AR_DMADBG_5 above):
>> >
>> > 1112                 dcu_chain_state =3D (dma_dbg_chain >> (5 * queue)=
) & 0x1f;=20=20
>>=20
>> Okay, here is a patch fixing both places; could one of you please test
>> it?
>
> Sorry for the delayed answer..., did prepare already a similar patch (but
> without the optimization of moving out the dbg_reg/offset out of the for-
> loop in ath9k_hw_verify_hang) and tested it via some additional debug
> output....
>
> In IBSS mode with iperf running in both directions all 1 to 3 hours
> ar9003_hw_detect_mac_hang() triggers the additional check/call
> to ath9k_hw_verify_hang() but always without real hang outcome...

Great, thanks!

> Some (minor) style questions below...
>
>>=20
>> -Toke
>>=20
>> diff --git a/drivers/net/wireless/ath/ath9k/ar9003_hw.c b/drivers/net/wi=
reless/ath/ath9k/ar9003_hw.c
>> index 4f27a9fb1482..2e8570baabf6 100644
>> --- a/drivers/net/wireless/ath/ath9k/ar9003_hw.c
>> +++ b/drivers/net/wireless/ath/ath9k/ar9003_hw.c
>> @@ -1099,17 +1099,22 @@ static bool ath9k_hw_verify_hang(struct ath_hw *=
ah, unsigned int queue)
>>  {
>>  	u32 dma_dbg_chain, dma_dbg_complete;
>>  	u8 dcu_chain_state, dcu_complete_state;
>> +	unsigned int dbg_reg, offset;
>>  	int i;
>>=20=20
>> -	for (i =3D 0; i < NUM_STATUS_READS; i++) {
>> -		if (queue < 6)
>> -			dma_dbg_chain =3D REG_READ(ah, AR_DMADBG_4);
>> -		else
>> -			dma_dbg_chain =3D REG_READ(ah, AR_DMADBG_5);
>> +	if (queue < 6) {
>> +		dbg_reg =3D AR_DMADBG_4;
>> +		offset =3D queue;
>
> Or calculate the 'real' offset here:
>
> 		offset =3D queue * 5;
>
>> +	} else {
>> +		dbg_reg =3D AR_DMADBG_5;
>> +		offset =3D queue - 6;
>
> 		offset =3D (queue - 6) * 5;
>> +	}
>>=20=20
>> +	for (i =3D 0; i < NUM_STATUS_READS; i++) {
>> +		dma_dbg_chain =3D REG_READ(ah, dbg_reg);
>>  		dma_dbg_complete =3D REG_READ(ah, AR_DMADBG_6);
>>=20=20
>> -		dcu_chain_state =3D (dma_dbg_chain >> (5 * queue)) & 0x1f;
>> +		dcu_chain_state =3D (dma_dbg_chain >> (5 * offset)) & 0x1f;
>
> And a slightly simpler calculation here:
>
> 		dcu_chain_state =3D (dma_dbg_chain >> offset) & 0x1f;

Sure, SGTM.

> Or alternative (without offset var) solution:
>
> 		dcu_chain_state =3D (dma_dbg_chain >> (5 * (queue % 6))) & 0x1f;

Was trying to avoid the divide (in %) by defining the offset above
(probably a useless optimisation, but, well :)).

> Do you prefer to convert your suggestion into a complete patch/commit or
> should I update mine (incorporating the optimization of moving out the
> dbg_reg/offset out of the for-loop) and send to the mailing list?

I mostly wrote that because I wasn't sure any of y'all would send a
patch; so sure, please go ahead and submit a proper one :)

-Toke
