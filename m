Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9D743B2702
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jun 2021 07:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbhFXFwh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Jun 2021 01:52:37 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:54001 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230252AbhFXFwg (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Jun 2021 01:52:36 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1624513818; h=Content-Type: MIME-Version: Message-ID: Date:
 References: Subject: Cc: To: From: Sender;
 bh=jxLy/lhwl4e9PpQ7PCOZ9QUibWNheQYuWVGtFBs4KgM=; b=lGrk27Q3lcx21GMZm3PbDLH5GL0Hi7U6aH0yv1eDs9a8Oiy78Am+x2x38VYwYGQctsLusXDS
 gB/RaeXE0kkmfDqu/J20RRu3uwE/QlkZmaj+qWb8B/ADnHS1MhPKtniOGKHG5nD2og18wUzz
 B/wJ1xaC+nel6hJxBFiVmCMnwMQ=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 60d41d0701dd9a9431bb6738 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 24 Jun 2021 05:49:59
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A7EA9C43460; Thu, 24 Jun 2021 05:49:59 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AD829C433F1;
        Thu, 24 Jun 2021 05:49:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AD829C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Wireless <linux-wireless@vger.kernel.org>,
        Luca Coelho <luciano.coelho@intel.com>,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the wireless-drivers-next tree
References: <20210624121639.6d89a9b8@canb.auug.org.au>
Date:   Thu, 24 Jun 2021 08:49:51 +0300
Message-ID: <871r8rke0w.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> After merging the wireless-drivers-next tree, today's linux-next build
> (x86_64 allmodconfig) produced this warning:
>
> drivers/net/wireless/intel/iwlwifi/fw/acpi.c:720:12: warning: 'iwl_acpi_eval_dsm_func' defined but not used [-Wunused-function]
>   720 | static u32 iwl_acpi_eval_dsm_func(struct device *dev, enum iwl_dsm_funcs_rev_0 eval_func)
>       |            ^~~~~~~~~~~~~~~~~~~~~~
>
> Introduced by commit
>
>   7119f02b5d34 ("iwlwifi: mvm: support BIOS enable/disable for 11ax in Russia")

Thanks for the report, I missed the warning as I had CONFIG_ACPI disabled in my
build tests. I enabled it now and sent a fix:

https://patchwork.kernel.org/project/linux-wireless/patch/20210624052918.4946-1-kvalo@codeaurora.org/

Luca, please review. I also assigned it to me on patchwork and planning
to apply it directly to wireless-drivers-next.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
