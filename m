Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 536B76E5D08
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Apr 2023 11:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjDRJJm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Apr 2023 05:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjDRJJh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Apr 2023 05:09:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2721659DC
        for <linux-wireless@vger.kernel.org>; Tue, 18 Apr 2023 02:09:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA6E861F83
        for <linux-wireless@vger.kernel.org>; Tue, 18 Apr 2023 09:09:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 094AEC433EF;
        Tue, 18 Apr 2023 09:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681808960;
        bh=w28Lfinz6EaBHtWGJs8L/2PATDDR+sdiC202nVpFOfg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=qQPvGbHeC71jGB3U97vu7pBC+Pclh+kdzWcimAVG8KppgCM5l7YGtG3suphYAW4z1
         PBxYVarOg3/lTCNH3SgCq436edzGUOItrbAtfxmFkGcXEshlOGXUbnvUiqFKBgOjGN
         eAGNv87/Em9+yuNqoU2jbOPfIpBH0mlwbcrLNGyfJlvRuUwLZCptAvT41iDrmAGq8t
         QNzUUZGlTUeXrBwUS53fV3mPGzwjkc7KCBmGVZYS4ZTcYjcBOk9QhEghxq2kn6BiW9
         INe3Q8p7+RyMjjm6oKBBgxDImfOuEZi9NPFMsAjlEvZjlvXl1cUGbVb4oBZnQGiBiX
         H06xmmaLahkug==
From:   Kalle Valo <kvalo@kernel.org>
To:     "Muna Sinada \(QUIC\)" <quic_msinada@quicinc.com>
Cc:     Robert Marko <robert.marko@sartura.hr>,
        "ath11k\@lists.infradead.org" <ath11k@lists.infradead.org>,
        "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Anilkumar Kolli \(QUIC\)" <quic_akolli@quicinc.com>
Subject: Re: [PATCH v2 2/4] wifi: ath11k: push MU-MIMO params from hostapd to hardware
References: <1666128501-12364-1-git-send-email-quic_msinada@quicinc.com>
        <1666128501-12364-3-git-send-email-quic_msinada@quicinc.com>
        <CA+HBbNHw-0+Ty_-masxGKwT6ju_EBxT3n5B0Ygcn3XzQi_CzWg@mail.gmail.com>
        <87fs9ndh6s.fsf@kernel.org>
        <CA+HBbNEaNTkUv_UPgQievxaLya0XC6=AVj0=GWiH+qB9=vRZHg@mail.gmail.com>
        <87bkkbdcfu.fsf@kernel.org> <87pm8iaggt.fsf@kernel.org>
        <BY5PR02MB6164BAC2A418B3C5462C2C348F9B9@BY5PR02MB6164.namprd02.prod.outlook.com>
        <87mt3b6nz6.fsf@kernel.org>
Date:   Tue, 18 Apr 2023 12:09:15 +0300
In-Reply-To: <87mt3b6nz6.fsf@kernel.org> (Kalle Valo's message of "Fri, 14 Apr
        2023 08:18:21 +0300")
Message-ID: <874jpdwo90.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
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

Kalle Valo <kvalo@kernel.org> writes:

> "Muna Sinada (QUIC)" <quic_msinada@quicinc.com> writes:
>
>> Muna Sinada <quic_msinada@quicinc.com> writes:
>>> Kalle Valo <kvalo@kernel.org> writes:
>>>> Robert Marko <robert.marko@sartura.hr> writes:
>>>>
>>>>> On Wed, Mar 29, 2023 at 11:45=E2=80=AFAM Kalle Valo <kvalo@kernel.org=
> wrote:
>>>>>
>>>>>> >> @@ -5369,6 +5491,10 @@ static int ath11k_mac_copy_he_cap(struct=20
>>>>>> >> ath11k *ar,
>>>>>> >>
>>>>>> >>                 he_cap_elem->mac_cap_info[1] &=3D
>>>>>> >>=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20
>>>>>> >> IEEE80211_HE_MAC_CAP1_TF_MAC_PAD_DUR_MASK;
>>>>>> >> +               he_cap_elem->phy_cap_info[0] &=3D
>>>>>> >> + ~IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G;
>>>>>> >> +               he_cap_elem->phy_cap_info[0] &=3D
>>>>>> >> +=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20
>>>>>> >> + ~IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G;
>>>>>> >
>>>>>> > This is causing a regression for us in OpenWrt at least on IPQ8074=
=20
>>>>>> > but probably on all ath11k-supported HW. Cause 80+80 and 160MHz=20
>>>>>> > support bits are being cleared here so 160MHz is not being=20
>>>>>> > advertised after this patch.
>>>>>>
>>>>>> Oh man, not good. Robert, should we revert this patchset entirely?=20
>>>>>> Of course it would be better if Muna can submit quickly a fix, but=20
>>>>>> I'm not going to wait for long.
>>>>>
>>>>> I would prefer to see it get fixed, cause just removing the flag=20
>>>>> removal gets 160MHz working, but I am not sure about other flags as=20
>>>>> well.
>>>>
>>>> Ok, let's try to get it fixed then. Muna, can you comment and send a=20
>>>> fix ASAP?
>>>
>>>No reply from Muna. I'll try the new bugbot to open a bug for this regre=
ssion:
>>>
>>>bugbot on
>>
>> I have created fix, tested it and pushed internally for review.
>>
>> @Kalle, how do I go about continuing the conversation on Bugzilla?
>
> Better to continue the discussion on the list. I only created the bug on
> Bugzilla so that I don't forget this as I didn't hear anything from you.

Muna now submitted a fix:

https://patchwork.kernel.org/project/linux-wireless/patch/1681762947-13882-=
1-git-send-email-quic_msinada@quicinc.com/

Robert, can you please check it? And if it works a Tested-by would be
nice.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
