Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 387E36C6E79
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Mar 2023 18:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbjCWRNN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Mar 2023 13:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbjCWRNI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Mar 2023 13:13:08 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32FD2113E0
        for <linux-wireless@vger.kernel.org>; Thu, 23 Mar 2023 10:12:59 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id w9so89902953edc.3
        for <linux-wireless@vger.kernel.org>; Thu, 23 Mar 2023 10:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679591578;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4/W/awWX4W+zcuM+R3yDEDWYh82OlCjaf/hYhhVRfbo=;
        b=giKoCEmKF7byyJX8t98yerTiXDPDJFNEBrOexfrAyiDONEvmrPC1jeUi6/F0DULmlj
         aR+yHePTI+xfXyF6wOCrLj65ES0VX82gFwZWjk18rC/9KiNMnmJLKuS3Vp+perqI2IXN
         WpXU8sNvOxVqfcbA1riOIDNccpOnVk3ayot1dCmqJGkVjXLZ5ivbwEdgl5PC7JW5SOV6
         b0PRwsVTXLe849Bm6mFTfRHIMYka4zO/MNg2h8OTKbEPA1lurX1bAMka5C6VDNgblKf5
         fUvxCCUjlsq4hr6X13LyiGFOvvIsvmlG8e/1XxQsPPOHIJ3lnyzGk1E/yzaU7XA3e5EZ
         CGVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679591578;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4/W/awWX4W+zcuM+R3yDEDWYh82OlCjaf/hYhhVRfbo=;
        b=Z74LUDGLrrZqTP0sxy1oFRWzjIlR0roNFImujq9bjBXXVf1jRaZD4APWV+7vwbGRV2
         9jWTbD3wj2c9usur9YHz61evt/qFE5srNbyKS40/hps9QE9d+AsuugzGbBXy+inyRllo
         WpgQzf/peFNqR/xDC6Tr18mgBsNRlQrcQ6p2vSPfuGdTPbs4hzoYuJdMv23VFAbTrlJR
         uHQhcT5+iC861TxKBq+r6Ew8VVLv8z+rCpKqejNlK2Iv3HDiLMIYkgst/gREp7CQkasq
         l6N0FjY1B1Z2xjehEqQXOs1RvQxpkZpRgJwswAG0uDB9FjD6WzQRMglxDBtzDrVTEOY7
         htQg==
X-Gm-Message-State: AO0yUKUq8JqLPl1VNY/+HH6FEFdUIw16CBqm5DksCnauosBFimYR2Fnp
        Ei6oPepeJV6K7RpQ1LT4Xiw=
X-Google-Smtp-Source: AK7set84P+dSjKr22IQLbamFi+TVaJpRVwynVkalskSxKdgUyrVcaBAauQAsapuErmuC5XZGnX5OQA==
X-Received: by 2002:a17:906:f6da:b0:8de:e66a:ece9 with SMTP id jo26-20020a170906f6da00b008dee66aece9mr10956574ejb.24.1679591578249;
        Thu, 23 Mar 2023 10:12:58 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.55])
        by smtp.gmail.com with ESMTPSA id z26-20020a17090674da00b009310d4dece9sm8904244ejl.62.2023.03.23.10.12.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 10:12:57 -0700 (PDT)
Message-ID: <bbcc03ad-3003-c26e-3b8d-d2340243c8bf@gmail.com>
Date:   Thu, 23 Mar 2023 19:12:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: [RFC PATCH 00/14] wifi: rtl8xxxu: Add AP mode support for 8188f
To:     Martin Kaistra <martin.kaistra@linutronix.de>,
        linux-wireless@vger.kernel.org
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20230322171905.492855-1-martin.kaistra@linutronix.de>
Content-Language: en-US
In-Reply-To: <20230322171905.492855-1-martin.kaistra@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 22/03/2023 19:18, Martin Kaistra wrote:
> This series intends to bring AP mode support to the rtl8xxxu driver,
> more specifically for the 8188f, because this is the HW I have.
> The work is based on the vendor driver as I do not have access to
> datasheets.
> 
> This is an RFC, so that there can be a discussion first before
> potentially implementing support for the other chips in this driver, if
> required.
> 

Hi!

I ran into some problems while testing this.

First, a null pointer dereference in rtl8xxxu_config_filter() when
turning on the AP. priv->vif was NULL:

	if (priv->vif->type != NL80211_IFTYPE_AP) {

I changed it like this:

	if (priv->vif && priv->vif->type != NL80211_IFTYPE_AP) {

Then I was able to turn on the AP and connect my phone to it. However,
the system froze after a few seconds. I had `journalctl --follow`
running. The last thing printed before the system froze was the DHCP
stuff (discover, offer, request, ack). The phone said it was connected,
but speedtest.net didn't have time to load before the freeze.

My system is a laptop with RTL8822CE internal wifi card connected to my
ISP's router. The connections are managed by NetworkManager 1.42.4-1,
which uses wpa_supplicant 2:2.10-8 and dnsmasq 2.89-1. The operating
system is Arch Linux running kernel 6.2.5-arch1-1.

I used Plasma's NetworkManager applet to create a new "Wi-Fi (shared)"
connection with mode "Access Point", band 2.4 GHz, channel 1, no
encryption, and "IPv4 is required for this connection".


Unrelated to anything, just out of curiosity, what brand/model is your
RTL8188FU?
