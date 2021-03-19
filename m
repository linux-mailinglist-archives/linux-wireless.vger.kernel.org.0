Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4A63414E5
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Mar 2021 06:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233881AbhCSFcE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Mar 2021 01:32:04 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:28503 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233869AbhCSFbr (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Mar 2021 01:31:47 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1616131907; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=4Fw/9ix5c3ONb9JlAoxaOb2rJAyzpG4j9/cNWCYvGSs=;
 b=M5cH0DMz37cb5GjKK51m4Pkq8ZeODyfBpn6yxnRmentEN8OYQ8Uzt+MsyeTHCAVw/Z/bCfFa
 pCEoQXUqRr8rXHoOUMtFpnvKl2ucQp04Y3Gn4cpxsn8vadd9x4s1jWaiuQzKbYo18V9eURPS
 zkC3zeMUvVwdNI7CYItXFryLFR0=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 605437421de5dd7b99e1e9b6 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 19 Mar 2021 05:31:46
 GMT
Sender: periyasa=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1EFBAC43462; Fri, 19 Mar 2021 05:31:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: periyasa)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2B99BC433CA;
        Fri, 19 Mar 2021 05:31:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 19 Mar 2021 11:01:45 +0530
From:   Karthikeyan periyasamy <periyasa@codeaurora.org>
To:     Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Miles Hu <milehu@codeaurora.org>,
        John Crispin <john@phrozen.org>,
        pradeepc=codeaurora.org@codeaurora.org
Subject: Re: [PATCH V8 1/3] ath11k: switch to using ieee80211_tx_status_ext()
In-Reply-To: <1616105397-1482-2-git-send-email-pradeepc@codeaurora.org>
References: <1616105397-1482-1-git-send-email-pradeepc@codeaurora.org>
 <1616105397-1482-2-git-send-email-pradeepc@codeaurora.org>
Message-ID: <183cd636909cec0b8d20da8515c146ab@codeaurora.org>
X-Sender: periyasa@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> -	ieee80211_tx_status(ar->hw, msdu);
> +	spin_lock_bh(&ab->base_lock);
> +	peer = ath11k_peer_find_by_id(ab, ts->peer_id);
> +	if (peer) {
> +		arsta = (struct ath11k_sta *)peer->sta->drv_priv;
> +		status.sta = peer->sta;
> +		status.skb = msdu;
> +		status.info = info;
> +		status.rate = &arsta->last_txrate;

Assigning arsta holded last_txrate pointer to status.rate create race 
condition problem b/w sta delete and ieee80211_tx_status_ext, no ?
Hw we ensure that arsta pointer is valid until ieee80211_tx_status_ext() 
processing?

Instead why don't we have local struct rate_info and assign like below 
code snippet

         struct rate_info rate;
...
         rate = arsta->last_txrate;
         status.rate = &rate;

Thanks,
Karthikeyan P
