Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC1ED7CC937
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Oct 2023 18:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233785AbjJQQ4l (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Oct 2023 12:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233499AbjJQQ4k (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Oct 2023 12:56:40 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F17AA4
        for <linux-wireless@vger.kernel.org>; Tue, 17 Oct 2023 09:56:39 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-4195fddd6d7so49695631cf.0
        for <linux-wireless@vger.kernel.org>; Tue, 17 Oct 2023 09:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697561798; x=1698166598; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6Lxk9ICuNszqfm+sUcVU/wQO8YIegQv++qn3iso04u4=;
        b=WAs/9+594MSXdZTXpv2Qg0epjbNqzIbylagEUPBz7EG5hZnX9afNzOgleutNEFtYaI
         5fmHJN40npdh3yTVk6Ahb08uNScgnXqh26frGeQ6dnS71LHa+TD6/Rwb+1TIVWBNYTa1
         iRb8H+z/qp5GlcIgN0DrBEEabe1mYxWVmzy1j/QD9G+8ujsU3OiXhtYMeOGD1wv7dNpl
         pICfZpo2M69by+pwojKn5jIMfdEfc8Pbk10aWWBgqshUcvJgwFkPYfWF5NHMziBUtPCn
         DkXklo9N3Qo5LdMV3iVjw+O12jKTeWGwCBAzdqV17tQtqVYAwYja2y1ObY59Zg2O77Dc
         /V9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697561798; x=1698166598;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Lxk9ICuNszqfm+sUcVU/wQO8YIegQv++qn3iso04u4=;
        b=goEXpHOMsAeenCbywGp3hA+FYJlBVtmw2zoxvprq5UuD4vZ3sd6r8wWdEtwCGvaLGs
         bm//rmMfr/A8N6yNQWMS+NbNonJ3Bj8CT0GYSOmL+zb2h6OdHssnGgBFvoUwVB2lRvq8
         MEVFLfp4Gkg/cCv3heAwAmHs/Ux6oTGYzt3MKq3KRUr0aaGsGFXo9U2be49BJySRP7VY
         P9WKWOTjcnkYvFLfx91h9icntFnuyLwf6vTcGFSJc+MOnffV1UCwxuhmxd/uNtULDDPj
         j09L2nAWcWjE/YSkb8OQHDrGLp2YxTFAiSxuGNkSlUOMbhFwB5XzzW+bGGDXAkYcfj5L
         yDmQ==
X-Gm-Message-State: AOJu0YxPQFvqJWUSOypYSWEHnbbMW7QL8XO6VFOBKgaRq/UHPGlgTxJJ
        S/Q4oAxXZgfrT+yXewRqwt9QM0CtmCo=
X-Google-Smtp-Source: AGHT+IGSy8pNtACKf2V7AgqJvwUe3xxXUym70+by++AWHR7uxmkMZ1cjrbe4BsEDN46mi1T+8DGX9w==
X-Received: by 2002:a05:622a:1183:b0:412:c81:efe2 with SMTP id m3-20020a05622a118300b004120c81efe2mr3335382qtk.31.1697561798158;
        Tue, 17 Oct 2023 09:56:38 -0700 (PDT)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id k2-20020ac81402000000b004199c98f87dsm756623qtj.74.2023.10.17.09.56.36
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 09:56:37 -0700 (PDT)
Message-ID: <c84bf2bf-7af5-49d4-b3a4-dba7abb8fca6@gmail.com>
Date:   Tue, 17 Oct 2023 09:56:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RX multicast action frames (ath10k)
Content-Language: en-US
From:   James Prestwood <prestwoj@gmail.com>
To:     linux-wireless@vger.kernel.org
References: <01c99bfb-b87b-4566-a873-38c6b7dbc0d9@gmail.com>
In-Reply-To: <01c99bfb-b87b-4566-a873-38c6b7dbc0d9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/17/23 7:42 AM, James Prestwood wrote:
> Hi,
> 
> Currently it is not possible to receive multicast action frames (AFAIK) 
> unless EXT_FEATURE_MULTICAST_REGISTRATIONS is supported, which is 
> currently only ath9k (and hwsim). This was added to support DPP which 
> I'm also trying to do on a system using ath10k (potentially ath11k in 
> the future). The original change [1] to ath9k was quite simple and just 
> set FIF_MCAST_ACTION to the list of filters.
> 
> I tried doing this for ath10k with no luck, and looking deeper it 
> appears the firmware API (ATH10K_FW_WMI_OP_VERSION_TLV) doesn't have the 
> "rx_filter" command. I'm using a QCA6174.
> 
> I also noticed the "configure_filter" op for ath10k seems to be monitor 
> specific.
> 
> So I'm wondering if this is something the firmware needs to support (if 
> so I guess I'm SOL unless someone wants to add that). If not I could use 
> some guidance on how I could support it if its possible to modify the 
> ath10k driver.
> 
> Thanks,
> James
> 
> [1] 
> https://lore.kernel.org/linux-wireless/20200426084733.7889-1-jouni@codeaurora.org/

Figured it out, I had misunderstood what "monitor" meant in the context 
of changing an RX filter. Patch sent.

https://lore.kernel.org/linux-wireless/20231017165306.118779-1-prestwoj@gmail.com/T/#u
