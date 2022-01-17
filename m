Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B24A749087B
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jan 2022 13:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239772AbiAQMOF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Jan 2022 07:14:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239765AbiAQMOF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Jan 2022 07:14:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5B2C061574;
        Mon, 17 Jan 2022 04:14:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0EB5AB80EFF;
        Mon, 17 Jan 2022 12:14:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D3F7C36AE3;
        Mon, 17 Jan 2022 12:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642421642;
        bh=BBOF++IVz/pta6LKd13k1kPWwmvKm8Im1AVHqlJUUc0=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ptfJh3HmjCF8PtBd7je+GfO/cxIUau6CzCINOmsXiJ70VMtIE2UuquN8lLYwvycGs
         HdbAb9nG3zG4qQ31Fm21NuzWFWwMFpdKaU8bAQiEdyWpYmBkzTcXdomHJ1wt08mnhV
         cF5m1nm9DUMTqwNQEBuFdIks2s7S0b4wS1TJKqPN1fCrvUxVvrJvrVqYXiLztYu7zs
         7LSUWuJV7vmaopF9uhDpskxyje3anadFiyB7pm5DP1/WjPbeYB27QZX3gKAEZf1qaH
         Y8MklX2SrxeklZa9Hc/vLH/OaMFnFiHO/7A69NVulGnBopUufwgK2QFimsTzRLOZBF
         pkK7WFX398ijQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     linux-wireless@vger.kernel.org, wcn36xx@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, loic.poulain@linaro.org,
        benl@squareup.com
Subject: Re: [PATCH v3 1/4] wcn36xx: Implement get_snr()
References: <20220115001646.3981501-1-bryan.odonoghue@linaro.org>
        <20220115001646.3981501-2-bryan.odonoghue@linaro.org>
Date:   Mon, 17 Jan 2022 14:13:57 +0200
In-Reply-To: <20220115001646.3981501-2-bryan.odonoghue@linaro.org> (Bryan
        O'Donoghue's message of "Sat, 15 Jan 2022 00:16:43 +0000")
Message-ID: <87fspmsgoq.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bryan O'Donoghue <bryan.odonoghue@linaro.org> writes:

> The wcn36xx BD phy descriptor returns both Received Signal Strength
> Information (RSSI) and Signal To Noise Ratio (SNR) with each delivered BD.
>
> The macro to extract this data is a simple-one liner, easily imported from
> downstream. This data will be useful to us when implementing
> mac80211-ops->get_survey().

I assume with downstream you mean the prima driver, I'll change that.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
