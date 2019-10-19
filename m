Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C730DDA94
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Oct 2019 21:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbfJSTCx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 19 Oct 2019 15:02:53 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:56509 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726078AbfJSTCx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 19 Oct 2019 15:02:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571511771;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dn11RnQbQQOG+Q/OgBP8XLWxJZK3dTGJ/aBY7/8g9lQ=;
        b=CtmXUYvCt5djhIXhHnDAKCic6hnn35BA3LfLT0OXJqY0hpy/jKZtlz4U0WrflLARs9f69Y
        EKj1Y2/4lXN4jTtTWrzEqRO84fQwaDC0Mv9Vg2vdeHc9UtgbRzKYxHQJnOJbviLk9uJ8Bp
        ZpAk4KDBBpcsR1nck94a+XXbYjD18f8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-nuIselneNPKdtdqVbmW1pQ-1; Sat, 19 Oct 2019 15:02:50 -0400
Received: by mail-qk1-f197.google.com with SMTP id 11so9220523qkh.15
        for <linux-wireless@vger.kernel.org>; Sat, 19 Oct 2019 12:02:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kxEwZLybIpNz0Vb4W9kORWNZfwwCGa9psMh9sXu2bjE=;
        b=RQffL83rjcUPmUeA1DJqmQjNTZiOwJeNfl3fQu2Q9BX40+8MakSwC7jTX/sNRjK3dq
         7NBwF1zx8UpXqpmiZOSJsPQTzWjz1U5LpeJ3Xy5KnT9BLDqumqWsi9IyqDpg/Sn2Vw6G
         vVR/01MFB1O1phH6ASsiLZNQdVRAwMciP0fW5t2wrcM/0lFdVmkm2sp4dsT7qeOcNYTa
         UVAplwbd2LdRwMG0ENEvoCn+7Y8YSk7Xm5rmoJTRG5Ui5a8hLmabJTv652C6jGtN8szo
         URggWtiV/uRDeh6xUoo1cBglIihNElVlbOh9Kglpenr4jt0udFg98exEPBdsZsl1z0DC
         14vA==
X-Gm-Message-State: APjAAAU98hdTG2mzbvQ9hf35OZgm/knSoI35pYs8OowmS5mTaPjT0zel
        f8HhWQ8jBokKVNdGGHrZ3bkl4HwHjo30EoC4FkiWVVsVMV/UJyixQv5+YN7nd6vu350oyHA+vNp
        HIXTKz2DCPwFgKZH24NPFFi0lvlk=
X-Received: by 2002:ac8:22b6:: with SMTP id f51mr16039312qta.210.1571511770032;
        Sat, 19 Oct 2019 12:02:50 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxYeNR+SNTgFKYHZhJnIjW6j5UdIhrEsDzzcdKF07tcQ0YU0KGfmxdpwyCWtBWskmN+vHkcag==
X-Received: by 2002:ac8:22b6:: with SMTP id f51mr16039286qta.210.1571511769597;
        Sat, 19 Oct 2019 12:02:49 -0700 (PDT)
Received: from [192.168.1.157] (pool-96-235-39-235.pitbpa.fios.verizon.net. [96.235.39.235])
        by smtp.gmail.com with ESMTPSA id t32sm6867826qtb.64.2019.10.19.12.02.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Oct 2019 12:02:48 -0700 (PDT)
Subject: Re: [PATCH v2] rtlwifi: Fix potential overflow on P2P code
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Ping-Ke Shih <pkshih@realtek.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nicolas Waisman <nico@semmle.com>
References: <20191018114321.13131-1-labbott@redhat.com>
 <871rv9xb2l.fsf@kamboji.qca.qualcomm.com>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <51b732bf-4575-d7d1-daff-ec1c2171a303@redhat.com>
Date:   Sat, 19 Oct 2019 15:02:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <871rv9xb2l.fsf@kamboji.qca.qualcomm.com>
Content-Language: en-US
X-MC-Unique: nuIselneNPKdtdqVbmW1pQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/19/19 6:51 AM, Kalle Valo wrote:
> Laura Abbott <labbott@redhat.com> writes:
>=20
>> Nicolas Waisman noticed that even though noa_len is checked for
>> a compatible length it's still possible to overrun the buffers
>> of p2pinfo since there's no check on the upper bound of noa_num.
>> Bound noa_num against P2P_MAX_NOA_NUM.
>>
>> Reported-by: Nicolas Waisman <nico@semmle.com>
>> Signed-off-by: Laura Abbott <labbott@redhat.com>
>> ---
>> v2: Use P2P_MAX_NOA_NUM instead of erroring out.
>> ---
>>   drivers/net/wireless/realtek/rtlwifi/ps.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/net/wireless/realtek/rtlwifi/ps.c b/drivers/net/wir=
eless/realtek/rtlwifi/ps.c
>> index 70f04c2f5b17..fff8dda14023 100644
>> --- a/drivers/net/wireless/realtek/rtlwifi/ps.c
>> +++ b/drivers/net/wireless/realtek/rtlwifi/ps.c
>> @@ -754,6 +754,9 @@ static void rtl_p2p_noa_ie(struct ieee80211_hw *hw, =
void *data,
>>   =09=09=09=09return;
>>   =09=09=09} else {
>>   =09=09=09=09noa_num =3D (noa_len - 2) / 13;
>> +=09=09=09=09if (noa_num > P2P_MAX_NOA_NUM)
>> +=09=09=09=09=09noa_num =3D P2P_MAX_NOA_NUM;
>> +
>>   =09=09=09}
>>   =09=09=09noa_index =3D ie[3];
>>   =09=09=09if (rtlpriv->psc.p2p_ps_info.p2p_ps_mode =3D=3D
>> @@ -848,6 +851,9 @@ static void rtl_p2p_action_ie(struct ieee80211_hw *h=
w, void *data,
>>   =09=09=09=09return;
>>   =09=09=09} else {
>>   =09=09=09=09noa_num =3D (noa_len - 2) / 13;
>> +=09=09=09=09if (noa_num > P2P_MAX_NOA_NUM)
>> +=09=09=09=09=09noa_num =3D P2P_MAX_NOA_NUM;
>=20
> IMHO using min() would be cleaner, but I'm fine with this as well. Up to
> you.
>=20

I believe the intention is to re-write this anyway so I'd prefer to
just get this in given the uptick this issue seems to have gotten.

Thanks,
Laura

