Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D01A14E2CDC
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Mar 2022 16:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348083AbiCUPwo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Mar 2022 11:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348012AbiCUPwj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Mar 2022 11:52:39 -0400
Received: from mail.toke.dk (mail.toke.dk [IPv6:2a0c:4d80:42:2001::664])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712B315B073
        for <linux-wireless@vger.kernel.org>; Mon, 21 Mar 2022 08:51:13 -0700 (PDT)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1647877872; bh=2N+uqh2BdbSvBOogz1KroPOcFF6SuXXq3xDHTsNJ0l8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=YHadGArhPi/iBuFxh7n6KRKLh+U8M5LVTOjK7Eh/EMWF669+HUSbNEqsIQU9AI+VP
         cCnV7zn+uU4e2Ga/JJ4eFvu4YTNEtbHS8J0D7gkH+fIYxS0eTn2OuAd4cXedMRnQOx
         TKf5UxqeMcbV3zHMYnjHLyyRy8VwOpSuYkCBgY1bkqFtoOF7iH7TDZwzX/ZQXKUgf1
         IbVSGQUh+dEwMpLbyH4q2nSyoht88Kze/H8Ya1G8gxWxT1HtiBKnrvebV9F3lHZiC1
         87Lt72S39ykhzoLvHiWeARNd+nIHiW7IBsgE5Doh4OSC8UVrLxhbG8MpdZxnNhHjIK
         LJK8GhAq1y2cA==
To:     Wenli Looi <wlooi@ucalgary.ca>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        ath9k-devel@qca.qualcomm.com, Wenli Looi <wlooi@ucalgary.ca>
Subject: Re: [PATCH 4/6] ath9k: fix ar9003_get_eepmisc
In-Reply-To: <20220320233010.123106-5-wlooi@ucalgary.ca>
References: <20220320233010.123106-1-wlooi@ucalgary.ca>
 <20220320233010.123106-5-wlooi@ucalgary.ca>
Date:   Mon, 21 Mar 2022 16:51:11 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87a6dj9uds.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wenli Looi <wlooi@ucalgary.ca> writes:

> The current implementation is reading the wrong eeprom type.
>
> Fixes: d8ec2e ("ath9k: Add an eeprom_ops callback for retrieving the eepmisc value")
> Signed-off-by: Wenli Looi <wlooi@ucalgary.ca>
> ---
>  drivers/net/wireless/ath/ath9k/ar9003_eeprom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c b/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
> index 669b49b56..a109a44a1 100644
> --- a/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
> +++ b/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
> @@ -5615,7 +5615,7 @@ unsigned int ar9003_get_paprd_scale_factor(struct ath_hw *ah,
>  
>  static u8 ar9003_get_eepmisc(struct ath_hw *ah)
>  {
> -	return ah->eeprom.map4k.baseEepHeader.eepMisc;
> +	return ah->eeprom.ar9300_eep.baseEepHeader.opCapFlags.eepMisc;
>  }

Looks like this is only ever used to check for the
AR5416_EEPMISC_BIG_ENDIAN flag - so is that never used by AR9300, or how
was this ever working given that it's a completely different offset?

-Toke
