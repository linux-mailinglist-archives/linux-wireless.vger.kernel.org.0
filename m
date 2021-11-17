Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE154541D6
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Nov 2021 08:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233429AbhKQHcK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 Nov 2021 02:32:10 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:32284 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233408AbhKQHcK (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 Nov 2021 02:32:10 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1637134152; h=Date: Message-ID: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=9RotHWo70qAVeRv22J1y8hVciT3lLoohC0G1xXpqzcE=;
 b=Y6kagOjeK5CbqrUSepwNnZgZjkkA7z7Au3yyM/vgSn92oRrQJabJGtp76gPdv+ECGJjuNqEe
 BufKPF/7IWpoJA0vCTMVfX1yWVeMkr2AWpBMvQ8kAK82qo45RGfScUSet+Tc1xToG9fhgEZ2
 OMqjJK7j++gcZJmiz9szrHuaN+A=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 6194af47665450d43aedf8cf (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 17 Nov 2021 07:29:11
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EC803C4360D; Wed, 17 Nov 2021 07:29:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 93E20C4338F;
        Wed, 17 Nov 2021 07:29:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 93E20C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: Add missing qmi_txn_cancel()
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1635857558-21733-1-git-send-email-akolli@codeaurora.org>
References: <1635857558-21733-1-git-send-email-akolli@codeaurora.org>
To:     Anilkumar Kolli <akolli@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Anilkumar Kolli <akolli@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163713414745.31320.12579939812980458629.kvalo@codeaurora.org>
Date:   Wed, 17 Nov 2021 07:29:10 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Anilkumar Kolli <akolli@codeaurora.org> wrote:

> Currently many functions do not follow this guidance when
> qmi_send_request() fails, therefore add missing
> qmi_txn_cancel() in the qmi_send_request() error path.
> 
> Also remove initialization on 'struct qmi_txn'
> since qmi_tx_init() performs all necessary initialization.
> 
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.4.0.1-01838-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

1ad6e4b00f29 ath11k: Add missing qmi_txn_cancel()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1635857558-21733-1-git-send-email-akolli@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

