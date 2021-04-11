Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF9A835B2BA
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Apr 2021 11:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235005AbhDKJaQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 11 Apr 2021 05:30:16 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:60060 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbhDKJaP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 11 Apr 2021 05:30:15 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1618133399; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=Wjr4MtiwE10dyuPFl8BYAE2OkUDfX84c9+H04sEh7dQ=;
 b=kcxkjbIKhpCM0/eGl9skZ4S1bGj0Rjk9EkKkbnx1aQ6dUNE8x/mnWz+m9bsf+JUWu2Q0yDON
 GS8S8vllFzQnj0R2AxvTjYU08Ix5MntD2VUKX+GYQHo+u8hd5VutikPnzh3Gmws0RVuJcKjd
 LGYGzMMYRYs+ApGyIu87OpwKBiE=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 6072c180febcffa80ff6be49 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 11 Apr 2021 09:29:36
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 110E4C433CA; Sun, 11 Apr 2021 09:29:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7CA22C433C6;
        Sun, 11 Apr 2021 09:29:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7CA22C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] rtw88: Fix an error code in
 rtw_debugfs_set_rsvd_page()
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <YE8nmatMDBDDWkjq@mwanda>
References: <YE8nmatMDBDDWkjq@mwanda>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Yan-Hsuan Chuang <tony0620emma@gmail.com>,
        Tzu-En Huang <tehuang@realtek.com>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210411092936.110E4C433CA@smtp.codeaurora.org>
Date:   Sun, 11 Apr 2021 09:29:36 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dan Carpenter <dan.carpenter@oracle.com> wrote:

> The sscanf() function returns the number of matches (0 or 1 in this
> case).  It doesn't return error codes.  We should return -EINVAL if the
> string is invalid
> 
> Fixes: c376c1fc87b7 ("rtw88: add h2c command in debugfs")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Patch applied to wireless-drivers-next.git, thanks.

c9eaee0c2ec6 rtw88: Fix an error code in rtw_debugfs_set_rsvd_page()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/YE8nmatMDBDDWkjq@mwanda/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

