Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 440B625A842
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Sep 2020 11:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgIBJEN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Sep 2020 05:04:13 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:48127 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726406AbgIBJEG (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Sep 2020 05:04:06 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1599037446; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=bNcWb4j6D7NP0IRFXZQt18sXXRlPHK5K026l5OhDEEQ=;
 b=m8xqSWZEDR2ML3lDhJVVoJ1kgaKFYHV4txFUKWOqF7QPnrOt6T95X9B0MKRZxbeqAKDQrZF2
 cf3dwhzUeIJUykYEN6uo1sBCsN+6ZASld3/NosuhOsr8cXq701hyvbwDSHi3fM4SW21L7dEz
 enxlgUQBAUbI02+Pxy4D3evpwN8=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5f4f600532925f96e1c9b8a0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 02 Sep 2020 09:04:05
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A0092C43395; Wed,  2 Sep 2020 09:04:04 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 69F78C433A0;
        Wed,  2 Sep 2020 09:04:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 69F78C433A0
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 15/15] rtlwifi: Remove temporary definition of RT_TRACE
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200831185046.30307-1-Larry.Finger@lwfinger.net>
References: <20200831185046.30307-1-Larry.Finger@lwfinger.net>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     linux-wireless@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200902090404.A0092C43395@smtp.codeaurora.org>
Date:   Wed,  2 Sep 2020 09:04:04 +0000 (UTC)
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

Patch applied to wireless-drivers-next.git, thanks.

4d342964f31e rtlwifi: Remove temporary definition of RT_TRACE

-- 
https://patchwork.kernel.org/patch/11746899/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

