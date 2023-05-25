Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCE2711096
	for <lists+linux-wireless@lfdr.de>; Thu, 25 May 2023 18:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233181AbjEYQM1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 May 2023 12:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbjEYQM0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 May 2023 12:12:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA3FE7B
        for <linux-wireless@vger.kernel.org>; Thu, 25 May 2023 09:11:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B9FF60B01
        for <linux-wireless@vger.kernel.org>; Thu, 25 May 2023 16:11:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 417E2C433D2;
        Thu, 25 May 2023 16:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685031115;
        bh=Uq2yuGi1Suk3LZ6vqr+srEB4z525oFO8xf9SNJRxaac=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=gh9bysinn0FJ/qyercjhSP2XYdB8vEDo0ufemZInheanwiEzBnQhuOifrKI90yIDy
         PoCTkiyvyo76wtGoW7nLTO/gfVTU/4lb8fKUl/6OwoJBztL9WKsoEP4y4Gkqw6yqee
         tZiudVUvbhBQgEGp7Y7oky1+mVmxgrGaN0gqLyMVidAHfotWxyBGDDlpiA6JGWW2xE
         oOl/6uFZC/HRCPGRFgtdEHXbhJeCbsNnizZ8EJWof1tJAm/aLOYAmgI5uh+OK1m4CL
         NWmeaf9otBx3LeCLXjJx+wBkKYwmyoCnZNMruDyZK9xzXMV6fS637osrPY4xt94dZc
         FcJvHriHyeisw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/7] wifi: rtw89: 8851b: add TX power related functions
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230519031500.21087-2-pkshih@realtek.com>
References: <20230519031500.21087-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <timlee@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168503111204.22756.3771727071281469277.kvalo@kernel.org>
Date:   Thu, 25 May 2023 16:11:54 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> Get TX power value from tables according to selected country and channel,
> and set proper power to registers.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

7 patches applied to wireless-next.git, thanks.

76f2516f7937 wifi: rtw89: 8851b: add TX power related functions
68a2cb6b0669 wifi: rtw89: 8851b: fill BB related capabilities to chip_info
92aa2643235d wifi: rtw89: 8851b: add MAC configurations to chip_info
791af3fb2dec wifi: rtw89: 8851b: add RF configurations
4cfad52a5df7 wifi: rtw89: enlarge supported length of read_reg debugfs entry
c4ff50149885 wifi: rtw89: add tx_wake notify for 8851B
14820388aafb wifi: rtw89: 8851b: add 8851be to Makefile and Kconfig

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230519031500.21087-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

