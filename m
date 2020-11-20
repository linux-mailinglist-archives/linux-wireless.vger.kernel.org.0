Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F40362BA9A7
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Nov 2020 12:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbgKTL5N (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Nov 2020 06:57:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727933AbgKTL5N (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Nov 2020 06:57:13 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298DAC0613CF
        for <linux-wireless@vger.kernel.org>; Fri, 20 Nov 2020 03:57:13 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id j7so9791139wrp.3
        for <linux-wireless@vger.kernel.org>; Fri, 20 Nov 2020 03:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tmaJye+YtnExaj+tPRNAkavNWRxucz6CvyQWaoDrKoM=;
        b=m41I3BGMuQfBgBwmyrfHvkv8kUS6U2UqbMh9k/fDPwntaTHKlAV7KqDCjeIunfXgX/
         Lz7G3ul6fy171rw8F7su+YTKL1A7dlSehVByW7PKllPl4dN6K1KKswf+Z1Klqxu8z14l
         yiAygNNuihC+eTm9O+ewpWRvf+45wtOzuj0llk6jFt9DNTD8CmOyGTpm5LZwHN0vYHMp
         E1hYUG3bYJZVZMKl/6fSo7wO7Aivm5PJGIka071Qwy+f1n0OA38Hadeqbu9XUkiYP9Tq
         qd1ITm5/BhjXI2DFQYPUxWxq9hoBpodfFWL/qAgE0Uc6eC8frIgwyazXWamJXWPOwBVZ
         8JLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tmaJye+YtnExaj+tPRNAkavNWRxucz6CvyQWaoDrKoM=;
        b=tSqoKusLXqHqUZ4QSJopr+apfWTTRW9Dklkw9a0gyGBKEf1GzCaULjfDIjLEyFtdtE
         IPxEiIsoTRLOg4CtQ5Ix8uPvwewmJ2kZ6iaC+LgBkdQPSv7dSNMmLLulAvrsVD/lKHjx
         FJf8kYIoln+KJTItewdD1a5zr98Sg81YeL41Gt6Ppy82ba0ybBNSQYYRGngFTBLO+1RB
         hP3hmX6eJRbEW3wBMqFzBbFjlrGxtWI4FgTnV1E+8B0AqihQrGv4kpjufTP6m2MUSQ37
         hR2xAk23asRoKBwuzDc0zy0N6Vs0dVhH2QwAPNM9TrU74ORT3Qf1itqmQXBQDLeQ7/94
         I0vw==
X-Gm-Message-State: AOAM531qhh7QDht4kj1yvTW7en2mMbKhUvcF1v29T1DY+A0qvoZtdzYk
        CwrWrhjj/yW2X/ZmKsM6LsCVciwMq5cYmg==
X-Google-Smtp-Source: ABdhPJwnmKe44C3cwxcvBafAIOJurpNh6/3o+O9dvJIZtvcPqbSyoHhTDa82NEjljQ6fJl6nZ6ulcg==
X-Received: by 2002:adf:e787:: with SMTP id n7mr16807788wrm.153.1605873431943;
        Fri, 20 Nov 2020 03:57:11 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id g4sm4846907wrp.0.2020.11.20.03.57.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2020 03:57:11 -0800 (PST)
Subject: Re: [PATCH] wcn36xx: Send NULL data packet when exiting BMPS
To:     Loic Poulain <loic.poulain@linaro.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>,
        Benjamin Li <benl@squareup.com>
References: <20201120021403.2646574-1-bryan.odonoghue@linaro.org>
 <20201120021403.2646574-2-bryan.odonoghue@linaro.org>
 <CAMZdPi-HeeLauPSLrWnt4ricaP=d55LY960gYpS0FXVi=zsAVw@mail.gmail.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Message-ID: <96ef1fe5-6fb9-99c1-91c2-a0d7fb9d9246@linaro.org>
Date:   Fri, 20 Nov 2020 11:58:12 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAMZdPi-HeeLauPSLrWnt4ricaP=d55LY960gYpS0FXVi=zsAVw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 20/11/2020 08:15, Loic Poulain wrote:
> On Fri, 20 Nov 2020 at 03:13, Bryan O'Donoghue
> <bryan.odonoghue@linaro.org> wrote:
>>
>> This commit updates the BMPS exit path to be consistent with downstream in
>> terms of exiting BMPS mode. Downstream sets the flag to send a NULL data
>> frame to the host on exiting BMPS.
>>
>> This will tell the AP to send any queued frames to the STA immediately.
>> Verified the relevant bit toggle in wireshark.
>>
>> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>> ---
>>   drivers/net/wireless/ath/wcn36xx/smd.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
>> index 8ff1eda8f942..acf533fae46a 100644
>> --- a/drivers/net/wireless/ath/wcn36xx/smd.c
>> +++ b/drivers/net/wireless/ath/wcn36xx/smd.c
>> @@ -2176,6 +2176,7 @@ int wcn36xx_smd_exit_bmps(struct wcn36xx *wcn, struct ieee80211_vif *vif)
>>          INIT_HAL_MSG(msg_body, WCN36XX_HAL_EXIT_BMPS_REQ);
>>
>>          msg_body.bss_index = vif_priv->bss_index;
>> +       msg_body.send_data_null = 1;
> 
> I'm quite sure I've seen null data packet wakeup (PS=0) when sniffing
> wcn3620, but maybe it was submitted by mac80211, have you then checked
> you do not end with double null packets with that patch (one from
> firmware and one from mac layer)?

Just did.

Definitely not double nulling
