Return-Path: <linux-wireless+bounces-29735-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2170ACBC12A
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Dec 2025 23:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18FA130084F0
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Dec 2025 22:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F61B316183;
	Sun, 14 Dec 2025 22:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFEyzy9T"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95672989B5
	for <linux-wireless@vger.kernel.org>; Sun, 14 Dec 2025 22:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765751431; cv=none; b=dvSQjLnsZakUflexpERVGNtTqwunSvJ0d/lahiMfStzCff2fLfU3Hw7Gu3tB7bYyrUPJcK7PJ72ut+oujAi336UoWN04bb/Bx2H0B+U1YNogV8A3Ph8l9v6llr1wPySxQxjIWqUql0MGZwlz9nVwgxFCOEENnxwAEtCuU8WRsbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765751431; c=relaxed/simple;
	bh=9IMlFEmnsE0d/d62i01r8S82Ir8EjKiqjAJ5/5MJgHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T3Yt9jNp6MDPKNXlViG9xfXGqR26jSAC1zCXH7RdGYjpx/h58tGB5YV9e4FWcDiA9KnjQbLTHFmyStILfo/4M62Pr86CMN8+ndj+OBqPrsF1/Qo/Gb9CYtPx9rCoy/AtHNA1xLniQEfRyts+J7nQfufKIk3WtvWs3H70jNRE4xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IFEyzy9T; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42fbab737f5so1130208f8f.1
        for <linux-wireless@vger.kernel.org>; Sun, 14 Dec 2025 14:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765751427; x=1766356227; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v+kOdVB/v3IQEDWdQy/7HhQKOWUzE/Sn+zJCDPFb0sg=;
        b=IFEyzy9TzuzYshm+PmS4DRKbv4lr3Og+4Ut8ky4jtyGdP5VlbTYyfCkGFEjpO4yEeQ
         bBd/fYMQ/7Pd5jrq9fWrZIsUE2HbD+6h+1FK+5gYnOf3hfCWQYj5foPSCSkZb6VuZyNQ
         fV637fCNcclaIRBUMHoeb/KNx6I57J9NjhOB7Gsq52VVqHvZLH/ujtmUZmw2DwBvChAL
         k7DNKm+iD8gpnaWh5sDAlkepQ5JQvCykaxLjYiquZP4riWiliB+zFkbF5k/LVWiVknot
         sXjfk0z4u14z0xGpADBWI6HLKPmaM3NE/bT56wZIAX93hY21mac3v6/Zfm7ijZcbWivc
         Cq9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765751427; x=1766356227;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v+kOdVB/v3IQEDWdQy/7HhQKOWUzE/Sn+zJCDPFb0sg=;
        b=wkxXxEvosdhY7qOKYZ1xfy7cx9KE/Xvi+EXUX3DrTpbWKz46dy7Mps4XWHVl5HCe26
         nSa8GYv2+6B6PY0dGpdYvRmMf5sB6NlU4PUxkmXZt3uLATqoCjNM7VZ+j6He3HOqt0Yt
         QANPDbmrMryAjmtZvoEXosZDFxa2FyjlcrW9WIAJmOPtAiGJFFqvhzt9iCLcR88IIz3S
         K7jncMt/TQV5VqP/p0JTDHE90SU4wZps2IAxc/Viq609R9SH8SW3+pb04chT6LZb9qIW
         lKvQDkppCi3AIKZJ6dWUUE6KrFR0ZyW4dMpxntPRd0d+E3Pa0LEscrV1f/dUYxCCYoGA
         nrmw==
X-Forwarded-Encrypted: i=1; AJvYcCUqXVOv1B28ZbrWq08G0z7bpfY1+bKNvk2ZzLgGJZlCwFq9rp3zI4HXol6SVnIj4e8X+Pu++UkgeBRd/mrWew==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo4oKxcIVxom4bHikX83hYg+A+3HeuVYg+o4FPb0E2YZokL3aI
	5eMY9hopyuxAZxzFqyicojVEGmHcPkM4PlGOfY+OjXJdf5mEv0ybtcg9aOe+mA==
