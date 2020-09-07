Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 024452600ED
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Sep 2020 18:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731222AbgIGQ4T (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Sep 2020 12:56:19 -0400
Received: from a27-188.smtp-out.us-west-2.amazonses.com ([54.240.27.188]:40078
        "EHLO a27-188.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729862AbgIGQ4L (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Sep 2020 12:56:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599497771;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type;
        bh=E7t//6wwVe6yoHqHO8AWN7Zj46ePVZw+67TGmdShN74=;
        b=ADKvl7PXpRWu8VlsVX/yoid2s8Dy7P9E14N2iN23DhNiXQgAKMjy9/1cGS/afafx
        OQgxGiOH4UlczVodr1r+Xb/WCxRBmnchyJhTMXrRcS5OpH4aSVYkvwW5KOMNfq5PQ8H
        beWANGvMOrO6HZeupYFa8Cw7ZggHEfYa/Dbamcsg=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599497771;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type:Feedback-ID;
        bh=E7t//6wwVe6yoHqHO8AWN7Zj46ePVZw+67TGmdShN74=;
        b=I9C3pr4hiDDFdD8lrMapzSQBf9H6nWJlfykL5ZWMGssFM4cxW49YMgR1BMhSkrsK
        zScdkOjCo3DgGtIZaIXuCOtv4U/VS8XYD6nHQZwtvtFdZ9jTcdlHYp6Banf+w0/6XzK
        qzfGTwBH+0Sg5GQSo4TyObnYnxUFMb8Y49VF5/uo=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 12EFBC4B52A
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Karthikeyan Periyasamy <periyasa@codeaurora.org>,
        Jakub Kicinski <kuba@kernel.org>,
        kernel-janitors@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org
Subject: Re: [PATCH net-next] ath11k: fix uninitialized return in ath11k_spectral_process_data()
References: <20200619142922.GA267142@mwanda> <87a70vf923.fsf@codeaurora.org>
        <20200622171846.GE4151@kadam>
Date:   Mon, 7 Sep 2020 16:56:11 +0000
In-Reply-To: <20200622171846.GE4151@kadam> (Dan Carpenter's message of "Mon,
        22 Jun 2020 20:18:47 +0300")
Message-ID: <01010174697f1805-c885f217-9729-4089-91bd-4bd79645fec0-000000@us-west-2.amazonses.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SES-Outgoing: 2020.09.07-54.240.27.188
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dan Carpenter <dan.carpenter@oracle.com> writes:

> On Mon, Jun 22, 2020 at 05:51:16PM +0300, Kalle Valo wrote:
>> Dan Carpenter <dan.carpenter@oracle.com> writes:
>> 
>> > There is a success path where "ret" isn't initialized where we never
>> > have a ATH11K_SPECTRAL_TAG_SCAN_SEARCH and then ret isn't initialized.
>> >
>> > Fixes: 9d11b7bff950 ("ath11k: add support for spectral scan")
>> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>> > ---
>> >  drivers/net/wireless/ath/ath11k/spectral.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/net/wireless/ath/ath11k/spectral.c b/drivers/net/wireless/ath/ath11k/spectral.c
>> > index 1c5d65bb411f..bfbf905f7507 100644
>> > --- a/drivers/net/wireless/ath/ath11k/spectral.c
>> > +++ b/drivers/net/wireless/ath/ath11k/spectral.c
>> > @@ -677,7 +677,7 @@ static int ath11k_spectral_process_data(struct ath11k *ar,
>> >  	u32 data_len, i;
>> >  	u8 sign, tag;
>> >  	int tlv_len, sample_sz;
>> > -	int ret;
>> > +	int ret = 0;
>> >  	bool quit = false;
>> 
>> I try to avoid initialising ret variables so I would like find another
>> way. What about doing this (completely untested!) in the end of the
>> function:
>> 
>>         return 0;
>> 
>> err:
>> 	kfree(fft_sample);
>> unlock:
>> 	spin_unlock_bh(&ar->spectral.lock);
>> 	return ret;
>
> I normally avoid it as well...  If I were to redo this patch, I would
> probably do:
>
> 	ret = 0;
> err:
> 	kfree(fft_sample);
> unlock:
> 	spin_unlock_bh(&ar->spectral.lock);
> 	return ret;
>
> Would that be better?

Ah, my proposal was buggy. So yes, this is definitely better :) I
changed now the patch in the pending branch, please check:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=586f8e6779fa75ade112cb48606794e034e0ff1d

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
