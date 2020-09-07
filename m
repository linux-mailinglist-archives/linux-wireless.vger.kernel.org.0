Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB34925F907
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Sep 2020 13:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728724AbgIGLGO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Sep 2020 07:06:14 -0400
Received: from a27-187.smtp-out.us-west-2.amazonses.com ([54.240.27.187]:41236
        "EHLO a27-187.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728833AbgIGK7u (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Sep 2020 06:59:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599476389;
        h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID;
        bh=CZJI5A+Q4qqEWMI7I/Rka4KTe1dm5BFjfmSKsUF2lyE=;
        b=FJQ/9V9IeYXRQaQzShiC/TrHBRB3Fkgk9HfU940AKgrlXDCXQZothFT+ZCidb3Wq
        1ePm33NFcWRzeo8OB3Z8XbJBI2eixm6hDaItBeegYKYN5CAQfuQW2HX31jop+xreH86
        84C9ZRrkxiep9sP7elYixhAxY2Bk/wqQc2EpDxyk=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599476389;
        h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID:Feedback-ID;
        bh=CZJI5A+Q4qqEWMI7I/Rka4KTe1dm5BFjfmSKsUF2lyE=;
        b=nFMLXU5VAr3kTUZgjrrtEWbS4eftABx1H6VBWBuWg672CUj/jd29yZ+mMmyqo5QI
        gGkO00uayHM0oTnXQrBUHjxBl4LSQjeR2ES5uNwmg7GFrDpSF1dFH6vEiujKMRBcIig
        W0yP/8NusLi+497Hv30E0lng467mUHqGuir6RL6Q=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 7 Sep 2020 10:59:49 +0000
From:   akolli@codeaurora.org
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, devicetree@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH v6 2/3] ath11k: copy ce service configs to hw_params
In-Reply-To: <87363t52nj.fsf@codeaurora.org>
References: <1598287470-1871-1-git-send-email-akolli@codeaurora.org>
 <1598287470-1871-3-git-send-email-akolli@codeaurora.org>
 <87363t52nj.fsf@codeaurora.org>
Message-ID: <010101746838d5d2-5deaf2a7-2c2e-440d-b488-c9150e681566-000000@us-west-2.amazonses.com>
X-Sender: akolli@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
X-SES-Outgoing: 2020.09.07-54.240.27.187
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-09-07 15:28, Kalle Valo wrote:
> Anilkumar Kolli <akolli@codeaurora.org> writes:
> 
>> No functional changes, added target ce service configurations to 
>> hw_params.
>> 
>> Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
> 
> [...]
> 
>> --- a/drivers/net/wireless/ath/ath11k/core.c
>> +++ b/drivers/net/wireless/ath/ath11k/core.c
>> @@ -812,12 +812,6 @@ int ath11k_core_init(struct ath11k_base *ab)
>>  		return ret;
>>  	}
>> 
>> -	ret = ath11k_init_hw_params(ab);
>> -	if (ret) {
>> -		ath11k_err(ab, "failed to get hw params %d\n", ret);
>> -		return ret;
>> -	}
> 
> This is very suspicious.

ath11k_core_pre_init() is calling ath11k_init_hw_params(), again calling 
same function in ath11k_core_init()
is not needed. Will send this as a new patch ?

Thanks
Anil
