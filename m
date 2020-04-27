Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEAB81B967C
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2020 07:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgD0F0c (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Apr 2020 01:26:32 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:37431 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726172AbgD0F0b (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Apr 2020 01:26:31 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587965191; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=unnUbNzOiNi4DCP+2MtOogJBUgOZSGHdqUj3TJFnSdQ=; b=vdtQ94XqKRqvEtg7cJrQPzdKlqrmV0S+7bbOc9H9LlmCBehdWSDj2p8qXnQMLK2p0vrniLzY
 nXCsEYzZZP8TyJX2kWIeWvsrj3ITaAeSQ2YfjzH72dlvLrsZbmlN6M/PyJmHl9oKw8n3N2kI
 73ienZz3KmMpJKSrttV6CCmTMAw=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea66cfb.7fa3de1a97a0-smtp-out-n05;
 Mon, 27 Apr 2020 05:26:19 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E815CC433F2; Mon, 27 Apr 2020 05:26:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 61305C433CB;
        Mon, 27 Apr 2020 05:26:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 61305C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     John Oldman <john.oldman@polehill.co.uk>
Cc:     m@bues.ch, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] :ssb sprom.c: Fixed block comments coding style issues
References: <20200424175043.16261-1-john.oldman@polehill.co.uk>
Date:   Mon, 27 Apr 2020 08:26:15 +0300
In-Reply-To: <20200424175043.16261-1-john.oldman@polehill.co.uk> (John
        Oldman's message of "Fri, 24 Apr 2020 18:50:43 +0100")
Message-ID: <87wo61ijns.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

John Oldman <john.oldman@polehill.co.uk> writes:

> Fixed coding style issues
>
> Signed-off-by: John Oldman <john.oldman@polehill.co.uk>
> ---
>  drivers/ssb/sprom.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)

The title prefix should be "ssb: ", I'll fix it during commit.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
