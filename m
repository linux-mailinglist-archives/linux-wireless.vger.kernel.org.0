Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5E70B5472
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Sep 2019 19:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbfIQRoE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Sep 2019 13:44:04 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:48028 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfIQRoE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Sep 2019 13:44:04 -0400
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 7398713753C;
        Tue, 17 Sep 2019 10:44:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 7398713753C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1568742243;
        bh=yKoFNLr7afSoYDBuTIU9ynCx61w6pq9x8JRWxKNnOWU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=cHjrOIzkxW+k3GDlHYyS4j8V/Zy/ms0xxAT9MpugG3LsCkKqUStOuiTEm4Wj2L60d
         2OXVfSjpztCqq3CCYmF94OJRyMQDMmM2UgQX3L4jGXIgLS/BZA/CscLOkcNG5a6uVt
         ehV192UVcTYbvwGRGO7L54B6nR0nIy32iYrmy+Dg=
Subject: Re: [PATCH] cfg80211: Add cumulative channel survey dump support.
To:     Sven Eckelmann <sven@narfation.org>, vnaralas@codeaurora.org,
        ath10k@lists.infradead.org
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org, sw@simonwunderlich.de,
        slakkavalli@datto.com
References: <1526980556-26707-1-git-send-email-vnaralas@codeaurora.org>
 <1527069282.3759.16.camel@sipsolutions.net>
 <ebf1c95acb34649b3d2a5435142dc06a@codeaurora.org>
 <2083094.mFhUXK7yzB@bentobox>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <cc8bc245-034b-376d-3952-0c0ac6d51cab@candelatech.com>
Date:   Tue, 17 Sep 2019 10:44:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <2083094.mFhUXK7yzB@bentobox>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/17/19 10:27 AM, Sven Eckelmann wrote:
> On Thursday, 31 May 2018 11:06:59 CEST vnaralas@codeaurora.org wrote:
>> I will sent next version of patch with updated commit log.
> 
> Can you please point me to the second version?
> 
> Btw. I've just checked the minimal changes in ath10k to get this working. It
> seems we need SURVEY_INFO_NON_ACC_DATA in ath10k's ath10k_get_survey + memset
> of ar->survey[idx].
> 
> But right now the total time looks (especially) wrong to me. At least it is
> rather unlikely that I can have around 30 second active time delta in
> roughly 1 real world second.  Maybe a bug with the READ_CLEAR handling in
> firmware 10.2.4-1.0-00043 or maybe all firmware version? More logs about
> that at the end.
> 
> @Ben: Was this also what you've experience in the past with the 10.2 firmware
> bss_chan_info counter bugs or am I just misusing the functionality of the
> firmware?

Last I recall, the upstream code had several bugs.  Maybe some QCA
firmware person can let you know if they fixed the upstream firmware.

If you want to test against ath10k-ct driver/firmware, and if you still see bogus values, then
I can debug and fix it.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

