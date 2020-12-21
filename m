Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD3D2E026D
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Dec 2020 23:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbgLUWWX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Dec 2020 17:22:23 -0500
Received: from mail2.candelatech.com ([208.74.158.173]:53908 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgLUWWW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Dec 2020 17:22:22 -0500
Received: from [192.168.254.6] (unknown [50.46.158.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 2539113C2B0;
        Mon, 21 Dec 2020 14:21:42 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 2539113C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1608589302;
        bh=u1kcYItexzSqhZ/LdK+cgKFiRExwyVnWjAL3XOvHJuA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=EOXB7iDHKaoeaTVuZOuPrO5CYcPhkz6qwxS8sU5bwEb5tCaLbQCQZPDI4PYAEw6GD
         aPbOarnxWa2oM0+upV4JA8qNF4wkZfwT/BF4gJbTzcMT7d43MleUeTDxFPwTTpxEMM
         E2WjNVO+yMAO5FTQVa8+41GSAMYIb6tHD1XU8g0U=
Subject: Re: [PATCH v2] ath10k: Per-chain rssi should sum the secondary
 channels
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
References: <20191217183343.25585-1-greearb@candelatech.com>
 <20201221183044.9016DC433C6@smtp.codeaurora.org>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <ff0dde53-8483-88c9-3b7a-65e905bca632@candelatech.com>
Date:   Mon, 21 Dec 2020 14:21:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201221183044.9016DC433C6@smtp.codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 12/21/20 10:30 AM, Kalle Valo wrote:
> greearb@candelatech.com wrote:
> 
>> From: Ben Greear <greearb@candelatech.com>
>>
>> This makes per-chain RSSI be more consistent between HT20, HT40, HT80.
>> Instead of doing precise log math for adding dbm, I did a rough estimate,
>> it seems to work good enough.
>>
>> Tested on ath10k-ct 9984 firmware.
>>
>> Signed-off-by: Ben Greear <greearb@candelatech.com>
> 
> Commented out code etc so I assume this is an RFC. Has anyone tested
> this with upstream firmware?

I probably tweaked this patch since sending.  my wave-1 didn't work with this approach,
and in the end, to get a valid RSSI, I ended up reading the
per-chain noise-floor periodically and storing that so I could use proper noise-floor
instead of just -95.  I am not sure upstream firmware can support that, so probably
not worth adding just the sum logic unless someone can figure out how to get the noise
floor out of the firmware...

Thanks,
Ben



-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
