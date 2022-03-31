Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7F64ED328
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Mar 2022 07:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiCaFJK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 31 Mar 2022 01:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiCaFIk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 31 Mar 2022 01:08:40 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B8E4349D
        for <linux-wireless@vger.kernel.org>; Wed, 30 Mar 2022 22:06:50 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id x31so14311486pfh.9
        for <linux-wireless@vger.kernel.org>; Wed, 30 Mar 2022 22:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=AoBZG/yiJ6+iCgMDn0fAA0KBmLbpdCwlKXKAQfWztPc=;
        b=aW6e5LYEk9vvZLGnTh7AfLPRozdASjaoVU1P21Z0Rza63SVH1jBLSIeqJH2rsB3Jxr
         gi2ffg8zv9jGd1Tj0yfAYcr5fi2JF+lge7yIof7mw//fRQ5pSuKO/SyidhXuH0upuT/2
         41oy78q84xP5tHLk3sCxkYs7iIAeVpXZNVA8h7HskBUwhhXfWSHIqNkg9rFyqY9uAJRG
         B/zdwH7+hIiLiPGSss7qZxiMk0CvyxkLkUq/iw0fXB0i1qiP+t7htPmre840mDgQS/dE
         0Jz5Mzk295iz39+wOmoeRKipUL5WFufwhNeguoyPRlZVszRLv2TP3aDeD/cQSJGhaJNs
         xPdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AoBZG/yiJ6+iCgMDn0fAA0KBmLbpdCwlKXKAQfWztPc=;
        b=vitArG4Jz6lMDrHqIhW8raV/75TYzQSPErK6LEHD4vMN/DGw0AlBeluP3qxvUe4fTi
         QDoZFUeM1BT4AnbimK6KCvzdZioiNXTG1nqpccLqGIPKcSEZY+y+52OiMjDWBjpIoXiC
         4pvf+/HCTPIND8CsXx6Xv1MZdCTSQsLRh/NgqumRAPI4v5fgdv5xsK3/Nio498MI5Bdq
         19bq4EpFuKd1FbUmW9Jd5+3rcxVKQqWNnlH1TsSThTT/rv9AsYQ7bHcSbGfxQXwDBx/4
         qkChSLrKjft6lt9eT+CqF/URyOLmewmReJgsO5xJZIucPJ2/1QMiBW7AFg5IAZ33VInl
         j5yg==
X-Gm-Message-State: AOAM530y459BhQQXK8QqZytp50S3Qcf1uskGHhhLI7rrS0AV+1Dd+f6h
        KkGvew/7SKsW9jClQry7BEQwtopVeI9KHg==
X-Google-Smtp-Source: ABdhPJzkhEPH4/VGyGSACMTh6UnzZjVAbFYUX35MI0A+APiD2c1NFSnJcLCijK7O77iDycwaCdhvcw==
X-Received: by 2002:a05:6a00:288c:b0:4fa:8c08:aca9 with SMTP id ch12-20020a056a00288c00b004fa8c08aca9mr3576135pfb.62.1648703209727;
        Wed, 30 Mar 2022 22:06:49 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-30.three.co.id. [116.206.28.30])
        by smtp.gmail.com with ESMTPSA id u25-20020a62ed19000000b004f140515d56sm25729140pfh.46.2022.03.30.22.06.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 22:06:48 -0700 (PDT)
Message-ID: <8ad2754c-c5bb-7b07-6b3f-5701d0434eee@gmail.com>
Date:   Thu, 31 Mar 2022 12:06:45 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v5.18] ath9k: Properly clear TX status area before
 reporting to mac80211
Content-Language: en-US
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@toke.dk>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
References: <20220330164409.16645-1-toke@toke.dk>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220330164409.16645-1-toke@toke.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 30/03/22 23.44, Toke Høiland-Jørgensen wrote:
> The ath9k driver was not properly clearing the status area in the
> ieee80211_tx_info struct before reporting TX status to mac80211. Instead,
> it was manually filling in fields, which meant that fields introduced later
> were left as-is.
> 
> Conveniently, mac80211 actually provides a helper to zero out the status
> area, so use that to make sure we zero everything.
> 
> The last commit touching the driver function writing the status information
> seems to have actually been fixing an issue that was also caused by the
> area being uninitialised; but it only added clearing of a single field
> instead of the whole struct. That is now redundant, though, so revert that
> commit and use it as a convenient Fixes tag.
> 
> Fixes: cc591d77aba1 ("ath9k: Make sure to zero status.tx_time before reporting TX status")
> Reported-by: Bagas Sanjaya <bagasdotme@gmail.com>
> Signed-off-by: Toke Høiland-Jørgensen <toke@toke.dk>

No regressions and UBSAN warning [1] reported on dmesg.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

However, there is something missing. I don't see Cc: stable@vger.kernel.org
trailer in this patch. I think it should, because I reported that this issue
first occurred on v5.17, then still appeared on v5.17.1.

-- 
An old man doll... just what I always wanted! - Clara
