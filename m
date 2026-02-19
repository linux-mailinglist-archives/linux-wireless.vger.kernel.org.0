Return-Path: <linux-wireless+bounces-32029-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mF+jCrH0lmndrQIAu9opvQ
	(envelope-from <linux-wireless+bounces-32029-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 12:32:01 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9304315E4BE
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 12:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AE2AB3017272
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 11:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D730619E992;
	Thu, 19 Feb 2026 11:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="Qt9M5AyS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD5A1A9F91
	for <linux-wireless@vger.kernel.org>; Thu, 19 Feb 2026 11:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771500713; cv=none; b=flZ1KgbGKD4JV4IXACYzb4s4I4mfBDl/Hm6ez1b/pAyUtQXCVHRbFb50m911VEG3vcIt6ztTne088BlJhMld9zd0lrqZPTrQg4xedgBl5rweQuIa2XlNOLO3Hxc7yYZPyLWlc4eafh+nljC/DpncyIjdTd8fuEQrXjlcQ1DAhsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771500713; c=relaxed/simple;
	bh=ixL0rP9k0AhLizYSWCCBdFXXsLUvvmGl1rjeU8SbLeE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bwYeXm335qHUglQCCNnGFhzr+0joln8Qe8UUCOWcuvpm8zeMtk+8sZkWxxj/T15oXs4y6m7gihuYuH5QWtnExs1xBejS17hJ/gOjaU65AuSKSykbdsra7Sbcxk/MfofjoiyLWD8uYx3U3Mu9Rw35AfU5LXqk32HJKnEohH9crlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=Qt9M5AyS; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4837907f535so7545705e9.3
        for <linux-wireless@vger.kernel.org>; Thu, 19 Feb 2026 03:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1771500709; x=1772105509; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WDzlYIoeVQaQH9OqgFyjlNZouhIzF/kzZ+17obwht0U=;
        b=Qt9M5AyS4LBoS5Fspjdj/mE5GqG/0T6mIGodjxKCNe70a1Kxfzv+qPRkhe/Yp9Bwg1
         Z7zB7HmHqHBMD/1esP+ZoD8bW0rfZ0FgCigd0IaY9XugHdwiC7zxNmDqVmGzJQ0R7/sZ
         uPF+7nbNh+2uLNUWNBa3O2E9Gjt3IQO0xSxzxC9wHntKFv4bYc/DI03C3UI/CZNmuZH1
         FhD8PF5EF7S92gs/CGDpL9RuLksOt+fEGj0UndQopOTbTEJbKEa+QKOcx8Hdt1QJC5Eq
         g1TBl16FEb8jGmgPkaQdWGGdLJBEVdZB0+BN6o/mYTpTmQvuedaUifNkmuRbKEi3otS1
         GdBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771500709; x=1772105509;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WDzlYIoeVQaQH9OqgFyjlNZouhIzF/kzZ+17obwht0U=;
        b=ggJMh0IDPOT3rJHBHIIt/sgCcCs09X4cdq4+Tz3p6o7owxRNJqynoT3OsUs5+z+7Av
         xgmDqFBtT0hSVnGD393XRXi7GUrl4Ob5O68191e+TcP4s4AYGzTnBLeE8NwWHH8iXuM6
         GkBoORGqYsQOjE7aFs7VwNWy0VAXo6kNZX3vhc8wP2yQbWX9DDphxSeFc6VevCgZ/oUr
         pF7PqHRCZXERWFgvfMBwe6g2aJNRhOFCELXirBqN8GBLfd88XJf43OescPPzEumsJPOZ
         jwKgIHjIKOjTW1DW7oZoBlXp5FLZyNSn59NlavtzaWDZNfToVjYFgXL0K+mb4A7NWGlP
         /U6g==
X-Gm-Message-State: AOJu0YzK2ZyuWmPGemHIO2yeIqnw2wLTeeZqCwJUD+MKHR+LmoWX1+V4
	XdCxuxWduqShy9gJ7PKN0THBhoRD5N/3MN37t32liC9RyS4Dd/ElQlseAa3A6q+tAaDZeQPi04y
	GBqwg
X-Gm-Gg: AZuq6aKB/0RQrckD0X6vlb/NES436sWNzp2/Bx5IMINsqgBCOXe3vy9jzf3BszRqfii
	QRVrwzYEtAIehJZ4d92bBw+07Ahb9jmSs4a5t8Ree9IR5fncUEbaCu+tZ1LPa8rsKcTZXL/yXeu
	D8JZnacNTrTsIirWIgeXgRAyLoMCRd1jyQC4CuD2cLnATv5hrOAtboXvQ2458AQx/QlXdFoj40k
	8URw+iURbb9M4HeNuALm0Y81RvHc8Eci9HaRGPX5jRX713QHzjvLlAFPQi8F1POuwnzMSYFbaMN
	28RXuWPaN2NP+34InDsk6+UW3IEJGFZY5atnLT8zskpRhBR50hc5HNKbRTty+ml3hEo8Cb/zZQK
	cwZJ6geJ7H9MI4ezFj5dZZPrEw/O9PnUkuth6mC1v1I6N6LY0Qay/7pOtgX4fg9OO/nshUTtA8g
	r8B/dj3wPmip1aSqjliTfM2B9RnVxQtzdXk+WzHQR8/c4vgaSRYaL/IQ==
X-Received: by 2002:a05:600c:8709:b0:480:1c53:2085 with SMTP id 5b1f17b1804b1-48379bd731emr287433325e9.19.1771500708973;
        Thu, 19 Feb 2026 03:31:48 -0800 (PST)
Received: from [192.168.108.101] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4839ea1e9absm18204535e9.3.2026.02.19.03.31.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Feb 2026 03:31:48 -0800 (PST)
Message-ID: <541218f7-0256-4cae-9cb1-40a1a2da2bfb@freebox.fr>
Date: Thu, 19 Feb 2026 12:31:48 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v2] wifi: ath12k: add basic hwmon temperature
 reporting
