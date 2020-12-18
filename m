Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 614CA2DDE07
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Dec 2020 06:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbgLRF1k (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Dec 2020 00:27:40 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:19171 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbgLRF1j (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Dec 2020 00:27:39 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1608269236; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=TDNiaVMOFoCnxwVGcj/R5FSJ1oq2holdQERjw39ulbU=; b=BqoBDIwfq7J1ng6+5kDpa3LQ8czFRwlAF1VOkJuxsxsY7MrHHmgea3PCJjp1fOCH2ecPOgjA
 iAKttJzfK1Tli4N8Jmy5/91u+6SBApRDXb1Ugd7a9jzE9s7MfxR4EVTD3pyFk1eFMmMZhqiw
 MjRgKjBAg9D149LDCZf80c/EkBY=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-west-2.postgun.com with SMTP id
 5fdc3d97065be8d8354e48ac (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 18 Dec 2020 05:26:47
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C3C64C433CA; Fri, 18 Dec 2020 05:26:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from x230.qca.qualcomm.com (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3856CC433CA;
        Fri, 18 Dec 2020 05:26:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3856CC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/2] mt76: usb: remove wake logic in mt76u_status_worker
References: <cover.1607164041.git.lorenzo@kernel.org>
        <00009bf0cfdc9565e4432cad3ed51888c667c25d.1607164041.git.lorenzo@kernel.org>
        <20201217191017.GG16606@lore-desk>
Date:   Fri, 18 Dec 2020 07:26:42 +0200
In-Reply-To: <20201217191017.GG16606@lore-desk> (Lorenzo Bianconi's message of
        "Thu, 17 Dec 2020 20:10:17 +0100")
Message-ID: <87blerhegd.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo.bianconi@redhat.com> writes:

>> Similar to mmio code path, remove wake logic in mt76u_status_worker
>> handler
>
> Starting from commit '90d494c99a99fa2eb858754345c4a9c851b409a0
> ("mt76: improve tx queue stop/wake")', the wake queue logic on
> the usb status path is no longer necessary since the hw queues
> are no longer stopped on the mt76 tx path.

Thanks, I'll update the commit logs based on the info you provided.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
