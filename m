Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6A22A4603
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Nov 2020 14:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbgKCNNa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Nov 2020 08:13:30 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:16113 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728721AbgKCNN3 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Nov 2020 08:13:29 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604409209; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=kJE3Itmf+jWbO4yB/RJMz173+NAW4O8iB9/q9jXy720=;
 b=uPYKnWTFhlzv12JJQnN1gh/RrULPRGAfxB4hKhcEzTN+NDETWoqASrT/Cx+40r83KHtU2ocw
 DlwuORKg2Uiv9UGNCvTbvt6X6bWtyoEgztFbi7mjuDBsDfbntk7P+HHFrnIfe9+/LPtOWHsY
 LtPNZ9qI2ckzC4Km7T8fHKeixTg=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 5fa15770d608b771031723ba (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 03 Nov 2020 13:13:20
 GMT
Sender: cjhuang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BA179C43395; Tue,  3 Nov 2020 02:34:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cjhuang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D4D49C43382;
        Tue,  3 Nov 2020 02:34:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 03 Nov 2020 10:34:47 +0800
From:   Carl Huang <cjhuang@codeaurora.org>
To:     Abhishek Kumar <kuabhs@chromium.org>
Cc:     briannorris@chromium.org, linux-wireless@vger.kernel.org,
        dianders@chromium.org, ath10k@lists.infradead.org,
        johannes@sipsolutions.net
Subject: Re: [RFC 1/2] nl80211: add common API to configure SAR power
 limitations.
In-Reply-To: <20201031024631.1528113-1-kuabhs@chromium.org>
References: <20201030205639.1452712-1-kuabhs@chromium.org>
 <20201031024631.1528113-1-kuabhs@chromium.org>
Message-ID: <e5302eb0b20339d3f6544652e4034993@codeaurora.org>
X-Sender: cjhuang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-10-31 10:46, Abhishek Kumar wrote:
> From: kuabhs@chromium.org
> 
> There are few more additional comments here.
>> + * @NL80211_CMD_SET_SAR_SPECS: SAR power limitation configuration is
>> + *     passed using %NL80211_ATTR_SAR_SPEC.
>> + *
> 
> This command requires NL80211_ATTR_IFINDEX, probably should be better 
> to add
> this in the comment ?
> 
Per Johannes's comments, this explicit index is not required. Are you 
fine
with it?

Instead, user-space application records the array index when querying 
the SAR
capability. When set, the nested array index will be used to set the 
power.
This requires user-space has a strict mapping of index. and 
NL80211_ATTR_IFINDEX
is to be removed.


>> +static int
>> +nl80211_put_sar_specs(struct cfg80211_registered_device *rdev,
>> +                     struct sk_buff *msg)
>> +{
>> +       struct nlattr *sar_capa, *specs, *sub_freq_range;
>> +       u8  num_freq_ranges;
>> +       int i;
>> +
>> +       if (!rdev->wiphy.sar_capa)
>> +               return 0;
>> +
>> +       num_freq_ranges = rdev->wiphy.sar_capa->num_freq_ranges;
>> +
>> +       sar_capa = nla_nest_start(msg, NL80211_ATTR_SAR_SPEC);
>> +       if (!sar_capa)
>> +               return -ENOSPC;
> 
> I see some places nla_nest_start_noflag being used and here 
> nla_nest_start.
> Whats the specific reason to do that ? In the newer Kernel versions, I 
> believe
> nla_nest_start is preferred.
> 
This will be addressed in next version.

>> +               power = 
>> nla_get_u8(spec[NL80211_SAR_ATTR_SPECS_POWER]);
>> +               sar_spec->sub_specs[specs].power = power;
>> +
>> +               /* if NL80211_SAR_ATTR_SPECS_FREQ_RANGE_INDEX isn't 
>> present,
>> +                * then the power applies to all bands. But it's only 
>> valid
>> +                * for the first entry.
>> +                */
>> +               if (!spec[NL80211_SAR_ATTR_SPECS_FREQ_RANGE_INDEX]) {
>> +                       if (specs) {
>> +                               err = -EINVAL;
>> +                               goto error;
>> +                       } else {
>> +                               
>> sar_spec->sub_specs[specs].freq_range_index =
>> +                                       NL80211_SAR_ALL_FREQ_RNAGES;
>> +                               specs++;
>> +                               break;
>> +                       }
>> +               }
> 
> Here I see you are assigning same power to all freq band if for the 
> first band
> the freq index is not provided. Is there any specific reason to only
> check the first
> here ? Probably this logic should move into specific drivers. Thoughts 
> ?
> 
This logic will be removed per Johannes's comments.

Please read  Johannes's comments. If you agree with him and has no other 
advices,
then I will post the second version of it.


> -Abhishek
> 
> 
> _______________________________________________
> ath10k mailing list
> ath10k@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/ath10k
