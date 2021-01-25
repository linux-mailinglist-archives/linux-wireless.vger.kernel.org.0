Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD4F3047E4
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Jan 2021 20:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388929AbhAZFy0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Jan 2021 00:54:26 -0500
Received: from a1.mail.mailgun.net ([198.61.254.60]:63684 "EHLO
        a1.mail.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729261AbhAYOQE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Jan 2021 09:16:04 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1611584111; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=Fusvwvh4vJulzcV0KcOn09ikDpggnn9YKgAWIvRTEsY=;
 b=EQG7aAbvORoO2e8c61kg7HA4WsKvO+BgVhv9cm2xyDDMAZ/dZu052tQU1eAUYewanMIIXv0Q
 Ie+amajwSdMU4feiC+V0IeSkD2e2QOfm/a9W8RjRFIbAHalc996muYzvuShsCx1nwBR0GIjN
 xt8N7uvMW42gPM/+P2nD8d2A1jc=
X-Mailgun-Sending-Ip: 198.61.254.60
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 600eceffbdcf4682875ceaa5 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 25 Jan 2021 14:00:31
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D03F5C43461; Mon, 25 Jan 2021 14:00:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D48B5C433C6;
        Mon, 25 Jan 2021 14:00:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D48B5C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH for v5.11 1/7] iwlwifi: mvm: fix the return type for DSM
 functions 1 and 2
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <iwlwifi.20210122144849.5757092adcd6.Ic24524627b899c9a01af38107a62a626bdf5ae3a@changeid>
References: <iwlwifi.20210122144849.5757092adcd6.Ic24524627b899c9a01af38107a62a626bdf5ae3a@changeid>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210125140030.D03F5C43461@smtp.codeaurora.org>
Date:   Mon, 25 Jan 2021 14:00:30 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> From: Matt Chen <matt.chen@intel.com>
> 
> The return type value of functions 1 and 2 were considered to be an
> integer inside a buffer, but they can also be only an integer, without
> the buffer.  Fix the code in iwl_acpi_get_dsm_u8() to handle it as a
> single integer value, as well as packed inside a buffer.
> 
> Signed-off-by: Matt Chen <matt.chen@intel.com>
> Fixes: 9db93491f29e ("iwlwifi: acpi: support device specific method (DSM)")
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

7 patches applied to wireless-drivers.git, thanks.

aefbe5c445c7 iwlwifi: mvm: fix the return type for DSM functions 1 and 2
e223e42aac30 iwlwifi: mvm: invalidate IDs of internal stations at mvm start
16062c12edb8 iwlwifi: pcie: add rules to match Qu with Hr2
96d2bfb7948a iwlwifi: mvm: clear IN_D3 after wowlan status cmd
4886460c4d15 iwlwifi: Fix IWL_SUBDEVICE_NO_160 macro to use the correct bit.
7a21b1d4a728 iwlwifi: mvm: guard against device removal in reprobe
0bed6a2a14af iwlwifi: queue: bail out on invalid freeing

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/iwlwifi.20210122144849.5757092adcd6.Ic24524627b899c9a01af38107a62a626bdf5ae3a@changeid/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