To: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>,
 ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Aishwarya R <aishwarya.r@oss.qualcomm.com>
References: <20260219073440.19618-1-maharaja.kennadyrajan@oss.qualcomm.com>
Content-Language: en-US
From: Pablo MARTIN-GOMEZ <pmartin-gomez@freebox.fr>
In-Reply-To: <20260219073440.19618-1-maharaja.kennadyrajan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[freebox-fr.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[freebox-fr.20230601.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-32029-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[freebox.fr];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmartin-gomez@freebox.fr,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,freebox.fr:mid]
X-Rspamd-Queue-Id: 9304315E4BE
X-Rspamd-Action: no action

Hello,

On 19/02/2026 08:34, Maharaja Kennadyrajan wrote:
> Add initial thermal support by wiring up a per-radio (pdev) hwmon temperature
> sensor backed by the existing WMI pdev temperature command and event.
> When userspace reads the sysfs file temp1_input, the driver sends
> WMI_PDEV_GET_TEMPERATURE_CMDID (tag WMI_TAG_PDEV_GET_TEMPERATURE_CMD) and waits
> for the corresponding WMI_PDEV_TEMPERATURE_EVENTID
> (tag WMI_TAG_PDEV_TEMPERATURE_EVENT) to get the temperature and pdev_id.
>
> Export the reported value in millidegrees Celsius as required by hwmon.
> The temperature reported is per-radio (pdev). In a multi-radio wiphy under a
> single phy, a separate hwmon device is created for each radio.
>
> Sample command and output:
> $ cat /sys/devices/pci0000:00/.../ieee80211/phyX/hwmonY/temp1_input
> $ 50000
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202602160145.YQdvbqYY-lkp@intel.com/
> Co-developed-by: Aishwarya R <aishwarya.r@oss.qualcomm.com>
> Signed-off-by: Aishwarya R <aishwarya.r@oss.qualcomm.com>
> Signed-off-by: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
> ---
>
> v2: Fixed the kernel test robot reported build test error.
>
>   drivers/net/wireless/ath/ath12k/Makefile  |   1 +
>   drivers/net/wireless/ath/ath12k/core.c    |  13 +++
>   drivers/net/wireless/ath/ath12k/core.h    |   3 +
>   drivers/net/wireless/ath/ath12k/mac.c     |   5 +
>   drivers/net/wireless/ath/ath12k/thermal.c | 125 ++++++++++++++++++++++
>   drivers/net/wireless/ath/ath12k/thermal.h |  44 ++++++++
>   drivers/net/wireless/ath/ath12k/wmi.c     |  57 +++++-----
>   7 files changed, 217 insertions(+), 31 deletions(-)
>   create mode 100644 drivers/net/wireless/ath/ath12k/thermal.c
>   create mode 100644 drivers/net/wireless/ath/ath12k/thermal.h
>
[...]
> +
> +int ath12k_thermal_register(struct ath12k_base *ab)
> +{
> +	struct ath12k *ar;
> +	int i, j, ret;
> +
> +	if (!IS_REACHABLE(CONFIG_HWMON))
> +		return 0;
> +
> +	for (i = 0; i < ab->num_radios; i++) {
> +		ar = ab->pdevs[i].ar;
> +		if (!ar)
> +			continue;
> +
> +		ar->thermal.hwmon_dev =
> +			hwmon_device_register_with_groups(&ar->ah->hw->wiphy->dev,
> +							  "ath12k_hwmon", ar,
> +							  ath12k_hwmon_groups);
> +		if (IS_ERR(ar->thermal.hwmon_dev)) {
> +			ret = PTR_ERR(ar->thermal.hwmon_dev);
> +			ar->thermal.hwmon_dev = NULL;
> +			ath12k_err(ar->ab, "failed to register hwmon device: %d\n",
> +				   ret);
> +			for (j = i - 1; j >= 0; j--) {
> +				ar = ab->pdevs[i].ar;
Shouldn't it be `ar = ab->pdevs[j].ar;`?
> +				if (!ar)
> +					continue;
> +
> +				hwmon_device_unregister(ar->thermal.hwmon_dev);
> +				ar->thermal.hwmon_dev = NULL;
> +			}
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +

[...]

Best regards,

Pablo MG


