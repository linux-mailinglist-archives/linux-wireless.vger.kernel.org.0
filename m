Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5624B6D0733
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Mar 2023 15:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbjC3NpF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Mar 2023 09:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232059AbjC3NpC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Mar 2023 09:45:02 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6976BDC8
        for <linux-wireless@vger.kernel.org>; Thu, 30 Mar 2023 06:44:41 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id q23-20020a05683031b700b006a1370e214aso7145069ots.11
        for <linux-wireless@vger.kernel.org>; Thu, 30 Mar 2023 06:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=seqtechllc.com; s=google; t=1680183877;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iwcsnV9PI7cjjYT37XSQZUYM9/h/szm8FuKiFwTpB+E=;
        b=JHJ7KuLVBf/AOvBl3Fr/7vVEDPudAIp/NVmsC/n0hig5S5cqqrkwYNsosxwK3JlUNm
         /iP2QTLgwHJOZXrR5YNRwbBBAN4yuuD/pZrA39KKghuwHwRYHRyzvhc+DzBDhG45LBRh
         VKLXoJF9o3SeRnFAGfmQ+9cU2U0gceSGcaPgG0OS8otULr/bMh0kDFRdOxuLw1RH+Bli
         q6wSsOexODlcrX6Nq2TqMDPksb7uoTlDfxIV842crkloLb8C5zq3sNAIoqEAam7xuwZv
         5VnN6HoYmiBJqgxas3RD2luRxwz4gox9xBHzOU+icZ8NHAq5ZcZFR0Tp4r39zqXMzVwG
         doWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680183877;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iwcsnV9PI7cjjYT37XSQZUYM9/h/szm8FuKiFwTpB+E=;
        b=0N3qpWUDReXhk05GyMvY/8cfLtnlMnu6RZd7DRkExlMGf9RJRt1hSs+Yv/QF1aRag/
         6LXcaAJCMcXErnGb9xnEtE3OplDZU4ZjGcO7niA1OUfkTrxzRrrwCt6uuIWNnZ6HAjyO
         VnFGTJ3qX/U4CDQfdvGlEJ7aWM/77S2TmCGfk1rwZJwaSLo8AxvDfmoch7wO1QWDIZWG
         UDyyXx+rnfHa35153ZMj7QtKW5IK9J5rXbaXn356rhf0gdjUOALXwRPYZILeHSQPAA2z
         u9HONoUiEm+Oy6ufNSyidvGGZKAGbE2OWrrhCawbkmBiVYValA1f8CAhjuTkMHlzc5o4
         uzcg==
X-Gm-Message-State: AO0yUKV6JPDB8A35C3Am8o/5o47IsVOLs2EKkwtSl52Gw7aFoz7KIjOi
        N97zPscQt1cLLoLdwyiD+jD3ygt7nyVEI6BUx+PQoZZbvUS2ZAutkmApkDxa3AFaK3zgd8wCaYX
        kBOf8WWNSLYT2aOXOZm2sdGIVDZIUONHaY3uGqkJlTK2deLBwwoxGXECCIwMkPRf53Fg2DdJnwv
        rY1qyFtjfIWbkC7d3R/Lio2BIo/SvE5KaIS6FJTOA7KF9i+mvsXPUTjA==
X-Google-Smtp-Source: AK7set9CWRDoEQ83x5HxavcLGp5I4qlVisb8vnMXSv9vdSW2dTUNnmNFHDlJuk4CJj6pGPbyAHRnbg==
X-Received: by 2002:a05:6830:1e38:b0:69f:8a54:d6fa with SMTP id t24-20020a0568301e3800b0069f8a54d6famr11390899otr.10.1680183877091;
        Thu, 30 Mar 2023 06:44:37 -0700 (PDT)
Received: from smtpclient.apple ([67.202.189.242])
        by smtp.gmail.com with ESMTPSA id t16-20020a9d7750000000b006a036b9794asm7424416otl.37.2023.03.30.06.44.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Mar 2023 06:44:36 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: Re: shift exponent 35 is too large @ ath/ath9k/ar9003_hw.c:1147
From:   Gregg Wonderly <greggwonderly@seqtechllc.com>
In-Reply-To: <87cz5079p1.fsf@toke.dk>
Date:   Thu, 30 Mar 2023 08:44:25 -0500
Cc:     linux-wireless@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <27B86217-CA79-4E4A-842B-9B2341B48B13@seqtechllc.com>
References: <E3A9C354-0CB7-420C-ADEF-F0177FB722F4@seqtechllc.com>
 <87cz5079p1.fsf@toke.dk>
