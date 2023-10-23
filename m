Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9436F7D3D73
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Oct 2023 19:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjJWRZX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Oct 2023 13:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjJWRZV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Oct 2023 13:25:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8DDEE
        for <linux-wireless@vger.kernel.org>; Mon, 23 Oct 2023 10:25:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AC7CC433C7;
        Mon, 23 Oct 2023 17:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698081918;
        bh=GuXXS31t9Vtcv709kb40Xj2GJgjFOUYLP5P+8DuT3Sg=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=sNyapKAOoOG9tFjmBkut+3WREuKr1pZo8F139z1GUIeeNQw5OrX5riUop2C8mL0kk
         cSVNvgj288NFdOGcQDxYymCy3lYEPxT+31PMcyCRBnF0W+a7rX9leG+6a+W6RObBVQ
         BCmHqElb9SY5hWA9x3lZkczvK/mhcO+yX86RsuRKUKM0b6oKjkLOaQo+4NtIZ5D6CX
         P9jbIP28F4WQTABSS3B2R3BMX1Ze2xrPilD9/u6JekkecnNPnxw3vhkbPsDn49xuF5
         SAA1Nl22m3LBUDajJZzAMdzQSLvilnmteh2KaaKc797QOxG8Fm1VptkYD1CIyOxxYN
         490HtW0KC8xAQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/3] wifi: brcmfmac: fix format-truncation warnings
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231012135854.3473332-1-kvalo@kernel.org>
References: <20231012135854.3473332-1-kvalo@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169808191584.695306.1796980160191200158.kvalo@kernel.org>
Date:   Mon, 23 Oct 2023 17:25:17 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@kernel.org> wrote:

> On v6.6-rc4 with GCC 13.2 I see:
> 
> drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c:262:52: warning: '%d' directive output may be truncated writing between 1 and 5 bytes into a region of size 4 [-Wformat-truncation=]
> drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c:262:46: note: directive argument in the range [0, 65535]
> drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c:262:46: note: directive argument in the range [0, 65535]
> drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c:262:9: note: 'snprintf' output between 9 and 17 bytes into a destination of size 9
> drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c:265:55: warning: '%d' directive output may be truncated writing between 1 and 5 bytes into a region of size 4 [-Wformat-truncation=]
> drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c:265:48: note: directive argument in the range [0, 65535]
> drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c:265:48: note: directive argument in the range [0, 65535]
> drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c:265:9: note: 'snprintf' output between 10 and 18 bytes into a destination of size 10
> drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c:342:50: warning: '/' directive output may be truncated writing 1 byte into a region of size between 0 and 4 [-Wformat-truncation=]
> drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c:342:42: note: directive argument in the range [0, 65535]
> drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c:342:9: note: 'snprintf' output between 10 and 18 bytes into a destination of size 10
> 
> Fix these by increasing the buffer sizes to 20 bytes to make sure there's enough space.
> 
> Compile tested only.
> 
> Signed-off-by: Kalle Valo <kvalo@kernel.org>

3 patches applied to wireless-next.git, thanks.

fab22496c982 wifi: brcmfmac: fix format-truncation warnings
c253e43e1078 wifi: ipw2x00: fix format-truncation warnings
359342795d62 wifi: ath9k_htc: fix format-truncation warning

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231012135854.3473332-1-kvalo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

