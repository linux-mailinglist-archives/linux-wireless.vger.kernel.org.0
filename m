Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C379A1E817F
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2020 17:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgE2PSq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 May 2020 11:18:46 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:62589 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbgE2PSp (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 May 2020 11:18:45 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590765524; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=8MkArqelu6rqd2Rvi+97NN/iHBrB59zyrr/FjHzHabw=; b=hW5CCFhKSmkNU9cx5Foy5Tw8sr9Eq84SyvEP/PCYSe+IRqRuwDZqfUa0xO33yu47ahrR+WD4
 QuyUBgItElbhkP+OOiYpnqtxNFitIDyYXX+/ifWWKX0ps/AD4noXjQ7939o2rsUB+XQmoxEt
 wyLUNNwABPt2syGujBSKtpg6tMs=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5ed127c03131442d95037cb8 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 29 May 2020 15:18:24
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5F30CC433CB; Fri, 29 May 2020 15:18:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2CBB7C433C6;
        Fri, 29 May 2020 15:18:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2CBB7C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     yhchuang@realtek.com, linux-wireless@vger.kernel.org,
        tehuang@realtek.com, oliver.sang@intel.com
Subject: Re: [PATCH] rtw88: 8822c: fix missing brace warning for old compilers
References: <20200522035521.12295-1-yhchuang@realtek.com>
        <20200528183911.zbnhfdexehur4wby@linutronix.de>
Date:   Fri, 29 May 2020 18:18:19 +0300
In-Reply-To: <20200528183911.zbnhfdexehur4wby@linutronix.de> (Sebastian
        Andrzej Siewior's message of "Thu, 28 May 2020 20:39:11 +0200")
Message-ID: <87o8q6srb8.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> On 2020-05-22 11:55:21 [+0800], yhchuang@realtek.com wrote:
>> From: Yan-Hsuan Chuang <yhchuang@realtek.com>
>> 
>> For older versions of gcc, the array = {0}; will cause warnings:
>
> I wouldn't say older. I have here 9.3.0 and it does create the same
> warning.

Yeah, and usually it's best to specify the exact compiler version. "old"
and "new" are very relative terms :)

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
