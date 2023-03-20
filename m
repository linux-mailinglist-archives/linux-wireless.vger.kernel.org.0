Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA806C1D63
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Mar 2023 18:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbjCTRKy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Mar 2023 13:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233353AbjCTRK3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Mar 2023 13:10:29 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C472DE44
        for <linux-wireless@vger.kernel.org>; Mon, 20 Mar 2023 10:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=f18Jj1X5RBDBxDmYG5gdBT4DNpSY1VTIA46He4j4jkE=;
        t=1679331973; x=1680541573; b=sqVe5PNcKpGZTDQD4osQBUMCXG/OeF/F0Q5SzmbPFgCXTTm
        goJRaaBbXmvTH9ZDESCwsUb6b/igXDPuEH1MN+P65Mqgp5aCJiF3WocjkT4+YleaV52l5UsYM2cXJ
        e3UW4ISA20QwARC7sqqeRWrnAdVrnDJlHe2WsVs18jv9PfCrTomjcmUVlaEFqxM3p8P6gK7WcuRK/
        C0CaJJ7tKDrVnQROuR3qU6Ao7mYIGHLKNze1WjICHMbdoK8KipecySsaR6Yvk4G27xeru/2+13oTN
        cNXzO7SfoX3awLPJghlhWfhH7+HsIG88tQi5QVP5c1DZj4JTCM085pBJ/DoQX/7g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1peIwM-0094EH-20;
        Mon, 20 Mar 2023 18:04:58 +0100
Message-ID: <5e4ebc0244dfaafe8fe640458130a4527f43c728.camel@sipsolutions.net>
Subject: Re: [PATCH v2 0/4] Add AP power save support
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Maharaja Kennadyrajan <quic_mkenna@quicinc.com>,
        ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 20 Mar 2023 18:04:57 +0100
In-Reply-To: <20230320164334.3325886-1-quic_mkenna@quicinc.com>
References: <20230320164334.3325886-1-quic_mkenna@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2023-03-20 at 22:13 +0530, Maharaja Kennadyrajan wrote:
> AP power save feature is enabled when the driver and hardware
> supports. If the driver suppots this feature then driver will
> advertise this flag SUPPORTS_AP_PS to enable the AP power save
> in mac80211.
>=20
> AP goes into the power save mode, if no stations are connected
> and it will come out of power save as and when any of the station
> associate to it. Also, during the power save tx chain mask is
> reduced to 1x1 until the any station connects with more than
> 1x1 chain mask.
>=20

All of that seems entirely transparent, similar to how mac80211 today
reduces bandwidth of the AP interface (min_def in a chandef) - what's
the point of doing all this infrastructure to make it configurable then?
Why not always have it, and perhaps make some debugfs to turn it off for
debugging/experiments?

johannes
