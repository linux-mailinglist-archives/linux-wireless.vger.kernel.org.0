Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92192B5597
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Sep 2019 20:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfIQSr4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Sep 2019 14:47:56 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:56534 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfIQSrz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Sep 2019 14:47:55 -0400
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id D955A13C2BA;
        Tue, 17 Sep 2019 11:47:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com D955A13C2BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1568746074;
        bh=2zfcXpLzYrPH6FKxSpSRRg81H8Gbxcv8HHPcDWIq7JE=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=Sm5Qh92kUnbGYZGZEVuhEVqfMXclJXly8JuIwTRKbEdHa7A1M9zi4q8ofrB6xNwzd
         qz51wDYSbp1YtwEv5FbD2mxNxNXdQFdP60+t3GaMz/OkvNgmlkY/zDmlyu02b/hbb3
         lcooHJQilJe7rgwE/th6TbBNjWidBUmg2NZYgoNU=
Subject: Re: [RFC 0/4] Allow live MAC address change
To:     Bob Marcan <bob.marcan@gmail.com>, linux-wireless@vger.kernel.org
References: <20190904191155.28056-1-prestwoj@gmail.com>
 <d776271eac8b7cd24da6dbd21fb87186b30a0e7f.camel@sipsolutions.net>
 <4c43ea6a74cacc61184bc5b1387fecaa40711369.camel@gmail.com>
 <4909a428ee6fef2bf8b0e61841bc88062f534b13.camel@sipsolutions.net>
 <896183390a396e8e0508622eceb3664effcb3c30.camel@gmail.com>
 <87a7b8lciz.fsf@tynnyri.adurom.net>
 <844f1a1dc72ec73df5a86864b410bbc490c4abdd.camel@gmail.com>
 <87imprbc0j.fsf@kamboji.qca.qualcomm.com>
 <763f4560-ba78-b0e7-6855-fd4bc048ec13@gmail.com>
 <20190917204419.41235404@smicro.local.lan>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <745d71bc-5cec-9483-b53a-5f96a3cbd4a6@candelatech.com>
Date:   Tue, 17 Sep 2019 11:47:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190917204419.41235404@smicro.local.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/17/19 11:44 AM, Bob Marcan wrote:
> On Tue, 17 Sep 2019 10:40:49 -0500
> Denis Kenzior <denkenz@gmail.com> wrote:
> 
>> Hi Kalle,
>>
>>> For user experience scanning and DHCP are also important, what kind of > numbers you get when those are included? No need to have anything> precise, I would like just to get an understanding where we are> nowadays.
>>
>> Scanning heavily depends on the RF environment and the hardware.  In our testing ath9k takes stupid long to scan for example.
>>
>> But in a sort of best case scenario, using limited scan and no mac change, iwd connects in ~300ms.  People have reported that they have not finished opening their laptop screen and they're connected, so at that level of latency, every millisecond is important and totally worth fighting for.  Randomizing the MAC would penalize our connection times by 2X (300 ms at least).  And Android folks have reported the penalty to be as high as 3 seconds.  So this needs to be fixed.  And do note that this is a feature every modern OS implements by default.
> 
> Randomizing the MAC is a stupid decision.
> Do you realy expect that this will add something to the security?

It allows one to be more anonymous.

Thanks,
Ben

> 
> B. Marčan
> 


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

