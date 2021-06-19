Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D71743AD8B3
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Jun 2021 10:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233336AbhFSIvG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 19 Jun 2021 04:51:06 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:48356 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbhFSIvF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 19 Jun 2021 04:51:05 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1624092535; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=ihDIZulanQz94DPDBMQtNnxkLQ2Co8HobZZ7B68JgRc=; b=XiuTsF6DlPezIHkQUBnkZj3/GfmJbaiY8EcF+JPDMSrDZ1OEGQ0WOoiGLeqh6U/KXYu8KuXI
 OkyV/kEBNa5xPDSWCKuQVnYLdRxW2aXzRlk5eydkQCqTl8O+L0qfqfHTwyc6q0XyHaGLH1Nd
 vZGmaDnNTMrN8arJAC5FTU986YY=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 60cdaf63e570c0561945e994 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 19 Jun 2021 08:48:35
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0F19CC433D3; Sat, 19 Jun 2021 08:48:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D5511C433F1;
        Sat, 19 Jun 2021 08:48:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D5511C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Zekun Shen <bruceshenzk@gmail.com>
Cc:     ath9k-devel@qca.qualcomm.com,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] ath9k: fix OOB read ar9300_eeprom_restore_internal
References: <YM1ajkPk+7ve4Ls9@Zekuns-MBP-16.fios-router.home>
Date:   Sat, 19 Jun 2021 11:48:27 +0300
In-Reply-To: <YM1ajkPk+7ve4Ls9@Zekuns-MBP-16.fios-router.home> (Zekun Shen's
        message of "Fri, 18 Jun 2021 22:46:38 -0400")
Message-ID: <87a6nmi6jo.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

+ linux-wireless

Zekun Shen <bruceshenzk@gmail.com> writes:

> Bad header can have large length field which can cause OOB.
> cptr is the last bytes for read, and the eeprom is parsed
> from high to low address. The OOB, triggered by the condition
> length > cptr could cause memory error with a read on
> negative index.
>
> There are some sanity check around length, but it is not
> compared with cptr (the remaining bytes). Here, the
> corrupted/bad EEPROM can cause panic.
>
> I was able to reproduce the crash, but I cannot find the
> log and the reproducer now. After I applied the patch, the
> bug is no longer reproducible.
>
> Signed-off-by: Zekun Shen <bruceshenzk@gmail.com>

Please resubmit and cc linux-wireless list, otherwise patchwork won't
see the patch and then it will be out of my radar.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
