Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0C7ED3B63
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2019 10:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbfJKIk1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Oct 2019 04:40:27 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36414 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbfJKIk1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Oct 2019 04:40:27 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 691DF60C8B; Fri, 11 Oct 2019 08:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1570783226;
        bh=jKrOmNfjGT2NuRxIi7DDNb9RKh26gHTqjkx6d4eCq5M=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=P60DOC+Ms6g6UeWeGzz7zpSKpklz83VWMykvSOirMIb9WdtSX8l5MEZqeexupnNL8
         A7qFyRer51WivxmJS/Riz520OsaglzyL3hdLUoe2EOQ+RqKiEtVUbTJFpxPMekF3bQ
         N6a2DYzZYEBoY0GInrwZG9pTARCXwMJ+CFZWJ44o=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4A7FC605FE;
        Fri, 11 Oct 2019 08:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1570783224;
        bh=jKrOmNfjGT2NuRxIi7DDNb9RKh26gHTqjkx6d4eCq5M=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=dJvzUCf3xOa7kzJU7YSXt4F5AldnuI66MKXUnV8prapegZkkZZBqDPgT14fZ+25l7
         n+N8eWdclAB82QZPUOWxG6bQUwuNHJnTKIj6LdcWhO5sQtMNAxFekjVeJB8B1GBLrp
         WD5KUVQgakO5ngtu+S1i39ZfPjo6u9vSjB4ZyM0Y=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4A7FC605FE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Sven Eckelmann <sven@narfation.org>
Cc:     ath10k@lists.infradead.org, vnaralas@codeaurora.org,
        linux-wireless@vger.kernel.org,
        Sven Eckelmann <seckelmann@datto.com>
Subject: Re: [RFC PATCH 2/2] ath10k: regularly fetch survey counters
References: <20190918124259.17804-1-sven@narfation.org>
        <20190918124259.17804-3-sven@narfation.org>
Date:   Fri, 11 Oct 2019 11:40:20 +0300
In-Reply-To: <20190918124259.17804-3-sven@narfation.org> (Sven Eckelmann's
        message of "Wed, 18 Sep 2019 14:42:59 +0200")
Message-ID: <87r23jznd7.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sven Eckelmann <sven@narfation.org> writes:

> From: Sven Eckelmann <seckelmann@datto.com>
>
> The survey counters from firmwares like 10.2.4 are not actually using the
> full 64 bit. Instead, they only use the lower 31 bit and overflow ever
> 14-30s. The driver must frequently fetch the survey data and add it to the
> survey data storage to avoid this problem and to present meaningful values
> to the caller of .get_survey.
>
> It is assumed for now that only the current rx_channel retrieves relevant
> updates for the survey data. This should avoid that the bss channel survey
> request times out too often.

Please clarify in the commit log on which hardware this workaround is
enabled. It should be all hardware with ATH10K_HW_CC_WRAP_SHIFTED_ALL
enabled so both QCA988X versions and QCA9887, right?

> Tested on QCA988x hw2.0 10.2.4-1.0-00043
>
> Signed-off-by: Sven Eckelmann <seckelmann@datto.com>

[...]

> --- a/drivers/net/wireless/ath/ath10k/mac.h
> +++ b/drivers/net/wireless/ath/ath10k/mac.h
> @@ -40,6 +40,9 @@ void ath10k_offchan_tx_purge(struct ath10k *ar);
>  void ath10k_offchan_tx_work(struct work_struct *work);
>  void ath10k_mgmt_over_wmi_tx_purge(struct ath10k *ar);
>  void ath10k_mgmt_over_wmi_tx_work(struct work_struct *work);
> +void ath10k_survey_dwork(struct work_struct *work);
> +int ath10k_survey_start(struct ath10k *ar);
> +void ath10k_survey_stop(struct ath10k *ar);

Please use ath10k_mac_ prefix for all functions you are adding to mac.c.
Yeah, I know not all the existing one even have that, should fix it at
some point.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
