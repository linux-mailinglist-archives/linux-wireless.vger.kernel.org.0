Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7292B6E173A
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Apr 2023 00:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjDMWRL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Apr 2023 18:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjDMWRK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Apr 2023 18:17:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D87C6A5A
        for <linux-wireless@vger.kernel.org>; Thu, 13 Apr 2023 15:17:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BABD6641AD
        for <linux-wireless@vger.kernel.org>; Thu, 13 Apr 2023 22:17:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7093C433D2;
        Thu, 13 Apr 2023 22:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681424227;
        bh=EPPsXYyb7OTHXr2IvbHMAmLhIU6g6nJreUrPLB94Z3w=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=gh9/+aYoa99K806hKwQkyWppPnrYWJ7sNZDFTNzZlKl7e8T33skIX656JvyXKRRbN
         SZ/5awcML1bY1XV0Ng4CAhxSA+RYABc46kH7bcSF7f+yxB2HePR3GaWFTKsTVO5QR7
         MLSTybtsSnjG0mFb+18neucLAFao4wQ2yrA57wD2R1al9HLBni/+lPOnsWkqO93bsE
         ky06sbXpqY4Y2qFVE2ML4h6h7m/fQoCtNOKp9vxogJo8xP/s4PeIsm2UrmxrArfaWE
         zch7BX1b77kNrWrqnE7fQp2mXplHEFBwm5usCLsw34X0l388Bn+oKUasM83nigCFei
         zqkf9nGvh1z2A==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 76EDFAA7BC5; Fri, 14 Apr 2023 00:17:04 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To:     Peter Seiderer <ps.report@gmx.net>,
        Gregg Wonderly <greggwonderly@seqtechllc.com>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: shift exponent 35 is too large @ ath/ath9k/ar9003_hw.c:1147
In-Reply-To: <20230330181138.5a881d19@gmx.net>
References: <E3A9C354-0CB7-420C-ADEF-F0177FB722F4@seqtechllc.com>
 <87cz5079p1.fsf@toke.dk>
 <27B86217-CA79-4E4A-842B-9B2341B48B13@seqtechllc.com>
 <20230330181138.5a881d19@gmx.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 14 Apr 2023 00:17:04 +0200
Message-ID: <87h6tjzau7.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Peter Seiderer <ps.report@gmx.net> writes:

> Hello Gregg, Toke,
>
> On Thu, 30 Mar 2023 08:44:25 -0500, Gregg Wonderly <greggwonderly@seqtech=
llc.com> wrote:
>
>> I have not tested this.  I am in the middle of testing on this machine o=
f many other things and building a kernel right now is not on my timeline. =
 Note that I have a magic 6 constant in there.  I derived this from dividin=
g 32 by the bit mask 0x1f width of 5.  But looking further at this, it seem=
s like chk_dbg should actually be a u64, and dma_dbg_4 and dma_dbg_5 placed=
 into that value as a continuous 64bit value.  But again, I don=E2=80=99t k=
now if there are 2 bits at the top of dma_dbg_4 and 3 bits at the bottom of=
 dma_dbg_5 that go together. This needs to be fixed by someone with the tim=
e and the knowledge of what=E2=80=99s going on in the hardware.
>
> The comment from drivers/net/wireless/ath/ath9k/ar9003_hw.c only some
> lines above seems to support your reasoning (for the '6' constant, not
> for the packaging into an u64 - bit 30-31 unused):
>
> 1073 /*=20=20=20=20=20=20=20=20=20=20=20=20=20=20
> 1074  * MAC HW hang check
> 1075  * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 1076  *
> 1077  * Signature: dcu_chain_state is 0x6 and dcu_complete_state is 0x1.
> 1078  *
> 1079  * The state of each DCU chain (mapped to TX queues) is available fr=
om these
> 1080  * DMA debug registers:
> 1081  *=20=20=20=20=20=20
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
> 1092  *=20=20=20=20=20=20=20=20=20=20=20=20=20=20
> 1093  * The DCU chain state "0x6" means "WAIT_FRDONE" - wait for TX frame=
 to be done.
> 1094  */=20=20=20=20=20
>
> But with the same/similar bug some lines below (dma_dbg_chain is AR_DMADB=
G_4
> for queue < 6 and AR_DMADBG_5 above):
>
> 1112                 dcu_chain_state =3D (dma_dbg_chain >> (5 * queue)) &=
 0x1f;

Okay, here is a patch fixing both places; could one of you please test
it?

-Toke

diff --git a/drivers/net/wireless/ath/ath9k/ar9003_hw.c b/drivers/net/wirel=
ess/ath/ath9k/ar9003_hw.c
index 4f27a9fb1482..2e8570baabf6 100644
--- a/drivers/net/wireless/ath/ath9k/ar9003_hw.c
+++ b/drivers/net/wireless/ath/ath9k/ar9003_hw.c
@@ -1099,17 +1099,22 @@ static bool ath9k_hw_verify_hang(struct ath_hw *ah,=
 unsigned int queue)
 {
 	u32 dma_dbg_chain, dma_dbg_complete;
 	u8 dcu_chain_state, dcu_complete_state;
+	unsigned int dbg_reg, offset;
 	int i;
=20
-	for (i =3D 0; i < NUM_STATUS_READS; i++) {
-		if (queue < 6)
-			dma_dbg_chain =3D REG_READ(ah, AR_DMADBG_4);
-		else
-			dma_dbg_chain =3D REG_READ(ah, AR_DMADBG_5);
+	if (queue < 6) {
+		dbg_reg =3D AR_DMADBG_4;
+		offset =3D queue;
+	} else {
+		dbg_reg =3D AR_DMADBG_5;
+		offset =3D queue - 6;
+	}
=20
+	for (i =3D 0; i < NUM_STATUS_READS; i++) {
+		dma_dbg_chain =3D REG_READ(ah, dbg_reg);
 		dma_dbg_complete =3D REG_READ(ah, AR_DMADBG_6);
=20
-		dcu_chain_state =3D (dma_dbg_chain >> (5 * queue)) & 0x1f;
+		dcu_chain_state =3D (dma_dbg_chain >> (5 * offset)) & 0x1f;
 		dcu_complete_state =3D dma_dbg_complete & 0x3;
=20
 		if ((dcu_chain_state !=3D 0x6) || (dcu_complete_state !=3D 0x1))
@@ -1139,12 +1144,17 @@ static bool ar9003_hw_detect_mac_hang(struct ath_hw=
 *ah)
 		goto exit;
=20
 	for (i =3D 0; i < ATH9K_NUM_TX_QUEUES; i++) {
-		if (i < 6)
+		unsigned int offset;
+
+		if (i < 6) {
 			chk_dbg =3D dma_dbg_4;
-		else
+			offset =3D i;
+		} else {
 			chk_dbg =3D dma_dbg_5;
+			offset =3D i - 6;
+		}
=20
-		dcu_chain_state =3D (chk_dbg >> (5 * i)) & 0x1f;
+		dcu_chain_state =3D (chk_dbg >> (5 * offset)) & 0x1f;
 		if (dcu_chain_state =3D=3D 0x6) {
 			dcu_wait_frdone =3D true;
 			chk_dcu |=3D BIT(i);
