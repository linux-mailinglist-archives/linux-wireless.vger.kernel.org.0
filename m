Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6A16B7941
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Mar 2023 14:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjCMNoA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Mar 2023 09:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbjCMNn5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Mar 2023 09:43:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1914D628
        for <linux-wireless@vger.kernel.org>; Mon, 13 Mar 2023 06:43:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8A8A612C5
        for <linux-wireless@vger.kernel.org>; Mon, 13 Mar 2023 13:43:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB58AC433A0;
        Mon, 13 Mar 2023 13:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678715030;
        bh=D4bDQXlwozVG1K6+orRbpAfGYQB0zvrHrXjNQKnOgMU=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=n5XwxOv0OFPjg0WCZHwDMR+n89it+dmlrActt+H3tqbSNnUdBENNP7uYNeKNiSu7q
         ku3YJJdVcXrHFjI93H5aHlTjAY8i6U1OwKQJA2dYwWE/WtnqUzNMD01kVMiiHGEo2P
         ZLWTLbLv9y289233TFIiQjfES0siUx813jJoK7MBpCIoGM3s4Ujg603vs4l+wq0GON
         YvNhBGs2xGmP9oovZVKXCmVVrKzEfF6gIyzKBFzAqaDcKnf1P1zZx9BBxGVwmtaS3k
         1RF6B/0FhargZCxA/wm3ER3aolkysV/rJ/oh6/HIZqNJ9S9le9P4q2UlznHsJzjHTI
         YCz7DDPxTebTg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtw89: release RX standby timer of beamformee CSI
 to
 save power
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230307141848.26403-1-pkshih@realtek.com>
References: <20230307141848.26403-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167871502784.31347.15116424034328408504.kvalo@kernel.org>
Date:   Mon, 13 Mar 2023 13:43:49 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> Originally, we keep RX standby timer to handle beamformee CSI, but this
> spends power and causes system not entering power save mode. To improve
> power consumption, release the timer if throughput becomes low.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

8a66293e73a5 wifi: rtw89: release RX standby timer of beamformee CSI to save power

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230307141848.26403-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

