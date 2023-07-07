Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A4474B606
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jul 2023 19:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbjGGRzY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Jul 2023 13:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232533AbjGGRzX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Jul 2023 13:55:23 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9059E2685
        for <linux-wireless@vger.kernel.org>; Fri,  7 Jul 2023 10:55:21 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-51dff848168so2905751a12.2
        for <linux-wireless@vger.kernel.org>; Fri, 07 Jul 2023 10:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688752520; x=1691344520;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NVDSYxwa05jJn6QPiRRRKEE5xPGES75ekgR3d7z/2Wo=;
        b=rRgFAd5Pa42kuMa6vOq9+WOtlbhRaoVw8YKHo0xq0mlC64wqzsAkFLolRjmppyaKAh
         9a1RAyR0JXrvGv9J0C9lQP4gmq22G5etHc6iHC0o1HX4VY1EyjyAeYfiww2ZWO2PA6ia
         ize3poarKh1emUv2tLiNcAIBwSBtXYFIPMWycF6h4H4/N3ZjKtcvWH5A92UFqln+YXPS
         MxVjf9tN6TRCISbL/bjFaGpZBVJUnJQDhTIbtyMr04cF+bMtQ9sDAuK/eL980kZ2q1vi
         /b2aU4ERPmFRiLcHENfdw6XJyiXUigbsWJxPnRy8CeVUu0gSzB7U4npSXX1BpEWVeOiW
         XhVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688752520; x=1691344520;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NVDSYxwa05jJn6QPiRRRKEE5xPGES75ekgR3d7z/2Wo=;
        b=Dab42mFOn4g736kNl9BhNRZyngVoRfhaqeTSTHFdPBaEdcITyq+1YrergkgNrYLH88
         S6pDFC0gUALG1Ql6amYNQiw/ETTt6PV/ITszhTAnGpaaVCFqo2ZRkoEH7BqdeaQ7u2gV
         9N9yIDr+TjwWkxZAYFo92y9ofUXyNz/wmWEzWYqaBjvMzA61+3VP1v7jmsoPQ1XsuXCc
         i50+S8TPjQc24C1j1oRUilaN+EXR88FoPFI/Z+6rpXrc+KiJJx1fO9BJDyNuMXXVgLxU
         Djk2x9dl7wi5zFZFaY7kasHgr9jGM1IT8cWcHPzImDZRuNoL8nqckVOoyU9JVmsbc8Qs
         TIWA==
X-Gm-Message-State: ABy/qLaZ/jhQvVNa9Q5YjG7kBXFlLDQXbshhgDh9pqczlxJSmp0dYkNz
        NQgbSuV6okFxylXpZtY01ls=
X-Google-Smtp-Source: APBJJlFXR2MmvgdA6QigEdXjJqSSrMMtxljzcc5HVPz3vFELici50W+67H2v0xSf77CF7tE9VjX8Cw==
X-Received: by 2002:a17:907:1246:b0:982:ab8d:1e08 with SMTP id wc6-20020a170907124600b00982ab8d1e08mr3969330ejb.59.1688752519814;
        Fri, 07 Jul 2023 10:55:19 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.57])
        by smtp.gmail.com with ESMTPSA id v9-20020a170906858900b0098e78ff1a87sm2445227ejx.120.2023.07.07.10.55.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jul 2023 10:55:19 -0700 (PDT)
Message-ID: <938ae608-a865-4056-06de-c230d74e1847@gmail.com>
Date:   Fri, 7 Jul 2023 20:55:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 00/18] wifi: rtl8xxxu: Add AP mode support for 8188f
To:     Martin Kaistra <martin.kaistra@linutronix.de>,
        =?UTF-8?Q?Georg_M=c3=bcller?= <georgmueller@gmx.net>,
        linux-wireless@vger.kernel.org
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20230428150833.218605-1-martin.kaistra@linutronix.de>
 <c9e6a13b-e32d-f810-741c-33598956a55e@gmx.net>
 <997e1858-a499-2188-a6a1-f0c4f0c90079@linutronix.de>
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <997e1858-a499-2188-a6a1-f0c4f0c90079@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 07/07/2023 10:23, Martin Kaistra wrote:
> Hi Georg,
> 
> Am 05.07.23 um 11:00 schrieb Georg Müller:
>> Hi Martin,
>>

[...]

>> Please give me a hint if and how I may help tracking down the issue to
>> enable AP mode for 8188EU as well.
> 
> I would suggest the following:
> - in rtl8xxxu_fill_txdesc_v3, set macid, HW_SEQ like in the v2 function
> - 8188e does decide on the tx rate in software, so rtl8188e_handle_ra_tx_report2() will probably need some adjustments to handle multiple macids (maybe ra_info in rtl8xxxu_priv should be an array of size RTL8XXXU_MAX_MAC_ID_NUM?)

ra_info should be an array(?), except the dynamic_tx_rpt_timing_counter
member should be moved to rtl8xxxu_priv. In the vendor driver it was
a static variable in the odm_rate_decision_8188e() function.

An array or some dynamic data structure? The array would take up at
least 3072 bytes, including when the driver is handling some other
chip which doesn't need the array.

Additionally, rtl8xxxu_sta_add() and rtl8xxxu_sta_remove() need to
increase/decrease REG_TX_REPORT_CTRL + 1, otherwise you will only get
correct rate control for the first station which connects to the AP.
