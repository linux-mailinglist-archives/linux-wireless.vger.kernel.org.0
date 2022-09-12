Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16F15B58F8
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Sep 2022 13:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbiILLF3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Sep 2022 07:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiILLF2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Sep 2022 07:05:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB89399D5
        for <linux-wireless@vger.kernel.org>; Mon, 12 Sep 2022 04:05:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 14F8DB80C63
        for <linux-wireless@vger.kernel.org>; Mon, 12 Sep 2022 11:05:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D17F2C433D6;
        Mon, 12 Sep 2022 11:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662980724;
        bh=1jdBK1FYwxGWlVf8w771PuvsjoYlHEa5EkUVnGz8ZKQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=KyxFCSdf/UPDgRM9F+OXgmYJ6YU2lxhOiETTtCjEyZqEaEWFThZXID76//ZbFK7l5
         /WGv9ZrrlE7uHfpGj19+PxvAIiYOXwDU+fwWlqEDFFt5/Z1MBUx0XjSyuDyMiVuidG
         rGOYqqUEONmEVXN0Ol6gBBQbtJ21+FVo1aLrTEWIJDifOJzwwmLNcDJ+vTM9fjsbo1
         SB3KganF9lZtdzyuNy0GP4zNnM0TiixZUjWldmpTtIKXkE1O2a6MZdMjx/RA07xOoP
         axY0XrBKGXemWDmDUbapc0slx0eXzQzXMEDzmrlmvxSm7W6UqIZc81xigQxHwfeuAU
         Cn5RzAL3lK98w==
From:   Kalle Valo <kvalo@kernel.org>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        <ath11k@lists.infradead.org>
Subject: Re: [PATCH] wifi: mac80211: RCU-ify link STA pointers
References: <24df3a0c-a312-d9b6-5840-1eacd79d824b@quicinc.com>
        <87a67498b4.fsf@kernel.org>
        <7199bd7d-b45c-5c72-576e-363ad37cce82@quicinc.com>
Date:   Mon, 12 Sep 2022 14:05:19 +0300
In-Reply-To: <7199bd7d-b45c-5c72-576e-363ad37cce82@quicinc.com> (Wen Gong's
        message of "Mon, 12 Sep 2022 18:55:04 +0800")
Message-ID: <875yhs97kg.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> writes:

> On 9/12/2022 6:49 PM, Kalle Valo wrote:
>> Wen Gong <quic_wgong@quicinc.com> writes:
>>
>>> Hi Johannes,
>>>
>>> Currently for MLO test, the others links's rx_nss of struct
>>> ieee80211_link_sta is still value 0 in ieee80211_set_associated(),
>>> becaue they are not pass into ieee80211_sta_set_rx_nss() in
>>> mac80211 except the deflink which means the primary link.
>>> This lead driver get nss =3D 0 for other links. Will you fix it
>>> or is it design by default?
>>>
>>> Only primary link has valid rx_nss value which is not 0 by below call s=
tack.
>>> ieee80211_assoc_success()->
>>>  =C2=A0=C2=A0=C2=A0 rate_control_rate_init(sta);
>>>
>>> commit:c71420db653aba30a234d1e4cf86dde376e604fa
>>> wifi: mac80211: RCU-ify link STA pointers
>> Strange format and s-o-b missing. Was this meant as an RFC patch?
>
> This is not a patch for review, it is to ask some question about the patch
>
> "wifi: mac80211: RCU-ify link STA pointers" which is already upstream.

Then you should not add "[PATCH]" in the subject. The string "[PATCH]"
is supposed to inform that the email contains a patch which should be
applied.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
