Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCEE6D45EF
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Apr 2023 15:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbjDCNhX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Apr 2023 09:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjDCNhW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Apr 2023 09:37:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18709A9
        for <linux-wireless@vger.kernel.org>; Mon,  3 Apr 2023 06:37:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D0557B81A1C
        for <linux-wireless@vger.kernel.org>; Mon,  3 Apr 2023 13:37:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A83BDC433D2;
        Mon,  3 Apr 2023 13:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680529039;
        bh=Njy4FkcLomWAbLTtFKzBUOD7yqXh1/VNs6oBDRnop3Y=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=aJLlJ66M2vQxHNl1Ug2/97BSLATpUnYzCjlZGZmPXPgT+F7UpuQ39u1aHUSwR502U
         oeFcCfncE3OTfvAUzHtuSaZaoP1gVpihKgKfTMDfkEh1kfubNaYi4iDC8ogf2BVZWd
         3fi1TOabZI4SNqH8o4801XL008yqvUlxLA+7ovL15qGd+VF4JonSliVUtbG8+gQgqn
         JO2uKjuWKQjaU3llHMKh9ldWYWYYGeOA4rV5eSTg+1tboEEpo3xvDFTdwLt8rDytGZ
         N64lks1xSlnxFWSpbuAK/dZQ6iNvpWsjppLM9qr0SNkteInnbq6mrtCu+t2KbzbZPG
         OYJqTesoTBxEw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/3] wifi: rtw89: set data lowest rate according to AP
 supported rate
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230320093112.30466-1-pkshih@realtek.com>
References: <20230320093112.30466-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <gary.chang@realtek.com>, <timlee@realtek.com>,
        <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168052903648.11825.3006625605965445551.kvalo@kernel.org>
Date:   Mon,  3 Apr 2023 13:37:18 +0000 (UTC)
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Chih-Kang Chang <gary.chang@realtek.com>
> 
> By default the driver uses the 1M and 6M rate (0x0) for data frames in
> 2 GHz and 5/6 GHz bands respectively. But the rate that might not AP
> supported. Therefore, We modify the data lowest rate according to the
> lowest of AP supported rate.
> 
> Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

3 patches applied to wireless-next.git, thanks.

e5307c9cd7ee wifi: rtw89: set data lowest rate according to AP supported rate
41209362d700 wifi: rtw89: remove superfluous H2C of join_info
40711486c7ba wifi: rtw89: fix incorrect channel info during scan due to ppdu_sts filtering

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230320093112.30466-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

