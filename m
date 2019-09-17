Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2E1B4843
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Sep 2019 09:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730555AbfIQH2u (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Sep 2019 03:28:50 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38892 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfIQH2u (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Sep 2019 03:28:50 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D3612613A3; Tue, 17 Sep 2019 07:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568705328;
        bh=oLwQ6A67jzNqU2gJ2LI77+6Nr39hcA3nWg8B/UciTsY=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Pz6RHKp/DtCNWFthGzkYWVlaY0Qe0PCRdfcdEF2O7+uuHXzGhdYR6FMtFdEQEmsdq
         JpSOoIWTZso6QHYPXLutCeB4w7S+Jp8dS2g4Ae0Z9c4uAN+5dx8o4W0Mh9ryiSqt0a
         Ke+LT5N1OdUjjOYV+a6Z9F4JDFO+h2j7t1PZbqz8=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 663726013C;
        Tue, 17 Sep 2019 07:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568705328;
        bh=oLwQ6A67jzNqU2gJ2LI77+6Nr39hcA3nWg8B/UciTsY=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Pz6RHKp/DtCNWFthGzkYWVlaY0Qe0PCRdfcdEF2O7+uuHXzGhdYR6FMtFdEQEmsdq
         JpSOoIWTZso6QHYPXLutCeB4w7S+Jp8dS2g4Ae0Z9c4uAN+5dx8o4W0Mh9ryiSqt0a
         Ke+LT5N1OdUjjOYV+a6Z9F4JDFO+h2j7t1PZbqz8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 663726013C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Sven Eckelmann <sven@narfation.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Sven Eckelmann <seckelmann@datto.com>,
        Govind Singh <govinds@codeaurora.org>,
        Wen Gong <wgong@codeaurora.org>
Subject: Re: [PATCH v2] ath10k: fix max antenna gain unit
References: <20190611172131.6064-1-sven@narfation.org>
Date:   Tue, 17 Sep 2019 10:28:43 +0300
In-Reply-To: <20190611172131.6064-1-sven@narfation.org> (Sven Eckelmann's
        message of "Tue, 11 Jun 2019 19:21:31 +0200")
Message-ID: <87muf3bcus.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

+ Govind, Wen

Sven Eckelmann <sven@narfation.org> writes:

> From: Sven Eckelmann <seckelmann@datto.com>
>
> Most of the txpower for the ath10k firmware is stored as twicepower (0.5 dB
> steps). This isn't the case for max_antenna_gain - which is still expected
> by the firmware as dB.
>
> The firmware is converting it from dB to the internal (twicepower)
> representation when it calculates the limits of a channel. This can be seen
> in tpc_stats when configuring "12" as max_antenna_gain. Instead of the
> expected 12 (6 dB), the tpc_stats shows 24 (12 dB).
>
> Tested on QCA9888 and IPQ4019 with firmware 10.4-3.5.3-00057.
>
> Fixes: 02256930d9b8 ("ath10k: use proper tx power unit")
> Signed-off-by: Sven Eckelmann <seckelmann@datto.com>

[...]

> --- a/drivers/net/wireless/ath/ath10k/mac.c
> +++ b/drivers/net/wireless/ath/ath10k/mac.c
> @@ -1008,7 +1008,7 @@ static int ath10k_monitor_vdev_start(struct ath10k *ar, int vdev_id)
>  	arg.channel.min_power = 0;
>  	arg.channel.max_power = channel->max_power * 2;
>  	arg.channel.max_reg_power = channel->max_reg_power * 2;
> -	arg.channel.max_antenna_gain = channel->max_antenna_gain * 2;
> +	arg.channel.max_antenna_gain = channel->max_antenna_gain;
>  
>  	reinit_completion(&ar->vdev_setup_done);
>  
> @@ -1450,7 +1450,7 @@ static int ath10k_vdev_start_restart(struct ath10k_vif *arvif,
>  	arg.channel.min_power = 0;
>  	arg.channel.max_power = chandef->chan->max_power * 2;
>  	arg.channel.max_reg_power = chandef->chan->max_reg_power * 2;
> -	arg.channel.max_antenna_gain = chandef->chan->max_antenna_gain * 2;
> +	arg.channel.max_antenna_gain = chandef->chan->max_antenna_gain;
>  
>  	if (arvif->vdev_type == WMI_VDEV_TYPE_AP) {
>  		arg.ssid = arvif->u.ap.ssid;
> @@ -3105,7 +3105,7 @@ static int ath10k_update_channel_list(struct ath10k *ar)
>  			ch->min_power = 0;
>  			ch->max_power = channel->max_power * 2;
>  			ch->max_reg_power = channel->max_reg_power * 2;
> -			ch->max_antenna_gain = channel->max_antenna_gain * 2;
> +			ch->max_antenna_gain = channel->max_antenna_gain;
>  			ch->reg_class_id = 0; /* FIXME */

What about firmwares using WMI TLV interface, for example QCA6174 or
WCN3990? Does this break max antenna gain on those devices? Govind, Wen?

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
