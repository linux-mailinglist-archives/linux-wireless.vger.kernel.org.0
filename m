Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D147631302B
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Feb 2021 12:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbhBHLJI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 Feb 2021 06:09:08 -0500
Received: from so15.mailgun.net ([198.61.254.15]:57264 "EHLO so15.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233042AbhBHLEF (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 Feb 2021 06:04:05 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1612782231; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=iIN13FOdpOZzV9CWg91CsLyHiyCdurn89J8zh6JZi7Y=;
 b=nHOd+T39A7MBQrZDgFerwXEm1hCx7DjKaoe/6AmFXCFa7lqEYr+YteBGn+ZBVcZh+cxE5drN
 5a461+KusO+uWmQNWdcPMwB80EG6nyaSgOI1ZgTBbDklS5c7aZY4SwrECcHRw/FeWbDwpMvh
 sxG/Ju5vBKlreFnO6ex/V+mo6Go=
X-Mailgun-Sending-Ip: 198.61.254.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 60211a72d5a7a3baaed6ca8f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 08 Feb 2021 11:03:14
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0CB9FC43462; Mon,  8 Feb 2021 11:03:14 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3147BC433CA;
        Mon,  8 Feb 2021 11:03:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3147BC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] brcmfmac: Add DMI nvram filename quirk for Predia
 Basic
 tablet
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210129171413.139880-1-hdegoede@redhat.com>
References: <20210129171413.139880-1-hdegoede@redhat.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210208110314.0CB9FC43462@smtp.codeaurora.org>
Date:   Mon,  8 Feb 2021 11:03:14 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hans de Goede <hdegoede@redhat.com> wrote:

> The Predia Basic tablet contains quite generic names in the sys_vendor and
> product_name DMI strings, without this patch brcmfmac will try to load:
> brcmfmac43340-sdio.Insyde-CherryTrail.txt as nvram file which is a bit
> too generic.
> 
> Add a DMI quirk so that a unique and clearly identifiable nvram file name
> is used on the Predia Basic tablet.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

2 patches applied to wireless-drivers-next.git, thanks.

af4b3a6f36d6 brcmfmac: Add DMI nvram filename quirk for Predia Basic tablet
a338c874d3d9 brcmfmac: Add DMI nvram filename quirk for Voyo winpad A15 tablet

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210129171413.139880-1-hdegoede@redhat.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

