Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 794EB421DF9
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Oct 2021 07:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbhJEFdq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Oct 2021 01:33:46 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:15347 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230403AbhJEFdq (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Oct 2021 01:33:46 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633411916; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=c8LOerBQhA9YB/N4BZ5roeefjYwZzJONtp99S/VuNCE=;
 b=bQFVcR8ZF+TRINU5/+AUK1IBy+HBKChGoHG3A15r6cvsC0TJmihopQbqh44wcSwfrWwDekW7
 KHCzDahm91nnEpNdx0rzB9DXNCxR5UtyAOZH8XFBblpBMYC77VOTuLW+sW23Bmx0nY1bL2ak
 Xg7+PCl3JQKKaaip16Di0l2i4ZY=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 615be34887540061e6f8c344 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 05 Oct 2021 05:31:52
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 352A5C4360D; Tue,  5 Oct 2021 05:31:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL autolearn=no autolearn_force=no
        version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5942BC4338F;
        Tue,  5 Oct 2021 05:31:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 5942BC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] brcmfmac: Add DMI nvram filename quirk for Cyberbook T116
 tablet
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210928160633.96928-1-hdegoede@redhat.com>
References: <20210928160633.96928-1-hdegoede@redhat.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20211005053152.352A5C4360D@smtp.codeaurora.org>
Date:   Tue,  5 Oct 2021 05:31:52 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hans de Goede <hdegoede@redhat.com> wrote:

> The Cyberbook T116 tablet contains quite generic names in the sys_vendor
> and product_name DMI strings, without this patch brcmfmac will try to load:
> "brcmfmac43455-sdio.Default string-Default string.txt" as nvram file which
> is way too generic.
> 
> The nvram file shipped on the factory Android image contains the exact
> same settings as those used on the AcePC T8 mini PC, so point the new
> DMI nvram filename quirk to the acepc-t8 nvram file.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Patch applied to wireless-drivers-next.git, thanks.

49c3eb3036e6 brcmfmac: Add DMI nvram filename quirk for Cyberbook T116 tablet

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210928160633.96928-1-hdegoede@redhat.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

