Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF87851B724
	for <lists+linux-wireless@lfdr.de>; Thu,  5 May 2022 06:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242694AbiEEE2v (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 May 2022 00:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiEEE2u (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 May 2022 00:28:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2336225285
        for <linux-wireless@vger.kernel.org>; Wed,  4 May 2022 21:25:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9EFF3B82B1E
        for <linux-wireless@vger.kernel.org>; Thu,  5 May 2022 04:25:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ECA6C385AC;
        Thu,  5 May 2022 04:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651724708;
        bh=3Oe6ZBRqpW08S5I0nat5b0sA/RqhRvjKjYgAURXkykQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=maREjnhNrCvw7jkXa6R24oV3sqZLWzsLWymGpu1cwOQKgQsw/EEotl7ozfnZHiG0c
         R1BJcM3f9HN4PvdtVomicpwkkv1MwBnugQNU27rjsFJavZPD1WXxlbSh+6xUZIc6Ek
         U7noV6xxRKpA1bGxoMoX63I9Mc2oK5ok+J82akke3afoGqboWPNeyoVkq3HkWrm5px
         h0hC8FBDdWzxqLmEwDl51YXMI7Pv+vFFpeXua7w54b7Sj1+IiSyBU1HbTf6XfDEGTy
         K1NPrDNV9d/hkApOuQWrvVJ816OgZ6T0x4A7D+yjk5fOVy51s1s79ngdB/dtQtQF3U
         Fay1neoq5ipPA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH wireless-next 0/3] wifi: netif_napi_add() conversions
References: <20220504163316.549648-1-kuba@kernel.org>
Date:   Thu, 05 May 2022 07:25:03 +0300
In-Reply-To: <20220504163316.549648-1-kuba@kernel.org> (Jakub Kicinski's
        message of "Wed, 4 May 2022 09:33:13 -0700")
Message-ID: <87a6bwzjvk.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jakub Kicinski <kuba@kernel.org> writes:

> Convert wifi callers to the new netif_napi_add() APIs.
>
> The callers passing 64 or NAPI_POLL_WEIGHT to the non-Tx flavor
> are left alone. I'm planning to include wifi drivers in the massive
> tree-wide patch/series which will drop the last argument from
> netif_napi_add(). Alternatively I can switch all of wifi to
> netif_napi_add_tx_weight() and back after the netif_napi_add()
> change makes its wait into wireless-next.
> Please LMK if you prefer that.
>
> Jakub Kicinski (3):
>   wifi: wil6210: switch to netif_napi_add_tx()
>   wifi: mt76: switch to netif_napi_add_tx()
>   wifi: qtnfmac: switch to netif_napi_add_weight()

We don't use that "wifi:" prefix, otherwise looks good. Feel free to
take via your tree:

Acked-by: Kalle Valo <kvalo@kernel.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
