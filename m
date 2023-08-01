Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A61B76B7F0
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Aug 2023 16:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234822AbjHAOri (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Aug 2023 10:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234180AbjHAOri (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Aug 2023 10:47:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F85B1BCF
        for <linux-wireless@vger.kernel.org>; Tue,  1 Aug 2023 07:47:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E21F6615D3
        for <linux-wireless@vger.kernel.org>; Tue,  1 Aug 2023 14:47:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 072D2C433C8;
        Tue,  1 Aug 2023 14:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690901256;
        bh=A6d4S4Wf0mfkNxaD8pMeDfYCvT82PGNAf+8GL8JCK9o=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=JLMVXFpeVkQTRdfh5syOy/aSgmoS2G5FrKdmEGp58UjyJadahjTUGwlA3gcC1/FNH
         Drc41jqOb2Pfxs4ZTLiv1lqmWj5LRn8/ywS/ZywbgsQiTHIwn4uVFs56PVYnGMv491
         q75ytQ+ZVWBTGZtfOu0sbzJ1ufidQVvKzPIkHKneabf5GUm3aufbLMHzmlHj4XompQ
         4mvXv4T5Xs9GxXSkCbbfUkIeXVoxQLrs1QdJ/0QKWvXyJEvkN+j4LvsUZAXW6Rd6mr
         28GuZmZXe5iMBxHpC4ZqYKTwWAahrptX5Du63/kcathxLx5KQx1yNgEEPIHBGogUZ9
         3h+oxMEvwepdQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v7] wifi: mwifiex: Fix OOB and integer underflow when rx
 packets
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230723070741.1544662-1-pinkperfect2021@gmail.com>
References: <20230723070741.1544662-1-pinkperfect2021@gmail.com>
To:     Polaris Pi <pinkperfect2021@gmail.com>
Cc:     matthewmwang@chromium.org, briannorris@chromium.org,
        kuba@kernel.org, linux-wireless@vger.kernel.org,
        Polaris Pi <pinkperfect2021@gmail.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169090125328.212423.6884831819316913937.kvalo@kernel.org>
Date:   Tue,  1 Aug 2023 14:47:34 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Polaris Pi <pinkperfect2021@gmail.com> wrote:

> Make sure mwifiex_process_mgmt_packet,
> mwifiex_process_sta_rx_packet and mwifiex_process_uap_rx_packet,
> mwifiex_uap_queue_bridged_pkt and mwifiex_process_rx_packet
> not out-of-bounds access the skb->data buffer.
> 
> Fixes: 2dbaf751b1de ("mwifiex: report received management frames to cfg80211")
> Signed-off-by: Polaris Pi <pinkperfect2021@gmail.com>
> Reviewed-by: Matthew Wang <matthewmwang@chromium.org>
> Reviewed-by: Brian Norris <briannorris@chromium.org>

Patch applied to wireless-next.git, thanks.

119585281617 wifi: mwifiex: Fix OOB and integer underflow when rx packets

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230723070741.1544662-1-pinkperfect2021@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

