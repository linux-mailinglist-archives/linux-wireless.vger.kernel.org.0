Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5DB73113D
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Jun 2023 09:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244969AbjFOHrt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Jun 2023 03:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245160AbjFOHrl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Jun 2023 03:47:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A652125
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jun 2023 00:47:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA8396113C
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jun 2023 07:47:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 302C3C433C0;
        Thu, 15 Jun 2023 07:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686815258;
        bh=7CVt0yJUE9MoB4TVN1pUXjMz47ah5wIriJqAdAsIKxA=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Edjo9H1aN0j3yl0U34fL1fvQkTMatm7RT9fV1QAb3HLUO/jyv+diHMrP4tHE08b7y
         M0LbCfYBgDaRNHat2f57WdhOYdxUCyCOPg0lpfB537zAsdsaLEySjJi+M+8lnYUv02
         Q6swk07UPDBibjXJ6DGl1yEIQzdF/+YNywekMInXD4l8g38RiXmNn87ND1lz+0cGOP
         aaUQ0/RMF0qe7tp+0cB/cyaYfZ9sODrjw+fJdDtJ/AJL3nwY8+oV4y/hDaVv6rfChH
         +KCxR5SyF79r5GaKfISVmcpnpe/ex8zSdBc4WhU9VipKEky8SZXecwcvGvEl8faGNg
         0KFTiMMcKBosQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/3] [v6] wifi: rtw89: cleanup private data structures
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230614081555.91395-1-dmantipov@yandex.ru>
References: <20230614081555.91395-1-dmantipov@yandex.ru>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168681525495.8111.4617235468513878840.kvalo@kernel.org>
Date:   Thu, 15 Jun 2023 07:47:37 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dmitry Antipov <dmantipov@yandex.ru> wrote:

> Remove a bunch of unused (and set but unused) fields
> from 'struct rtw89_btc_wl_nhm', 'struct rtw89_dle_info',
> 'struct rtw89_hal' and 'struct rtw89_env_monitor_info'
> driver-specific data structures, adjust related bits.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

3 patches applied to wireless-next.git, thanks.

65a9140e38b6 wifi: rtw89: cleanup private data structures
686317a246cd wifi: rtw89: cleanup rtw89_iqk_info and related code
5bc9a34ce87b wifi: rtw89: fix spelling typo of IQK debug messages

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230614081555.91395-1-dmantipov@yandex.ru/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

