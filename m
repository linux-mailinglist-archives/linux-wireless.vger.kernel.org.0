Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B91287D6000
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Oct 2023 04:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbjJYChi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Oct 2023 22:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbjJYChh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Oct 2023 22:37:37 -0400
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7460B10C6
        for <linux-wireless@vger.kernel.org>; Tue, 24 Oct 2023 19:37:35 -0700 (PDT)
Received: from eig-obgw-6004a.ext.cloudfilter.net ([10.0.30.197])
        by cmsmtp with ESMTPS
        id vLNgqMOLQgpyEvTm2qdDKy; Wed, 25 Oct 2023 02:37:34 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id vTm1qX9zKwasUvTm1qZykW; Wed, 25 Oct 2023 02:37:33 +0000
X-Authority-Analysis: v=2.4 cv=ZpP+lv3G c=1 sm=1 tr=0 ts=65387f6d
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=_mNlVl-r0hj7kTaC:21 a=IkcTkHD0fZMA:10 a=bhdUkHdE2iEA:10 a=wYkD_t78qR0A:10
 a=yiRjFQIvNRT05BO5IWcA:9 a=QEXdDO2ut3YA:10 a=N_l3Vs37sht3-TxgB6J7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=IahuLxENwBvcQu5NawHPQqBuCWpwToxFKhWLnhbPsjA=; b=A6miGOebEelAgGO/y8Xg8CQaJ2
        encD8KXpUYQA7Y57ewp1KWNFtAjLh0IdF7vZcMJdKh0a50bWUD68yixEX90aMwNzvTsEmGz3GoxEh
        AIQcmyyGSlVF/ChA64778Ek8Oht/x9PZG/AMRI4kubCRbkcfQPCunXdX/qM6NeUaqcn5FnyOsiy42
        e3ZVgbvPm5QZ9KGnMogaJ125PG3bV3rZSPAF5VbXNGPSX5VayntbfDeCN7dUHAqbwm94mt9MismLX
        8MV0Yp01UBJoG34XnWNMIXZrJH2WiJicdU33zSLBTITiJQuEG+fPE6GOzWyOTTbBqN/JZkJAvXSTK
        EVAt/XJA==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:56754 helo=[192.168.15.10])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qvTm0-003HJe-2k;
        Tue, 24 Oct 2023 21:37:32 -0500
Message-ID: <8219c79e-0359-4136-afa4-fba76fde191a@embeddedor.com>
Date:   Tue, 24 Oct 2023 20:37:31 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC - is this a bug?] wifi: ath10k: Asking for some light on
 this, please :)
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
References: <626ae2e7-66f8-423b-b17f-e75c1a6d29b3@embeddedor.com>
 <26b15f4702cef17fe70b496a62f03735874bd16a.camel@sipsolutions.net>
 <07e9bb04-f9fc-46d5-bfb9-a00a63a707c0@embeddedor.com>
 <f8daa53ee8a8019e4fd2b823c1fcb85a6cc4d806.camel@sipsolutions.net>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <f8daa53ee8a8019e4fd2b823c1fcb85a6cc4d806.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.21.192
X-Source-L: No
X-Exim-ID: 1qvTm0-003HJe-2k
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.10]) [187.162.21.192]:56754
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfNUcfVpzHUwXmjsxhJ/nTMy+y9ciRhO8Xf/ZLlhUUUz4I2ptEupEJWzzZ8uAGr8urvONhswgais1NHzUcSOOZUARBS6HX/sHNMx89CESUuHLcDvltuxK
 B4XdHwRQJ0RTjb7WNUPhFeK9U7Wt88krjnEXzWxBb2+3kw4M7I0k7v9NNMkceIMYsGJ7c4ffPTrqFRbpI3lciGLRV8JyOfBvJ0kEohPkcYJ91uBHdYlMVnU/
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 10/24/23 14:49, Johannes Berg wrote:
> On Tue, 2023-10-24 at 14:41 -0600, Gustavo A. R. Silva wrote:
>>
>> It seems we run into the same issue in the function below, even in the
>> case this `memset()` is unnecessary (which it seems it's not):
>>
>> 	8920         memset(skb->data, 0, sizeof(*cmd));
>>
>> Notice that if `cap->peer_chan_len == 0` or `cap->peer_chan_len == 1`,
>> in the original code, we have `len == sizeof(*cmd) == 128`:
> 
> Right.
> 
>> -       /* tdls peer update cmd has place holder for one channel*/
>> -       chan_len = cap->peer_chan_len ? (cap->peer_chan_len - 1) : 0;
>> -
>> -       len = sizeof(*cmd) + chan_len * sizeof(*chan);
>> +       len = struct_size(cmd, peer_capab.peer_chan_list, cap->peer_chan_len);
>>
>>           skb = ath10k_wmi_alloc_skb(ar, len);
>>           if (!skb)
>>
>> which makes `round_len == roundup(len, 4) == struct_size(cmd,...,...) == 104`
>> when `cap->peer_chan_len == 0`
> 
> And yeah, that's really the issue, it only matters for ==0. For a moment
> there I thought that doesn't even make sense, but it looks like it never
> even becomes non-zero.
> 
> No idea then, sorry. You'd hope firmware doesn't care about the actual
> message size if the inner data says "0 entries", but who knows? And how
> many firmware versions are there? :)
> 
> So I guess you'd want to stay compatible, even if it means having a
> 
> 	chan_len = min(cap->peer_chan_len, 1);
> 
> for the struct_size()?

Yeah, that's an alternative.

I'll wait for the maintainers to chime in and see if they have a different
opinion.

Thanks
--
Gustavo
