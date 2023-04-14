Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530446E234E
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Apr 2023 14:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbjDNMc0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Apr 2023 08:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjDNMcZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Apr 2023 08:32:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ACA4D7
        for <linux-wireless@vger.kernel.org>; Fri, 14 Apr 2023 05:32:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD97962B56
        for <linux-wireless@vger.kernel.org>; Fri, 14 Apr 2023 12:32:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 460A8C4339B;
        Fri, 14 Apr 2023 12:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681475540;
        bh=wbYHVuhGWIXyTu0OxT57LXng3YOV5LO+g8Uaq4wCAX0=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=FSzU2/ommmYBeKoqtgmqZn39N18qCkLHk9qkGoCdEzyiufLS0ETfWknOEJ4eqMnZv
         e45piCroicnSgDGJQ/yn8jPvaueeQPwGk4s+64K9vOGWckVU5gNrkXryEPlzkKiSMP
         42ArEC90efQG/YAZOpuGIXh65wqXr/xlu98wUiYAZrddEVO8cYFJ3WoQ1vPGlFCMXv
         2rNZB+BhKaUeebZ8j5WHdmdCidVH+cdAi/Nk3VRHdpW3NXKcUeTn/jR7LdhK3xtSQp
         lHvzIM17KhRzLwOZNGBXHnl+hZasXiA6xxN8l1NRwtyRPTRKoSpx4MKNYbWa4iOtRK
         yQ0m/EIj77z7A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/2] wifi: rtl8xxxu: Clean up some messy ifs
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <e24a5534-6e33-cfb9-0634-0caf4646513f@gmail.com>
References: <e24a5534-6e33-cfb9-0634-0caf4646513f@gmail.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Jes Sorensen <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168147553724.16522.17924195042305201326.kvalo@kernel.org>
Date:   Fri, 14 Apr 2023 12:32:19 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> Add some new members to rtl8xxxu_fileops and use them instead of
> checking priv->rtl_chip.
> 
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>

2 patches applied to wireless-next.git, thanks.

a5be45ea4593 wifi: rtl8xxxu: Clean up some messy ifs
b9c3379dda14 wifi: rtl8xxxu: Support devices with 5-6 out endpoints

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/e24a5534-6e33-cfb9-0634-0caf4646513f@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

