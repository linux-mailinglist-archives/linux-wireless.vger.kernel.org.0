Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC081BB9E8
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2020 11:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgD1JeK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Apr 2020 05:34:10 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:59092 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726477AbgD1JeJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Apr 2020 05:34:09 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588066449; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=ZJDw4uzstyr32yvRRVc+6/V2a+CvApC6DC2EqgKHIZg=; b=QuEvZXKVJPiFfMUYsfP9YjLHhzI1AGzo5qDrOirJPPteRVijBHZanyHNEawdQUmMq+aA0Z5+
 y2FfFMYIW2o2MDy1RdOMa1nHwaEzPezXla0uDI9M0KHmou/GcMytbuJwFuHwVaJ/xRrPG3lp
 QJMETQeV8DUC1kunE063W5q9Dhk=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea7f886.7fbb85903ab0-smtp-out-n04;
 Tue, 28 Apr 2020 09:33:58 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9E5E1C433F2; Tue, 28 Apr 2020 09:33:58 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 43D2FC433CB;
        Tue, 28 Apr 2020 09:33:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 43D2FC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
Subject: Re: [PATCH v2 1/4] ath10k: enable firmware peer stats info for wmi tlv
References: <20200427080416.8265-2-wgong@codeaurora.org>
        <20200428091303.089AEC433D2@smtp.codeaurora.org>
Date:   Tue, 28 Apr 2020 12:33:54 +0300
In-Reply-To: <20200428091303.089AEC433D2@smtp.codeaurora.org> (Kalle Valo's
        message of "Tue, 28 Apr 2020 09:13:03 +0000 (UTC)")
Message-ID: <87k120eyyl.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@codeaurora.org> writes:

> Wen Gong <wgong@codeaurora.org> wrote:
>
>> For wmi tlv type, firmware disable peer stats info by default, after
>> enable it, firmware will report WMI_TLV_PEER_STATS_INFO_EVENTID if
>> ath10k send WMI_TLV_REQUEST_PEER_STATS_INFO_CMDID to firmware.
>> 
>> Enable it will only set a flag in firmware, firmware will not report
>> it without receive request WMI command.
>> 
>> Tested with QCA6174 SDIO with firmware WLAN.RMH.4.4.1-00042.
>> 
>> Signed-off-by: Wen Gong <wgong@codeaurora.org>
>> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
>
> 4 patches applied to ath-next branch of ath.git, thanks.
>
> 2289bef25e32 ath10k: enable firmware peer stats info for wmi tlv
> 0f7cb26830a6 ath10k: add rx bitrate report for SDIO
> 3344b99d69ab ath10k: add bitrate parse for peer stats info
> 4cc02c7c1494 ath10k: correct tx bitrate of iw for SDIO

I think these caused a new warning which I missed:

drivers/net/wireless/ath/ath10k/wmi-tlv.c:3013:34: warning: incorrect type in assignment (different base types)
drivers/net/wireless/ath/ath10k/wmi-tlv.c:3013:34:    expected restricted __le32 [usertype] reset_after_request
drivers/net/wireless/ath/ath10k/wmi-tlv.c:3013:34:    got unsigned int [usertype] reset

Please send a followup patch to fix that.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
