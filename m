Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAC3B6C668D
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Mar 2023 12:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjCWL3L (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Mar 2023 07:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjCWL3K (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Mar 2023 07:29:10 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322111B325
        for <linux-wireless@vger.kernel.org>; Thu, 23 Mar 2023 04:29:07 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id cn12so39307323edb.4
        for <linux-wireless@vger.kernel.org>; Thu, 23 Mar 2023 04:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679570945;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xRoBzr3Ian/N+F11piGyE0HzKv89Ema2vwaYG2HlEqk=;
        b=XQfpi4YkQUQFqksp1Xret8mnJbjtIg+q1tzCpHhfsAqzBq4fxGiTBqjDJVTG7SVVSi
         tcyHdpeKPtluHUNQTkL+d9AlQZ2MZZDNfnMmd8RT0ISkMOG69ObiLk7f3+U+d6qcLmLn
         xN09UwJ/6ECccIb22145Opk35NdXFcSTkAxUFFkUOQQC5lZNVMTCiYkZSIeZfUqDEfde
         t1/pggBXvs5bpQd4uMiAe5UvhV64UySrsd28M8tbsCgvV7ZaNtLqxjtLaRNcXJU6KFfr
         ZDRhb7JgTPHTZQpAMSGXvL9bmzA3rIxI95vuh0jvPFCJMNi/BPfeFTWqRn1+DmsMP+ik
         rGkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679570945;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xRoBzr3Ian/N+F11piGyE0HzKv89Ema2vwaYG2HlEqk=;
        b=cThO+zWggpLdoX2j4G5gQnQiXlM3wPoq3M7UslM1JfiznJuBS4Em1BU3RDFqpKg+qL
         asbSPau1kKfdTVIeNeOmWo7AbsLoFZxmItuxpm4n7NxOAzLeqG/qRxS04M7tgnZOYESV
         coRfMWKjafJrpNZG7xt1eDfrE7Mk1vrYGmYIuqqSu6DRQQiPa0rbe4oA/Ds8r19eIgw/
         Ctq3NTMbBOXNb1WdcMu9aathd0I9MxT5dFYRa1NidBzsiTMevwNKtqTiMJYGgBQlsW/M
         xVpHvsDqeGRtlHb3RBckIwWjZnHj54QdczOBPK2B9malY/dKj43D6M1LqyMLvzopaNap
         0g4Q==
X-Gm-Message-State: AO0yUKXS26/uXixE2oMESazlGwgGZWV3cZgQrxUrVUxDNf5SflU8zzQq
        Ys1vSVnFsJVgKy0GvCF7jq9UoJ8LlVnSksqGC+0=
X-Google-Smtp-Source: AK7set/t8cSplE6nQRaGMMGWIPq8vKdeJEohyihPsgBRKJQcvjXxNrDXGRMU/9Kr6G/pziM40aRaNw==
X-Received: by 2002:aa7:de82:0:b0:4fa:e187:64d1 with SMTP id j2-20020aa7de82000000b004fae18764d1mr8502409edv.38.1679570945736;
        Thu, 23 Mar 2023 04:29:05 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:a665:ed1e:3966:c991? ([2a02:810d:15c0:828:a665:ed1e:3966:c991])
        by smtp.gmail.com with ESMTPSA id u17-20020a170906409100b009338ad391b9sm6103635ejj.213.2023.03.23.04.29.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 04:29:05 -0700 (PDT)
Message-ID: <1b105e1a-580c-6f75-731e-4823eba4073d@linaro.org>
Date:   Thu, 23 Mar 2023 12:29:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: Status of linux-nfc@lists.01.org mailing list
Content-Language: en-US
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Bongsu Jeon <bongsu.jeon@samsung.com>,
        Mark Greer <mgreer@animalcreek.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
References: <CAKXUXMzggxQ43DUZZRkPMGdo5WkzgA=i14ySJUFw4kZfE5ZaZA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAKXUXMzggxQ43DUZZRkPMGdo5WkzgA=i14ySJUFw4kZfE5ZaZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 23/03/2023 12:18, Lukas Bulwahn wrote:
> Dear Krzysztof, dear Bongsu, dear Mark,
> 
> According to MAINTAINERS, you are all maintainers of some section that
> asks to send patches to the linux-nfc@lists.01.org mailing list.
> Recently I sent a patch mail to the linux-nfc@lists.01.org and I am
> getting the response that the mail is not delivered to that list.
> 
> A quick ping from my local machine seems also to suggest the server is
> not available anymore:
> 
> PING lists.01.org(ml01.01.org (2001:19d0:306:5::1)) 56 data bytes
> From 2001:19d0:300:1::14 icmp_seq=1 Destination unreachable: Address unreachable
> 
> Are you aware of some temporary transition of the email server? Is
> there a plan to set up a new mailing list at another domain? Is this
> mailing list obsolete and should we just delete the references in
> MAINTAINERS to that mailing list?

I am not a maintainer of this mailing list. I did not get any
notifications from 01.org that they are shutting down their lists. Maybe
we should just drop it.

+Cc net folks

Best regards,
Krzysztof

