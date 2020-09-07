Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 261C225FE80
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Sep 2020 18:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730470AbgIGQSG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Sep 2020 12:18:06 -0400
Received: from a27-185.smtp-out.us-west-2.amazonses.com ([54.240.27.185]:58404
        "EHLO a27-185.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730394AbgIGQR5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Sep 2020 12:17:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599495477;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type;
        bh=fHmkMsSqCrU8zIQPY0mHmkrXR5chyuKH+CWAaoIweHQ=;
        b=FQEYfq0gGffYY1Ec74e0ofLEgX0B1+/OhdhLfZ1pOWI0arQqmparOJjzooQFj+MP
        Cx0yb3XNuMgMg4Tt0xIUAPAilzrxx/2Mdfjdp4tAUtvFO364eKXLA6NffVvaKSzySHd
        b7sjvbGhQEWZ3HoEDadH9imPa0w4WW2gjTCgq5Bc=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599495477;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type:Feedback-ID;
        bh=fHmkMsSqCrU8zIQPY0mHmkrXR5chyuKH+CWAaoIweHQ=;
        b=WOkohfLwII1vMzCj+g8XljGkk2sP0NCv1ZRQAwswfrzcrH9JyvEY9iJYDKojWqCl
        gBSDW7nF6JbnxfGsyRHhqkswqrJwnTCTr8qKPNVIDiFrxZ1b2xtSI4E+3BM6qX6yYVQ
        JAyykVCvPAv1YGPx3qmqCtQwtii7Ie1/+FxkmPNo=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 999ABC38689
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     "Rakesh Pillai" <pillair@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        ath10k@lists.infradead.org
Subject: Re: [PATCH] ath10k: Use bdf calibration variant for snoc targets
References: <1593193990-30366-1-git-send-email-pillair@codeaurora.org>
        <87y2ls4lbf.fsf@codeaurora.org>
        <0101017459fdd62b-791355e4-ea88-4142-96a7-06849bcd7b09-000000@us-west-2.amazonses.com>
Date:   Mon, 7 Sep 2020 16:17:57 +0000
In-Reply-To: <0101017459fdd62b-791355e4-ea88-4142-96a7-06849bcd7b09-000000@us-west-2.amazonses.com>
        (Rakesh Pillai's message of "Fri, 4 Sep 2020 16:40:41 +0000")
Message-ID: <01010174695c181a-6f8e9efc-bbc9-45ff-8d54-62db5e0163f6-000000@us-west-2.amazonses.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SES-Outgoing: 2020.09.07-54.240.27.185
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

"Rakesh Pillai" <pillair@codeaurora.org> writes:

>> > --- a/drivers/net/wireless/ath/ath10k/qmi.c
>> > +++ b/drivers/net/wireless/ath/ath10k/qmi.c
>> > @@ -576,6 +576,8 @@ static int ath10k_qmi_cap_send_sync_msg(struct
>> ath10k_qmi *qmi)
>> >  	if (resp->chip_info_valid) {
>> >  		qmi->chip_info.chip_id = resp->chip_info.chip_id;
>> >  		qmi->chip_info.chip_family = resp->chip_info.chip_family;
>> > +	} else {
>> > +		qmi->chip_info.chip_id = 0xFF;
>> >  	}
>> 
>> So you hard code chip_id to 0xff if it's not valid. Is it 100%
>> guaranteed that there never will be a chip id with 0xff?
>
> 0x0 and 0xff are invalid chip id and are are not used.
> If the chip_id read fails, we fallback to the default board data.
> 0xff is used to go to the default board data (Also this is in alignment with
> the current implementation of board_id)
>
> Does that make sense ?

I'm a bit hesitant, over the years I have seen cases so many cases where
"foo is not used anywhere" and later that foo is actually used
somewhere. 0xff means that there's only 254 different values, but I
guess there are not that many chip ids? So a chip id is very different
from a board id, right?

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
