Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD2E1FAC15
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jun 2020 11:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725896AbgFPJNL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Jun 2020 05:13:11 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:50073 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728044AbgFPJNI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Jun 2020 05:13:08 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592298786; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=OgDBzqqrEPPmIa2KUj3HnyS1zXMXu3Jcgi9sskDBZ9k=; b=BxpTwzVypvWKsh1EZxfEsCm25hYn+MJ4jtuF4FKb91pFMsJ/J4jVAcGx3q5uBNEKhqBaDXCs
 AsbL7tM8+3lmvZQvWN0h4n32Yj78XerXpzSU5l3kZ/W3/pbh7Qt4A0FbtEt0plcKvnRlXuBb
 Ldc1aY0cJILS4Ua+Kgs9qMiP6rs=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5ee88d214c9690533a25dbc4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 16 Jun 2020 09:13:05
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D7678C433CB; Tue, 16 Jun 2020 09:13:04 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5B920C433CA;
        Tue, 16 Jun 2020 09:13:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5B920C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Anilkumar Kolli <akolli@codeaurora.org>
Cc:     ath11k@lists.infradead.org, devicetree@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2 0/8] ath11k: Add IPQ6018 support
References: <1591709581-18039-1-git-send-email-akolli@codeaurora.org>
Date:   Tue, 16 Jun 2020 12:13:01 +0300
In-Reply-To: <1591709581-18039-1-git-send-email-akolli@codeaurora.org>
        (Anilkumar Kolli's message of "Tue, 9 Jun 2020 19:02:53 +0530")
Message-ID: <87pn9zidb6.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Anilkumar Kolli <akolli@codeaurora.org> writes:

> IPQ6018 has a 5G radio and 2G radio with 2x2
> and shares IPQ8074 configuration.
>
> Tested on: IPQ6018 WLAN.HK.2.2-02134-QCAHKSWPL_SILICONZ-1
> Tested on: IPQ8074 WLAN.HK.2.4.0.1-00009-QCAHKSWPL_SILICONZ-1 

To get the multiple hw support faster in (I need them also for QCA6390
patches) I split this into multiple sets:

>   ath11k: update firmware files read path
>   ath11k: rename default board file

These are now applied.

>   ath11k: define max_radios in hw_params
>   ath11k: add hw_ops for pdev id to hw_mac mapping
>   ath11k: Add bdf-addr in hw_params

I'll modify these a bit, remove all IPQ6018 references from them and
then submit them myself.

>   dt: bindings: net: update compatible for ath11k
>   ath11k: add ce services for IPQ6018

Anil, please resubmit these as v3 based on the comments.

>   ath11k: add IPQ6018 support

Anil, add this as the last patch in your v3 series. And do note that I
will split the part adding ath11k_init_hw_params() function to a
separate patch, so no need to include it in this patch anymore.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
