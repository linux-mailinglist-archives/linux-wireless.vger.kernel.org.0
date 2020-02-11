Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 204A8158F7A
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2020 14:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbgBKNKK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Feb 2020 08:10:10 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:44385 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727567AbgBKNKK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Feb 2020 08:10:10 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1581426610; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=r1jHmcnWOSlLIduWOd0dkPuv1x2mjdN9YR/CChlg6VM=; b=hqtZiRpI8q5EPITAgFXAQUS1CSHZXcIc/xenPfmvpn0/16/j2IPNlA/IMj4nvuBiHLzMQo4B
 KTNo3ZqimQgy9n1d6WDZCugkIl+g02a+gyGdW53vbL25ilK2SG6hvlDmrBUMoUeXY5c6MceB
 uXm3U4zdnYaDXIxzwlBGtNJODs8=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e42a7b1.7fd83ffd6e68-smtp-out-n03;
 Tue, 11 Feb 2020 13:10:09 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 82E45C4479C; Tue, 11 Feb 2020 13:10:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DC258C43383;
        Tue, 11 Feb 2020 13:10:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DC258C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     John Crispin <john@phrozen.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Subject: Re: [RESEND V2 3/4] ath11k: switch to using ieee80211_tx_status_ext()
References: <20200204151135.25302-1-john@phrozen.org>
        <20200204151135.25302-3-john@phrozen.org>
Date:   Tue, 11 Feb 2020 15:10:04 +0200
In-Reply-To: <20200204151135.25302-3-john@phrozen.org> (John Crispin's message
        of "Tue, 4 Feb 2020 16:11:34 +0100")
Message-ID: <87h7zxxob7.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

John Crispin <john@phrozen.org> writes:

> This allows us to pass HE rates down into the stack.
>
> Signed-off-by: John Crispin <john@phrozen.org>
> ---
>  drivers/net/wireless/ath/ath11k/dp_tx.c | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c b/drivers/net/wireless/ath/ath11k/dp_tx.c
> index 7b532bf9acd8..66a6cfd54ad9 100644
> --- a/drivers/net/wireless/ath/ath11k/dp_tx.c
> +++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
> @@ -357,9 +357,12 @@ static void ath11k_dp_tx_complete_msdu(struct ath11k *ar,
>  				       struct sk_buff *msdu,
>  				       struct hal_tx_status *ts)
>  {
> +	struct ieee80211_tx_status status = { 0 };

This adds a sparse warning:

drivers/net/wireless/ath/ath11k/dp_tx.c:350:47: warning: Using plain integer as NULL pointer

Seems like a false warning, no? But not sure how to shut up the warning,
using '{ NULL }' would do that but just feels wrong. Any opinions?

There was also a trivial checkpatch warning:

drivers/net/wireless/ath/ath11k/dp_tx.c:419: Please don't use multiple blank lines

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
