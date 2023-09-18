Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329667A5040
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Sep 2023 19:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjIRRCl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Sep 2023 13:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbjIRRCj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Sep 2023 13:02:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDA9A6
        for <linux-wireless@vger.kernel.org>; Mon, 18 Sep 2023 10:02:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 961E4C4163C;
        Mon, 18 Sep 2023 14:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695047388;
        bh=dA929+3iTIxGbjOe6CiFoyvygTA9LQumTRpzdD4INWI=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=O63EozK2NxHsb/Ej7v+Txl0xXfqrDs6i9s68fv9AvQoIu2njMi/Kkt5O2eJU2+1HA
         glBqWc8Ied9rTHNOpH5DDyVq+XcCGdT5YntowA++ZqJjx5Tbv6iI8brvu4h4XxUzA6
         SdELqb/sLK00tXI4m8iOrZ9pRM99g1qOJd2beqcsAkXZixY5ihqCkcnrWYSxb6vNBZ
         gy1lJgynBdB+4d7s90Sd1jyiYp8IuQkNxDW4nTM94XcLYq8/DHG0hjz0EASB0bA0hC
         25u0fEf+SfP/02VLK4kl3Qpg9fAdpEllbDpOX2Jkf9aOR8OR6P+xgYB/vEslFT7kqs
         yYLk8p1PNhlVw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/6] wifi: rtw89: add to query RX descriptor format v2
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230911082049.33541-2-pkshih@realtek.com>
References: <20230911082049.33541-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169504738572.740666.15331889491171451137.kvalo@kernel.org>
Date:   Mon, 18 Sep 2023 14:29:47 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> RX descriptor is used to provide meta data of received data. The WiFi 7
> chips use different RX descriptor format, so add this parser along with
> hardware design.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

6 patches applied to wireless-next.git, thanks.

a1cb73f29539 wifi: rtw89: add to query RX descriptor format v2
6f09ff0a0927 wifi: rtw89: add to fill TX descriptor for firmware command v2
d542ee748ec3 wifi: rtw89: add to fill TX descriptor v2
c8b9a49f7a3d wifi: rtw89: add chip_info::txwd_info size to generalize TX WD submit
651298138e42 wifi: rtw89: consolidate registers of mac port to struct
7c8a55dd265b wifi: rtw89: add mac_gen pointer to access mac port registers

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230911082049.33541-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

