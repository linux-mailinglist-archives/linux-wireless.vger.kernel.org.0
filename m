Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC1E4DB36D
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Mar 2022 15:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356861AbiCPOjs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Mar 2022 10:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356837AbiCPOjf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Mar 2022 10:39:35 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B102733A30
        for <linux-wireless@vger.kernel.org>; Wed, 16 Mar 2022 07:38:10 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a8so4620985ejc.8
        for <linux-wireless@vger.kernel.org>; Wed, 16 Mar 2022 07:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=4iSmUHIOPBD0fcLO6IuI2tphiUvxfBd0934UBJsqoj0=;
        b=SwyIemCt+49VWK90LkHY/jN8LhiJsB70Ne0K9hsJdsG692mjTytfibNIamFhHI6BII
         u9l4vcTqkqU7le5pvu8poS6oQ1+BakgtEMGRxXnq+39eJgeKP0UV7sUWuVuJAv2jG7hx
         pwIVaEqk6X3CUj5ZJoZsTtMgGyN/zKRzVCuBlVCbcsLYZRBxUwgXIcxUpgxGxrpXiCLb
         GG5taT1LUU8xmVG0XLA517+4s63vmMNyRX3SwdMf9UPXwtYPL722BDNCE8N7CjNSLl5U
         TnXfh5a8BzXxkYwOTJVwMrIbPWIZRb5AutYbEY/t/vpOmo7x4krpt5PsgYklhas7JNta
         YnEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4iSmUHIOPBD0fcLO6IuI2tphiUvxfBd0934UBJsqoj0=;
        b=agncEs8ecqU92J0CFa8SbnxW28cx+eo8hkpTHYGbIg9MAZRgplUqB15+sBnUsXyk8S
         +N5DZS5vCfXYjxVcvA/2pkJNc/a0QXQNKYDFRoZ6JKxQw261K9rV1xJCwUXehSiFvu0O
         ubDJsjRPgtrzRNeryUqyt/hXZW1ZDRAwvo+ToAhhR8Ah5Sgb1DQISrZ85L3LWV1Reo4S
         6GCs8ljb0XOMB3i0vsibh1uyzSQOzCrwgobtBiPee8hPbs2Io0bWiR3aRCYrCEgcPW+d
         YDzDO5AGdcDN1X6EzigeiBFzvfjfxAttPO6I/Z84FwR5WUHq+iYJdQNqazOrqg8kRkIf
         yhjA==
X-Gm-Message-State: AOAM533fB0WMJk2/iV8ZDV5hQ8fa3JfBREKJ3QQ4YwVF/NscSruO5n6w
        qlV8IHxilaWo5xXHVbcrDzPVPTax2lw+iQ==
X-Google-Smtp-Source: ABdhPJw5SlJp0/OYIZ6AN5dcFyugvC61um588FYH+ineRhV1j0gOS+CdDslhRiQfR7WVqKBbzQppgA==
X-Received: by 2002:a17:907:2d2a:b0:6db:7298:8d4c with SMTP id gs42-20020a1709072d2a00b006db72988d4cmr199112ejc.679.1647441488760;
        Wed, 16 Mar 2022 07:38:08 -0700 (PDT)
Received: from ?IPV6:2a02:1811:cc83:eef0:7bf1:a0f8:a9aa:ac98? (ptr-dtfv0pmq82wc9dcpm6w.18120a2.ip6.access.telenet.be. [2a02:1811:cc83:eef0:7bf1:a0f8:a9aa:ac98])
        by smtp.gmail.com with ESMTPSA id m14-20020a17090677ce00b006dbf0aaf4a6sm1015970ejn.56.2022.03.16.07.38.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Mar 2022 07:38:08 -0700 (PDT)
Message-ID: <10c35486-55f4-f907-cbe3-c1a33a0710aa@gmail.com>
Date:   Wed, 16 Mar 2022 15:38:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] ath11k: acquire ab->base_lock in unassign when finding
 the peer by addr
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Carl Huang <cjhuang@codeaurora.org>
References: <20220314215253.92658-1-dossche.niels@gmail.com>
 <87o826pgqr.fsf@kernel.org> <c0874b06-116d-7471-3b50-21099c729c3d@gmail.com>
 <87k0cuotjo.fsf@kernel.org>
From:   Niels Dossche <dossche.niels@gmail.com>
In-Reply-To: <87k0cuotjo.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 16/03/2022 15:34, Kalle Valo wrote:
> Niels Dossche <dossche.niels@gmail.com> writes:
> 
>> On 3/16/22 07:13, Kalle Valo wrote:
>>> Niels Dossche <dossche.niels@gmail.com> writes:
>>>
>>>> ath11k_peer_find_by_addr states via lockdep that ab->base_lock must be
>>>> held when calling that function in order to protect the list. All
>>>> callers except ath11k_mac_op_unassign_vif_chanctx have that lock
>>>> acquired when calling ath11k_peer_find_by_addr. That lock is also not
>>>> transitively held by a path towards ath11k_mac_op_unassign_vif_chanctx.
>>>> The solution is to acquire the lock when calling
>>>> ath11k_peer_find_by_addr inside ath11k_mac_op_unassign_vif_chanctx.
>>>>
>>>> Fixes: 701e48a43e15 ("ath11k: add packet log support for QCA6390")
>>>> Signed-off-by: Niels Dossche <dossche.niels@gmail.com>
>>>
>>> On what hardware and firmware version did you test this?
>>>
>>
>> Thanks for your reply.
>> I am currently working on a static analyser to detect missing locks.
>> This was a reported case. I manually verified the report by looking
>> at the code, so that I do not send wrong information or patches.
>> After concluding that this seems to be a true positive, I created this patch.
>> However, as I do not in fact have this particular hardware, I was unable to test it.
> 
> Ah, I didn't realise this. If you are using a tool to find errors in the
> code it's always a good idea to document that in the commit log. I'll
> add an edited version of what wrote you above in the commit log, ok?
> 

I will make sure to write that in future commits, sorry for the inconvenience.
Adding an edited version of what I write to the commit log is okay for me, thanks!
