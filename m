Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27641C3425
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2019 14:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbfJAMVg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Oct 2019 08:21:36 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33172 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbfJAMVc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Oct 2019 08:21:32 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7E95361214; Tue,  1 Oct 2019 12:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569932491;
        bh=O+H0n1S6gFicgpHrI2JlZritofpDZiCn4tJ8rOv4qu4=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=VB6LkcDi4ClLAi4eWlFVJGM+n8sRwZFcYAfGfdMSZsMLeCTWZ+A5zRCg76aF0JKzS
         65bxW+8r3E5uITMczrS/+gD52zN2dNUwLt6TgeHNRIZj8PxzetF5j6vjd2eAhimvlQ
         v7RsxUttY2zILo+yPqcn7HuIr4eZu2v4bt5j0+OU=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CA3376034D;
        Tue,  1 Oct 2019 12:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569932491;
        bh=O+H0n1S6gFicgpHrI2JlZritofpDZiCn4tJ8rOv4qu4=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=VB6LkcDi4ClLAi4eWlFVJGM+n8sRwZFcYAfGfdMSZsMLeCTWZ+A5zRCg76aF0JKzS
         65bxW+8r3E5uITMczrS/+gD52zN2dNUwLt6TgeHNRIZj8PxzetF5j6vjd2eAhimvlQ
         v7RsxUttY2zILo+yPqcn7HuIr4eZu2v4bt5j0+OU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CA3376034D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Erik Stromdahl <erik.stromdahl@gmail.com>
Cc:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH 6/6] ath10k: sdio: replace skb_trim with explicit set of skb->len
References: <20190409190851.4557-1-erik.stromdahl@gmail.com>
        <20190409190851.4557-7-erik.stromdahl@gmail.com>
        <87zhovcqhl.fsf@kamboji.qca.qualcomm.com>
        <deca77d1-f171-e0cd-b571-89c2f8bafc87@gmail.com>
Date:   Tue, 01 Oct 2019 15:21:26 +0300
In-Reply-To: <deca77d1-f171-e0cd-b571-89c2f8bafc87@gmail.com> (Erik
        Stromdahl's message of "Mon, 15 Apr 2019 17:11:27 +0200")
Message-ID: <875zl864hl.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

+ johannes

Erik Stromdahl <erik.stromdahl@gmail.com> writes:

> On 4/12/19 3:17 PM, Kalle Valo wrote:
>> Erik Stromdahl <erik.stromdahl@gmail.com> writes:
>>
>>> This patch fixes a bug with padding of the skb data buffer.
>>> Since skb_trim can only be used to reduce the skb len, it is useless when
>>> we pad (increase the length of) the skb. Instead we must set skb->len
>>> directly.
>>>
>>> Signed-off-by: Erik Stromdahl <erik.stromdahl@gmail.com>
>>> ---
>>>   drivers/net/wireless/ath/ath10k/sdio.c | 7 ++++++-
>>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
>>> index 3eb241cb8a25..989e3f563f3d 100644
>>> --- a/drivers/net/wireless/ath/ath10k/sdio.c
>>> +++ b/drivers/net/wireless/ath/ath10k/sdio.c
>>> @@ -1496,7 +1496,12 @@ static int ath10k_sdio_hif_tx_sg(struct ath10k *ar, u8 pipe_id,
>>>   		skb = items[i].transfer_context;
>>>   		padded_len = ath10k_sdio_calc_txrx_padded_len(ar_sdio,
>>>   							      skb->len);
>>> -		skb_trim(skb, padded_len);
>>> +		/* FIXME: unsure if just extending the skb len is the right
>>> +		 * thing to do since we might read outside the skb->data
>>> +		 * buffer. But we really don't want to realloc the skb just to
>>> +		 * pad the length.
>>> +		 */
>>> +		skb->len = padded_len;
>>
>> Good catch! But I don't think you can modify skb->len directly like
>> that. There is skb_pad() but that doesn't change skb->len, so that most
>> likely needs more changes. So maybe skb_put() is the safest here?
>>
> I have tried a few different solutions for this, but none seems to be
> bullet proof.
>
> skb_pad() raises a BUG() if there is not enough space in skb->data.
>
> The best candidate so far has been skb_put_padto(). It pads and reallocates
> the skb if needed.
>
> The problem is that it also cause a panic if there is more than one reference
> to the skb (skb_shared() returns true).
>
> Some of the management frames via nl80211 have a refcount of 2.
> In this case it is not possible to free and allocate the skb since there are
> other users/references.
>
> I think I will have to make some kind of solution where I copy the content of
> the skb to an internal buffer instead.

Sorry for the late reply, I see that you also tried a different (and
more complex) approach here:

https://patchwork.kernel.org/patch/10906011/

In my opinion the cleanest approach would be to add extra_tx_tailroom to
struct ieee80211_hw, similarly like we have extra_tx_headroom, and that
way ath10k could easily add the padding with skb_pad(). Or what do you
think?

Of course I don't know what Johannes thinks as it would need several
changes in mac80211, but at least struct net_device has needed_tailroom
as well. And I would imagine that there is some other hardware which
needs to do padding like this, or are ath10k SDIO devices really the
first mac80211 drivers needing tailroom?

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
