Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1877B45F1F1
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Nov 2021 17:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237781AbhKZQh1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Nov 2021 11:37:27 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:28195 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1378485AbhKZQf1 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Nov 2021 11:35:27 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1637944334; h=Date: Message-ID: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=6hBNTUJmKyf7yXmLGQ6yXgItZigOgXecS9ohi9qRAN0=;
 b=qLgFq7tSp6+Ot/Aucobmry3KyYT3HXq0nyLHn4pEm4GkXv8nRSiWp8SnWpG/cyFk985smGAc
 x8A+XL3AEddVsTixdS+VUYOtKZmnOadMJ7k4M4HNWRKI6FFv/UWxiG3SlR3em2nJrkMpPsKW
 52uXnySX0MgTItA9OxPgit7o2uc=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 61a10c0e4fca5da46d99259e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 26 Nov 2021 16:32:14
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2B278C4360C; Fri, 26 Nov 2021 16:32:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 05B32C4360D;
        Fri, 26 Nov 2021 16:32:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 05B32C4360D
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v8 1/6] mei: bus: add client dma interface
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20211112062814.7502-1-emmanuel.grumbach@intel.com>
References: <20211112062814.7502-1-emmanuel.grumbach@intel.com>
To:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Cc:     linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163794433101.10370.1125934548563056145.kvalo@codeaurora.org>
Date:   Fri, 26 Nov 2021 16:32:14 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Emmanuel Grumbach <emmanuel.grumbach@intel.com> wrote:

> From: Alexander Usyskin <alexander.usyskin@intel.com>
> 
> Expose the client dma mapping via mei client bus interface.
> The client dma has to be mapped before the device is enabled,
> therefore we need to create device linking already during mapping
> and we need to unmap after the client is disable hence we need to
> postpone the unlink and flush till unmapping or when
> destroying the device.
> 
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> Co-developed-by: Tomas Winkler <tomas.winkler@intel.com>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Link: https://lore.kernel.org/r/20210420172755.12178-1-emmanuel.grumbach@intel.com

6 patches applied to wireless-drivers-next.git, thanks.

2cca3465147d mei: bus: add client dma interface
2da4366f9e2c iwlwifi: mei: add the driver to allow cooperation with CSME
4ea7da5fad43 iwlwifi: mei: add debugfs hooks
6d19a5eba5cd iwlwifi: integrate with iwlmei
bfcfdb59b669 iwlwifi: mvm: add vendor commands needed for iwlmei
7ce1f2157e14 iwlwifi: mvm: read the rfkill state and feed it to iwlmei

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211112062814.7502-1-emmanuel.grumbach@intel.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

