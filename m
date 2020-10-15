Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE77A28F16D
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Oct 2020 13:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbgJOLhb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Oct 2020 07:37:31 -0400
Received: from z5.mailgun.us ([104.130.96.5]:55978 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726309AbgJOLh0 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Oct 2020 07:37:26 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1602761846; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=r1ehb31RQz1ouAHmpJLctQJs4jh51DviwdM1StDNxY8=;
 b=ueIB1Yv7TYLmSLytN1fiKkwtVA6ikv8mTJp97ZBrCiItymVj5+M3JlPYK2DlN6YMxVGaCJvY
 HvTA/QSPVjfhOQ61PhJkw0837rU3vLS8pM82ZUIqkZ1eS4xfrggdOVZG84r5X4dCdm4Q9JSb
 tzfSD8g+nweFsYxQiIyJ4PSPcts=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5f88346c588858a304d95393 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 15 Oct 2020 11:37:16
 GMT
Sender: ssreeela=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4FA6AC433CB; Thu, 15 Oct 2020 11:37:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ssreeela)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 87F7AC433F1;
        Thu, 15 Oct 2020 11:37:14 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Thu, 15 Oct 2020 17:07:14 +0530
From:   ssreeela@codeaurora.org
To:     Peter Oh <peter.oh@eero.com>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Govindaraj Saminathan <gsamin@codeaurora.org>
Subject: Re: [PATCH v3] ath11k: cold boot calibration support
In-Reply-To: <b0d42c5e-8aac-cea2-bc6d-3a6341689d05@eero.com>
References: <1600163991-2093-1-git-send-email-ssreeela@codeaurora.org>
 <b0d42c5e-8aac-cea2-bc6d-3a6341689d05@eero.com>
Message-ID: <66888db2618270660f38a0c89226332f@codeaurora.org>
X-Sender: ssreeela@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-09-18 01:24, Peter Oh wrote:
> On 9/15/20 2:59 AM, Sowmiya Sree Elavalagan wrote:
>> From: Govindaraj Saminathan <gsamin@codeaurora.org>
>> 
>> cold boot calibration is the process to calibrate all the channels
>> during the boot-up to avoid the calibration delay during the
>> channel change.
>> During the boot-up, firmware started with mode “cold_boot_calibration”
>> Firmware calibrate all channels and generate CalDb(DDR).
>> Subsequent WIFI ON will reuse the same CalDb.
> Can you clarify the definition of "WIFI ON"?

WIFI ON here refers to wireless interfaces bring
up(reinitialised) in normal mode

>> Firmware restarted with Mission mode to continue the normal operation.
> 
> Please change the mission mode to normal according to
> ATH11K_FIRMWARE_MODE_NORMAL.

Sure we will change that
> 
> Which code it sets back to normal mode from cold boot mode? I don't see 
> it.
> 

Please check the function ath11k_qmi_fwreset_from_cold_boot where 
firmware is reset.
During restart, firmware mode will be reset to normal.
>> +static int ath11k_qmi_process_coldboot_calibration(struct ath11k_base 
>> *ab)
>> +{
>> +	int timeout;
>> +	int ret;
>> +
>> +	ret = ath11k_qmi_wlanfw_mode_send(ab, 
>> ATH11K_FIRMWARE_MODE_COLD_BOOT);
>> +	if (ret < 0) {
>> +		ath11k_warn(ab, "qmi failed to send wlan fw mode:%d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	ath11k_dbg(ab, ATH11K_DBG_QMI, "Coldboot calibration wait 
>> started\n");
>> +
>> +	timeout = wait_event_timeout(ab->qmi.cold_boot_waitq,
>> +				     (ab->qmi.cal_done  == 1),
>> +				     ATH11K_COLD_BOOT_FW_RESET_DELAY);
>> +	if (timeout <= 0) {
>> +		ath11k_warn(ab, "Coldboot Calibration timed out\n");
>> +		return -ETIMEDOUT;
> 
> Does it make ath11k firmware stay in cold boot mode when timeout 
> happens?
> 
> If so, is it worthy to have WLAN usuable due to cold boot calibration 
> failure?
> 
> As I understand, initial calibration on current operation channel will
> be done regardless of cold boot calibration
> 

Agreed, these comments will be addressed in the next patch set.
>> +	}
>> +
>> +	ath11k_dbg(ab, ATH11K_DBG_QMI, "Coldboot calibration wait ended\n");
>> +
>> +	return 0;
>> +}
>> +
>>   static int
>>   ath11k_qmi_driver_event_post(struct ath11k_qmi *qmi,
>>   			     enum ath11k_qmi_event_type type,
>> @@ -2597,9 +2643,16 @@ static void ath11k_qmi_driver_event_work(struct 
>> work_struct *work)
>>   				break;
>>   			}
>>   -			ath11k_core_qmi_firmware_ready(ab);
>> -			ab->qmi.cal_done = 1;
>> -			set_bit(ATH11K_FLAG_REGISTERED, &ab->dev_flags);
>> +			if (ath11k_cold_boot_cal && ab->qmi.cal_done == 0 &&
>> +			    ab->hw_params.cold_boot_calib) {
>> +				ath11k_qmi_process_coldboot_calibration(ab);
>> +			} else {
>> +				clear_bit(ATH11K_FLAG_CRASH_FLUSH,
>> +					  &ab->dev_flags);
>> +				clear_bit(ATH11K_FLAG_RECOVERY, &ab->dev_flags);
> Please split this patch into a separate patch. It's not directly
> related to cold boot.

This resets the flag to commence normal operation when firmware switches 
to normal mode after cold boot calibration.
Once the firmware is ready we clear this flag so that it will not block 
any further communication with firmware.
>> +				ath11k_core_qmi_firmware_ready(ab);
>> +				set_bit(ATH11K_FLAG_REGISTERED, &ab->dev_flags);
>> +			}
>>     			break;
>>   		case ATH11K_QMI_EVENT_COLD_BOOT_CAL_DONE:
> 
> Thanks,
> 
> Peter
