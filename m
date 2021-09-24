Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9D5341773C
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Sep 2021 17:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346968AbhIXPHD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Sep 2021 11:07:03 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:20110 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346921AbhIXPHC (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Sep 2021 11:07:02 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1632495929; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=eyMGPHcaqJ0znG866UUp+BkYa+NlLIG6yFmlgPsLFiw=; b=kUTSnFCwmKMXL/GA4lnLqUt9iwgVMPle2kROeTrErKRjTVd3ru88SqtBxnwwxkCfuMvSMcKs
 jOPqifP2DqMfSggzrwQrI4pulSDWNpNUYNMRDeQ122eI8U9FuYzyarr0lAjlBXdSYZ5xg8x6
 JDPjM1Xm8AuG/DvykGmPAu4kaRY=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 614de91874211e7d6420c714 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 24 Sep 2021 15:04:56
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C43ECC4360D; Fri, 24 Sep 2021 15:04:55 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 05F91C4338F;
        Fri, 24 Sep 2021 15:04:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 05F91C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Jouni Malinen <jouni@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Anilkumar Kolli <akolli@codeaurora.org>
Subject: Re: [PATCH 4/4] ath11k: add caldata download support from EEPROM
References: <20210721201927.100369-1-jouni@codeaurora.org>
        <20210721201927.100369-5-jouni@codeaurora.org>
Date:   Fri, 24 Sep 2021 18:04:50 +0300
In-Reply-To: <20210721201927.100369-5-jouni@codeaurora.org> (Jouni Malinen's
        message of "Wed, 21 Jul 2021 23:19:27 +0300")
Message-ID: <875yuqrp4d.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jouni Malinen <jouni@codeaurora.org> writes:

> From: Anilkumar Kolli <akolli@codeaurora.org>
>
> Firmware updates EEPROM support capability in QMI FW caps, send QMI BDF
> download request message with file type EEPROM, to get caldata download
> from EEPROM. Firmware takes more time to update cal data from EEPROM, so
> increase QMI timeout.

The commit log would need more explanation how this patch works.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
