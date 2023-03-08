Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 672256B166C
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Mar 2023 00:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjCHXSf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Mar 2023 18:18:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjCHXSa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Mar 2023 18:18:30 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389771FCA
        for <linux-wireless@vger.kernel.org>; Wed,  8 Mar 2023 15:18:22 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id p26so48140wmc.4
        for <linux-wireless@vger.kernel.org>; Wed, 08 Mar 2023 15:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678317500; x=1680909500;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7IQLd/y1wF2Vv+Pb8fPKInE7oUtL7YCSx37c5DWA2oM=;
        b=ca0CFJaPLLfm8/sPJgszjlmvMSWdV5Tb0LCBYic7q3flQZpkx6yTRMH+qF0g+1Jcoc
         hMjSgZMhl40HTggsRAAVWZ09XCSXt7PV/kwV7j5BlXwTjJiijngkWo404govCKsL+OU/
         /IDFw1xLML3mq03uFFog2wAck3WrLzfzWo4QCjXL69yY01/iP2xlv5SSIhU0Jy2RWRuR
         f9kv5SRq+Df9/7H1s8x6TynKNkPCz+vVnKorLM1HLawLcHFV2zUuuXR8LXJtbHLpgcDe
         /Oyr/ieKLHUngF5L4sV7CPb06+1DSMbPxh5nMqS3tDWY8riFib8KfRCLHQw5imTXAs7x
         XDFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678317500; x=1680909500;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7IQLd/y1wF2Vv+Pb8fPKInE7oUtL7YCSx37c5DWA2oM=;
        b=ZUIM+9RjznvJk0/ji/y44qLSq7UvbLsAZFtH7AZA6lmvgkGR43+rIgtmqNd512mrct
         PcgirIi+WW2FqHdGCmZE3R9UH5886cSUBghLGjF73ys/NDVXXq5c/6fiEt9CheHg64d+
         PKJD0gONVC9bacy970ZjiWP1lehucHCAXRBLPSQRFaXfUjVDAXmMjNBZ0VdjIrx784/4
         teSuopu5FWYfT5H9E4NedodolAgoe5Aqs23xYCL+WNsyZ8ng/Nu5+KjNRytQhmcvv7kG
         lP9ZLUKt3tZnT1736Bs1vCw8lHpr4vPINcNVBMKHjuxJymXG6u0khu3xHleLHU+Crj6b
         2oBQ==
X-Gm-Message-State: AO0yUKU3aRtJkbxfKnImjbcp4pKHx7QnUG8jETnrjNnPDFT3Dpk26HXW
        ZbHhSDTaPopJkrJwjoZY4JU=
X-Google-Smtp-Source: AK7set+/ltflWp/ko/ctJTviUs7JYeb6BjEz3iB3oszviKMDPdxeFlwQuRZkePibX4IRZIT7EqJ41A==
X-Received: by 2002:a05:600c:1c1e:b0:3df:f7ba:14f8 with SMTP id j30-20020a05600c1c1e00b003dff7ba14f8mr694679wms.1.1678317500597;
        Wed, 08 Mar 2023 15:18:20 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id g11-20020adffc8b000000b002c7b229b1basm16390009wrr.15.2023.03.08.15.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 15:18:20 -0800 (PST)
Date:   Thu, 9 Mar 2023 00:18:18 +0100
From:   philipp hortmann <philipp.g.hortmann@gmail.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Jes Sorensen <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>, Jiajie Chen <c@jia.je>
Subject: Re: [PATCH v2] wifi: rtl8xxxu: Support new chip RTL8710BU aka
 RTL8188GU
Message-ID: <20230308231818.GA9043@matrix-ESPRIMO-P710>
References: <d4c5073a-4831-7353-6ea7-06dfd3cca7f2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4c5073a-4831-7353-6ea7-06dfd3cca7f2@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Mar 08, 2023 at 11:27:50PM +0200, Bitterblue Smith wrote:
> This chip is found in cheap "free driver" USB adapters from Aliexpress.
> Initially they pretend to be a CD-ROM containing the driver for Windows.
> "Ejecting" switches the device to wifi mode.
> 
> Features: 2.4 GHz, b/g/n mode, 1T1R, 150 Mbps.
> 
> This chip is more unique than other Realtek chips:
> 
> * The registers at addresses 0x0-0xff, which all the other chips use,
>   can't be used here. New registers at 0x8000-0x80ff must be used
>   instead. And it's not a simple matter of adding 0x8000: 0x2
>   (REG_SYS_FUNC) became 0x8004, 0x80 (REG_MCU_FW_DL) became 0x8090,
>   etc.
> 
> * Also there are a few new registers which must be accessed indirectly
>   because their addresses don't fit in 16 bits. No other chips seem to
>   have these.
> 
> * The vendor driver compiles to 8188gu.ko, but the code calls the chip
>   RTL8710B(U) pretty much everywhere, including messages visible to the
>   user.
> 
> Another difference compared to the other chips supported by rtl8xxxu is
> that it has a new PHY status struct, or three of them actually, from
> which we extract the RSSI, among other things. This is not unique,
> though, just new. The chips supported by rtw88 also use it.
> 
>  	struct usb_anchor tx_anchor;

Tested Chip: RTL8188EU
Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150

