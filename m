Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA6AE15D538
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Feb 2020 11:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbgBNKHK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Feb 2020 05:07:10 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:11763 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729007AbgBNKHJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Feb 2020 05:07:09 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1581674829; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=Eo7YKUPx35g+SU/GalvQpdatVLjLaWnjOwyhAovi/ZU=; b=TXJQJKyp7Cwwfy/u2tHjIotYhoviz1hxaYX2msbEKG3Jyo8acxaQke4FQ2quxO+nMlECXDM8
 FX0sVj27qGbhUl6zyvffyNE68dXpZOrYj/J/GvQS5DKKS/bikVncfmhyqlW64bqlpCqAm9BI
 6s4/spoUCAYa5j0nzdlOmPDBdK0=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e467141.7f7ab5f20500-smtp-out-n02;
 Fri, 14 Feb 2020 10:06:57 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6E0ECC4479D; Fri, 14 Feb 2020 10:06:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 47314C433A2;
        Fri, 14 Feb 2020 10:06:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 47314C433A2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: pull request: mt76 2019-02-14
References: <923dcdff-f205-ebd8-4e58-36ba466ef740@nbd.name>
Date:   Fri, 14 Feb 2020 12:06:53 +0200
In-Reply-To: <923dcdff-f205-ebd8-4e58-36ba466ef740@nbd.name> (Felix Fietkau's
        message of "Fri, 14 Feb 2020 10:25:14 +0100")
Message-ID: <87tv3tqy82.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> Hi Kalle,
>
> here's my first pull request for 5.7
>
> - Felix
>
> The following changes since commit aa7619a39acef91c5a6904f3ada7d0f20e2ad25e:
>
>   rtw88: Fix incorrect beamformee role setting (2020-02-13 12:07:25 +0200)
>
> are available in the Git repository at:
>
>   https://github.com/nbd168/wireless tags/mt76-for-kvalo-2020-02-14
>
> for you to fetch changes up to 0987295750574adc59999b8fb9890834574bc4e2:
>
>   mt76: Introduce mt76_mcu data structure (2020-02-14 10:17:46 +0100)
>
> ----------------------------------------------------------------
> mt76 patches for 5.6

The tag mention 5.6 but I think you meant 5.7. I don't have a problem
with that, just mentioning in case it bothers you :)

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
