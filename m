Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 257756E6DEA
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Apr 2023 23:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbjDRVPN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Apr 2023 17:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbjDRVPM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Apr 2023 17:15:12 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812FF55AC
        for <linux-wireless@vger.kernel.org>; Tue, 18 Apr 2023 14:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1681852503; i=ps.report@gmx.net;
        bh=4COBRp4iP8Pcrumbl2cTqBgwwjrgDO+b/j7uX78lRm4=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
        b=SV0OBr5bXeBhhfG4Gy5ET8WJkZ2WhKdMA3WqAuLl0DnRokQW5T0Caumryv1+lcj+L
         kBnueGw4KmCqMetj+7IYFfN3NVI9vJP8Sx8ZqWQ3yOIYnCtYho65lw9AeWH4Yi67ez
         0kg0urRDoXEgMa21X8Tr+bEZXeTgcplsH8vtN9rJOvFLt7UBxxsPzQWz0W7aY12zWD
         MI1NhjoCHiN5P2orRTtCE19/NhBO9Cp/mVj1v/Mspgvs8Lg5KQVLPqaTMlztRRAbbG
         TlKSoEuPhoslrX+8YCTBR6uAyoPw8XZM8N1tTr57zJ2IAyjQybOOhr4gIonOp8mpG6
         YalvgM/gtYupw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost ([62.216.208.98]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MXp9Y-1pq62d2uFA-00YDud; Tue, 18
 Apr 2023 23:15:03 +0200
Date:   Tue, 18 Apr 2023 23:14:50 +0200
From:   Peter Seiderer <ps.report@gmx.net>
To:     Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@kernel.org>
Cc:     Gregg Wonderly <greggwonderly@seqtechllc.com>,
        linux-wireless@vger.kernel.org
Subject: Re: shift exponent 35 is too large @ ath/ath9k/ar9003_hw.c:1147
Message-ID: <20230418231450.7de58120@gmx.net>
In-Reply-To: <87h6tjzau7.fsf@toke.dk>
References: <E3A9C354-0CB7-420C-ADEF-F0177FB722F4@seqtechllc.com>
        <87cz5079p1.fsf@toke.dk>
        <27B86217-CA79-4E4A-842B-9B2341B48B13@seqtechllc.com>
        <20230330181138.5a881d19@gmx.net>
        <87h6tjzau7.fsf@toke.dk>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Rfm/eIYTwZ91g8m0I8ujv/yTcszPZPafmDF2a4tWo+ahgeB8dCe
 /nra03f2ln+/NJ1WrDFbHxktzJB322G+s1fHZDrswlo2Hkf9dqi7cQ9uV3gLyQjxFQtBplV
 QxExlyl+i/GIZ/Qa+yWsXQ2VPLxpJk7iJs+3dj/l5gLeb6wIihaDaueOrb+Er0VRqjL8j4s
 K0j1fB4Zf5Eyt/NKAGYhA==
UI-OutboundReport: notjunk:1;M01:P0:Dklb53Uwaxg=;+GUbxHfsjiPPmTkQWlHrzn2CPZt
 FOMt93UsiiFWOICxbFelGuZSYH98ZAzeODmJIVCBQwuYrJRNKTkiSY0EfUeCN1thghw8U85nk
 nprK6NABRepVPzqMf6MeU+M0+/NY+Luvo/NHkY8bWz6ws5K/KYbVJMzQ53dBoaXt0lX8rUL5Q
 LX67C6UxgIautxrj+CxkBtbsQwJtbS8g4qrt1YD5uzN4RYk8sLXzNOT2QC5eudPTXxYWi2IZY
 +AFj+eZpUKrshyscm/qZ+KV0om9dOKA2R4Abmp9hkLqQky8PtHAltpcZfekdd6BR4zC4dWH2N
 H6StIqmLPdG/ppQsbIXMRqdY4Smua9r3IDJxhnxufnSvnzLNPuCXV6OyGQ9VaFoM/x9rJLxd8
 GsoR4hcIp5dSFkIm7PurK0xpIXOYYhydaPqF3FwI61AIjH1sfb45dNahgfu4P+vEa4LRWRaaQ
 xNYjZ01oO/wdQZtd9Fw2wRlnmrcKWQjDUEUCx2705gs/AcijqHwAdZ6lEkTzUk/rR0z+OlPak
 SQuXiP8bwGrvmdOkKh0tgc74UnQUpWat9wvt8xGZq/V+spIBiyI9XQ7B+7G70hqKwFerCwhby
 SyP3LObrSYFNBbXVld5Z4RdlBA9WSMDgOlmDsKQ4uELCMhzURd0qKMN7ZYyDUyeM5Kte10LdT
 WQPDzBLCA67+NwHgkc8zEpHkynjNfZdQi+dsDR8aEwZevHY8sujW14HYy6BcX9l1MttB3p77U
 2VzifdTvOQPlhUg6fFSbrasIhWT5cDHRm8WTRZmnN3OBNm2seekEdkr0+MGO0dGJVmFxqDlkj
 cf/kcpKSr62/G/+MQg11eFAZFvGGQ+OqNhxQogBUROljCPZjHQ+25ACbbN2HkgdDgs6TSyY9x
 27s3eMKKj8wIDEV2AZeLyUzDjk+ro9yfIAy9ApyXUnmcniORHKYKmHQZrE4tNji2EmOy3Exiq
 fbbLwrK7xX0cevIpLumkt3++hXM=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Toke,

On Fri, 14 Apr 2023 00:17:04 +0200, Toke H=C3=B8iland-J=C3=B8rgensen <toke@=
kernel.org> wrote:

> Peter Seiderer <ps.report@gmx.net> writes:
>=20
> > Hello Gregg, Toke,
> >
> > On Thu, 30 Mar 2023 08:44:25 -0500, Gregg Wonderly <greggwonderly@seqte=
chllc.com> wrote:
> > =20
> >> I have not tested this.  I am in the middle of testing on this machine=
 of many other things and building a kernel right now is not on my timeline=
.  Note that I have a magic 6 constant in there.  I derived this from divid=
ing 32 by the bit mask 0x1f width of 5.  But looking further at this, it se=
ems like chk_dbg should actually be a u64, and dma_dbg_4 and dma_dbg_5 plac=
ed into that value as a continuous 64bit value.  But again, I don=E2=80=99t=
 know if there are 2 bits at the top of dma_dbg_4 and 3 bits at the bottom =
of dma_dbg_5 that go together. This needs to be fixed by someone with the t=
ime and the knowledge of what=E2=80=99s going on in the hardware. =20
> >
> > The comment from drivers/net/wireless/ath/ath9k/ar9003_hw.c only some
> > lines above seems to support your reasoning (for the '6' constant, not
> > for the packaging into an u64 - bit 30-31 unused):
> >
> > 1073 /*             =20
> > 1074  * MAC HW hang check
> > 1075  * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > 1076  *
> > 1077  * Signature: dcu_chain_state is 0x6 and dcu_complete_state is 0x1.
> > 1078  *
> > 1079  * The state of each DCU chain (mapped to TX queues) is available =
from these
> > 1080  * DMA debug registers:
> > 1081  *     =20
> > 1082  * Chain 0 state : Bits 4:0   of AR_DMADBG_4
> > 1083  * Chain 1 state : Bits 9:5   of AR_DMADBG_4
> > 1084  * Chain 2 state : Bits 14:10 of AR_DMADBG_4
> > 1085  * Chain 3 state : Bits 19:15 of AR_DMADBG_4
> > 1086  * Chain 4 state : Bits 24:20 of AR_DMADBG_4
> > 1087  * Chain 5 state : Bits 29:25 of AR_DMADBG_4
> > 1088  * Chain 6 state : Bits 4:0   of AR_DMADBG_5
> > 1089  * Chain 7 state : Bits 9:5   of AR_DMADBG_5
> > 1090  * Chain 8 state : Bits 14:10 of AR_DMADBG_5
> > 1091  * Chain 9 state : Bits 19:15 of AR_DMADBG_5
> > 1092  *             =20
> > 1093  * The DCU chain state "0x6" means "WAIT_FRDONE" - wait for TX fra=
me to be done.
> > 1094  */    =20
> >
> > But with the same/similar bug some lines below (dma_dbg_chain is AR_DMA=
DBG_4
> > for queue < 6 and AR_DMADBG_5 above):
> >
> > 1112                 dcu_chain_state =3D (dma_dbg_chain >> (5 * queue))=
 & 0x1f; =20
>=20
> Okay, here is a patch fixing both places; could one of you please test
> it?

Sorry for the delayed answer..., did prepare already a similar patch (but
without the optimization of moving out the dbg_reg/offset out of the for-
loop in ath9k_hw_verify_hang) and tested it via some additional debug
output....

In IBSS mode with iperf running in both directions all 1 to 3 hours
ar9003_hw_detect_mac_hang() triggers the additional check/call
to ath9k_hw_verify_hang() but always without real hang outcome...

Some (minor) style questions below...

>=20
> -Toke
>=20
> diff --git a/drivers/net/wireless/ath/ath9k/ar9003_hw.c b/drivers/net/wir=
eless/ath/ath9k/ar9003_hw.c
> index 4f27a9fb1482..2e8570baabf6 100644
> --- a/drivers/net/wireless/ath/ath9k/ar9003_hw.c
> +++ b/drivers/net/wireless/ath/ath9k/ar9003_hw.c
> @@ -1099,17 +1099,22 @@ static bool ath9k_hw_verify_hang(struct ath_hw *a=
h, unsigned int queue)
>  {
>  	u32 dma_dbg_chain, dma_dbg_complete;
>  	u8 dcu_chain_state, dcu_complete_state;
> +	unsigned int dbg_reg, offset;
>  	int i;
> =20
> -	for (i =3D 0; i < NUM_STATUS_READS; i++) {
> -		if (queue < 6)
> -			dma_dbg_chain =3D REG_READ(ah, AR_DMADBG_4);
> -		else
> -			dma_dbg_chain =3D REG_READ(ah, AR_DMADBG_5);
> +	if (queue < 6) {
> +		dbg_reg =3D AR_DMADBG_4;
> +		offset =3D queue;

Or calculate the 'real' offset here:

		offset =3D queue * 5;

> +	} else {
> +		dbg_reg =3D AR_DMADBG_5;
> +		offset =3D queue - 6;

		offset =3D (queue - 6) * 5;
> +	}
> =20
> +	for (i =3D 0; i < NUM_STATUS_READS; i++) {
> +		dma_dbg_chain =3D REG_READ(ah, dbg_reg);
>  		dma_dbg_complete =3D REG_READ(ah, AR_DMADBG_6);
> =20
> -		dcu_chain_state =3D (dma_dbg_chain >> (5 * queue)) & 0x1f;
> +		dcu_chain_state =3D (dma_dbg_chain >> (5 * offset)) & 0x1f;

And a slightly simpler calculation here:

		dcu_chain_state =3D (dma_dbg_chain >> offset) & 0x1f;

Or alternative (without offset var) solution:

		dcu_chain_state =3D (dma_dbg_chain >> (5 * (queue % 6))) & 0x1f;

Do you prefer to convert your suggestion into a complete patch/commit or
should I update mine (incorporating the optimization of moving out the
dbg_reg/offset out of the for-loop) and send to the mailing list?

Regards,
Peter


>  		dcu_complete_state =3D dma_dbg_complete & 0x3;
> =20
>  		if ((dcu_chain_state !=3D 0x6) || (dcu_complete_state !=3D 0x1))
> @@ -1139,12 +1144,17 @@ static bool ar9003_hw_detect_mac_hang(struct ath_=
hw *ah)
>  		goto exit;
> =20
>  	for (i =3D 0; i < ATH9K_NUM_TX_QUEUES; i++) {
> -		if (i < 6)
> +		unsigned int offset;
> +
> +		if (i < 6) {
>  			chk_dbg =3D dma_dbg_4;
> -		else
> +			offset =3D i;
> +		} else {
>  			chk_dbg =3D dma_dbg_5;
> +			offset =3D i - 6;
> +		}
> =20
> -		dcu_chain_state =3D (chk_dbg >> (5 * i)) & 0x1f;
> +		dcu_chain_state =3D (chk_dbg >> (5 * offset)) & 0x1f;
>  		if (dcu_chain_state =3D=3D 0x6) {
>  			dcu_wait_frdone =3D true;
>  			chk_dcu |=3D BIT(i);

