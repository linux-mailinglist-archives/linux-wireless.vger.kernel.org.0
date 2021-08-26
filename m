Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 855403F85C2
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Aug 2021 12:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241276AbhHZKnx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Aug 2021 06:43:53 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:64924 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234296AbhHZKnw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Aug 2021 06:43:52 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1629974585; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=jxQj+Qq58uCngE8BIFIYp5sPKXbtHgYgxSLMFmISMug=;
 b=tewpEDtP4WHsRkP2mxePrCAf1SEkkAnonsOcfLKXSIjA+1eli8Sl7+ahBlsIdML0XMB0VwZJ
 ezGlm5y2Uj4Llks0MUWA0fuyjXl9YA2b8kibp97LdZfFJmq5GqxYWmjpK6w0++HIkjfsHbfz
 8CrqMnYuGsjiKO6r7t/Rz8mRxLA=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 61277038b52e91333cc86e4d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 26 Aug 2021 10:43:04
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 72C57C4360D; Thu, 26 Aug 2021 10:43:04 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BE528C4338F;
        Thu, 26 Aug 2021 10:43:02 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 26 Aug 2021 18:43:02 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2 5/8] cfg80211: save power spectral density(psd) of
 regulatory rule
In-Reply-To: <101b523a6fe06fea3e1c9642a1bf5e85a9d0e680.camel@sipsolutions.net>
References: <20210820122041.12157-1-wgong@codeaurora.org>
 <20210820122041.12157-6-wgong@codeaurora.org>
 <101b523a6fe06fea3e1c9642a1bf5e85a9d0e680.camel@sipsolutions.net>
Message-ID: <4eca272868dae4f7a923656a12b03024@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-08-26 16:25, Johannes Berg wrote:
> I was going to apply this and patch 4 squashed, saying:
> 
> 
>     cfg80211: regulatory: handle 6 GHz power spectral density (PSD)
> 
>     6 GHz regulatory domains introduce power spectral density (PSD).
>     Allow wiphy-specific regulatory rules to specify these values.
> 
> but ...
>> 
>> +		if (chan->flags & IEEE80211_CHAN_PSD)
>> +			chan->psd = min_t(s8, rrule1->psd, rrule1->psd);
>> +
> 
> This is obviously wrong?
Yes it should change like this:

	if ((rrule1->flags & NL80211_RRF_PSD) && (rrule1->flags & 
NL80211_RRF_PSD))
		chan->psd = min_t(s8, rrule1->psd, rrule1->psd);
	else
		chan->flags &= ~NL80211_RRF_PSD;

> 
> johannes
