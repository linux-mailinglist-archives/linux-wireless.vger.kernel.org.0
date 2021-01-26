Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D276C304C7A
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Jan 2021 23:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729809AbhAZWpT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Jan 2021 17:45:19 -0500
Received: from m42-8.mailgun.net ([69.72.42.8]:55962 "EHLO m42-8.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727884AbhAZRc1 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Jan 2021 12:32:27 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1611682320; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=qd8eFHF9sahtxnasGHzr+j1A6XXP+KsTxTl3+ooZsMk=; b=X3v6G6UF03L6JIowRGDv0NX/pMMRE1/5q6PM2+ASd7HM8JITzjW4T1UTxO2rCbBeLtD+2cV2
 C0007m0JB95j4FuhATAMvhqBU2iLLQZ6yYxsnqmOC3VWUFtBAaXKMmKL/dY6QySMKlbaygK6
 aT40hpTwhRPm4+6QpRbwoXU+WA0=
X-Mailgun-Sending-Ip: 69.72.42.8
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 601051e7ad4c9e395bde4e30 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 26 Jan 2021 17:31:19
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 129AFC43461; Tue, 26 Jan 2021 17:31:19 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CCD7AC433CA;
        Tue, 26 Jan 2021 17:31:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CCD7AC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Aloka Dixit <alokad@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, John Crispin <john@phrozen.org>,
        Lavanya Suresh <lavaks@codeaurora.org>,
        ath11k@lists.infradead.org
Subject: Re: [PATCH V6] ath11k: add multiple bssid support
References: <20210120003221.21984-1-alokad@codeaurora.org>
Date:   Tue, 26 Jan 2021 19:31:14 +0200
In-Reply-To: <20210120003221.21984-1-alokad@codeaurora.org> (Aloka Dixit's
        message of "Tue, 19 Jan 2021 16:32:21 -0800")
Message-ID: <874kj3bo65.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Aloka Dixit <alokad@codeaurora.org> writes:

> From: John Crispin <john@phrozen.org>
>
> Add the required wmi support and make use of it in the beacon template
> code. We need to split the beacon code up into 2 code paths so that
> we can also send EMA templates.
>
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-01492-QCAHKSWPL_SILICONZ-1
>
> Signed-off-by: John Crispin <john@phrozen.org>
> Signed-off-by: Lavanya Suresh <lavaks@codeaurora.org>
> Signed-off-by: Aloka Dixit <alokad@codeaurora.org>

Please CC ath11k list with ath11k patches.

> base-commit: be8cd9b8f5ed435c27530430aa1b1da30f9825d5
> prerequisite-patch-id: 1c9127eb0d6efce75a0aa085527bf81ced427387
> prerequisite-patch-id: 41af1c46bdedfa8768dd4205bb0647101de27dea
> prerequisite-patch-id: f197607d75899cbecffd775e1ca243aa2fe082d0
> prerequisite-patch-id: 55dad75c4f560213110f57f1abf24d9b7301a1b2

This fails to compile for me, what are these prerequisite patches?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
