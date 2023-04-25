Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4FFD6EDB62
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Apr 2023 07:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbjDYFxj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Apr 2023 01:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbjDYFxi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Apr 2023 01:53:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D205C4C15
        for <linux-wireless@vger.kernel.org>; Mon, 24 Apr 2023 22:53:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70F8B62B32
        for <linux-wireless@vger.kernel.org>; Tue, 25 Apr 2023 05:53:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A425C433EF;
        Tue, 25 Apr 2023 05:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682402016;
        bh=+w+5rtL8LJ8B3LU18mhmJe8KrxsNeAal+me9ozVOLjA=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=RLUBoML5wg8PlrNGyU+1aPkILBJ0hzcfuYFpKDmzespL1ygvZrkEQs6OucS1QKXvE
         msmpyBHGDuWeKeN7dsb/G6xNBalEotwUKBbgDdMH9jHJeS2WtKY0ejqvnAq9o5DUCQ
         VVaLx0Mmmvyr4MGF8NUlluP5TCqUBCQJj/vrQNjGp0Qg2Px9oN6bSaLAhH0g2P+t4B
         EHoMUFc8Y4QZCNaIdeDIHya9jrf1XNQiFPzr55ybVfDJO4Ek1n/P7DYUyGqWch6kI7
         PIxNh7Dvj50IY9mTm0oVD1wXewMQbNWpb/rb90/PtF3hbTWl6ZD9hzOiX1JeFMANNh
         aYp0anV2fyAFg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc:     Martin Kaistra <martin.kaistra@linutronix.de>,
        linux-wireless@vger.kernel.org,
        Jes Sorensen <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v2 18/18] wifi: rtl8xxxu: Set maximum number of supported stations
References: <20230419100145.159191-1-martin.kaistra@linutronix.de>
        <20230419100145.159191-19-martin.kaistra@linutronix.de>
        <98355d5e-ac45-c522-3b8a-8cdc243b87cb@gmail.com>
Date:   Tue, 25 Apr 2023 08:53:32 +0300
In-Reply-To: <98355d5e-ac45-c522-3b8a-8cdc243b87cb@gmail.com> (Bitterblue
        Smith's message of "Mon, 24 Apr 2023 23:16:23 +0300")
Message-ID: <875y9kqzhf.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bitterblue Smith <rtl8821cerfe2@gmail.com> writes:

>> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> @@ -7464,6 +7464,8 @@ static int rtl8xxxu_probe(struct usb_interface *interface,
>>  
>>  	hw->wiphy->max_scan_ssids = 1;
>>  	hw->wiphy->max_scan_ie_len = IEEE80211_MAX_DATA_LEN;
>> +	if (priv->fops->max_sta_num)
>> +		hw->wiphy->max_ap_assoc_sta = priv->fops->max_sta_num - 1;
>
> The way you use it, "max_macid_num" would be a more accurate name.

Indeed. I was first wondering why subtract max_sta_num, at least for me
max_macid_num makes more sense.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
