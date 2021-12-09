Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADBB746E3F0
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Dec 2021 09:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbhLIIUJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Dec 2021 03:20:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbhLIIUJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Dec 2021 03:20:09 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E36AC061746
        for <linux-wireless@vger.kernel.org>; Thu,  9 Dec 2021 00:16:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 83BADCE24FE
        for <linux-wireless@vger.kernel.org>; Thu,  9 Dec 2021 08:16:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE99DC004DD;
        Thu,  9 Dec 2021 08:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639037792;
        bh=hHIZzJ4ztLVFhIuazZxbc+tg62aR9GAkzbKw4gDmRzI=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Xxz+Y/KwpHITbp/Xl3DyVSL6llXh8JeZQ2TyRgY5BKHLJcVTj/Zzrofvk5lIhC/R4
         pjBHaDIECnn9qENEptQG3d1b8IaZiP8sbmRBIlPrSY7+JiKo2lPelA5B7uoBr3Hya6
         ReuiJBhR1ZD+1uTCOcWpBUpsxjiCwchhNqgGqSUEBjczN39XR5MuSyEZ4CbeKXmfn8
         2KbPlfwhr/l50XxooeTnM9MOH/DsyDIdKcdVbCcRnAppqzQn9tj2UtWZNvJ6guFYl8
         dYFWaOq5/7KIR4k61AFAhXenMTkvXV5FBZRylqZLMPkfHAnWlaGQZM/tYWQUtu6oa4
         UzwZhTnkFMI4g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] ath10k: drop beacon and probe response which leak from
 other channel
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20211208061752.16564-1-quic_wgong@quicinc.com>
References: <20211208061752.16564-1-quic_wgong@quicinc.com>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath10k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <quic_wgong@quicinc.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163903778980.12588.4204363037879005735.kvalo@kernel.org>
Date:   Thu,  9 Dec 2021 08:16:31 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> wrote:

> When scan request on channel 1, it also receive beacon from other
> channels, and the beacon also indicate to mac80211 and wpa_supplicant,
> and then the bss info appears in radio measurement report of radio
> measurement sent from wpa_supplicant, thus lead RRM case fail.
> 
> This is to drop the beacon and probe response which is not the same
> channel of scanning.
> 
> Tested-on: QCA6174 hw3.2 SDIO WLAN.RMH.4.4.1-00049
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

3bf2537ec2e3 ath10k: drop beacon and probe response which leak from other channel

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211208061752.16564-1-quic_wgong@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

