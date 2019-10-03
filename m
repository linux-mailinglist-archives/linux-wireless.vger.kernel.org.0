Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01F08C9F01
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Oct 2019 15:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729501AbfJCNDk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Oct 2019 09:03:40 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45416 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbfJCNDk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Oct 2019 09:03:40 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B57C2611C5; Thu,  3 Oct 2019 13:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1570107818;
        bh=Lx9BrOJJ6VK6C6KTF5WnbI/0E1bm8YGL2YkTTHwg8wM=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=NsG0wxGPTBk4roraRLgfmhCuwK1qI1h9stKu5DbmEzJm/UdJTFygZUuREFzWfhda3
         PBedeAJ8EToLROfv5NRGhGLa3dCykmOdcrQwd2ChzhizNEMtd1p7x/6li4jzwuVDoq
         ryNMFjsAWzjmJv3zWbzgIUnf/q0a5j6vIUNkEF3I=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C754560E73;
        Thu,  3 Oct 2019 13:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1570107818;
        bh=Lx9BrOJJ6VK6C6KTF5WnbI/0E1bm8YGL2YkTTHwg8wM=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=NsG0wxGPTBk4roraRLgfmhCuwK1qI1h9stKu5DbmEzJm/UdJTFygZUuREFzWfhda3
         PBedeAJ8EToLROfv5NRGhGLa3dCykmOdcrQwd2ChzhizNEMtd1p7x/6li4jzwuVDoq
         ryNMFjsAWzjmJv3zWbzgIUnf/q0a5j6vIUNkEF3I=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C754560E73
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Peter Oh <peter.oh@bowerswilkins.com>
Cc:     Rakesh Pillai <pillair@codeaurora.org>,
        "ath10k\@lists.infradead.org" <ath10k@lists.infradead.org>,
        "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2] ath10k: Report low ack rssi based on the reason code
References: <1554276181-7879-1-git-send-email-pillair@codeaurora.org>
        <5f25f471-5753-7d4a-91f8-9a3986117580@bowerswilkins.com>
Date:   Thu, 03 Oct 2019 16:03:33 +0300
In-Reply-To: <5f25f471-5753-7d4a-91f8-9a3986117580@bowerswilkins.com> (Peter
        Oh's message of "Wed, 3 Apr 2019 16:58:51 +0000")
Message-ID: <878sq20ymy.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Peter Oh <peter.oh@bowerswilkins.com> writes:

> On 04/03/2019 12:23 AM, Rakesh Pillai wrote:
>> Firmware sends peer sta kickout event to the driver
>> along with the reason code for a particular peer.
>>
>> Currently the sta kickout event is delivered to the
>> upper layer without checking if the reason code is
>> valid or not. This causes frequent disconnection of
>> the STA.
>>
>> Report low ack rssi event to mac80211 only if the reason
>> code is valid.
>>
>> Tested HW: WCN3990
>> Tested FW: WLAN.HL.2.0-01188-QCAHLSWMTPLZ-1
>>
>> Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>

[...]

>> @@ -3440,6 +3437,12 @@ void ath10k_wmi_event_peer_sta_kickout(struct ath10k *ar, struct sk_buff *skb)
>>   		goto exit;
>>   	}
>>   
>> +	if (arg.reason_code_valid &&
>> +	    arg.reason == WMI_PEER_STA_KICKOUT_REASON_UNSPECIFIED)
>> +		goto exit;
>> +
>
> Why do we want this event not to be delivered to user space?

Yeah, I'm curious about that as well. If I'm guessing right,
WMI_PEER_STA_KICKOUT_REASON_UNSPECIFIED is supposed to mean that the
firmware does not support providing the reason code. Usually, but not
always, in the firmware interface value zero means unsupported. So why
would we want to ignore a kickout event which has a valid mac address
for the peer?

In what kind of cases is the firmware emitting these events? Is this
really the correct thing to do?

>> +	ath10k_dbg(ar, ATH10K_DBG_WMI, "wmi event peer sta kickout %pM reason code %d\n",
>> +		   arg.mac_addr, arg.reason);
>>   	ieee80211_report_low_ack(sta, 10);
>>   
>>   exit:
>> diff --git a/drivers/net/wireless/ath/ath10k/wmi.h b/drivers/net/wireless/ath/ath10k/wmi.h
>> index e1c40bb..3ccd79e 100644
>> --- a/drivers/net/wireless/ath/ath10k/wmi.h
>> +++ b/drivers/net/wireless/ath/ath10k/wmi.h
>> @@ -6797,6 +6797,8 @@ struct wmi_vdev_start_ev_arg {
>>   
>>   struct wmi_peer_kick_ev_arg {
>>   	const u8 *mac_addr;
>> +	u32 reason;
>> +	bool reason_code_valid;
>>   };
>
> Adding extra members to this structure breaks structure consistency 
> between FW and host driver since FW doesn't have such members.

Yeah, this reason_code_valid boolean is set if WMI-TLV is used, but it
does not still mean that the reason code is valid. (There might be
WMI-TLV firmwares which do not provide the reason code.)

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
