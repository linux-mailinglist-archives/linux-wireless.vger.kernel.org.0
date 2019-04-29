Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7847BE4BC
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2019 16:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbfD2O05 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Apr 2019 10:26:57 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46904 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728276AbfD2O04 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Apr 2019 10:26:56 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 81B08608D4; Mon, 29 Apr 2019 14:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556548016;
        bh=IV0ZG6ry64zXhiRgrGKXvLnELJTpAeh9g3O3T8TohQw=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=m6bVYXu6hdBpom4N8mp3+cdHioWWWIqFuuWXoycN+K7ZN4BR91NbFENodyX6XqPjR
         hnMfcW4rjMt7/1aEkoAGbhL6telhZzrnuVlXtST1JkY5i/W3j6nbMHNad/NauOYHBw
         O1K1viBbWet0mB+fFRHQO3Y/5MqutWc84pJ0/f/Q=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,MISSING_DATE,MISSING_MID autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EE3DD607DF;
        Mon, 29 Apr 2019 14:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556548014;
        bh=IV0ZG6ry64zXhiRgrGKXvLnELJTpAeh9g3O3T8TohQw=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=niUyj4ztBOldr2anyLvHJxl/K8lZPA503ruQC6k8aQ0gJeJRmqwuBVGdsAjOs6fSB
         IKJ0Lf/JDBEJvf8LDRCiR4aWS/otNSaty53YiCnj3KyWGDmAzkqxqkneiEXDhxcUt4
         9H3gzKHCwPG0awntrOGZUFAeuGE0+434DxJwBOHs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EE3DD607DF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: Drop WARN_ON()s that always trigger during system
 resume
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <2884043.Jv1Mn93hE8@aspire.rjw.lan>
References: <2884043.Jv1Mn93hE8@aspire.rjw.lan>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        ath10k@lists.infradead.org, Todd Brandt <todd.e.brandt@intel.com>,
        linux-wireless@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190429142655.81B08608D4@smtp.codeaurora.org>
Date:   Mon, 29 Apr 2019 14:26:55 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

"Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:

> ath10k_mac_vif_chan() always returns an error for the given vif
> during system-wide resume which reliably triggers two WARN_ON()s
> in ath10k_bss_info_changed() and they are not particularly
> useful in that code path, so drop them.
> 
> Tested: QCA6174 hw3.2 PCI with WLAN.RM.2.0-00180-QCARMSWPZ-1
> Tested: QCA6174 hw3.2 SDIO with WLAN.RMH.4.4.1-00007-QCARMSWP-1
> 
> Fixes: cd93b83ad927 ("ath10k: support for multicast rate control")
> Fixes: f279294e9ee2 ("ath10k: add support for configuring management packet rate")
> Cc: stable@vger.kernel.org
> Reviewed-by: Brian Norris <briannorris@chromium.org>
> Tested-by: Brian Norris <briannorris@chromium.org>
> Tested-by: Claire Chang <tientzu@chromium.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-current branch of ath.git, thanks.

9e80ad37f678 ath10k: Drop WARN_ON()s that always trigger during system resume

-- 
https://patchwork.kernel.org/patch/10837139/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

