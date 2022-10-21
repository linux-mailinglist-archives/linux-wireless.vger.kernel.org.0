Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805B8607D9F
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Oct 2022 19:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiJURgU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Oct 2022 13:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiJURgR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Oct 2022 13:36:17 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4797720F7F
        for <linux-wireless@vger.kernel.org>; Fri, 21 Oct 2022 10:36:15 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id q19so8532941edd.10
        for <linux-wireless@vger.kernel.org>; Fri, 21 Oct 2022 10:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+hVN4Rp1qTUaeBZzlHLy966oP8QWNGdOaseY1HNwOsk=;
        b=YoACzptUamGCnoY63E4R2mAM5zUM75R3joFT9zY3cTEeWoPIvy1H2R1YEvJQ28YYMp
         JjKvAM5wWbUrukfZWEc+A/hgjmpP+Hdx5/TqaYs8ctuoRc9rGWo35/e1u60EW1LlRE9S
         A0caCUq/OJJPidwyHKy+n5DxCQMZvDcw+/aFqFc+7C+sHQn+EoP0s/1Kz85F2+zM73f6
         FxZAiNYJzojif65iDc/cCOehEzfP6WmL4nd6DA2DB/vj665u2SMUPr46tTpiqo2j6M/w
         Dai4MrvgBfa4MIUSJTeywvnnPNPvRsj5gce43Z9+MSu+nuAm2BliomsARoUD3Ltwuguc
         BaXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+hVN4Rp1qTUaeBZzlHLy966oP8QWNGdOaseY1HNwOsk=;
        b=BhepzvmrGHqfTN4ixd1Aiu/sEggBcc1A8T5DO/9NDfazcGt5oX/32r0WwmBvXIZI54
         Nb2MnO6uwnSHjbX8n9fzQLusx8bXEpN1oSo6cbvy6StXx2x7F6qMhU1A1IRP+TDrnNda
         xUlSGiiC1puxPGy8U1vSjipO0tYBfBmlCQ9VRPG58sCZmaWOqG3jLWgZo/nJaKgjZRS+
         dOHW8n/8BdfZ2fs5qPHEVKxabX+/gU8LJZ2HhR944IMxRZHFb0t6/oH/N98PJmX064sH
         reKeKirK6/PrhYJIhMXtOttiw9XzK7EuEMZqLJ2+6lsKfxMq4uOVu24ITXW0mkbkJBJR
         LRIQ==
X-Gm-Message-State: ACrzQf2jbOAaoRJYYEp3lhJ1g29lAYAodUCVNuubkfExUFWVTlh26xKe
        +WKMpcLhgANoWRLy9IoEeOt8gF+EV1c=
X-Google-Smtp-Source: AMsMyM48djW0V4phv+srlaWvMLvtaCQI43eFJw9Afxt7924CyBDJt3e7+2wwWBZ4p35ZFJf+Uu35zQ==
X-Received: by 2002:a50:fe85:0:b0:458:5562:bf1e with SMTP id d5-20020a50fe85000000b004585562bf1emr18208022edt.167.1666373773780;
        Fri, 21 Oct 2022 10:36:13 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.23])
        by smtp.gmail.com with ESMTPSA id gc37-20020a1709072b2500b0077d6f628e14sm11870381ejc.83.2022.10.21.10.36.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Oct 2022 10:36:13 -0700 (PDT)
Message-ID: <db62da89-8d43-df82-5c41-01fa40244d10@gmail.com>
Date:   Fri, 21 Oct 2022 20:36:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 3/5] wifi: rtl8xxxu: Recognise all possible chip cuts
Content-Language: en-US
To:     Ping-Ke Shih <pkshih@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>
References: <2b29b6d9-c17e-76d6-c32f-630f24b407b7@gmail.com>
 <f7239792-028f-77dc-a86d-f89e3eeafa7d@gmail.com>
 <4294d0bed5e54862bb199bc2e8e4b6ae@realtek.com>
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <4294d0bed5e54862bb199bc2e8e4b6ae@realtek.com>
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

On 21/10/2022 08:31, Ping-Ke Shih wrote:
> 
> 
>> -----Original Message-----
>> From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> Sent: Monday, October 17, 2022 1:30 AM
>> To: linux-wireless@vger.kernel.org
>> Cc: Jes Sorensen <Jes.Sorensen@gmail.com>
>> Subject: [PATCH 3/5] wifi: rtl8xxxu: Recognise all possible chip cuts
>>
>> The chip cut, also known as the chip version, is a letter from A (0)
>> to P (15). Recognise them all instead of printing "unknown" when it's
>> greater than E.
>>
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> ---
>>  .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 27 +++++--------------
>>  1 file changed, 6 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> index 2efc99896b96..a8914650815e 100644
>> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> @@ -1573,31 +1573,16 @@ rtl8xxxu_set_spec_sifs(struct rtl8xxxu_priv *priv, u16 cck, u16 ofdm)
>>
>>  static void rtl8xxxu_print_chipinfo(struct rtl8xxxu_priv *priv)
>>  {
>> +	static const char cuts[16] = "ABCDEFGHIJKLMNOP";
>>  	struct device *dev = &priv->udev->dev;
>> -	char *cut;
>> +	char cut = '?';
>>
>> -	switch (priv->chip_cut) {
>> -	case 0:
>> -		cut = "A";
>> -		break;
>> -	case 1:
>> -		cut = "B";
>> -		break;
>> -	case 2:
>> -		cut = "C";
>> -		break;
>> -	case 3:
>> -		cut = "D";
>> -		break;
>> -	case 4:
>> -		cut = "E";
>> -		break;
>> -	default:
>> -		cut = "unknown";
>> -	}
>> +	/* Currently always true: chip_cut is 4 bits. */
>> +	if (priv->chip_cut <= 15)
>> +		cut = cuts[priv->chip_cut];
> 
> How about?
> 
>    cut = 'A' + priv->chip_cut;
> 
That works too.
