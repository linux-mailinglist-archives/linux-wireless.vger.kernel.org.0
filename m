Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8F833230A
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Mar 2021 11:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbhCIK3D (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Mar 2021 05:29:03 -0500
Received: from m42-2.mailgun.net ([69.72.42.2]:57441 "EHLO m42-2.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229951AbhCIK3A (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Mar 2021 05:29:00 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1615285740; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=sB7cCEuMvHrtjL8oFz1GX7XYdpwuB1QICugYYTo73us=; b=Rr+5AMP5UTNZqCzD2xuKJn/9G9gwIwMRhw3frWisForNrb+VXPNKAUJAOUnJNAo2eqD6XVrz
 vsoI8vGlBDjla5tCrCY6ulTMs0/hQ1NOP2+jDXwKHGKmmjbnUtJ44exu/q04p9/5dHfFE0js
 Lp647jhlnmNC8umigbO7mVVwbF4=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 60474dd5106ec1d9068c366c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 09 Mar 2021 10:28:37
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D810DC43466; Tue,  9 Mar 2021 10:28:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2E3F6C433CA;
        Tue,  9 Mar 2021 10:28:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2E3F6C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        nbd@nbd.name, sean.wang@mediatek.com, leon.yen@mediatek.com
Subject: Re: [PATCH wireless-drivers] mt76: mt7921: fix airtime reporting
References: <c05333be0e3e85a50a71bb2de81034fe425e3701.1615284335.git.lorenzo@kernel.org>
Date:   Tue, 09 Mar 2021 12:28:32 +0200
In-Reply-To: <c05333be0e3e85a50a71bb2de81034fe425e3701.1615284335.git.lorenzo@kernel.org>
        (Lorenzo Bianconi's message of "Tue, 9 Mar 2021 11:09:03 +0100")
Message-ID: <87wnugzkmn.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> writes:

> Fix {tx,rx}_airtime reporting for mt7921 driver. Wrong register definitions
> trigger a tx hangs before resetting airtime stats.
>
> Fixes: 163f4d22c118d ("mt76: mt7921: add MAC support")
> Tested-by: Leon Yen <leon.yen@mediatek.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

I'll queue this to v5.12 and assigned to me on patchwork. Felix, ack?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
