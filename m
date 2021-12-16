Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D380476BF2
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Dec 2021 09:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbhLPIae (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Dec 2021 03:30:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbhLPIae (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Dec 2021 03:30:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1694CC061574
        for <linux-wireless@vger.kernel.org>; Thu, 16 Dec 2021 00:30:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA2D761C67
        for <linux-wireless@vger.kernel.org>; Thu, 16 Dec 2021 08:30:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 597CEC36AE4;
        Thu, 16 Dec 2021 08:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639643433;
        bh=tUJahsqqCIeG/NMQ2Aq2LsEmQwCbqwNcp2Ew18cWq2s=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=KQplWeDHmSQ4fZ0/kJ3CeoTSUoeKTWtanbQh88q7UXZrvQtfVuYtr/NqD1b28teIt
         Pjfgw9SrleQVCBOBdYZIFXhUOeNMapaogXELGV1hvLOjrLBCMgPBDb7yHpQAvFK1lp
         A1ssk8+9IQUR2dfTehcfvJOHQqrP1MGk4UbXtOL2Dha+dp9Qfh3oS6yQUuANDqwK3q
         gl3KJal7/7MXFTK6vZqdCLRAe105OSp+2BfciKU0NpZEaYGOoGfo43famCitC5b/cE
         CAm8+c3yLtOljZJXWtpwwo49w5P0soWiIsfRfPTmAvgaVyFcm/32wcXYQ5NOF2LYEt
         D3eAoMpMIDmnw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/1] wilc1000: Improve WILC TX performance when
 power_save
 is off
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20211210203016.3680425-2-davidm@egauge.net>
References: <20211210203016.3680425-2-davidm@egauge.net>
To:     David Mosberger-Tang <davidm@egauge.net>
Cc:     Ajay Singh <ajay.kathat@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org,
        David Mosberger-Tang <davidm@egauge.net>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163964342720.18270.10262942260112362104.kvalo@kernel.org>
Date:   Thu, 16 Dec 2021 08:30:31 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

David Mosberger-Tang <davidm@egauge.net> wrote:

> The wakeup and sleep commands need to be sent to the WILC chip only
> when it is in power save mode (PSM, as controlled by "iw dev wlan0 set
> power_save on/off").  The commands are relatively costly, so it pays
> to skip them when possible.
> 
> iperf3 without this patch (no significant different with PSM on/off):
>   TX   0.00-120.01 sec   140 MBytes  9.82 Mbits/sec
>   RX   0.00-120.69 sec   283 MBytes  19.6 Mbits/sec
> 
> with this patch applied:
> 
> PSM off (TX is 46% improved, RX slightly improved; may not be significant):
>   TX   0.00-120.00 sec   206 MBytes  14.4 Mbits/sec
>   RX   0.00-120.48 sec   322 MBytes  22.4 Mbits/sec
> 
> PSM on (no significant change):
>   TX   0.00-120.00 sec   140 MBytes  9.78 Mbits/sec
>   RX   0.00-120.08 sec   257 MBytes  18.0 Mbits/sec
> 
> Signed-off-by: David Mosberger-Tang <davidm@egauge.net>

Patch applied to wireless-drivers-next.git, thanks.

b530d5f39c2f wilc1000: Improve WILC TX performance when power_save is off

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211210203016.3680425-2-davidm@egauge.net/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