X-Gm-Gg: AY/fxX5WqZN72C8/OSC6S8MnX0XqD2dJ8J02qce83xoerF6NP0M3C9FXhvF7mEZNOHF
	hn/GyHa102wTUVkNxFmuKGwvd+NCXtWx9UY44q2Elm9Pcf1EhN0BKFF9m8OEr+sSsbRJSpUbTTD
	+m7rTMq8uKGsOP4Dvc24pmM2WrA1IpmLQtmD0RcuzWFgw0sg+kaFjnxaICJ1LQjBIL8Zn3ua0PQ
	skr4HLBeXAV15GJlFJX1+LyT3pg24MSgt6Vzg0Cqmp0rLDulCmA6JFZirKhe1VO3tTOUWjrlpbB
	dIDoz30AEF8x98S9Urz1sSwct9oFl/rFoliN7t6iiqAuYevLf4bvhoa8KkAUM3rW2jSmgBsbOog
	Ii0iHWtNrOPeJ8fHSDYKK+CfRR43iMjJI3cbgASKz1q/zF8wG0b5L7MIqEh6kIt08anEBt5FDEv
	S7KWDaJ+u0hEw+tGnXx3nz
X-Google-Smtp-Source: AGHT+IEPRt2EFYklaLf7uRZinUsTyzTFs9naD2Lo1ro7IDU5jJlZMdiHRdRjdJWgw7LaZskaeL1u6g==
X-Received: by 2002:a05:6000:1ace:b0:429:d59e:d097 with SMTP id ffacd0b85a97d-42fb3e639d9mr9172910f8f.9.1765751426976;
        Sun, 14 Dec 2025 14:30:26 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.187])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-430f675c2basm7886111f8f.18.2025.12.14.14.30.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Dec 2025 14:30:26 -0800 (PST)
Message-ID: <efc58c87-d391-4970-b9af-abdef9861342@gmail.com>
Date: Mon, 15 Dec 2025 00:30:24 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rtw-next 04/12] wifi: rtw89: mac: reset power state before
 switching to power on
To: Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org
Cc: gary.chang@realtek.com, damon.chen@realtek.com, kevin_yang@realtek.com
References: <20251212031303.19882-1-pkshih@realtek.com>
 <20251212031303.19882-5-pkshih@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <20251212031303.19882-5-pkshih@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/12/2025 05:12, Ping-Ke Shih wrote:
