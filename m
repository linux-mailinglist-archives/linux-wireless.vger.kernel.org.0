Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE643DDB7D
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Aug 2021 16:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234008AbhHBOtX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Aug 2021 10:49:23 -0400
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.52]:47274 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234377AbhHBOtX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Aug 2021 10:49:23 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.67.132])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 77F7D1C0063;
        Mon,  2 Aug 2021 14:49:12 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 49E98500026;
        Mon,  2 Aug 2021 14:49:12 +0000 (UTC)
Received: from [192.168.254.6] (unknown [50.34.183.227])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id CFB2C13C2B1;
        Mon,  2 Aug 2021 07:49:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com CFB2C13C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1627915751;
        bh=cdwIkuj4LQvdfDONH3ndN+CXLKEuMhwzmsPlE7IHc1s=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=oxK1XYTfg6Qgqtjh9ikY6FO1nEe7HkPmrXVTa0ju5AJMtu276l4r7Qr6HYUC9XY0I
         eyQtpiZiUqohp1mzedPq2lB2bemthevlSpUmP8uuXClY0VpqvjcXI/eyyE4T/cPAiH
         j3g2E53RgWrOcbEB0FNV+l3l7gap6OLhmqwalS88=
Subject: Re: [PATCH v4 1/8] mt76 - mt7915: Add ethtool stats support.
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
References: <20210723154627.10078-1-greearb@candelatech.com>
 <87bl6iditz.fsf@tynnyri.adurom.net>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <820645f2-e6fa-846f-a101-c4a977a9a994@candelatech.com>
Date:   Mon, 2 Aug 2021 07:49:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <87bl6iditz.fsf@tynnyri.adurom.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
X-MDID: 1627915752-dXDsn3X1qMuJ
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 7/31/21 12:48 AM, Kalle Valo wrote:
> greearb@candelatech.com writes:
> 
>> From: Ben Greear <greearb@candelatech.com>
>>
>> This exposes some tx-path stats to the ethtool API, so that
>> ethtool -S wlanX provides some more useful info.
>>
>> Signed-off-by: Ben Greear <greearb@candelatech.com>
> 
> The subject style mt76 uses is:
> 
> mt76: mt7915: Add ethtool stats support
> 
> And no period in the end.

Don't apply the 1/8 series.  I merged two patches based on previous
comment so now it is a x/7 series.  I'll go through and make sure
I have punctuation correct and re-submit that x/7 as needed.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
