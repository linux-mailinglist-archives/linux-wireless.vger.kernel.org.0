Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D29E85F9C41
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Oct 2022 11:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbiJJJxM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Oct 2022 05:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbiJJJxL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Oct 2022 05:53:11 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E8217586
        for <linux-wireless@vger.kernel.org>; Mon, 10 Oct 2022 02:53:10 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id y1so6343277qky.12
        for <linux-wireless@vger.kernel.org>; Mon, 10 Oct 2022 02:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FFJMIAmvUOe3JtHUldQs90SjA7BN1J1PHfava9TLUiA=;
        b=WrIMXj8nXIdKcJvI8ZEDA9pQ3j1wtVB4HEEIz6n1YzsnWPB5ClwGoixxZg/kOHoA45
         xBO71A2amw3gvKo0WWKXYH2BGDwVITvFYaofG3Ht4Ak8AFTsRgZnsqXXSgppzbD1ajUk
         BLGEzWNZJQCj7szQ5BNcRjSBzMnKZQE2QVFM0iLve6lL56Uy9n8Im7jkWQqSjS5x3K29
         S3A5oIZCs8sriwIAyZMmzgyoAaSl0dYdr7QFOJvIudCtDlfzU3fcTr2m08+MOlCut9aw
         8c/CYfGKNKHfJ64qN9hTJ31tAiRXEl9LGPBxCHZIi4xCeB1zGXqQlhgdHpKd1ERElLTC
         REDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FFJMIAmvUOe3JtHUldQs90SjA7BN1J1PHfava9TLUiA=;
        b=zXMHLNWqVZMexdsl9Xf5qF7wGY0OlHv2wuK4siXudGD7kNWdCiGScqqN0vhDlWWBvt
         gm9kCtkD9L1kDzURGhqG/aqvGV+lf3Ul3H129qfMsmyyn+WiC8a80Yse+/by01nDyDln
         BNMKkqJQqAM+6kC5Ia/jEgtChSUQaHrMViSd1PNbATyEFaRQz/g1qOlV60wrNU/rEE6g
         x3A/ev+fGTw4nduByqv0YBL44lunbXHoec9JmwjJp7rs5pUQmRCgdtGw1pnowpp/T6Dd
         XNIWAwr0IA+K2Zd4FfJyagB9oRx15dXg7i7Mq29DbULprD8H0wfDbbYaOZxL+caIG+09
         dQVQ==
X-Gm-Message-State: ACrzQf3a3Q96iv3AXwidHNOJ8NmcmDrHcJ6BZ1gkwgpjfSScKnfanPbm
        Qhq0OYpfv+177qvzmC1+gXI=
X-Google-Smtp-Source: AMsMyM4wv6OfANmmF4pRe7ezd4fgk6AeTM3xE33CFEpLyDsgWNfMVp9rpWJr1kNYxuJ3D8Mm463tAg==
X-Received: by 2002:a05:620a:1727:b0:6ce:9b88:92aa with SMTP id az39-20020a05620a172700b006ce9b8892aamr12037591qkb.160.1665395589814;
        Mon, 10 Oct 2022 02:53:09 -0700 (PDT)
Received: from [10.176.68.61] ([192.19.148.250])
        by smtp.gmail.com with ESMTPSA id q24-20020a37f718000000b006ed519554cfsm1590951qkj.61.2022.10.10.02.53.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Oct 2022 02:53:09 -0700 (PDT)
Message-ID: <243c9212-0bd0-fa08-056e-efbf6fbcb842@gmail.com>
Date:   Mon, 10 Oct 2022 11:53:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 1/3] brcmfmac: add a timer to read console periodically in
 PCIE bus
Content-Language: en-US
To:     Ian Lin <ian.lin@infineon.com>, linux-wireless@vger.kernel.org
Cc:     brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        franky.lin@broadcom.com, hante.meuleman@broadcom.com,
        kvalo@kernel.org, Double.Lo@infineon.com
References: <20220929031001.9962-1-ian.lin@infineon.com>
 <20220929031001.9962-2-ian.lin@infineon.com>
From:   Arend Van Spriel <aspriel@gmail.com>
In-Reply-To: <20220929031001.9962-2-ian.lin@infineon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/29/2022 5:09 AM, Ian Lin wrote:
> From: Wright Feng <wright.feng@cypress.com>
> 
> Currently, host only reads console buffer when receiving mailbox data or
> hit crash with PCIE bus. Therefore, we add timer in PCIE code to read
> console buffer periodically to help developer and user check firmware
> message when there is no data transmission between host and dongle.

These patches are already applied, but wanted to respond still. I know 
the proprietary driver does use a timer, but it was a design decision to 
drop that. It adds overhead and complexity which is not resulting in 
more information about the firmware. Maybe I am missing the exact 
scenarios in which this would be useful. Also description above says it 
would help the user, but I very much doubt that. Not much users are 
fiddling with debugfs and if they are we can call them developers ;-)

Regards,
Arend
