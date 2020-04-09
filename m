Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D44A1A358A
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Apr 2020 16:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbgDIONw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Apr 2020 10:13:52 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:44095 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726552AbgDIONv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Apr 2020 10:13:51 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586441631; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=oA2QVf0tNPtlNkAxOEoOHVKhyFVXRF/JetkMbIVl7Js=; b=Mp3E+p1WxbPYII7X8uCx1nZ9AalQ7gAVe9n9+wAX8+xdTcYvdJQwfVLK3HEnKmqPpsdfT/UH
 Zo2MC4tNscqpNowi2PlQO16L+kzQ87OrDKeAql/9oSTGnjNIdplSzZwHISHlMoiCqA8So6WH
 iycAm/e0ZKeTur8YypJIgXG8Yag=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e8f2d98.7fdf86bc0570-smtp-out-n01;
 Thu, 09 Apr 2020 14:13:44 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5F8ECC433D2; Thu,  9 Apr 2020 14:13:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D8EFDC433CB;
        Thu,  9 Apr 2020 14:13:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D8EFDC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Yu Wang <yyuwang@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
Subject: Re: [PATCH v2 2/2] ath10k: correct legacy rate in tx stats
References: <1574147982-3956-1-git-send-email-yyuwang@codeaurora.org>
        <0101016e82882548-361b3da4-fd9b-4ba9-95b6-a5d782d4a1c8-000000@us-west-2.amazonses.com>
        <87h7yd4y0a.fsf@kamboji.qca.qualcomm.com>
Date:   Thu, 09 Apr 2020 17:13:39 +0300
In-Reply-To: <87h7yd4y0a.fsf@kamboji.qca.qualcomm.com> (Kalle Valo's message
        of "Tue, 24 Mar 2020 16:40:21 +0200")
Message-ID: <87y2r4u4q4.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

For some reason these comments didn't go to patchwork so resending them
again:

Kalle Valo <kvalo@codeaurora.org> writes:

> Yu Wang <yyuwang@codeaurora.org> writes:
>
>> +	for (i = 0; i < sband->n_bitrates; i++) {
>> +		bitrates = &sband->bitrates[i];
>> +		if (ath10k_mac_bitrate_is_cck(bitrates->bitrate) != cck)
>> +			continue;
>> +
>> +		if (bitrates->hw_value == hw_rate ||
>> +		    (bitrates->flags & IEEE80211_RATE_SHORT_PREAMBLE &&
>> +		     bitrates->hw_value_short == hw_rate)) {
>> +			bitrate = bitrates->bitrate;
>> +
>> +			/* The bitrate will be recovered in
>> +			 * ath10k_update_per_peer_tx_stats().
>> +			 */
>> +			if (bitrate == 55)
>> +				bitrate = 60;
>> +
>> +			bitrate = bitrate / 10;
>
> Here you use magic value 60 but in ath10k_update_per_peer_tx_stats() you
> use magic value 50:
>
>> +		/* from 1Mbps to 100Kbps */
>> +		rate = rate * 10;
>> +		if (rate == 50)
>> +			rate = 55;
>
> Am I missing something or how is this supposed to work?

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
