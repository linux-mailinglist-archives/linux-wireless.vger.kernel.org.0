Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2516D76B0
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Apr 2023 10:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237436AbjDEIT7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Apr 2023 04:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237288AbjDEIT5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Apr 2023 04:19:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB401BEA
        for <linux-wireless@vger.kernel.org>; Wed,  5 Apr 2023 01:19:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD7FC62478
        for <linux-wireless@vger.kernel.org>; Wed,  5 Apr 2023 08:19:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E22BBC433D2;
        Wed,  5 Apr 2023 08:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680682792;
        bh=h+azRsNrQNvSZoKtD4Pui+A0ykChj4PqevmHG3PaPRE=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=NCPSlq0Eqb+yBe0xLWN+z75QKKMsUuFqxNA0Eck9RlIlBkyrvQQQyiu7q4hTXwpES
         xxJebdlWrmIEr03OD3WNNQeLzq6uF1/iRWYiIXVdIbvU5YjbAI3reUAboZEFha/AzV
         LjWDaWZCXBnyGZZ9tSsLOuUYe699QZYkAelLVxAHXRDFg+FHIqBP7/s0RnY+j2sKx7
         fb87wJk/FAov51bmWxh0+uswFGm3PTtSR9CCaRE6Vh6rPA7i8sAju9J57eZtTACVbJ
         BClSLHHB+p3YBwcmnTDF1KOP1KpvOFm/cNTZzxfhIJeVjUIIMnPqGGgqG1Kv0Hdftr
         rhuNX+o+9fPUg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     Muna Sinada <quic_msinada@quicinc.com>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org,
        Anilkumar Kolli <quic_akolli@quicinc.com>
Subject: Re: [PATCH v2 2/4] wifi: ath11k: push MU-MIMO params from hostapd to hardware
References: <1666128501-12364-1-git-send-email-quic_msinada@quicinc.com>
        <1666128501-12364-3-git-send-email-quic_msinada@quicinc.com>
        <CA+HBbNHw-0+Ty_-masxGKwT6ju_EBxT3n5B0Ygcn3XzQi_CzWg@mail.gmail.com>
        <87fs9ndh6s.fsf@kernel.org>
        <CA+HBbNEaNTkUv_UPgQievxaLya0XC6=AVj0=GWiH+qB9=vRZHg@mail.gmail.com>
        <87bkkbdcfu.fsf@kernel.org>
Date:   Wed, 05 Apr 2023 11:19:46 +0300
In-Reply-To: <87bkkbdcfu.fsf@kernel.org> (Kalle Valo's message of "Wed, 29 Mar
        2023 14:28:05 +0300")
Message-ID: <87pm8iaggt.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@kernel.org> writes:

> Robert Marko <robert.marko@sartura.hr> writes:
>
>> On Wed, Mar 29, 2023 at 11:45=E2=80=AFAM Kalle Valo <kvalo@kernel.org> w=
rote:
>>
>>> >> @@ -5369,6 +5491,10 @@ static int ath11k_mac_copy_he_cap(struct ath1=
1k *ar,
>>> >>
>>> >>                 he_cap_elem->mac_cap_info[1] &=3D
>>> >>                         IEEE80211_HE_MAC_CAP1_TF_MAC_PAD_DUR_MASK;
>>> >> +               he_cap_elem->phy_cap_info[0] &=3D
>>> >> +                       ~IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160=
MHZ_IN_5G;
>>> >> +               he_cap_elem->phy_cap_info[0] &=3D
>>> >> +                       ~IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80P=
LUS80_MHZ_IN_5G;
>>> >
>>> > This is causing a regression for us in OpenWrt at least on IPQ8074 but
>>> > probably on all ath11k-supported HW. Cause 80+80 and 160MHz support
>>> > bits are being cleared here so 160MHz is not being advertised after
>>> > this patch.
>>>
>>> Oh man, not good. Robert, should we revert this patchset entirely? Of
>>> course it would be better if Muna can submit quickly a fix, but I'm not
>>> going to wait for long.
>>
>> I would prefer to see it get fixed, cause just removing the flag
>> removal gets 160MHz working, but I am not sure about other flags as
>> well.
>
> Ok, let's try to get it fixed then. Muna, can you comment and send a fix
> ASAP?

No reply from Muna. I'll try the new bugbot to open a bug for this regressi=
on:

bugbot on

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
