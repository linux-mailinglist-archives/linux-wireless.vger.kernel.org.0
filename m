Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9E2458946
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2019 19:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfF0Rsv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Jun 2019 13:48:51 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53682 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbfF0Rsv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Jun 2019 13:48:51 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 72D48607CA; Thu, 27 Jun 2019 17:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561657730;
        bh=qED9uKP5F5WoOP06iz8bukm7ZaG+W6I585cBXO19cj0=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=S04I4fOBg19EUUHrFO3It4BfVcDg0ZJw6LEbgtERdaCHcrmBm3EWOGlxi4/uWUTp2
         M8VgIW4Nf2X7as3sZSWNOtBuKRgOovLXuWiJfGFnbvfpBrgdyeSsea/tIkYHl7TUTc
         8BNBojD/lmM4fBRRu9tCzBq+cVDt2JlHbWA7P0DE=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EB53D602BC;
        Thu, 27 Jun 2019 17:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561657730;
        bh=qED9uKP5F5WoOP06iz8bukm7ZaG+W6I585cBXO19cj0=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=IKP+eryRm4WL82EVCLjnTXs4pqPnsJplUYG9BhlFIZArsP5Jj2si78JDU7cpnShtJ
         H/yD564G0Fw5FqI+QKFO/tO/iMBODhfg3GNABMerQz+sHC0SPSeODZ+65JvlD+kdRE
         2zdbhm8VnqSPrivyHPwZr0n3NUPuLGcEvkoHLQRc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EB53D602BC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wireless: wil6210: no need to check return value of
 debugfs_create functions
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20190611191024.GA17227@kroah.com>
References: <20190611191024.GA17227@kroah.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Maya Erez <merez@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, wil6210@qti.qualcomm.com
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190627174850.72D48607CA@smtp.codeaurora.org>
Date:   Thu, 27 Jun 2019 17:48:50 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.
> 
> Cc: Maya Erez <merez@codeaurora.org>
> Cc: Kalle Valo <kvalo@codeaurora.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: linux-wireless@vger.kernel.org
> Cc: wil6210@qti.qualcomm.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Maya Erez <merez@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

ce564170dfe5 wil6210: no need to check return value of debugfs_create functions

-- 
https://patchwork.kernel.org/patch/10988197/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

