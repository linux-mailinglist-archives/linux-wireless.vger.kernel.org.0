Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D02191FAAE7
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jun 2020 10:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgFPIQR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Jun 2020 04:16:17 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:48184 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbgFPIQQ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Jun 2020 04:16:16 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592295376; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=f64PeUzV7C5W0lKbHLkX6Uj9u1p3WpcYLvSTXK1yupk=;
 b=Qh3oNs9+5LcSvhf/3mArQ3IFA6BgdjgQn2FrwLMesO6/1UnysYGc/4n4tD4SR8zMIl8ZsX/u
 BBHMX0cqmfpkZfyz/kazbwMb9mnOlAzppHf9xJm3etP/cFplPaTa0vYjCevXx9BOybFSxL+d
 Jy/bIAP3BwSIjE1cQHCZtLbavQ0=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-west-2.postgun.com with SMTP id
 5ee87fcb3a8a8b20b8db25e9 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 16 Jun 2020 08:16:11
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id F09FDC43387; Tue, 16 Jun 2020 08:16:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 03F28C433CA;
        Tue, 16 Jun 2020 08:16:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 03F28C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6] ath10k: provide survey info as accumulated data
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1592232686-28712-1-git-send-email-kvalo@codeaurora.org>
References: <1592232686-28712-1-git-send-email-kvalo@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        sven@narfation.org, 24601deerej@gmail.com,
        markus.theil@tu-ilmenau.de
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200616081610.F09FDC43387@smtp.codeaurora.org>
Date:   Tue, 16 Jun 2020 08:16:10 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@codeaurora.org> wrote:

> It is expected that the returned counters by .get_survey are monotonic
> increasing. But the data from ath10k gets reset to zero regularly. Channel
> active/busy time are then showing incorrect values (less than previous or
> sometimes zero) for the currently active channel during successive survey
> dump commands.
> 
> example:
> 
>   $ iw dev wlan0 survey dump
>   Survey data from wlan0
>   	frequency:                      5180 MHz [in use]
>   	channel active time:            54995 ms
>   	channel busy time:              432 ms
>   	channel receive time:           0 ms
>   	channel transmit time:          59 ms
>   ...
> 
>   $ iw dev wlan0 survey dump
>   Survey data from wlan0
>   	frequency:                      5180 MHz [in use]
>   	channel active time:            32592 ms
>   	channel busy time:              254 ms
>   	channel receive time:           0 ms
>   	channel transmit time:          0 ms
>   ...
> 
> The correct way to handle this is to use the non-clearing
> WMI_BSS_SURVEY_REQ_TYPE_READ wmi_bss_survey_req_type. The firmware will
> then accumulate the survey data and handle wrap arounds.
> 
> Tested-on: QCA9984 hw1.0 10.4-3.5.3-00057
> Tested-on: QCA988X hw2.0 10.2.4-1.0-00047
> Tested-on: QCA9888 hw2.0 10.4-3.9.0.2-00024
> Tested-on: QCA4019 hw1.0 10.4-3.6-00140
> 
> Fixes: fa7937e3d5c2 ("ath10k: update bss channel survey information")
> Signed-off-by: Venkateswara Naralasetty <vnaralas@codeaurora.org>
> Tested-by: Markus Theil <markus.theil@tu-ilmenau.de>
> Tested-by: John Deere <24601deerej@gmail.com>
> [sven@narfation.org: adjust commit message]
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

720e5c03e5cb ath10k: provide survey info as accumulated data

-- 
https://patchwork.kernel.org/patch/11605281/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

