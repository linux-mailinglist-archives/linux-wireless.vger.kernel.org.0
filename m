Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 318471245EC
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2019 12:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfLRLiU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Dec 2019 06:38:20 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:40365 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725930AbfLRLiT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Dec 2019 06:38:19 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576669099; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=rz0Kd1kzw1pOfXRtzDC7Qn16ChAfn24BE9QP3Nt/UVc=;
 b=CXU3C8P8Z2Po3Gp05RRO3vNUG6pOoWpl2F8WfFDimQTpRzRD49ER2pZ4gD1hWgiwEk/6ipap
 fPtVXGih2OITAOpGRfq3edUzxXnd6k5j1IUU4AZfA1+UqHxQtoA52GpHg6SCcgKlmzYsRTrF
 J+pCF1GpSKKqmXuMbd2gKhpggNU=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5dfa0fa9.7fe238b96ca8-smtp-out-n02;
 Wed, 18 Dec 2019 11:38:17 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3E78BC43383; Wed, 18 Dec 2019 11:38:17 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EAB18C433CB;
        Wed, 18 Dec 2019 11:38:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EAB18C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH V3 7/9] ath11k: move some tx_status parsing to debugfs code
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20191213153839.12372-8-john@phrozen.org>
References: <20191213153839.12372-8-john@phrozen.org>
To:     John Crispin <john@phrozen.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        John Crispin <john@phrozen.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20191218113817.3E78BC43383@smtp.codeaurora.org>
Date:   Wed, 18 Dec 2019 11:38:17 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

John Crispin <john@phrozen.org> wrote:

> Some of the fields are only used by debugfs. Move the parsing of these
> from the data hot path to the debugfs code.
> 
> Signed-off-by: John Crispin <john@phrozen.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

This added a new warning, fixed in pending branch:

drivers/net/wireless/ath/ath11k/debugfs_sta.c: In function 'ath11k_update_per_peer_stats_from_txcompl':
drivers/net/wireless/ath/ath11k/debugfs_sta.c:138:6: warning: variable 'num_tones_in_ru' set but not used [-Wunused-but-set-variable]

-- 
https://patchwork.kernel.org/patch/11290753/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
