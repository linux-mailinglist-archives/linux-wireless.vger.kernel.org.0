Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6CFB3A7C1A
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jun 2021 12:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbhFOKjG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Jun 2021 06:39:06 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:18652 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231664AbhFOKjE (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Jun 2021 06:39:04 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1623753420; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=ksckzWO9VmurR/0PhO+oOToCabvoksQAxJ52rnjPBhA=;
 b=rJdQpFEhB+LIPXF0zcazqGC7/VFnV8iyBKEgFCEMzT6Dk+ZOVlMw4bD7M6f2D0X2O7rDrpp1
 9DVD4tRlWRgCcIof9IxPSb8ce7je8BIkt800gI3rTBOPp8ALvHbCqwclZukcL2ZukLEVlBCA
 iX9nrWMzV1xqIGwIhmMDBPoqUiY=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 60c882cae27c0cc77f2540ce (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 15 Jun 2021 10:36:58
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 174A9C43460; Tue, 15 Jun 2021 10:36:58 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 31F5DC433D3;
        Tue, 15 Jun 2021 10:36:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 31F5DC433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [1/2] brcmfmac: fix setting of station info chains bitmask
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210506132010.3964484-1-alsi@bang-olufsen.dk>
References: <20210506132010.3964484-1-alsi@bang-olufsen.dk>
To:     =?utf-8?q?Alvin_=C5=A0ipraga?= <ALSI@bang-olufsen.dk>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "brcm80211-dev-list.pdl@broadcom.com" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        "SHA-cyfmac-dev-list@infineon.com" <SHA-cyfmac-dev-list@infineon.com>,
        =?utf-8?q?Alvin_=C5=A0ipraga?= <ALSI@bang-olufsen.dk>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210615103658.174A9C43460@smtp.codeaurora.org>
Date:   Tue, 15 Jun 2021 10:36:58 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Alvin Šipraga <ALSI@bang-olufsen.dk> wrote:

> The sinfo->chains field is a bitmask for filled values in chain_signal
> and chain_signal_avg, not a count. Treat it as such so that the driver
> can properly report per-chain RSSI information.
> 
> Before (MIMO mode):
> 
>   $ iw dev wlan0 station dump
>       ...
>       signal: -51 [-51] dBm
> 
> After (MIMO mode):
> 
>   $ iw dev wlan0 station dump
>       ...
>       signal: -53 [-53, -54] dBm
> 
> Fixes: cae355dc90db ("brcmfmac: Add RSSI information to get_station.")
> Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>

2 patches applied to wireless-drivers-next.git, thanks.

feb456437621 brcmfmac: fix setting of station info chains bitmask
9a1590934d9a brcmfmac: correctly report average RSSI in station info

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210506132010.3964484-1-alsi@bang-olufsen.dk/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

