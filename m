Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB90D2DE036
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Dec 2020 10:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732864AbgLRJFg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Dec 2020 04:05:36 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:21390 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728210AbgLRJFf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Dec 2020 04:05:35 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1608282311; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=opbN+J0bR0up7fcnsxUQhaf9pOkqB0FicjgwecoPD20=;
 b=jTkD1g5nfEbv7XBpGmwJ2SECd92lFI58msc6QU5fc67xovKZFGL3DE14sUzUzhzi9hNPwojg
 m+NfZFh7agvduJsoJ0ezjS9yNxXJZOc1hqp/i7m9uvSkjFpUowXSTvYm8DKGuQhVP+YY8Eun
 x1iz3GLKsoDo9iqqdKiZxsTqOkU=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5fdc70babfd08afb0d81563a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 18 Dec 2020 09:04:58
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1CF78C43461; Fri, 18 Dec 2020 09:04:58 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D8094C433C6;
        Fri, 18 Dec 2020 09:04:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D8094C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: pci: remove unnecessary mask in
 ath11k_pci_enable_ltssm()
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1608143051-5386-1-git-send-email-kvalo@codeaurora.org>
References: <1608143051-5386-1-git-send-email-kvalo@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201218090458.1CF78C43461@smtp.codeaurora.org>
Date:   Fri, 18 Dec 2020 09:04:58 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@codeaurora.org> wrote:

> 0x10 is a leftover and unnecessary, GCC_GCC_PCIE_HOT_RST_VAL is already defined
> to 0x10.
> 
> No functional changes, compile tested only.
> 
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

562934ada52a ath11k: pci: remove unnecessary mask in ath11k_pci_enable_ltssm()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1608143051-5386-1-git-send-email-kvalo@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

