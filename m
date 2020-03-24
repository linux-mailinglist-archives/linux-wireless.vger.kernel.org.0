Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D51CF1913E0
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2020 16:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbgCXPH3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Mar 2020 11:07:29 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:28881 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727567AbgCXPH3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Mar 2020 11:07:29 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1585062449; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=GZK16usF8knIDAeRKWMHZTS0aC1e7azGfDPSpUjeyf8=; b=TdLDs9zcFhNG7dThBx2hJ6mfvp7tw+uKYYpZnn8DVh/f4yszN1nOWB7fD6WWwEvGS2ABH9jN
 MkU/T6QbhBvCpgmPR69d3RaTP+3x86CkN8htInO+KKHho1DJ2JLInkGtajxDM5SUcTxSdoVT
 waEEr6REMa1YnKTq+gGjKpVs/3o=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e7a2226.7f19bb7ce8f0-smtp-out-n05;
 Tue, 24 Mar 2020 15:07:18 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C89F1C433D2; Tue, 24 Mar 2020 15:07:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0872DC433CB;
        Tue, 24 Mar 2020 15:07:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0872DC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH 01/14] iwlwifi: mvm: add soc latency support
References: <20200323131925.208376-1-luca@coelho.fi>
        <iwlwifi.20200323151304.a491f6c5ae4b.I6829a46b89e4e701f80a0e4033f4dd41ee44ed12@changeid>
Date:   Tue, 24 Mar 2020 17:07:15 +0200
In-Reply-To: <iwlwifi.20200323151304.a491f6c5ae4b.I6829a46b89e4e701f80a0e4033f4dd41ee44ed12@changeid>
        (Luca Coelho's message of "Mon, 23 Mar 2020 15:19:12 +0200")
Message-ID: <877dz94wrg.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> writes:

> From: Shahar S Matityahu <shahar.s.matityahu@intel.com>
>
> Some devices require longer time to stabilize the power and XTAL.
> This is especially true for devices integrated in the SoC.  Add
> support for a new firmware API that allows the driver to set the
> latency value accordingly.
>
> Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

[...]

> +++ b/drivers/net/wireless/intel/iwlwifi/fw/api/soc.h
> @@ -0,0 +1,83 @@
> +/******************************************************************************
> + *
> + * This file is provided under a dual BSD/GPLv2 license.  When using or
> + * redistributing this file, you may do so under either license.

Any chance of getting SPDX tags to iwlwifi soon? They are awesome and
make life so much easier.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
