Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48ED60E985
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Oct 2022 21:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235280AbiJZTrv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Oct 2022 15:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235259AbiJZTrU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Oct 2022 15:47:20 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8932EBC44F
        for <linux-wireless@vger.kernel.org>; Wed, 26 Oct 2022 12:46:58 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id g16so10810112qtu.2
        for <linux-wireless@vger.kernel.org>; Wed, 26 Oct 2022 12:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=az4DdZ94Dcv40kwLv8X5NX9K3iXjRUb2dsWj/gPdqHQ=;
        b=N5kLECUnBb6pDE43XjC/Gw7V9ViDgHZzsNNs2xeEl7OXrnjODcce7Myo2o1tuuyyk0
         tIO7TGDNgcRHd0EzOhh6q78shbOfLEj928+QYhAxPJIFLtt59LPJrxFB9v//GUnOPCmB
         T5gNPVjP4k1xJUGThI42/i7MuBi8IPBeyYByc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=az4DdZ94Dcv40kwLv8X5NX9K3iXjRUb2dsWj/gPdqHQ=;
        b=cswHfnBHyfGz2aCLBONH6BiRY/YzmTpZ8dCBfi1skddxY4XIA+Cp5eXQM+JF9aUwer
         b9N/t/X5X7smmrFD4gJNJ7g/kmVtlO1MLUqLXJxZFxysv9lDFJKshslVu+a739tnZC5v
         iE45sqBnacuqJz/sDDyNGLQbQwkUZOnSkr1G+stMkDZ0szUuE0aXoau5HBPzvVjpdgD0
         lK7o5fEFdW/lIpllqfJOI7oh2KGXfbLUZ5PGJF4bGnmJYZ0u4aYyeckcVsMNHOsnmDE2
         OhDOikuIaYC/t6WjbPxRaoJbVnjsfUcr1uCdHqKD/JuBQLzUuLUB53BjYsV6aXb1MVxI
         cSIw==
X-Gm-Message-State: ACrzQf2+5Xt6cTZUOQr6bglIDQMicAm2JH6WQCXMCP09r++X0PgEetxx
        Ukh2ZDLrPLPlRFKyhU8jf38UsbUN+bamag==
X-Google-Smtp-Source: AMsMyM6PxMzcqUDq5edhDI3ioET1luoXMBS9ESrY3qqmO1rmgtFuQ3WSpmXPx7e9btL3FoG2B30u3A==
X-Received: by 2002:a05:622a:407:b0:39a:836:acfe with SMTP id n7-20020a05622a040700b0039a0836acfemr37547982qtx.133.1666813617696;
        Wed, 26 Oct 2022 12:46:57 -0700 (PDT)
Received: from ?IPV6:2600:1700:9770:4850:2cd3:5b9:e84b:3a69? ([2600:1700:9770:4850:2cd3:5b9:e84b:3a69])
        by smtp.gmail.com with ESMTPSA id q13-20020a05620a0d8d00b006dfa0891397sm4471464qkl.32.2022.10.26.12.46.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 12:46:57 -0700 (PDT)
Message-ID: <11e005c2-2363-d63f-9f3f-3ca811737231@chromium.org>
Date:   Wed, 26 Oct 2022 12:46:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] wifi: ath11k: Fix qmi_msg_handler data structure
 initialization
To:     Rahul Bhattacharjee <quic_rbhattac@quicinc.com>,
        ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
References: <20221021090126.28626-1-quic_rbhattac@quicinc.com>
Content-Language: en-US
From:   "Joseph S. Barrera III" <joebar@chromium.org>
In-Reply-To: <20221021090126.28626-1-quic_rbhattac@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/21/22 2:01 AM, Rahul Bhattacharjee wrote:

>   	},
> +	{/* end of list */}
>   };

Do you want to add a comma after that last list element?

Actually, I normally see the last list element simply being

 > +	{},

... with no comment necessary.


