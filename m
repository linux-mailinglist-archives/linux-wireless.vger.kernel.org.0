Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D31CB4DAE69
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Mar 2022 11:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355193AbiCPKou (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Mar 2022 06:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355190AbiCPKot (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Mar 2022 06:44:49 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A3113DEF
        for <linux-wireless@vger.kernel.org>; Wed, 16 Mar 2022 03:43:35 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id w4so2157383edc.7
        for <linux-wireless@vger.kernel.org>; Wed, 16 Mar 2022 03:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=BvWV3OKRPLrOR+4WWPxXiUIc8WeUJWgTBPBrNnDPh7o=;
        b=DYMg/VRIR9RfBYXzg/VJlJNBgjBzzKkyW6kmnabz6oRQ+c4yNo4jfwgtE9g1Pb6hdj
         v5Z+0b3Q36IyI26NrtS1YayUxT0yAeQ61lDIiivZjhTLRwFrP1xoCgOX2Fit9eDuzHRs
         InjK8yo7UACSv17V27BFouussBbjztqDmIKoG1oqrXIaD/EJAiwmi5A7LfkDuAitXgpV
         4ZjECtG1ZJo38hx3+gseFhIS1006jHmdEWCGW5StGcRsPjSSJNCTPJILWgGbgOxzaKg9
         CGFYWrqVMTiD3Kv+DXeNYrJCIhWdPH7oyDpreeEIJ1/AXMsBjW9tps5FfZpPY2WHjs6F
         RG5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BvWV3OKRPLrOR+4WWPxXiUIc8WeUJWgTBPBrNnDPh7o=;
        b=QZJRDfgQ5UlZoUWp9Nt+K3roMWFO1LguesQrZkVFhNV1Gv+6YFWJ+RTyPlJ8k4OD0S
         F6XSddPlINSRxShdQF4I4FjwqMY1oHf8pVWQ9OZedv3RWc/jc1p1+/SrRkfSqlG9f7vM
         IzVrDxWU35TLkYSCp5DQsjDCGY2Atg5XRUZLzIeMsya1HseGn/gI/7mpToASJa2Zruyl
         78tFTZFU7g6PU3djAcgK91a3ZDcOUh8WbzUJ6FQSt5zHOUadia/Wh0a3VFSAkA3yJHkn
         mSczooq2YWLAPmsJvJZ/E7g0SGut0FpU0sG5Xoh0kHcVcmmAbNTyfIpVAS8LiPl54zXE
         3gIw==
X-Gm-Message-State: AOAM532CKl9YnuvmALoM5uH2Pgzrp0/qVr1lP+YDpHfjKUO8z4umXCH7
        1Ye9kJIXn3HzeZUj6aqbB1w=
X-Google-Smtp-Source: ABdhPJz90mINuRQyoT8W7/g+d52sHUS5cZwmj1ONf/XRnQXu7VeK2imn9CxTDdWBltaDsPQeazCXyg==
X-Received: by 2002:a05:6402:386:b0:415:ead8:ced with SMTP id o6-20020a056402038600b00415ead80cedmr29576796edv.407.1647427414223;
        Wed, 16 Mar 2022 03:43:34 -0700 (PDT)
Received: from ?IPV6:2a02:1811:cc83:eef0:f2b6:6987:9238:41ca? (ptr-dtfv0poj8u7zblqwbt6.18120a2.ip6.access.telenet.be. [2a02:1811:cc83:eef0:f2b6:6987:9238:41ca])
        by smtp.gmail.com with ESMTPSA id bw26-20020a170906c1da00b006c8aeca8febsm724642ejb.47.2022.03.16.03.43.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Mar 2022 03:43:33 -0700 (PDT)
Message-ID: <c0874b06-116d-7471-3b50-21099c729c3d@gmail.com>
Date:   Wed, 16 Mar 2022 11:43:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] ath11k: acquire ab->base_lock in unassign when finding
 the peer by addr
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Carl Huang <cjhuang@codeaurora.org>
References: <20220314215253.92658-1-dossche.niels@gmail.com>
 <87o826pgqr.fsf@kernel.org>
From:   Niels Dossche <dossche.niels@gmail.com>
In-Reply-To: <87o826pgqr.fsf@kernel.org>
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

On 3/16/22 07:13, Kalle Valo wrote:
> Niels Dossche <dossche.niels@gmail.com> writes:
> 
>> ath11k_peer_find_by_addr states via lockdep that ab->base_lock must be
>> held when calling that function in order to protect the list. All
>> callers except ath11k_mac_op_unassign_vif_chanctx have that lock
>> acquired when calling ath11k_peer_find_by_addr. That lock is also not
>> transitively held by a path towards ath11k_mac_op_unassign_vif_chanctx.
>> The solution is to acquire the lock when calling
>> ath11k_peer_find_by_addr inside ath11k_mac_op_unassign_vif_chanctx.
>>
>> Fixes: 701e48a43e15 ("ath11k: add packet log support for QCA6390")
>> Signed-off-by: Niels Dossche <dossche.niels@gmail.com>
> 
> On what hardware and firmware version did you test this?
> 

Hi Kalle

Thanks for your reply.
I am currently working on a static analyser to detect missing locks.
This was a reported case. I manually verified the report by looking
at the code, so that I do not send wrong information or patches.
After concluding that this seems to be a true positive, I created this patch.
However, as I do not in fact have this particular hardware, I was unable to test it.

Thanks
