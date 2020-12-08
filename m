Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7C32D24E3
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Dec 2020 08:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbgLHHqT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Dec 2020 02:46:19 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:15100 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbgLHHqT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Dec 2020 02:46:19 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1607413559; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=mQh4D22HBya4G4ZCJxJspFIe9YA9MmItJjpgs4D4lSA=;
 b=aPAaWFhJVwUTX/zW1dIKRERxsa5LwhrZSKZDeVf2I3CwLjJ82CEFQiIu00nN8TrV/S8fJScD
 N4a6ziLZSNZP+OFgb/d/+N1iN4A9sVPluKzd6pOo1zZtwc7GKHOoQPfJVEGTnUUOi3fkgjKm
 usDB1B59vi3iD2R2BB7TOoLc19Q=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5fcf2f1535e04c51aba1d5cd (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 08 Dec 2020 07:45:25
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 52131C43461; Tue,  8 Dec 2020 07:45:25 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D1313C433C6;
        Tue,  8 Dec 2020 07:45:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D1313C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] add ath11k MODULE_FIRMWARE macros
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20201202182705.dhkml4nb4rf2vwav@orac>
References: <20201202182705.dhkml4nb4rf2vwav@orac>
To:     Devin Bayer <dev@doubly.so>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201208074525.52131C43461@smtp.codeaurora.org>
Date:   Tue,  8 Dec 2020 07:45:25 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Devin Bayer <dev@doubly.so> wrote:

> I am trying to get the ath11k driver to work with VyOS and during the
> build it tries to discover the firmware blobs which drivers require.
> 
> This doesn't work with ath11k because it doesn't use the MODULE_FIRMWARE
> macro. This patch fixes that.
> 
> Signed-off-by: Devin Bayer <dev@doubly.so>
> [kvalo@codeaurora.org: cleanup commit log, move to pci.c]
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

3dbd7fe78c42 ath11k: pci: add MODULE_FIRMWARE macros

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20201202182705.dhkml4nb4rf2vwav@orac/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

