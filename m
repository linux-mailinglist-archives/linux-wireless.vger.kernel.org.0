Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70EB42D2F16
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Dec 2020 17:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730398AbgLHQGd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Dec 2020 11:06:33 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:59122 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730004AbgLHQGd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Dec 2020 11:06:33 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1607443570; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=WLq9WnXIdyVCLN05fCAlgSfSryx7PT9u84TUFl5XxYk=; b=l8BcyNdfbAstSkTpHFUKPvw07etRjw8eweQKtdutOKv5TPZ6BsZsRgisAbQPUXBtQYbNYGxP
 1sAqcw8rsk75+aSfZuHqBFXIzDS3madg5JeH/hIDtmYEph3tiKjGLE/ZYOZQByU1oTFe02fi
 aJov1LqkhbA9lC4+poPAZKV/xw8=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5fcfa44e6ec7ce143600b6ca (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 08 Dec 2020 16:05:34
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D55ABC43461; Tue,  8 Dec 2020 16:05:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EF9D0C433C6;
        Tue,  8 Dec 2020 16:05:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EF9D0C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Xiaohui Zhang <ruc_zhangxiaohui@163.com>
Cc:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] mwifiex: Fix possible buffer overflows in mwifiex_uap_bss_param_prepare
References: <20201208154343.6946-1-ruc_zhangxiaohui@163.com>
Date:   Tue, 08 Dec 2020 18:05:28 +0200
In-Reply-To: <20201208154343.6946-1-ruc_zhangxiaohui@163.com> (Xiaohui Zhang's
        message of "Tue, 8 Dec 2020 23:43:43 +0800")
Message-ID: <87r1o0cmgn.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Xiaohui Zhang <ruc_zhangxiaohui@163.com> writes:

> From: Zhang Xiaohui <ruc_zhangxiaohui@163.com>
>
> mwifiex_uap_bss_param_prepare() calls memcpy() without checking
> the destination size may trigger a buffer overflower,
> which a local user could use to cause denial of service or the
> execution of arbitrary code.
> Fix it by putting the length check before calling memcpy().
>
> Signed-off-by: Zhang Xiaohui <ruc_zhangxiaohui@163.com>

When you submit a new version mark it as v2:

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches#patch_version_missing

But this is just for the future, no need to resend because of this.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
