Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42F432A9024
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Nov 2020 08:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgKFHRG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Nov 2020 02:17:06 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:55545 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbgKFHRG (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Nov 2020 02:17:06 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604647025; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=2ceNdW2nIFqcnwPL1hsLy+ofihqtQ74th6wCBVy8fZE=; b=EoE5b+raF/sd0QFnPYD1xV/QsS0Sr1kQ+04XJb0Kx6ZkkKL2Rv6K4Dy+FWta2L2gECHvX71o
 UrImTuwyVGSM/Q/tK4YRAHqHKdiVe/9vNHWi3LE0/9U5Cb/gZP0FVByZVp3urztC8hlgVSjV
 J6gVudrerrfCm5NUIaoBv/20JCw=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5fa4f8611baf490ee91b2e2f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 06 Nov 2020 07:16:49
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E39C0C433FE; Fri,  6 Nov 2020 07:16:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4863BC433C6;
        Fri,  6 Nov 2020 07:16:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4863BC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     "Rakesh Pillai" <pillair@codeaurora.org>
Cc:     "'Doug Anderson'" <dianders@chromium.org>,
        'Abhishek Kumar' <kuabhs@chromium.org>,
        'Brian Norris' <briannorris@chromium.org>,
        'linux-wireless' <linux-wireless@vger.kernel.org>,
        'LKML' <linux-kernel@vger.kernel.org>,
        'ath10k' <ath10k@lists.infradead.org>
Subject: Re: [PATCH] ath10k: Fix the parsing error in service available event
References: <1603811067-23058-1-git-send-email-pillair@codeaurora.org>
        <CAD=FV=XRyeXcE93nZgOy+x5eWcHcKKwbJccuWFkx+cA8tEXwZQ@mail.gmail.com>
        <003801d6ad41$a1bb8970$e5329c50$@codeaurora.org>
Date:   Fri, 06 Nov 2020 09:16:45 +0200
In-Reply-To: <003801d6ad41$a1bb8970$e5329c50$@codeaurora.org> (Rakesh Pillai's
        message of "Wed, 28 Oct 2020 21:17:19 +0530")
Message-ID: <878sbflztu.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

"Rakesh Pillai" <pillair@codeaurora.org> writes:

>> > diff --git a/drivers/net/wireless/ath/ath10k/wmi-tlv.c
>> b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
>> > index 932266d..3b49e29 100644
>> > --- a/drivers/net/wireless/ath/ath10k/wmi-tlv.c
>> > +++ b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
>> > @@ -1404,9 +1404,12 @@ static int ath10k_wmi_tlv_svc_avail_parse(struct
>> ath10k *ar, u16 tag, u16 len,
>> >                 arg->service_map_ext_len = *(__le32 *)ptr;
>> >                 arg->service_map_ext = ptr + sizeof(__le32);
>> >                 return 0;
>> > +       case WMI_TLV_TAG_FIRST_ARRAY_ENUM:
>> > +               return 0;
>> 
>> This is at least slightly worrying to me.  If I were calling this
>> function, I'd expect that if I didn't get back an error that at least
>> "arg->service_map_ext_len" was filled in.  Seems like you should do:
>> 
>> case WMI_TLV_TAG_FIRST_ARRAY_ENUM:
>>   arg->service_map_ext_len = 0;
>>   arg->service_map_ext = NULL;
>>   return 0;
>> 
>> ...and maybe add a comment about why you're doing that?
>> 
>> At the moment things are working OK because
>> ath10k_wmi_event_service_available() happens to init the structure to
>> 0 before calling with:
>> 
>>   struct wmi_svc_avail_ev_arg arg = {};
>> 
>> ....but it doesn't seem like a great idea to rely on that.
>> 
>> That all being said, I'm just a drive-by reviewer and if everyone else
>> likes it the way it is, feel free to ignore my comments.
>
>
> The TLV TAG " WMI_TLV_TAG_STRUCT_SERVICE_AVAILABLE_EVENT" is the first
> and a mandatory TLV in the service available event. The subsequent
> TLVs are optional ones and may or may not be present (based on FW
> versions).

From ath10k point of view never trust what the firmware sends you. Even
if WMI_TLV_TAG_STRUCT_SERVICE_AVAILABLE_EVENT is a mandatory TLV it
might be missing for whatever reasons. The same is with buffer lengths
etc and always confirm what you are receiving from the firmware.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
