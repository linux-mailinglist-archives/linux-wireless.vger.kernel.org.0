Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA596B793B
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Mar 2023 14:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjCMNms (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Mar 2023 09:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjCMNmq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Mar 2023 09:42:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FB461888
        for <linux-wireless@vger.kernel.org>; Mon, 13 Mar 2023 06:42:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 80A94B8106E
        for <linux-wireless@vger.kernel.org>; Mon, 13 Mar 2023 13:42:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4392C4339B;
        Mon, 13 Mar 2023 13:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678714963;
        bh=MUYo4IxqZ4cXEabkutpX0t6K890yflN5Ls0bJjlehsw=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=OfFVH8NS/DAtBVazf28pdXVVJC6FJ1CG+urGtMbfOlWcSDxlsTTDQ+2tfdnOyG5sa
         mI0OAm/zRZSrT5/uTH7d/zxggxbt7GtRJAdIiUJ1Rn+UxE2u/6rJC1Q4ORRzupWn9x
         hYIMsJQ7jNDx7PuKpXHYyeCnDLLC+NiTzuLrtO+LmAv7tonEw8mDMDaNP9ujMQd4EV
         kb1GTFV1YzhQcN++B4+LSmTX6FI+sLEkATekz2XMsmWSb82Q7Kt95bd+jNIONDMa8B
         2VoDJ0mzljhoPKqKV4nUXccoiBePu7G29ePQ0i66F/KEw6Mjknj9Uxue4OXpl8UKRQ
         zKX2IGAySrCzQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] wifi: move mac80211_hwsim and virt_wifi to virtual
 directory
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230227121732.8967-2-kvalo@kernel.org>
References: <20230227121732.8967-2-kvalo@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167871495682.31347.16079041223615239506.kvalo@kernel.org>
Date:   Mon, 13 Mar 2023 13:42:42 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@kernel.org> wrote:

> To clean up drivers/net/wireless move the virtual drivers to a new virtual
> directory. I did consider adding CONFIG_WLAN_VENDOR_VIRTUAL like other vendors
> have but then dropped the idea as we are not real drivers.
> 
> There should be no changes in compilation or in Kconfig options, merely moving
> files. The order in menuconfig is slightly changed, the virtual drivers are now
> last in the list.
> 
> Signed-off-by: Kalle Valo <kvalo@kernel.org>

2 patches applied to wireless-next.git, thanks.

f79cbc77abde wifi: move mac80211_hwsim and virt_wifi to virtual directory
298e50ad8eb8 wifi: move raycs, wl3501 and rndis_wlan to legacy directory

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230227121732.8967-2-kvalo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