> To run power on function properly, reset power states (off/on/PS) to
> initial state. Otherwise, it might be unusable due to fail to power on.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
>  drivers/net/wireless/realtek/rtw89/mac.c    |  89 ++++++++++++--
>  drivers/net/wireless/realtek/rtw89/mac.h    |   1 +
>  drivers/net/wireless/realtek/rtw89/mac_be.c | 130 ++++++++++++++++++++
>  drivers/net/wireless/realtek/rtw89/reg.h    |  27 ++++
>  4 files changed, 240 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
> index d78fbe73e365..ba4344a640f5 100644
> --- a/drivers/net/wireless/realtek/rtw89/mac.c
> +++ b/drivers/net/wireless/realtek/rtw89/mac.c
> @@ -1478,13 +1478,11 @@ static void rtw89_mac_power_switch_boot_mode(struct rtw89_dev *rtwdev)
>  
>  static int rtw89_mac_power_switch(struct rtw89_dev *rtwdev, bool on)
>  {
> -#define PWR_ACT 1
>  	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
>  	const struct rtw89_chip_info *chip = rtwdev->chip;
>  	const struct rtw89_pwr_cfg * const *cfg_seq;
>  	int (*cfg_func)(struct rtw89_dev *rtwdev);
>  	int ret;
> -	u8 val;
>  
>  	rtw89_mac_power_switch_boot_mode(rtwdev);
>  
> @@ -1499,10 +1497,10 @@ static int rtw89_mac_power_switch(struct rtw89_dev *rtwdev, bool on)
>  	if (test_bit(RTW89_FLAG_FW_RDY, rtwdev->flags))
>  		__rtw89_leave_ps_mode(rtwdev);
>  
> -	val = rtw89_read32_mask(rtwdev, R_AX_IC_PWR_STATE, B_AX_WLMAC_PWR_STE_MASK);
> -	if (on && val == PWR_ACT) {
> -		rtw89_err(rtwdev, "MAC has already powered on\n");
> -		return -EBUSY;
> +	if (on) {
> +		ret = mac->reset_pwr_state(rtwdev);
> +		if (ret)
> +			return ret;
>  	}
>  
>  	ret = cfg_func ? cfg_func(rtwdev) : rtw89_mac_pwr_seq(rtwdev, cfg_seq);
> @@ -1529,7 +1527,6 @@ static int rtw89_mac_power_switch(struct rtw89_dev *rtwdev, bool on)
>  	}
>  
>  	return 0;
> -#undef PWR_ACT
>  }
>  
>  int rtw89_mac_pwr_on(struct rtw89_dev *rtwdev)
> @@ -3931,6 +3928,83 @@ static int rtw89_mac_feat_init(struct rtw89_dev *rtwdev)
>  	return 0;
>  }
>  
> +static int rtw89_mac_reset_pwr_state_ax(struct rtw89_dev *rtwdev)
> +{
> +	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
> +	u32 val32;
> +	int ret;
> +
> +	val32 = rtw89_read32(rtwdev, R_AX_SYSON_FSM_MON);
> +	val32 &= WLAN_FSM_MASK;
> +	val32 |= WLAN_FSM_SET;
> +	rtw89_write32(rtwdev, R_AX_SYSON_FSM_MON, val32);
> +
> +	ret = read_poll_timeout(rtw89_read32_mask, val32, val32 == WLAN_FSM_IDLE,
> +				1000, 2000000, false,
> +				rtwdev, R_AX_SYSON_FSM_MON, WLAN_FSM_STATE_MASK);
> +	if (ret) {
> +		rtw89_err(rtwdev, "[ERR]Polling WLAN PMC timeout= %X\n", val32);
> +		return ret;
> +	}

I get this error message with every AX chip the first time
rtw89_mac_pwr_on() is called:

[  +0.007286] rtw89_8852bu 2-4:1.0: loaded firmware rtw89/rtw8852b_fw-1.bin
[  +2.001260] rtw89_8852bu 2-4:1.0: [ERR]Polling WLAN PMC timeout= 100

They still work, because the second attempt in rtw89_mac_pwr_on()
succeeds.

Before this patch, the message was "MAC has already powered on".
The new message says it's an error, so it will confuse people.

Is it possible this code related to R_AX_SYSON_FSM_MON is not
applicable to USB? My adapters still work if I delete it.

(I don't get the error with RTL8912AU.)

> +
> +	val32 = rtw89_read32_mask(rtwdev, R_AX_IC_PWR_STATE, B_AX_WLMAC_PWR_STE_MASK);
> +	if (val32 == MAC_AX_MAC_OFF) {
> +		rtw89_write32_clr(rtwdev, R_AX_SYS_PW_CTRL, B_AX_EN_WLON);
> +		rtw89_write32_clr(rtwdev, R_AX_SYS_PW_CTRL, B_AX_APFM_SWLPS);
> +	} else if (val32 == MAC_AX_MAC_ON) {
> +		rtw89_write32_set(rtwdev, R_AX_SYS_PW_CTRL, B_AX_EN_WLON);
> +		rtw89_write32_set(rtwdev, R_AX_SYS_PW_CTRL, B_AX_APFM_OFFMAC);
> +
> +		ret = read_poll_timeout(rtw89_read32_mask, val32, val32 == MAC_AX_MAC_OFF,
> +					1000, 2000000, false,
> +					rtwdev, R_AX_SYS_PW_CTRL, B_AX_APFM_OFFMAC);
> +		if (ret) {
> +			rtw89_err(rtwdev, "[ERR]Polling MAC state timeout= %X\n", val32);
> +			return ret;
> +		}
> +
> +		rtw89_write32_clr(rtwdev, R_AX_SYS_PW_CTRL, B_AX_EN_WLON);
> +		rtw89_write32_clr(rtwdev, R_AX_SYS_PW_CTRL, B_AX_APFM_SWLPS);
> +	} else if (val32 == MAC_AX_MAC_LPS) {
> +		rtw89_write32_set(rtwdev, R_AX_WLLPS_CTRL, B_AX_FORCE_LEAVE_LPS);
> +
> +		ret = read_poll_timeout(rtw89_read32_mask, val32, val32 == MAC_AX_MAC_ON,
> +					1000, 2000000, false,
> +					rtwdev, R_AX_IC_PWR_STATE, B_AX_WLMAC_PWR_STE_MASK);
> +		if (ret) {
> +			rtw89_err(rtwdev, "[ERR]Polling MAC STS timeout= %X\n", val32);
> +			return ret;
> +		}
> +
> +		rtw89_write32_set(rtwdev, R_AX_SYS_PW_CTRL, B_AX_EN_WLON);
> +		rtw89_write32_set(rtwdev, R_AX_SYS_PW_CTRL, B_AX_APFM_OFFMAC);
> +
> +		ret = read_poll_timeout(rtw89_read32_mask, val32, val32 == MAC_AX_MAC_OFF,
> +					1000, 2000000, false,
> +					rtwdev, R_AX_SYS_PW_CTRL, B_AX_APFM_OFFMAC);
> +		if (ret) {
> +			rtw89_err(rtwdev, "[ERR]Polling MAC state timeout= %X\n", val32);
> +			return ret;
> +		}
> +
> +		rtw89_write32_clr(rtwdev, R_AX_WLLPS_CTRL, B_AX_FORCE_LEAVE_LPS);
> +		rtw89_write32_clr(rtwdev, R_AX_SYS_PW_CTRL, B_AX_EN_WLON);
> +		rtw89_write32_clr(rtwdev, R_AX_SYS_PW_CTRL, B_AX_APFM_SWLPS);
> +	}
> +
> +	switch (chip_id) {
> +	case RTL8852A:
> +	case RTL8852B:
> +	case RTL8851B:
> +		rtw89_write32_clr(rtwdev, R_AX_AFE_CTRL1, B_AX_CMAC_CLK_SEL);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
>  static void rtw89_disable_fw_watchdog(struct rtw89_dev *rtwdev)
>  {
>  	u32 val32;
> @@ -7206,6 +7280,7 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_ax = {
>  	.set_cpuio = set_cpuio_ax,
>  	.dle_quota_change = dle_quota_change_ax,
>  
> +	.reset_pwr_state = rtw89_mac_reset_pwr_state_ax,
>  	.disable_cpu = rtw89_mac_disable_cpu_ax,
>  	.fwdl_enable_wcpu = rtw89_mac_enable_cpu_ax,
>  	.fwdl_get_status = rtw89_fw_get_rdy_ax,
> diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
> index 0007229d6753..9ec70729e9e1 100644
> --- a/drivers/net/wireless/realtek/rtw89/mac.h
> +++ b/drivers/net/wireless/realtek/rtw89/mac.h
> @@ -1052,6 +1052,7 @@ struct rtw89_mac_gen_def {
>  			 struct rtw89_cpuio_ctrl *ctrl_para, bool wd);
>  	int (*dle_quota_change)(struct rtw89_dev *rtwdev, bool band1_en);
>  
> +	int (*reset_pwr_state)(struct rtw89_dev *rtwdev);
>  	void (*disable_cpu)(struct rtw89_dev *rtwdev);
>  	int (*fwdl_enable_wcpu)(struct rtw89_dev *rtwdev, u8 boot_reason,
>  				bool dlfw, bool include_bb);
> diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
> index 556e5f98e8d4..65c0c0de3a30 100644
> --- a/drivers/net/wireless/realtek/rtw89/mac_be.c
> +++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
> @@ -425,6 +425,135 @@ int rtw89_mac_read_xtal_si_be(struct rtw89_dev *rtwdev, u8 offset, u8 *val)
>  	return 0;
>  }
>  
> +static int rtw89_mac_reset_pwr_state_be(struct rtw89_dev *rtwdev)
> +{
> +	u32 val32;
> +	int ret;
> +
> +	val32 = rtw89_read32(rtwdev, R_BE_SYSON_FSM_MON);
> +	val32 &= WLAN_FSM_MASK;
> +	val32 |= WLAN_FSM_SET;
> +	rtw89_write32(rtwdev, R_BE_SYSON_FSM_MON, val32);
> +
> +	ret = read_poll_timeout(rtw89_read32_mask, val32, val32 == WLAN_FSM_IDLE,
> +				1000, 2000000, false,
> +				rtwdev, R_BE_SYSON_FSM_MON, WLAN_FSM_STATE_MASK);
> +	if (ret) {
> +		rtw89_err(rtwdev, "[ERR]Polling WLAN PMC timeout= %X\n", val32);
> +		return ret;
> +	}
> +
> +	val32 = rtw89_read32_mask(rtwdev, R_BE_IC_PWR_STATE, B_BE_WLMAC_PWR_STE_MASK);
> +	if (val32 == MAC_AX_MAC_OFF) {
> +		rtw89_write32_clr(rtwdev, R_BE_HCI_OPT_CTRL, B_BE_HAXIDMA_IO_EN);
> +
> +		ret = read_poll_timeout(rtw89_read32_mask, val32, !val32,
> +					1000, 2000000, false,
> +					rtwdev, R_BE_HCI_OPT_CTRL,
> +					B_BE_HAXIDMA_IO_ST | B_BE_HAXIDMA_BACKUP_RESTORE_ST);
> +		if (ret) {
> +			rtw89_err(rtwdev, "[ERR]Polling HAXI IO timeout= %X\n", val32);
> +			return ret;
> +		}
> +
> +		rtw89_write32_clr(rtwdev, R_BE_HCI_OPT_CTRL, B_BE_HCI_WLAN_IO_EN);
> +
> +		ret = read_poll_timeout(rtw89_read32_mask, val32, !val32,
> +					1000, 2000000, false,
> +					rtwdev, R_BE_HCI_OPT_CTRL, B_BE_HCI_WLAN_IO_ST);
> +		if (ret) {
> +			rtw89_err(rtwdev, "[ERR]Polling WLAN IO timeout= %X\n", val32);
> +			return ret;
> +		}
> +
> +		rtw89_write32_clr(rtwdev, R_BE_SYS_PW_CTRL, B_BE_EN_WLON);
> +		rtw89_write32_clr(rtwdev, R_BE_SYS_PW_CTRL, B_BE_APFM_SWLPS);
> +	} else if (val32 == MAC_AX_MAC_ON) {
> +		rtw89_write32_clr(rtwdev, R_BE_HCI_OPT_CTRL, B_BE_HAXIDMA_IO_EN);
> +
> +		ret = read_poll_timeout(rtw89_read32_mask, val32, !val32,
> +					1000, 2000000, false,
> +					rtwdev, R_BE_HCI_OPT_CTRL,
> +					B_BE_HAXIDMA_IO_ST | B_BE_HAXIDMA_BACKUP_RESTORE_ST);
> +		if (ret) {
> +			rtw89_err(rtwdev, "[ERR]Polling HAXI IO timeout= %X\n", val32);
> +			return ret;
> +		}
> +
> +		rtw89_write32_clr(rtwdev, R_BE_HCI_OPT_CTRL, B_BE_HCI_WLAN_IO_EN);
> +
> +		ret = read_poll_timeout(rtw89_read32_mask, val32, !val32,
> +					1000, 2000000, false,
> +					rtwdev, R_BE_HCI_OPT_CTRL, B_BE_HCI_WLAN_IO_ST);
> +		if (ret) {
> +			rtw89_err(rtwdev, "[ERR]Polling WLAN IO timeout= %X\n", val32);
> +			return ret;
> +		}
> +
> +		rtw89_write32_set(rtwdev, R_BE_SYS_PW_CTRL, B_BE_EN_WLON);
> +		rtw89_write32_set(rtwdev, R_BE_SYS_PW_CTRL, B_BE_APFM_OFFMAC);
> +
> +		ret = read_poll_timeout(rtw89_read32_mask, val32, val32 == MAC_AX_MAC_OFF,
> +					1000, 2000000, false,
> +					rtwdev, R_BE_SYS_PW_CTRL, B_BE_APFM_OFFMAC);
> +		if (ret) {
> +			rtw89_err(rtwdev, "[ERR]Polling MAC state timeout= %X\n", val32);
> +			return ret;
> +		}
> +
> +		rtw89_write32_clr(rtwdev, R_BE_SYS_PW_CTRL, B_BE_EN_WLON);
> +		rtw89_write32_clr(rtwdev, R_BE_SYS_PW_CTRL, B_BE_APFM_SWLPS);
> +	} else if (val32 == MAC_AX_MAC_LPS) {
> +		rtw89_write32_clr(rtwdev, R_BE_HCI_OPT_CTRL, B_BE_HAXIDMA_IO_EN);
> +
> +		ret = read_poll_timeout(rtw89_read32_mask, val32, !val32,
> +					1000, 2000000, false,
> +					rtwdev, R_BE_HCI_OPT_CTRL,
> +					B_BE_HAXIDMA_IO_ST | B_BE_HAXIDMA_BACKUP_RESTORE_ST);
> +		if (ret) {
> +			rtw89_err(rtwdev, "[ERR]Polling HAXI IO timeout= %X\n", val32);
> +			return ret;
> +		}
> +
> +		rtw89_write32_clr(rtwdev, R_BE_HCI_OPT_CTRL, B_BE_HCI_WLAN_IO_EN);
> +
> +		ret = read_poll_timeout(rtw89_read32_mask, val32, !val32,
> +					1000, 2000000, false,
> +					rtwdev, R_BE_HCI_OPT_CTRL, B_BE_HCI_WLAN_IO_ST);
> +		if (ret) {
> +			rtw89_err(rtwdev, "[ERR]Polling WLAN IO timeout= %X\n", val32);
> +			return ret;
> +		}
> +
> +		rtw89_write32_set(rtwdev, R_BE_WLLPS_CTRL, B_BE_FORCE_LEAVE_LPS);
> +
> +		ret = read_poll_timeout(rtw89_read32_mask, val32, val32 == MAC_AX_MAC_ON,
> +					1000, 2000000, false,
> +					rtwdev, R_BE_IC_PWR_STATE, B_BE_WLMAC_PWR_STE_MASK);
> +		if (ret) {
> +			rtw89_err(rtwdev, "[ERR]Polling MAC STS timeout= %X\n", val32);
> +			return ret;
> +		}
> +
> +		rtw89_write32_set(rtwdev, R_BE_SYS_PW_CTRL, B_BE_EN_WLON);
> +		rtw89_write32_set(rtwdev, R_BE_SYS_PW_CTRL, B_BE_APFM_OFFMAC);
> +
> +		ret = read_poll_timeout(rtw89_read32_mask, val32, val32 == MAC_AX_MAC_OFF,
> +					1000, 2000000, false,
> +					rtwdev, R_BE_SYS_PW_CTRL, B_BE_APFM_OFFMAC);
> +		if (ret) {
> +			rtw89_err(rtwdev, "[ERR]Polling MAC state timeout= %X\n", val32);
> +			return ret;
> +		}
> +
> +		rtw89_write32_clr(rtwdev, R_BE_WLLPS_CTRL, B_BE_FORCE_LEAVE_LPS);
> +		rtw89_write32_clr(rtwdev, R_BE_SYS_PW_CTRL, B_BE_EN_WLON);
> +		rtw89_write32_clr(rtwdev, R_BE_SYS_PW_CTRL, B_BE_APFM_SWLPS);
> +	}
> +
> +	return 0;
> +}
> +
>  static void rtw89_mac_disable_cpu_be(struct rtw89_dev *rtwdev)
>  {
>  	u32 val32;
> @@ -2623,6 +2752,7 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_be = {
>  	.set_cpuio = set_cpuio_be,
>  	.dle_quota_change = dle_quota_change_be,
>  
> +	.reset_pwr_state = rtw89_mac_reset_pwr_state_be,
>  	.disable_cpu = rtw89_mac_disable_cpu_be,
>  	.fwdl_enable_wcpu = rtw89_mac_fwdl_enable_wcpu_be,
>  	.fwdl_get_status = fwdl_get_status_be,
> diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
> index 5b4a459cf29c..fb641cefa4c9 100644
> --- a/drivers/net/wireless/realtek/rtw89/reg.h
> +++ b/drivers/net/wireless/realtek/rtw89/reg.h
> @@ -149,6 +149,7 @@
>  #define R_AX_WLLPS_CTRL 0x0090
>  #define B_AX_LPSOP_ASWRM BIT(17)
>  #define B_AX_LPSOP_DSWRM BIT(9)
> +#define B_AX_FORCE_LEAVE_LPS BIT(3)
>  #define B_AX_DIS_WLBT_LPSEN_LOPC BIT(1)
>  #define SW_LPS_OPTION 0x0001A0B2
>  
> @@ -313,6 +314,9 @@
>  #define R_AX_IC_PWR_STATE 0x03F0
>  #define B_AX_WHOLE_SYS_PWR_STE_MASK GENMASK(25, 16)
>  #define B_AX_WLMAC_PWR_STE_MASK GENMASK(9, 8)
> +#define MAC_AX_MAC_OFF 0
> +#define MAC_AX_MAC_ON 1
> +#define MAC_AX_MAC_LPS 2
>  #define B_AX_UART_HCISYS_PWR_STE_MASK GENMASK(7, 6)
>  #define B_AX_SDIO_HCISYS_PWR_STE_MASK GENMASK(5, 4)
>  #define B_AX_USB_HCISYS_PWR_STE_MASK GENMASK(3, 2)
> @@ -2094,6 +2098,7 @@
>  #define B_AX_B1_ISR_ERR_USRCTL_REINIT BIT(0)
>  
>  #define R_AX_AFE_CTRL1 0x0024
> +#define B_AX_CMAC_CLK_SEL BIT(21)
>  
>  #define B_AX_R_SYM_WLCMAC1_P4_PC_EN BIT(4)
>  #define B_AX_R_SYM_WLCMAC1_P3_PC_EN BIT(3)
> @@ -2107,6 +2112,12 @@
>  #define B_AX_R_SYM_FEN_WLBBFUN_1 BIT(16)
>  #define B_AX_R_SYM_ISO_CMAC12PP BIT(5)
>  
> +#define R_AX_SYSON_FSM_MON 0x00A0
> +#define B_AX_FSM_MON_SEL_MASK GENMASK(26, 24)
> +#define B_AX_DOP_ELDO BIT(23)
> +#define B_AX_FSM_MON_UPD BIT(15)
> +#define B_AX_FSM_PAR_MASK GENMASK(14, 0)
> +
>  #define R_AX_CMAC_REG_START 0xC000
>  
>  #define R_AX_CMAC_FUNC_EN 0xC000
> @@ -4172,6 +4183,22 @@
>  #define B_BE_LPSROP_LOWPWRPLL BIT(7)
>  #define B_BE_LPSROP_DSWRSD_SEL_MASK GENMASK(5, 4)
>  
> +#define R_BE_SYSON_FSM_MON 0x00A0
> +#define B_BE_FSM_MON_SEL_MASK GENMASK(26, 24)
> +#define B_BE_DOP_ELDO BIT(23)
> +#define B_BE_AFE_PLL_BYPASS BIT(22)
> +#define B_BE_PON_SWR_BYPASS BIT(21)
> +#define B_BE_PON_ADIE_BYPASS BIT(20)
> +#define B_BE_AFE_LS_BYPASS BIT(19)
> +#define B_BE_BTPMC_XTAL_SI_BYPASS BIT(17)
> +#define B_BE_WLPMC_XTAL_SI_BYPASS BIT(16)
> +#define B_BE_FSM_MON_UPD BIT(15)
> +#define B_BE_FSM_PAR_MASK GENMASK(14, 0)
> +#define WLAN_FSM_MASK 0xFFFFFF
> +#define WLAN_FSM_SET 0x4000000
> +#define WLAN_FSM_STATE_MASK 0x1FF
> +#define WLAN_FSM_IDLE 0
> +
>  #define R_BE_EFUSE_CTRL_2_V1 0x00A4
>  #define B_BE_EF_ENT BIT(31)
>  #define B_BE_EF_TCOLUMN_EN BIT(29)


