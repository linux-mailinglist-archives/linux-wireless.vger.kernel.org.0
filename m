Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF4015AC77
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2020 16:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbgBLPzW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Feb 2020 10:55:22 -0500
Received: from mail27.static.mailgun.info ([104.130.122.27]:56449 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727458AbgBLPzV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Feb 2020 10:55:21 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1581522921; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=X9M208ccwHtf3Jj9nbloF1G5J3OEple00U4Sl30TQ+w=; b=nHjCWRMovNA4/4n92/lBidHmJgYmYPzBqtKcyIYX/9+AqnIQjB/QVnZpT+5I4KpqUijQlojy
 JPFn+Bgeh2OXj0liXOfEKmrf+rc1lQP8QrK64UrPryRsLu/gGCwejKUgpUJoV58wUxJOL6Ij
 6/hSvLjaZYFouYF6hH+OSq5Ucgs=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e441fdf.7f9e655160a0-smtp-out-n03;
 Wed, 12 Feb 2020 15:55:11 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CFA8DC4479F; Wed, 12 Feb 2020 15:55:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from x230.qca.qualcomm.com (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0C63DC43383;
        Wed, 12 Feb 2020 15:55:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0C63DC43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Sven Eckelmann <sven@narfation.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        John Crispin <john@phrozen.org>
Subject: Re: [RESEND V2 3/4] ath11k: switch to using ieee80211_tx_status_ext()
References: <20200204151135.25302-1-john@phrozen.org>
        <20200204151135.25302-3-john@phrozen.org>
        <87h7zxxob7.fsf@kamboji.qca.qualcomm.com>
        <4744821.iAptAJfnkX@bentobox>
Date:   Wed, 12 Feb 2020 17:55:07 +0200
In-Reply-To: <4744821.iAptAJfnkX@bentobox> (Sven Eckelmann's message of "Tue,
        11 Feb 2020 15:38:22 +0100")
Message-ID: <87wo8r7qck.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sven Eckelmann <sven@narfation.org> writes:

> On Tuesday, 11 February 2020 14:10:04 CET Kalle Valo wrote:
> [...]
>> > diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c b/drivers/net/wireless/ath/ath11k/dp_tx.c
>> > index 7b532bf9acd8..66a6cfd54ad9 100644
>> > --- a/drivers/net/wireless/ath/ath11k/dp_tx.c
>> > +++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
>> > @@ -357,9 +357,12 @@ static void ath11k_dp_tx_complete_msdu(struct ath11k *ar,
>> >  				       struct sk_buff *msdu,
>> >  				       struct hal_tx_status *ts)
>> >  {
>> > +	struct ieee80211_tx_status status = { 0 };
>> 
>> This adds a sparse warning:
>> 
>> drivers/net/wireless/ath/ath11k/dp_tx.c:350:47: warning: Using plain
>> integer as NULL pointer
>> 
>> Seems like a false warning, no? But not sure how to shut up the warning,
>> using '{ NULL }' would do that but just feels wrong. Any opinions?
>
> Why is this a false warning? The structure is following:
>
>     struct ieee80211_tx_status {
>     	struct ieee80211_sta *sta;
>     	struct ieee80211_tx_info *info;
>     	struct sk_buff *skb;
>     	struct rate_info *rate;
>     };
>
> And this is a pre-C99 initializer. The equal C99-Initializer would be
>
>     struct ieee80211_tx_status status = {
>     	.sta = NULL,
> 	};
>
> So it is initializing status.sta with 0. But status.sta is a pointer
> and we should use NULL for pointers instead of plain 0. If you want
> to initialize the object on stack to zero but not initialize each 
> member then just use {}.

Ah, of course. Thanks for pointing this out.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
