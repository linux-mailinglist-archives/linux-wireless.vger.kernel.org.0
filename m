Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB2B6D4629
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Apr 2023 15:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbjDCNuQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Apr 2023 09:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbjDCNuP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Apr 2023 09:50:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EAE8191EE
        for <linux-wireless@vger.kernel.org>; Mon,  3 Apr 2023 06:49:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 62653B81A16
        for <linux-wireless@vger.kernel.org>; Mon,  3 Apr 2023 13:49:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51193C433D2;
        Mon,  3 Apr 2023 13:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680529789;
        bh=fT4/bhIvqUua9+hZVKY5XgpED0gkhvKtDxlKaYq7nYo=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=NGt4ybHCzQHrjK1wT97EwT6LmTUmMpQXeasrII3G3kzNSyhNIWGa4LdJ7KXUQKZp+
         dgsC5rFS1mNkCW0N7QdkSVM0EuqgPP+imOcvU3c0GLg+JlVFgm+w7+LtU1x0E9aRxA
         YAib8+2V6rIKhMbi1lnF7EPWm5DuzOiqTJaSGUqj/+aaqNRLPxsIL98Kghbs5GBFPh
         qfVL+g3l8iQ4cPpUHdKm3OULuSfFzPhTYX5H2kyh77gLWQ41sh5U/Ob2Os5hFyZgRR
         5ZwkTYf76WTNa0WE8LfJpc/3FV5073kmhVRIZZh+uIvFi1Lluf+mkvzSdhhK7DDzsE
         3bcFkBRLeld6A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath11k: reduce the MHI timeout to 20s
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230329162038.8637-1-kvalo@kernel.org>
References: <20230329162038.8637-1-kvalo@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168052978643.12755.3479029977193961957.kvalo@kernel.org>
Date:   Mon,  3 Apr 2023 13:49:48 +0000 (UTC)
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@kernel.org> wrote:

> From: Kalle Valo <quic_kvalo@quicinc.com>
> 
> Currently ath11k breaks after hibernation, the reason being that ath11k expects
> that the wireless device will have power during suspend and the firmware will
> continue running. But of course during hibernation the power from the device is
> cut off and firmware is not running when resuming, so ath11k will fail.
> 
> (The reason why ath11k needs the firmware running is the interaction between
> mac80211 and MHI stack, it's a long story and more info in the bugzilla report.)
> 
> In SUSE kernels the watchdog timeout is reduced from the default 120 to 60 seconds:
> 
> CONFIG_DPM_WATCHDOG_TIMEOUT=60
> 
> But as the ath11k MHI timeout is 90 seconds the kernel will crash before will
> ath11k will recover in resume callback. To avoid the crash reduce the MHI
> timeout to just 20 seconds.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.9
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=214649
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to wireless.git, thanks.

cf5fa3ca0552 wifi: ath11k: reduce the MHI timeout to 20s

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230329162038.8637-1-kvalo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

