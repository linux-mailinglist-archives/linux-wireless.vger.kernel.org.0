Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 976BA6CD6B9
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Mar 2023 11:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbjC2Jpm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Mar 2023 05:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjC2Jpl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Mar 2023 05:45:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F10DE
        for <linux-wireless@vger.kernel.org>; Wed, 29 Mar 2023 02:45:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC4CE61C31
        for <linux-wireless@vger.kernel.org>; Wed, 29 Mar 2023 09:45:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E439AC4339C;
        Wed, 29 Mar 2023 09:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680083139;
        bh=bBrUy329B14lmah78gYYaC8CptR+CjuPDZjmY2/LIRU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=dpviCasEkMvgojCweh3NCCwz+4NpoaKsU8stph2VKUpn6dTUD3b58N7bF74WAdALA
         RaZ1nVPasGsEcWz34HJ3WoKoELoNr6B3Bn8+WI4tkvqy9QACxbl3PVmgcsYUF1Wcdw
         Xx/rW1hbwr1Rh3W8YU06wePW5mtF9yqczHzHDo7ZMCBepjvhhA8mBdx/dxw5Lfq5Fi
         wOA3sKBiER213Yjh+9Im+vOOs0VwkmggYdEtlHFOg9RM7zqxBoYXIZCpjUUG+j/Dhn
         VGdqq3enJMSCAZDGFcRDrrIFwWl+t8MiKfOR5lSPZRtM4jFHZVeye8jIa01sLq3+ju
         6ncS3f5sg7ohQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     Muna Sinada <quic_msinada@quicinc.com>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org,
        Anilkumar Kolli <quic_akolli@quicinc.com>
Subject: Re: [PATCH v2 2/4] wifi: ath11k: push MU-MIMO params from hostapd to hardware
References: <1666128501-12364-1-git-send-email-quic_msinada@quicinc.com>
        <1666128501-12364-3-git-send-email-quic_msinada@quicinc.com>
        <CA+HBbNHw-0+Ty_-masxGKwT6ju_EBxT3n5B0Ygcn3XzQi_CzWg@mail.gmail.com>
Date:   Wed, 29 Mar 2023 12:45:31 +0300
In-Reply-To: <CA+HBbNHw-0+Ty_-masxGKwT6ju_EBxT3n5B0Ygcn3XzQi_CzWg@mail.gmail.com>
        (Robert Marko's message of "Tue, 28 Mar 2023 13:11:22 +0200")
Message-ID: <87fs9ndh6s.fsf@kernel.org>
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

> On Tue, Oct 18, 2022 at 11:28=E2=80=AFPM Muna Sinada <quic_msinada@quicin=
c.com> wrote:
>
>>
>> In the previous behaviour only HE IE in management frames are changed
>> regarding MU-MIMO configurations and not in hardware. Adding push of
>> MU-MIMO configurations to the hardware as well.
>>
>> This patch is dependant on mac80211 patchset:
>> https://patchwork.kernel.org/project/linux-wireless/list/?series=3D68332=
2&state=3D%2A&archive=3Dboth
>>
>> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-00356-QCAHKSWPL_SILICONZ-1
>>
>> Co-developed-by: Anilkumar Kolli <quic_akolli@quicinc.com>
>> Signed-off-by: Anilkumar Kolli <quic_akolli@quicinc.com>
>> Signed-off-by: Muna Sinada <quic_msinada@quicinc.com>

[...]

>> @@ -5369,6 +5491,10 @@ static int ath11k_mac_copy_he_cap(struct ath11k *=
ar,
>>
>>                 he_cap_elem->mac_cap_info[1] &=3D
>>                         IEEE80211_HE_MAC_CAP1_TF_MAC_PAD_DUR_MASK;
>> +               he_cap_elem->phy_cap_info[0] &=3D
>> +                       ~IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_=
IN_5G;
>> +               he_cap_elem->phy_cap_info[0] &=3D
>> +                       ~IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS8=
0_MHZ_IN_5G;
>
> This is causing a regression for us in OpenWrt at least on IPQ8074 but
> probably on all ath11k-supported HW. Cause 80+80 and 160MHz support
> bits are being cleared here so 160MHz is not being advertised after
> this patch.

Oh man, not good. Robert, should we revert this patchset entirely? Of
course it would be better if Muna can submit quickly a fix, but I'm not
going to wait for long.

The patchset is in wireless-next at the moment and the commits from the
patchset are:

a96f10422e74 wifi: ath11k: modify accessor macros to match index size
38dfe775d0ab wifi: ath11k: push MU-MIMO params from hostapd to hardware
8077c1bbbc28 wifi: ath11k: move HE MCS mapper to a separate function
ebf82988f844 wifi: ath11k: generate rx and tx mcs maps for supported HE mcs

> I fail to understand why are 80+80 and 160 MHz feature flags being cleare=
d?

Me neither. I missed that in my review.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
