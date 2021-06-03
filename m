Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD08399DF6
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Jun 2021 11:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbhFCJoe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Jun 2021 05:44:34 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:48804 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229506AbhFCJod (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Jun 2021 05:44:33 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1622713369; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=uZn3pbE3U1wchG9C0u/HMA/pIOrVIBEJ04QKPe/a3sg=; b=arQ0831b3Ws8fj3IglWQ86eSNjdSgSSdWzybBd0TcZwHT5Cx3kj4IoWqsFMJbmAaAx3eAlu2
 KwfWSf3vqTvESt91isSNBP6Hl+adTXeANjay2qMlaMG6xbh6XjZyX86aXU83rRG1pWErhp0P
 hthHnJuTzODQIJpk6H90Ni/y1OE=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 60b8a40d8491191eb3d00f9c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 03 Jun 2021 09:42:37
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6A992C433D3; Thu,  3 Jun 2021 09:42:37 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 87FA9C433D3;
        Thu,  3 Jun 2021 09:42:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 87FA9C433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, sean.wang@mediatek.com
Subject: Re: [PATCH v2 5.13] mt76: mt7615: do not set MT76_STATE_PM at bootstrap
References: <e5a2618574007113d844874420f7855891abf167.1621085028.git.lorenzo@kernel.org>
        <YLJEgzafftYq7JBg@lore-desk>
Date:   Thu, 03 Jun 2021 12:42:33 +0300
In-Reply-To: <YLJEgzafftYq7JBg@lore-desk> (Lorenzo Bianconi's message of "Sat,
        29 May 2021 15:41:23 +0200")
Message-ID: <87h7if1dyu.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> writes:

>> Remove MT76_STATE_PM in mt7615_init_device() and introduce
>> __mt7663s_mcu_drv_pmctrl for fw loading in mt7663s.
>> This patch fixes a crash at bootstrap for device (e.g. mt7622) that do
>> not support runtime-pm
>> 
>> Fixes: 7f2bc8ba11a0 ("mt76: connac: introduce wake counter for
>> fw_pmctrl synchronization")
>> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>
> Hi Kalle,
>
> any news about this patch?

Should be in wireless-drivers now.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
