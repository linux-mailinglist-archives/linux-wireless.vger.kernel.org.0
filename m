Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFCE3FA9EA
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Aug 2021 09:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbhH2H1B (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 29 Aug 2021 03:27:01 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:52910 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230378AbhH2H1B (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 29 Aug 2021 03:27:01 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1630221969; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=7fOdjc2r5ctsDwNXSlMXstbqU5bH1F/XDd/EzEWJyGE=;
 b=WuHn1neKP70QRMXxe2dC9JosrN8ozuvcMmfV+yaSGjKJyqh5vcwRBJHqqECnKPQXV7b9Y65e
 6mSRQ/0tHKrGhOQ5YMvu2W6EfrPAifn0ZoI/F66fGKSnRG0hV1P6KU3hVHgdN38/yPg2EbJ7
 62STPKqb075hjrjGu3ZNwujMJpA=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 612b368940d2129ac1a26101 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 29 Aug 2021 07:26:01
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E5F5EC43616; Sun, 29 Aug 2021 07:26:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL autolearn=no autolearn_force=no
        version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2C8CCC4338F;
        Sun, 29 Aug 2021 07:25:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 2C8CCC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [v3] rtw88: add quirk to disable pci caps on HP Pavilion
 14-ce0xxx
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210822194932.29630-1-Larry.Finger@lwfinger.net>
References: <20210822194932.29630-1-Larry.Finger@lwfinger.net>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     linux-wireless@vger.kernel.org,
        =?utf-8?q?Ugo_R=C3=A9mery?= <ugo.remery@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210829072600.E5F5EC43616@smtp.codeaurora.org>
Date:   Sun, 29 Aug 2021 07:26:00 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Larry Finger <Larry.Finger@lwfinger.net> wrote:

> From: Ugo Rémery <ugo.remery@gmail.com>
> 
> 8821CE causes random freezes on HP Pavilion 14-ce0019nf. Add a quirk
> to disable pci ASPM capability.
> 
> Signed-off-by: Ugo Rémery <ugo.remery@gmail.com>
> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>

Patch applied to wireless-drivers-next.git, thanks.

1d4dcaf3db9b rtw88: add quirk to disable pci caps on HP Pavilion 14-ce0xxx

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210822194932.29630-1-Larry.Finger@lwfinger.net/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

