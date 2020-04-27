Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 519301BA00E
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2020 11:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgD0JjG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Apr 2020 05:39:06 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:14027 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726003AbgD0JjF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Apr 2020 05:39:05 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587980345; h=Content-Type: MIME-Version: Message-ID: Date:
 References: In-Reply-To: Subject: Cc: To: From: Sender;
 bh=fUyyyvZY5erFWNghFuz6u1lkeSrntr/X0HIwG5v1vAY=; b=dKv3MKCvrdIpXxFcSOS42HFU8RDES3YdUjoFtpLI5lkvkZ+F8JDfC/ljaTIAF9re7yXt0/vG
 u8JQZXRIvY0PvJJuG+wvy6XT2Q2bbVzEYL65mSw9ReXbWgx3vAky3yiANL8kgcOtpY4mHEOH
 pLEni3tn9Ct0PnexxWz1FA4yPGU=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea6a820.7f730f8c8228-smtp-out-n03;
 Mon, 27 Apr 2020 09:38:40 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2DBE6C432C2; Mon, 27 Apr 2020 09:38:40 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7D714C433D2;
        Mon, 27 Apr 2020 09:38:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7D714C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Sumit Semwal <sumit.semwal@linaro.org>,
        kernel-janitors@vger.kernel.org, linux-wireless@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        ath11k@lists.infradead.org, linux-media@vger.kernel.org
Subject: Re: [PATCH net-next] ath11k: use GFP_ATOMIC under spin lock
In-Reply-To: <20200427092417.56236-1-weiyongjun1@huawei.com> (Wei Yongjun's
        message of "Mon, 27 Apr 2020 09:24:17 +0000")
References: <20200427092417.56236-1-weiyongjun1@huawei.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
Date:   Mon, 27 Apr 2020 12:38:35 +0300
Message-ID: <877dy1gtes.fsf@kamboji.qca.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wei Yongjun <weiyongjun1@huawei.com> writes:

> A spin lock is taken here so we should use GFP_ATOMIC.
>
> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Do note that ath11k patches go to my ath.git tree, not net-next. But no
need to resend because of this.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
