Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85F5515C02B
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2020 15:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730124AbgBMOOT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Feb 2020 09:14:19 -0500
Received: from mail27.static.mailgun.info ([104.130.122.27]:51157 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730079AbgBMOOT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Feb 2020 09:14:19 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1581603258; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=kyo3XbEx2hGjWaSk+8F9Bsjztqgo2ckJ7k/zktGDo/c=; b=oB75kYBAfzgIpBGYojP/dg4s6oi1G+0/LYaSdjCA5gOVYfzbcowwdB/VTeblcZQ2WRzEJqzk
 o5B+7tSwjgijly04AmoxmLwVpRGM36O1TZbz8HAZXL3vw7z2+PBdrwUL8SxbuBdWpY7Oz10o
 yUEWp036dYCWfRQpDI73Ecywb8M=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e4559a5.7fb481f95228-smtp-out-n03;
 Thu, 13 Feb 2020 14:13:57 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A6032C4479C; Thu, 13 Feb 2020 14:13:56 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from x230.qca.qualcomm.com (85-76-96-17-nat.elisa-mobile.fi [85.76.96.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 043F0C43383;
        Thu, 13 Feb 2020 14:13:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 043F0C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Maharaja Kennadyrajan <mkenna@codeaurora.org>
Cc:     ath10k@lists.infradead.org, Vikas Patel <vikpatel@codeaurora.org>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH] ath10k: avoid consecutive OTP download to reduce boot time
References: <1578378195-25780-1-git-send-email-mkenna@codeaurora.org>
        <f1b4007f9d7e882c4ed2db67dc64cc96@codeaurora.org>
Date:   Thu, 13 Feb 2020 16:13:51 +0200
In-Reply-To: <f1b4007f9d7e882c4ed2db67dc64cc96@codeaurora.org> (Maharaja
        Kennadyrajan's message of "Tue, 07 Jan 2020 12:30:19 +0530")
Message-ID: <87pnei7exs.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Maharaja Kennadyrajan <mkenna@codeaurora.org> writes:

> On 2020-01-07 11:53, Maharaja Kennadyrajan wrote:
>
> [Maha]: Please ignore/drop this duplicate patch as I sent it already.
> Regret for inconvenience caused.

Are you sure I should drop this? In the first patch I think you forgot
to CC linux-wireless and that's why I didn't see it. But this second
patch was CCed to linux-wireless and I see it on patchwork. So my plan
is to put this back to my queue, please let me know if I have
misunderstood.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
