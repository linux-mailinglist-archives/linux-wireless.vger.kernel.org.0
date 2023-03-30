Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D976D0945
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Mar 2023 17:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbjC3PT1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Mar 2023 11:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbjC3PT0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Mar 2023 11:19:26 -0400
X-Greylist: delayed 381 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 30 Mar 2023 08:18:15 PDT
Received: from mail.toke.dk (mail.toke.dk [IPv6:2a0c:4d80:42:2001::664])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D22FD314
        for <linux-wireless@vger.kernel.org>; Thu, 30 Mar 2023 08:18:14 -0700 (PDT)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1680189068; bh=hVkXO7PZSB0qrRgJUS62J7P7zmKerELjVYkqcykyCCI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=vIPWy3mVo2ugexqr3X9kvDpJheufyJc/UAikEvYyLul8sJgcAIolQPsDwgBjNSMEW
         2sVautb8dpITRAZGYvFkrZPf0tMGLQHsainOBmSSL7L6srz0f8436I6YLGyidEohQU
         zhTXFfidkmYdU33Cx2IIajGTtwLYbcp4jVFNPGmLDAvCHD5PLroutAzKcYvI5x9n2H
         tc2msmWkuFbYJgJ0cgI1pBuKDWemMuJ2kd1kKOyieosqQFBRRq4C5ITP4F6vV6aB4D
         qPcfCdpkqjYL3hyEcm6JCfpNFVt+mMn2Hau/2RTDc/sTYM6KEZEFtW01HD45givQc+
         p3V7ecEyz8gdA==
To:     Jonas Jelonek <jelonek.jonas@gmail.com>,
        linux-wireless@vger.kernel.org
Cc:     thomas.huehn@hs-nordhausen.de, nbd@nbd.name, kvalo@kernel.org,
        johannes.berg@intel.com, lorenzo@kernel.org,
        Jonas Jelonek <jelonek.jonas@gmail.com>
Subject: Re: [PATCH v2] ath9k: fix per-packet TX-power cap for TPC
In-Reply-To: <20230330132159.758088-1-jelonek.jonas@gmail.com>
References: <20230330132159.758088-1-jelonek.jonas@gmail.com>
Date:   Thu, 30 Mar 2023 17:11:07 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87r0t6mfzo.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jonas Jelonek <jelonek.jonas@gmail.com> writes:

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

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>

