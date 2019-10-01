Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9C72C2FDB
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2019 11:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729998AbfJAJRU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Oct 2019 05:17:20 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38420 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727957AbfJAJRT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Oct 2019 05:17:19 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A2890608CE; Tue,  1 Oct 2019 09:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569921438;
        bh=VgnLI7BFsqBudMVP0S40TwP5BbrjxaKPOJHaep+FrMY=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Iifk4lOm2ITfHmvh0SWG2wM6CIJ6scNn36qsYsu3pzsI8O57HQAukihETDGMFhdUR
         Js1n5jHDmag19n/0ostc7sfc4hs3ciQEw7gTL09NFR5ivFriKw55vRI2d1G30OQ6qu
         dkmQoocNKs/KZuCpGkqRYu+5aw8fkJ6TS5GRrujo=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5332660265;
        Tue,  1 Oct 2019 09:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569921438;
        bh=VgnLI7BFsqBudMVP0S40TwP5BbrjxaKPOJHaep+FrMY=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=lTIS9XSkt5nF4ul6PIfvfvFo2vs4hm0DrtzQDoiRVWlSoa4Z6bm9Erme4VvCIKgWn
         EtRP0u/h92R2b2d0L0yYgQWFt88iBZQv3Zfc7KdUDr1IKzlRSBrYNGadMAZ9E9Z24M
         PAGthp6yY/DRxXUvtceLciBWgTyNgFIv0BexXHeg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5332660265
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 01/15] rtw88: remove redundant flag check helper function
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1568617425-28062-2-git-send-email-yhchuang@realtek.com>
References: <1568617425-28062-2-git-send-email-yhchuang@realtek.com>
To:     <yhchuang@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20191001091718.A2890608CE@smtp.codeaurora.org>
Date:   Tue,  1 Oct 2019 09:17:18 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<yhchuang@realtek.com> wrote:

> From: Yan-Hsuan Chuang <yhchuang@realtek.com>
> 
> These helper functions seems useless. And in some cases
> we want to use test_and_[set/clear]_bit, these helpers
> will make the code more complicated. So remove them.
> 
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>

Does not apply anymore, please rebase.

Recorded preimage for 'drivers/net/wireless/realtek/rtw88/mac.c'
error: Failed to merge in the changes.
Applying: rtw88: remove redundant flag check helper function
Using index info to reconstruct a base tree...
M	drivers/net/wireless/realtek/rtw88/mac.c
M	drivers/net/wireless/realtek/rtw88/main.c
Falling back to patching base and 3-way merge...
Auto-merging drivers/net/wireless/realtek/rtw88/main.c
Auto-merging drivers/net/wireless/realtek/rtw88/mac.c
CONFLICT (content): Merge conflict in drivers/net/wireless/realtek/rtw88/mac.c
Patch failed at 0001 rtw88: remove redundant flag check helper function
The copy of the patch that failed is found in: .git/rebase-apply/patch

12 patches set to Changes Requested.

11146413 [01/15] rtw88: remove redundant flag check helper function
11146419 [03/15] rtw88: pci: reset H2C queue indexes in a single write
11146421 [06/15] rtw88: not to enter or leave PS under IRQ
11146441 [07/15] rtw88: not to control LPS by each vif
11146423 [08/15] rtw88: remove unused lps state check helper
11146437 [09/15] rtw88: LPS enter/leave should be protected by lock
11146425 [10/15] rtw88: leave PS state for dynamic mechanism
11146429 [11/15] rtw88: add deep power save support
11146435 [12/15] rtw88: not to enter LPS by coex strategy
11146427 [13/15] rtw88: select deep PS mode when module is inserted
11146433 [14/15] rtw88: add deep PS PG mode for 8822c
11146431 [15/15] rtw88: remove misleading module parameter rtw_fw_support_lps

-- 
https://patchwork.kernel.org/patch/11146413/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

