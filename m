Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B12846E453F
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Apr 2023 12:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbjDQKdh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Apr 2023 06:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbjDQKd0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Apr 2023 06:33:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3545FC0
        for <linux-wireless@vger.kernel.org>; Mon, 17 Apr 2023 03:32:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9E63614E9
        for <linux-wireless@vger.kernel.org>; Mon, 17 Apr 2023 10:32:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD72EC433D2;
        Mon, 17 Apr 2023 10:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681727521;
        bh=VoKLRLIqg6P5TWJ+bX+VxLZ4+h/ZRGMm8P5ymLNr4rg=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=mJR1JO7fpiTgka6rXF/C1QJl3wpdwUFeKH/OyHgQZO1UeDy1W8pnGM3IXKjsx1niL
         etfzAE294VvOT9Q/PJW3yZ8Kp1uFz/HB0ebLlNjLNUr/1AXQj3To6YHGAxUsc1RR2i
         rHq1IDkF8z5X8+/ilrpN4v8WjBKauLs7D7Mn2vBEMN8djaM4RipF6MVaHbdPlpGVwV
         dDFU//RTU9Llx1H1yuBEEG9cq3S8x5692WeR3ZxTYwiD/wcr1hXrfiiwCiOdjUC/bF
         uCfHGYPfJhk5cReVZdT17f3lw0+7vwpMNAYVmbeTrYNCi7ZfywuMHuZFT1rm7KkHVw
         H0+yK5e7fry5w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] ath9k: fix per-packet TX-power cap for TPC
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230330132159.758088-1-jelonek.jonas@gmail.com>
References: <20230330132159.758088-1-jelonek.jonas@gmail.com>
To:     Jonas Jelonek <jelonek.jonas@gmail.com>
Cc:     linux-wireless@vger.kernel.org, thomas.huehn@hs-nordhausen.de,
        nbd@nbd.name, johannes.berg@intel.com, lorenzo@kernel.org,
        Jonas Jelonek <jelonek.jonas@gmail.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168172751777.21228.15075674009242455727.kvalo@kernel.org>
Date:   Mon, 17 Apr 2023 10:31:59 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jonas Jelonek <jelonek.jonas@gmail.com> wrote:

> Fix incorrect usage of plain rate_idx as index into the max (power) per
> rate lookup table.
> 
> For transmit power control (TPC), the ath9k driver maintains internal
> tables (in struct ath_hw) to store the max allowed power level per rate.
> They are used to limit a given TX-power according to regulatory and user
> limits in the TX-path per packet. The tables are filled in a predefined
> order, starting with values for CCK + OFDM rates and followed by the
> values for MCS rates. Thus, the maximum power levels for MCS do not
> start at index 0 in the table but are shifted by a fixed value.
> 
> The TX-power limiting in ath_get_rate_txpower currently does not apply
> this shift, thus retrieves the incorrect maximum power level for a given
> rate. In particular for MCS rates, the maximum power levels for CCK/OFDM
> rates were used, e.g. maximum power for OFDM 0 was used for MCS 0. If
> STBC is used, the power is mostly limited to 0 because the STBC table
> is zeroed for legacy CCK/OFDM rates. Encountered this during testing of
> our work-in-progress TPC per packet for ath9k.
> This only has an effect when TPC is enabled in ath9k (tpc_enabled in
> struct ath_hw) which defaults to false. In this case it has a
> significant impact on the used TX-power, throughput + RSSI. Otherwise
> the affected code is just skipped and TX-power is limited with the
> hardware registers only. This patch fixes this table lookup.
> 
> Tested on OpenWrt (kernel 5.15.98, but backported ath9k driver) with
> small desk setup using ath9k chips AR9280 and AR9580. Cap of TX-power is
> working properly for all rates now, throughput and RSSI as expected,
> equal to as if TPC was disabled.
> Compile-tested with latest 6.3 kernel + allyesconfig.
> 
> Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>
> Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

e04e4b6e01e7 wifi: ath9k: fix per-packet TX-power cap for TPC

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230330132159.758088-1-jelonek.jonas@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

