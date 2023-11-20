Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBAAB7F1339
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Nov 2023 13:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233232AbjKTM1v (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Nov 2023 07:27:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232607AbjKTM1v (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Nov 2023 07:27:51 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19BCE5
        for <linux-wireless@vger.kernel.org>; Mon, 20 Nov 2023 04:27:46 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-778940531dbso275964285a.0
        for <linux-wireless@vger.kernel.org>; Mon, 20 Nov 2023 04:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700483266; x=1701088066; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IvzJUnFYD87lMKX7ZfI614acA27mho8juoGTE8Crpj4=;
        b=ItPFJrfIMdDCFLOOaE+vLMGSNnNeE0d7i9VGo52t8NeU2qhzFquG9CiUht1bxOq+by
         HUxtH+6TpXmLpIOytA5NH/nlxjEWsBMGeejkYnfXkvLUQbPpTstWwmnO+CXY7k3QCrN3
         MDbsn38UgclKlrz0klXrLnN61dUWlIVe3HRdo9DSBBrC++QlwrjiQk/ElFbfiC9lhM1W
         aSfoOogTgrrbYT8WKejcVvdqTXYgIT773lp3mMJheWOafXj6wE+ILA6hTV4JwtPfjseC
         0qXHNe81g7dgiZ1KSSEbp+B/+TStumR6iwLq4349cG2MdTx87KONEXXXvUa+V2i8KYAh
         14kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700483266; x=1701088066;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IvzJUnFYD87lMKX7ZfI614acA27mho8juoGTE8Crpj4=;
        b=aGrV2A2vkrE4P16RWf4ybNPLO2pDQ29rrSwOWyhDv6rpvJc3LAH73YXNmBQOOMtAJf
         Tk8fzBsSjzUxwXrzP/maq7a0m/uPRvZz620HLx29olo6w6/gkxAcuq2/rXUF3USsHE4q
         mt0x7hU/Rz8UZG7xBXulviwql1rIAHa/KOnGGRZtqujILcSA2hX0VOe4RUeqo4zQ0mj4
         haF6YbyEh05NYlAOMegr8HEhKodwHXnDrtssQqPvSDgUR5tZoNHqWJ4x0Zn/EC4/2NEG
         4JQA8KhAeS+W6IyOgrDZ+FJbh2h9KCFog4xffWPPd0BbJoscZfMb9GsxCy2yTwTq6x5H
         3gvA==
X-Gm-Message-State: AOJu0YzQXw6lxPeMPNuKfGHSV7pjIW0cTeFitbIZvyaZd8gid61BwcMA
        xZqcDGOHl78eveS29JzxDCLzFuM1OvU=
X-Google-Smtp-Source: AGHT+IGWyjHqTqvBY6AvrAphkxBgCpkIpxEkM6WASvL/biWvECCDgzaOIMx8COdqRVgk/TRqkENFsg==
X-Received: by 2002:ad4:5f89:0:b0:679:d3eb:1469 with SMTP id jp9-20020ad45f89000000b00679d3eb1469mr5058619qvb.49.1700483265914;
        Mon, 20 Nov 2023 04:27:45 -0800 (PST)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id kh13-20020a056214514d00b00679df2f6d11sm496507qvb.59.2023.11.20.04.27.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 04:27:45 -0800 (PST)
Message-ID: <0f79edbc-c727-44b6-8b9e-493026313b83@gmail.com>
Date:   Mon, 20 Nov 2023 04:27:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] wifi: ath11k: use select for CRYPTO_MICHAEL_MIC
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     linux-wireless@vger.kernel.org
References: <20231113153544.282461-1-prestwoj@gmail.com>
 <343af05d-eab9-4411-a016-8d7d96f78379@quicinc.com>
 <87pm04947x.fsf@kernel.org>
From:   James Prestwood <prestwoj@gmail.com>
In-Reply-To: <87pm04947x.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/20/23 01:14, Kalle Valo wrote:
> Jeff Johnson <quic_jjohnson@quicinc.com> writes:
>
>> On 11/13/2023 7:35 AM, James Prestwood wrote:
>>> Let ath11k select this option automatically which makes building
>>> more intuitive if the user enables this driver (rather than the
>>> driver not building unless CRYPTO_MICAEL_MIC is explicitly enabled)
>> s/MICAEL/MICHAEL/
>>
>> add hard stop
>>
>> Also suggest you include (or summarize) the information that Kalle
>> shared that ath is the outlier here:
>>
>> Further investigation shows that ath11k and ath12k are the only who use
>> 'depends on' with CRYPTO_MICHAEL_MIC:
>>
>> ./drivers/net/wireless/intel/ipw2x00/Kconfig:	select CRYPTO_MICHAEL_MIC
>> ./drivers/net/wireless/intersil/hostap/Kconfig:	select CRYPTO_MICHAEL_MIC
>> ./drivers/net/wireless/intersil/orinoco/Kconfig:	select CRYPTO_MICHAEL_MIC
>> ./drivers/net/wireless/ath/ath11k/Kconfig:	depends on CRYPTO_MICHAEL_MIC
>> ./drivers/net/wireless/ath/ath12k/Kconfig:	depends on CRYPTO_MICHAEL_MIC
>> ./drivers/staging/rtl8192e/Kconfig:	select CRYPTO_MICHAEL_MIC
>> ./drivers/staging/ks7010/Kconfig:	select CRYPTO_MICHAEL_MIC
>>
>> consider these comments apply to ath12k change as well :)
> BTW I can add these changes in the pending branch, no need to resend
> because of this.

Works for me. Had a few things come up and hadn't circled back here yet.

Thanks,

James

