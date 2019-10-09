Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD435D09C6
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2019 10:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729548AbfJII1S (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Oct 2019 04:27:18 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60704 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfJII1S (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Oct 2019 04:27:18 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9029761230; Wed,  9 Oct 2019 08:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1570609637;
        bh=SlauZ4D8HLCxXEiHQM7t8QAJWzhEXJDLKsZ+hcRK+f0=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=lLQrx+AWxhce9300FQpQjXBZn8PDbkdTuajjUBgguNgnL+2e40CC8+IWiBJ9ePaqc
         4qkUbxWMgXFhOUl45npJkzGzlfeWmSu+qcANd7zU1U4jN0sI3yRi48g8mPKSmb2RnP
         mGCwYlPNGoLc9gld/ykPTvNFa8mEIhie6Ro/kTeE=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,MISSING_DATE,MISSING_MID,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E2BE261CB7;
        Wed,  9 Oct 2019 08:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1570609631;
        bh=SlauZ4D8HLCxXEiHQM7t8QAJWzhEXJDLKsZ+hcRK+f0=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=X4cpT/lzoG2Y5DFNvnv7+ZtIbTKSY/C0Qd+YnOhtWfMtp7dFmghgj9fRdmal2439t
         EwLezsU/X5qoXw0Fx7HqAxLc59yK4aD4LbDpC5OfOwdknXYlReu9E4ZCIptIl0aFdy
         pa7NtTSoZRP+NJ1v4SdPgtswvP5bE86ro2J7dRnA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E2BE261CB7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rtw88: Fix an error message
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20191007084805.GA3865@mwanda>
References: <20191007084805.GA3865@mwanda>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Yan-Hsuan Chuang <yhchuang@realtek.com>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20191009082716.9029761230@smtp.codeaurora.org>
Date:   Wed,  9 Oct 2019 08:27:11 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dan Carpenter <dan.carpenter@oracle.com> wrote:

> The WARN_ON() macro doesn't take an error message, the argument is a
> condition so this won't display the warning message.
> 
> Fixes: 27e117e4b01b ("rtw88: add deep power save support")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Patch applied to wireless-drivers-next.git, thanks.

be10b09b278f rtw88: Fix an error message

-- 
https://patchwork.kernel.org/patch/11176989/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

