Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76591658AF0
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Dec 2022 10:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbiL2J0w (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Dec 2022 04:26:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233109AbiL2J0u (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Dec 2022 04:26:50 -0500
Received: from mail.schwarz.eu (eight.schwarz.eu [IPv6:2a01:4f8:c17:2a56::8:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4882213D35
        for <linux-wireless@vger.kernel.org>; Thu, 29 Dec 2022 01:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=oss.schwarz.eu; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=TqKITWH2KzWt4CFinzy2XAYNVXlR7/0RCXnqOB9BDX0=; b=QWf+Cb/bqov/CWfsPGgIaQi6vm
        8vhcebs54kDqdKNCHv+wLuCsJTAI9/nOzK0TTx0uxiklPK7N/l4aPj6pEi385YsbNtn+ffknqWwfW
        +jh9tyhR1PIPn4NemblpgHPm5DT9Oca94r11LOIP3M8UQ9tPLdp0kYdNfVtdurnlFoGFdQ77r6dDb
        VPRKHRmROVK9MANC933/nQHFzp2kJxNObzglGMOHBxzTTPtoNJ2Pxxk+I1kI44weyZcax0OQlxzgo
        tA1t3loATwRIZAFcbLc5iUtuxcEpbEU7/1W7RRRo/Hxh1EQjXBiWUdzd5rkekN8maLtuHj1SR124x
        0TJwqlSg==;
Message-ID: <8c31c09f-68c1-42a8-1db9-1ea98caf8d05@oss.schwarz.eu>
Date:   Thu, 29 Dec 2022 10:26:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: rtw_8821cu: "rfe 38 isn't supported" with Linux 6.2rc1
 (0bda:c811)
To:     Ping-Ke Shih <pkshih@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <a949dfb1-51e9-8f91-bef1-674c78101cc3@oss.schwarz.eu>
 <79ce633c3e274cffb22349b12566d78a@realtek.com>
Content-Language: en-US
From:   Felix Schwarz <felix.schwarz@oss.schwarz.eu>
In-Reply-To: <79ce633c3e274cffb22349b12566d78a@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Received: by mail.schwarz.eu with esmtpsa (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.96)
        (envelope-from <felix.schwarz@oss.schwarz.eu>)
        id 1pApBW-0006L0-1a; Thu, 29 Dec 2022 10:26:46 +0100
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Ping-Ke,

Am 29.12.22 um 01:26 schrieb Ping-Ke Shih:
> RFE type 38 is very similar to type 6, so I suggest to try this:
> 
> diff --git a/rtw8821c.c b/rtw8821c.c
> index dd01b22f..9ac83756 100644
> --- a/rtw8821c.c
> +++ b/rtw8821c.c
> @@ -1547,6 +1547,7 @@ static const struct rtw_rfe_def rtw8821c_rfe_defs[] = {
>          [4] = RTW_DEF_RFE_EXT(8821c, 0, 0, 2),
>          [6] = RTW_DEF_RFE(8821c, 0, 0),
>          [34] = RTW_DEF_RFE(8821c, 0, 0),
> +       [38] = RTW_DEF_RFE(8821c, 0, 0),
>   };

That seems to help. The errors I posted initially are all gone.

Now I see a wifi card in network manager and scanning for wifi networks works as 
well. Connection to my wireless network does not work though (neither 2.4 Ghz 
nor 5) - no real errors just endless spinning after I entered my password. 
(Though running any application is *extremly* slow without an obvious cause when 
running 6.2rc1, maybe a different bug?)

I should probably debug this without gnome + networkmanager but maybe you have 
an idea based on these errors?

rtw_8821cu 1-4:1.0: read register 0x5 failed with -110
rtw_8821cu 1-4:1.0: read register 0x20 failed with -110
rtw_8821cu 1-4:1.0: read register 0x7c failed with -110
rtw_8821cu 1-4:1.0: read register 0x1080 failed with -110
rtw_8821cu 1-4:1.0: write register 0x3 failed with -110


I attached the logs produced once I attach the USB device running Linux 6.2rc1 
with the additional patch for rfe 38.

Felix

