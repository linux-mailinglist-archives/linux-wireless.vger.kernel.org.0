Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCEA823582F
	for <lists+linux-wireless@lfdr.de>; Sun,  2 Aug 2020 17:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgHBPaP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 2 Aug 2020 11:30:15 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:30038 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725768AbgHBPaP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 2 Aug 2020 11:30:15 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1596382214; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=A+g2QS0HdfByZolMx/cDo4EMXXNg/jBWqy9XDQ2JidY=;
 b=n62munwOVvuZCpl3EsjA62hRT37oEAu+rhIqlCgB9ZXsmOgDJKbs5aawOmee6V4bRfIRXCML
 QoSrP0pQ0qwmE4rBhY0J8VNcHlpv1tHn0uUlNyXXucaSdh7OgkeFvlRieCF7lWc23QEjgTeQ
 sX2LPopJ3M3NmQm/tfTokyuA+iI=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n14.prod.us-east-1.postgun.com with SMTP id
 5f26dbf09403087e1001c11f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 02 Aug 2020 15:29:52
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3F2C4C433C6; Sun,  2 Aug 2020 15:29:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 84F2AC433C6;
        Sun,  2 Aug 2020 15:29:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 84F2AC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH net-next] brcm80211: fix possible memleak in
 brcmf_proto_msgbuf_attach
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1595237765-66238-1-git-send-email-wangyufen@huawei.com>
References: <1595237765-66238-1-git-send-email-wangyufen@huawei.com>
To:     Wang Yufen <wangyufen@huawei.com>
Cc:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <brcm80211-dev-list@cypress.com>, <linux-wireless@vger.kernel.org>,
        <davem@davemloft.net>, <kuba@kernel.org>,
        <franky.lin@broadcom.com>, <wright.feng@cypress.com>,
        Wang Yufen <wangyufen@huawei.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200802152951.3F2C4C433C6@smtp.codeaurora.org>
Date:   Sun,  2 Aug 2020 15:29:51 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wang Yufen <wangyufen@huawei.com> wrote:

> When brcmf_proto_msgbuf_attach fail and msgbuf->txflow_wq != NULL,
> we should destroy the workqueue.
> 
> Fixes: 05491d2ccf20 ("brcm80211: move under broadcom vendor directory")

Moving the driver to another directory cannot have caused this bug, so I'm
removing the fixes tag. Please check your commit logs, don't just blindly copy
what git-blame says.

-- 
https://patchwork.kernel.org/patch/11673291/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

