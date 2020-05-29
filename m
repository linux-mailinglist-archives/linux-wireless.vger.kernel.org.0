Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C80C1E847B
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2020 19:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgE2RPr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 May 2020 13:15:47 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:23063 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726898AbgE2RPq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 May 2020 13:15:46 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590772546; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=KUKSffLOr8iGTBRWNsnLfV9RvP5ReiJB0kFpyiL8pNg=;
 b=bNiR/nMR2DwcuMuytlN5i+gZ59CK5YOYnPGhnYHJ9MMV1mdqqUM1wtgvWLGRrku4A50KXrHt
 +hwzuux55oAjcNz4dBWGrMbejxvwSfn2S562CbYSzC3NuAUHTxGYL5i20Y6qAWXEQF66u7BD
 hpDdOQVChPAZUzvQotLcLB1w4Qo=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5ed1433e3131442d954a04b3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 29 May 2020 17:15:42
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9345DC433C9; Fri, 29 May 2020 17:15:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 06131C433C6;
        Fri, 29 May 2020 17:15:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 06131C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] cw1200: Remove local sdio VENDOR and DEVICE id
 definitions
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200520125410.31757-1-pali@kernel.org>
References: <20200520125410.31757-1-pali@kernel.org>
To:     =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Solomon Peachy <pizza@shaftnet.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200529171541.9345DC433C9@smtp.codeaurora.org>
Date:   Fri, 29 May 2020 17:15:41 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Pali Rohár <pali@kernel.org> wrote:

> They are already present in linux/mmc/sdio_ids.h.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>

Patch applied to wireless-drivers-next.git, thanks.

83cee4e625f8 cw1200: Remove local sdio VENDOR and DEVICE id definitions

-- 
https://patchwork.kernel.org/patch/11560329/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

