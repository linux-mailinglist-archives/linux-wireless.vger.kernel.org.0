Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29C9D18FA0D
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2020 17:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbgCWQjR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Mar 2020 12:39:17 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:23224 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727234AbgCWQjR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Mar 2020 12:39:17 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584981556; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=vOzmT9ZTimnxOkb03T4PZ9gFFOcanFSDfBXAwTjZOEI=;
 b=JqoWjm07ZcV1aAE/NVucBYCywMP1C4ySS/DXB4i0BjRiuG/4N8aMMvL8J19FaX+7yKC+ETX7
 waSn6GsaBO2Y07Flfo4z81aoRDhkJ5iIDGJcGuAFdOaUDTO7afngQqcPQZekcU90eJcddKCW
 5uHCMmnixDKJbSav7CNmW6rKpNA=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e78e622.7fec77cdb5a8-smtp-out-n01;
 Mon, 23 Mar 2020 16:38:58 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A1183C44788; Mon, 23 Mar 2020 16:38:58 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 06C39C433BA;
        Mon, 23 Mar 2020 16:38:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 06C39C433BA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5.6] iwlwifi: don't send GEO_TX_POWER_LIMIT if no wgds
 table
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <iwlwifi.20200318081237.46db40617cc6.Id5cf852ec8c5dbf20ba86bad7b165a0c828f8b2e@changeid>
References: <iwlwifi.20200318081237.46db40617cc6.Id5cf852ec8c5dbf20ba86bad7b165a0c828f8b2e@changeid>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org, lenb@kernel.org, noodles@earth.li
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200323163858.A1183C44788@smtp.codeaurora.org>
Date:   Mon, 23 Mar 2020 16:38:58 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> From: Golan Ben Ami <golan.ben.ami@intel.com>
> 
> The GEO_TX_POWER_LIMIT command was sent although
> there is no wgds table, so the fw got wrong SAR values
> from the driver.
> 
> Fix this by avoiding sending the command if no wgds
> tables are available.
> 
> Signed-off-by: Golan Ben Ami <golan.ben.ami@intel.com>
> Fixes: 39c1a9728f93 ("iwlwifi: refactor the SAR tables from mvm to acpi")
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> Tested-By: Jonathan McDowell <noodles@earth.li>
> Tested-by: Len Brown <len.brown@intel.com>

Patch applied to wireless-drivers.git, thanks.

0433ae556ec8 iwlwifi: don't send GEO_TX_POWER_LIMIT if no wgds table

-- 
https://patchwork.kernel.org/patch/11444587/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
