Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 856EEBB16C
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Sep 2019 11:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405721AbfIWJ3w (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Sep 2019 05:29:52 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39192 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405719AbfIWJ3w (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Sep 2019 05:29:52 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8F93160256; Mon, 23 Sep 2019 09:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569230990;
        bh=D+rdXYJOSYeIJJ0VA2+MIg14cqG8bvEfeyZVH63asSc=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Jg2IJWk8Ug/niNGBDyMvXpXZYErcSHcH84Xdb2KKLZgzumo3+47vHucvPIpzVOWw4
         f/t0cZrQGJ/sQ+lGtIbsZMJFh0FGFL8sXZKUny4WYlO99O2r0544H78ndfXk+p820Y
         eubpWrOuHUAlN6VeknRjgiC3f8AltmhmjYb8+jh0=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from x230.qca.qualcomm.com (37-136-106-186.rev.dnainternet.fi [37.136.106.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 794146021C;
        Mon, 23 Sep 2019 09:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569230989;
        bh=D+rdXYJOSYeIJJ0VA2+MIg14cqG8bvEfeyZVH63asSc=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=fQgLbZ1cvV5AMZa973G9VfW923xVRjG4KWlJZ0KDiorbi5dc51UcKaQb1W0vARsBy
         sz8puuKQrOQykQTAoFopZG0qOnSfBFY+qENAMpbuHMf/tfOiPQzx1asPRRtH1DxFRo
         CNbbBu/xeH3nMwQpYsWtCg2ofxXj+eFEu9lDp4qw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 794146021C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v5 0/8] ath10k: improve throughout of tcp/udp TX/RX of sdio
References: <1567679893-14029-1-git-send-email-wgong@codeaurora.org>
Date:   Mon, 23 Sep 2019 12:29:46 +0300
In-Reply-To: <1567679893-14029-1-git-send-email-wgong@codeaurora.org> (Wen
        Gong's message of "Thu, 5 Sep 2019 18:38:05 +0800")
Message-ID: <87sgon8inp.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> writes:

> The bottleneck of throughout on sdio chip is the bus bandwidth, to the
> patches are all to increase the use ratio of sdio bus.
>
>                       udp-rx    udp-tx    tcp-rx    tcp-tx
> without patches(Mbps)  320        180       170       151
> with patches(Mbps)     450        410       400       320
>
> These patches only affect sdio bus chip, explanation is mentioned in each
> patch's commit log.

Below is my summary of the patchset. I recommend splitting these into
smaller sets, makes it a lot easier to review and apply. And please send
only one or two patchsets at a time.

[PATCH v5 1/8] ath10k: adjust skb length in ath10k_sdio_mbox_rx_packet

Applied.

Patchset 1:

[PATCH v5 2/8] ath10k: enable RX bundle receive for sdio
[PATCH v5 3/8] ath10k: change max RX bundle size from 8 to 32 for sdio

Reasonal but needs some cleanup.

Patchset 2:

[PATCH v5 4/8] ath10k: add workqueue for RX path of sdio

Is really another thread needed? We already have one for SDIO.

[PATCH v5 6/8] ath10k: add htt TX bundle for sdio

And again a new thread so that we would have three threads for SDIO? I'm
not convinced about that.

Patchset 3:

[PATCH v5 7/8] ath10k: enable alt data of TX path for sdio

Again another module parameter?

[PATCH v5 8/8] ath10k: enable napi on RX path for sdio

Seems reasonable, but worried about breaking USB.

Patchset 4:

[PATCH v5 5/8] ath10k: disable TX complete indication of htt for sdio

Quite hackish and I need numbers how much it really improves throughput

-- 
Kalle Valo
