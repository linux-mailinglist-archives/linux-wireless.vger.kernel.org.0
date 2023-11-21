Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 873CF7F2DD1
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Nov 2023 13:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233711AbjKUM46 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Nov 2023 07:56:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233336AbjKUM45 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Nov 2023 07:56:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FCAB1BB
        for <linux-wireless@vger.kernel.org>; Tue, 21 Nov 2023 04:56:54 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD664C433C7;
        Tue, 21 Nov 2023 12:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700571413;
        bh=t0yUG7IevizXZgseTaL3uPwrMwMP22WXfGfF4u8JCrg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=pHYOLDi0aPfv9LidD0SicDgwFjvsRqio0a9Tcliwlc7HUu7cD9I/TeHX6kSfc/ucj
         RLS+9e/opfmBsBsQyTIPtW0xhxsHSYuLR1C8bYSWpCgY+TuYunb685u2ous/eMQtfS
         4s9kewzk2bR2IA5+6VeUoLCZ54lwoKjwYrIj11bmr3W8YPUkv0C/dJlOlKAuXbaFy+
         v1Zy3/M3n8tZzZB2J0AF86jdfr0XEGSw6D4oc0Q5Lbv/WU0/5xUs9iTJ2YtSouhZfc
         jyQT8bH0h1qmwqGF+Lq0DHjGgp/wDqtk2OxeCCmbfZIg8fONsXo+2P77PJUP0plyRc
         aUDmmmwY00jIw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Anuj Khera <quic_akhera@quicinc.com>
Cc:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: cfg80211: Rename bssid to peer_addr in
 cfg80211_pmksa
References: <20231120062450.8023-1-quic_akhera@quicinc.com>
Date:   Tue, 21 Nov 2023 14:56:50 +0200
In-Reply-To: <20231120062450.8023-1-quic_akhera@quicinc.com> (Anuj Khera's
        message of "Mon, 20 Nov 2023 11:54:50 +0530")
Message-ID: <87r0kj6z8t.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Anuj Khera <quic_akhera@quicinc.com> writes:

> The cfg80211_pmksa structure uses bssid member to store
> the PMKSA for a BSS in Station mode. Change the name of
> structure member bssid to peer_addr so that same member
> can be used to store the PMKSA for a station in AP mode
> using station MAC address.
>
> Signed-off-by: Anuj Khera <quic_akhera@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath6kl/cfg80211.c           |  8 ++++----
>  .../wireless/broadcom/brcm80211/brcmfmac/cfg80211.c  | 12 ++++++------
>  drivers/net/wireless/microchip/wilc1000/cfg80211.c   | 10 +++++-----
>  drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c    |  8 ++++----
>  include/net/cfg80211.h                               |  5 +++--
>  net/wireless/nl80211.c                               |  2 +-
>  net/wireless/trace.h                                 |  2 +-
>  net/wireless/wext-compat.c                           |  2 +-
>  8 files changed, 25 insertions(+), 24 deletions(-)

For a rename like this I would expect to see patch 2 adding the actual
functionality.

Johannes, just so you know this patch has nothing to do with
ath10k/ath11k/ath12k. I guess this is for the proprietary Qualcomm
driver?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
