Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE6AD72EAA8
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jun 2023 20:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbjFMSPi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Jun 2023 14:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233782AbjFMSPg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Jun 2023 14:15:36 -0400
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9EEC19B5
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jun 2023 11:15:33 -0700 (PDT)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1686680132; bh=jzSKSaw6yFODVr7w5QacycAN66wxVkHmAf2GWtVMqBg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=o0DCqnkU0/4epID3YCiHsyKVvHm4Ucfjl5NZBucmiOAW0fcLP6qpG9NwCjhqWZVpx
         fiCAtFdOzOCojn/klZ93Sb3xzLcWIDtfKUdUrh5027EWjKQOYc2MiX5cpOMcDyNp3t
         oLhHm5MFrH44RNT9Y7UIkybqZTxEzQDCbzeu4Megd+rZ5sWeVy+MGS3BjIngoKn2n2
         CoaSpz6RhAJy5NcKwWemSJGEj3md8EEeoWrel8aA9MNUpJq8vYCerN6TUTDBKS1MQC
         xNmtKbz6rf7w1qZqji9WIrlk9r5cQJgq5GjkSSzQQKVPcWxUX0povjvEzC6g4Kxl3g
         lcLKasf1HYYAg==
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: Re: [PATCH] wifi: ath9k: convert msecs to jiffies where needed
In-Reply-To: <20230613134655.248728-1-dmantipov@yandex.ru>
References: <20230613134655.248728-1-dmantipov@yandex.ru>
Date:   Tue, 13 Jun 2023 20:15:31 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87y1knw7ng.fsf@toke.dk>
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

> Since 'ieee80211_queue_delayed_work()' expects timeout in
> jiffies and not milliseconds, 'msecs_to_jiffies()' should
> be used in 'ath_restart_work()' and '__ath9k_flush()'.
>
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

I believe this warrants a:

Fixes: d63ffc45c5d3 ("ath9k: rename tx_complete_work to hw_check_work")

with that:

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