To:     =?utf-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
X-Mailer: Apple Mail (2.3731.400.51.1.1)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I have not tested this.  I am in the middle of testing on this machine =
of many other things and building a kernel right now is not on my =
timeline.  Note that I have a magic 6 constant in there.  I derived this =
from dividing 32 by the bit mask 0x1f width of 5.  But looking further =
at this, it seems like chk_dbg should actually be a u64, and dma_dbg_4 =
and dma_dbg_5 placed into that value as a continuous 64bit value.  But =
again, I don=E2=80=99t know if there are 2 bits at the top of dma_dbg_4 =
and 3 bits at the bottom of dma_dbg_5 that go together. This needs to be =
fixed by someone with the time and the knowledge of what=E2=80=99s going =
on in the hardware.

Gregg Wonderly

> On Mar 22, 2023, at 4:33 PM, Toke H=C3=B8iland-J=C3=B8rgensen =
<toke@kernel.org> wrote:
>=20
> Gregg Wonderly <greggwonderly@seqtechllc.com> writes:
>=20
>> I am receiving a console error message from this driver that appears =
to be in the following function.  In this function, the chk_dbg variable =
is 32bits and there is logic that seems to attempt to select from 1 of 2 =
different 32bit values to get a 64bit wide mask value into chk_dbg from =
dma_dbg_4 or dmc_dbg_5.
>>=20
>> The problem is that the (5*i) shift count should be have i adjusted =
by the 6 limit used to make the check for which dma_dbg_[45] value =
selected.
>>=20
>>=20
>> static bool ar9003_hw_detect_mac_hang(struct ath_hw *ah)
>> {
>> 	u32 dma_dbg_4, dma_dbg_5, dma_dbg_6, chk_dbg;
>> 	u8 dcu_chain_state, dcu_complete_state;
>> 	bool dcu_wait_frdone =3D false;
>> 	unsigned long chk_dcu =3D 0;
>> 	unsigned int i =3D 0;
>> 	dma_dbg_4 =3D REG_READ(ah, AR_DMADBG_4);
>> 	dma_dbg_5 =3D REG_READ(ah, AR_DMADBG_5);
>> 	dma_dbg_6 =3D REG_READ(ah, AR_DMADBG_6);
>> 	dcu_complete_state =3D dma_dbg_6 & 0x3;
>> 	if (dcu_complete_state !=3D 0x1)
>> 		goto exit;
>> 	for (i =3D 0; i < ATH9K_NUM_TX_QUEUES; i++) {
>> 		if (i < 6)
>> 			chk_dbg =3D dma_dbg_4;
>> 		else
>> 			chk_dbg =3D dma_dbg_5;
>> 		dcu_chain_state =3D (chk_dbg >> (5 * i)) & 0x1f;
>> 		if (dcu_chain_state =3D=3D 0x6) {
>> 			dcu_wait_frdone =3D true;
>> 			chk_dcu |=3D BIT(i);
>> 		}
>> 	}
>> 	if ((dcu_complete_state =3D=3D 0x1) && dcu_wait_frdone) {
>> 		for_each_set_bit(i, &chk_dcu, ATH9K_NUM_TX_QUEUES) {
>> 			if (ath9k_hw_verify_hang(ah, i))
>> 				return true;
>> 		}
>> 	}
>> exit:
>> 	return false;
>> }
>>=20
>> The for loop seems to need to look like the following:
>>=20
>> 	for (i =3D 0; i < ATH9K_NUM_TX_QUEUES; i++) {
>>               int off=3Di;
>> 		if (i < 6) {
>> 			chk_dbg =3D dma_dbg_4;
>> 		} else {
>> 			chk_dbg =3D dma_dbg_5;
>>                       off =3D i - 6;
>>               }
>> 		dcu_chain_state =3D (chk_dbg >> (5 * off)) & 0x1f;
>> 		if (dcu_chain_state =3D=3D 0x6) {
>> 			dcu_wait_frdone =3D true;
>> 			chk_dcu |=3D BIT(i);
>> 		}
>> 	}
>>=20
>=20
> Did you test this? Please send a proper patch :)
>=20
> -Toke

