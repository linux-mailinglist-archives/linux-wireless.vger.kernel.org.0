Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3CD6B7902
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Mar 2023 14:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbjCMNb1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Mar 2023 09:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbjCMNbV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Mar 2023 09:31:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD0B15161
        for <linux-wireless@vger.kernel.org>; Mon, 13 Mar 2023 06:30:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 04317B810F1
        for <linux-wireless@vger.kernel.org>; Mon, 13 Mar 2023 13:30:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6272C433D2;
        Mon, 13 Mar 2023 13:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678714205;
        bh=Dh+EHKcJ5GswwdKBK05bEQYQc334Nu1cv89Vl2Qvfr8=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=VVWMjLehYUtD8GwEUzRrVhrgc1To8bphwHH2J4V7b8bILZdJ1Gif6d17whwqsFG/r
         CAA5YX7rw66XcN2EqRNIhu2PBk5SCWjN/Ji668M6E894AiBqEMBsU6XOJ84kjEvSFk
         b1/OlC5yAwlKPSMYxxRw/rbXaAl2qXU8Q6dmcEftsgh8p3HEQiFdXF7laqQ+Jrl4Q8
         JQYT6BTKrjR1Bkaqi7r/opFUh+6Uq7njnTVbQvc3h14+tS/IV7feagqePJdfyI1jAD
         S6IajROVgtIYNlBlSjoXTt/k1hpxot3lNkAyioj5TqLTQgebnhqTNjbNsgBpoWDrBw
         Mt9qgPN9M36GA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH wireless] wifi: mt76: do not run mt76_unregister_device()
 on
 unregistered hw
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <be3457d82f4e44bb71a22b2b5db27b644a37b1e1.1677107277.git.lorenzo@kernel.org>
References: <be3457d82f4e44bb71a22b2b5db27b644a37b1e1.1677107277.git.lorenzo@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, nbd@nbd.name, helmut@subdivi.de,
        lorenzo.bianconi@redhat.com
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167871420240.22880.15712893985847828554.kvalo@kernel.org>
Date:   Mon, 13 Mar 2023 13:30:04 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Trying to probe a mt7921e pci card without firmware results in a
> successful probe where ieee80211_register_hw hasn't been called. When
> removing the driver, ieee802111_unregister_hw is called unconditionally
> leading to a kernel NULL pointer dereference.
> Fix the issue running mt76_unregister_device routine just for registered
> hw.
> 
> Link: https://bugs.debian.org/1029116
> Link: https://bugs.kali.org/view.php?id=8140
> Reported-by: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>
> Fixes: 1c71e03afe4b ("mt76: mt7921: move mt7921_init_hw in a dedicated work")
> Tested-by: Helmut Grohne <helmut@freexian.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Patch applied to wireless.git, thanks.

41130c32f3a1 wifi: mt76: do not run mt76_unregister_device() on unregistered hw

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/be3457d82f4e44bb71a22b2b5db27b644a37b1e1.1677107277.git.lorenzo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

