Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8A01BBA52
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2020 11:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgD1Jtr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Apr 2020 05:49:47 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:46700 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727030AbgD1Jtq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Apr 2020 05:49:46 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588067385; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=Ot1JE8mGrLeKXjW9jNRp/7RM3Thoh3OD95x4qaOK1m4=;
 b=KUkslRvksO4MAaaoOjIuGMNl2K9p3idQ721eQOnCHUHvHojSxGloIxQQid5HPUmTjrk2oEED
 Aoil8WA8NjRex2BEMznHAOyfIwEFghqe8fRo8+8or52isIyLGKdMixuSBXdhY/Jp+rz4AXCl
 IeUguzDTdoiiBZnmi6IKmsIQzH8=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea7fc28.7fb55e111ea0-smtp-out-n02;
 Tue, 28 Apr 2020 09:49:28 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AEF25C433F2; Tue, 28 Apr 2020 09:49:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 28260C433D2;
        Tue, 28 Apr 2020 09:49:27 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 28 Apr 2020 17:49:27 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
Subject: Re: [PATCH v2 1/4] ath10k: enable firmware peer stats info for wmi
 tlv
In-Reply-To: <87k120eyyl.fsf@kamboji.qca.qualcomm.com>
References: <20200427080416.8265-2-wgong@codeaurora.org>
 <20200428091303.089AEC433D2@smtp.codeaurora.org>
 <87k120eyyl.fsf@kamboji.qca.qualcomm.com>
Message-ID: <2c0d03590f2ecf55aaff86e760232807@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-04-28 17:33, Kalle Valo wrote:
> Kalle Valo <kvalo@codeaurora.org> writes:
> 
>> Wen Gong <wgong@codeaurora.org> wrote:
>> 
>>> For wmi tlv type, firmware disable peer stats info by default, after
>>> enable it, firmware will report WMI_TLV_PEER_STATS_INFO_EVENTID if
>>> ath10k send WMI_TLV_REQUEST_PEER_STATS_INFO_CMDID to firmware.
>>> 
>>> Enable it will only set a flag in firmware, firmware will not report
>>> it without receive request WMI command.
>>> 
>>> Tested with QCA6174 SDIO with firmware WLAN.RMH.4.4.1-00042.
>>> 
>>> Signed-off-by: Wen Gong <wgong@codeaurora.org>
>>> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
>> 
>> 4 patches applied to ath-next branch of ath.git, thanks.
>> 
>> 2289bef25e32 ath10k: enable firmware peer stats info for wmi tlv
>> 0f7cb26830a6 ath10k: add rx bitrate report for SDIO
>> 3344b99d69ab ath10k: add bitrate parse for peer stats info
>> 4cc02c7c1494 ath10k: correct tx bitrate of iw for SDIO
> 
> I think these caused a new warning which I missed:
> 
> drivers/net/wireless/ath/ath10k/wmi-tlv.c:3013:34: warning: incorrect
> type in assignment (different base types)
> drivers/net/wireless/ath/ath10k/wmi-tlv.c:3013:34:    expected
> restricted __le32 [usertype] reset_after_request
> drivers/net/wireless/ath/ath10k/wmi-tlv.c:3013:34:    got unsigned int
> [usertype] reset
ok. I will give new patch to fix the 3 warning.
> 
> Please send a followup patch to fix that.
