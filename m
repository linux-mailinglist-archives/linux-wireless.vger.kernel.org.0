Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 444AD2872C0
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Oct 2020 12:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729589AbgJHKq3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Oct 2020 06:46:29 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:31112 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729562AbgJHKqZ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Oct 2020 06:46:25 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1602153984; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=5L5pKh2bQVuMrcN3xcSsrwheEy1mTGgJUbk2Z/atqUY=;
 b=nd26WbXyCILYjpl8rNpVSSqk17VxqPIKsaMIKSgg5TAqtYbtDHQvBKMNe8NLtluZQQiobNlQ
 Se15VHUfpL3/6iIAY5Ohz0pIp7rYm5NIc0odeC2GelERTWM4E9j42CJ0guvGPfDkYHp/YBWG
 OmLDatAPIC3RMjcrikY75SZDA6I=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5f7eedf6d6d00c7a9e5e27c6 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 08 Oct 2020 10:46:14
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 79150C433FF; Thu,  8 Oct 2020 10:46:14 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1DBA0C433CB;
        Thu,  8 Oct 2020 10:46:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1DBA0C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] ath11k: Fix memory leak on error path
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20201004100218.311653-2-alex.dewar90@gmail.com>
References: <20201004100218.311653-2-alex.dewar90@gmail.com>
To:     Alex Dewar <alex.dewar90@gmail.com>
Cc:     unlisted-recipients:; (no To-header on input)
        Alex Dewar <alex.dewar90@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Illegal-Object: Syntax error in Cc: address found on vger.kernel.org:
        Cc:     unlisted-recipients:; (no To-header on input)Alex Dewar <alex.dewar90@gmail.com>
                                                                     ^-missing end of address
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201008104614.79150C433FF@smtp.codeaurora.org>
Date:   Thu,  8 Oct 2020 10:46:14 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Alex Dewar <alex.dewar90@gmail.com> wrote:

> In ath11k_mac_setup_iface_combinations(), if memory cannot be assigned
> for the variable limits, then the memory assigned to combinations will
> be leaked. Fix this.
> 
> Addresses-Coverity-ID: 1497534 ("Resource leaks")
> Fixes: 2626c269702e ("ath11k: add interface_modes to hw_params")
> Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>

Patch applied to wireless-drivers-next.git, thanks.

8431350eee2e ath11k: Fix memory leak on error path

-- 
https://patchwork.kernel.org/patch/11815579/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

