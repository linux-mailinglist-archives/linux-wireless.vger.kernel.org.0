Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAD232212E5
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2020 18:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbgGOQqm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Jul 2020 12:46:42 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:33685 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725897AbgGOQql (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Jul 2020 12:46:41 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594831601; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=eb4kKC4UQm/vpwtdUU3zCwzF5FNDpt82Q911d//PWws=;
 b=h7tMOiOJJZp40UJXcznDh75WQNLgopKq/9Yaek2r3AXv5XOIllqmMiKGhsNvc9Ib+IToAyLN
 sIOBCckNgD70SAcN0O9nVWI+D4gQJDFn2np4P22gYPmx+3WAKOkxYnvZG52CQybGclUScLnp
 F1ZE5j95WpGQopxSw/HjNmizuf8=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-east-1.postgun.com with SMTP id
 5f0f32e7427cd5576630523b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 15 Jul 2020 16:46:31
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2DC3DC433C9; Wed, 15 Jul 2020 16:46:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DB2ABC433C6;
        Wed, 15 Jul 2020 16:46:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DB2ABC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH V2 1/2] rtlwifi: Use const in 8188ee/8723be/8821ae
 swing_table
 declarations
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200629055843.25394-1-pkshih@realtek.com>
References: <20200629055843.25394-1-pkshih@realtek.com>
To:     <pkshih@realtek.com>
Cc:     <joe@perches.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200715164630.2DC3DC433C9@smtp.codeaurora.org>
Date:   Wed, 15 Jul 2020 16:46:30 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<pkshih@realtek.com> wrote:

> From: Joe Perches <joe@perches.com>
> 
> Reduce data usage about 1KB by using const.
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

2 patches applied to wireless-drivers-next.git, thanks.

40c66c68b3fd rtlwifi: Use const in 8188ee/8723be/8821ae swing_table declarations
6648cfac8e2a rtlwifi: 8821ae: remove unused path B parameters from swing table

-- 
https://patchwork.kernel.org/patch/11632619/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

