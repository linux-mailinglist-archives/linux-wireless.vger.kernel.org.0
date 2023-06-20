Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5B0E736B87
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jun 2023 14:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbjFTMFg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Jun 2023 08:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjFTMF3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Jun 2023 08:05:29 -0400
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596BB1709
        for <linux-wireless@vger.kernel.org>; Tue, 20 Jun 2023 05:05:26 -0700 (PDT)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1687262723; bh=7b2cfT4q4kUSUpHOVSXR2A8k+9G4TngwBe2H5LXpB0w=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=PLQ4NS5EdnNExMH7NbfFqheRYeAdEc+sLBuT3E7EK7ztPW7ubILitPNco5c+9GHav
         lTvsH66wl4lkZayDd+Id/SIy9ojrtMHF9B5qZgpT0zb/JktPR09VJ5iHNI+l8wsaxd
         010+0PSt5VMLH+q6w2s9WH80gUXE/eX9qJQDTJ5bZGwhp4sYUSJpuMwSB0bZpUJgub
         iz/HhQDM6ZqXyUnHboSJFrLE+psTuqqhPkPCr0zcC2Y70yaJMvkYWXYag3WwkUdAyn
         FteCqb0PAwQlOcdhM5pbR1dgnIlOF8g8H+909XcfqCyszbTuuEZvFbb4n05T+SkCFx
         dxlovadKiqezQ==
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: Re: [PATCH 1/2] [v2] wifi: ath9k: avoid using uninitialized array
In-Reply-To: <20230620080855.396851-1-dmantipov@yandex.ru>
References: <20230620080855.396851-1-dmantipov@yandex.ru>
Date:   Tue, 20 Jun 2023 14:05:22 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87a5wue3ul.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dmitry Antipov <dmantipov@yandex.ru> writes:

> In 'ath_tx_count_frames()', 'ba' array may be used uninitialized, so
> add 'memset()' call similar to one used in 'ath_tx_complete_aggr()'.
>
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
