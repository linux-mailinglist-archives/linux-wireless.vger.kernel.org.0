Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D81762777E1
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Sep 2020 19:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbgIXRd1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Sep 2020 13:33:27 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:54620 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728719AbgIXRd1 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Sep 2020 13:33:27 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600968806; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=/UcSTuBdPIozzV0z9q1iZpMD1y335vSnNUyRQrsl4B4=; b=LjH2ugO6nQ8G5W8g3MYke1MWbrw02t9902gsU8LjD5zdw2ge/3fm8DXzMGo/8g0g+M3NGQq6
 j0zeSJC/K/TSIKAVu9IaL60FvBJRnKZbSpQ0Pern0pVxYM7ebNAsS3YKuYDgdPf0C0T/7Xni
 XmsY1qxiB7fx/kc822G4lWzg84A=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5f6cd85db51786209ce8f687 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 24 Sep 2020 17:33:17
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 56F25C433CB; Thu, 24 Sep 2020 17:33:17 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2160BC433CA;
        Thu, 24 Sep 2020 17:33:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2160BC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/7] iwlwifi: enable twt by default
References: <20200924132339.337310-1-luca@coelho.fi>
        <iwlwifi.20200924162105.c12a9b75da6b.I181fc5c80988e7ecea281c60e57a22ae7ec86716@changeid>
Date:   Thu, 24 Sep 2020 20:33:13 +0300
In-Reply-To: <iwlwifi.20200924162105.c12a9b75da6b.I181fc5c80988e7ecea281c60e57a22ae7ec86716@changeid>
        (Luca Coelho's message of "Thu, 24 Sep 2020 16:23:33 +0300")
Message-ID: <87mu1fkrl2.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> writes:

> From: Golan Ben Ami <golan.ben.ami@intel.com>
>
> In a previous patch, a flag for disabling twt by a dbg-cfg
> was added. This will be useful for disabling twt on specific
> cores, after branch-out.
> However, we'd like twt to be enabled on master.
>
> So, enable twt on master.

What's master in this context? AP mode?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
