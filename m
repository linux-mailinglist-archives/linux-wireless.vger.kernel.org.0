Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEB342E7DC1
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Dec 2020 03:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgLaCrr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Dec 2020 21:47:47 -0500
Received: from mail2.candelatech.com ([208.74.158.173]:50136 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgLaCrq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Dec 2020 21:47:46 -0500
Received: from [192.168.254.6] (unknown [50.46.152.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id D7CED13C2B0;
        Wed, 30 Dec 2020 18:47:05 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com D7CED13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1609382826;
        bh=2mn5CDFdPiRtJXOt4x3nCCH4BwkT99QhAXktU+aBDls=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Xwn1SRMskSMLreyLl7fLjCIQAbZ7GZYkQHoipuGn/XNI51uC067fJ2AkITVA/NkeN
         +SFYtT8Jmv+V7aHhvr+sMohSlXn4O9KRSfXB4hR7Qgrq+zhjmHF4/f60jlREYLbOLf
         Ul7LMdrYyQyKqIia2M+cs7PQQUbm6T/UVNlaTkoc=
Subject: Re: [PATCH 3/6] iwlwifi: Allow per-device fwcfg files.
To:     Julian Calaby <julian.calaby@gmail.com>
Cc:     linux-wireless@vger.kernel.org, Luciano Coelho <luca@coelho.fi>
References: <20201231000523.14963-1-greearb@candelatech.com>
 <20201231000523.14963-3-greearb@candelatech.com>
 <CAGRGNgXx3tqzOjLcKA=+FDrQsad_Hn=KX_gC+P4DFX+r8e2Fnw@mail.gmail.com>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <8b14768d-4ddb-6cb0-e27a-1fd1d8d1e41e@candelatech.com>
Date:   Wed, 30 Dec 2020 18:47:04 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAGRGNgXx3tqzOjLcKA=+FDrQsad_Hn=KX_gC+P4DFX+r8e2Fnw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 12/30/20 5:19 PM, Julian Calaby wrote:
> Hi Ben,
> 
> On Thu, Dec 31, 2020 at 11:17 AM <greearb@candelatech.com> wrote:
>>
>> From: Ben Greear <greearb@candelatech.com>
>>
>> This allows one to set the NSS and some
>> other low-level features for ax200 radios.
>>
>> Signed-off-by: Ben Greear <greearb@candelatech.com>
>> ---
>>   drivers/net/wireless/intel/iwlwifi/iwl-dbg-cfg.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-cfg.c b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-cfg.c
>> index 223c716d9fce..e2ae509d1650 100644
>> --- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-cfg.c
>> +++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-cfg.c
>> @@ -246,12 +246,16 @@ void iwl_dbg_cfg_load_ini(struct device *dev, struct iwl_dbg_cfg *dbgcfg)
>>          const struct firmware *fw;
>>          char *data, *end, *pos;
>>          int err;
>> +       char fname[128];
>>
>>          if (dbgcfg->loaded)
>>                  return;
>>
>> -       /* TODO: maybe add a per-device file? */
>> -       err = firmware_request_nowarn(&fw, "iwl-dbg-cfg.ini", dev);
>> +       snprintf(fname, 127, "iwl-dbg-cfg-%s.ini", dev_name(dev));
>> +       fname[127] = 0;
>> +
>> +       /* TODO: maybe add a per-device file?  Yes, did that. --Ben */
> 
> You probably don't need the comment anymore =)
> 
>> +       err = firmware_request_nowarn(&fw, fname, dev);
> 
> Would it make sense to fall back to "iwl-dbg-cfg.ini" if the
> per-device one isn't available?

It would be fine with me, lets see if Luca has any interest in the patches
in general before I go tweaking on them...

Thanks,
Ben

> 
> Thanks,
> 


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
