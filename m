Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCD22F67C0
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Jan 2021 18:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbhANRbu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Jan 2021 12:31:50 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:59203 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbhANRbu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Jan 2021 12:31:50 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1610645487; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=a/+Vk3tZnLQyiXNt1NDAmp9qgghDvKblFmmYetfo3Lk=;
 b=CPSiDxnIpCGj3tD54xtEysUu6T1S373TOGb488OdsBQqbOrW7eRzHEY7DxfQl188HmtiKtgi
 o6ooW6n2XfAgJJVXHujIh5Vx5lF1frKmy1iFx78oXAYwm9ZQ4dDUO40ez4EygorBw1CaWubS
 A5KQL2z2pnWubN4LhNkx740QFik=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 60007fb7415a6293c5b5b514 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 14 Jan 2021 17:30:31
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EBDFAC43462; Thu, 14 Jan 2021 17:30:30 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C2EB7C433C6;
        Thu, 14 Jan 2021 17:30:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C2EB7C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] mt7601u: process URBs in status EPROTO properly
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20201217161302.GA12562@E480>
References: <20201217161302.GA12562@E480>
To:     Zhi Han <z.han@gmx.net>
Cc:     linux-wireless@vger.kernel.org, kuba@kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210114173030.EBDFAC43462@smtp.codeaurora.org>
Date:   Thu, 14 Jan 2021 17:30:30 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Zhi Han <z.han@gmx.net> wrote:

> When the usb device being plugged out, before the usb_driver:disconnect
> called by e.g workqueue, it is possible that some URBs are still in
> processing, and being marked as EPROTO in host controller.
> 
> Those URBs should not be scheduled in complete_rx callback function to
> get further processing.
> 
> Signed-off-by: Zhi Han <z.han@gmx.net>
> Acked-by: Jakub Kicinski <kuba@kernel.org>

Patch applied to wireless-drivers-next.git, thanks.

0e40dbd56d67 mt7601u: process URBs in status EPROTO properly

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20201217161302.GA12562@E480/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

