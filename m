Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA7726E608
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Sep 2020 22:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgIQUDA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Sep 2020 16:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbgIQUC7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Sep 2020 16:02:59 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8745BC061A28
        for <linux-wireless@vger.kernel.org>; Thu, 17 Sep 2020 12:54:53 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id s65so1999509pgb.0
        for <linux-wireless@vger.kernel.org>; Thu, 17 Sep 2020 12:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eero.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=7dq3Ok1SPXSJBj3ecW7XDRuuGO0+w+QnLPnVhXB7SiE=;
        b=Zlfzy+i2/hP0gFdQBv7xZV+WAZY4Lw3W7NAXCLzCVFIVVfShWsbasb3O5ioJQDNg8V
         103cFN/X1tR3q7KQ6gbMLjrq8g4kGyv8kJiv2+RiV9pHc69t/J6pCeS/hmVLNUQ/NzO1
         ylDYSBb9QJ0nT/cNrRr0jGdGmr0Ia+e4NkdJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=7dq3Ok1SPXSJBj3ecW7XDRuuGO0+w+QnLPnVhXB7SiE=;
        b=OJ3rMh6+VW51Y+mgMZd8Cn1SWUVfy4pN7NX03vbReEZswWs0GPSLp27a5dNuNiPnnX
         cOhAVToxfuFvzqhMWSE+OdIYqGYpSLXGM1yLtG2rbfsBSQeuinx7FzBsAr65WCCw8Z3r
         unBDr7XqCfqt/4NpAaq+ETxMkDYCpv+06oQSZFRPjYBeCuJNapZ/H8pRF+128ZgTf0y6
         gyojNX9us3Ve8v+3k+3BZAvO/82mmYhRqxuwZkrIcTjtXrsZlRW3IQI9sls8xJo/+wdQ
         e6wqqIXzYph/T2K+UkOBmUnEp7TzhkrbrjTgodleqoyxUENmvFg1YjpI63GCaIIyNnho
         UT3w==
X-Gm-Message-State: AOAM530Hzrfy0/pYklSJoxJsICfBy+eoODUGZepkAD9CARdGMshwGaS2
        h9ShP6ItF6NSRxVpy2VsHeV4owdwTNwaOg==
X-Google-Smtp-Source: ABdhPJzR1TsRcw2jecJIHfXbGUHP4d+r9ALvLEx+oMZlkbcoj/VSyDb97N4o3Vui93+2ccjjw11s1g==
X-Received: by 2002:a63:85c2:: with SMTP id u185mr23190300pgd.157.1600372493064;
        Thu, 17 Sep 2020 12:54:53 -0700 (PDT)
Received: from ?IPv6:2601:647:4c00:311:152b:d023:4ed3:fc2? ([2601:647:4c00:311:152b:d023:4ed3:fc2])
        by smtp.gmail.com with ESMTPSA id h9sm438567pfc.28.2020.09.17.12.54.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2020 12:54:52 -0700 (PDT)
Subject: Re: [PATCH v3] ath11k: cold boot calibration support
To:     Sowmiya Sree Elavalagan <ssreeela@codeaurora.org>,
        ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Govindaraj Saminathan <gsamin@codeaurora.org>
References: <1600163991-2093-1-git-send-email-ssreeela@codeaurora.org>
From:   Peter Oh <peter.oh@eero.com>
Message-ID: <b0d42c5e-8aac-cea2-bc6d-3a6341689d05@eero.com>
Date:   Thu, 17 Sep 2020 12:54:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1600163991-2093-1-git-send-email-ssreeela@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 9/15/20 2:59 AM, Sowmiya Sree Elavalagan wrote:
> From: Govindaraj Saminathan <gsamin@codeaurora.org>
>
> cold boot calibration is the process to calibrate all the channels
> during the boot-up to avoid the calibration delay during the
> channel change.
> During the boot-up, firmware started with mode “cold_boot_calibration”
> Firmware calibrate all channels and generate CalDb(DDR).
> Subsequent WIFI ON will reuse the same CalDb.
Can you clarify the definition of "WIFI ON"?
> Firmware restarted with Mission mode to continue the normal operation.

Please change the mission mode to normal according to 
ATH11K_FIRMWARE_MODE_NORMAL.

Which code it sets back to normal mode from cold boot mode? I don't see it.

> +static int ath11k_qmi_process_coldboot_calibration(struct ath11k_base *ab)
> +{
> +	int timeout;
> +	int ret;
> +
> +	ret = ath11k_qmi_wlanfw_mode_send(ab, ATH11K_FIRMWARE_MODE_COLD_BOOT);
> +	if (ret < 0) {
> +		ath11k_warn(ab, "qmi failed to send wlan fw mode:%d\n", ret);
> +		return ret;
> +	}
> +
> +	ath11k_dbg(ab, ATH11K_DBG_QMI, "Coldboot calibration wait started\n");
> +
> +	timeout = wait_event_timeout(ab->qmi.cold_boot_waitq,
> +				     (ab->qmi.cal_done  == 1),
> +				     ATH11K_COLD_BOOT_FW_RESET_DELAY);
> +	if (timeout <= 0) {
> +		ath11k_warn(ab, "Coldboot Calibration timed out\n");
> +		return -ETIMEDOUT;

Does it make ath11k firmware stay in cold boot mode when timeout happens?

If so, is it worthy to have WLAN usuable due to cold boot calibration 
failure?

As I understand, initial calibration on current operation channel will 
be done regardless of cold boot calibration

> +	}
> +
> +	ath11k_dbg(ab, ATH11K_DBG_QMI, "Coldboot calibration wait ended\n");
> +
> +	return 0;
> +}
> +
>   static int
>   ath11k_qmi_driver_event_post(struct ath11k_qmi *qmi,
>   			     enum ath11k_qmi_event_type type,
> @@ -2597,9 +2643,16 @@ static void ath11k_qmi_driver_event_work(struct work_struct *work)
>   				break;
>   			}
>   
> -			ath11k_core_qmi_firmware_ready(ab);
> -			ab->qmi.cal_done = 1;
> -			set_bit(ATH11K_FLAG_REGISTERED, &ab->dev_flags);
> +			if (ath11k_cold_boot_cal && ab->qmi.cal_done == 0 &&
> +			    ab->hw_params.cold_boot_calib) {
> +				ath11k_qmi_process_coldboot_calibration(ab);
> +			} else {
> +				clear_bit(ATH11K_FLAG_CRASH_FLUSH,
> +					  &ab->dev_flags);
> +				clear_bit(ATH11K_FLAG_RECOVERY, &ab->dev_flags);
Please split this patch into a separate patch. It's not directly related 
to cold boot.
> +				ath11k_core_qmi_firmware_ready(ab);
> +				set_bit(ATH11K_FLAG_REGISTERED, &ab->dev_flags);
> +			}
>   
>   			break;
>   		case ATH11K_QMI_EVENT_COLD_BOOT_CAL_DONE:

Thanks,

Peter

