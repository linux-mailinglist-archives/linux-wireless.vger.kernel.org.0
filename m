Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A84E3A0854
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2019 19:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbfH1RZh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Aug 2019 13:25:37 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:39960 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbfH1RZh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Aug 2019 13:25:37 -0400
Received: from marcel-macbook.fritz.box (p4FEFC580.dip0.t-ipconnect.de [79.239.197.128])
        by mail.holtmann.org (Postfix) with ESMTPSA id 088D7CEC82;
        Wed, 28 Aug 2019 19:34:21 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v2] cfg80211: add local BSS receive time to survey
 information
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190828102042.58016-1-nbd@nbd.name>
Date:   Wed, 28 Aug 2019 19:25:34 +0200
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Content-Transfer-Encoding: 8BIT
Message-Id: <9189B2C1-6E5B-4457-9354-A010F946EE33@holtmann.org>
References: <20190828102042.58016-1-nbd@nbd.name>
To:     Felix Fietkau <nbd@nbd.name>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Felix,

> This is useful for checking how much airtime is being used up by other
> transmissions on the channel, e.g. by calculating (time_rx - time_bss_rx)
> or (time_busy - time_bss_rx - time_tx)
> 
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
> include/net/cfg80211.h       | 4 ++++
> include/uapi/linux/nl80211.h | 3 +++
> net/wireless/nl80211.c       | 4 ++++
> 3 files changed, 11 insertions(+)
> 
> diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
> index 35ec1f0a2bf9..bf97c4f805d3 100644
> --- a/include/net/cfg80211.h
> +++ b/include/net/cfg80211.h
> @@ -694,6 +694,7 @@ ieee80211_chandef_max_power(struct cfg80211_chan_def *chandef)
>  * @SURVEY_INFO_TIME_RX: receive time was filled in
>  * @SURVEY_INFO_TIME_TX: transmit time was filled in
>  * @SURVEY_INFO_TIME_SCAN: scan time was filled in
> + * @SURVEY_INFO_TIME_BSS_RX: local BSS receive time was filled in
>  *
>  * Used by the driver to indicate which info in &struct survey_info
>  * it has filled in during the get_survey().
> @@ -707,6 +708,7 @@ enum survey_info_flags {
> 	SURVEY_INFO_TIME_RX		= BIT(5),
> 	SURVEY_INFO_TIME_TX		= BIT(6),
> 	SURVEY_INFO_TIME_SCAN		= BIT(7),
> +	SURVEY_INFO_TIME_BSS_RX		= BIT(8),
> };
> 
> /**
> @@ -723,6 +725,7 @@ enum survey_info_flags {
>  * @time_rx: amount of time the radio spent receiving data
>  * @time_tx: amount of time the radio spent transmitting data
>  * @time_scan: amount of time the radio spent for scanning
> + * @time_bss_rx: amount of time the radio spent receiving data on a local BSS
>  *
>  * Used by dump_survey() to report back per-channel survey information.
>  *
> @@ -737,6 +740,7 @@ struct survey_info {
> 	u64 time_rx;
> 	u64 time_tx;
> 	u64 time_scan;
> +	u64 time_bss_rx;
> 	u32 filled;
> 	s8 noise;
> };
> diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
> index 822851d369ab..e74cf4daad02 100644
> --- a/include/uapi/linux/nl80211.h
> +++ b/include/uapi/linux/nl80211.h
> @@ -3843,6 +3843,8 @@ enum nl80211_user_reg_hint_type {
>  * @NL80211_SURVEY_INFO_TIME_SCAN: time the radio spent for scan
>  *	(on this channel or globally)
>  * @NL80211_SURVEY_INFO_PAD: attribute used for padding for 64-bit alignment
> + * @NL80211_SURVEY_INFO_TIME_BSS_RX: amount of time the radio spent
> + *	receiving local BSS data
>  * @NL80211_SURVEY_INFO_MAX: highest survey info attribute number
>  *	currently defined
>  * @__NL80211_SURVEY_INFO_AFTER_LAST: internal use
> @@ -3859,6 +3861,7 @@ enum nl80211_survey_info {
> 	NL80211_SURVEY_INFO_TIME_TX,
> 	NL80211_SURVEY_INFO_TIME_SCAN,
> 	NL80211_SURVEY_INFO_PAD,
> +	NL80211_SURVEY_INFO_TIME_BSS_RX,

wouldn’t this go before the PAD attribute?

Regards

Marcel

