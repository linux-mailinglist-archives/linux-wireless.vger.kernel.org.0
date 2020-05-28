Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EADE1E5914
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2020 09:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgE1Hll (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 03:41:41 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:13310 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbgE1Hll (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 03:41:41 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590651701; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=b1pPUBurNqZFnj7IGoabaXECzB48DBuG72B0+aHryII=;
 b=KSEuFfd587lH5AhGD7B+nrRSxMlbm3ScUIugkFve8UNYzHstauxx/zrmqJV2PMOAU8/Grzve
 9rKBELcR3hm9WvPOgn+UPW5BZkyYWxAhwjowPj/+NJH2EEGwg8zvyEmZwAyfhdfUaj3Ng97I
 1JCyFb+BwVX0ti5ZwhTLg+YF4qE=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5ecf6b334776d1da6da41f2d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 28 May 2020 07:41:39
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 57B19C433C9; Thu, 28 May 2020 07:41:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: pradeepc)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1D907C43395;
        Thu, 28 May 2020 07:41:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 28 May 2020 00:41:39 -0700
From:   Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v3 1/9] cfg80211: Add helper function to identify 6GHz PSC
 channel
In-Reply-To: <643b2e386881de3051f35eaf64d36344cb2df9f6.camel@sipsolutions.net>
References: <20200526224217.11119-1-pradeepc@codeaurora.org>
 <20200526224217.11119-2-pradeepc@codeaurora.org>
 (sfid-20200527_004804_951011_BE3F0562)
 <643b2e386881de3051f35eaf64d36344cb2df9f6.camel@sipsolutions.net>
Message-ID: <4f4b4023d38d75bfa7f95db1aa1a3056@codeaurora.org>
X-Sender: pradeepc@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> static inline bool cfg80211_channel_is_psc(struct ieee80211_channel 
> *chan)
> {
> 	if (chan->band != NL80211_BAND_6GHZ)
> 		return false;
> 
> 	return ieee80211_frequency_to_channel(chan->center_freq) % 16 == 5;
> }
> 
> johannes
sure Johannes. Above looks neat.

Thanks
pradeep
