Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49B50220846
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2020 11:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730106AbgGOJLA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Jul 2020 05:11:00 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:33885 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728206AbgGOJK7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Jul 2020 05:10:59 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594804259; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=5ja9tDhHKqdxkv48zPzy76y1NrN/fkGHvNsEgvXr6Tc=;
 b=ZRTe9uWzJ75XMnrj/WrbSvV8pZCA+lYP1wuiOy9MhKkyVbkyYwMhFDVgRJ3tr4hy5u+v/Llq
 9YDxVh/71pUrUriwDOvHNZzHKdVHU7e5mTiL7VvtvQzv+fpKg7zb7OLmMxl6Mw0pHdrCFr6w
 q1NK9yuIG//7Xdz/0cDS3lzJ+g0=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-west-2.postgun.com with SMTP id
 5f0ec81f8e36ecda303a4cf6 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 15 Jul 2020 09:10:55
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E08E7C433C9; Wed, 15 Jul 2020 09:10:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6B9CBC433CA;
        Wed, 15 Jul 2020 09:10:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6B9CBC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v1] rtw88: pci: disable aspm for platform inter-op with
 module
 parameter
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200605074703.32726-1-yhchuang@realtek.com>
References: <20200605074703.32726-1-yhchuang@realtek.com>
To:     <yhchuang@realtek.com>
Cc:     <kernel@iuliancostan.com>, <linux-wireless@vger.kernel.org>,
        <i@outv.im>, <trevor@shartrec.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200715091054.E08E7C433C9@smtp.codeaurora.org>
Date:   Wed, 15 Jul 2020 09:10:54 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<yhchuang@realtek.com> wrote:

> From: Yan-Hsuan Chuang <yhchuang@realtek.com>
> 
> Some platforms cannot read the DBI register successfully for the
> ASPM settings. After the read failed, the bus could be unstable,
> and the device just became unavailable [1]. For those platforms,
> the ASPM should be disabled. But as the ASPM can help the driver
> to save the power consumption in power save mode, the ASPM is still
> needed. So, add a module parameter for them to disable it, then
> the device can still work, while others can benefit from the less
> power consumption that brings by ASPM enabled.
> 
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=206411
> [2] Note that my lenovo T430 is the same.
> 
> Fixes: 3dff7c6e3749 ("rtw88: allows to enable/disable HCI link PS mechanism")
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>

Patch applied to wireless-drivers-next.git, thanks.

68aa716b7dd3 rtw88: pci: disable aspm for platform inter-op with module parameter

-- 
https://patchwork.kernel.org/patch/11589181/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

