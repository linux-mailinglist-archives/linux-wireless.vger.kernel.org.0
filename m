Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6D5E1AD752
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2020 09:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbgDQHXu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Apr 2020 03:23:50 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:18791 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728419AbgDQHXu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Apr 2020 03:23:50 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587108229; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=rA7iAexd4wP+UbyJuh7JwfZi1usnt0xjffk5Mpiz7Yk=;
 b=m5JF8Y/OeXSdTqKExy/+PYshrvHcxX4sMK/xocfSePeVHD6v/Rg01HtmrYqoqhEYLGOoPTcg
 BIoe36iyxUdaerpUfHUyhX88J47z/qJxqSpTObJv6HbnwPRI5CHaviU2yrs2Yp9OhuA7FXLL
 m34wMHfJNN9natdK5nevi0Dtveg=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e995981.7f330a838688-smtp-out-n05;
 Fri, 17 Apr 2020 07:23:45 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 11A0BC433CB; Fri, 17 Apr 2020 07:23:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A55EFC433F2;
        Fri, 17 Apr 2020 07:23:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 17 Apr 2020 15:23:44 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] ath10k: improve power save performance for sdio
In-Reply-To: <87y2quponn.fsf@kamboji.qca.qualcomm.com>
References: <0101016ed9241282-73dd8b35-e2e5-4f37-9b50-cf2fb6524dfc-000000@us-west-2.amazonses.com>
 <877dyfr4fb.fsf@kamboji.qca.qualcomm.com>
 <b9f680d57a6fbc9ac59dc5fc281d0af3@codeaurora.org>
 <87y2quponn.fsf@kamboji.qca.qualcomm.com>
Message-ID: <ffdecd6a9db5b96d6c791fc04108b163@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-04-17 15:17, Kalle Valo wrote:
> Wen Gong <wgong@codeaurora.org> writes:
> 
>> On 2020-04-16 20:38, Kalle Valo wrote:
>>> Wen Gong <wgong@codeaurora.org> writes:
>>> 
>> 
>>> 
>>>> +static inline int ath10k_hif_set_mbox_sleep(struct ath10k *ar,
>>>> bool enable_sleep)
>>>> +{
>>>> +	if (ar->hif.ops->set_mbox_sleep)
>>>> +		return ar->hif.ops->set_mbox_sleep(ar, enable_sleep);
>>>> +	return 0;
>>>> +}
>>> 
>>> I don't think we need to add another hif op for this. I sent v2 which
>>> uses existing op.
>> 
>> Yes, I see it. but I see it removed ath10k_hif_set_mbox_sleep in
>> ath10k_core_start, expected it will not effect the patch's power save.
> 
> So the idea is that the same functionality is still there as with your
> version, the callpath is just a bit different:
> 
> ath10k_core_start()
>     -> ath10k_hif_start_post()
>         -> ath10k_sdio_hif_start_post()
>             -> ath10k_sdio_set_mbox_sleep()
> 
> But please do double check that I didn't miss anything.
yes, I see this now, so it not miss in v2.
@@ -1749,6 +1819,8 @@  static int ath10k_sdio_hif_start_post(struct 
ath10k *ar)
  		ar_sdio->swap_mbox = false;
  	}

+	ath10k_sdio_hif_set_mbox_sleep(ar, true);
+
  	return 0;
  }
