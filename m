Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD91B2357D7
	for <lists+linux-wireless@lfdr.de>; Sun,  2 Aug 2020 17:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbgHBO7X (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 2 Aug 2020 10:59:23 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:48895 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725853AbgHBO7W (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 2 Aug 2020 10:59:22 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1596380361; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=BKtA1y2+cg1n0Oxr+QAJxIgbuRnTbM/9xV3TLuWzV9E=;
 b=FHsEHe8nsUbuoai5+llKsA+IyBVDI+NVf6qKsUHqm9j5kfAVk13JHddgpuuJQ01lkcO2Htik
 p2gw+Ppjw78/GlCYpBRrwtKvn84ZuToKWLZFA3m5Q5U/F6PH42V8zHG6ZGSjnyDlLNnZpNfD
 gstoV4heWQ4nwtLUxSB/K3/q1e4=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5f26d4c621feae908b0648e7 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 02 Aug 2020 14:59:18
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0818CC43395; Sun,  2 Aug 2020 14:59:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 61ABAC433C9;
        Sun,  2 Aug 2020 14:59:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 61ABAC433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v1] prism54: islpci_hotplug: use generic power management
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200721125514.145607-1-vaibhavgupta40@gmail.com>
References: <20200721125514.145607-1-vaibhavgupta40@gmail.com>
To:     Vaibhav Gupta <vaibhavgupta40@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200802145918.0818CC43395@smtp.codeaurora.org>
Date:   Sun,  2 Aug 2020 14:59:18 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Vaibhav Gupta <vaibhavgupta40@gmail.com> wrote:

> Drivers using legacy power management .suspen()/.resume() callbacks
> have to manage PCI states and device's PM states themselves. They also
> need to take care of standard configuration registers.
> 
> Switch to generic power management framework using a single
> "struct dev_pm_ops" variable to take the unnecessary load from the driver.
> This also avoids the need for the driver to directly call most of the PCI
> helper functions and device power state control functions as through
> the generic framework, PCI Core takes care of the necessary operations,
> and drivers are required to do only device-specific jobs.
> 
> Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>

Patch applied to wireless-drivers-next.git, thanks.

81cf72b74671 prism54: islpci_hotplug: use generic power management

-- 
https://patchwork.kernel.org/patch/11675653/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

