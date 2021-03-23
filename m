Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C278B345B04
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Mar 2021 10:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbhCWJiO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Mar 2021 05:38:14 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:31016 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbhCWJiE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Mar 2021 05:38:04 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1616492284; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=G+g1Iw4J55JufuntnDdtspIrkfkp6gY0+lxAdFuX1V4=;
 b=gjZukHewjojczFqLNllbDkS/6NodBDnOr56NC9j4Ll0awyMRUcWyQrWWGndVF9ppUxEzfiNj
 1HjMQMZIzbTa3jO9TPYHVegJwFylInZxhV7tPgKdSSlZQqzy75GdzyeB8yTqkGyJjcP5Va3m
 vTp6pVNikSG6IGvsEMIxWta1uXw=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 6059b6f15d70193f88e07ae0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 23 Mar 2021 09:37:53
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 34DE5C433CA; Tue, 23 Mar 2021 09:37:53 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DB7F2C433C6;
        Tue, 23 Mar 2021 09:37:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DB7F2C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 5.12 regression fix] brcmfmac: p2p: Fix recently
 introduced
 deadlock issue
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210313143635.109154-1-hdegoede@redhat.com>
References: <20210313143635.109154-1-hdegoede@redhat.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com,
        Johannes Berg <johannes.berg@intel.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210323093753.34DE5C433CA@smtp.codeaurora.org>
Date:   Tue, 23 Mar 2021 09:37:53 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hans de Goede <hdegoede@redhat.com> wrote:

> Commit a05829a7222e ("cfg80211: avoid holding the RTNL when calling the
> driver") replaced the rtnl_lock parameter passed to various brcmf
> functions with just lock, because since that commit it is not just
> about the rtnl_lock but also about the wiphy_lock .
> 
> During this search/replace the "if (!rtnl_locked)" check in brcmfmac/p2p.c
> was accidentally replaced with "if (locked)", dropping the inversion of
> the check. This causes the code to now call rtnl_lock() while already
> holding the lock, causing a deadlock.
> 
> Add back the "!" to the if-condition to fix this.
> 
> Cc: Johannes Berg <johannes.berg@intel.com>
> Fixes: a05829a7222e ("cfg80211: avoid holding the RTNL when calling the driver")
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Patch applied to wireless-drivers.git, thanks.

bd83a2fc05ed brcmfmac: p2p: Fix recently introduced deadlock issue

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210313143635.109154-1-hdegoede@redhat.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

