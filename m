Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA54381660
	for <lists+linux-wireless@lfdr.de>; Sat, 15 May 2021 08:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbhEOGmi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 15 May 2021 02:42:38 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:32206 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbhEOGmg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 15 May 2021 02:42:36 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1621060884; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=6lvZfHptDjPNIatHZ6MPf+k2JUFdYVXsnmeeKxDTuaQ=;
 b=Qum0GTGYbBdiSbiu4t9HcrADPva59wigldOcWRnd7FJ/jFaJy5pYrMqNQAXBIXFeLOsSZTvF
 6wbmb7xY1c5DhiqFf+T5k7lvNmB5O7pbwqq7HPud2RhTLw/oUG1CeM+XetJ5WrXc6CooGV/g
 etBcYcESQTPvI7beXj9Z4MLru0M=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 609f6d0f60c53c8c9d74ba38 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 15 May 2021 06:41:19
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CCE4FC4323A; Sat, 15 May 2021 06:41:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EBC28C433F1;
        Sat, 15 May 2021 06:41:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EBC28C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/3] mt76: connac: do not schedule wake_work if the
 runtime-pm
 is disabled
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <aad9ade1a25f45084cbc2aa66e5ff9a268043ff3.1619187875.git.lorenzo@kernel.org>
References: <aad9ade1a25f45084cbc2aa66e5ff9a268043ff3.1619187875.git.lorenzo@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, sean.wang@mediatek.com
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210515064118.CCE4FC4323A@smtp.codeaurora.org>
Date:   Sat, 15 May 2021 06:41:18 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Fix the following crash due to a call to mt7921_pm_wake_work if the
> device has pm disabled or does not support runtime-pm
> 
> [    8.412590] mt7921e 0000:01:00.0: HW/SW Version: 0x8a108a10, Build
> [    8.413660] WARNING: CPU: 0 PID: 20 at __queue_delayed_work+0x84/0xb0
> [    8.481831] CPU: 0 PID: 20 Comm: kworker/u4:1 Not tainted 5.10.31 #0
> [    8.488175] Hardware name: MediaTek MT7622 RFB1 board (DT)
> [    8.493663] Workqueue: mt76 mt7921_pm_wake_work [mt7921e]
> [    8.499055] pstate: 60000085 (nZCv daIf -PAN -UAO -TCO BTYPE=--)
> [    8.505052] pc : __queue_delayed_work+0x84/0xb0
> [    8.509574] lr : queue_delayed_work_on+0x54/0x78
> [    8.514180] sp : ffffffc010bcbd20
> [    8.517485] x29: ffffffc010bcbd20 x28: 0000000000000000
> [    8.522790] x27: ffffff800015a148 x26: ffffffc0108acae0
> [    8.528094] x25: 0000000000000000 x24: ffffff80056b4208
> [    8.533399] x23: ffffff80056b26e0 x22: ffffff80056b26e0
> [    8.538703] x21: ffffff80056b45f8 x20: ffffff80056b5dc8
> [    8.544006] x19: 0000000000000000 x18: 000000000000000e
> [    8.549310] x17: 0000000000000001 x16: 0000000000000019
> [    8.554614] x15: 0000000000000033 x14: ffffffffffffffff
> [    8.559919] x13: ffffffffffffffff x12: 0000000000000000
> [    8.565223] x11: 0000000000000040 x10: 0000000000000820
> [    8.570528] x9 : 0000b3c738feafd6 x8 : ffffff801feb7c80
> [    8.575832] x7 : ffffff80056b4808 x6 : 0000000000000000
> [    8.581136] x5 : ffffff80056b2888 x4 : 0000000fffffffe0
> [    8.586441] x3 : 000000000000003e x2 : ffffff80056b2868
> [    8.591745] x1 : 0000000000000000 x0 : 0000000000000002
> [    8.597049] Call trace:
> [    8.599488]  __queue_delayed_work+0x84/0xb0
> [    8.603662]  queue_delayed_work_on+0x54/0x78
> [    8.607947]  ieee80211_queue_delayed_work+0x30/0x50 [mac80211]
> [    8.613774]  mt7921_pm_wake_work+0xa0/0xe0 [mt7921e]
> [    8.618730]  process_one_work+0x1fc/0x398
> [    8.622730]  worker_thread+0x150/0x4e0
> [    8.626472]  kthread+0x120/0x128
> [    8.629693]  ret_from_fork+0x10/0x18
> 
> Fixes: 129fac01ffe85 ("mt76: connac: introduce wake counter for fw_pmctrl synchronization")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Dropped patch 2 per Lorenzo's request.

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/aad9ade1a25f45084cbc2aa66e5ff9a268043ff3.1619187875.git.lorenzo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

