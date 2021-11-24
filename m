Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF7745B5AF
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Nov 2021 08:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbhKXHnJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Nov 2021 02:43:09 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:16513 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229624AbhKXHnI (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Nov 2021 02:43:08 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1637739599; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=KlBt6VrXCvps14JV6wK6+MGAbpn/eHc4WVGnRxXnBXM=; b=oADJpJHcdO9rookz7UZiextgp2Y2VTcDLTIG5dNRUp3ABtPXuaIv1zxQk47om4SjGRh1IjsG
 gKnKxbHFfWqpB9wWRwyIRmL5zBQCYWkytmITVCyRtBgEr/AyUsJk1sBeh7fqIiJW33Tp0EZa
 OhjvQNcmKOugSkGmF7PpfWndRhI=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 619dec4e6bacc185a5dd15a2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 24 Nov 2021 07:39:58
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0166EC43616; Wed, 24 Nov 2021 07:39:58 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CF5F1C4360D;
        Wed, 24 Nov 2021 07:39:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org CF5F1C4360D
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     P Praneesh <ppranees@codeaurora.org>, <ath11k@lists.infradead.org>,
        <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy <periyasa@codeaurora.org>
Subject: Re: [PATCH v3 2/3] ath11k: Refactor update channel list function
References: <1634906227-22028-1-git-send-email-ppranees@codeaurora.org>
        <1634906227-22028-3-git-send-email-ppranees@codeaurora.org>
        <0fb4fec3-4fd0-6e92-b1d9-5bffc0958e97@quicinc.com>
Date:   Wed, 24 Nov 2021 09:39:50 +0200
In-Reply-To: <0fb4fec3-4fd0-6e92-b1d9-5bffc0958e97@quicinc.com> (Wen Gong's
        message of "Wed, 24 Nov 2021 11:50:05 +0800")
Message-ID: <87pmqq6lyx.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> writes:

> On 10/22/2021 8:37 PM, P Praneesh wrote:
>
> ...
>
>> ---
>> ...
>> -			ch->maxpower = channel->max_power * 2;
>> -			ch->maxregpower = channel->max_reg_power * 2;
>> -			ch->antennamax = channel->max_antenna_gain * 2;
>> ...
>>   +int ath11k_wmi_update_scan_chan_list(struct ath11k *ar,
>> +				     struct scan_req_params *arg)
>> ...
>> +			ch->maxpower = channel->max_power;
>> +			ch->maxregpower = channel->max_reg_power;
>> +			ch->antennamax = channel->max_antenna_gain;
>> +
>> ...
>
> I see it also have another patch to remove the "*2" for power.
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?id=9212c1b9e80a869e732769a4fe7f82d392b219be
>
> ath11k: send proper txpower and maxregpower values to firmware.
>
> so are you the same reason to remove "*2" ?

I'm not quite getting what you are saying, can you elaborate more? Did
this patch break something?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
