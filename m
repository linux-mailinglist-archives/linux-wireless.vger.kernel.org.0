Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40484785A3E
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Aug 2023 16:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234129AbjHWOSG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Aug 2023 10:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235020AbjHWOSF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Aug 2023 10:18:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C846E62
        for <linux-wireless@vger.kernel.org>; Wed, 23 Aug 2023 07:18:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B89BF66308
        for <linux-wireless@vger.kernel.org>; Wed, 23 Aug 2023 14:18:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C22CC433C7;
        Wed, 23 Aug 2023 14:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692800282;
        bh=GMdH5vkLU5RgLDl3GYq0LoKq9cbkTrF9yoz4tusx7m0=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=C9mN4hJ1z2zQIpWY5e8AYfKGxW5FAdoWlPG3nLWdVprvBHJ+yLIzvANk8qeXBGaqW
         WtNjOgPkmkjFgDsrbnA2Zfk7AEb9uW6uCup+e7mPGbP+kqY5/t9yYJUa5mytvQ6jG6
         UenRPxQl/odyS544yGUuoUROTqYnqA0rZ9GbO3d18PvaN/jViTXGxJAJh/uwScD3jX
         tz9kY+5X1Yzjz2BWsIxS5rM1A9bcH7iH13SmG7jXpfl24ih2XbTY+8TsUfrRB+UG4+
         xfH+JSQMrJ+T8+GEuXBoK2vgUfMuii8TUwwgYonfti19+iCfxNacy5ZdQO99Shr/X+
         5kztToDGRZIkQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: Fix memory leak in rx_desc and tx_desc
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230718053510.30894-1-quic_rajson@quicinc.com>
References: <20230718053510.30894-1-quic_rajson@quicinc.com>
To:     Rajat Soni <quic_rajson@quicinc.com>
Cc:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Rajat Soni <quic_rajson@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169280027919.1336947.4721639851626095486.kvalo@kernel.org>
Date:   Wed, 23 Aug 2023 14:18:00 +0000 (UTC)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rajat Soni <quic_rajson@quicinc.com> wrote:

> Currently when ath12k_dp_cc_desc_init() is called we allocate
> memory to rx_descs and tx_descs. In ath12k_dp_cc_cleanup(), during
> descriptor cleanup rx_descs and tx_descs memory is not freed.
> 
> This is cause of memory leak. These allocated memory should be
> freed in ath12k_dp_cc_cleanup.
> 
> In ath12k_dp_cc_desc_init(), we can save base address of rx_descs
> and tx_descs. In ath12k_dp_cc_cleanup(), we can free rx_descs and
> tx_descs memory using their base address.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Rajat Soni <quic_rajson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

afb522b36e76 wifi: ath12k: Fix memory leak in rx_desc and tx_desc

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230718053510.30894-1-quic_rajson@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

