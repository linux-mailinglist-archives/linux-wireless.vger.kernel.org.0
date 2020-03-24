Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA13190D59
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2020 13:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbgCXMZs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Mar 2020 08:25:48 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:25717 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727332AbgCXMZs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Mar 2020 08:25:48 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1585052747; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=MBBxdSu+v22AOGbX7PgfT+8mNtaVMqonw+j86vVTlyA=; b=twM3VCWbjG4Aln1YS9tmBz+EsuCGHpvrxFyFdhmDJUEFh26/gem8ppjtRRv3eRhSRZ1mfQON
 muh0F0gNePEH9qQTX3/gGZT+3V/3BqnMFjsMU4DdSc83x2HeBE28K9zK8LuyVH+LkVkv/9+O
 y0LCaON5tO94aVagofN+ue5TBWY=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e79fc3f.7fab05150e30-smtp-out-n05;
 Tue, 24 Mar 2020 12:25:35 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6DC3DC433D2; Tue, 24 Mar 2020 12:25:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 01E4DC433CB;
        Tue, 24 Mar 2020 12:25:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 01E4DC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
Subject: Re: [PATCH v2] ath10k: add retry mechanism for ath10k_start
References: <20200120025609.6060-1-wgong@codeaurora.org>
        <87mu9mwwhs.fsf@kamboji.qca.qualcomm.com>
        <576c72fed4a15a13989dde163d77ed8c@codeaurora.org>
Date:   Tue, 24 Mar 2020 14:25:30 +0200
In-Reply-To: <576c72fed4a15a13989dde163d77ed8c@codeaurora.org> (Wen Gong's
        message of "Fri, 14 Feb 2020 10:41:52 +0800")
Message-ID: <877dza7xdx.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> writes:

> On 2020-02-13 19:35, Kalle Valo wrote:
>>
>> I'm not convinved about this. ath10k assumes that SDIO bus works
>> reliably and there's no data loss. In my opinion if the SDIO is not
>> working reliably we should fail immediately with a clear error message
>> for the user, instead of having an unstable connection. And I
>> understand
>> from the logs that ath10k fails cleanly in this simulated failure.
>>
>> So what you do here is ignore the assumption that the SDIO bus should
>> always work reliably and add a workaround by trying to restart the
>> firmware multiple times, and hope that by luck it works during one
>> of 10
>> retry attempts. But then what? Isn't the WLAN connection flaky as SDIO
>> bus is not reliable? So if we were to follow that design logic,
>> shouldn't we add retries for _all_ ath10k SDIO transactions? But that
>> would make ath10k even more complex as it is.
>
> for other SDIO transfer, like data tx/rx, if it fail, the upper stack
> has error mechanism to handle the fail.

Handle the fail is different from retrying. I'm all that all error cases
need to be gracefully handled and bailed out with a clear error, but I
have not seen any logic that mac80211 or driver should retry
transmissions to firmware because of hardware errors. Just as an
example, if there is data loss on the PCI/SDIO bus I don't think the
ath10k credit handling will work for long.

> but for ath10k_start, if it fails, especailly for recovery, then it can
> not recovery again, because cfg80211_shutdown_all_interfaces, and it
> need
> to reboot system to recovery wlan by test.
>>
>> Because I think this patch makes things worse for the user, so I would
>> like to understand the real life use case this patch is trying to fix
>> and how it would help the user.
>
> sometimes it has recovery/suspend/resume test case, it need to make sure
> ath10k_start success, otherwise wlan will can not recovery unless reboot
> system.

If this works 99% of the time and 1% is failing then you should find the
root cause for that 1% case and fix that. The bug might be in ath10k, in
SDIO controller driver or maybe even somewhere else.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
