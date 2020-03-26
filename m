Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF9C194488
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2020 17:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbgCZQol (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Mar 2020 12:44:41 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:60124 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726163AbgCZQol (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Mar 2020 12:44:41 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1585241080; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=KcShAloOe0WbrxiHc/ErCwnLAnHW41qaCreJTs18qKI=; b=cVadtt4iB1lCn3KrIBnWFaVWCQeEcvWzOQ3ALqTu7fA6kuVO1Z3UUPhfuxyR7Dl3MXPEKEk9
 P0ZTLmebXCZaLwM5d/oI9GUuqmgvaxZ8MDuyyQJmGc8kNBUtAgJSrJDcndwhkhGu/tXCGTSf
 zvQYmNIpIM3EBDrxzeuociV4uLQ=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e7cdbf7.7f61225f61b8-smtp-out-n03;
 Thu, 26 Mar 2020 16:44:39 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 046C1C433F2; Thu, 26 Mar 2020 16:44:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AEC77C433D2;
        Thu, 26 Mar 2020 16:44:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AEC77C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Maharaja Kennadyrajan <mkenna@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] ath11k: add pktlog checksum in trace events to support pktlog
References: <1585234155-30574-1-git-send-email-mkenna@codeaurora.org>
Date:   Thu, 26 Mar 2020 18:44:34 +0200
In-Reply-To: <1585234155-30574-1-git-send-email-mkenna@codeaurora.org>
        (Maharaja Kennadyrajan's message of "Thu, 26 Mar 2020 20:19:15 +0530")
Message-ID: <87k137oykt.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Maharaja Kennadyrajan <mkenna@codeaurora.org> writes:

> Pktlog data are different among the chipset & chipset versions.
> As part of enhancing the user space script to decode the pktlog
> trace events generated, it is desirable to know which chipset or
> which chipset version has provided the events and thereby decode
> the pktlogs appropriately.
>
> Pktlog checksum helps to determine the chipset variant which is
> given by the firmware in the struct wmi_ready_event.
>
> Pktlog checksums are computed during the firmware build.
> So, adding that pktlog checksum in the pklog trace events.
>
> Signed-off-by: Maharaja Kennadyrajan <mkenna@codeaurora.org>

When you send a new version please always increase the version number
(in this case this should be v2), even if just the email address has
changed. That way I can immediately see which version to take.

But no need to resend just because of this.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
