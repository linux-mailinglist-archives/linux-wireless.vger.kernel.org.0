Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB4C647229
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Dec 2022 15:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiLHOsW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Dec 2022 09:48:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiLHOsR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Dec 2022 09:48:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18C499F3E
        for <linux-wireless@vger.kernel.org>; Thu,  8 Dec 2022 06:48:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9D0A5B82407
        for <linux-wireless@vger.kernel.org>; Thu,  8 Dec 2022 14:48:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A27E1C433C1;
        Thu,  8 Dec 2022 14:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670510894;
        bh=RaAlRAvys5Kp5vwjXqZFFxVpv4hLXyKiuhqICdIPOjU=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=EaOD6q1EcyAXAXUJc5DIl26/iGBM2WQG0im5ax/ayvk5RrlskRzsRZYJVBBOGlDMB
         8kMijINXOfyzNC8K8LIGcUrLvXEk3dUM+mini0PTPIlsc+43r+8FB0N0qNGOgLrULd
         LTtv3HMNuJKQuyxRQZT3eH3MyfNUrdPGFhc/WtiMrdN35grrGLKQYFxtO5oWl8fi7y
         efq9EhZ/mb7wpCWRFJQAVy9UOKGbdUVhoB27zJmcs4Of6yZ+l9hLUfrggtACR9cbDt
         YLtP6w/O9+eaJz6flPaLXUYE7U/I5X8J3EpHFeqXkiXN8TbgW9icCpoWvNOlOUaLgL
         PPGHgU54m7lng==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/4] wifi: rtw89: add mac TSF sync function
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20221202061527.505668-2-pkshih@realtek.com>
References: <20221202061527.505668-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <phhuang@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167051089193.9839.7580560813060192456.kvalo@kernel.org>
Date:   Thu,  8 Dec 2022 14:48:13 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Po-Hao Huang <phhuang@realtek.com>
> 
> If the interface is in AP/P2P GO mode, we adjust the TSF with random
> offset to avoid TBTT of different vifs to overlap and collide.
> For every new interface added, we adjust the value and resync for all
> interfaces.
> 
> Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

4 patches applied to wireless-next.git, thanks.

fb2b8cec81d7 wifi: rtw89: add mac TSF sync function
d592b9f74264 wifi: rtw89: stop mac port function when stop_ap()
8fc5d4338620 wifi: rtw89: fix unsuccessful interface_add flow
a0e78d5c6082 wifi: rtw89: add join info upon create interface

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20221202061527.505668-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

