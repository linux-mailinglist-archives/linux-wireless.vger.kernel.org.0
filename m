Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE4461510F
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Nov 2022 18:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiKARtg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Nov 2022 13:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiKARtf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Nov 2022 13:49:35 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460FD1CFF5
        for <linux-wireless@vger.kernel.org>; Tue,  1 Nov 2022 10:49:34 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id bs21so21202694wrb.4
        for <linux-wireless@vger.kernel.org>; Tue, 01 Nov 2022 10:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vuz2/1e8Z4TDpyEriCyACpZF+nY+VKelYmyQZgIB5As=;
        b=lUmOn5Z/KIfZ1LT8QCy9ETrXaNlr+x0WGEpfbKb0GxPuxpeX2LFDrAOCbBg4Rp6lMF
         JsNhxW9uMJHmW0c1n68aye8TqAHpO6g60LedXKuHWQsh/W11LZpnsP6ZFfiQ+8pzYUF3
         3RyDyGOAtNE0v9bqtcmAgFezxFygYGP+59Zwx6oTjH7KJHOiV4bezhhwsMDeU1eFIqlj
         tLZX7NsMMOnc3IirPf+mh31w8N8ZmIIuvlxcAgZ5iJ0dVxAfjkNu0z2+M0Rwdc7p4EVb
         hcMAuUXCKeQdKVm2kTpL1Bv2my69Oo8uv+nI/5T20HgNe3GRPc/JEbCVFwOdF4i0ZLZL
         g9HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vuz2/1e8Z4TDpyEriCyACpZF+nY+VKelYmyQZgIB5As=;
        b=EREnoQz2RE5vW3peHUVOF9M3yEMvSQPp9BzxZN0e2uyUIVdAQ4nOvJ4n5A5/A5KGOv
         UJ35Hl5pIuXSbEJkaLzDhHF74nU3hqGujNPF1iEKOEPSa6rZmuqFaNhx4HblxxdxyAxA
         VE+GB2C0mz1PG0NWu18O9nlF5sb505t0q+clX7G4sutF47Bv4dLZUYY1On1SdVH2su65
         3Mm1qe/B9hrpEpG/btlJb/vfN68xEiojw3CKV376WJ+AMYk08j51TI+yiGCzGvJHGPhJ
         Z3SnwBRrbbNLm8b8bqefk6txWYZgellvhdT3cuODZcvoo4ZXG7vq3q7xOL+ReA7SDyLl
         7PJQ==
X-Gm-Message-State: ACrzQf1gMOGbE6glibLGozb1447t9jWxaQCqRERFxTqEH6SbAki9Uvcy
        6s6smJoWCmmwv6vsXlgmw8OP+JA2x/w=
X-Google-Smtp-Source: AMsMyM7NZWWGAKqK/AUpXZO5TCQC4KC8pnEEikYKmVmuM9LYoDLMDfAfro0f6aqJfwSHjtNdX5b74g==
X-Received: by 2002:adf:e6c3:0:b0:236:acdb:4d9b with SMTP id y3-20020adfe6c3000000b00236acdb4d9bmr12078185wrm.528.1667324972733;
        Tue, 01 Nov 2022 10:49:32 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.23])
        by smtp.gmail.com with ESMTPSA id y10-20020a5d620a000000b0023657e1b97esm10758916wru.11.2022.11.01.10.49.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Nov 2022 10:49:32 -0700 (PDT)
Message-ID: <f0fcd38a-83f6-e22a-b715-facf61d67b7d@gmail.com>
Date:   Tue, 1 Nov 2022 19:49:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v3 5/5] wifi: rtl8xxxu: Use dev_info instead of pr_info
To:     Kalle Valo <kvalo@kernel.org>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Jes Sorensen <Jes.Sorensen@gmail.com>
References: <d1cfc9ef-dfc1-b3dc-c471-fe18aee8962e@gmail.com>
 <f5ceeb63-bfd2-0fe5-c88b-2bc4c9c7c46a@gmail.com> <87iljzudxl.fsf@kernel.org>
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <87iljzudxl.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 01/11/2022 13:11, Kalle Valo wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> writes:
> 
>> Replace two instances of bare pr_info with dev_info.
>>
>> Also make their messages a little more informative.
>>
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> 
> [...]
> 
>> @@ -5420,7 +5421,8 @@ static void rtl8xxxu_rx_urb_work(struct work_struct *work)
>>  			rtl8xxxu_queue_rx_urb(priv, rx_urb);
>>  			break;
>>  		default:
>> -			pr_info("failed to requeue urb %i\n", ret);
>> +			dev_info(&priv->udev->dev,
>> +				 "failed to requeue urb with error %i\n", ret);
> 
> Should this be dev_warn()? It looks like a warning.
> 
Probably yes. I'll do that and also rebase everything.
