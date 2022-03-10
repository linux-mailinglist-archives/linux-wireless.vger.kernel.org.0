Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E15784D509F
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Mar 2022 18:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245127AbiCJRev (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Mar 2022 12:34:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245124AbiCJRet (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Mar 2022 12:34:49 -0500
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE132180224
        for <linux-wireless@vger.kernel.org>; Thu, 10 Mar 2022 09:33:48 -0800 (PST)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.65.202])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 63C581C0083;
        Thu, 10 Mar 2022 17:33:47 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 7475C80061;
        Thu, 10 Mar 2022 17:33:46 +0000 (UTC)
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id AD8F113C2B0;
        Thu, 10 Mar 2022 09:33:45 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com AD8F113C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1646933625;
        bh=csPLNH+Xm14KMoz5U1IHax3GownuS2xkwNwztW6xGFs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ALQanerqsMf2Sa7B10mp0DN1h/e0fIQrXWEQ+dwom1eeiWXsTywpF1MdoiaaUpmPO
         PtGHRDUW/13ZRmJ/vfXDe2+nZ6cnwHcy6mVB3fh6tpZabW9EqN3RtwB4KmAjcKAU3o
         HhmxN3RauhNc1MX+T1p8kjzg/prmJeY2GJUnWNVI=
Subject: Re: [PATCH v2 1/2] mac80211: extend current rate control tx status
 API
To:     Jonas Jelonek <jelonek.jonas@gmail.com>
Cc:     =?UTF-8?Q?Thomas_H=c3=bchn?= <thomas@inet.tu-berlin.de>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Kalle Valo <kvalo@kernel.org>, "nbd@nbd.name" <nbd@nbd.name>,
        johannes@sipsolutions.net
References: <20220309195759.1494-1-jelonek.jonas@gmail.com>
 <20220309195759.1494-2-jelonek.jonas@gmail.com>
 <bc398c48-b5b2-8037-a8c6-712b2e191202@candelatech.com>
 <8FC6B734-4D4A-4D91-A38E-DE36E415A36E@inet.tu-berlin.de>
 <22a43538-a2ad-f3a7-2909-5ef6a0d2ab27@candelatech.com>
 <CAChE-vRdnLgjGt3wDrzDC_eKWnX-wi_bWAiBYcheZrSMcfDoyQ@mail.gmail.com>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <0a447b8e-647f-2f0e-4444-35792974e1e6@candelatech.com>
Date:   Thu, 10 Mar 2022 09:33:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAChE-vRdnLgjGt3wDrzDC_eKWnX-wi_bWAiBYcheZrSMcfDoyQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-MDID: 1646933627-u9-YbG20Txd8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 3/10/22 9:27 AM, Jonas Jelonek wrote:
> On 3/10/22 16:43 UTC, Ben Greear wrote:
>>>
>>> Certain 802.11a/g/n Atheros chips provide a 0,5dB tx-power step granularity, while Mediatek 802.11ac chips have 1dB or even 3dB step width. So I would argue that a 1dB step width is a good compromise as the common value for new tpc algorithms.
>>
>> If you use 0.5db units for that struct, then it will support anything with that granularity or higher.
>> But, fine with me if you want to just have it be 1db units.
>>
> using 0.5db is more appropriate for the already existing chips that
> support this granularity, and is more future-proof.
> 1db units may be easier to handle for the API and/or TPC algorithms
> but again limits existing hardware capabilities.
> 
>>> The ath9k chips I have used so far support a minimum tx-power of -5dBm (=0,32mW), Mediatek has a min of 0dBm (=1mW)… so I would argue to use 0dBm  (=1mW) as common minimum tx-power value, as the any possible spatial reuse gain happens from 0dBm up to max tx-power.
>>
>> If a chip supports setting to txpower to -5, then why not let the API support that?  Have The value -128
>> be 'do not set', and anything else will mean 'try to set the chip to this power or the nearest thing to it
>> that the chip supports'.
> 
> I agree with that, having -128 as value for 'not set' or 'invalid'
> would leave the negative dBm for chips that support this.
> Whether the TPC then actually makes use of this should not be the
> reason to use 0 as default.
> 
> To your previous question:
> retry_count = 1 is intended to be a single tx, so naming the struct
> member 'try_count' would be more appropriate?

Yes, I think so.

In my own hackings, I have also used a try_count of '0' to mean try once
but request NOACK on the frame.  I am not sure if that even applies in
your case though...

Thanks,
Ben

> 
> Besides this, I will add proper documentation for this in the
> following patch version to clarify the units and meanings.




-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

