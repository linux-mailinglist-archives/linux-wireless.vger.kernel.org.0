Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E07E12C679
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2019 14:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbfE1M2j (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 May 2019 08:28:39 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39270 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726580AbfE1M2j (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 May 2019 08:28:39 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9DFCC607CA; Tue, 28 May 2019 12:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559046518;
        bh=VWyaDCfFJGBHWFrbs/WrgqYDyCsaFwNYuMp2vPDqxzU=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=jqWdp596lVDPadwR+S0BmRjW7WEL9Gee9SRsXibiajCRqSFYwYIwbVbO7ykLovm/v
         kcJkWPx2mde2/4RhnI0oRsjQygxYtK6PAXLDByIdWKb3YSnezVbvKLILsixzwMxgj9
         noTzw1hXbVZfXm1F7zOMSg1/ATw/Jy9Cm0+wkhqI=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,MISSING_DATE,MISSING_MID,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 929EF6034D;
        Tue, 28 May 2019 12:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559046517;
        bh=VWyaDCfFJGBHWFrbs/WrgqYDyCsaFwNYuMp2vPDqxzU=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=CB50bJslUYXYYzC5zUzcYM6uIAhHCXU1/CUx+ywVgbzf2MH7tfmOo0Mar/lqQA216
         X8diKvx/Mfvym1B3SD+Q+VCdbuVylGyu9VOrFyMqR41U+k7ZsKU10rO+mSHyxLoiZU
         V0HgxEWTjWpQRVPXKqY0plgQu8h/RP8YywUslI3k=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 929EF6034D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/7] rt2x00: allow to specify watchdog interval
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1556788021-6531-2-git-send-email-sgruszka@redhat.com>
References: <1556788021-6531-2-git-send-email-sgruszka@redhat.com>
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     linux-wireless@vger.kernel.org,
        =?utf-8?q?Tomislav_Po=C5=BEega?= <pozega.tomislav@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Felix Fietkau <nbd@nbd.name>, Mathias Kresin <dev@kresin.me>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190528122838.9DFCC607CA@smtp.codeaurora.org>
Date:   Tue, 28 May 2019 12:28:38 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Stanislaw Gruszka <sgruszka@redhat.com> wrote:

> Allow subdriver to change watchdog interval by intialize
> link->watchdog_interval value before rt2x00link_register().
> 
> Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>

Failed to apply:

fatal: sha1 information is lacking or useless (drivers/net/wireless/ralink/rt2x00/rt2800lib.c).
error: could not build fake ancestor
Applying: rt2800: initial watchdog implementation
Patch failed at 0001 rt2800: initial watchdog implementation
The copy of the patch that failed is found in: .git/rebase-apply/patch

7 patches set to Changes Requested.

10926395 [1/7] rt2x00: allow to specify watchdog interval
10926397 [2/7] rt2800: add helpers for reading dma done index
10926401 [3/7] rt2800: initial watchdog implementation
10926403 [4/7] rt2800: add pre_reset_hw callback
10926405 [5/7] rt2800: do not nullify initialization vector data
10926407 [6/7] rt2x00: add restart hw
10926409 [7/7] rt2800: do not enable watchdog by default

-- 
https://patchwork.kernel.org/patch/10926395/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

