Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACBAD1E8398
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2020 18:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgE2Q0V (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 May 2020 12:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgE2Q0U (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 May 2020 12:26:20 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB3BC03E969
        for <linux-wireless@vger.kernel.org>; Fri, 29 May 2020 09:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=RRZpYVNgi0Cv6Sp/r3A8FrzZfzBZmxak7j674fp2yAA=; b=ep8vjTUOMXLx9blvAE0o+ixwHz
        ot12Pa7D3xs2Nk8S3aRL3G2JhXZxNZqaNx6awX4fIXP2jBM5dtnI2ZKRmlkqJB3J6ftBGZxfjrj7h
        EeRCRMFfVc4aVxWXscCvvJ3hWr8uche6nj+fWYwr+f9w8G+7YK3IcGA8+o+ArLHpZMxk=;
Received: from p4ff13c20.dip0.t-ipconnect.de ([79.241.60.32] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1jehpr-0008CS-4X; Fri, 29 May 2020 18:26:19 +0200
Subject: Re: pull request: mt76 2019-05-22
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
References: <d0de94c9-f367-0f57-950b-c76e1808bdcb@nbd.name>
 <875zceu90v.fsf@codeaurora.org>
From:   Felix Fietkau <nbd@nbd.name>
Autocrypt: addr=nbd@nbd.name; prefer-encrypt=mutual; keydata=
 xsDiBEah5CcRBADIY7pu4LIv3jBlyQ/2u87iIZGe6f0f8pyB4UjzfJNXhJb8JylYYRzIOSxh
 ExKsdLCnJqsG1PY1mqTtoG8sONpwsHr2oJ4itjcGHfn5NJSUGTbtbbxLro13tHkGFCoCr4Z5
 Pv+XRgiANSpYlIigiMbOkide6wbggQK32tC20QxUIwCg4k6dtV/4kwEeiOUfErq00TVqIiEE
 AKcUi4taOuh/PQWx/Ujjl/P1LfJXqLKRPa8PwD4j2yjoc9l+7LptSxJThL9KSu6gtXQjcoR2
 vCK0OeYJhgO4kYMI78h1TSaxmtImEAnjFPYJYVsxrhay92jisYc7z5R/76AaELfF6RCjjGeP
 wdalulG+erWju710Bif7E1yjYVWeA/9Wd1lsOmx6uwwYgNqoFtcAunDaMKi9xVQW18FsUusM
 TdRvTZLBpoUAy+MajAL+R73TwLq3LnKpIcCwftyQXK5pEDKq57OhxJVv1Q8XkA9Dn1SBOjNB
 l25vJDFAT9ntp9THeDD2fv15yk4EKpWhu4H00/YX8KkhFsrtUs69+vZQwc0cRmVsaXggRmll
 dGthdSA8bmJkQG5iZC5uYW1lPsJgBBMRAgAgBQJGoeQnAhsjBgsJCAcDAgQVAggDBBYCAwEC
 HgECF4AACgkQ130UHQKnbvXsvgCgjsAIIOsY7xZ8VcSm7NABpi91yTMAniMMmH7FRenEAYMa
 VrwYTIThkTlQzsFNBEah5FQQCACMIep/hTzgPZ9HbCTKm9xN4bZX0JjrqjFem1Nxf3MBM5vN
 CYGBn8F4sGIzPmLhl4xFeq3k5irVg/YvxSDbQN6NJv8o+tP6zsMeWX2JjtV0P4aDIN1pK2/w
 VxcicArw0VYdv2ZCarccFBgH2a6GjswqlCqVM3gNIMI8ikzenKcso8YErGGiKYeMEZLwHaxE
 Y7mTPuOTrWL8uWWRL5mVjhZEVvDez6em/OYvzBwbkhImrryF29e3Po2cfY2n7EKjjr3/141K
 DHBBdgXlPNfDwROnA5ugjjEBjwkwBQqPpDA7AYPvpHh5vLbZnVGu5CwG7NAsrb2isRmjYoqk
 wu++3117AAMFB/9S0Sj7qFFQcD4laADVsabTpNNpaV4wAgVTRHKV/kC9luItzwDnUcsZUPdQ
 f3MueRJ3jIHU0UmRBG3uQftqbZJj3ikhnfvyLmkCNe+/hXhPu9sGvXyi2D4vszICvc1KL4RD
 aLSrOsROx22eZ26KqcW4ny7+va2FnvjsZgI8h4sDmaLzKczVRIiLITiMpLFEU/VoSv0m1F4B
 FtRgoiyjFzigWG0MsTdAN6FJzGh4mWWGIlE7o5JraNhnTd+yTUIPtw3ym6l8P+gbvfoZida0
 TspgwBWLnXQvP5EDvlZnNaKa/3oBes6z0QdaSOwZCRA3QSLHBwtgUsrT6RxRSweLrcabwkkE
 GBECAAkFAkah5FQCGwwACgkQ130UHQKnbvW2GgCfTKx80VvCR/PvsUlrvdOLsIgeRGAAn1ee
 RjMaxwtSdaCKMw3j33ZbsWS4
Message-ID: <adcaf365-8dda-8c04-99ab-c6d1d1901fc8@nbd.name>
Date:   Fri, 29 May 2020 18:26:18 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <875zceu90v.fsf@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-05-29 16:10, Kalle Valo wrote:
> Felix Fietkau <nbd@nbd.name> writes:
> 
>> Hi Kalle,
>>
>> here's another pull request for 5.8, replacing the previous one.
>>
>> - Felix
>>
>> The following changes since commit 50ce4c099bebf56be86c9448f7f4bcd34f33663c:
>>
>>   sctp: fix typo sctp_ulpevent_nofity_peer_addr_change (2020-05-27 15:08:02 -0700)
>>
>> are available in the Git repository at:
>>
>>   https://github.com/nbd168/wireless tags/mt76-for-kvalo-2020-05-28
>>
>> for you to fetch changes up to d9045b18cd445e0d0a53903ffd5d79793d9df59e:
>>
>>   mt76: mt7915: remove set but not used variable 'msta' (2020-05-28 17:57:25 +0200)
>>
>> ----------------------------------------------------------------
>> mt76 patches for 5.8
>>
>> * fixes for sparse warnings
>> * DBDC fixes
>> * mt7663 remain-on-channel support
>> * mt7915 spatial reuse support
>> * mt7915 radiotap fix
>> * station wcid allocation fix
>> * mt7663 powersave fix
>> * mt7663 scan fix
>> * mt7611n support
>> * cleanup
>>
>> ----------------------------------------------------------------
> 
> One commit has the Cc field by accident, but no need to resend because
> of this. Just check your workflow.
Sorry about that. I will be more careful about that sort of thing.

Thanks,

- Felix
