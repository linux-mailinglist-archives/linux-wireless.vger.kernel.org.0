Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2C8615A0D9
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2020 06:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbgBLFtu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Feb 2020 00:49:50 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:47961 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727893AbgBLFtu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Feb 2020 00:49:50 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1581486590; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=4nXRF41DUnBVNFoYDb54+pPJeN0bz4OPCsG/eKuBNxs=; b=w9DQ5f7Gg/0bnw0KInRsvT/rU/YkIJzblNh1e4cfDq3ZT7W1XeXnkHOQRKZyhg6CZq29spiA
 9wErDdXE9IQoOoVb7bJmOgx4QeNcYxIZ86spNNoVW/LlIVuNoqSH7TCgSn+0ro/XKD3xGTTr
 iJbBlD6djUDbgEnOcw0jkA4ij3o=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e4391fd.7f8ef9be0ae8-smtp-out-n03;
 Wed, 12 Feb 2020 05:49:49 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 59F93C4479F; Wed, 12 Feb 2020 05:49:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 01C66C43383;
        Wed, 12 Feb 2020 05:49:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 01C66C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        intel-wired-lan@lists.osuosl.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 20/28] drivers: net: Call cpu_latency_qos_*() instead of pm_qos_*()
References: <1654227.8mz0SueHsU@kreacher> <10624145.o336LLEsho@kreacher>
Date:   Wed, 12 Feb 2020 07:49:43 +0200
In-Reply-To: <10624145.o336LLEsho@kreacher> (Rafael J. Wysocki's message of
        "Wed, 12 Feb 2020 00:24:36 +0100")
Message-ID: <87v9ocwe14.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

"Rafael J. Wysocki" <rjw@rjwysocki.net> writes:

> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>
> Call cpu_latency_qos_add/update/remove_request() instead of
> pm_qos_add/update/remove_request(), respectively, because the
> latter are going to be dropped.
>
> No intentional functional impact.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c   | 13 ++++++-------
>  drivers/net/wireless/ath/ath10k/core.c       |  4 ++--
>  drivers/net/wireless/intel/ipw2x00/ipw2100.c | 10 +++++-----
>  3 files changed, 13 insertions(+), 14 deletions(-)

For the wireless stuff:

Acked-by: Kalle Valo <kvalo@codeaurora.org>

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
