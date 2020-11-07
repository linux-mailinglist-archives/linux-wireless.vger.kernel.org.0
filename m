Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32F682AA66A
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Nov 2020 16:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgKGPtx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 7 Nov 2020 10:49:53 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:37692 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbgKGPtw (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 7 Nov 2020 10:49:52 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604764192; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=QX/CAFsEEcsAvay8vmxzFXfg8iFSLG7sVEq8z4uprI4=;
 b=T7+BUn3kXYJd7s2BgVIDH1raUoIJ7MJIycptdpFAKk8+Wfv6yJE0mMIz09Xj0jLcctmweJ43
 wG4JLpX4LIbHH+yKcsROZSuE3p+kDb2POEnZOheCqrqex+E21VmnTUyizqKOioBcAbUaH+bF
 GnvQ/XgvmN0FotmUEto/CUm6ALM=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5fa6c213e41a481b55d039fa (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 07 Nov 2020 15:49:39
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E1EA2C433C9; Sat,  7 Nov 2020 15:49:38 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 94C08C433C6;
        Sat,  7 Nov 2020 15:49:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 94C08C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] brcmfmac: fix SDIO access for big-endian host
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20201020174639.28892-1-rde@setrix.com>
References: <20201020174639.28892-1-rde@setrix.com>
To:     Remi Depommier <rde@setrix.com>
Cc:     linux-wireless@vger.kernel.org, Remi Depommier <rde@setrix.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201107154938.E1EA2C433C9@smtp.codeaurora.org>
Date:   Sat,  7 Nov 2020 15:49:38 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Remi Depommier <rde@setrix.com> wrote:

> These full-mac chips use little-endian byte ordering. This patch
> adds a few missing conversions to/from little-endian so that the
> driver may be used with a big-endian host.
> 
> Signed-off-by: Remi Depommier <rde@setrix.com>

Patch applied to wireless-drivers-next.git, thanks.

d56fd83cf99c brcmfmac: fix SDIO access for big-endian host

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20201020174639.28892-1-rde@setrix.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

