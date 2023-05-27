Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440EB71333D
	for <lists+linux-wireless@lfdr.de>; Sat, 27 May 2023 10:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjE0IRD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 27 May 2023 04:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjE0IRC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 27 May 2023 04:17:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51C4E1
        for <linux-wireless@vger.kernel.org>; Sat, 27 May 2023 01:16:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A59160F28
        for <linux-wireless@vger.kernel.org>; Sat, 27 May 2023 08:16:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC4BEC433D2;
        Sat, 27 May 2023 08:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685175417;
        bh=J+LI9cfyEWSnHpb5g+LVQgHuHtmR3T0juAHYX4U3j5E=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=MxWdx8NXugX6oagLUZoXEaYbYtni+ipGvBWAaIT9Lqxu9lsI0Zec2pzDtFtFYJpje
         GEmDgpWGcTdZDseZwbnGd5FR8hMU1S4jTJjT1poCziS8XgmEoyu8mh8qbXe21lZxiw
         2Tv4v8DkTHnwcFOibnp6pvBL4r7LpOnuGVROG3/ez87ux52VIR3h8JnwK1vwmGSKaS
         lIDJbzYuu85VN78D4QlnioSRiI48LsVCwkRbiK250kgsxPnXt95ZTW42rToUXiMj/N
         dolAE+2OvA7N/orxqR1eVTQRu3MVcgbyANqXK3HseOUvf3AMZGKGjtrGn6OYwC9er0
         Ono2k/ii4MY6A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: mt76: mt7996: fix endianness warning in
 mt7996_mac_write_txwi
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <9509f4bc32d9321f3419a3c0029a01b426f13fd8.1684746447.git.lorenzo@kernel.org>
References: <9509f4bc32d9321f3419a3c0029a01b426f13fd8.1684746447.git.lorenzo@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com,
        linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168517541096.19767.17568326076832648919.kvalo@kernel.org>
Date:   Sat, 27 May 2023 08:16:56 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Fix the following endianness warning in mt7996_mac_write_txwi routine:
> 
> drivers/net/wireless/mediatek/mt76/mt7996/mac.c:1091:25: warning: invalid assignment: |=
> drivers/net/wireless/mediatek/mt76/mt7996/mac.c:1091:25:    left side has type restricted __le32
> drivers/net/wireless/mediatek/mt76/mt7996/mac.c:1091:25:    right side has type unsigned long
> 
> Fixes: 15ee62e73705 ("wifi: mt76: mt7996: enable BSS_CHANGED_BASIC_RATES support")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Reviewed-by: Simon Horman <simon.horman@corigine.com>

Failed to apply, please rebase over wireless tree.

error: sha1 information is lacking or useless (drivers/net/wireless/mediatek/mt76/mt7996/mac.c).
error: could not build fake ancestor
hint: Use 'git am --show-current-patch=diff' to see the failed patch
Applying: wifi: mt76: mt7996: fix endianness warning in mt7996_mac_write_txwi
Patch failed at 0001 wifi: mt76: mt7996: fix endianness warning in mt7996_mac_write_txwi

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/9509f4bc32d9321f3419a3c0029a01b426f13fd8.1684746447.git.lorenzo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

