Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F27C2CC61C
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Dec 2020 20:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgLBTCw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Dec 2020 14:02:52 -0500
Received: from m42-5.mailgun.net ([69.72.42.5]:19458 "EHLO m42-5.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726082AbgLBTCw (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Dec 2020 14:02:52 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1606935748; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=p1j+NgFfG1/co7fB3TIlYekVg6QID5HWLBfQFS5JqFc=;
 b=Z2TAQMo0012dPZEy0QQ3f7ZMLLJ7RjNTiYFkpiVVvASxzF2K1sRkRJQazncmgwQFGD5tL3BK
 gkDKT9qcOWDTv5rSmers9MWZ+JUI6JmLnRX1ASkXO+ppjpT2hbxwAMK66wYK4gjb3zoWNZeX
 FykrcTh+QS0GXJI36GIUSlmKxyU=
X-Mailgun-Sending-Ip: 69.72.42.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5fc7e4a90b1f6587dd587425 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 02 Dec 2020 19:02:01
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C44AAC433C6; Wed,  2 Dec 2020 19:02:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B579FC43460;
        Wed,  2 Dec 2020 19:02:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B579FC43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/3] iwlwifi: pcie: add one missing entry for AX210
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <iwlwifi.20201202143859.308eab4db42c.I3763196cd3f7bb36f3dcabf02ec4e7c4fe859c0f@changeid>
References: <iwlwifi.20201202143859.308eab4db42c.I3763196cd3f7bb36f3dcabf02ec4e7c4fe859c0f@changeid>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201202190201.C44AAC433C6@smtp.codeaurora.org>
Date:   Wed,  2 Dec 2020 19:02:01 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> From: Luca Coelho <luciano.coelho@intel.com>
> 
> The 0x0024 subsytem device ID was missing from the list, so some AX210
> devices were not recognized.  Add it.
> 
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

3 patches applied to wireless-drivers.git, thanks.

5febcdef3090 iwlwifi: pcie: add one missing entry for AX210
568d3434178b iwlwifi: pcie: invert values of NO_160 device config entries
a0426b6caf18 iwlwifi: pcie: add some missing entries for AX210

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/iwlwifi.20201202143859.308eab4db42c.I3763196cd3f7bb36f3dcabf02ec4e7c4fe859c0f@changeid/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

