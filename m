Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0590872EB04
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jun 2023 20:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbjFMS3Q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Jun 2023 14:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232924AbjFMS3O (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Jun 2023 14:29:14 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F099E1709
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jun 2023 11:29:13 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1a694ac3238so1985170fac.3
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jun 2023 11:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686680953; x=1689272953;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=TPk4mgdBLNFYseP/hsh3OVeTLpGIYx4k3HWN7Myz56w=;
        b=g/gHHMyndM5ru3FdjxSlLv/t2a6eX5pDNNTziA8Fr6JUjfuNG14MqrNesDYVR2NKnK
         eFlEpK6ly/BfZfQnnsXeZG7HOgLOZEEwjrwABJsHZeHlBLyIY6aRdhcjTlMa9/aSJOUv
         OsD9Jdm9Iduairc64X84FcWhnO+94U2XNpCVBInq4TCuqqGW5xze169sNSvc1cFE9YLd
         JSpSSBVAU0Np6yKhzYJ6qkqMOoIasDa4f6+ggLAtP4CianENTQjECzDp50OucqiLdS5U
         VXKO9sgWvov0L6lRgNRONduqYQyMQEW/1RImbvM01P3ylj/m76xDZMsgpwfPzYlJmjJD
         Dmxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686680953; x=1689272953;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TPk4mgdBLNFYseP/hsh3OVeTLpGIYx4k3HWN7Myz56w=;
        b=AiXqlaPT1iqwF9baFNLXsXs0I4lxPejkhNMSewzq9fAcsc6ZwADvHPEfJTYHsyeXxF
         vh+ENLNMJk0NUdRwN5F7XOWoH4p/d0H8Rj7ekMYMQ6pjpE4MRThwB9luEeu+W4CQUvXk
         8je1+20Y2zmE90PIdeu2RYygPJ6EUoe5naAGDZWxEft2zv1cE2Ussg8TK+bTizYhk+J1
         V+9X3jnKFLibpQ8HokojXF1ogpr7Mx9bBUFoBYfSwgbcY2nTrELVNmmBwm3WBmH6I/Ie
         MqnJTRY4EpfaS79UXSZsMu2MeNH1QHFWN8EmJ2our32Vs0J7Kec3AjWn7j1NaKETa0Jt
         0m1Q==
X-Gm-Message-State: AC+VfDy0LkN0xt9QsJMB9Z0xNFEIG3VwNapqTAUCF53itC3mGWM7cFzH
        FFozFsc0A0ES7KzW6JJJTdg=
X-Google-Smtp-Source: ACHHUZ671NJiBnQ90/50tMx2GPQFbXSlOxialvyRhpDT5X0Wx+Ze5ew/zhu3ogrg/9vbR2bX8/aPgA==
X-Received: by 2002:a05:6870:5b2f:b0:1a6:98de:e458 with SMTP id ds47-20020a0568705b2f00b001a698dee458mr4284367oab.8.1686680953250;
        Tue, 13 Jun 2023 11:29:13 -0700 (PDT)
Received: from [192.168.1.119] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id t14-20020a4ad0ae000000b0054fd0b7af2bsm4343490oor.31.2023.06.13.11.29.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 11:29:12 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <91f3ecc2-7ae4-b17d-acda-f3f7e4b48f6f@lwfinger.net>
Date:   Tue, 13 Jun 2023 13:29:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: Linux mainline support for RTL8811AU/RTL8821AU
To:     petter@technux.se, linux-wireless@vger.kernel.org
Cc:     pkshih@realtek.com, morrownr@gmail.com, kernel@pengutronix.de,
        kvalo@kernel.org, linux@ulli-kroll.de, petter.mabacker@esab.se,
        s.hauer@pengutronix.de
References: <20230613080907.328548-1-petter@technux.se>
Content-Language: en-US
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <20230613080907.328548-1-petter@technux.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 6/13/23 03:09, petter@technux.se wrote:
> Hi,
> 
> I'm investigating a wifi dongle (LM808) that is based on the RTL8811AU chipset.
> 
> $ lsusb
> ..
> Bus 003 Device 066: ID 0bda:a811 Realtek Semiconductor Corp. RTL8811AU 802.11a/b/g/n/ac WLAN Adapter
> ..
> 
> I cannot find any driver support in mainline for that chipset (8811cu/8821cu, seems to exists). Just curious if anyone knows if there are any ongoing efforts to get this driver included in mainline?
> 
> I can see that both:
> 
> https://www.lm-technologies.com/product/wifi-usb-adapter-433mbps-lm808/?template=driver
> 
> and
> 
> https://github.com/morrownr/8821au-20210708
> 
> exists for non-mainline support, so will play a bit with them. But for maintenance etc I'm interested to learn about possible mainline efforts within this area.

It seems that the RTW8821AE has never been built or released. If it had been, 
then extending that driver to the 8821AU would be easy as there would be a file 
rtw8821a.c that contained all the details of that chip. Without that, there is 
little that anyone outside Realtek can do. The vendor driver, which is the one 
in the link you posted, will likely work.

Larry

