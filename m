Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4AC943464E
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Oct 2021 09:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbhJTH56 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Oct 2021 03:57:58 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:42926 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229503AbhJTH55 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Oct 2021 03:57:57 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1634716543; h=Date: Message-ID: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=sgSU08pE4MwHf7VppFAfRQn6yCyfZVk166EZfeEC2zY=;
 b=f5oaGN0cY/DQvdYltZ+oWkuTR1Ehq9vWUBcD4izL0jXZedwSJgiLCygzj3eefNbkGpZ+ewzl
 a5zg0DBIYGwuNWOJ+UDPTyk9oqcfdGOpEuxpGBFSPpskn00rOS/9XN8wTv2sEwvuialgu1Rx
 FK3iSFznh+tcVHmFsS4+RoHs57s=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 616fcb7ffd91319f0ff166b6 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 20 Oct 2021 07:55:43
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EE337C43460; Wed, 20 Oct 2021 07:55:42 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 43219C4338F;
        Wed, 20 Oct 2021 07:55:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 43219C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: Fix device boot error
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210913175048.192812-1-jouni@codeaurora.org>
References: <20210913175048.192812-1-jouni@codeaurora.org>
To:     Jouni Malinen <jouni@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Abinaya Kalaiselvan <akalaise@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163471653903.23156.15370975982440752540.kvalo@codeaurora.org>
Date:   Wed, 20 Oct 2021 07:55:42 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jouni Malinen <jouni@codeaurora.org> wrote:

> From: Abinaya Kalaiselvan <akalaise@codeaurora.org>
> 
> mask value ATH10K_FW_CRASH_DUMP_RAM_DATA is not mandatory to get iram
> mem layout. So introduced ath10k_coredump_get_hw_mem_layout to copy
> hardware memory layout.
> 
> This fixes the below boot error:
> [   17.468882] ath10k_pci 0000:06:00.0: failed to copy target iram contents: -12
> [   17.513925] ath10k_pci 0000:06:00.0: could not init core (-12)
> [   17.517635] ath10k_pci 0000:06:00.0: could not probe fw (-12)
> 
> Tested-on: QCA9984 X86 10.4-3.9.0.2-00139
> 
> Fixes: 9af7c32ceca8 ("ath10k: add target IRAM recovery feature support")
> Signed-off-by: Abinaya Kalaiselvan <akalaise@codeaurora.org>
> Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
> Reported-by: kernel test robot <lkp@intel.com>

The patch had multiple issues so I sent v2:

https://patchwork.kernel.org/project/linux-wireless/patch/20211020075054.23061-1-kvalo@codeaurora.org/

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210913175048.192812-1-jouni@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

