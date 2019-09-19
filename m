Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54D67B8077
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Sep 2019 19:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391133AbfISRyP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Sep 2019 13:54:15 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37395 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389717AbfISRyP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Sep 2019 13:54:15 -0400
Received: by mail-pf1-f193.google.com with SMTP id y5so2804057pfo.4
        for <linux-wireless@vger.kernel.org>; Thu, 19 Sep 2019 10:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eero.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=nKKtMJgm2T8OQpNNkegrSmUFwcFcES0Bmbw8lt6ta2E=;
        b=FvGCWlOA83AdVjinet8cdNHH9U4kf0RnYxo/mg+ua/u0voG5RDgPRApc6YFKIfMxIN
         ptPYQj1m+IUtIrUJ/JTFOgZtM/V7Xevnawc63U4byD9Khz8STqtmJkciIFtac447xhp7
         RWebBtMhKaKi8QJQX0wQLMJ4ze40ThS+joIq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=nKKtMJgm2T8OQpNNkegrSmUFwcFcES0Bmbw8lt6ta2E=;
        b=TNoAx3cvgaayamoSoJo4dInrMP8mi1fjXXoSDSRP/MZPPLauhRc1lS60/jpeI3XdDw
         ATepQoKA+smwdgd/dcfAg0Ht9lsu+k8CKXZyvukm3yhWDrgknZSrj1OQm7rDEj2k91qd
         Jxoc71Vf5MWJor1AgfWaDwulCWav2oX0dFYlz/aAAR+d9gx+aW3hiupSha/KJBSO923Y
         8M1ApLbplf+E46YjZK59ez8NKq3b4Chd6EU2dIoXoOQ3a3rZp9Ar95sPXNFXX9xM/hYi
         E9qLWOrl1+ZtaH3hHqljyUA3oboswIybn9sDtJlzmy3nUoV2IIcCv0Ow35hHDfkmX0YO
         ck7Q==
X-Gm-Message-State: APjAAAXKPZ/YAThxsy5lvXuJm7HNEJvCpvdbuWX0PNCIJC3ETboVsWEi
        h7WpH/Y2SAjRWCCzzoWWQm5LLg==
X-Google-Smtp-Source: APXvYqzZ5LcSkpUvblvaEwlV81X52GwDdgv95K7Lw8XdTpYQYq1oEkyuoiCYd3xViJ5enTl1fnZQ4w==
X-Received: by 2002:a63:4562:: with SMTP id u34mr10150235pgk.288.1568915654364;
        Thu, 19 Sep 2019 10:54:14 -0700 (PDT)
Received: from [10.0.2.15] (eero.static.monkeybrains.net. [199.116.72.162])
        by smtp.gmail.com with ESMTPSA id c14sm13534604pfm.179.2019.09.19.10.54.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Sep 2019 10:54:13 -0700 (PDT)
Subject: Re: [PATCH RFC/RFT 4/4] mac80211: Apply Airtime-based Queue Limit
 (AQL) on packet dequeue
To:     Ben Greear <greearb@candelatech.com>,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net,
        John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>
References: <156889576422.191202.5906619710809654631.stgit@alrua-x1>
 <156889576869.191202.510507546538322707.stgit@alrua-x1>
 <f21b10fd-02ae-af59-8e2f-88f654627ab3@eero.com>
 <879913e9-4254-1381-07f6-d860fb0b8de0@candelatech.com>
From:   Peter Oh <peter.oh@eero.com>
Message-ID: <f9b224a0-305f-9715-f627-7a5fae0988d3@eero.com>
Date:   Thu, 19 Sep 2019 10:54:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <879913e9-4254-1381-07f6-d860fb0b8de0@candelatech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 9/19/19 10:46 AM, Ben Greear wrote:
> On 9/19/19 10:44 AM, Peter Oh wrote:
>> On 9/19/19 5:22 AM, Toke Høiland-Jørgensen wrote:
>>> From: Toke Høiland-Jørgensen <toke@redhat.com>
>>>
>>> This patch ports that idea over to mac80211. The basic idea is simple
>>> enough: Whenever we dequeue a packet from the TXQs and send it to the
>>> driver, we estimate its airtime usage, based on the last recorded TX 
>>> rate
>>> of the station that packet is destined for.
>>
>> The way to decide the last recorded TX rate could be vary among 
>> drivers. In terms of ath10k driver and FW, they use 4 PPDUs to update 
>> the Tx rate. Isn't it too small sampling number to be used for AQL?
>
> Probably it is not exactly the last 4 either, since the report comes 
> back indirectly and not
> synchronized with the tx path?
>
The point of my question is "the last recorded Tx raith small nte is 
derived wumber of PPDUs and if it's ok to use it for AQL calculation or 
not".

Thanks,

Peter

