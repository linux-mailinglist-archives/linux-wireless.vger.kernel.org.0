Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F74D1F99FC
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2020 16:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730526AbgFOOUq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Jun 2020 10:20:46 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:60583 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729733AbgFOOUq (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Jun 2020 10:20:46 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592230845; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=czrYUlyT3kZ7GiZuDFHwz0laE3llzhJoc1Uz3avQubs=; b=wTgIy1+l035CmAwi12m1Q4yTCFjwR2jKq6n4JofkfoNHQJ/MZ1O8Zh+Xn/HD1vdt+3tc2fI1
 zDNG46nJC1Dn+jybN4bzAt4XExsIpNGxIiHYxzECqZjW8Av7KgckjTEHFF7keHRxkOj0puP1
 bqkyalfp6GMlcCb/IXwXUn55SOk=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5ee783b0f3deea03f3d3183b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 15 Jun 2020 14:20:32
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1BBD5C43387; Mon, 15 Jun 2020 14:20:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7E9FDC433CB;
        Mon, 15 Jun 2020 14:20:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7E9FDC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Julian Calaby <julian.calaby@gmail.com>
Cc:     Anilkumar Kolli <akolli@codeaurora.org>,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Subject: Re: [PATCH 7/8] ath11k: add ce services for IPQ6018
References: <1591678993-11016-1-git-send-email-akolli@codeaurora.org>
        <1591678993-11016-8-git-send-email-akolli@codeaurora.org>
        <CAGRGNgWO_KwfQcfh=DSB5NdM2696ZzVU7ZuQN_x_+op1c5ySEw@mail.gmail.com>
Date:   Mon, 15 Jun 2020 17:20:28 +0300
In-Reply-To: <CAGRGNgWO_KwfQcfh=DSB5NdM2696ZzVU7ZuQN_x_+op1c5ySEw@mail.gmail.com>
        (Julian Calaby's message of "Tue, 9 Jun 2020 17:10:06 +1000")
Message-ID: <874krcjtqr.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Julian Calaby <julian.calaby@gmail.com> writes:

> On Tue, Jun 9, 2020 at 3:07 PM Anilkumar Kolli <akolli@codeaurora.org> wrote:
>>
>> IPQ6018 does not support mac2, add a new ce service map.
>>
>> Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
>> ---
>>  drivers/net/wireless/ath/ath11k/ahb.c | 122 ++++++++++++++++++++++++++++++++--
>>  1 file changed, 117 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
>> index b080ad8fab0a..25764f719db0 100644
>> --- a/drivers/net/wireless/ath/ath11k/ahb.c
>> +++ b/drivers/net/wireless/ath/ath11k/ahb.c
>> @@ -647,8 +749,15 @@ static void ath11k_ahb_init_qmi_ce_config(struct ath11k_base *ab)
>>
>>         cfg->tgt_ce_len = ARRAY_SIZE(target_ce_config_wlan) - 1;
>>         cfg->tgt_ce = target_ce_config_wlan;
>> -       cfg->svc_to_ce_map_len = ARRAY_SIZE(target_service_to_ce_map_wlan);
>> -       cfg->svc_to_ce_map = target_service_to_ce_map_wlan;
>> +       if (ab->hw_params.dev_id == ATH11K_HW_IPQ6018) {
>> +               cfg->svc_to_ce_map_len =
>> +                       ARRAY_SIZE(target_service_to_ce_map_wlan_ipq6018);
>> +               cfg->svc_to_ce_map = target_service_to_ce_map_wlan_ipq6018;
>> +       } else {
>> +               cfg->svc_to_ce_map_len =
>> +                       ARRAY_SIZE(target_service_to_ce_map_wlan_ipq8074);
>> +               cfg->svc_to_ce_map = target_service_to_ce_map_wlan_ipq8074;
>> +       }
>
> You could just have a pointer to this array in the "hw_params"
> structure which would reduce this to something like:
>
> cfg->svc_to_ce_map_len = ARRAY_SIZE(ab->hw_params.service_to_ce_map);
> cfg->svc_to_ce_map = ab->hw_params.service_to_ce_map;
>
> and make adding future hardware easier.

Yeah, that's a good idea.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
