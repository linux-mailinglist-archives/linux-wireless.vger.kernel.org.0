Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7631BB90A
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2020 10:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgD1Iov (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Apr 2020 04:44:51 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:44036 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726641AbgD1Iou (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Apr 2020 04:44:50 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588063490; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=ZSNSGLztqx/bFT9D2SAH7xK3Gx1la+nBonDVvy1XqhI=;
 b=KbQTi5ARvi8ZTcRJh+Cseey0S16MP/QchIlaJE3P7KCDN7er2IcYVZx5qgYlKA3/QLCAuVI6
 RvR+RWjCG9yuCRpzZnhdxWKgZhJEKEUGVG2qdm8ZZoNUuGuqlk/h119X9pUEjTrruKr6G7PX
 XS3d0oIwqJCKaUhsZa7fMw+TZ7g=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea7ed01.7f01ed655490-smtp-out-n03;
 Tue, 28 Apr 2020 08:44:49 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7D63BC433F2; Tue, 28 Apr 2020 08:44:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 56D14C433CB;
        Tue, 28 Apr 2020 08:44:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 56D14C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rtw88: fix sparse warnings for download firmware routine
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200424101255.28239-1-yhchuang@realtek.com>
References: <20200424101255.28239-1-yhchuang@realtek.com>
To:     <yhchuang@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200428084448.7D63BC433F2@smtp.codeaurora.org>
Date:   Tue, 28 Apr 2020 08:44:48 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<yhchuang@realtek.com> wrote:

> From: Yan-Hsuan Chuang <yhchuang@realtek.com>
> 
> sparse warnings: (new ones prefixed by >>)
> 
> >> drivers/net/wireless/realtek/rtw88/mac.c:653:5: sparse: sparse:
> symbol '__rtw_download_firmware' was not declared. Should it be static?
> >> drivers/net/wireless/realtek/rtw88/mac.c:817:5: sparse: sparse:
> symbol '__rtw_download_firmware_legacy' was not declared. Should it be
> static?
> 
> Fixes: 15d2fcc6b2de ("rtw88: add legacy firmware download for 8723D devices")
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>

Patch applied to wireless-drivers-next.git, thanks.

3d8bf50860c7 rtw88: fix sparse warnings for download firmware routine

-- 
https://patchwork.kernel.org/patch/11507425/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
