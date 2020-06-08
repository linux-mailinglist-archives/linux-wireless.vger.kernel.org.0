Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC031F1C4C
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jun 2020 17:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730346AbgFHPlz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 Jun 2020 11:41:55 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:63421 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729580AbgFHPly (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 Jun 2020 11:41:54 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591630913; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=sa75mzHZ2bGETfWdUaWiF6FbWCgAVbPKq8iwMeyAHE0=;
 b=PRTeymNr5RVMoeau6hG/5lK4dpQ3qh68+pvdFlSoNrEvm6O4dfXE6xWYCIIAhLxM5VDW21Vh
 AcIExFWljHJNDRuRKTrqz09nOkRwla+ae5RzCMuHbYNK5UUa1mcXe490UNR0GzDVPm/plaqb
 HvlFlvQXUvcJVktMTfAu43XQLiw=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5ede5c40b2f512dd9ddb3775 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 08 Jun 2020 15:41:52
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 49CF2C43391; Mon,  8 Jun 2020 15:41:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B3C19C433CA;
        Mon,  8 Jun 2020 15:41:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B3C19C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5 1/8] ath11k: add 6G frequency list supported by driver
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200603001724.12161-2-pradeepc@codeaurora.org>
References: <20200603001724.12161-2-pradeepc@codeaurora.org>
To:     Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200608154152.49CF2C43391@smtp.codeaurora.org>
Date:   Mon,  8 Jun 2020 15:41:52 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Pradeep Kumar Chitrapu <pradeepc@codeaurora.org> wrote:

> This patch adds support for 6GHz frequency listing.
> 
> Signed-off-by: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

This patchset had new warnings which I fixed in the pending branch:

drivers/net/wireless/ath/ath11k/dp_rx.c:2178: braces {} should be used on all arms of this statement
drivers/net/wireless/ath/ath11k/mac.c:3749: Blank lines aren't necessary before a close brace '}'
drivers/net/wireless/ath/ath11k/mac.c:4197: Blank lines aren't necessary before a close brace '}'

-- 
https://patchwork.kernel.org/patch/11584701/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

