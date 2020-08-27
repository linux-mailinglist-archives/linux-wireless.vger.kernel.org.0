Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF2B2542A0
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Aug 2020 11:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbgH0JmU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Aug 2020 05:42:20 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:28836 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726157AbgH0JmT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Aug 2020 05:42:19 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598521339; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=wDL5smpFuHK1RVU40LuGBzvmSaHNufP3hdJpSXobU2w=;
 b=SQOnEvl1InU5RqBHGQDoWEklSpASDCHTETJwPcl4NlZxADibQTh/CnRi9iEzwjjKLc5PPX8F
 caE76vt0My60gZzpeZS2BcOGgAiqJpufHvjowaSz3DTJIFDGZRzetonYbeMamWzl3gX7UszK
 cXS7dHpC2Z4AV63KAplclgDlFFQ=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5f477ffadb22b129dfd2cb12 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 27 Aug 2020 09:42:18
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6DD4DC433C6; Thu, 27 Aug 2020 09:42:17 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5B491C433CA;
        Thu, 27 Aug 2020 09:42:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5B491C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 15/15] rtlwifi: Remove temporary definition of RT_TRACE
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200723204244.24457-16-Larry.Finger@lwfinger.net>
References: <20200723204244.24457-16-Larry.Finger@lwfinger.net>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     linux-wireless@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200827094217.6DD4DC433C6@smtp.codeaurora.org>
Date:   Thu, 27 Aug 2020 09:42:17 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Larry Finger <Larry.Finger@lwfinger.net> wrote:

> A definition of this macro was kept until all drivers had been converted.
> It can now be deleted.
> 
> This change also renames _rtl_dbg_trace() to _rtl_dbg_out().
> 
> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: kernel test robot <lkp@intel.com>

Dropping patch 15 due to the reported build error, please resubmit that
separately.

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/patch/11681621/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

