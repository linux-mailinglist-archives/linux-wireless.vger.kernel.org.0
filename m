Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B23E25A846
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Sep 2020 11:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgIBJEX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Sep 2020 05:04:23 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:61514 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726762AbgIBJEN (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Sep 2020 05:04:13 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1599037452; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=Yj6uFnqBv37hAtARw1jGBYsz4NqT1O/pC/lPBawUtwg=;
 b=fM+gw6EYG1JLsynOwOECTygKmrLqtlJtIyskd4B5AS/rX+quD6i98T3nysxGlJLgHodMSjOa
 XNZHID8TaAMdQfndopA8z2SXvDOXtGdZ/Vh7WMMhQ7SPLsEsWKZhKZAX6gXFPGWiak6Cy5zc
 PZATedyh7Em6/nkZy68Qla23HPE=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5f4f5fe6885efaea0a5e7d8b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 02 Sep 2020 09:03:34
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 10024C433CA; Wed,  2 Sep 2020 09:03:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E363AC433C6;
        Wed,  2 Sep 2020 09:03:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E363AC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 14/15] rtlwifi: rtl8821ae: Rename RT_TRACE to rtl_dbg
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200831184536.29950-1-Larry.Finger@lwfinger.net>
References: <20200831184536.29950-1-Larry.Finger@lwfinger.net>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     linux-wireless@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200902090334.10024C433CA@smtp.codeaurora.org>
Date:   Wed,  2 Sep 2020 09:03:34 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Larry Finger <Larry.Finger@lwfinger.net> wrote:

> Change the misleading macro name to one that is more descriptive for
> rtl8821ae. Changes suggested by ckeckpatch.pl have been made.
> 
> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>

Patch applied to wireless-drivers-next.git, thanks.

98611b00b7ac rtlwifi: rtl8821ae: Rename RT_TRACE to rtl_dbg

-- 
https://patchwork.kernel.org/patch/11746883/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

