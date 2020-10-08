Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70F33287AC1
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Oct 2020 19:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731799AbgJHRPo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Oct 2020 13:15:44 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:20485 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730261AbgJHRPn (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Oct 2020 13:15:43 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1602177343; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=1C1nDIaoqlTGWP/sHZwVwpzazhjQWBQF+ikt3pKnBms=;
 b=HJGM0kVmYzErYMlDy3g6Vpss+1TifeQqMOtv/yGQOoQl4WaltDylvP5aMKtYuRzX9wrwgAa2
 vyFC0fciD9QyejceB8DTopijDw0iI7Bx0C4EcTdhb4vMoByj9r8I70sy7M6KlDtVYyUFzvKQ
 rnv730z4ga0oxLP6bMBPiZbhO7M=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 5f7f493e319d4e9cb5cb4a04 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 08 Oct 2020 17:15:42
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 92371C433CA; Thu,  8 Oct 2020 17:15:42 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 79F52C433F1;
        Thu,  8 Oct 2020 17:15:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 79F52C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 01/13] iwlwifi: pcie: fix xtal latency for 9560 devices
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <iwlwifi.20201008181047.34392f98fdb1.I3d3db14f6d1a8ecc547ca6afce8488816bd26081@changeid>
References: <iwlwifi.20201008181047.34392f98fdb1.I3d3db14f6d1a8ecc547ca6afce8488816bd26081@changeid>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201008171542.92371C433CA@smtp.codeaurora.org>
Date:   Thu,  8 Oct 2020 17:15:42 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> From: Luca Coelho <luciano.coelho@intel.com>
> 
> We were using a very high latency for all 9560 devices so they all
> would have time to stabilize.  But this causes the system to be
> slighly slower, so we can use the best values for each device.
> 
> This requires a new trans cfg struct for devices with longer latency
> and some adjustments to the other structs.
> 
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

13 patches applied to wireless-drivers-next.git, thanks.

24436191a3b4 iwlwifi: pcie: fix xtal latency for 9560 devices
8fac81b50059 iwlwifi: pcie: fix the xtal latency value for a few qu devices
58ddd9b6d194 iwlwifi: mvm: don't send a CSA command the firmware doesn't know
60cbad2b867f iwlwifi: mvm: remove memset of kek_kck command
efa40c7ef689 iwlwifi: mvm: fix suspicious rcu usage warnings
853f4954baf4 iwlwifi: stats: add new api fields for statistics cmd/ntfy
45acebf8d6a6 iwlwifi: fix sar geo table initialization
0fafaa97ef35 iwlwifi: rs: align to new TLC config command API
b3e4c0f34c17 iwlwifi: move PNVM implementation to common code
a182dfab2842 iwlwifi: add trans op to set PNVM
6654cd4eb90f iwlwifi: pcie: implement set_pnvm op
6972592850c0 iwlwifi: read and parse PNVM file
09b3ab8782e7 iwlwifi: bump FW API to 59 for AX devices

-- 
https://patchwork.kernel.org/patch/11823191/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

