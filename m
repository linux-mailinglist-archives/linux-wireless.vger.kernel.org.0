Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFD76D0AC8
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Mar 2023 18:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjC3QMr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Mar 2023 12:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjC3QMq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Mar 2023 12:12:46 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609B3D53F
        for <linux-wireless@vger.kernel.org>; Thu, 30 Mar 2023 09:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1680192699; i=ps.report@gmx.net;
        bh=R1MKpNLk57oHIJUk4XQaSwCwGBdciofprJffbKefGxE=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
        b=BeWTn04rqVc3+7RWHBM7zvk5zh+pNGzl7OQcPeYbzcMpXJbxMuMtcR58/NjAqitxH
         s5jOMtRnQost9GhfknbCxNnUMaaFOLOHvTwmtt/uIo009MtjktszkVZX1gkVDdxAmD
         6FAxOF3EVj3esMYIl6J7H3SfA8rxThOE2axXeeXx9l4hPklZGQ9sN00PRJ2HZ2hPCY
         nsK2YrzjgbGgJ2n3Xw+o1epKqyyDpAhXJSgwE/tC2yhh6x1IjvA84PO0rPnKFtVcul
         8Kt9FTZ+xoYy1UhiaLwAiV0mccEo1logGAKCIBRkKrJ2/LGtGeYV0Hi/I85edKmh+8
         yI+AAe0YVmxeg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost ([62.216.208.135]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MvK0X-1qYN0E11Np-00rHUY; Thu, 30
 Mar 2023 18:11:39 +0200
Date:   Thu, 30 Mar 2023 18:11:38 +0200
From:   Peter Seiderer <ps.report@gmx.net>
To:     Gregg Wonderly <greggwonderly@seqtechllc.com>
Cc:     Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@kernel.org>,
        linux-wireless@vger.kernel.org
Subject: Re: shift exponent 35 is too large @ ath/ath9k/ar9003_hw.c:1147
Message-ID: <20230330181138.5a881d19@gmx.net>
In-Reply-To: <27B86217-CA79-4E4A-842B-9B2341B48B13@seqtechllc.com>
References: <E3A9C354-0CB7-420C-ADEF-F0177FB722F4@seqtechllc.com>
        <87cz5079p1.fsf@toke.dk>
        <27B86217-CA79-4E4A-842B-9B2341B48B13@seqtechllc.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pWmrVvjzkodlL1ngB5/Pf97FJpD0QMY3+K/1Zf66AMoyWPRFgnJ
 KjI4mVrX5P/HVi9kF31T9D3me/zIOdmuhfLZjoM92cKj3UvzCTjz4Hfw1o6blN+HFwvucg3
 VoZrcZq6tta4y6wrb3X3wtWvt+jdGLmu1TNPC71/pNKFC8q6XIkFhS7rh0sVK1XIWEY350B
 sQmpF4a0KkwnP4dSc8ZnQ==
UI-OutboundReport: notjunk:1;M01:P0:cjy3GItbiC8=;n6MdKIsnpxpk/f7XoSBPqo87tjO
 V4FnCx0okAxY4CTZm1WQgvwdtbtwzvC/ibBepA8ZgCyHW/1AEp3k1YuNtUIlI/tMHJXhz7qvM
 bwhXFX700sn8HX5aWeX0ZoqyX27NOADQWc/HjUbj+W9KTASIwt0Z6LoKKcekYCiZYm5oiatWr
 cU/Qk9quShVgUnAoVCVMkbYgKdTTN/Hrvl+Q8rL5LquuBSt6PnxPzUOyMLMxe9TXGgm7Ycuak
 XTESsLDA81KVn0DLhGwm93SwM2RbkiGALHDB3G24thLDrBZeo9eQsPPKnPTjKtriVlGqdC1hu
 i02ZyZt4EqN5t4b6V8+Xkw29gBqIqk2Hc8V+ZucyF1roT+7Hg5FZr3/95tKUMPIECPPNXSAwU
 g05hRF2HbUHM9aG3E3/wnffBZD6cxyEb3v/9cVG0o46jVV9DcWhuZlJN1jVEEO9i9nKJpvZt3
 jRINjXuufaDB0IaWpSW75xDb2/5A8XarNybkAbr4vQUaXjaXfgplO+MXVqShYj5pX4fqAKWBC
 BngEn5/DJSOoQAvr7NE8zEyMN066RvXBt4YnwNjwZ03j7tagAL7VsXkZ6KVWzaYnUOtvft/+Z
 2DxwbrP2fTs6yTBZkIH/gaEqmg20P4hrGJ9EgJ+zROpc3wA0r0z7iZJ3iiYL4zrBIywIbMhF3
 tpnPBVvOOs+gwDN01v5MsO6RHwIXBZm/JxfwTvX1Zl0ufKYE9nsnmEuGART9G5MzyuyHn0P2/
 SAUVfk+LxN9QHNqN16KmcJEs2EmZ4KKVIqckPZIPDDQG/9KYSo198Iv6kKcs1mD2zGjS9AkXy
 bfx3hppo/QxpuEPJM5Fr8HIOt46B1JSRpxXfIf0ziwKLVYamd/a00BMB4mG+yZ4ZHHDa+B0z2
 YnqlVU43h5VVuL7j1aX+1w3qjvEkfLP1ueqe3TcRxFwfE9VPFFuj/fg+UPAIsnucNzYG3yBvn
 UG/ViUTZ0BGfHVqfhSH9FC+Fbf4=
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Gregg, Toke,

On Thu, 30 Mar 2023 08:44:25 -0500, Gregg Wonderly <greggwonderly@seqtechll=
c.com> wrote:

> I have not tested this.  I am in the middle of testing on this machine of=
 many other things and building a kernel right now is not on my timeline.  =
Note that I have a magic 6 constant in there.  I derived this from dividing=
 32 by the bit mask 0x1f width of 5.  But looking further at this, it seems=
 like chk_dbg should actually be a u64, and dma_dbg_4 and dma_dbg_5 placed =
into that value as a continuous 64bit value.  But again, I don=E2=80=99t kn=
ow if there are 2 bits at the top of dma_dbg_4 and 3 bits at the bottom of =
dma_dbg_5 that go together. This needs to be fixed by someone with the time=
 and the knowledge of what=E2=80=99s going on in the hardware.

The comment from drivers/net/wireless/ath/ath9k/ar9003_hw.c only some
lines above seems to support your reasoning (for the '6' constant, not
for the packaging into an u64 - bit 30-31 unused):

1073 /*             =20
1074  * MAC HW hang check
1075  * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
1076  *
1077  * Signature: dcu_chain_state is 0x6 and dcu_complete_state is 0x1.
1078  *
1079  * The state of each DCU chain (mapped to TX queues) is available from=
 these
1080  * DMA debug registers:
1081  *     =20
1082  * Chain 0 state : Bits 4:0   of AR_DMADBG_4
1083  * Chain 1 state : Bits 9:5   of AR_DMADBG_4
1084  * Chain 2 state : Bits 14:10 of AR_DMADBG_4
1085  * Chain 3 state : Bits 19:15 of AR_DMADBG_4
1086  * Chain 4 state : Bits 24:20 of AR_DMADBG_4
1087  * Chain 5 state : Bits 29:25 of AR_DMADBG_4
1088  * Chain 6 state : Bits 4:0   of AR_DMADBG_5
1089  * Chain 7 state : Bits 9:5   of AR_DMADBG_5
1090  * Chain 8 state : Bits 14:10 of AR_DMADBG_5
1091  * Chain 9 state : Bits 19:15 of AR_DMADBG_5
1092  *             =20
1093  * The DCU chain state "0x6" means "WAIT_FRDONE" - wait for TX frame t=
o be done.
1094  */    =20

But with the same/similar bug some lines below (dma_dbg_chain is AR_DMADBG_4
for queue < 6 and AR_DMADBG_5 above):

1112                 dcu_chain_state =3D (dma_dbg_chain >> (5 * queue)) & 0=
x1f;

Regards,
Peter


>=20
> Gregg Wonderly
>=20
> > On Mar 22, 2023, at 4:33 PM, Toke H=C3=B8iland-J=C3=B8rgensen <toke@ker=
nel.org> wrote:
> >=20
> > Gregg Wonderly <greggwonderly@seqtechllc.com> writes:
> >  =20
> >> I am receiving a console error message from this driver that appears t=
o be in the following function.  In this function, the chk_dbg variable is =
32bits and there is logic that seems to attempt to select from 1 of 2 diffe=
rent 32bit values to get a 64bit wide mask value into chk_dbg from dma_dbg_=
4 or dmc_dbg_5.
> >>=20
> >> The problem is that the (5*i) shift count should be have i adjusted by=
 the 6 limit used to make the check for which dma_dbg_[45] value selected.
> >>=20
> >>=20
> >> static bool ar9003_hw_detect_mac_hang(struct ath_hw *ah)
> >> {
> >> 	u32 dma_dbg_4, dma_dbg_5, dma_dbg_6, chk_dbg;
> >> 	u8 dcu_chain_state, dcu_complete_state;
> >> 	bool dcu_wait_frdone =3D false;
> >> 	unsigned long chk_dcu =3D 0;
> >> 	unsigned int i =3D 0;
> >> 	dma_dbg_4 =3D REG_READ(ah, AR_DMADBG_4);
> >> 	dma_dbg_5 =3D REG_READ(ah, AR_DMADBG_5);
> >> 	dma_dbg_6 =3D REG_READ(ah, AR_DMADBG_6);
> >> 	dcu_complete_state =3D dma_dbg_6 & 0x3;
> >> 	if (dcu_complete_state !=3D 0x1)
> >> 		goto exit;
> >> 	for (i =3D 0; i < ATH9K_NUM_TX_QUEUES; i++) {
> >> 		if (i < 6)
> >> 			chk_dbg =3D dma_dbg_4;
> >> 		else
> >> 			chk_dbg =3D dma_dbg_5;
> >> 		dcu_chain_state =3D (chk_dbg >> (5 * i)) & 0x1f;
> >> 		if (dcu_chain_state =3D=3D 0x6) {
> >> 			dcu_wait_frdone =3D true;
> >> 			chk_dcu |=3D BIT(i);
> >> 		}
> >> 	}
> >> 	if ((dcu_complete_state =3D=3D 0x1) && dcu_wait_frdone) {
> >> 		for_each_set_bit(i, &chk_dcu, ATH9K_NUM_TX_QUEUES) {
> >> 			if (ath9k_hw_verify_hang(ah, i))
> >> 				return true;
> >> 		}
> >> 	}
> >> exit:
> >> 	return false;
> >> }
> >>=20
> >> The for loop seems to need to look like the following:
> >>=20
> >> 	for (i =3D 0; i < ATH9K_NUM_TX_QUEUES; i++) {
> >>               int off=3Di;
> >> 		if (i < 6) {
> >> 			chk_dbg =3D dma_dbg_4;
> >> 		} else {
> >> 			chk_dbg =3D dma_dbg_5;
> >>                       off =3D i - 6;
> >>               }
> >> 		dcu_chain_state =3D (chk_dbg >> (5 * off)) & 0x1f;
> >> 		if (dcu_chain_state =3D=3D 0x6) {
> >> 			dcu_wait_frdone =3D true;
> >> 			chk_dcu |=3D BIT(i);
> >> 		}
> >> 	}
> >>  =20
> >=20
> > Did you test this? Please send a proper patch :)
> >=20
> > -Toke =20
>=20

