Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8F5243E235
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Oct 2021 15:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbhJ1NbD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Oct 2021 09:31:03 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:62706 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230331AbhJ1NbB (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Oct 2021 09:31:01 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1635427715; h=Date: Message-ID: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=x3m0T0TYkMfipQ1cWI4bbiEZDY0ERUgi7XTAfjybcjY=;
 b=ZGQYDd26945TDS25/EozhKu5HGyHlx0mwql4HEBFHEDmn3mNbmNXO5a1ZzRXw84MVAiBYs9W
 Ho/yEk0AB2In2skz4ySGgUOIDV5T6v2IOCnRDVe5vXTM3QL0gOsvsi0OTC7FWY35UqjqlqnD
 r4WGhJehKfaFYMKQ6yEbJDXUzls=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 617aa573f6a3eeacf9187729 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 28 Oct 2021 13:28:19
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 94702C43619; Thu, 28 Oct 2021 13:28:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E72BEC4338F;
        Thu, 28 Oct 2021 13:28:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org E72BEC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 3/3] mwifiex: fix division by zero in fw download path
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20211027080819.6675-4-johan@kernel.org>
References: <20211027080819.6675-4-johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Brian Norris <briannorris@chromium.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>, stable@vger.kernel.org,
        Amitkumar Karwar <akarwar@marvell.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163542769280.5095.17800694227410955005.kvalo@codeaurora.org>
Date:   Thu, 28 Oct 2021 13:28:18 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johan Hovold <johan@kernel.org> wrote:

> Add the missing endpoint sanity checks to probe() to avoid division by
> zero in mwifiex_write_data_sync() in case a malicious device has broken
> descriptors (or when doing descriptor fuzz testing).
> 
> Only add checks for the firmware-download boot stage, which require both
> command endpoints, for now. The driver looks like it will handle a
> missing endpoint during normal operation without oopsing, albeit not
> very gracefully as it will try to submit URBs to the default pipe and
> fail.
> 
> Note that USB core will reject URBs submitted for endpoints with zero
> wMaxPacketSize but that drivers doing packet-size calculations still
> need to handle this (cf. commit 2548288b4fb0 ("USB: Fix: Don't skip
> endpoint descriptors with maxpacket=0")).
> 
> Fixes: 4daffe354366 ("mwifiex: add support for Marvell USB8797 chipset")
> Cc: stable@vger.kernel.org      # 3.5
> Cc: Amitkumar Karwar <akarwar@marvell.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> Reviewed-by: Brian Norris <briannorris@chromium.org>

Patch applied to wireless-drivers-next.git, thanks.

89f8765a11d8 mwifiex: fix division by zero in fw download path

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211027080819.6675-4-johan@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

