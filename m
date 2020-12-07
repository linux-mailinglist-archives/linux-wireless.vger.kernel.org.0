Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11EFE2D1673
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Dec 2020 17:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbgLGQgy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Dec 2020 11:36:54 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:20850 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727393AbgLGQgx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Dec 2020 11:36:53 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1607358995; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=u63whlbSh4y6dg0bzGordeEpKrlwLA9/qUQr249ZiG8=;
 b=U03zh7GWCrKUmZq86OrOfUtHFZ0meaBsXV9R+0ZG1fHnMauZr7LNRrf+UYgFHU+tpzn2e6XF
 JM00XRRzBPzwnkdFQEPV0PRgrUX2OXeVDp/ZlkomEZy+C56Yz0kJDuw0/hejgE9l6G0yZzXV
 CjJk1VOdXcPhKB43bwhXo7VSJ+o=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-east-1.postgun.com with SMTP id
 5fce59f3ae7b105766da71a1 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 07 Dec 2020 16:36:03
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7D14EC43462; Mon,  7 Dec 2020 16:36:01 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1FF23C433C6;
        Mon,  7 Dec 2020 16:35:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1FF23C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH wireless] adm8211: fix error return code in
 adm8211_probe()
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1607071638-33619-1-git-send-email-zhangchangzhong@huawei.com>
References: <1607071638-33619-1-git-send-email-zhangchangzhong@huawei.com>
To:     Zhang Changzhong <zhangchangzhong@huawei.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        "John W. Linville" <linville@tuxdriver.com>,
        Michael Wu <flamingice@sourmilk.net>,
        Zhang Changzhong <zhangchangzhong@huawei.com>,
        <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201207163602.7D14EC43462@smtp.codeaurora.org>
Date:   Mon,  7 Dec 2020 16:36:01 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Zhang Changzhong <zhangchangzhong@huawei.com> wrote:

> Fix to return a negative error code from the error handling
> case instead of 0, as done elsewhere in this function.
> 
> Fixes: cc0b88cf5ecf ("[PATCH] Add adm8211 802.11b wireless driver")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zhang Changzhong <zhangchangzhong@huawei.com>

Patch applied to wireless-drivers-next.git, thanks.

05c2a61d69ea adm8211: fix error return code in adm8211_probe()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1607071638-33619-1-git-send-email-zhangchangzhong@huawei.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

