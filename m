Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71D66F0A8C
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Apr 2023 19:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244039AbjD0RNK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Apr 2023 13:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239857AbjD0RNI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Apr 2023 13:13:08 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0DE1990
        for <linux-wireless@vger.kernel.org>; Thu, 27 Apr 2023 10:13:07 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f18dacd392so55231815e9.0
        for <linux-wireless@vger.kernel.org>; Thu, 27 Apr 2023 10:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682615586; x=1685207586;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/UV+AYmavyUzsXww01pZooZyjBVF20AHDsdPv9PE5Gk=;
        b=l10oac2JORqGpXUELSvSCY8r0wZiIPaphflz7admd8ONPJyIcHYH1MTng49R97tmbX
         rpi5xYKEylgh/0sEpz7KczjS/mI1YYwOeq7dzIzLDSZfxGIVnJUQOFDZJhPaqa2ituKK
         Oe4iA67vvlwZmF1WapsD7LbGIuo7J/GjRRJJaf8LNW5QPq/hXT10PZr43PsBd4eQshnN
         uRAg1Kcchyk27LijtsuMlx66VITGxMdZOpFImwrpAj4r8+tdZYLgPHhKj/RemNrWD3jO
         Wu2/RMQHUi6dHir8pixkcPljGshqSvzAlXPN8Ue5kPATh6s377ViMLWYKZBAMwRhBYG3
         eHKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682615586; x=1685207586;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/UV+AYmavyUzsXww01pZooZyjBVF20AHDsdPv9PE5Gk=;
        b=clu+JredJlKJbPrM0JOL4025zIZ2fc+tVcBEU/Kr0m4DiKOkif2bevmwShfvUQTTkO
         HFIj+JYDAUUFHV0Eg/wQoiPXm1QKMpRU5VEP2jYh5rbUbG5cPmlbTBwuRgzTs6FbHXva
         dQ3oW2XIQfXmBAtUGu6rxlzjjuDXFFMPHfwelp3pvrqWSwgzUBRC50oT+jgeDdV0SM8I
         xc/GOygiijTzSuMdL0F+B8mG7g8jpa17acSwMqJixtjFDJoKB55Dy6DMIOT8amWUzddq
         UFM/L6yQZNYDitq44sKV1op1XStuaoSdT4DufMK2ppnPve6lAZHHlCgrOG7OpvvjSk2S
         S4Kg==
X-Gm-Message-State: AC+VfDyQeaREAD4ORnPIcIgRgn0Is2g2Bq/ttBuek8B6VZYOLL5/onmu
        noLgtYjhGTe1TRezURA/3YHqFnE4tDA=
X-Google-Smtp-Source: ACHHUZ7HwCs5JZFrTCDscwEex47dlRqRPiRllG2B+WAzhWex/1ID9rH+WS8NWvfeL2tN2K79xCoW+Q==
X-Received: by 2002:a7b:ca56:0:b0:3f1:6fea:790a with SMTP id m22-20020a7bca56000000b003f16fea790amr1987861wml.30.1682615585993;
        Thu, 27 Apr 2023 10:13:05 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.55])
        by smtp.gmail.com with ESMTPSA id t10-20020a05600c198a00b003f16932fe7dsm25606429wmq.38.2023.04.27.10.13.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Apr 2023 10:13:05 -0700 (PDT)
