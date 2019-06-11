Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 284FE3CD56
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2019 15:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390582AbfFKNtA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Jun 2019 09:49:00 -0400
Received: from mail.neratec.com ([46.140.151.2]:34027 "EHLO mail.neratec.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387866AbfFKNtA (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Jun 2019 09:49:00 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.neratec.com (Postfix) with ESMTP id A6CA5CE0392;
        Tue, 11 Jun 2019 15:48:58 +0200 (CEST)
Received: from mail.neratec.com ([127.0.0.1])
        by localhost (mail.neratec.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id E9IuFc_Ng8ht; Tue, 11 Jun 2019 15:48:58 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.neratec.com (Postfix) with ESMTP id 837E7CE0395;
        Tue, 11 Jun 2019 15:48:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.neratec.com 837E7CE0395
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=neratec.com;
        s=9F5C293A-195B-11E9-BBA5-B4F3B9D999CA; t=1560260938;
        bh=2ZnbpGhkbUkTw/gTpY2/UiYtzqcC8WJxOnjsgjEWBwk=;
        h=To:From:Message-ID:Date:MIME-Version;
        b=V379okPJV8+ep5hiHdTNfwjWyYITRH2TIYRPqcKVgsXpD+hHxi1sgTI8jmh7nIw8s
         ybVCulJpdiBt6wTxwwPcgyuXlx0RF25VZO7K+u7UBDnV0ANgCwQ8JI+Bi9PScoVns0
         boFEDe5Ni09rtmG6o4ofMQ73EMkh/2ZOU4owxY0ze0YhNXDi+Q+9yFSnpIc2hNTGb6
         kCxoCc8QGSBF3WIXF0hCgpe5Ufci7iOiuU9lRgTWL2/4LpJXyLevpPycbnDHJ3UFwI
         5JY+UT4xwC0z2FautSk0HxVj1Jbi0yVgL28pHuG9KUzC/3hFql3zS8qhIJspyccIS2
         Y+uTTsxkQQCNw==
X-Virus-Scanned: amavisd-new at neratec.com
Received: from mail.neratec.com ([127.0.0.1])
        by localhost (mail.neratec.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Zap_hYuaALy3; Tue, 11 Jun 2019 15:48:58 +0200 (CEST)
Received: from [172.29.80.18] (dynvpn-018.vpn.neratec.com [172.29.80.18])
        by mail.neratec.com (Postfix) with ESMTPSA id 56406CE0392;
        Tue, 11 Jun 2019 15:48:58 +0200 (CEST)
Subject: Re: [PATCH v2] ath9k: correctly handle short radar pulses (fixes
 3c0efb745a)
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, nbd@nbd.name
References: <20190611131006.29715-1-zefir.kurtisi@neratec.com>
 <20190611133656.16964-1-zefir.kurtisi@neratec.com>
 <87h88wgrui.fsf@kamboji.qca.qualcomm.com>
From:   Zefir Kurtisi <zefir.kurtisi@neratec.com>
Message-ID: <f3ec61f2-2b63-4d20-b9f4-d85cc2d44073@neratec.com>
Date:   Tue, 11 Jun 2019 15:48:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <87h88wgrui.fsf@kamboji.qca.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 6/11/19 3:43 PM, Kalle Valo wrote:
> Zefir Kurtisi <zefir.kurtisi@neratec.com> writes:
> 
>> Changes to v1:
>> * typos fixed in commit-message
>> --
>>
>> In commit '3c0efb745a17 ("ath9k: discard undersized packets")'
>> the lower bound of RX packets was set to 10 (min ACK size) to
>> filter those that would otherwise be treated as invalid at
>> mac80211.
>>
>> Alas, short radar pulses are reported as PHY_ERROR frames
>> with length set to 3. Therefore their detection stopped
>> working after that commit.
>>
>> NOTE: ath9k drivers built thereafter will not pass DFS
>> certification.
>>
>> This extends the criteria for short packets to explicitly
>> handle PHY_ERROR frames.
>>
>> Signed-off-by: Zefir Kurtisi <zefir.kurtisi@neratec.com>
> 
> Forgot to mention that the Fixes line should be before s-o-b, not in the
> title:
> 
> Fixes: 3c0efb745a17 ("ath9k: discard undersized packets")
> 
> I'll fix (no pun intended) that as well.
> 
Thanks. Was unsure about that, checkpatch warned about format (mandatory 12 digit
hash), but not the proper location. Will keep in mind.
