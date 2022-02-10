Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 930EC4B1596
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Feb 2022 19:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243255AbiBJSyy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Feb 2022 13:54:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343577AbiBJSyx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Feb 2022 13:54:53 -0500
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E02101C
        for <linux-wireless@vger.kernel.org>; Thu, 10 Feb 2022 10:54:53 -0800 (PST)
Received: by mail-oo1-xc2f.google.com with SMTP id c7-20020a4ad207000000b002e7ab4185d2so7488817oos.6
        for <linux-wireless@vger.kernel.org>; Thu, 10 Feb 2022 10:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yMao6UkzoPZa4OKRcl+oKZYBvLwCm7QOnag32j5HVEY=;
        b=EdKZGjoPIrYFOOsb+zaQHZlJ3w10kBbU2rZSwCahJmAV3wcMMWqMoyHJmfAb4x7Zj3
         cMVjr4dZBDWoCr0MewplkAHP8A9zhAd8wbn08phyjQsJClBRJGVV039o8atGw1kTbcpZ
         1pjaWdB2Gw08Xri6/Tw2p236TzSMHV32zmtKtVcrdBWbPDp7j/01wU9BXT73uNvQrZvl
         +8WhjyuqhOhy7rXYo4MefaXlxszN+7a2xEbtdxRRk91yttS5TdZ68vd1+PnGbgzOcwnO
         vkf5rIYvA7F+lOUcX2HqSIP51Xsw87PqxiSmW3te2jeFyhq4s6tudIaSreU0l7xVu15G
         5a2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yMao6UkzoPZa4OKRcl+oKZYBvLwCm7QOnag32j5HVEY=;
        b=f+ak/rv8M6GXv0eXayH2o4JVfwEAdWWBtz4pvgiDjUXeTAEHYMR5Pn8I1Aob91iNRU
         OptPHeeRBV8tig8Z8/opKRILCCPzGnA6edM9+TlkP/Amn9ElLJkUrhpDST8svPKC/CLR
         EQWzl69KtPLfgsl+icpz2am3vo81a6VgqaGy61pxAMyhmuVmjl8HjY1zs2Qq+16nC4Dq
         XDormvtRmHac5POszmuG/RBvH1XNEkbBMqU2qO2AeI3Lkkg9UlQ9p3mygVFj3VqeYIxj
         MIuEMO6USDE44NCe7SPWx7lJzY7gSLGp5SnSXjF9wsnfND/8msJ5wivbDloIiK85Sgng
         +H2g==
X-Gm-Message-State: AOAM532apKPtDuiSDxfbmjJo6OePtA/0daP22XOzVOT60ZkUuhhLrKt8
        /LeTlotw+o/7rWvsWJMT1E8=
X-Google-Smtp-Source: ABdhPJzQ5RvTmE01HTtNLHFD9BXPL29NOqeZUKmtVd9qMDvbQMn7XMyJ/2Rn2AN6tgGvrSpZQWBrEA==
X-Received: by 2002:a05:6870:1059:: with SMTP id 25mr1261477oaj.172.1644519293062;
        Thu, 10 Feb 2022 10:54:53 -0800 (PST)
Received: from [192.168.1.103] (cpe-24-31-246-181.kc.res.rr.com. [24.31.246.181])
        by smtp.gmail.com with ESMTPSA id p5sm8352016oou.39.2022.02.10.10.54.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 10:54:52 -0800 (PST)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <ba50e373-59d8-d544-e7f9-3fe2a3336056@lwfinger.net>
Date:   Thu, 10 Feb 2022 12:54:50 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: Possible bug in cfg80211
Content-Language: en-US
To:     Maxim Klimenko Sergievich <klimenkomaximsergievich@gmail.com>,
        linux-wireless@vger.kernel.org
References: <CAEqd1ZZucLqJMEktzmnCKzwXXkswzqJNf_yr2HZV20LcWtiR6A@mail.gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <CAEqd1ZZucLqJMEktzmnCKzwXXkswzqJNf_yr2HZV20LcWtiR6A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2/10/22 07:25, Maxim Klimenko Sergievich wrote:
> Modules settings:
> blacklist pcspkr
> blacklist bluetooth
> blacklist kvm
> blacklist kvm_amd
> 
> # options amdgpu reset_method=5
> options snd_hda_intel power_save=1
> options rtw88_core support_bf=0
> options cfg80211 cfg80211_disable_40mhz_24ghz=1 bss_entries_limit=1
> options mac80211 minstrel_vht_only=1 ieee80211_default_rc_algo=minstrel_ht

Maxim,

What kernel are you running?

Why are you setting option cfg80211_disable_40mhz_24ghz=1 for cfg80211. Is is 
because the 2.4 GHz band is really crowded, or do you wish to throttle rtw88?

I am most concerned about that bss_entries_limit=1 option for cfg80211. Do you 
still get the warnings logged if you eliminate that one?

I also have a question for Johannes, et al. Should the "if (WARN_ON(!oldest))" 
in net/wireless/scan.c be a WARN_ON_ONCE()? It does not seem worthwhile to spam 
the logs. It is clear that once this happens, it will happen again and again.

Larry

