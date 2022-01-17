Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E223F4908F6
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jan 2022 13:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbiAQMp2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Jan 2022 07:45:28 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:45108 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbiAQMp1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Jan 2022 07:45:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7132BB8104D
        for <linux-wireless@vger.kernel.org>; Mon, 17 Jan 2022 12:45:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6063C36AEC;
        Mon, 17 Jan 2022 12:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642423525;
        bh=diarlsjyUeuHowtNNVWY50r6KaQgdnsyfvtUVtB0cRk=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=f945m6NRc/sDfkf+EqVFH+3i5UY+QfdPJEs7DNmMrT2nYK5dlHe8sNrAIHRIKDEFc
         oGwLziwfH0szK9dYa3NBHuP/walWmjHKcL9qYhxZ+baYL2WDhxq9SVE2OfnkF+Vh42
         a2qW5V977A+51f7b2jEnMKm8iXY88b+lXN65bjXxMohMjrwDkqol1kLnMx8j6inM+0
         g9eCP0GAkFl1WRotqMa7DoNC+xZee7VfVHmLtUNUIQxXbFE2A97c+yPipkts34dwK+
         dMBsSpUYrvcvbrSDVMGsRoQXzurLUqPBzNfQvKvFESmSQSbuND1txI4fHXLplYBl/V
         ZxfG9qBiXpJVg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] ath10k: abstract htt_rx_desc structure
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20211216151823.68878-1-franciman12@gmail.com>
References: <20211216151823.68878-1-franciman12@gmail.com>
To:     Francesco Magliocca <franciman12@gmail.com>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        enrico@fracta.dev, Francesco Magliocca <franciman12@gmail.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164242352076.27899.16661550947975191712.kvalo@kernel.org>
Date:   Mon, 17 Jan 2022 12:45:23 +0000 (UTC)
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
> Define a base htt_rx_desc structure and htt_rx_desc_v1
> for use with the QCA family of ath10k supported cards
> and htt_rx_desc_v2 for use with the WCN3990 card.
> 
> Define htt_rx_desc_ops which contains the abstract operations
> to access the generic htt_rx_desc, give implementations
> for each card and update htt_rx.c to use the defined
> abstract interface to rx descriptors.
> 
> Fixes: e3def6f7ddf8 ("ath10k: Update rx descriptor for WCN3990 target")
> 
> Tested-on: QCA6174 hw3.2 PCI WLAN.RM.4.4.1-00157-QCARMSWPZ-1
> 
> Co-developed-by: Enrico Lumetti <enrico@fracta.dev>
> Signed-off-by: Enrico Lumetti <enrico@fracta.dev>
> Signed-off-by: Francesco Magliocca <franciman12@gmail.com>
> Link: https://lore.kernel.org/ath10k/CAH4F6usFu8-A6k5Z7rU9__iENcSC6Zr-NtRhh_aypR74UvN1uQ@mail.gmail.com/
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

6bae9de622d3 ath10k: abstract htt_rx_desc structure

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211216151823.68878-1-franciman12@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

