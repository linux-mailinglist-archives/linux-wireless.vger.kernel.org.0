Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7A1149A55
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2020 12:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729255AbgAZLK3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 26 Jan 2020 06:10:29 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:17914 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726436AbgAZLK3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 26 Jan 2020 06:10:29 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580037028; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=9cXD0JbgoEOJ/xwaPErLWvhid4jdbxT0RLrSqEM4ZsE=;
 b=IT2h8XNZ768JuTZFyvbTk5zuYdazO9zz8RHrYeC0sRR3dMPLuXMYm7SJZ+TuCA0ygfgMl/Oq
 nfYEX8fb8p9X8gbXVeKAHBqqFanhqnMtSHLTjJk8JHx5PFRz7jeRXPZU0LxPrpZgHqiPOCwP
 QpWpbQDh2FLsI1Ej7dK4twSz0Ks=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e2d73a3.7f105259fae8-smtp-out-n01;
 Sun, 26 Jan 2020 11:10:27 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 37295C4479C; Sun, 26 Jan 2020 11:10:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: vjakkam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9BE04C43383;
        Sun, 26 Jan 2020 11:10:25 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 26 Jan 2020 16:40:25 +0530
From:   vjakkam@codeaurora.org
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2] cfg80211: Enhance the AKM advertizement to support per
 interface.
In-Reply-To: <a09e490e-a1e9-b4ec-afbf-438aef816435@broadcom.com>
References: <20191223185255.1009-1-vjakkam@codeaurora.org>
 <20200117113507.13503-1-vjakkam@codeaurora.org>
 <a09e490e-a1e9-b4ec-afbf-438aef816435@broadcom.com>
Message-ID: <1793692bd48e546915d3a3ec28208b01@codeaurora.org>
X-Sender: vjakkam@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-01-20 14:27, Arend Van Spriel wrote:
> On 1/17/2020 12:35 PM, Veerendranath Jakkam wrote:
>> Commit ab4dfa20534e ("cfg80211: Allow drivers to advertise supported 
>> AKM
>> suites") introduces the support to advertize supported AKMs to 
>> userspace.
>> 
>> This needs an enhancement to advertize the AKM support per interface 
>> type,
>> specifically for the cfg80211-based drivers that implement SME and use
>> different mechanisms to support the AKM's for each interface type 
>> (e.g.,
>> the support for SAE, OWE AKM's take different paths for such drivers 
>> on
>> STA/AP mode).
>> 
>> Add a new nl80211 attribute to provide supported AKMs per interface 
>> type
>> to userspace.
>> 
>> This commit aims the same and enhances the earlier mechanism of 
>> advertizing
>> the AKMs per wiphy. AKMs advertized in akm_suites are default 
>> capabilities
>> if not advertized for a specific interface type in iftype_akm_suites.
>> 
>> Signed-off-by: Veerendranath Jakkam <vjakkam@codeaurora.org>
>> ---
>> Changelog:
>> v1->v2:
>>   -Keep advertizing support for AKM suites per wiphy
>>   -AKM suites per interface overrides wiphy AKM suites for specific 
>> interface
>>   -Rename new nl80211 attribute to NL80211_ATTR_IFTYPE_AKM_SUITES
>> ---
>>   include/net/cfg80211.h       | 22 +++++++++++++++++++-
>>   include/uapi/linux/nl80211.h |  6 ++++++
>>   net/wireless/nl80211.c       | 39 
>> ++++++++++++++++++++++++++++++++++++
>>   3 files changed, 66 insertions(+), 1 deletion(-)
>> 
>> diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
>> index fa027d0d031b..10533dff2102 100644
>> --- a/include/net/cfg80211.h
>> +++ b/include/net/cfg80211.h
>> @@ -4398,6 +4398,18 @@ struct cfg80211_pmsr_capabilities {
>>   	} ftm;
>>   };
>>   +/**
>> + * struct wiphy_iftype_akm_suites - supported akm suites per 
>> interface type
>> + * @iftype: interface type
>> + * @akm_suites: points to an array of supported akm suites
>> + * @n_akm_suites: number of supported AKM suites
>> + */
>> +struct wiphy_iftype_akm_suites {
>> +	enum nl80211_iftype iftype;
> 
> I can imagine certain iftypes could support same suites so maybe good
> to use bitmask of iftypes iso single iftype.
> 
> Regards,
> Arend
> 
>> +	const u32 *akm_suites;
>> +	int n_akm_suites;
>> +};
>> +

Thanks, I will upload v3 patch with suggested changes.
