Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314A358C4BC
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Aug 2022 10:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242052AbiHHILX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 Aug 2022 04:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234988AbiHHILT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 Aug 2022 04:11:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD77310FE0
        for <linux-wireless@vger.kernel.org>; Mon,  8 Aug 2022 01:11:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 783D4B80DCF
        for <linux-wireless@vger.kernel.org>; Mon,  8 Aug 2022 08:11:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DF06C433D6;
        Mon,  8 Aug 2022 08:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659946276;
        bh=cvJPosquDWHM60kC283pdtjQvNHai7KEGa7EcxtmfaU=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Jozeg6cSL1W7FpHNOJbyvysHVAJ6XuYy/YEKI3pOwRjnaS5dn81VxVqs+T8iv78tk
         gJLFbix/KY0t2S2NfBNBwwd4oeSwWmkStllE8Gtr0VehI6WUBGOBRnvPw6dkxKoahi
         kG2w2pGmku4qGm2+lx+QkLBIMT3L444u3AEKisxAljyuEIOBlSW0g8+JTT/fChwED/
         Uf1HsFYv05gbAYzwXgsMCI8ExVz0zyPb+HYkAQaCVweHLl+yV+ZkRzvILj5uinGMPf
         ixcW3CqO9DHl9D72mj0rPmUjnZsawuHUuMlBeiwRjjzT3bpMfPEGU8YIKaUXvtGYyy
         Wt6iAUbThCsQg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH wireless] wifi: wilc1000: fix spurious inline in
 wilc_handle_disconnect()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220801110440.13144-1-kvalo@kernel.org>
References: <20220801110440.13144-1-kvalo@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <165994627009.4951.11229163755018345171.kvalo@kernel.org>
Date:   Mon,  8 Aug 2022 08:11:15 +0000 (UTC)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@kernel.org> wrote:

> Sparse warns:
> 
> drivers/net/wireless/microchip/wilc1000/hif.h:218:35: error: marked inline, but without a definition
> 
> Remove the inline, it's not needed.
> 
> Reported-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Kalle Valo <kvalo@kernel.org>
> Acked-by: Ajay Singh <ajay.kathat@microchip.com>

Patch applied to wireless.git, thanks.

f01272ee3856 wifi: wilc1000: fix spurious inline in wilc_handle_disconnect()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220801110440.13144-1-kvalo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

