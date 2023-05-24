Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB4870FF42
	for <lists+linux-wireless@lfdr.de>; Wed, 24 May 2023 22:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjEXUcA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 May 2023 16:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjEXUb7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 May 2023 16:31:59 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF61610B
        for <linux-wireless@vger.kernel.org>; Wed, 24 May 2023 13:31:57 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-19674cab442so590910fac.3
        for <linux-wireless@vger.kernel.org>; Wed, 24 May 2023 13:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684960317; x=1687552317;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=INAF0tX8rmBBU+wYFCtXzVhr54eZNosdE/vo/Z06pxg=;
        b=omOArGIim/fPKcFnv+EMB/mql7qOlQ2bFDFJPBRV90M82vwwfN3tMELKvS9VslzX+Z
         f1ywZQKR2RaR0qtOZo4WolMHcZnKeuza9nlkGvMfHtcHY+Nhn8vos90S7AXGPt2yCksa
         vtiQ2cuYqPsJDvl+Zl0jO821KA7Oq7CTRiIe8H7lLqo8rZqq3iGIzyRAFtqCZ+UBP5tP
         Yl3YWDs6e2AlAf/YlzEIENSlxdEfxtLfH0t71QWRiz38s9n++jdhgOcdS7RubT+JuRsI
         qCYznl4l+W1ctpwV8xcIYMRTx6hNd54GaD8SThXv9bc/DNSjjQ/bbmFmaTRr/Ihnalbg
         VOhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684960317; x=1687552317;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=INAF0tX8rmBBU+wYFCtXzVhr54eZNosdE/vo/Z06pxg=;
        b=ffSw3lFuMK+PLSn7TSzPtLIbLzFcExcwTp7jozlCGmWYWAqFWctbWxxNwZg+mq8by9
         Re70FkFN9Ygot/7lK5Y5UOjH78I44cDPr7lkPGibKQ52giBsplXDCiRdVX4xFbMGdEQL
         +3DTdDtTnwTHOd8n3vPBjWU0HzWuHnCIRcEgkY2+5go3p8wdu6kc8ZoWouiiRYPLS0vH
         +/8oLg/6qKB2MnxDf4YxgPIHc1nBsCUavUQeiqB4NF7bNlBvVmL8DhaJSTLtgoMW+amh
         1z8wbLma2OCOfbrXzqXQZV8ygK31o0mc/r4ig3TEokZLWV89jFfXUIDim0zSyLcgHp9e
         4LdQ==
X-Gm-Message-State: AC+VfDyHGfv/adFIRFlRz0ko6k5jxtOWNwDiHO0XE50p+S5g0EUk+9t4
        51hcp7w6NthU58GcJXvWA3w=
X-Google-Smtp-Source: ACHHUZ7wTikKBXTCYiR6v5RMlzRS5F7AqZQ1A753CX/ttKwEdmQ6ZOKk+BPLJQqXAiYc6Qbo4FNF7Q==
X-Received: by 2002:a05:6870:b286:b0:18e:d237:9693 with SMTP id c6-20020a056870b28600b0018ed2379693mr483313oao.46.1684960317299;
        Wed, 24 May 2023 13:31:57 -0700 (PDT)
Received: from [192.168.0.159] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id a2-20020a056870b14200b0018045663fc5sm325226oal.48.2023.05.24.13.31.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 13:31:56 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <547524c3-bfb4-8132-b309-6eb9e648881e@lwfinger.net>
Date:   Wed, 24 May 2023 15:31:55 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: rtw88: Problem with sdio.c
Content-Language: en-US
To:     =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
References: <1027342a-97dd-83cd-f363-43cff49967e2@lwfinger.net>
 <2681990.mvXUDI8C0e@jernej-laptop>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <2681990.mvXUDI8C0e@jernej-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/24/23 14:18, Jernej Škrabec wrote:
> 
> This was fixed in:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=cb0ddaaa5db09d7d216fcbf0e68779be223a1128

That fix is in the kernel mainline source, but not in wireless-next, where I got 
my source. I hope it gets resolved correctly.

Larry


