Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 722627019B1
	for <lists+linux-wireless@lfdr.de>; Sat, 13 May 2023 22:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjEMUm2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 13 May 2023 16:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjEMUmY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 13 May 2023 16:42:24 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338632D48
        for <linux-wireless@vger.kernel.org>; Sat, 13 May 2023 13:42:23 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3090d3e9c92so706148f8f.2
        for <linux-wireless@vger.kernel.org>; Sat, 13 May 2023 13:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684010541; x=1686602541;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5NuTlZARGpYtUbpAIisRPiVEsNcUwoEdVoK2pjpcdRU=;
        b=Ep52cXoba4uBbzZcxaTLRENd1XOPDjhv07p9JQ3+tE40WS2jeh15aVTzTQAfeB54rS
         7IzGwiunWRvPFU+Wz4wgIwAH4f9FcRwhw70LHyqV3o5gx2syrbVBM3KfLNLF8fQXyHwT
         cctUn4yunXU8QCFvwYizfPDk9uK0RcNpXbE9EZNL8vo0jcar5+4WzEHk7X0a5Sy7CDkb
         GNQouKDlx+oWuZftZHuJYI8HFYb4+QdFTMlmScT8tgmJuRVp9gRhHgwJgFlpCAldSiXU
         S3UNqKlUAx0V4zwbrMnkNFQTacPeoBzttvoUE5groNstF90zQn6U9y4yKyRCKQiNR7hQ
         rEOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684010541; x=1686602541;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5NuTlZARGpYtUbpAIisRPiVEsNcUwoEdVoK2pjpcdRU=;
        b=HBBGxq8gX0bOW/fMJzMgTQVynFhN0mU51U94HBJRAHEaFV8LOwORZqp3pde8Xg6uzF
         vz6/UZ/6pjuU+EYdVKoKHWqRzeLm8ag9OPzeoNlNVGCdndleVcbO97VSX6nbo2VGNHU3
         POkz/C1CU9wJ2jRCXrPVOEeseBDZeQ+A2/E4xuNxtNNij9ATsCd/emQeGMSwjua7THY3
         NHWx7ZugEVabXm0pLFMDGpomddYxvGBvALgYvjKBXoTIaBeEd67tFrEEbWc1hqbzZRJ6
         Wzb05YUOB63+Nal6wYMaLxoDlt2Zrw9QnZ85NyRCvqGRauAFG4cirBDdS42WmsqOdr0d
         ulpA==
X-Gm-Message-State: AC+VfDx/pK/2VgyD8dMrUyCTOXEUkAgGT+u3voHs7JTZEVu1m5R38YOy
        zo6knPLu+b5iglbHV620UOI=
X-Google-Smtp-Source: ACHHUZ7Hm2p/yqyNr7B84fMRzXA8pAK1dIZ8nppCzROrnsRZ86S4eHsROvXTZ5+WQtV+vb65bHMClA==
X-Received: by 2002:adf:d846:0:b0:307:8651:258e with SMTP id k6-20020adfd846000000b003078651258emr17863599wrl.21.1684010541374;
        Sat, 13 May 2023 13:42:21 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.55])
        by smtp.gmail.com with ESMTPSA id v3-20020adfebc3000000b00307c0afc030sm10360315wrn.4.2023.05.13.13.42.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 May 2023 13:42:20 -0700 (PDT)
Message-ID: <f19bb9e3-a706-2a22-c1fb-029b77719831@gmail.com>
Date:   Sat, 13 May 2023 23:42:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 1/2] wifi: rtl8xxxu: Support new chip RTL8192FU
To:     Ping-Ke Shih <pkshih@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     "Jes.Sorensen@gmail.com" <Jes.Sorensen@gmail.com>
References: <98eff876-bb91-f51a-ffe9-b37d27518f9d@gmail.com>
 <094340810bbcbb7d85dd9c9c06b48d3a19aadd85.camel@realtek.com>
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <094340810bbcbb7d85dd9c9c06b48d3a19aadd85.camel@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 13/05/2023 09:13, Ping-Ke Shih wrote:
> On Fri, 2023-05-12 at 20:07 +0300, Bitterblue Smith wrote:
>> External mail.
>>
>>
>>
>> This is a newer chip, similar to the RTL8710BU in that it uses the same
>> PHY status structs.
>>
>> Features: 2.4 GHz, b/g/n mode, 2T2R, 300 Mbps.
>>
>> It can allegedly have Bluetooth, but that's not implemented here.
>>
>> This chip can have many RFE (RF front end) types, of which types 1
>> and 5 are the only ones tested. Many of the other types need different
>> initialisation tables. They can be added if someone wants them.
>>
>> The vendor driver v5.8.6.2_35538.20191028_COEX20190910-0d02 from
>> https://github.com/BrightX/rtl8192fu was used as reference, with
>> additional device IDs taken from
>> https://github.com/kelebek333/rtl8192fu-dkms.
>>
>> The vendor driver also claims to support devices with ID 0bda:a725,
>> but that is found in some bluetooth-only devices, so it's not supported
>> here.
>>
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> ---
>> v3:
>>  - Rebase on top of wireless-next.
>>  - Mark device 0b05:18b1 and RFE type 1 (ASUS USB-N13 C1) as tested.
>>
>> v2:
>>  - Feedback from Ping-Ke Shih:
>>    - Add rtl8xxxu_8192f.o to Makefile.
>>    - Initialise variable channel_idx in rtl8192fu_config_kfree() and
>>      variable ledcfg in rtl8192fu_led_brightness_set() to avoid
>>      warnings.
>>    - Give names to a lot of registers.
>>    - Initialise bb_gain_for_path in rtl8192fu_config_kfree() in two
>>      steps.
>>    - Don't assign the return value of rtl8xxxu_write32_mask() to
>>      variable val32 in rtl8xxxu_fill_iqk_matrix_b().
>>  - Add more information about device IDs to the commit message.
>> ---
>>  drivers/net/wireless/realtek/rtl8xxxu/Kconfig |    3 +-
>>  .../net/wireless/realtek/rtl8xxxu/Makefile    |    2 +-
>>  .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  |   47 +
>>  .../realtek/rtl8xxxu/rtl8xxxu_8188f.c         |    3 +-
>>  .../realtek/rtl8xxxu/rtl8xxxu_8192f.c         | 2090 +++++++++++++++++
>>  .../realtek/rtl8xxxu/rtl8xxxu_8710b.c         |    1 +
>>  .../realtek/rtl8xxxu/rtl8xxxu_8723b.c         |    1 +
>>  .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c |  107 +-
>>  .../wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h |   39 +
>>  9 files changed, 2262 insertions(+), 31 deletions(-)
>>  create mode 100644 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192f.c
>>
>>
> 
> [...]
> 
>> @@ -7484,6 +7522,9 @@ static int rtl8xxxu_probe(struct usb_interface *interface,
>>                 if (id->idProduct == 0x0109)
>>                         untested = 0;
>>                 break;
>> +       case 0x0b05:
>> +               if (id->idProduct == 0x18f1)
>> +                       untested = 0;
> 
> 'break;' is missing. 
> 

Ah, sorry about that.

>>         default:
>>                 break;
>>         }
>>
> 
> [...]
> 

