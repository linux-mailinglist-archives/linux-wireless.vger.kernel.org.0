Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9591540D2
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2020 10:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbgBFJEM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Feb 2020 04:04:12 -0500
Received: from nbd.name ([46.4.11.11]:57252 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbgBFJEM (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Feb 2020 04:04:12 -0500
Received: from [95.81.1.64] (helo=[10.255.231.27])
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1izd50-0006N0-Jw; Thu, 06 Feb 2020 10:04:10 +0100
Subject: Re: [PATCH V2 1/3] nl80211: add support for setting fixed HE
 rate/gi/ltf
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     Miles Hu <milehu@codeaurora.org>, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org
References: <20200204103514.18111-1-john@phrozen.org>
 <4bf4c267-bfc2-1a04-f2d6-541f086e72c0@broadcom.com>
From:   John Crispin <john@phrozen.org>
Message-ID: <1b74ca8c-3bed-6296-5b3d-1ece82b4a56e@phrozen.org>
Date:   Thu, 6 Feb 2020 10:04:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <4bf4c267-bfc2-1a04-f2d6-541f086e72c0@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 06/02/2020 09:58, Arend Van Spriel wrote:
> On 2/4/2020 11:35 AM, John Crispin wrote:
>> From: Miles Hu <milehu@codeaurora.org>
>>
>> This patch adds the nl80211 structs, definitions, policies and parsing
>> code required to pass fixed HE rate, gi and ltf settings.
>>
>> Signed-off-by: John Crispin <john@phrozen.org>
>> Signed-off-by: Miles Hu <milehu@codeaurora.org>
>> ---
>> Changes in V2
>> * add more policies
>> * reoder enums
>> * remove incorrect he_cap from ieee80211_supported_band
> 
> Not seeing the change listed above or am I missing something?
> 
> Regards,
> Arend

Hi Arend,
that is the delta to V1 as per Johannes's feedback. Not additional 
code/features
	John

> 
>> * remove _WARN from policy
>>
>>   include/net/cfg80211.h       |   3 +
>>   include/uapi/linux/nl80211.h |  28 +++++++++
>>   net/wireless/nl80211.c       | 117 ++++++++++++++++++++++++++++++++++-
>>   3 files changed, 146 insertions(+), 2 deletions(-)
> 
> _______________________________________________
> ath11k mailing list
> ath11k@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/ath11k

