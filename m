Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A71A226B18
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jul 2020 18:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732089AbgGTQjQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Jul 2020 12:39:16 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:20499 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731516AbgGTQjO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Jul 2020 12:39:14 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1595263153; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=oADOHu2XYQ7xLJMCcJfAaqhNS8NeuEPZuwNJvU0jarw=;
 b=ZU8tXkjO91jroFed4fU7f3Ht0M2sYSntZTB5V3yuMNVaqc/naME7lf984sNZDOKZ22gvRILI
 nBP0L8VKMec66iKlcdoXTOrGsNNJIYw3YitwGbtLVOAIAj4jSdhEtpaOI93E/pMuj0I0MPC1
 vTI0sZ1lOeWLuvn4c8KGULkp5/0=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n18.prod.us-west-2.postgun.com with SMTP id
 5f15c8b15b75bcda60974d25 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 20 Jul 2020 16:39:13
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BE814C43391; Mon, 20 Jul 2020 16:39:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A4238C433C6;
        Mon, 20 Jul 2020 16:39:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A4238C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] iwlwifi: Make some Killer Wireless-AC 1550 cards work
 again
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200714091911.4442-1-alessio.bonfiglio@mail.polimi.it>
References: <20200714091911.4442-1-alessio.bonfiglio@mail.polimi.it>
To:     Alessio Bonfiglio <alessio.bonfiglio@mail.polimi.it>
Cc:     linux-wireless@vger.kernel.org,
        Alessio Bonfiglio <alessio.bonfiglio@mail.polimi.it>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200720163912.BE814C43391@smtp.codeaurora.org>
Date:   Mon, 20 Jul 2020 16:39:12 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Alessio Bonfiglio <alessio.bonfiglio@mail.polimi.it> wrote:

> Fix the regression introduced by commit c8685937d07f ("iwlwifi: move
> pu devices to new table") by adding the ids and the configurations of
> two missing Killer 1550 cards in order to configure and let them work
> correctly again (following the new table convention).
> Resolve bug 208141 ("Wireless ac 9560 not working kernel 5.7.2",
> https://bugzilla.kernel.org/show_bug.cgi?id=208141).
> 
> Fixes: c8685937d07f ("iwlwifi: move pu devices to new table")
> Signed-off-by: Alessio Bonfiglio <alessio.bonfiglio@mail.polimi.it>

Patch applied to wireless-drivers.git, thanks.

b5ba46b81c2f iwlwifi: Make some Killer Wireless-AC 1550 cards work again

-- 
https://patchwork.kernel.org/patch/11662083/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

