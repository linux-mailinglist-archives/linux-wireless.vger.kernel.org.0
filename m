Return-Path: <linux-wireless+bounces-712-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDFAC80F532
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Dec 2023 19:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 608FC281E00
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Dec 2023 18:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766DB7E767;
	Tue, 12 Dec 2023 18:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iRr+WNCY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562C87E766
	for <linux-wireless@vger.kernel.org>; Tue, 12 Dec 2023 18:04:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA91AC433C8;
	Tue, 12 Dec 2023 18:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702404254;
	bh=Qhnij1X9k/lZtXrCPrd9zjK1pYJ+zHsCzhKpojt6ZKw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=iRr+WNCYq+sp1WLyFFBn4dJwGV6uERu2tnxd3KwEBDqWkwIYh+TJMHOeBKTLw0CzQ
	 SZl5p3OLr5ZaTUsyRZdMwKhlU8yfXuPgPmt+hvHV72ryob2rFOJYx/y1KwgTSRENO0
	 TTKPWUTwVqFT/Nm7BxBAwh4aHhIS1pSS1b3yuAMqLwXu0CY5ADUeAjkiGrfUFvml/Y
	 XOfo2X1oFPf9r6GwXs/byTUc59LKWjkiS8G4IFUX0U2e2C4+99vvyXUmL/Zrr9YWWi
	 cinFwc35VfS9k34TGyOVTpweDfG9TW9WkJPeBgiH8b1X9ZntX/6QMfV4Ar4FtREie4
	 ojBmhQuQ+CmWw==
From: Kalle Valo <kvalo@kernel.org>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Stanislaw Gruszka <stf_xl@wp.pl>,  lvc-project@linuxtesting.org,
  linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: rt2x00: remove useless code in
 rt2x00queue_create_tx_descriptor()
References: <20231212173421.119136-1-dmantipov@yandex.ru>
Date: Tue, 12 Dec 2023 20:04:11 +0200
In-Reply-To: <20231212173421.119136-1-dmantipov@yandex.ru> (Dmitry Antipov's
	message of "Tue, 12 Dec 2023 20:34:18 +0300")
Message-ID: <87il53nvqc.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dmitry Antipov <dmantipov@yandex.ru> writes:

> In 'rt2x00queue_create_tx_descriptor()', there is no need to call
> 'ieee80211_get_rts_cts_rate()' while checking for RTS/CTS frame
> since this function returns NULL or pointer to internal bitrate
> table entry, and the return value is not actually used. This way,
> 'rate' becomes block-scoped later when determining the modulation.
> Compile tested only.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
>  drivers/net/wireless/ralink/rt2x00/rt2x00queue.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00queue.c b/drivers/net/wireless/ralink/rt2x00/rt2x00queue.c
> index 98df0aef8168..7f9955deb204 100644
> --- a/drivers/net/wireless/ralink/rt2x00/rt2x00queue.c
> +++ b/drivers/net/wireless/ralink/rt2x00/rt2x00queue.c
> @@ -389,7 +389,6 @@ static void rt2x00queue_create_tx_descriptor(struct rt2x00_dev *rt2x00dev,
>  	struct ieee80211_tx_info *tx_info = IEEE80211_SKB_CB(skb);
>  	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
>  	struct ieee80211_tx_rate *txrate = &tx_info->control.rates[0];
> -	struct ieee80211_rate *rate;

I think this should be kept.

> @@ -463,7 +459,8 @@ static void rt2x00queue_create_tx_descriptor(struct rt2x00_dev *rt2x00dev,
>  	else if (txrate->flags & IEEE80211_TX_RC_MCS)
>  		txdesc->rate_mode = RATE_MODE_HT_MIX;
>  	else {
> -		rate = ieee80211_get_tx_rate(rt2x00dev->hw, tx_info);
> +		struct ieee80211_rate *rate =
> +			ieee80211_get_tx_rate(rt2x00dev->hw, tx_info);

As I find it bad practice to declarare variables within if/else blocks.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

