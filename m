Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 913404DC8B3
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Mar 2022 15:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235064AbiCQOZm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Mar 2022 10:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbiCQOZl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Mar 2022 10:25:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0EC318546E
        for <linux-wireless@vger.kernel.org>; Thu, 17 Mar 2022 07:24:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00CDD61731
        for <linux-wireless@vger.kernel.org>; Thu, 17 Mar 2022 14:24:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31676C340E9;
        Thu, 17 Mar 2022 14:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647527063;
        bh=K1Ik0h5GqpyFksiSichAv/us8jpIOL4zUZfLhGHASg8=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=MkTMUeTetR30q+SJjgLlmuG41WvyafA5WRXkWDYz89NM896Q4O35ab8Vw+Rf4Zh8T
         7vuj1ieyZTy1TuaS7Mo57tq9mRrGeY/7VgGxldZz0DfzKfvMKPaNqpxsD/rOdjIYXr
         WSRi0g6hDeJ6nN+VWE9B4iZibFNLF9kST22VOFUMBzZ7o9V6wVNBPveUwuIxHbe33Q
         gijTdc9GARfe3gomzFVl0clSmxfgDoJ9XHM6mVuYkxnSHDTdz5ApjlujkCmEn/NLoV
         CrvABvGr9VgSXIIyF75Ly7MCJHlmfFdrlCf6vYRA6mpCFDT8j9A/j34Jf+CDdRW4w4
         GiiVtp2QnU/wg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 01/12] rtw89: modify dcfo_comp to share with chips
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220317055543.40514-2-pkshih@realtek.com>
References: <20220317055543.40514-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <leo.li@realtek.com>,
        <hsuan8331@realtek.com>, <yuanhan1020@realtek.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164752705616.16149.15748435534814952311.kvalo@kernel.org>
Date:   Thu, 17 Mar 2022 14:24:21 +0000 (UTC)
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Yuan-Han Zhang <yuanhan1020@realtek.com>
> 
> The dcfo_comp is digital CFO (central frequency offset) compensation.
> Since the flow can be shared with all chips, add chip parameters to support
> variant register address and format.
> 
> Signed-off-by: Yuan-Han Zhang <yuanhan1020@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

12 patches applied to wireless-next.git, thanks.

b7379148f598 rtw89: modify dcfo_comp to share with chips
8379fa611536 rtw89: 8852c: add write/read crystal function in CFO tracking
a9ffae8d3f9d rtw89: 8852c: add setting of TB UL TX power offset
84d0e33e51df rtw89: 8852c: add read/write rf register function
2a5f2b32639a rtw89: add config_rf_reg_v1 to configure RF parameter tables
828a4396e52a rtw89: modify MAC enable functions
e07a99682972 rtw89: initialize preload window of D-MAC
de78869d1f48 rtw89: disable FW and H2C function if CPU disabled
feed65417847 rtw89: 8852c: add mac_ctrl_path and mac_cfg_gnt APIs
8001c741e351 rtw89: change value assignment style of rtw89_mac_cfg_gnt()
d780f926d633 rtw89: extend mac tx_en bits from 16 to 32
de7ba639e6c5 rtw89: implement stop and resume channels transmission v1

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220317055543.40514-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

