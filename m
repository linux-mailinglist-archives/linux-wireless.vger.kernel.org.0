Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F594353826
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Apr 2021 14:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbhDDM4d (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 4 Apr 2021 08:56:33 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:16550 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbhDDM4c (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 4 Apr 2021 08:56:32 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1617540988; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=jEMRUAMh/TKgCIXDHS1CDEDrjjZuYl9CfCWWxLqsKns=;
 b=oS1SMgll6UzxQ3lwFuhmi7ZaIW8SXd/kZ4sEf7rJ3mqIY3kSARVH0KClK7YuAH4+0AGLbsfr
 cWatNGgKRBEjW1U2qVglf/n8koJJoMsl6vSCVClYFWdQZABlh6tSPNw8Jt2pqcG6Fe6h7ha6
 XDlvT9vUe4qR37Y3tE6YPwcGwzQ=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 6069b77be0e9c9a6b6167890 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 04 Apr 2021 12:56:27
 GMT
Sender: pradeepc=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 39314C433ED; Sun,  4 Apr 2021 12:56:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: pradeepc)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 97C80C433CA;
        Sun,  4 Apr 2021 12:56:26 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 04 Apr 2021 05:56:26 -0700
From:   Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
To:     Karthikeyan periyasamy <periyasa@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        John Crispin <john@phrozen.org>,
        pradeepc=codeaurora.org@codeaurora.org
Subject: Re: [PATCH V8 1/3] ath11k: switch to using ieee80211_tx_status_ext()
In-Reply-To: <183cd636909cec0b8d20da8515c146ab@codeaurora.org>
References: <1616105397-1482-1-git-send-email-pradeepc@codeaurora.org>
 <1616105397-1482-2-git-send-email-pradeepc@codeaurora.org>
 <183cd636909cec0b8d20da8515c146ab@codeaurora.org>
Message-ID: <c369ab155fe070ffc9c129662a3e71c8@codeaurora.org>
X-Sender: pradeepc@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-03-18 22:31, Karthikeyan periyasamy wrote:
>> -	ieee80211_tx_status(ar->hw, msdu);
>> +	spin_lock_bh(&ab->base_lock);
>> +	peer = ath11k_peer_find_by_id(ab, ts->peer_id);
>> +	if (peer) {
>> +		arsta = (struct ath11k_sta *)peer->sta->drv_priv;
>> +		status.sta = peer->sta;
>> +		status.skb = msdu;
>> +		status.info = info;
>> +		status.rate = &arsta->last_txrate;
> 
> Assigning arsta holded last_txrate pointer to status.rate create race
> condition problem b/w sta delete and ieee80211_tx_status_ext, no ?
> Hw we ensure that arsta pointer is valid until
> ieee80211_tx_status_ext() processing?
> 
> Instead why don't we have local struct rate_info and assign like below
> code snippet
> 
>         struct rate_info rate;
> ...
>         rate = arsta->last_txrate;
>         status.rate = &rate;
> 
> Thanks,
> Karthikeyan P
Thanks Karthikeyan, I have addressed this in V9..
