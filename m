Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B91D5892A
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2019 19:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbfF0RqW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Jun 2019 13:46:22 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52392 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbfF0RqW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Jun 2019 13:46:22 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 24CD160AD1; Thu, 27 Jun 2019 17:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561657581;
        bh=8/QiJ8OWT6ufL4GhYuoT3gx0n8TN9kD6X9JuL3lTTjk=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=i/IHB2vTa+r/ThI9Wso8spdbT9aSJyQkjQw7l2Tt9mmjitytkXvFflLrdtpsSQOW2
         7CQ4UX15HHWRM+KAr9XS6PUqj3aWPuuPWCGPLsLkEt9FG43n1rM2kgdYGHR9ArkkCw
         iIQ4mXa3Rr/5ZlIRjgziqGRdlW4rz6MNgWrdyffM=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,MISSING_DATE,MISSING_MID,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9294C60A0A;
        Thu, 27 Jun 2019 17:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561657580;
        bh=8/QiJ8OWT6ufL4GhYuoT3gx0n8TN9kD6X9JuL3lTTjk=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=g1fK3R8gbJeCA23A/rvShc2krRrk21dIxvttFgKItVCMgQ5FRrUwCnmCrX3F1GcEZ
         xyKrKAaRkiJDxNsl/irO9SE4v52l4dYANorsUgFOdHQMQJF7QD9SOm+bFhdV8Qk31k
         sm9y56P5w96AcuBC0/iSfPdaP549oisVRFvOfCPs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9294C60A0A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] ath9k: correctly handle short radar pulses (fixes
 3c0efb745a)
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20190611133656.16964-1-zefir.kurtisi@neratec.com>
References: <20190611133656.16964-1-zefir.kurtisi@neratec.com>
To:     Zefir Kurtisi <zefir.kurtisi@neratec.com>
Cc:     linux-wireless@vger.kernel.org, nbd@nbd.name
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190627174621.24CD160AD1@smtp.codeaurora.org>
Date:   Thu, 27 Jun 2019 17:46:21 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Zefir Kurtisi <zefir.kurtisi@neratec.com> wrote:

> In commit 3c0efb745a17 ("ath9k: discard undersized packets")
> the lower bound of RX packets was set to 10 (min ACK size) to
> filter those that would otherwise be treated as invalid at
> mac80211.
> 
> Alas, short radar pulses are reported as PHY_ERROR frames
> with length set to 3. Therefore their detection stopped
> working after that commit.
> 
> NOTE: ath9k drivers built thereafter will not pass DFS
> certification.
> 
> This extends the criteria for short packets to explicitly
> handle PHY_ERROR frames.
> 
> Fixes: 3c0efb745a17 ("ath9k: discard undersized packets")
> Signed-off-by: Zefir Kurtisi <zefir.kurtisi@neratec.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

df5c4150501e ath9k: correctly handle short radar pulses

-- 
https://patchwork.kernel.org/patch/10986957/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

