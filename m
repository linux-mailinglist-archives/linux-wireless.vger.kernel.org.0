Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E76D32F67CB
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Jan 2021 18:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbhANRd1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Jan 2021 12:33:27 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:59203 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbhANRd0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Jan 2021 12:33:26 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1610645588; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=FAGSlbucHTH8usyBEzsj+DlWJxytthLwyRvGEX/T7YY=;
 b=q9U+Jx1NXGuEn2ckQFyjXWFoVbSt/r8YckEhOXvmlZI+NPhp7kXy7fYvOf2cJX1GmIwpgxF+
 Qe1NYoYWjtNBmlixKlA4H7zM3REHV4MNKp1UGB2WDziHPlp0bx0G2tyl1K/NKSoJ+Lm703VS
 PbMMW4GrD3LT1kKIwm3jZ6RXD60=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 60008046c88af06107fa9754 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 14 Jan 2021 17:32:54
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EE9EAC433CA; Thu, 14 Jan 2021 17:32:53 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 42CBCC433C6;
        Thu, 14 Jan 2021 17:32:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 42CBCC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] brcmfmac: clear EAP/association status bits on linkdown
 events
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1608807119-21785-1-git-send-email-luca.pesce@vimar.com>
References: <1608807119-21785-1-git-send-email-luca.pesce@vimar.com>
To:     Luca Pesce <luca.pesce@vimar.com>
Cc:     linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        Luca Pesce <luca.pesce@vimar.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210114173253.EE9EAC433CA@smtp.codeaurora.org>
Date:   Thu, 14 Jan 2021 17:32:53 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Pesce <luca.pesce@vimar.com> wrote:

> This ensure that previous association attempts do not leave stale statuses
> on subsequent attempts.
> 
> This fixes the WARN_ON(!cr->bss)) from __cfg80211_connect_result() when
> connecting to an AP after a previous connection failure (e.g. where EAP fails
> due to incorrect psk but association succeeded). In some scenarios, indeed,
> brcmf_is_linkup() was reporting a link up event too early due to stale
> BRCMF_VIF_STATUS_ASSOC_SUCCESS bit, thus reporting to cfg80211 a connection
> result with a zeroed bssid (vif->profile.bssid is still empty), causing the
> WARN_ON due to the call to cfg80211_get_bss() with the empty bssid.
> 
> Signed-off-by: Luca Pesce <luca.pesce@vimar.com>

Patch applied to wireless-drivers-next.git, thanks.

e862a3e40880 brcmfmac: clear EAP/association status bits on linkdown events

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1608807119-21785-1-git-send-email-luca.pesce@vimar.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

