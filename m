Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8849C31B590
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Feb 2021 08:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbhBOHUv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Feb 2021 02:20:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbhBOHUs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Feb 2021 02:20:48 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149D5C061574
        for <linux-wireless@vger.kernel.org>; Sun, 14 Feb 2021 23:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:Subject:From:References:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=uttLwWuSKAqGmbfmcvZb7Xj5OnW1tzniTaKrD4MqBWU=; b=CZS3c1RDs/hB+KNA/xKBiH7ub/
        6bE7KOuN5tYNzJOZXtlfkQKcU6FnFmA1JTNLpPeXAoYipS6xD4WgIUiDXq7AK6hxpBfOymLwXU0oF
        uQvedDGybKvcdk12q9zC6GOhdM9Qlbwsi4XY6b4/3YtBHZZ6xzTCenS4gtkhOhmrknPY=;
Received: from p4ff13c8d.dip0.t-ipconnect.de ([79.241.60.141] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1lBYAv-0000nV-1Q; Mon, 15 Feb 2021 08:20:05 +0100
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, hurricos@gmail.com
References: <20210214184911.96702-1-nbd@nbd.name>
 <8735xyrkvy.fsf@codeaurora.org>
From:   Felix Fietkau <nbd@nbd.name>
Subject: Re: [PATCH] ath9k: fix transmitting to stations in dynamic SMPS mode
Message-ID: <d668f30a-f911-921f-d329-f6ac872d0bcc@nbd.name>
Date:   Mon, 15 Feb 2021 08:20:04 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <8735xyrkvy.fsf@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 2021-02-15 05:54, Kalle Valo wrote:
> Felix Fietkau <nbd@nbd.name> writes:
> 
>> When transmitting to a receiver in dynamic SMPS mode, all transmissions that
>> use multiple spatial streams need to be sent using CTS-to-self or RTS/CTS to
>> give the receiver's extra chains some time to wake up.
>> This fixes the tx rate getting stuck at <= MCS7 for some clients, especially
>> Intel ones, which make aggressive use of SMPS.
>>
>> Cc: stable@vger.kernel.org
>> Reported-by: Martin Kennedy <hurricos@gmail.com>
>> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> 
> No Fixes tag so I assume this is not a regression?
> 
> Should this go to v5.12 or -next? I guess that depends how much testing
> this patch has got.
I'd prefer v5.12. I got confirmation that the patch makes a big
difference in throughput with Intel clients (makes tx with MCS > 7
work), and I think there is very little potential for regressions.

- Felix
