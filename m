Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75C54313358
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Feb 2021 14:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbhBHNcV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 Feb 2021 08:32:21 -0500
Received: from so15.mailgun.net ([198.61.254.15]:61535 "EHLO so15.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229759AbhBHNcK (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 Feb 2021 08:32:10 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1612791111; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=oNMERzZVWVaCbjiM7xG76XnAPHjGJaARTIMS+Ct+WtY=; b=Va9ieY8714TxkUVxMqIOSUNi28tbPE4+cOyzw6Xa4LnDQH4Ip073k2KuOwe8h8/lDD4DrLIL
 OtSk8MqQ0K8/VFn9zC1QFlny8G8Gu/51+k39TMmHydcMIAyrU8YjS48jHe7/f5ZjPqd+qhWO
 WxuMa2yddgxH3pJghQu3J3BjBfg=
X-Mailgun-Sending-Ip: 198.61.254.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 60213d2f81f6c45dcefe9dc2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 08 Feb 2021 13:31:27
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7A1BCC433ED; Mon,  8 Feb 2021 13:31:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 415FEC433C6;
        Mon,  8 Feb 2021 13:31:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 415FEC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH 09/12] iwlwifi: pcie: Add support new CRFs for Ma
References: <20210208124847.1934441-1-luca@coelho.fi>
        <iwlwifi.20210208144305.0baae2775d7a.I7377b421b031796730daf809c4024a3c3ef95fa8@changeid>
Date:   Mon, 08 Feb 2021 15:31:23 +0200
In-Reply-To: <iwlwifi.20210208144305.0baae2775d7a.I7377b421b031796730daf809c4024a3c3ef95fa8@changeid>
        (Luca Coelho's message of "Mon, 8 Feb 2021 14:48:44 +0200")
Message-ID: <871rdq65zo.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> writes:

> From: Matti Gottlieb <matti.gottlieb@intel.com>
>
> Add support for Ma with Hr and Gf4

A proper english description would be nice. What's CRF? Or Ma? Even the
title is just gibberish for me.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
