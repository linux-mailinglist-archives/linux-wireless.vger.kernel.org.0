Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF3762ED3F
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Nov 2022 06:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240819AbiKRFlo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Nov 2022 00:41:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235063AbiKRFlm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Nov 2022 00:41:42 -0500
Received: from mog.warmcat.com (mog.warmcat.com [178.170.10.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D9F6319008
        for <linux-wireless@vger.kernel.org>; Thu, 17 Nov 2022 21:41:40 -0800 (PST)
Received: from mx.warmcat.com (host31-53-12-215.range31-53.btcentralplus.com [31.53.12.215])
        by mog.warmcat.com (Postfix) with ESMTPSA id 93D5913562B;
        Fri, 18 Nov 2022 05:41:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mog.warmcat.com 93D5913562B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=warmcat.com;
        s=default; t=1668750099;
        bh=8lzjj/iK/2JCh1w3wY2gfsTZakaw3H1rYuxjYSt2i1o=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FxQJv/5/R7e4rqcmsTEc5xduyHkfjfxPjiemCqbHgXdgAW68eqHAWU7NvrPmb0yhX
         TeTadfuAAU4sLQlCMLp/PQsp9JYzhZlK+clMSKZEEjgSFm2n/kD8TOPEAJ01nfBjg1
         OyxgnV6djaNFv50y6gGIyqFqn12u+EH3QdCjqtCo=
Received: from [192.168.4.115] (unknown [192.168.4.115])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by mx.warmcat.com (Postfix) with ESMTPSA id C164C2A0069;
        Fri, 18 Nov 2022 05:41:38 +0000 (GMT)
Message-ID: <3a562a50-0cef-4879-3691-3258596f5213@warmcat.com>
Date:   Fri, 18 Nov 2022 05:41:37 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: AP6275 / bcm43752 pcie on mainline brcmf
Content-Language: en-US
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>,
        Shengyu Qu <wiagn233@outlook.com>
Cc:     franky.lin@broadcom.com, linux-wireless@vger.kernel.org
References: <TY3P286MB26114DD461F50814980453E598029@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <08416710-655a-c87c-a599-3fe2563f7de4@warmcat.com>
 <18470a1e910.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <TY3P286MB26115A58795F264893CCB40198029@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <184720fc920.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <TY3P286MB26118BD94839F752CADCCF5298079@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <625f1d5d-e137-7ad7-96b9-92035e87df8b@broadcom.com>
 <638afa8e-a393-410c-3182-0d8e9b6da17d@warmcat.com>
 <1848793db88.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
From:   Andy Green <andy@warmcat.com>
In-Reply-To: <1848793db88.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 11/17/22 21:52, Arend Van Spriel wrote:

> I see. So could you load bcmdhd and provide log. Preferably with higher 
> debug level. It also has a module parameter for it. I think it is called 
> dhd_msg_level and please set it to 0x817.

It's here:

https://warmcat.com/ap6275p-dhd-log1.txt

after boot he shows a wlan0

wlan0: flags=-28669<UP,BROADCAST,MULTICAST,DYNAMIC>  mtu 1500
         inet6 fe80::d69c:ddff:fef5:bf7e  prefixlen 64  scopeid 0x20<link>
         ether d4:9c:dd:f5:bf:7e  txqueuelen 1000  (Ethernet)
         RX packets 0  bytes 0 (0.0 B)
         RX errors 0  dropped 0  overruns 0  frame 0
         TX packets 11  bytes 866 (866.0 B)
         TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

The dhd OOT driver comes with a rockchip-hacked rfkill driver which has 
all sorts of things in it related to wakelocks I removed, I built that 
too and rfkill reports

# rfkill
ID TYPE DEVICE           SOFT      HARD
  0 wlan phy0          blocked unblocked
  1 wlan brcmfmac-wifi blocked unblocked

"brcmfmac-wifi" is a literal in the dhd driver sources, confusingly. 
Mainline brcmfmac is not built or inserted as a module for this test.

# rfkill unblock

shows everything unblocked, but connmanctl can start scans but never get 
any results.  But it's happy with the firmware after hacking it to use 
updated apis.

-Andy
