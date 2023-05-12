Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3986FFEC8
	for <lists+linux-wireless@lfdr.de>; Fri, 12 May 2023 04:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239724AbjELCM7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 May 2023 22:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbjELCM5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 May 2023 22:12:57 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162D31FD4
        for <linux-wireless@vger.kernel.org>; Thu, 11 May 2023 19:12:57 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6ab0bad2587so3464738a34.3
        for <linux-wireless@vger.kernel.org>; Thu, 11 May 2023 19:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683857576; x=1686449576;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=CT3lvlvlbiejQBnn+yxG6OjQ+mZSBPxq/l3659gUwks=;
        b=sxVG81jbv/Ssr4+9ppcbWdGRuUlTu0IuFvNf6RZR+3WwCueacBfuVy7+3Ts8gJZQuF
         npXpn3yKStnVFmGxC8FGoTj1MLj1hqRHCnmRnMHPk/FA9Lop2hlFgL+TKXzYPsITNlJ1
         KDB0XubWcQDl6oZy1HZD84o4uK/eNZlz8PCUkcLHn0U8Tamf6xU/wirSashMgYc5xWON
         UjO3n9073+FrANrmaXtjx7e1eAnPJKg/WWgk8hoeqiqp4ldxBWDWvHBcKpqqchh71U7r
         DZLRqhs0i+a1HMD874IYvPDzd5M8aInearJ9PNCsx2rowtDRTE1Mx1KnpeAkadoeI7dJ
         urdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683857576; x=1686449576;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CT3lvlvlbiejQBnn+yxG6OjQ+mZSBPxq/l3659gUwks=;
        b=LIgaH7lDX2YQqODuKoFbPSkPMi9JDlKrwEEwknFIcNc3KH/w+XQkawH8mCch6dhTf2
         XjvvDeohYuGzlIwMxpFvv5etgS8nWdDmaprAoMYxRV/XDPYUKVaTPrBHD8E2PPR9zIj4
         mPGTu6ilt2V6rF6GPWbw+50vU3krHWgfpKB9ZUsdpRnwnZKSqJh6r0JpQSjR+3DxJXDD
         A7I7z90ocwjllkCNZ7GJaFmZLwC0Jxcfl/iZiRqeAEcNokW4wfwmhEhXjAlo/NO68NZZ
         Afh1zm/S5bDIfhnUFvDkV3ayKXFA+fvfewi+ZZ5TCwxEy8UdHknykyV8T4cxTI+ec/hE
         wbWw==
X-Gm-Message-State: AC+VfDzSCYTH7lkCyUWNONAFbEmxWyujMsqbSZXbeja8CcqEZB9CuXq/
        Z8fzM0XX1P4A04d4DzdaqXMay27TxRI=
X-Google-Smtp-Source: ACHHUZ6EKEurjk8Kj9eexFleauxA1M53Sjdlhjvs3IGu6c3YeuempLSSBTQiUBnoHZoPxrCVGyp0Bg==
X-Received: by 2002:a05:6830:1206:b0:6ab:1727:c255 with SMTP id r6-20020a056830120600b006ab1727c255mr5916200otp.38.1683857576338;
        Thu, 11 May 2023 19:12:56 -0700 (PDT)
Received: from [10.62.118.118] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id n25-20020a9d4d19000000b006a94f27988csm7930890otf.8.2023.05.11.19.12.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 May 2023 19:12:55 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <da5e25df-75bd-5474-a7e6-1d86ad604261@lwfinger.net>
Date:   Thu, 11 May 2023 21:12:54 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] wifi: rtlwifi: rtl8192cu: Remove driver
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Martin Kaistra <martin.kaistra@linutronix.de>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
References: <20230428182933.19157-1-Larry.Finger@lwfinger.net>
 <cab66a9d-9a66-7cd1-408b-91e8cd9d8a9c@linutronix.de>
 <53260a3b-9256-07a2-1d66-553e865362b7@lwfinger.net>
 <873543nlto.fsf@kernel.org>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <873543nlto.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/11/23 06:34, Kalle Valo wrote:
> 
> The original reason why we added CONFIG_RTL8XXXU_UNTESTED back in the
> day was so that we would not have two drivers supporting the same
> hardware. Though I don't know how much the kconfig helped with that but
> at least the conflicts were somehow documented.
> 
> Now that rtl8xxxu has matured and gained more features, I would really
> like the idea of removing rtl8192cu driver. Of course we should make
> sure that we are not accidentally removing any devices support, for
> example I was not able to find this device in rtl8xxxu:
> 
> 	{RTL_USB_DEVICE(USB_VENDOR_ID_REALTEK, 0x817c, rtl92cu_hal_cfg)},

I will submit a patch to add this device, and check the vendor driver to see if 
there are any devices that were missed in the rtlwifi driver, but that can wait 
until I remove rtl8192cu, which has to wait until rtl8xxxu can support AP mode 
on the devices. When that happens, I will resubmit the patch for the removal of 
CONFIG_RTL8XXXU_UNTESTED as part of a 3-patch series.

Larry


