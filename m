Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106356CD870
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Mar 2023 13:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjC2L2O (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Mar 2023 07:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjC2L2N (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Mar 2023 07:28:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76918211C
        for <linux-wireless@vger.kernel.org>; Wed, 29 Mar 2023 04:28:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 14D13B822A3
        for <linux-wireless@vger.kernel.org>; Wed, 29 Mar 2023 11:28:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEB3AC433D2;
        Wed, 29 Mar 2023 11:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680089289;
        bh=yrgPi3SJJBPVXBW7rWGkJfGUbY/VNnd5tktymM1MeZs=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=kWV9uS5hgUnTsZBPqINA4C+59hTtUcZRpn0DFJgiG//eEXgAnxRcu1tYbbjrnq/ER
         WApLpesh5QGHKFdpPVaVtp02uzmqnOpFwlirh6VoFYPXKweDiycX/fR+NlxhW3w+GQ
         7NLkOQr9cokjxLEeli+f0VcpllV9PCH1xDEAXc8D+jhjuEh5QmUIC3AtylvWA4jEaD
         re/zaJWtzLT76Koo1EJK+SpTRfNaSiHXN0fN3E+EXp1rW+83wQyWeGXt1e18wlftm1
         g+OF6zZd2yuRJvrO+hvifToTxyTXYPMslC4LbGawRRSnAegpbn2ryegRsBg2kp5W3h
         61GioFF0AXl4A==
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
Date:   Wed, 29 Mar 2023 14:28:05 +0300
In-Reply-To: <CA+HBbNEaNTkUv_UPgQievxaLya0XC6=AVj0=GWiH+qB9=vRZHg@mail.gmail.com>
        (Robert Marko's message of "Wed, 29 Mar 2023 12:42:34 +0200")
Message-ID: <87bkkbdcfu.fsf@kernel.org>
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

Robert Marko <robert.marko@sartura.hr> writes:

> On Wed, Mar 29, 2023 at 11:45=E2=80=AFAM Kalle Valo <kvalo@kernel.org> wr=
ote:
>
>> >> @@ -5369,6 +5491,10 @@ static int ath11k_mac_copy_he_cap(struct ath11=
k *ar,
>> >>
>> >>                 he_cap_elem->mac_cap_info[1] &=3D
>> >>                         IEEE80211_HE_MAC_CAP1_TF_MAC_PAD_DUR_MASK;
>> >> +               he_cap_elem->phy_cap_info[0] &=3D
>> >> +                       ~IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160M=
HZ_IN_5G;
>> >> +               he_cap_elem->phy_cap_info[0] &=3D
>> >> +                       ~IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PL=
US80_MHZ_IN_5G;
>> >
>> > This is causing a regression for us in OpenWrt at least on IPQ8074 but
>> > probably on all ath11k-supported HW. Cause 80+80 and 160MHz support
>> > bits are being cleared here so 160MHz is not being advertised after
>> > this patch.
>>
>> Oh man, not good. Robert, should we revert this patchset entirely? Of
>> course it would be better if Muna can submit quickly a fix, but I'm not
>> going to wait for long.
>
> I would prefer to see it get fixed, cause just removing the flag
> removal gets 160MHz working, but I am not sure about other flags as
> well.

Ok, let's try to get it fixed then. Muna, can you comment and send a fix
ASAP?

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
