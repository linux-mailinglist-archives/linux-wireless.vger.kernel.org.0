Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 036BEB76B9
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Sep 2019 11:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389003AbfISJwY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Sep 2019 05:52:24 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41938 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388872AbfISJwX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Sep 2019 05:52:23 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D046F60A43; Thu, 19 Sep 2019 09:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568886742;
        bh=DHbMt4VlMlCYGCcu0AHQMJtx9UThr1oG/eCCGfDnC7A=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Vz1AKjDmFrmZ1gQRxoavgYuMV9UH5A0MtY8qwwsgchKXrROz0n+XsS95d2qViT6q+
         ZORt495TxOh0SnH+pqO6diQYoLqRR56tvHYpGTBh6DQTQz8nlP7LvFwwcSFrMi3k4b
         Tk9i6j3HHbvjZ6lnwwIL/lpMmwM6A5gL94bokHUE=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 29F2160790;
        Thu, 19 Sep 2019 09:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568886740;
        bh=DHbMt4VlMlCYGCcu0AHQMJtx9UThr1oG/eCCGfDnC7A=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=kqNo/nz2TzAxUtfxiKXh+85jBGFvbRxmgbaFmpakr0ATkD2nxDhoNjMeyb6fIT7ax
         VWrMZlkfxYqKLtSvODrh5k9NaSINrcUa2s+aHkqu9p7YSTRVgt4N49P7xcaoMkIbyp
         4z7Rj+tANKSizcAibX+wTbd2Q7N9J50ZZsfn1T5A=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 29F2160790
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org, Mao Wenan <maowenan@huawei.com>
Subject: Re: [PATCH v5.4] iwlwifi: mvm: fix build w/o CONFIG_THERMAL
References: <20190918134903.10103-1-luca@coelho.fi>
        <7b7a8949caae37c0b0dcbc18823dbaf360d482ec.camel@coelho.fi>
Date:   Thu, 19 Sep 2019 12:52:17 +0300
In-Reply-To: <7b7a8949caae37c0b0dcbc18823dbaf360d482ec.camel@coelho.fi> (Luca
        Coelho's message of "Wed, 18 Sep 2019 16:50:35 +0300")
Message-ID: <87woe4k3zi.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> writes:

> On Wed, 2019-09-18 at 16:49 +0300, Luca Coelho wrote:
>> From: Johannes Berg <johannes.berg@intel.com>
>> 
>> Without CONFIG_THERMAL, the driver fails to link as it calls
>> iwl_mvm_send_temp_report_ths_cmd() unconditionally. Fix this
>> by making that function available, but do almost nothing but
>> send the empty firmware command to enable CT-kill reporting.
>> 
>> While at it, also fix that function itself to not error out
>> when the thermal zone hasn't been initialized, but instead
>> just send the empty firmware command in this case as well.
>> 
>> Fixes: 242d9c8b9a93 ("iwlwifi: mvm: use FW thermal monitoring regardless of CONFIG_THERMAL")
>> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
>> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
>> ---
>
> Kalle, please take this patch to fix the THERMAL thing instead.  I'll
> assign it to you in patchwork (and mark the other one as superseded).

Ok, I'll queue this to v5.4.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
