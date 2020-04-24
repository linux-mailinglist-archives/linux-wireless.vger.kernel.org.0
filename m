Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 019D61B712C
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2020 11:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbgDXJse (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Apr 2020 05:48:34 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:26582 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726659AbgDXJse (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Apr 2020 05:48:34 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587721713; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=q4glW/PfqW2UKA2yNtHmIcBa0W8k0+hJd18v2/HXCuU=; b=W6AJ3ofNdxIxQtY/DJfYm2IprnGk9H88mv1sBD7cHyfXAToTFtnz8Gi9TsquOUL9qrui6qK6
 srcYr5p7szh/Nuj8/NbEL/0w4N+5pmiRM/awmd2EfCMVwDWPk+Qr5pGriQpPhNXcpdYBNHtO
 lvEiFwTbzfkj1ucEAxGMUlEpQRI=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea2b5d3.7fe000fac2d0-smtp-out-n01;
 Fri, 24 Apr 2020 09:48:03 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 73CBBC433CB; Fri, 24 Apr 2020 09:48:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 022E2C433D2;
        Fri, 24 Apr 2020 09:48:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 022E2C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Sathishkumar Muruganandam <murugana@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 0/2] mac80211: enable TKIP when using encapsulation offloading
References: <1587720951-9222-1-git-send-email-murugana@codeaurora.org>
Date:   Fri, 24 Apr 2020 12:47:59 +0300
In-Reply-To: <1587720951-9222-1-git-send-email-murugana@codeaurora.org>
        (Sathishkumar Muruganandam's message of "Fri, 24 Apr 2020 15:05:49
        +0530")
Message-ID: <87mu71gqpc.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sathishkumar Muruganandam <murugana@codeaurora.org> writes:

> TKIP was disabled on encap offload mode since if TKIP MIC error
> reporting is not capable by the driver using encap offload mode,
> then TKIP countermeasures wont work.
>
> Enabling back TKIP bring-up in encap offload mode to leave the
> control with the driver to disable hw encap when it is not capable
> of TKIP MIC error reporting.
>
> Sathishkumar Muruganandam (2):
>   mac80211: enable TKIP when using encapsulation offloading
>   ath11k: add 802.3 undecap support to fix TKIP MIC error reporting

When you resend please increase the version to make it clear what is the
latest version. So this is actually v2, but no need to resend because of
this.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
