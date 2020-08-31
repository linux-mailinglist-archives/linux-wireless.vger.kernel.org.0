Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B395D257B0D
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Aug 2020 16:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbgHaOFB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 Aug 2020 10:05:01 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:60543 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgHaOE7 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 Aug 2020 10:04:59 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598882699; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=RRcT0ZzTQZoNhrKJpxf+857MEYDzY3HrhHoOF/ZLHdU=; b=aAXKsNHGG3TWZ1HDykAQ2dq/XjzzFI2WRr4Dkws6ua4UPEjqK20OMiS9zj/9AIhNTmeyIw1s
 L0rj5EiuWWQUfxrIm4RCVIuaAsWFDWlGCKv5kOyfx8QTBqQWs5FYlWjHZDHtwIumDImWjSHj
 QKBMnxMj3jeZ9dcGRyAMZJEgXtw=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5f4d03829bdf68cc0331b540 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 31 Aug 2020 14:04:50
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E4E8DC4339C; Mon, 31 Aug 2020 14:04:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A20F4C433C6;
        Mon, 31 Aug 2020 14:04:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A20F4C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Allen Pais <allen.lkml@gmail.com>
Cc:     dsd@gentoo.org, kune@deine-taler.de, davem@davemloft.net,
        kuba@kernel.org, linux-wireless@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] wireless: zd1211rw: fix build warning
References: <20200831043425.281538-1-allen.lkml@gmail.com>
Date:   Mon, 31 Aug 2020 17:04:45 +0300
In-Reply-To: <20200831043425.281538-1-allen.lkml@gmail.com> (Allen Pais's
        message of "Mon, 31 Aug 2020 10:04:25 +0530")
Message-ID: <87y2lu6hdu.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Allen Pais <allen.lkml@gmail.com> writes:

>  Tasklet conversion patches intoruced a build warning
> in init_usb_rx(), this patch fixes the same.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Allen Pais <allen.lkml@gmail.com>

I'll change the title to:

zd1211rw: fix build warning

And add:

Fixes: 26721b02466e ("zd1211rw: convert tasklets to use new tasklet_setup() API")

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
