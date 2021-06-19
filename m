Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 461793AD8E7
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Jun 2021 11:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233104AbhFSJ0Q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 19 Jun 2021 05:26:16 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:50835 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbhFSJ0P (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 19 Jun 2021 05:26:15 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1624094645; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=8Rw8lhBtTcA8EEOarfrT3EYG+cdqnL4LWumb4que/to=; b=dCC0lqjVq+n0Dpj9XZT7F+rihMA2NKfM5I4yf6q4LawCY1gOnaN9zRhuhLz3xIL8K0aG2sNQ
 UD2fDGXbeFwAZeJLyYBbSvna1QUKLNYiWD7Chpa7wJt7plSBZM6SGzDmDsHcd1FHCoZJciFe
 U2bBUHemthZn3r69n9DYuYOs8do=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 60cdb7b05eaa81cb1ee7f4ba (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 19 Jun 2021 09:24:00
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8943EC433D3; Sat, 19 Jun 2021 09:23:59 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0DDCEC433F1;
        Sat, 19 Jun 2021 09:23:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0DDCEC433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: pull request: mt76 2021-06-18 v3
References: <000e4539-11dc-a76b-3486-665ab5be3e84@nbd.name>
Date:   Sat, 19 Jun 2021 12:23:53 +0300
In-Reply-To: <000e4539-11dc-a76b-3486-665ab5be3e84@nbd.name> (Felix Fietkau's
        message of "Sat, 19 Jun 2021 09:30:21 +0200")
Message-ID: <875yyai4wm.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> Hi Kalle,
>
> here's an updated version of my first pull request for 5.14
>
> - Felix
>
> The following changes since commit 0c33795231bff5df410bd405b569c66851e92d4b:
>
>   Merge tag 'wireless-drivers-next-2021-06-16' of git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next (2021-06-16 12:59:42 -0700)
>
> are available in the Git repository at:
>
>   https://github.com/nbd168/wireless tags/mt76-for-kvalo-2021-06-18
>
> for you to fetch changes up to 61a1f99dd1e3c145fce9d601b52e7adb8f37322a:
>
>   mt76: mt7921: allow chip reset during device restart (2021-06-19 09:22:52 +0200)
>
> ----------------------------------------------------------------
> mt76 patches for 5.14
>
> * mt7915 MSI support
> * disable ASPM on mt7915
> * mt7915 tx status reporting
> * mt7921 decap offload
> * driver fixes
> * cleanups
> * mt7921 runtime power management improvements
> * testmode improvements/fixes
> * runtime PM improvements
>
> ----------------------------------------------------------------

Looks good now, pulled. Thanks!

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
