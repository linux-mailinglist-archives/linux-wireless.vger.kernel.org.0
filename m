Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A43066DF567
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Apr 2023 14:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbjDLMfm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Apr 2023 08:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbjDLMfi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Apr 2023 08:35:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0DE2697
        for <linux-wireless@vger.kernel.org>; Wed, 12 Apr 2023 05:35:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 77F1D61074
        for <linux-wireless@vger.kernel.org>; Wed, 12 Apr 2023 12:35:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E05C7C4339B;
        Wed, 12 Apr 2023 12:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681302923;
        bh=HiL2c2oRI1zUxgCvwNyxNuNlqz0eZMXJvMXuUdbJuTw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=HpzuFygyzZAcNZHqJO5sautUbDDt78mf48zJ/oW/G6l4Ai8RT1h/3+86BZX4Eoe0Z
         LHR3x23NgeLgatly53PnhlxjCY7lX0TMaBDGYN9liGwkX4ojA93ThmiK5VyKvXkBs8
         9jVERiAtGzXcZ51dpCk7LZXRAHb2vc32vWgWby7rObN3/qeUBDmvPnCZkHu7g/FVUm
         TNZTLXxCyMJAqd8IzVjhNgPLfZxyH/91eCcBl5rjqeQzHj216lOwapZz2AYfEDZtuL
         sXO0RKftpLAhp+pqM1OWqWISwh3U0iK5C8Gbo8CB9whFhRle7dkr1dln1ZHXyKfSbL
         GjrUhT6+eJImw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <tony0620emma@gmail.com>, <phhuang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 2/7] wifi: rtw88: add port switch for AP mode
References: <20230401124410.33221-1-pkshih@realtek.com>
        <20230401124410.33221-3-pkshih@realtek.com>
Date:   Wed, 12 Apr 2023 15:35:18 +0300
In-Reply-To: <20230401124410.33221-3-pkshih@realtek.com> (Ping-Ke Shih's
        message of "Sat, 1 Apr 2023 20:44:05 +0800")
Message-ID: <87bkjt8eih.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> writes:

> From: Po-Hao Huang <phhuang@realtek.com>
>
> Switch port settings if AP mode does not start on port 0 because of
> hardware limitation. For some ICs, beacons on ports other than zero
> could misbehave and do not issue properly, to fix this we change AP
> VIFs to port zero when multiple interfaces is active.
>
> Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

[...]

> +static void rtw_port_switch_iter(void *data, u8 *mac, struct ieee80211_vif *vif)
> +{
> +	struct rtw_iter_port_switch_data *iter_data = data;
> +	struct rtw_dev *rtwdev = iter_data->rtwdev;
> +	struct rtw_vif *rtwvif_target = (struct rtw_vif *)vif->drv_priv;
> +	struct rtw_vif *rtwvif_ap = iter_data->rtwvif_ap;
> +	const struct rtw_hw_reg *reg1, *reg2;
> +
> +	if (rtwvif_target->port != RTW_PORT_0)
> +		return;
> +
> +	rtw_info(rtwdev, "AP port switch from %d -> %d\n", rtwvif_ap->port,
> +		 rtwvif_target->port);

This looks more like a debug message. In normal operations (after the
initialisation) the drivers should be quiet and only print messages when
something unexpected happens.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
