Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE382A9037
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Nov 2020 08:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgKFHZn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Nov 2020 02:25:43 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:14963 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbgKFHZn (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Nov 2020 02:25:43 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604647542; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=KSFtXB0fMYrRDLd4eZCZ6m18gRUOPuVsjW4FtBbLZ/Y=; b=wAnlWdhBWqJ3InAzdzJYZFAC3ZY6uQ2O1jD+Hmdih3q8VhHJxD0+4Xov0SJ9LKbxoDOHsb2y
 B5vBO1xeIHYfk2VDQmPxvzVN1pYnsVW9hZ4Afhb46n39P28hb9NbQTREoa20uYBtXMEQY3RY
 SBNn/C1anhTzMgxOfAFA4CfMSXw=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5fa4fa76257b36c43ed11ca1 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 06 Nov 2020 07:25:42
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1074BC433F0; Fri,  6 Nov 2020 07:25:42 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 60663C433C8;
        Fri,  6 Nov 2020 07:25:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 60663C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Rakesh Pillai <pillair@codeaurora.org>,
        Abhishek Kumar <kuabhs@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        ath10k <ath10k@lists.infradead.org>
Subject: Re: [PATCH v2] ath10k: Fix the parsing error in service available event
References: <1603904469-598-1-git-send-email-pillair@codeaurora.org>
        <CAD=FV=V0apTHaemMKvRx1HWLaO9ArC2t4ohfZ7-CthFz2NiA2A@mail.gmail.com>
Date:   Fri, 06 Nov 2020 09:25:37 +0200
In-Reply-To: <CAD=FV=V0apTHaemMKvRx1HWLaO9ArC2t4ohfZ7-CthFz2NiA2A@mail.gmail.com>
        (Doug Anderson's message of "Wed, 28 Oct 2020 11:44:48 -0700")
Message-ID: <87wnyzkkum.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Doug Anderson <dianders@chromium.org> writes:

>>  static int ath10k_wmi_tlv_op_pull_svc_avail(struct ath10k *ar,
>> diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless/ath/ath10k/wmi.c
>> index 1fa7107..2e4b561 100644
>> --- a/drivers/net/wireless/ath/ath10k/wmi.c
>> +++ b/drivers/net/wireless/ath/ath10k/wmi.c
>> @@ -5751,8 +5751,9 @@ void ath10k_wmi_event_service_available(struct ath10k *ar, struct sk_buff *skb)
>>                             ret);
>>         }
>>
>> -       ath10k_wmi_map_svc_ext(ar, arg.service_map_ext, ar->wmi.svc_map,
>> -                              __le32_to_cpu(arg.service_map_ext_len));
>> +       if (arg.service_map_ext_valid)
>> +               ath10k_wmi_map_svc_ext(ar, arg.service_map_ext, ar->wmi.svc_map,
>> +                                      __le32_to_cpu(arg.service_map_ext_len));
>
> Your new patch still requires the caller to init the
> "service_map_ext_valid" to false before calling, but I guess there's
> not a whole lot more we can do because we might be parsing more than
> one tag.  It does seem nice that at least we now have a validity bit
> instead of just relying on a non-zero length to be valid.
>
> It might be nice to have a comment saying that it's up to us to init
> "arg.service_map_ext_valid" to false before calling
> ath10k_wmi_pull_svc_avail(), but I won't insist.  Maybe that's obvious
> to everyone but me...

It's not obvious to me either. Please add that comment.

BTW, for some reason Doug's response didn't get to patchwork:

https://patchwork.kernel.org/project/linux-wireless/patch/1603904469-598-1-git-send-email-pillair@codeaurora.org/

Though I do see it in linux-wireless, so most likely this was a
temporary glitch in patchwork. But it's just worrisome as nowadays I
only check the comments in patchwork before I apply the patch.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
