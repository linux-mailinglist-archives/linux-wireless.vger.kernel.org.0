Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3678340F3A
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Mar 2021 21:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233126AbhCRUao (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Mar 2021 16:30:44 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:26413 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233224AbhCRUaS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Mar 2021 16:30:18 -0400
X-Greylist: delayed 304 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Mar 2021 16:30:18 EDT
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1616099418; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=jnf5OevRfRzndK6VJ9m/LFXR55ww48JvW9oCoFKzSGM=;
 b=sS/8ZqOAtt2fV6rv7y4rmoc93ReevswaB07uZ+qNqYI8eQv2uAUMGA2fo8wRxY887HCyVYxZ
 kTem3mdWXSc1WxBjJMvFluG3FtIl04D7wb8hnEB/+e0V8SQpX2h7QqGpbisNYYM1fW4K3J3R
 IztQSdRaGiGdGLGVz23fNAYGufc=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 6053b70de2200c0a0d0a8b3b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 18 Mar 2021 20:24:45
 GMT
Sender: pradeepc=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5F1F0C433CA; Thu, 18 Mar 2021 20:24:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: pradeepc)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B7227C433C6;
        Thu, 18 Mar 2021 20:24:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 18 Mar 2021 13:24:44 -0700
From:   Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
To:     Karthikeyan periyasamy <periyasa@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Miles Hu <milehu@codeaurora.org>,
        John Crispin <john@phrozen.org>,
        pradeepc=codeaurora.org@codeaurora.org
Subject: Re: [PATCH v7 1/3] ath11k: switch to using ieee80211_tx_status_ext()
In-Reply-To: <65a8f70609a1758611c97205abd205f2@codeaurora.org>
References: <20210305230337.23047-1-pradeepc@codeaurora.org>
 <20210305230337.23047-2-pradeepc@codeaurora.org>
 <65a8f70609a1758611c97205abd205f2@codeaurora.org>
Message-ID: <dde25ece7fcbc6a0f268c98aa461d792@codeaurora.org>
X-Sender: pradeepc@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

>> +	spin_lock_bh(&ab->base_lock);
>> +	peer = ath11k_peer_find_by_id(ab, ts->peer_id);
>> +	if (peer) {
>> +		arsta = (struct ath11k_sta *)peer->sta->drv_priv;
>> +		status.sta = peer->sta;
>> +		status.skb = msdu;
>> +		status.info = info;
>> +		status.rate = &arsta->last_txrate;
>> +	}
>> +	rcu_read_unlock();
>> +	if (peer)
>> +		ieee80211_tx_status_ext(ar->hw, &status);
>> +	else
>> +		dev_kfree_skb_any(msdu);
>> +	spin_unlock_bh(&ab->base_lock);
> 
> Why ieee80211_tx_status_ext() kept under spin_lock?
> 
> Thanks,
> Karthikeyan P
Thanks Karthikeyan for the review..Yes, spin lock could be avoided for
ieee80211_tx_status_ext(). I will address this in next revision.

Thanks
pradeep
