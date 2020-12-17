Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9ADD2DD54B
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Dec 2020 17:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbgLQQeO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Dec 2020 11:34:14 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:28665 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727160AbgLQQeO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Dec 2020 11:34:14 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1608222833; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=U81S4lGZDzFvSKlS0bCje3dnH/HYDDF8KbNWK/FqHEo=;
 b=GixBkWis+BVNUZmQO5OFymrU7XJLmmzeIRPOk5cO6aJ4hKW3+VRuArpvxdn4PfZ+59GpqSX1
 CG3m/OcqthUaDGAjOJjsAZAb0ytNJrccYMpiBqN/Bw7xZHLCmJYoDrP4STO5W6eYHMk3Elwk
 UGdTOxP5j6Z1Y+j58R7RLibRKfg=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5fdb884d253011a4b8106582 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 17 Dec 2020 16:33:17
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7C64DC433CA; Thu, 17 Dec 2020 16:33:16 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D00F4C433C6;
        Thu, 17 Dec 2020 16:33:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D00F4C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] drivers/net: fix a null-ptr-deref bug in
 drivers/net/wireless/marvell/mwifiex/uap_txrx.c
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20201209132640.36031-1-tzh18@mails.tsinghua.edu.cn>
References: <20201209132640.36031-1-tzh18@mails.tsinghua.edu.cn>
To:     tangzhenhao <tzh18@mails.tsinghua.edu.cn>
Cc:     linux-wireless@vger.kernel.org, amitkarwar@gmail.com,
        tangzhenhao <tzh18@mails.tsinghua.edu.cn>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201217163316.7C64DC433CA@smtp.codeaurora.org>
Date:   Thu, 17 Dec 2020 16:33:16 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tangzhenhao <tzh18@mails.tsinghua.edu.cn> wrote:

> At line 257 in drivers/net/wireless/marvell/mwifiex/uap_txrx.c, the ret-val of skb_copy should be checked to avoid null-ptr-deref bug.
> 
> Signed-off-by: tangzhenhao <tzh18@mails.tsinghua.edu.cn>

The title does not use the correct format and the commit log is not word
wrapped.

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20201209132640.36031-1-tzh18@mails.tsinghua.edu.cn/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

