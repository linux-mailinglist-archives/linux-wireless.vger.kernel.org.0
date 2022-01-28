Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0AFF49FD34
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jan 2022 16:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349730AbiA1P4A (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jan 2022 10:56:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239183AbiA1Pz7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jan 2022 10:55:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC4EC061714
        for <linux-wireless@vger.kernel.org>; Fri, 28 Jan 2022 07:55:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C2F560EEE
        for <linux-wireless@vger.kernel.org>; Fri, 28 Jan 2022 15:55:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D94C6C340E0;
        Fri, 28 Jan 2022 15:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643385357;
        bh=j7KeaFPT3Na5uoBcqxWPuORAgTwdvyCSA5PVBr/0y6c=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=fxrRmIL/uiWq5Iv7pxx1Yjlc4qiXyqFh1Ya9NlNVEcQOzqD4h9YqkKCp9pkYx/SWS
         i+QBv6SWAWw8YKV83pNWidNZLX1yZtb1YbauiL0iqhG1yLFrG/hIim9/uM8jYYhrGa
         ZtDDS6SWGUpmYT3YWaPD9KQ+qHqJXydhF79i/fbldYX5vs+nMQE9WgHo/v8nt0PbXc
         mU3lTu60/b/y6w6Be9ARWPArcGiKuTYKb8J2TPwmB6ygdVVlAbT/LuZ5+S6eS7iv56
         MIziXpL80eTp5zLLOFDy9UY0+da7shwXde7UufunLTCrg9kzBHvlgc0CW9zN66m1wM
         ROxClzTU8+mLw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 2/3] rtw89: Add RX counters of VHT MCS-10/11 to debugfs
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220103013623.17052-2-pkshih@realtek.com>
References: <20220103013623.17052-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>,
        <rgoldwyn@suse.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164338535516.19531.18203108599582616684.kvalo@kernel.org>
Date:   Fri, 28 Jan 2022 15:55:56 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> 8852AE can receive packets with VHT MCS10/11, and we want to know we have
> received this kind of packets, so show the counter of VHT MCS10/11 in
> debugfs, like:
> 
> TP TX: 1 [1] Mbps (lv: 1), RX: 420 [422] Mbps (lv: 4)
> Beacon: 19
> Avg packet length: TX=102, RX=3081
> RX count:
>    Legacy: [0, 0, 0, 0]
>      OFDM: [0, 0, 0, 0, 0, 0, 0, 0]
>      HT 0: [0, 0, 0, 0, 0, 0, 0, 0]
>      HT 1: [0, 0, 0, 0, 0, 0, 0, 0]
>   VHT 1SS: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0][0, 0]
>   VHT 2SS: [0, 0, 0, 0, 0, 0, 0, 4, 624, 4818][29913, 556]
>    HE 1SS: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
>    HE 2ss: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
> TX rate [0]: VHT 2SS MCS-9 SGI	(hw_rate=0x119)	==> agg_wait=1 (3500)
> RX rate [0]: VHT 2SS MCS-10 SGI	(hw_rate=0x11a)
> RSSI: -30 dBm (raw=161, prev=165)
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

2 patches applied to wireless-next.git, thanks.

e56f3420106e rtw89: Add RX counters of VHT MCS-10/11 to debugfs
c1ea345deda8 rtw89: encapsulate RX handlers to single function

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220103013623.17052-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