Message-ID: <0ce23546-7bf6-ef96-9417-c62adaa77cb6@gmail.com>
Date:   Thu, 27 Apr 2023 20:13:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: RTL8188EU (LogiLink WL0151A) - Malformed packets
To:     Artem Makhutov <artem.makhutov@gmail.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <CALbLcfAXrHp4vsVGqU0nBdB_gFmKTKx0GcdrFJA7R_kodAy0Ew@mail.gmail.com>
 <bfe732f4-60dd-4d78-1259-5f9f6c11adbc@gmail.com>
 <CALbLcfB7cMctHC-Fv93z1WVCZkQ76uW2F_=P6rCW7ZSPXvmapw@mail.gmail.com>
 <2857f998-1b1a-e3c2-20fe-d03dadcf8f23@gmail.com>
 <CALbLcfCsyGzhvrqjSz37+7cLvc3rc4Y_kgspZV=kiPNs4TBE4w@mail.gmail.com>
 <CALbLcfBnF6njFMSfQk2TuOiZ3C3kHwqs4-c-MQGb72azzQ5sJA@mail.gmail.com>
 <38172c8e-d107-d96e-7292-09d0e3b061dd@gmail.com>
 <CALbLcfCHLU+zoFdTnTrJs22UUYwr2rETp5hqbv=NL352Qz-XgA@mail.gmail.com>
 <CALbLcfDZJmOyn-Gf24+9X-eHh3-3PY4_nP5soG3gHf_Vn85=EA@mail.gmail.com>
 <CALbLcfAiVgGi9iocEG4OfgET2XLDRq0dthbxDMP0vP3R6BBp_A@mail.gmail.com>
 <3ceecfc1-ab04-7d54-51bd-457a4708c0ac@gmail.com>
 <CALbLcfCpb8xbN+w2VvCZ6Gdr+L_ECH0UQsWZrpO1Hcpoef66UQ@mail.gmail.com>
 <8eaeb64e-3f7f-6752-4476-c0f0c88a008b@gmail.com>
 <CALbLcfD7AmMG72-Qxafc9533OQVBCL=RLDycjUCV2MJ0DRN6nw@mail.gmail.com>
 <2a679614-c964-dc3f-c987-6c7ee03923a0@gmail.com>
 <CALbLcfBGg8FTBZx-_8v6u5iLsAssr+=QgQYc+Q2bUbmEwJPRYQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CALbLcfBGg8FTBZx-_8v6u5iLsAssr+=QgQYc+Q2bUbmEwJPRYQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 25/04/2023 12:04, Artem Makhutov wrote:
> Hi,
> 
>>> As a workaround: What about checking the IP length field. If the
>>> received packet is smaller by 4 bytes than what it should be then just
>>> add extra 4 bytes at the end? Or does the MIC at the end have any
>>> influence on anything?
>>
>> That should work, but it's ugly.
> 
> I did it and it is working, and yes, it is ugly :)
> 
>> If the router lets you change the MTU, does it help to make it smaller?
> 
> No, this is a bad idea. It will bring a lot of other issues.
> 
>> Do you have the problem with the v5.13.3 driver? If it works (other
>> than completely dying after a while) we should see what it does
>> differently compared to the v5.2.2.4 driver.
> 
> The v5.13.3 does not have this problem.
> 
> I have tested 3 different approaches and also made some quick speed tests:
> 
> 1: I changed the skb length according the IP header so the packet is complete
> 2: Disabled ht by sband->ht_cap.ht_supported = false;
> 3: Tested v5.13.3 driver
> 
> Speedtests with iperf:
> IP header hack:
> 24.5 Mbits/sec
> 
> HT hack:
> 18.7 Mbits/sec
> 
> v5.13.3 driver:
> 54.6 Mbits/sec
> 
> The v5.13.3 driver has the highest speed and does not have the missing
> bytes bug. So it does something different...

I had another idea. Does this help?

diff --git a/rtl8xxxu_core.c b/rtl8xxxu_core.c
index cbf39ff..91878cf 100644
--- a/rtl8xxxu_core.c
+++ b/rtl8xxxu_core.c
@@ -4202,6 +4202,8 @@ static int rtl8xxxu_init_device(struct ieee80211_hw *hw)
 	val32 = RCR_ACCEPT_PHYS_MATCH | RCR_ACCEPT_MCAST | RCR_ACCEPT_BCAST |
 		RCR_ACCEPT_MGMT_FRAME | RCR_HTC_LOC_CTRL |
 		RCR_APPEND_PHYSTAT | RCR_APPEND_ICV | RCR_APPEND_MIC;
+	if (priv->rtl_chip == RTL8188E)
+		val32 &= ~RCR_APPEND_MIC;
 	rtl8xxxu_write32(priv, REG_RCR, val32);
 
 	if (fops->init_reg_rxfltmap) {
@@ -6197,6 +6199,8 @@ int rtl8xxxu_parse_rxdesc16(struct rtl8xxxu_priv *priv, struct sk_buff *skb)
 
 			rx_status->mactime = rx_desc->tsfl;
 			rx_status->flag |= RX_FLAG_MACTIME_START;
+			if (priv->rtl_chip == RTL8188E)
+				rx_status->flag |= RX_FLAG_MIC_STRIPPED;
 
 			if (!rx_desc->swdec)
 				rx_status->flag |= RX_FLAG_DECRYPTED;

