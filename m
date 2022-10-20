Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C670C605F1B
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Oct 2022 13:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbiJTLkU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Oct 2022 07:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbiJTLkR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Oct 2022 07:40:17 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 685E9FA007
        for <linux-wireless@vger.kernel.org>; Thu, 20 Oct 2022 04:40:07 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id bv10so33866273wrb.4
        for <linux-wireless@vger.kernel.org>; Thu, 20 Oct 2022 04:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UjYqUKvxLNskMjI6I5IrHriniS8ndvAfPluCUfkW4o4=;
        b=P5fT4b6qqCxqOVNPE/to/2Y4roKZyHPq92FHtu2TXGH24BF8j78htdlcxgV+6N0z6q
         OmbKtr1/Q8SFYseVVofmbrLcUvNIkYOJ9agF/NLAeJOJQrpwL2Ln9ZcXDBT13kYcN16h
         PEXjBjs4R9Bc30hiSR0BBY3pmpQVXTGFj64cnTphufGws2jDmA+zWueig/1gb2eLjYIK
         3gNoRGQQlXqRpX+ig6fzvhY9L2pbCZeGJmBBdNvilBXix/8R/ZYCeVpOim782NKGy4Dc
         6het/BB1tpYTccJxIc6jLSGZ9a1EIx5VYfzp05ff4fZ04VHnxpOb1ci6K9+fzfopaWBR
         sTDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UjYqUKvxLNskMjI6I5IrHriniS8ndvAfPluCUfkW4o4=;
        b=dmgg2Q2J74QGNASYS1XR8ZrxQuZTym9yp2EjGYn2hpCDcTkWdciDNpH2Mo72TDHOJe
         w8GszeZEjuDPCPSVedfjve+4TUR1DbBo/xWViNznliwpRLHMit+FpfpswikrFxhtxNn1
         /4ViETRqzvKo7dOd8Zpg/uittcEladZzyWdRUvwt9X4flSVpdIc3soRD/S92ng6L7JXI
         4ceR34owwDdvrRB68iYSOMJ0yjr7hocNRUtaRz2IKEcwBuFy8sIYkkU8goJs/iFwWc1z
         k9Cwzk8e3V2HBdlaThVDqIFWO/EqDtLk762E8JmOhqMNsryBMH2OR+Nw2OaAWHOooBkZ
         LJnw==
X-Gm-Message-State: ACrzQf2FqMlfUj4xejtr0s4kIqrYPhdasrS2198pdOBsgfGrxr5MqTYJ
        aheDZqfXq67fWp+T/Y5Pc0s=
X-Google-Smtp-Source: AMsMyM48baiRdfHYtqF2MqEMAbOFK06dF+eFUMnj8wdLRbLV3tKVqoWSL6GN/Naa4N0XZEe1FEqWyA==
X-Received: by 2002:a05:6000:1ac9:b0:22e:3d0c:43ed with SMTP id i9-20020a0560001ac900b0022e3d0c43edmr8290536wry.34.1666266005517;
        Thu, 20 Oct 2022 04:40:05 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.23])
        by smtp.gmail.com with ESMTPSA id g11-20020a5d488b000000b0022eafed36ebsm16232058wrq.73.2022.10.20.04.40.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 04:40:05 -0700 (PDT)
Message-ID: <a78a5526-a278-eaf8-89f6-45c64f44df15@gmail.com>
Date:   Thu, 20 Oct 2022 14:40:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: rtl8xxxu: Should it support RTL8188EU?
To:     Jes Sorensen <jes.sorensen@gmail.com>,
        linux-wireless@vger.kernel.org
Cc:     Larry Finger <Larry.Finger@lwfinger.net>
References: <2999b8e8-5706-8bfb-c3a5-5c547ab0a170@gmail.com>
 <012874df-59d4-8973-3dee-48f42208f9fc@gmail.com>
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <012874df-59d4-8973-3dee-48f42208f9fc@gmail.com>
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

On 03/10/2022 16:12, Jes Sorensen wrote:
> On 10/1/22 17:42, Bitterblue Smith wrote:
>> Considering there is a driver for RTL8188EU already in staging,
>> which people have been whittling down, should I put any effort
>> into adding support to rtl8xxxu?
>>
>> It's actually mostly working already [0], but rtl8xxxu doesn't
>> have AP mode, adhoc mode, power saving, etc so it wouldn't be
>> necessarily better than the driver in staging.
>>
>> [0] https://git.kernel.org/pub/scm/linux/kernel/git/jes/linux.git/log/drivers/net/wireless/realtek/rtl8xxxu?h=rtl8xxxu-8188eu
> 
> The staging driver is based on the vendor driver which is rather
> dreadful. Given the similarity of the chips, it feels really silly to
> have a second driver for just one chip.
> 
> I see no reason to abandon 8188eu support in rtl8xxxu, but given my
> total lack of time, I am also not able to invest in it.
> 
> Cheers,
> Jes
> 

So now I actually tested r8188eu and it's so bad. Why are people
spending so much time cleaning up a driver that doesn't work well?
With the default module parameters it had 35% packet loss with the
router 3 meters away in the same room. With rtw_power_mgnt=0 the
packet loss is gone but the speed is still disappointing: less than
50 megabits/second download, 65-70 upload, and it's unsteady.

The v5.2.2.4 driver from Larry Finger's repo works much better:
no packet loss and a steady 95 and 85 megabits/second in the same
conditions.

I'll get started then.
