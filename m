Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5C778FBDB
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Sep 2023 12:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245005AbjIAKnO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Sep 2023 06:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbjIAKnO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Sep 2023 06:43:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CC8E7E
        for <linux-wireless@vger.kernel.org>; Fri,  1 Sep 2023 03:43:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 94B6DB821F9
        for <linux-wireless@vger.kernel.org>; Fri,  1 Sep 2023 10:43:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 332E8C433C7;
        Fri,  1 Sep 2023 10:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693564988;
        bh=+z3yDpx7JBNFW174rxLjovbGXB3dtVqdAi37BUz+QUM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Cj5/QlXqDG35v+bZjQmaBpR0dPF92/ugvZ84OgbRK/M1O4juzi1cMYzMx8A1EFjC9
         Wb7u9emkKNaD3FE/mO45sw+VQ2iAQfq9vYShKLej5hN6cisQktqhNmlepwxLlTvMIU
         lrO1Stsk3bA/QFXLcDDJXyLEmyB8pqM330lxernUj+IYM6OLs2ioRCcIzcxiyRQVmm
         MpjXsKJZU1f7OzyROhHGrGI9SdkFGB7xOEIBdj+3IOS7V3hc8uLaIgB9QfbUdYldjX
         +c46wI9NBsQaUlsRrng0mgKQ1GsyZSXcNB6laAxlTZrtYDLuVzQ9dDOahM29yMF05k
         WFNMVYWJ2My1g==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 7AC8AD82404; Fri,  1 Sep 2023 12:43:05 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To:     Hancheng Yang <hyang@freebox.fr>, kvalo@codeaurora.org,
        Johannes Berg <johannes@sipsolutions.net>,
        Jouni Malinen <j@w1.fi>
Cc:     linux-wireless@vger.kernel.org, Hancheng Yang <hyang@freebox.fr>
Subject: Re: [PATCH] ath9k: reset survey of current channel after a scan
 started
In-Reply-To: <87wmxtby1g.fsf@toke.dk>
References: <20230817092900.361270-1-hyang@freebox.fr> <87wmxtby1g.fsf@toke.dk>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 01 Sep 2023 12:43:05 +0200
Message-ID: <87v8cutbra.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Toke H=C3=B8iland-J=C3=B8rgensen <toke@kernel.org> writes:

> Hancheng Yang <hyang@freebox.fr> writes:
>
>> In the `ath_set_channel()` function, we only reset surveys that are not =
from the current channel.
>> This leads to the accumulation of survey data for the current channel in=
definitely.
>> Log of hostapd:
>> [2023-08-17 11:21:51] ACS: Survey analysis for channel 1 (2412 MHz)
>> [2023-08-17 11:21:51] ACS: 1: min_nf=3D-90 interference_factor=3D0.56983=
3 nf=3D-89 time=3D36194 busy=3D20908 rx=3D16200
>> [2023-08-17 11:21:51] ACS: 2: min_nf=3D-90 interference_factor=3D0.57201=
8 nf=3D-89 time=3D36539 busy=3D21183 rx=3D16425
>> [2023-08-17 11:21:51] ACS: 3: min_nf=3D-90 interference_factor=3D0.57431=
1 nf=3D-90 time=3D36885 busy=3D21464 rx=3D16659
>> [2023-08-17 11:21:51] ACS: 4: min_nf=3D-90 interference_factor=3D0.5773 =
nf=3D-89 time=3D37231 busy=3D21772 rx=3D16924
>> [2023-08-17 11:21:51] ACS: 5: min_nf=3D-90 interference_factor=3D0.58010=
8 nf=3D-89 time=3D37578 busy=3D22076 rx=3D17189
>>
>>
>> This may not be the most optimal approach, as we want the ACS to rely on=
 the most recent survey.
>> So, reset the survey data for the current channel at the start of each s=
can.
>>
>> Or there's better approach?
>
> Johannes, Jouni, any thoughts? :)

Ping?

>>
>> Signed-off-by: Hancheng Yang <hyang@freebox.fr>
>> ---
>>  drivers/net/wireless/ath/ath9k/main.c | 15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>>
>> diff --git a/drivers/net/wireless/ath/ath9k/main.c b/drivers/net/wireles=
s/ath/ath9k/main.c
>> index fa5a87f021e2..3e4a711c96bb 100644
>> --- a/drivers/net/wireless/ath/ath9k/main.c
>> +++ b/drivers/net/wireless/ath/ath9k/main.c
>> @@ -2382,7 +2382,22 @@ static void ath9k_sw_scan_start(struct ieee80211_=
hw *hw,
>>  {
>>  	struct ath_softc *sc =3D hw->priv;
>>  	struct ath_common *common =3D ath9k_hw_common(sc->sc_ah);
>> +	struct cfg80211_chan_def *chandef =3D &sc->cur_chan->chandef;
>> +	struct ieee80211_channel *chan =3D chandef->chan;
>> +	int pos =3D chan->hw_value;
>>  	set_bit(ATH_OP_SCANNING, &common->op_flags);
>> +
>> +	/* Reset current survey */
>> +	if (!sc->cur_chan->offchannel) {
>> +		if (sc->cur_survey !=3D &sc->survey[pos]) {
>> +			if (sc->cur_survey)
>> +				sc->cur_survey->filled &=3D ~SURVEY_INFO_IN_USE;
>> +			sc->cur_survey =3D &sc->survey[pos];
>> +		}
>> +
>> +		memset(sc->cur_survey, 0, sizeof(struct survey_info));
>> +		sc->cur_survey->filled |=3D SURVEY_INFO_IN_USE;
>> +	}
>>  }
>>=20=20
>>  static void ath9k_sw_scan_complete(struct ieee80211_hw *hw,
>> --=20
>> 2.34.1
