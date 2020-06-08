Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13F8F1F17D8
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jun 2020 13:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729536AbgFHL30 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 Jun 2020 07:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729310AbgFHL30 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 Jun 2020 07:29:26 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C05C08C5C2
        for <linux-wireless@vger.kernel.org>; Mon,  8 Jun 2020 04:29:26 -0700 (PDT)
Received: from [2a04:4540:1401:8800:2d8:61ff:feed:60f5]
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1jiFxx-0000sY-MB; Mon, 08 Jun 2020 13:29:21 +0200
Subject: Re: [PATCH 12/12] ath11k: set the multiple bssid hw cap
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
References: <20200604070952.15481-1-john@phrozen.org>
 <20200604070952.15481-13-john@phrozen.org> <87ftb5ke5d.fsf@codeaurora.org>
From:   John Crispin <john@phrozen.org>
Message-ID: <14370186-aacb-78a7-c03b-b7517e065b3d@phrozen.org>
Date:   Mon, 8 Jun 2020 13:29:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <87ftb5ke5d.fsf@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 08.06.20 13:09, Kalle Valo wrote:
> John Crispin <john@phrozen.org> writes:
> 
>> This patch sets the SUPPORTS_MULTI_BSSID inside ath11k.
>>
>> Signed-off-by: John Crispin <john@phrozen.org>
> 
> On what hardware and firmware did you test this?
> 
>> --- a/drivers/net/wireless/ath/ath11k/wmi.h
>> +++ b/drivers/net/wireless/ath/ath11k/wmi.h
>> @@ -109,8 +109,8 @@ enum {
>>   
>>   enum {
>>   	WMI_HOST_VDEV_FLAGS_NON_MBSSID_AP	= 1,
>> -	WMI_HOST_VDEV_FLAGS_TRANSMIT_AP		= 2,
>> -	WMI_HOST_VDEV_FLAGS_NON_TRANSMIT_AP	= 4,
>> +	WMI_HOST_VDEV_FLAGS_NON_TRANSMIT_AP	= 2,
>> +	WMI_HOST_VDEV_FLAGS_TRANSMIT_AP		= 4,
> 
> I wonder if this is a safe thing to do? Do all firmware branches use
> these new values?
> 

Hi,
looks like i folded the fix patch into the wrong patch. these values get 
added in this same patchset. Johannes commented on the nl80211 part 
already and i will send out a V2 this week.
	John
