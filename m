Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34010319B4
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Jun 2019 07:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbfFAFF7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 1 Jun 2019 01:05:59 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50010 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfFAFF7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 1 Jun 2019 01:05:59 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E29BE60A44; Sat,  1 Jun 2019 05:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559365558;
        bh=IG1VoVeAEc+FjfyZl2nzFT7c62aaTzvk8id5FNKmK3E=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=I48utYMh3I52CFzMvuebLTQ0qtEnRffc1X39Q1a6NsQeqGkDWZv5xgeO9JB9B8hoq
         hyTjOXVgsKg1hWbNjCE5laqhaCN2q32iJddoIioi5dN52Kz+2Akaf5QLg4MXxDzsXt
         lEx/PsUdvVmOVkX07lv53IFo/M5o8Szdh/VJlX5o=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0EC66609F3;
        Sat,  1 Jun 2019 05:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559365558;
        bh=IG1VoVeAEc+FjfyZl2nzFT7c62aaTzvk8id5FNKmK3E=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=F4AWT/CsOPYBP7zOnOvwXpYHSl40WDyj0CkyiCspVcT/3AElRx5tqxLhO5HjhVV4w
         //f0rUQD6BbrJ0X9uUXKPuLfdlXd9YoJtoDqgowxkGCMs4KJ5pYJoeD3mn2E+PHa7o
         qwRt0Y0JByWhthwbWULiObRuo8DtXCZiuRuZ3COs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0EC66609F3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/7] iwlwifi: mvm: remove d3_sram debugfs file
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20190529133955.31082-2-luca@coelho.fi>
References: <20190529133955.31082-2-luca@coelho.fi>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190601050558.E29BE60A44@smtp.codeaurora.org>
Date:   Sat,  1 Jun 2019 05:05:58 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> From: Johannes Berg <johannes.berg@intel.com>
> 
> This debugfs file is really old, and cannot work properly since
> the unified image support. Rather than trying to make it work,
> which is difficult now due to multiple images (LMAC/UMAC etc.)
> just remove it - we no longer need it since we properly do a FW
> coredump even in D3 cases.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

7 patches applied to wireless-drivers.git, thanks.

23f57bfac7c2 iwlwifi: mvm: remove d3_sram debugfs file
b3500b472c88 iwlwifi: fix load in rfkill flow for unified firmware
44f61b5c832c iwlwifi: clear persistence bit according to device family
cc5470df4495 iwlwifi: print fseq info upon fw assert
b17dc0632a17 iwlwifi: fix AX201 killer sku loading firmware issue
a8627176b0de iwlwifi: Fix double-free problems in iwl_req_fw_callback()
5f4d55d5791a iwlwifi: mvm: change TLC config cmd sent by rs to be async

-- 
https://patchwork.kernel.org/patch/10967147/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

