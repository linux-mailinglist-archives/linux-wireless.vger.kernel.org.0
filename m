Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65AB4DB54F
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Mar 2022 16:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357378AbiCPPtt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Mar 2022 11:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353704AbiCPPts (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Mar 2022 11:49:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2BC5F62
        for <linux-wireless@vger.kernel.org>; Wed, 16 Mar 2022 08:48:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB5856171D
        for <linux-wireless@vger.kernel.org>; Wed, 16 Mar 2022 15:48:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3D6FC340F0;
        Wed, 16 Mar 2022 15:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647445713;
        bh=sS1giA2Hukp7vSzDUIXQKx9sl6L0HeAD+9uWPRoThWE=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Oo7Jq2ef6PepLWQwiE4owFBKmkoTQ4KEbJm3tqURezoZK8x1jioaNA6nrVvl8MR1E
         JEuuojbb3Gftp9dDpJ4lHXjQKpZV4rzmGyBCpXYwU8T3obw3XzAqtWiCahA8vIrU/8
         C1vaQuvDzsf9RlBD7M57wxRrKe4f+ogn+Z1SSi2iwIOCzOzyPOE5dwN2PAznvtHUCy
         2YFOIeWZRrRCAX+fg4Lc7GrE+DlG9OYVPRppv8x+tsYaIVrKy7cazGH9227Cv/YwAM
         najF0aHubDfI+ZQOsFYePzvo8uUXnenjlxkRlkkThD90Bujc3/Q24g2QYzdJPstbBn
         iLd13NKYwHq4Q==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <leo.li@realtek.com>,
        <hsuan8331@realtek.com>, <yuanhan1020@realtek.com>
Subject: Re: [PATCH 09/11] rtw89: 8852c: add mac_ctrl_path and mac_cfg_gnt APIs
References: <20220311030301.33921-1-pkshih@realtek.com>
        <20220311030301.33921-10-pkshih@realtek.com>
Date:   Wed, 16 Mar 2022 17:48:26 +0200
In-Reply-To: <20220311030301.33921-10-pkshih@realtek.com> (Ping-Ke Shih's
        message of "Fri, 11 Mar 2022 11:02:59 +0800")
Message-ID: <87k0ctx5it.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> writes:

> From: Chia-Yuan Li <leo.li@realtek.com>
>
> The BT-coexistence uses these function to control antenna and TDMA, so
> implement the variant type to support all chips.
>
> Signed-off-by: Chia-Yuan Li <leo.li@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

[...]

> +int rtw89_mac_cfg_gnt_v1(struct rtw89_dev *rtwdev,
> +			 const struct rtw89_mac_ax_coex_gnt *gnt_cfg)
> +{
> +	u32 val;
> +
> +	val = (gnt_cfg->band[0].gnt_bt ?
> +	       B_AX_GNT_BT_RFC_S0_VAL | B_AX_GNT_BT_RX_VAL |
> +	       B_AX_GNT_BT_TX_VAL : B_AX_WL_ACT_VAL) |
> +	      (gnt_cfg->band[0].gnt_bt_sw_en ?
> +	       B_AX_GNT_BT_RFC_S0_SWCTRL | B_AX_GNT_BT_RX_SWCTRL |
> +	       B_AX_GNT_BT_TX_SWCTRL | B_AX_WL_ACT_SWCTRL : 0) |
> +	      (gnt_cfg->band[0].gnt_wl ?
> +	       B_AX_GNT_WL_RFC_S0_VAL | B_AX_GNT_WL_RX_VAL |
> +	       B_AX_GNT_WL_TX_VAL | B_AX_GNT_WL_BB_VAL : 0) |
> +	      (gnt_cfg->band[0].gnt_wl_sw_en ?
> +	       B_AX_GNT_WL_RFC_S0_SWCTRL | B_AX_GNT_WL_RX_SWCTRL |
> +	       B_AX_GNT_WL_TX_SWCTRL | B_AX_GNT_WL_BB_SWCTRL : 0) |
> +	      (gnt_cfg->band[1].gnt_bt ?
> +	       B_AX_GNT_BT_RFC_S1_VAL | B_AX_GNT_BT_RX_VAL |
> +	       B_AX_GNT_BT_TX_VAL : B_AX_WL_ACT_VAL) |
> +	      (gnt_cfg->band[1].gnt_bt_sw_en ?
> +	       B_AX_GNT_BT_RFC_S1_SWCTRL | B_AX_GNT_BT_RX_SWCTRL |
> +	       B_AX_GNT_BT_TX_SWCTRL | B_AX_WL_ACT_SWCTRL : 0) |
> +	      (gnt_cfg->band[1].gnt_wl ?
> +	       B_AX_GNT_WL_RFC_S1_VAL | B_AX_GNT_WL_RX_VAL |
> +	       B_AX_GNT_WL_TX_VAL | B_AX_GNT_WL_BB_VAL : 0) |
> +	      (gnt_cfg->band[1].gnt_wl_sw_en ?
> +	       B_AX_GNT_WL_RFC_S1_SWCTRL | B_AX_GNT_WL_RX_SWCTRL |
> +	       B_AX_GNT_WL_TX_SWCTRL | B_AX_GNT_WL_BB_SWCTRL : 0);

Not really a fan of this style, wouldn't this be more readable:

val = 0;

if (gnt_cfg->band[0].gnt_bt)
       val |= B_AX_GNT_BT_RFC_S0_VAL | B_AX_GNT_BT_RX_VAL | B_AX_GNT_BT_TX_VAL;
else
       val |= B_AX_WL_ACT_VAL;

if (gnt_cfg->band[0].gnt_bt_sw_en)
       val |= B_AX_GNT_BT_RFC_S0_SWCTRL | B_AX_GNT_BT_RX_SWCTRL |
              B_AX_GNT_BT_TX_SWCTRL | B_AX_WL_ACT_SWCTRL;

For ": 0" cases the else branch is not needed.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
