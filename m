Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA2E938BC5E
	for <lists+linux-wireless@lfdr.de>; Fri, 21 May 2021 04:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237218AbhEUCW7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 May 2021 22:22:59 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:33710 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229534AbhEUCW6 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 May 2021 22:22:58 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1621563696; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=8DFCY8zp+CKLij4wkSAAwJexebg6Q/czG4q8BWXRJFw=;
 b=rTkKoDC4/+FQ1VTdXQEQEvqeNRh05s3BRZOzyxMzue4Rh9xXvM/1+vq81sjcp7mgOOyndLg4
 E4B9lY0PkfYfytVtSSgeWqvIiPzPGMrwNvkRAgWdSRxPH5dqBiAJ+F0ax2CtpsDXbyAaT3dY
 HT0zWEtl9dhO4cE2SEFxkPiGGGs=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 60a7192f5f788b52a5e45606 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 21 May 2021 02:21:35
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 88CAEC433F1; Fri, 21 May 2021 02:21:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D0411C433D3;
        Fri, 21 May 2021 02:21:33 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 21 May 2021 10:21:33 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Arend van Spriel <arend.vanspriel@broadcom.com>
Cc:     johannes@sipsolutions.net, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wireless: add check of field VHT Extended NSS BW Capable
 for 160/80+80 MHz setting
In-Reply-To: <fe1b7675-23ba-a86e-90db-de5803231e21@broadcom.com>
References: <20210520034021.14690-1-wgong@codeaurora.org>
 <fe1b7675-23ba-a86e-90db-de5803231e21@broadcom.com>
Message-ID: <2f580f80af0ec9b17068d80d42e666b9@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-05-21 03:21, Arend van Spriel wrote:
> On 5/20/2021 5:40 AM, Wen Gong wrote:
>> Table 9-251—Supported VHT-MCS and NSS Set subfields, it has subfield 
>> VHT Extended
>> NSS BW Capable, its definition is:
>> Indicates whether the STA is capable of interpreting the Extended NSS 
>> BW
>> Support subfield of the VHT Capabilities Information field.
>> 
>> This patch is to add check for the subfield.
> 
> Almost looks good to me, but...
> 
>> Signed-off-by: Wen Gong <wgong@codeaurora.org>
>> ---
>>   net/wireless/chan.c | 8 +++++---
>>   1 file changed, 5 insertions(+), 3 deletions(-)
>> 
>> diff --git a/net/wireless/chan.c b/net/wireless/chan.c
>> index 285b8076054b..f7f86bd75cc0 100644
>> --- a/net/wireless/chan.c
>> +++ b/net/wireless/chan.c
> 
> [...]
> 
>> @@ -1037,7 +1039,7 @@ bool cfg80211_chandef_usable(struct wiphy 
>> *wiphy,
>>   		cap = vht_cap->cap & IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_MASK;
>>   		if (cap != IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ &&
>>   		    cap != IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160_80PLUS80MHZ &&
>> -		    !(vht_cap->cap & IEEE80211_VHT_CAP_EXT_NSS_BW_MASK))
>> +		    !(ext_nss_cap && vht_cap->cap & 
>> IEEE80211_VHT_CAP_EXT_NSS_BW_MASK))
> 
> you should not mix logical and binary operators so add braces around
> the binary operation here.
priority of & is higher than &&, so it not need to add braces here.
however, i have sent patch v2 which added the braces.
https://lore.kernel.org/linux-wireless/20210521021809.23986-1-wgong@codeaurora.org/T/#u
> 
> Regards,
> Arend
> 
>>   			return false;
>>   		break;
>>   	default:
>> 
