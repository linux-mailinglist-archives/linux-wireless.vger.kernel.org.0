Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C58ED124F51
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2019 18:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfLRR2h (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Dec 2019 12:28:37 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:40040 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727184AbfLRR2g (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Dec 2019 12:28:36 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576690115; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=dCtKEMOUyODjTTc1Wnymth+20biHwaA3CWgOkLBofRc=;
 b=PHEt4H12fil0dp5a9XlfkXjbtLTkCCdd8n+ARsaNZv4/cEly2zS8CeVgl+1Jrj8Ux1PQSaK/
 iVFjwKH3G3x9B5kRNIs+Ps60lFPGC4DSyJdm2gqpwVptSlhmP0+343jxF+QsEgfgUXiY3KZO
 L/KyiYD2v5DIaZILZ+VttzJzpd8=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5dfa61c2.7f064e043928-smtp-out-n03;
 Wed, 18 Dec 2019 17:28:34 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 00386C4479F; Wed, 18 Dec 2019 17:28:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 61163C43383;
        Wed, 18 Dec 2019 17:28:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 61163C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH V3 1/9] ath11k: add wmi helper for turning STA PS on/off
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20191213153839.12372-2-john@phrozen.org>
References: <20191213153839.12372-2-john@phrozen.org>
To:     John Crispin <john@phrozen.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        John Crispin <john@phrozen.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20191218172834.00386C4479F@smtp.codeaurora.org>
Date:   Wed, 18 Dec 2019 17:28:33 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

John Crispin <john@phrozen.org> wrote:

> Add a WMI call helper to set the powersave mode of a STA interface.
> 
> Signed-off-by: John Crispin <john@phrozen.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

4 patches applied to ath-next branch of ath.git, thanks.

97c63746ebb9 ath11k: add wmi helper for turning STA PS on/off
6bfebd4bf939 ath11k: disable PS for STA interfaces by default upon bringup
bde4d95e92d5 ath11k: drop memset when setting up a tx cmd desc
6bc9d6f786a5 ath11k: rename ath11k_wmi_base instances from wmi_sc to wmi_ab

-- 
https://patchwork.kernel.org/patch/11290741/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
