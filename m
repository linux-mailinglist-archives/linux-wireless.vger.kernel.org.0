Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC3CB1B264E
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2020 14:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728852AbgDUMk0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Apr 2020 08:40:26 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:52963 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728804AbgDUMkP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Apr 2020 08:40:15 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587472814; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=2BBuZ2saqY8bkiyhwsNszE8S5S8FMvxU4rRpU9yJBm8=;
 b=pua1NDB7qnFKs+hRqc4oa82FjePssiZ20q5Dx+bIiCAtaU8cvJy/PdHiJ5BTeAiXPAplq5YE
 20LhSI9J4Y5rCWb/Lkc1Y7jBDbcw7VJCHwto+8lHuWmYjnUt+toBp4VLFSKGS3SsrBa8zy98
 lkmyO1dWiid3MIZ2crCoc3Z1knc=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e9ee9a3.7f540258fb90-smtp-out-n04;
 Tue, 21 Apr 2020 12:40:03 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 81361C43636; Tue, 21 Apr 2020 12:40:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6BB85C433D2;
        Tue, 21 Apr 2020 12:40:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6BB85C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 v5.7 1/6] iwlwifi: pcie: actually release queue memory in
 TVQM
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <iwlwifi.20200417100405.f5f4c4193ec1.Id5feebc9b4318041913a9c89fc1378bb5454292c@changeid>
References: <iwlwifi.20200417100405.f5f4c4193ec1.Id5feebc9b4318041913a9c89fc1378bb5454292c@changeid>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200421124002.81361C43636@smtp.codeaurora.org>
Date:   Tue, 21 Apr 2020 12:40:02 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> From: Johannes Berg <johannes.berg@intel.com>
> 
> The iwl_trans_pcie_dyn_txq_free() function only releases the frames
> that may be left on the queue by calling iwl_pcie_gen2_txq_unmap(),
> but doesn't actually free the DMA ring or byte-count tables for the
> queue. This leads to pretty large memory leaks (at least before my
> queue size improvements), in particular in monitor/sniffer mode on
> channel hopping since this happens on every channel change.
> 
> This was also now more evident after the move to a DMA pool for the
> byte count tables, showing messages such as
> 
>   BUG iwlwifi:bc (...): Objects remaining in iwlwifi:bc on __kmem_cache_shutdown()
> 
> This fixes https://bugzilla.kernel.org/show_bug.cgi?id=206811.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Fixes: 6b35ff91572f ("iwlwifi: pcie: introduce a000 TX queues management")
> Cc: stable@vger.kernel.org # v4.14+
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

6 patches applied to wireless-drivers.git, thanks.

b98b33d5560a iwlwifi: pcie: actually release queue memory in TVQM
290d5e495183 iwlwifi: mvm: beacon statistics shouldn't go backwards
d8d663970234 iwlwifi: pcie: indicate correct RB size to device
e5b72e3bc476 iwlwifi: mvm: limit maximum queue appropriately
38af8d5a90a8 iwlwifi: mvm: Do not declare support for ACK Enabled Aggregation
e6d419f94331 iwlwifi: mvm: fix inactive TID removal return value usage

-- 
https://patchwork.kernel.org/patch/11494275/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
