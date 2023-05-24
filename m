Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810DC70F361
	for <lists+linux-wireless@lfdr.de>; Wed, 24 May 2023 11:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjEXJrE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 May 2023 05:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjEXJrC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 May 2023 05:47:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA7093
        for <linux-wireless@vger.kernel.org>; Wed, 24 May 2023 02:47:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F3D762828
        for <linux-wireless@vger.kernel.org>; Wed, 24 May 2023 09:47:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9474BC433EF;
        Wed, 24 May 2023 09:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684921620;
        bh=bcvRAdI8ldnK2zZnrBoEpGJCxnft/lqn2evWQmQRaJY=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=jC1ug9MAHNnxhzEaGlryQ+ePQ8ZNJDf1tA2kI2w2adFqKwQ08tQsIOeJHWqE3lgfZ
         GXTOVUcXeWS6WkQ9DhGoMdvxb5ssN6AdwIg3I7A0B5w7qkcap0s8P4UeyZI/4b4XIS
         WYQFMnnf5l7bFKjseT5FDqeTPux3h3MklmydYNbCpafjDk99Es3v+iO4fKUFbnyne3
         ZqoEIWD7UwMuVSYcGk3IN3+Oc0E994+52hzaTXONh3heRFm6prPc39NuXkijqQhRpT
         BwXSvdHYYS3SNlJhizl2yEHvHtpg3/thKTIR0IDbFiC6HNSaFq1W0mmicFUE0R4xp4
         nbNqFToZ/6puw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: mt76: mt7996: fix endianness warning in mt7996_mac_write_txwi
References: <9509f4bc32d9321f3419a3c0029a01b426f13fd8.1684746447.git.lorenzo@kernel.org>
Date:   Wed, 24 May 2023 12:46:54 +0300
In-Reply-To: <9509f4bc32d9321f3419a3c0029a01b426f13fd8.1684746447.git.lorenzo@kernel.org>
        (Lorenzo Bianconi's message of "Mon, 22 May 2023 11:09:01 +0200")
Message-ID: <87pm6qkqnl.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> writes:

> Fix the following endianness warning in mt7996_mac_write_txwi routine:
>
> drivers/net/wireless/mediatek/mt76/mt7996/mac.c:1091:25: warning: invalid assignment: |=
> drivers/net/wireless/mediatek/mt76/mt7996/mac.c:1091:25:    left side has type restricted __le32
> drivers/net/wireless/mediatek/mt76/mt7996/mac.c:1091:25:    right side has type unsigned long
>
> Fixes: 15ee62e73705 ("wifi: mt76: mt7996: enable BSS_CHANGED_BASIC_RATES support")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Commit 15ee62e73705 is in v6.4-rc1 so I should take this to wireless,
right? Felix, ack?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
