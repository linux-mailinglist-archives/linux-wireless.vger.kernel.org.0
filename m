Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52CAB46C240
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Dec 2021 19:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240301AbhLGSEj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Dec 2021 13:04:39 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:40110 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240264AbhLGSEi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Dec 2021 13:04:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A6F4DB8174A
        for <linux-wireless@vger.kernel.org>; Tue,  7 Dec 2021 18:01:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A323C341C3;
        Tue,  7 Dec 2021 18:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638900066;
        bh=d1e8wK8u23dH/uMREW1nl9bpvWdgauhYNxNZbO1wBPs=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=K4Ir9RhSzDymQjcuSQ0VMIcEacHXj1wAeNk36gHVe/d8TXrhJNMbVIq+GuW3Akjq3
         6ylpy0lggF3XV+72yaS5owaC3+vZQZWV9Zu/oIOEMUYgpjsxx1tz75+PobsXtdAtpi
         iEkqUqwC48LhOapGw0ASAAaq0WeLI5vX/ohixcfQi1xp88ZMffMPHirAXdbRadByH2
         EVWpXFoQbL/GjnyFmNrObv/my4/hh4rYUWBxc9I/ZkPvnnh4NRIibP09Li6YIIDC4Y
         Gx2wURZ1MY/Fz8qOnuI+BSeaPR4eppjh7cNKui4HHLcBH9U9HTlAhkPduIVTtcgdJS
         cG0cNzuRuMjMw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: abstract htt_rx_desc structure
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <CAH4F6us6kLs4WZVKVNQV69wZ=BA2AzOyacyKLB3RfVme=9uKvA@mail.gmail.com>
References: <CAH4F6us6kLs4WZVKVNQV69wZ=BA2AzOyacyKLB3RfVme=9uKvA@mail.gmail.com>
To:     Francesco Magliocca <franciman12@gmail.com>
Cc:     ath10k@lists.infradead.org,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        linux-wireless@vger.kernel.org, enrico@fracta.dev
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163890006140.24891.14844374347226252991.kvalo@kernel.org>
Date:   Tue,  7 Dec 2021 18:01:05 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Francesco Magliocca <franciman12@gmail.com> wrote:

> QCA6174 card often hangs with the current htt_rx_desc
> memory layout in some circumstances, because its firmware
> fails to handle length differences.
> Therefore we must abstract the htt_rx_desc structure
> and operations on it, to allow different wireless cards
> to use different, unrelated rx descriptor structures.
> 
> Define a base htt_rx_desc structure and htt_rx_desc_qca_old
> for use with the QCA family of ath10k supported cards
> and htt_rx_desc_new for use with the WCN3990 card.
> 
> Define htt_rx_desc_ops which contains the abstract operations
> to access the generic htt_rx_desc, give implementations
> for each card and update htt_rx.c to use the defined
> abstract interface to rx descriptors.
> 
> Fixes: e3def6f7 ("ath10k: Update rx descriptor for WCN3990 target")
> 
> Tested-on: QCA6174 hw3.2 PCI WLAN.RM.4.4.1-00157-QCARMSWPZ-1
> 
> Co-developed-by: Enrico Lumetti <enrico@fracta.dev>
> Signed-off-by: Enrico Lumetti <enrico@fracta.dev>
> Signed-off-by: Francesco Magliocca <franciman12@gmail.com>

The patch is corrupted and I'm not able to apply it.

error: corrupt patch at line 19
stg import: Diff does not apply cleanly

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/CAH4F6us6kLs4WZVKVNQV69wZ=BA2AzOyacyKLB3RfVme=9uKvA@mail.gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

