Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9CE713AC06
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2020 15:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbgANOOc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Jan 2020 09:14:32 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:30379 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726038AbgANOOc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Jan 2020 09:14:32 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1579011272; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=BDH3q+NZfIdWAqfkJqvZG8gE2B/GRikU/kAh89acbrU=; b=vKLaBL2mqDQpxgTi1NMfYkYhhaDfzdjIgPVjwPsGeqAZIxfFk/kQGWmHs1NpIclF2zLW4CCD
 lJvOL4Ck8KQw4VDnkYG1ZhphAQ7yrqEz3ZKNZkfPp8Shde6MbdRt9yE8ndToa5SL1oRHbH4o
 AuksxUahVqJotHYcchsVNQni7wM=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e1dccc6.7f62d236cab0-smtp-out-n02;
 Tue, 14 Jan 2020 14:14:30 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C9D75C433A2; Tue, 14 Jan 2020 14:14:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D4D6CC433CB;
        Tue, 14 Jan 2020 14:14:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D4D6CC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com,
        linux-wireless@vger.kernel.org, Sean.Wang@mediatek.com
Subject: Re: [PATCH v2 01/18] mt76: mt76u: check tx_status_data pointer in mt76u_tx_tasklet
References: <cover.1578226544.git.lorenzo@kernel.org>
        <abcddd40dcf003980e1d095d6cbd40b22ac98a43.1578226544.git.lorenzo@kernel.org>
Date:   Tue, 14 Jan 2020 16:14:27 +0200
In-Reply-To: <abcddd40dcf003980e1d095d6cbd40b22ac98a43.1578226544.git.lorenzo@kernel.org>
        (Lorenzo Bianconi's message of "Sun, 5 Jan 2020 13:21:39 +0100")
Message-ID: <87muaq15x8.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> writes:

> New devices (e.g. mt7663u) do not rely on stats workqueue to load tx
> statistics but will be reported by the firmware. Check tx_status_data
> pointer in mt76u_tx_tasklet in order to reuse tx tasklet for new devices
>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Why is Sean's s-o-b first? Lorenzo is marked as the author so his s-o-b
should be first.

Also I recommend taking a look at the new Co-Developed-by tag.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
