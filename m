Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1897235826
	for <lists+linux-wireless@lfdr.de>; Sun,  2 Aug 2020 17:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgHBP0D (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 2 Aug 2020 11:26:03 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:63524 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbgHBP0C (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 2 Aug 2020 11:26:02 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1596381962; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=V5EG25ddeb8sJEO1NidFzVQDv7OZ5DtjFwDrZxV7BfY=;
 b=lbXDDR4uo5wtmMoNxMd9qYplnZt4PQRrSPMyTpe02pZeAzfAQ40HOMVmYuD9GmvdcWo+hP7E
 wRC53gHgKV1yNhes85ceesxTqIrdqu8CXPq4n7NnSBVorOCIMWm/qtwE0QTbr4Q0a+XSaFpS
 c1FCl3YzqtKQdIlnSBqqPFdCvv8=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-east-1.postgun.com with SMTP id
 5f26daeabcdc2fe471304969 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 02 Aug 2020 15:25:30
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7420FC43391; Sun,  2 Aug 2020 15:25:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CCAE1C433C9;
        Sun,  2 Aug 2020 15:25:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CCAE1C433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH net] wl1251: fix always return 0 error
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200730073939.33704-1-wanghai38@huawei.com>
References: <20200730073939.33704-1-wanghai38@huawei.com>
To:     Wang Hai <wanghai38@huawei.com>
Cc:     <davem@davemloft.net>, <kuba@kernel.org>,
        <david.gnedt@davizone.at>, <linville@tuxdriver.com>,
        <pavel@ucw.cz>, <pali@kernel.org>,
        <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200802152529.7420FC43391@smtp.codeaurora.org>
Date:   Sun,  2 Aug 2020 15:25:29 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wang Hai <wanghai38@huawei.com> wrote:

> wl1251_event_ps_report() should not always return 0 because
> wl1251_ps_set_mode() may fail. Change it to return 'ret'.
> 
> Fixes: f7ad1eed4d4b ("wl1251: retry power save entry")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wang Hai <wanghai38@huawei.com>

Patch applied to wireless-drivers-next.git, thanks.

20e6421344b5 wl1251: fix always return 0 error

-- 
https://patchwork.kernel.org/patch/11692427/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

