Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD67131183
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jan 2020 12:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgAFLmO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Jan 2020 06:42:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26305 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726296AbgAFLmO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Jan 2020 06:42:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578310933;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TNqdhqczgGxdK5AdjOJfUfkF3f4OWqEVU8tl4ZyprUA=;
        b=MvABnr/ArXBF9JURHTQvofftR+U8x4B3tMtFammhMovniylVCFfgsrxJqSK8s6SkAoNfHu
        U9qcbqyCClYGXSOMQrOFS6zbCM0bB6OvniKPw82YBT/QBAqqbcPZlrj2tcVaWq9i3wGyl/
        RB/DS0umaOy2XRV3IoOPVn2HkOBkRCE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-4fjAnKbgPO6v02ABuawmAg-1; Mon, 06 Jan 2020 06:42:12 -0500
X-MC-Unique: 4fjAnKbgPO6v02ABuawmAg-1
Received: by mail-wr1-f72.google.com with SMTP id j13so12822423wrr.20
        for <linux-wireless@vger.kernel.org>; Mon, 06 Jan 2020 03:42:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=TNqdhqczgGxdK5AdjOJfUfkF3f4OWqEVU8tl4ZyprUA=;
        b=EmGo9HYWSNqOXLao7VecFlszUKZ4zx20mMNEFXCmfRqrrQKIRtM0Bnh/wgvcdtXuQw
         lZGFJu+nhZRb5Lz/fGoXxMeBza2UWzfBKe9Q3IiyJhSmATpb8qxtsCHEAFS900Ii9yaf
         zPVcsOSULs7Uo6r178Cd8nn4A5zso9nrCHa9G65ZrRELNg4+d5hos2lgunnheC7At3OZ
         bWmbwA6yeGfEqZPZZdtX+u4f/bzABUsE5/d92CVwdP4ISWsen+RStNlfWHLGyGoe7OLU
         yJwCQZ8yDDBLeJdulVDIJ0p7zTmqB/RgNfhg4SMV4novX7qV1n0xYJdvaTZ2CCO3zI6/
         vCAA==
X-Gm-Message-State: APjAAAVJz2O7u05Mi5ZNlTmq6owlEzyq2F0tyyhWA6wNYnMokEucptH6
        9IFKF6cRkR1bFb2cyr/3ASg+rgjX1gvcCAjVlchLHlgVVJRq/n7qSp4ddyq3rNKoyxcizT357y6
        dCTPafKt4AvEovGjHM2ngioDL8cw=
X-Received: by 2002:a1c:9a44:: with SMTP id c65mr35846639wme.30.1578310931285;
        Mon, 06 Jan 2020 03:42:11 -0800 (PST)
X-Google-Smtp-Source: APXvYqxFqj5hbTmw5TNCiaFK0bcZ9ys0kpODCGKf2BRFw7C+DJBPxTlQ/OGlH4m6didvNL8jYT5x8Q==
X-Received: by 2002:a1c:9a44:: with SMTP id c65mr35846622wme.30.1578310931078;
        Mon, 06 Jan 2020 03:42:11 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id c17sm73314622wrr.87.2020.01.06.03.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 03:42:10 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id F1609180ADB; Mon,  6 Jan 2020 12:42:09 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Markus Theil <markus.theil@tu-ilmenau.de>,
        johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH] iw: info: print missing extended feature flag information
In-Reply-To: <0e8cd8ee-e9c3-2b0a-bdce-f831367734a1@tu-ilmenau.de>
References: <20200101174836.5513-1-markus.theil@tu-ilmenau.de> <8736csltrb.fsf@toke.dk> <0e8cd8ee-e9c3-2b0a-bdce-f831367734a1@tu-ilmenau.de>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 06 Jan 2020 12:42:09 +0100
Message-ID: <87zhf0ke0e.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Markus Theil <markus.theil@tu-ilmenau.de> writes:

> On 1/6/20 12:16 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Markus Theil <markus.theil@tu-ilmenau.de> writes:
>>
>>> Some extended feature flags were not considered before.
>>>
>>> Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
>>> ---
>>>  info.c | 10 ++++++++++
>>>  1 file changed, 10 insertions(+)
>>>
>>> diff --git a/info.c b/info.c
>>> index 38362d8..0f24dae 100644
>>> --- a/info.c
>>> +++ b/info.c
>>> @@ -676,7 +676,17 @@ broken_combination:
>>>  		ext_feat_print(tb, DFS_OFFLOAD, "DFS offload");
>>>  		ext_feat_print(tb, CONTROL_PORT_OVER_NL80211,
>>>  			       "control port over nl80211");
>>> +		ext_feat_print(tb, ACK_SIGNAL_SUPPORT,
>>> +			       "ack signal level support");
>>>  		ext_feat_print(tb, TXQS, "FQ-CoDel-enabled intermediate TXQs");
>>> +		ext_feat_print(tb, SCAN_RANDOM_SN,
>>> +			       "use random sequence numbers in scans");
>>> +		ext_feat_print(tb, SCAN_MIN_PREQ_CONTENT,
>>> +			       "use probe request with only rate IEs in scans");
>>> +		ext_feat_print(tb, CAN_REPLACE_PTK0,
>>> +			       "can safely replace PTK 0 when rekeying");
>>> +		ext_feat_print(tb, ENABLE_FTM_RESPONDER,
>>> +			       "enable FTM (Fine Time Measurement) responder");
>>>  		ext_feat_print(tb, AIRTIME_FAIRNESS,
>>>  			       "airtime fairness scheduling");
>> I would prefer to keep TXQS and AIRTIME_FAIRNESS next to each other.
>>
>> Also, while you're at it, could you please add the newly-added AQL
>> feature? Something like
>>
>>   		ext_feat_print(tb, AIRTIME_FAIRNESS,
>>   			       "airtime fairness scheduling");
>>  +		ext_feat_print(tb, AQL,
>>  +			       "Airtime Queue Limits (AQL)");
> I'm currently working on some other small patches and will include this
> and reorder the flags such that TXQS and AIRTIME_FAIRNESS will be next
> to each other.
> Thanks for the hint!

Great, thanks! :)

-Toke

