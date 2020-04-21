Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3AF1B2689
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2020 14:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbgDUMlv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Apr 2020 08:41:51 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:52963 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728769AbgDUMlt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Apr 2020 08:41:49 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587472909; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=5iR0UPoX5uDBVDbRaHJQlQd7bZARXqz8f01ic3ktvcE=;
 b=j9iYXhHxtzhvFMBNgITyq8lNJ2V87/MwL/jTi6IKjayPyktdktou8Kxdv5v4pKwtPyBoycG3
 oCLsH8anZAqMI3awnjr1S4pvpZON56io3izPrP0XTQMPbVgLbdgYHF7EwOLhUN8p7ZEWXnR3
 QwgolXEn2yFFHEb331XM9bLVrjQ=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e9ee9f1.7f2107cffb20-smtp-out-n04;
 Tue, 21 Apr 2020 12:41:21 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 742CAC432C2; Tue, 21 Apr 2020 12:41:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1C11EC43637;
        Tue, 21 Apr 2020 12:41:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1C11EC43637
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] MAINTAINERS: update mt76 reviewers
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <c171e0dfce9f2dad5ca6935eaf6004117f82e259.1587195398.git.ryder.lee@mediatek.com>
References: <c171e0dfce9f2dad5ca6935eaf6004117f82e259.1587195398.git.ryder.lee@mediatek.com>
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Roy Luo <royluo@google.com>, <linux-wireless@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200421124121.742CAC432C2@smtp.codeaurora.org>
Date:   Tue, 21 Apr 2020 12:41:21 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ryder Lee <ryder.lee@mediatek.com> wrote:

> Roy no longer works here. Time to say goodbye, my friend.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>

Patch applied to wireless-drivers.git, thanks.

10e41f34a019 MAINTAINERS: update mt76 reviewers

-- 
https://patchwork.kernel.org/patch/11496333/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
