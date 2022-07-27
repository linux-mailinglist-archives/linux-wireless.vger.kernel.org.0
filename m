Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEDB5824A4
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Jul 2022 12:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbiG0Klx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Jul 2022 06:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbiG0Klw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Jul 2022 06:41:52 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B3A6394
        for <linux-wireless@vger.kernel.org>; Wed, 27 Jul 2022 03:41:51 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id b26so23618306wrc.2
        for <linux-wireless@vger.kernel.org>; Wed, 27 Jul 2022 03:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=C3NUktwRjBAbIBvxFHwWcCMixWsyP7XViG7rd8WMaaQ=;
        b=KDrZtmDfrCRxU7XODweFUsiX0rpqq1ezKwGO2qnMe9zrVkogfs1Gph6YC5b1bEJoLJ
         FJ/SsRgZngrasAdsPpHDbgxQecl9cjV53C8XCRBPrOjxsFqU/seeotVI+HfZxczjuVpR
         fhwPM1HQo4XthMlz7bIZrBCsDLE/P17aJlRcpeRan4rtMHXMtxmqou4CfA1slEWXt3H3
         87s5rPJP+1AExIbT+f/RW6085cIOXdGe8x3Km+00SrrER3ZifZ4KYmClCEQ1jvaBNSE6
         tdQ4nHSEhUu1WmAhLgJXHA8AlQfB9gEmFK8LRS9pzMDW9ZbHJgcIG8r70uZZJLjNA+tl
         P/yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=C3NUktwRjBAbIBvxFHwWcCMixWsyP7XViG7rd8WMaaQ=;
        b=zPtKGm6yRakhn2F3OgVfiyWFvH/UkT706D39r/ikLCLKuc9hBxtpCuhzHxiHy0yZxc
         0vN4RwkYccu2UpFLaF0t1P18JLe40YJDGwqjLOBhnKpnXcwP67MfF2an1Lz34SbVPxu+
         p2H9ObZCu+YLiTjH6rGCWS9P3tZI8WRQK6Pt5H1pU1MW+5uMEPW0aIakqkVvB0suueH1
         zWpMJhrNPBymRKXZay1DLt6EWZ6ln6o9vm2yPBeASr64NRSHjcqO0jsMZgLh8JEsbKv0
         t9NDjRgzBhECL3IrRf6H/DqMgpTuV7uVe5CyMTO3nuxm77zaauyoj1WqTe/J2yTBXniY
         +kEQ==
X-Gm-Message-State: AJIora/WJwutgH6noBP4FJGjmGYif3CUDy9MG+TiE1EAJrRgTk5hojpx
        mpx6R+6fFWVvhbtv51kHfAHdaQ==
X-Google-Smtp-Source: AGRyM1so1lPt1QB16VUYUxms7cNmUGtmW38OfIx722tzIlDQZ/I0T5HJz46Xaq/4W88RsuW0gAYDkA==
X-Received: by 2002:a5d:64a3:0:b0:21d:ad9e:afd7 with SMTP id m3-20020a5d64a3000000b0021dad9eafd7mr13312763wrp.524.1658918510332;
        Wed, 27 Jul 2022 03:41:50 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id w7-20020adfec47000000b0021e9fafa601sm4081449wrn.22.2022.07.27.03.41.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jul 2022 03:41:49 -0700 (PDT)
Message-ID: <582e56e7-87d1-e6b3-ac7a-00fe07a10a14@linaro.org>
Date:   Wed, 27 Jul 2022 11:41:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 4/4] wcn36xx: Add debugfs entry to read firmware
 feature strings
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
Cc:     loic.poulain@linaro.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
References: <20220719143302.2071223-1-bryan.odonoghue@linaro.org>
 <20220719143302.2071223-5-bryan.odonoghue@linaro.org>
 <87k07yq230.fsf@kernel.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <87k07yq230.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 27/07/2022 11:31, Kalle Valo wrote:
> Bryan O'Donoghue <bryan.odonoghue@linaro.org> writes:

>> +static ssize_t read_file_firmware_feature_caps(struct file *file,
>> +					       char __user *user_buf,
>> +					       size_t count, loff_t *ppos)
>> +{
>> +	struct wcn36xx *wcn = file->private_data;
>> +	unsigned long page = get_zeroed_page(GFP_KERNEL);
>> +	char *p = (char *)page;
>> +	int i;
>> +	int ret;
>> +
>> +	if (!p)
>> +		return -ENOMEM;
>> +
>> +	mutex_lock(&wcn->hal_mutex);
>> +	for (i = 0; i < MAX_FEATURE_SUPPORTED; i++) {
>> +		if (wcn36xx_firmware_get_feat_caps(wcn->fw_feat_caps, i)) {
>> +			p += sprintf(p, "%s\n",
>> +				     wcn36xx_firmware_get_cap_name(i));
>> +		}
>> +	}
>> +	mutex_unlock(&wcn->hal_mutex);
>> +
>> +	ret = simple_read_from_buffer(user_buf, count, ppos, (char *)page,
>> +				      (unsigned long)p - page);
>> +
>> +	free_page(page);
>> +	return ret;
>> +}
> 
> Why not use the normal use kzalloc() and kfree()? That way you would not
> need a separate page variable. What's the benefit from
> get_zeroed_page()?


TBH I did a copy/paste here from another driver... I forget which
> 
> Also I don't see any checks for a memory allocation failure.
> 

its there

char *p = (char*) page;

if (!p)
     return -ENOMEM;

I can V2 this for kzalloc and kfree if you prefer though

---
bod
