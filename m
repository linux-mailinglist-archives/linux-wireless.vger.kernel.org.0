Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E6377F7A5
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Aug 2023 15:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351406AbjHQN0u (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Aug 2023 09:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351422AbjHQN0U (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Aug 2023 09:26:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07DE3592
        for <linux-wireless@vger.kernel.org>; Thu, 17 Aug 2023 06:26:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BD90635AD
        for <linux-wireless@vger.kernel.org>; Thu, 17 Aug 2023 13:26:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9C91C433C9;
        Thu, 17 Aug 2023 13:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692278773;
        bh=zPL9A637QF5Wd8e59X1OAPd8um+Jt2zJrIZquyDtTww=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=LHNOHx8pYTfXP27O5G8PL5iGo77tYxZJRoPzGgzhTNqADxCYOTt098BfnYUrN/UXY
         wJayX43q50RsRilmNVD5IWLOaBjN8VlxSQCL+7Kh8y7esCFOFdlC4R1WsGo8Lzoko+
         OYdfIo+DK+PmNSpZ7c5Nj7HGoCi56UGWCqVUdv6YoPCv55bnf8sG71TH9tuDltUWbT
         mmU9g5eyvO5HFATjl0zvcpdubHTi3V/olbIXS1A9TtlBjSwJLgrd9+2vjicvWE1qnY
         2M6z5WSsFDoEzdUuXPBnXutD+SLZw2v+tpN20Lir0X0P8J9T6Yw62EGE67gFXP5bRb
         d/Zbmu8J9f9lg==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 09B4BD3C2B8; Thu, 17 Aug 2023 15:26:04 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To:     Hancheng Yang <hyang@freebox.fr>, kvalo@codeaurora.org,
        Johannes Berg <johannes@sipsolutions.net>,
        Jouni Malinen <j@w1.fi>
Cc:     linux-wireless@vger.kernel.org, Hancheng Yang <hyang@freebox.fr>
Subject: Re: [PATCH] ath9k: reset survey of current channel after a scan
 started
In-Reply-To: <20230817092900.361270-1-hyang@freebox.fr>
References: <20230817092900.361270-1-hyang@freebox.fr>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 17 Aug 2023 15:26:03 +0200
Message-ID: <87wmxtby1g.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hancheng Yang <hyang@freebox.fr> writes:

> In the `ath_set_channel()` function, we only reset surveys that are not from the current channel.
> This leads to the accumulation of survey data for the current channel indefinitely.
> Log of hostapd:
> [2023-08-17 11:21:51] ACS: Survey analysis for channel 1 (2412 MHz)
> [2023-08-17 11:21:51] ACS: 1: min_nf=-90 interference_factor=0.569833 nf=-89 time=36194 busy=20908 rx=16200
> [2023-08-17 11:21:51] ACS: 2: min_nf=-90 interference_factor=0.572018 nf=-89 time=36539 busy=21183 rx=16425
> [2023-08-17 11:21:51] ACS: 3: min_nf=-90 interference_factor=0.574311 nf=-90 time=36885 busy=21464 rx=16659
> [2023-08-17 11:21:51] ACS: 4: min_nf=-90 interference_factor=0.5773 nf=-89 time=37231 busy=21772 rx=16924
> [2023-08-17 11:21:51] ACS: 5: min_nf=-90 interference_factor=0.580108 nf=-89 time=37578 busy=22076 rx=17189
>
>
> This may not be the most optimal approach, as we want the ACS to rely on the most recent survey.
> So, reset the survey data for the current channel at the start of each scan.
>
> Or there's better approach?

Johannes, Jouni, any thoughts? :)

-Toke

>
> Signed-off-by: Hancheng Yang <hyang@freebox.fr>
> ---
>  drivers/net/wireless/ath/ath9k/main.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/drivers/net/wireless/ath/ath9k/main.c b/drivers/net/wireless/ath/ath9k/main.c
> index fa5a87f021e2..3e4a711c96bb 100644
> --- a/drivers/net/wireless/ath/ath9k/main.c
> +++ b/drivers/net/wireless/ath/ath9k/main.c
> @@ -2382,7 +2382,22 @@ static void ath9k_sw_scan_start(struct ieee80211_hw *hw,
>  {
>  	struct ath_softc *sc = hw->priv;
>  	struct ath_common *common = ath9k_hw_common(sc->sc_ah);
> +	struct cfg80211_chan_def *chandef = &sc->cur_chan->chandef;
> +	struct ieee80211_channel *chan = chandef->chan;
> +	int pos = chan->hw_value;
>  	set_bit(ATH_OP_SCANNING, &common->op_flags);
> +
> +	/* Reset current survey */
> +	if (!sc->cur_chan->offchannel) {
> +		if (sc->cur_survey != &sc->survey[pos]) {
> +			if (sc->cur_survey)
> +				sc->cur_survey->filled &= ~SURVEY_INFO_IN_USE;
> +			sc->cur_survey = &sc->survey[pos];
> +		}
> +
> +		memset(sc->cur_survey, 0, sizeof(struct survey_info));
> +		sc->cur_survey->filled |= SURVEY_INFO_IN_USE;
> +	}
>  }
>  
>  static void ath9k_sw_scan_complete(struct ieee80211_hw *hw,
> -- 
> 2.34.1
