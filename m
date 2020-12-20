Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A78802DF551
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Dec 2020 13:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbgLTMF1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 20 Dec 2020 07:05:27 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:30767 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727300AbgLTMF1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 20 Dec 2020 07:05:27 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1608465909; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=CX2oIfYFVzDbJHgQOYYN0XleZinN5DLGEAdsFl4VyXk=;
 b=CSvH4IjDO2XybHZ3fRWOHs4NAZZJ88RN50tm9L8oUvcCThw+z+RlotR7pO/p+EWqxqAz1Nai
 gBoTuesCV3VfTSRikwYkAsiD3WYcxYUWzu2vvpla3J/JvkDWaY1BxrhBCQmozXg8yDoeqcnG
 J6N0d4+CAA2pNl4M8SnPU7fdtE8=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 5fdf3dd3031793dcb45051ee (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 20 Dec 2020 12:04:35
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AD3BDC43463; Sun, 20 Dec 2020 12:04:35 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 072D1C433C6;
        Sun, 20 Dec 2020 12:04:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 072D1C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [1/2] mt76: usb: remove wake logic in mt76u_status_worker
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <00009bf0cfdc9565e4432cad3ed51888c667c25d.1607164041.git.lorenzo@kernel.org>
References: <00009bf0cfdc9565e4432cad3ed51888c667c25d.1607164041.git.lorenzo@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com,
        linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201220120435.AD3BDC43463@smtp.codeaurora.org>
Date:   Sun, 20 Dec 2020 12:04:35 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Similar to mmio code path, remove wake logic in mt76u_status_worker handler.
> Starting from commit 90d494c99a99 ("mt76: improve tx queue stop/wake")', the
> wake queue logic on the usb status path is no longer necessary since the hw
> queues are no longer stopped on the mt76 tx path.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

2 patches applied to wireless-drivers.git, thanks.

e16ab3db87b3 mt76: usb: remove wake logic in mt76u_status_worker
123bb2b73788 mt76: sdio: remove wake logic in mt76s_process_tx_queue

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/00009bf0cfdc9565e4432cad3ed51888c667c25d.1607164041.git.lorenzo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

