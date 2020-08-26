Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE3625349E
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Aug 2020 18:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgHZQRT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Aug 2020 12:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726745AbgHZQRK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Aug 2020 12:17:10 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7DEDC061574
        for <linux-wireless@vger.kernel.org>; Wed, 26 Aug 2020 09:17:09 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id s13so2335056wmh.4
        for <linux-wireless@vger.kernel.org>; Wed, 26 Aug 2020 09:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XycEoPo+dLY0sc3uV4vBnOBCKEFQrB1ssK1HnRF7Sew=;
        b=Nfxcj0/Qlcapg/891M0UN42uAdjjaW9o5AVLZ1L8GvGeqH30VL7CLE08VhicRys/Sq
         8vIfsX54vnQq/j3y17fkXUc/zPRsnGNjAKxEgXq7vN5PT1pymQaHcisZOM0qwm5dDEFo
         T0coVZr/NUZ0JhZBxaR+/pyQVuUsKNZ5ESwutHQHTqOMWwMkee3hHSHbFvufArdMX2CV
         MM7pn2mjeRORHhlWCriY0WKPi9w/FxDqSeaiYubBxLc7wAzUCd94ffbe8+/BB6KLMyHS
         lt0OA7xi6KC5PN58tocdsxbah1HU6dq41N5OlFmU3eVPoLmwcbuecYRlgfxVwR5K5oq6
         WhQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XycEoPo+dLY0sc3uV4vBnOBCKEFQrB1ssK1HnRF7Sew=;
        b=BPxPm5mQTAPIfcrVAT8u82d8RHi2vGr02TsoyEV0mfVD4RTTuI7exL1WoySgRX5iiv
         GyfLfFx2W0xRv3IJEpwWEz3wRhagSXwCTAzkHYFj3ap3SuKqunCu+txbBMaCJBtNFh95
         Uoy2nDpwjIxh7av2d4relNbCv7xHEWnQixtRBGw8ZGT5M4mgpUKxrhAQf20Vtzx238+N
         y2HmiFbvbidmsbWCz4iJb+cjgdTif6vq7uoQS1qI7kr+uqbWpIaHlUfRE17RONr3/isy
         DyAdtEyJpLfJoQAUL0OtSW6JoDmAiwk09elwIjfNIR6Wmhe3oHZzBog1UGwLSpdpFC1Q
         AsuA==
X-Gm-Message-State: AOAM530NM4UChMpDQcID4JmmJ4IIWwauKNrd3JU+w4svKtb4QB7xQKW1
        Pz+T0bd/E0b0jYZtE28lSj23xw==
X-Google-Smtp-Source: ABdhPJz9Dw3kh2DpA0YSWXD5TFLHyzrnk4medUMqFBBFs01gYeA7bkE7GDRkN681BQAOHaaDG1hgUA==
X-Received: by 2002:a1c:e917:: with SMTP id q23mr7492239wmc.125.1598458628091;
        Wed, 26 Aug 2020 09:17:08 -0700 (PDT)
Received: from [192.168.0.38] ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id n124sm6540386wmn.29.2020.08.26.09.17.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2020 09:17:07 -0700 (PDT)
Subject: Re: [PATCH 00/36] wcn36xx: Add support for WCN3680 802.11ac
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        shawn.guo@linaro.org
References: <20200803031132.1427063-1-bryan.odonoghue@linaro.org>
 <87r1rt77hm.fsf@tynnyri.adurom.net>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Message-ID: <add1cb82-6dac-6424-dba8-c9cd9803f23a@linaro.org>
Date:   Wed, 26 Aug 2020 17:17:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87r1rt77hm.fsf@tynnyri.adurom.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 26/08/2020 16:27, Kalle Valo wrote:
> Bryan O'Donoghue <bryan.odonoghue@linaro.org> writes:
> 
>> This series adds support for the 802.11ac data-rates available on the WCN3680.
> 
> To review 36 patches is just too much, so I'm going to take this in
> smaller pieces.
> 
> In the future please limit the patchset size:
> 
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches#maximum_of_7-12_patches_per_patchset
> 

OK, I will break this up into groups of 8-10 patches on the rebase.

---
bod
