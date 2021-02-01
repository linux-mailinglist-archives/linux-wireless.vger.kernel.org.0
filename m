Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 743BB30AF14
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Feb 2021 19:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbhBASXi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 1 Feb 2021 13:23:38 -0500
Received: from so15.mailgun.net ([198.61.254.15]:40722 "EHLO so15.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232039AbhBASXL (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 1 Feb 2021 13:23:11 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1612203759; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=D5j2d0ccVJEiALSsLxaiQwPqUhJiQ8uL4wmsXcm8le0=;
 b=tpLupgAKbvqgtNCKS5XXgqnB/kKPxV2zgh/xa4ngPLX4h+2sMaatBDbvqaHbYZ19/oYtYPR2
 VTbVOX1zfy3TKFNql0p8sUGwdiqvbJEdTKwMlfiQNi+B8ueEM08VoZ78exmBHbUDOluBj9Jx
 b1RfAHbF2ssNgcFcjdgf6SGrOBw=
X-Mailgun-Sending-Ip: 198.61.254.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 601846d22d8ee3f99f029f6c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 01 Feb 2021 18:22:10
 GMT
Sender: alokad=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 529E6C43466; Mon,  1 Feb 2021 18:22:09 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: alokad)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 79121C43461;
        Mon,  1 Feb 2021 18:22:08 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 01 Feb 2021 10:22:08 -0800
From:   Aloka Dixit <alokad@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, John Crispin <john@phrozen.org>,
        Lavanya Suresh <lavaks@codeaurora.org>,
        ath11k@lists.infradead.org, kvalo=codeaurora.org@codeaurora.org
Subject: Re: [PATCH V6] ath11k: add multiple bssid support
In-Reply-To: <874kj3bo65.fsf@codeaurora.org>
References: <20210120003221.21984-1-alokad@codeaurora.org>
 <874kj3bo65.fsf@codeaurora.org>
Message-ID: <7b36901091429419209653f1be21cce1@codeaurora.org>
X-Sender: alokad@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-01-26 09:31, Kalle Valo wrote:
> Aloka Dixit <alokad@codeaurora.org> writes:
> 
>> From: John Crispin <john@phrozen.org>
>> 
>> Add the required wmi support and make use of it in the beacon template
>> code. We need to split the beacon code up into 2 code paths so that
>> we can also send EMA templates.
>> 
>> Tested-on: IPQ8074 hw2.0 AHB 
>> WLAN.HK.2.4.0.1-01492-QCAHKSWPL_SILICONZ-1
>> 
>> Signed-off-by: John Crispin <john@phrozen.org>
>> Signed-off-by: Lavanya Suresh <lavaks@codeaurora.org>
>> Signed-off-by: Aloka Dixit <alokad@codeaurora.org>
> 
> Please CC ath11k list with ath11k patches.
> 
>> base-commit: be8cd9b8f5ed435c27530430aa1b1da30f9825d5
>> prerequisite-patch-id: 1c9127eb0d6efce75a0aa085527bf81ced427387
>> prerequisite-patch-id: 41af1c46bdedfa8768dd4205bb0647101de27dea
>> prerequisite-patch-id: f197607d75899cbecffd775e1ca243aa2fe082d0
>> prerequisite-patch-id: 55dad75c4f560213110f57f1abf24d9b7301a1b2
> 
> This fails to compile for me, what are these prerequisite patches?

The prerequisites are these: 
https://patchwork.kernel.org/project/linux-wireless/list/?series=417275
Compilation shouldn't have failed though. Once these are accepted, will 
send rebased version for ath11k.
Thanks.
