Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF24E1B2284
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2020 11:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgDUJTE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Apr 2020 05:19:04 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:17737 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726120AbgDUJTD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Apr 2020 05:19:03 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587460742; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=H1ZvHCdisjdH46yMrRSo9RsaOp8q+peOIIJTJMYsVvA=; b=w1Cur9rBn8jQbNPDbb1htXrF+ApAd1NkUjtN9BgYADJURB1OnMKiyG4XaCGw8CtHZreXAFb0
 UYEoEeOo10nUC5Pz9ouPiq3PYuxh9cqeem8433QDSbIJrJvH865UZzmBqrTfHAwU73tFnFTB
 nyK6udIUg4msVdNbE0DpHBp29YY=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e9eba7c.7efdfad5cc00-smtp-out-n03;
 Tue, 21 Apr 2020 09:18:52 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2B8FBC433F2; Tue, 21 Apr 2020 09:18:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from x230.qca.qualcomm.com (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8BD9FC433D2;
        Tue, 21 Apr 2020 09:18:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8BD9FC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH 02/10] iwlwifi: move API version lookup to common code
References: <20200417102142.2173014-1-luca@coelho.fi>
        <iwlwifi.20200417131727.9c61e7e42b26.I5ede9cc25ee8de7b8d2b5c574f917a18971da734@changeid>
Date:   Tue, 21 Apr 2020 12:18:48 +0300
In-Reply-To: <iwlwifi.20200417131727.9c61e7e42b26.I5ede9cc25ee8de7b8d2b5c574f917a18971da734@changeid>
        (Luca Coelho's message of "Fri, 17 Apr 2020 13:21:34 +0300")
Message-ID: <87imhtqjrb.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> writes:

> From: Mordechay Goodstein <mordechay.goodstein@intel.com>
>
> The API version lookup is parsed from a TLV and should be in shared code
> make make it reusable across all opmodes.
>
> Also change the function names from mvm to fw, since this is not
> mvm-specific anymore.
>
> Additionally, since this function is not just a single line of code, it
> shouldn't be inline.  Convert them to actual functions.
>
> Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

[...]

> +++ b/drivers/net/wireless/intel/iwlwifi/fw/img.c
> @@ -0,0 +1,100 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/******************************************************************************
> + *
> + * This file is provided under a dual BSD/GPLv2 license.  When using or
> + * redistributing this file, you may do so under either license.
> + *
> + * GPL LICENSE SUMMARY
> + *
> + * Copyright(c) 2019 Intel Corporation
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of version 2 of the GNU General Public License as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + *
> + * The full GNU General Public License is included in this distribution
> + * in the file called COPYING.
> + *
> + * Contact Information:
> + *  Intel Linux Wireless <linuxwifi@intel.com>
> + * Intel Corporation, 5200 N.E. Elam Young Parkway, Hillsboro, OR 97124-6497
> + *
> + * BSD LICENSE
> + *
> + * Copyright(c) 2019 Intel Corporation
> + * All rights reserved.
> + *
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following conditions
> + * are met:
> + *
> + *  * Redistributions of source code must retain the above copyright
> + *    notice, this list of conditions and the following disclaimer.
> + *  * Redistributions in binary form must reproduce the above copyright
> + *    notice, this list of conditions and the following disclaimer in
> + *    the documentation and/or other materials provided with the
> + *    distribution.
> + *  * Neither the name Intel Corporation nor the names of its
> + *    contributors may be used to endorse or promote products derived
> + *    from this software without specific prior written permission.
> + *
> + * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
> + * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
> + * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
> + * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
> + * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
> + * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
> + * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
> + * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
> + * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
> + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
> + * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> + *****************************************************************************/

This doesn't look correct. You shouldn't have the actual license text if
you have SPDX tags. Also SPDX claims this is "GPL" but the license text
itself says "GPL or BSD" and they contradict each other.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
