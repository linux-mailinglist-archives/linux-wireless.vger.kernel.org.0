Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A577B21A3
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Sep 2023 17:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbjI1Pq6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Sep 2023 11:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbjI1Pq5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Sep 2023 11:46:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0520D6
        for <linux-wireless@vger.kernel.org>; Thu, 28 Sep 2023 08:46:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37F9FC433C7;
        Thu, 28 Sep 2023 15:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695916014;
        bh=KCQCIRbsa1m6qTWh9HIbZJWA7KSkVBIONtP4ro1bci0=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=mf8uvYje4sSGnByBOhDNCm480tZwXE8q+Bk01qYVSZFutC9p4vlKhrvF3QD7dPo77
         0KaYfdkRDWh3IqKbaOBEYnCPZyiTehqt6Erz6YQEicAJOaZQ//LeSY1MpDbXHjijEF
         thZj4J2TAdrXg8nN8cnCe8OGA8zi8IrxvTddpCpq24dtjw41iDTceeGXPMj07SIMN2
         5NOCuf7YSsIA79ffkZG5fY71ww4j9rydoI65DnXI28j7Smm8hEnzm/dXI5sIMphVBg
         m9Mt1Wz/w26O8uuoiTDZPuBD9XzkcAxXB7Hq4iN5MOWgVIIFvjbxqtC19dc7ruwunU
         9o57+43RnaPLA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath11k: drop NULL pointer check in
 ath11k_dp_rx_mon_dest_process()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230907083852.10775-1-dmantipov@yandex.ru>
References: <20230907083852.10775-1-dmantipov@yandex.ru>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        linux-wireless@vger.kernel.org, lvc-project@linuxtesting.org,
        ath11k@lists.infradead.org, Dmitry Antipov <dmantipov@yandex.ru>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169591601112.3096214.11174520645995155662.kvalo@kernel.org>
Date:   Thu, 28 Sep 2023 15:46:53 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dmitry Antipov <dmantipov@yandex.ru> wrote:

> Since 'srng_list' is a fixed-size array of 'struct hal_srng'
> in 'struct ath11_hal', any of its member can't be NULL and
> so relevant check may be dropped.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

Failed to apply.

error: patch failed: drivers/net/wireless/ath/ath11k/dp_rx.c:5094
error: drivers/net/wireless/ath/ath11k/dp_rx.c: patch does not apply
stg import: Diff does not apply cleanly

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230907083852.10775-1-dmantipov@yandex.ru/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

