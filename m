Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4AA258AE0
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Sep 2020 11:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbgIAI77 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Sep 2020 04:59:59 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:22142 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725949AbgIAI77 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Sep 2020 04:59:59 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598950798; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=zbhKl6lD3pv/gs8uCjSNoyREd8+EABNS5ndMiO8VBfg=;
 b=M4aF2XFNgZcCllg/HDB4fMuVcJU+94DqtRGS2l70ibjBRSlU00E7l8fE37DSOz3h32GP5sMz
 0j9IxaafhEcCmQrzbVBuXfPc9zWBQuG5rei+22a8heS/qF8th9CiRQ8GwXIht/uUl+O61dQd
 NZxkJKaER2jJKtVpmEJF+yItu1E=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5f4e0d7125e1ee7586bbfb05 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 01 Sep 2020 08:59:29
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7FA3CC433A0; Tue,  1 Sep 2020 08:59:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 36BD0C433C6;
        Tue,  1 Sep 2020 08:59:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 36BD0C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: zd1211rw: fix build warning
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200831043425.281538-1-allen.lkml@gmail.com>
References: <20200831043425.281538-1-allen.lkml@gmail.com>
To:     Allen Pais <allen.lkml@gmail.com>
Cc:     dsd@gentoo.org, kune@deine-taler.de, davem@davemloft.net,
        kuba@kernel.org, linux-wireless@vger.kernel.org,
        Allen Pais <allen.lkml@gmail.com>,
        kernel test robot <lkp@intel.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200901085929.7FA3CC433A0@smtp.codeaurora.org>
Date:   Tue,  1 Sep 2020 08:59:29 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Allen Pais <allen.lkml@gmail.com> wrote:

> Tasklet conversion patches intoruced a build warning
> in init_usb_rx(), this patch fixes the same.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: 26721b02466e ("zd1211rw: convert tasklets to use new tasklet_setup() API")
> Signed-off-by: Allen Pais <allen.lkml@gmail.com>

Patch applied to wireless-drivers-next.git, thanks.

5d4650ae8ba6 zd1211rw: fix build warning

-- 
https://patchwork.kernel.org/patch/11745469/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

