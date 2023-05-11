Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36A416FF379
	for <lists+linux-wireless@lfdr.de>; Thu, 11 May 2023 15:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237913AbjEKN4R (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 May 2023 09:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237896AbjEKN4Q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 May 2023 09:56:16 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15B63C31;
        Thu, 11 May 2023 06:56:13 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-50bc3a2d333so13127540a12.0;
        Thu, 11 May 2023 06:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683813372; x=1686405372;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LnHUphkdzPQcakVgi9g81EOHYUwmDWZ468NK7NaT9Iw=;
        b=QsaxRYzYTLdhD9uSrmxLHgk8qFPPSGVZoJCRi7HF/dVS6g5d/QZUjecN+H5XtvvCZ0
         /5HBckQY+/3/xppUoYllV91+xeeD4s3ir8LjXrbf3PESQ5rDim1s6XkpKWA1oWHeYeX7
         MPoZ8gSD0fuXOiesCBa6C2X05sA5oUVk0d0iIMLITCIQ60TMv2/J5MjnWFkBq0wPfjwo
         +v2OTlpA5itb6CopKzdResGDJEYjBUpg0wtktYd+ByX/6Hj0d62knXbLkwWiTslfMs55
         8UZIl2QOQz9lnLk1OyJR718R1hWUupxiBEPE6bx4Ragib58ORR5g5NrZJc1yBPXyNe4y
         qJag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683813372; x=1686405372;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LnHUphkdzPQcakVgi9g81EOHYUwmDWZ468NK7NaT9Iw=;
        b=WXMazjVtpcrM8ZaUtQSYsb27ZLagwa/cuTnJEHjtC7xRnkapDwLWSz/uIrgG31CN6r
         +v3BocAD48y/bJwsML0xN6CsjkZA+6lzgkjc/cgVephiwduQ3Zp0Zd+3+ImeCtHAwwt+
         adPjgkb1RsREvyg/RlPKR7FF17vQhiOqleJVTLioTfHxO4eDxrVj0gV5akGXpmKUfdAs
         F/VKrS3RQzYLZTBivD2YAaIY/omSpbSHJqEBENeNRnj+9Xa5xBuj2xTqIa5ql1wJGM+8
         XIJ+tve6RgKZBsHUikqPNWZ7wKLEdy1J8tKkNcvooHS8+l0apPUO9wNLLiSBepOCJSsb
         7rVg==
X-Gm-Message-State: AC+VfDx5wGLsqHza2sQjauQkhiQfUbnW8kSQ/9vANkVUwTQdD7agjjCN
        Adk7jK/4087udxAE2hZx9Ao=
X-Google-Smtp-Source: ACHHUZ5pxHjj3SN98cAIB7bbEqy26q9yy9faZT5Q/xLKj0VZOe4ozzGNTfgAmsgLJdz1NkJ6w8EMYA==
X-Received: by 2002:a50:fa86:0:b0:508:41df:b276 with SMTP id w6-20020a50fa86000000b0050841dfb276mr17743229edr.22.1683813372254;
        Thu, 11 May 2023 06:56:12 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.55])
        by smtp.gmail.com with ESMTPSA id f8-20020a056402068800b0050bc9c38fb4sm2887145edy.69.2023.05.11.06.56.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 May 2023 06:56:11 -0700 (PDT)
Message-ID: <24fd8bad-c8d7-6783-7662-e4ec86605f1d@gmail.com>
Date:   Thu, 11 May 2023 16:56:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] wifi: rtl8xxxu: fix authentication timeout due to
 incorrect RCR value
To:     Yun Lu <luyun_611@163.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Jes.Sorensen@gmail.com, kvalo@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
References: <20230427020512.1221062-1-luyun_611@163.com>
 <866570c9-38d8-1006-4721-77e2945170b9@lwfinger.net>
 <76a784b2.2cb3.187c60f0f68.Coremail.luyun_611@163.com>
 <d3743b66-23b1-011c-9dcd-c408b1963fca@lwfinger.net>
 <62d9fe90.63b.187cb1481f8.Coremail.luyun_611@163.com>
 <794ab671-43a3-7548-13f0-4b289f07425f@gmail.com>
 <75c2fe43.3e15.187e5b4182f.Coremail.luyun_611@163.com>
 <4856a7f8.1909.18808a46ab6.Coremail.luyun_611@163.com>
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <4856a7f8.1909.18808a46ab6.Coremail.luyun_611@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/05/2023 05:29, Yun Lu wrote:
> Larry  and  Bitterblue:
> 
> Thank you for your reply,  are there any further questions or suggestions on this issue?
> Could this patch be merged? There seems to be no other side effects.
> 

Your patch looks okay to me. I couldn't reproduce the bug and
I don't have any brilliant ideas, so that's it.
