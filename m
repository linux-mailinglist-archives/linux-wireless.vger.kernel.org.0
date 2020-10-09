Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9006F288C2D
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Oct 2020 17:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389116AbgJIPFp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Oct 2020 11:05:45 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:31668 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389074AbgJIPFp (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Oct 2020 11:05:45 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1602255944; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=ViQ9++w/TyFWiJCmDpt/D7xG3HMjhN+hmNuDrF+2g5k=;
 b=n5fMIvpyJMQCdvdAQ8JE3TW068w6uhEbwiFelGAfHHeD/kRsN37pPs6KlpGxRTgTUX3RRwHh
 xXBq7k0PDUyLqa5uw6DUIDPGsI4foOZLXDGqdrfAViftlagkf+LzJna9lOVPIciUpbjUxvxk
 7v7k6tpi9/90GQC63Y3QqQGmDUo=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5f807c3f3711fec7b1d2016f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 09 Oct 2020 15:05:35
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 14B0BC43385; Fri,  9 Oct 2020 15:05:35 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4150EC433FF;
        Fri,  9 Oct 2020 15:05:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4150EC433FF
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] Revert "iwlwifi: remove wide_cmd_header field"
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <iwlwifi.20201009122123.3e4ee0ad7a71.Id6d95ae601f048aeb4d2ed63a1712e469da84369@changeid>
References: <iwlwifi.20201009122123.3e4ee0ad7a71.Id6d95ae601f048aeb4d2ed63a1712e469da84369@changeid>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org, alexander@wetzel-home.de,
        andy.lavr@gmail.com
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201009150535.14B0BC43385@smtp.codeaurora.org>
Date:   Fri,  9 Oct 2020 15:05:35 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> From: Luca Coelho <luciano.coelho@intel.com>
> 
> This reverts commit 0a8159cbd11abf586693f1ec5264d0df587b71d8.
> 
> It turns out that this flag is used by iwldvm, so we can't get rid of
> it.  This broke iwldvm devices with BAD_COMMAND errors.
> 
> Fixes: 0a8159cbd11a ("iwlwifi: remove wide_cmd_header field")
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

Patch applied to wireless-drivers-next.git, thanks.

b7d96bca1f00 Revert "iwlwifi: remove wide_cmd_header field"

-- 
https://patchwork.kernel.org/patch/11825443/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

