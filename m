Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 133026EBA64
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Apr 2023 18:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjDVQnA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 22 Apr 2023 12:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjDVQnA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 22 Apr 2023 12:43:00 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DB91FE4
        for <linux-wireless@vger.kernel.org>; Sat, 22 Apr 2023 09:42:59 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-18b5c8c2a49so1745157fac.3
        for <linux-wireless@vger.kernel.org>; Sat, 22 Apr 2023 09:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682181778; x=1684773778;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:sender:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MRNwK3wWnnloC0Gm+qdLRfu/6sQihDU4RrW+I9dUXgw=;
        b=alTpLDBPL18wrQXVfJgBKXTuhfHBmluR4Ht3ltRUtiJ+Q/YSOnyL3baEqcc7pCVrUI
         ZMyGpesNY0Ta3kwJwlG2DFasHs/CoM0vukHvgsFhKr/1phnL583hjoUcFbPv5jOHAySu
         AvZYcXFP6lUGAbC+1fC8Ep3xcxTbMfvhGazuqqOYN/o/Ksit92+EeGNWsSow3QmuiC16
         55h30rNsob+Il9vL9x7i77i7jcE0vpB4iKs1u6TS6h1WmYSy2NuWkQBYCJ7cid/JQY0u
         i02xrrgdyYGkk6nyWqpJ3aVeGx8SVqC+gOnXxTzEl7mitlt3UHrPBb1EsLm4ebbd47YJ
         uJ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682181778; x=1684773778;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:sender:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MRNwK3wWnnloC0Gm+qdLRfu/6sQihDU4RrW+I9dUXgw=;
        b=mFZRPd2rK1cxb9Fln2+4xG6jIlb1vaNr6rlIP+YkrOu1wxBuwHBMZgdC1zV9u2h46J
         yTKqxi0a+Hho8FgKVevm+e803WY+OrA1uBIiNUiT7SUS+YDJOZjXUj7YYBZf5pBfDQ0I
         kXhY2Lyh/aFFlL/qXl48f2A/rdHOoOzIzzyIBRwIUE+NWcYkJ/FHRs3t+4EHxbAtzyoM
         klOaf70e53TeaPt/Nq4SAUAAegPO9EJpMAfcwSeVf5twXW+oYbhb8U7FItrcsBmLUkaY
         QNzYhIVWPnYuSA8R55WkLpZRdNnmDh121AWME3MdW4YKZJWJeboyn+9DQhYJg3Q18yzc
         5uvQ==
X-Gm-Message-State: AAQBX9cpga953bW7Ehlz5t59BNkBgMJ6z+IAbPjXhLdYfVJvANQzTTyX
        e+pSSYrLajrJUjIrG6XB+chpx4tRrvY=
X-Google-Smtp-Source: AKy350YFVfmj8+h0FKkfJrHuW6S8yuxSTAB+Wp5G5+xjiG5nicJy6FL7WyoF35uBj1ApBRYMyWKH1A==
X-Received: by 2002:a05:6870:88a8:b0:177:a4d0:e389 with SMTP id m40-20020a05687088a800b00177a4d0e389mr5500778oam.28.1682181778345;
        Sat, 22 Apr 2023 09:42:58 -0700 (PDT)
Received: from [192.168.0.162] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id dy14-20020a056870c78e00b0017197629658sm2808181oab.56.2023.04.22.09.42.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Apr 2023 09:42:58 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <5c753c2b-ca3e-50d8-8829-9c350d35b9f5@lwfinger.net>
Date:   Sat, 22 Apr 2023 11:42:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     Pkshih <pkshih@realtek.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Subject: Problems with HP BIOS
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke,

In https://github.com/lwfinger/rtw89/issues/226, users with an HP 450 G9 with an 
Intel processor and an HP 645 G9 with an AMD CPU report problems that seem to be 
from PCI bus power handling. Both models have an RTW8852BE wireless card. Adding 
all 3 options for rtw89_pci did not solve the problem, but may have helped.

The user with the AMD CPU found a BIOS setting that disables PCI power saving 
that seems to help a lot. I am not sure what to do at this point, but I wanted 
to alert you to the problem.

Such BIOS problems appear to be most common with late model HP and Lenovo laptops.

Larry
