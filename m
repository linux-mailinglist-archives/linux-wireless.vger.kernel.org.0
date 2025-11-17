Return-Path: <linux-wireless+bounces-29061-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBE2C65E28
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Nov 2025 20:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 003C74EAAEC
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Nov 2025 19:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAD7239E7D;
	Mon, 17 Nov 2025 19:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="To/SAtel";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RcJgnNT1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277F32EF65A
	for <linux-wireless@vger.kernel.org>; Mon, 17 Nov 2025 19:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763406632; cv=none; b=pozrTV5yXYpujPfMfvUk/O/vFm9vUFw/dNiUkMu6Bb2QNYJCe6vmYknB5GXRjTFwnLXsIQlZ7eYJV07Mf39W5uYhyD6AMp9SUwRpaB5Csx0zgNh3lgGjdwp/FOeat2BefnQq5uk/UIurSfC8BBPvAJOnQqIWd9Ab6Z4uROiTMkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763406632; c=relaxed/simple;
	bh=gVx+dImU0mH8p49jvZ1t52KiKxA7dY7vfAiebk8pmGU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YUeopzdALVHr+eRXtCBvt5erhYJLHqB+YQOzrhOg8dhrHZt+T8rbuFoUuVgDFlMrSrqZu2KhflUH5XLL4cGrFt/0jgVm/0Jk5PZSiL+ekd7ptQt0fgQSQ4c8v2IWEQPRKjl8xbsDsMZ7lkEBVEcBlykSdXx9DXdHV2xe8hwMA2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=To/SAtel; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RcJgnNT1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AHB6B2u4107917
	for <linux-wireless@vger.kernel.org>; Mon, 17 Nov 2025 19:10:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	M8kwY6wwLr3e/ReeYIZHpisyPqAUeytDZhK/1Crec4Y=; b=To/SAtelZQQhLhbg
	XLEgShQNm4p3fsnhDWTKYcITfrBYTQ3GlAcQVkn+Fmg8gdeCePgWGw/DOJjAqzzr
	VWUyw1qmw9vUY17KeKUY/RizLYPCeOTJ2hjBCA6owOuxzV0Hxfl8ExzMnPbpLWxh
	qP/tfi0VdDXM45zNoGyigqiuNwZHJdUgpj6SJibabcSo72jSC4AUuFQhYpnNCrGf
	LfzILwvqqQkQSGClpRzKOVmboss3xR4GJ2bcS2RkLK5nXRkE6+t9oIUYzLM37lOC
	2Mxol1+tm+ZVq7HSMJa2041tkIcjPClVKxK5d5RadfiitomLIOMqIAAexLKQV7L7
	aZ+kWw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ag2hp9djv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 17 Nov 2025 19:10:28 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2956f09f382so41016525ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 17 Nov 2025 11:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763406627; x=1764011427; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M8kwY6wwLr3e/ReeYIZHpisyPqAUeytDZhK/1Crec4Y=;
        b=RcJgnNT1HjO9SML0nofe7X0QNzcDClb6QdSiptUQIKPJIuhRjiheGzJvMlj1KQPIB2
         Ourx3BCSyde7pRRo4LCedKh+/9LswFJLJ53WOcnhlXYBWfBke4VIeuc1MfV3YWkVMITm
         i2a/4F+wdtJVNYaOEc1zqWJmP2BaW/1O682MkkWi8IkLd9mVafBlP0bGdQO3izg8h29y
         hcztGmlM/gSsnl4GRY9L/S8//5k3OinDYE2qL8tUDXNDba/g+odFJeBEXLif84vsAWxW
         wHkbzpeabBb4/AUMhuoVoibxn3lET2iPcfY82H61mK0DgJG6B2ypX9b580Yus10M7bQI
         AaPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763406627; x=1764011427;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M8kwY6wwLr3e/ReeYIZHpisyPqAUeytDZhK/1Crec4Y=;
        b=lZ4AIbSuV25iR5BgCPKuMHJW4cTsh+bzQzYXSHBYlBlyg8OKA3UcFetbl+L0AZxePt
         Cys8xIR31e3Vgxjw/CyECI2ooruACMlCkFAKUlf1ywiGcB96fq+3emzfJyXX/DqRNqKg
         IPVjnQ3qxQgEkZ5jZGMJHXrysderjYokP5QDFHxX5YSmTxnLD7KrhbQYnOPvIRfs9zdy
         90uapPoZIbtXGBpWFlRuQ0PTwshPTPSmBNp3E6DVCj5ENM1IxaiWrfV7GB04gtW4ETZ8
         Yn8MWzTcKzW49uRBchbLud4rvpn+dBo/p6upqCzYnKp8L2tANXSfxHJGzROYdjWbZGjW
         gy4A==
X-Forwarded-Encrypted: i=1; AJvYcCWiAuV7Dnb5eVyxntVZOf2PZCsmjZ9nxNHDzUHM6W/XOVoKuUAQjJqXRw4tcyGELA7HZJnWP5bc77v+TX0WIw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyIYYQXpstSwQK1wxBFudEBRjCxXlTbMgMgZeHSEyYgNTsRwDrp
	sbt/3VTdXySj/7OHlM3IPiz7A84SYM4K/LE6LCPiGBlkEOtWel55fWBvlBSGGumRRh/iZpZRQHn
	24otaa9RkEMbocMjw5XCI0WkW5RdY8R3ovpstExx/2gh2n0NdQB2tAKgu1M0UdXVnU3+biofwye
	mRvQ==
X-Gm-Gg: ASbGnctIC9WxovpiJE6XW3MnUi5kjvAVXxK9MUH7VSle8TlCHgaHvVKTLE4x116vQgN
	5mDg+T9Yg2bX2puC04FlQohG5IfrMtmDvmNLyL0gHBg3imMwV0+fzyWXg1FCL3M3zB1NIqmcNJH
	2WanSxPFd94JdWi37CCwO9oCGGT9Gr/sK/LgVIaEa+AZJiTe1OgsKuBoE1x11gS+1J1pOD53sPT
	R7e6N2kb6CRF0Zd0ytV3m3ywV5lx71wLLdoBzT5UQTbqAufnFKpVeYueau7hIQgahRu7K9pt0mu
	3CWXuyLGTQwxDN1l068bTn+EKZS2PqeM+zMT2GlRaYwGk/i4IQm2s9FVDf4ddF7JoDGqfTefesD
	tj8g9IrWRu8/aEuYBDZtJaEklyfgH9iX85OAHGQ1zcDsiaAD+O4s1AGCa7+YnefxgmVkwVG8zKq
	pW
X-Received: by 2002:a17:902:fc50:b0:294:fc77:f041 with SMTP id d9443c01a7336-299f559eb9cmr3272295ad.25.1763406627267;
        Mon, 17 Nov 2025 11:10:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHth8ezHCDAqla5er6zuP+EWk/SHiWLQ1I5YwnhxzhKVQcPn7t+K5hMnbqTjZTlrX8PZNczkQ==
X-Received: by 2002:a17:902:fc50:b0:294:fc77:f041 with SMTP id d9443c01a7336-299f559eb9cmr3272005ad.25.1763406626659;
        Mon, 17 Nov 2025 11:10:26 -0800 (PST)
Received: from [192.168.1.3] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2b0d91sm149015765ad.63.2025.11.17.11.10.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Nov 2025 11:10:26 -0800 (PST)
Message-ID: <fe78857f-956c-439e-a1a7-95ea19c8e932@oss.qualcomm.com>
Date: Mon, 17 Nov 2025 11:10:24 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/22] wifi: nxpwifi: create nxpwifi to support iw61x
To: Jeff Chen <jeff.chen_1@nxp.com>, linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, briannorris@chromium.org,
        johannes@sipsolutions.net, francesco@dolcini.it,
        tsung-hsien.hsieh@nxp.com, s.hauer@pengutronix.de
References: <20251117110046.2810811-1-jeff.chen_1@nxp.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20251117110046.2810811-1-jeff.chen_1@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 5WoKj5fMV9x_ZZGJbe_UsLn6Qiv5sYMa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE3MDE2MiBTYWx0ZWRfXyAqCjFhV/Lw+
 TjbW9q/RGSP8FI1QZKx2xy7XpOTcBkVJKJS+TbubZsp3pXBwd4TnnWGypTLYHfSXQaE1yXXTyxD
 JKJ9e9QbOVpedAMkfsrBOdWFgtT2A1jzzxzZvBYQcocCe8lus5sdgsnLqDk5xI63j0L9CNUihHj
 SldqKlFxWItnMuhMmH3vRaWm+XzYdo1Myu6AX1YVmBYfsWapRcOo+3Ajs57s/1MEcH/b/mDgvvO
 UG/mCbNANHmfESmUsY6R/svowN9RUnjZDvenPtfnGMg4+DOyz415agK5z3xouIwUedh+tB2ONdO
 qkXR0o7vOGtS0US6aXP++HGBI+eob8KjECOeksVhCM+hxJPAZuOTkEJs7SLAhjTARK6u7jRAH5m
 LwWndII2i5N2rhRwg/iVjcQgHt9FIQ==
X-Proofpoint-ORIG-GUID: 5WoKj5fMV9x_ZZGJbe_UsLn6Qiv5sYMa
X-Authority-Analysis: v=2.4 cv=Y5L1cxeN c=1 sm=1 tr=0 ts=691b7324 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8AirrxEcAAAA:8 a=fVhn27ayIr7D5BXt32AA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_03,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 impostorscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511170162

On 11/17/2025 3:00 AM, Jeff Chen wrote:
> This series adds a new full-MAC Wi-Fi driver `nxpwifi` to support NXP IW61x
> chip family. These chips are tri-radio single-chip solutions with Wi-Fi 6
> (1x1, 2.4/5 GHz), Bluetooth 5.4, and IEEE 802.15.4. Communication with the
> external host is via SDIO interface. The driver is tested on i.MX8M Mini
> EVK in both STA and AP mode.
> 
> This driver is not based on mac80211. It derives from mwifiex, but due to
> significant differences in firmware architecture, host command interface,
> and supported features, it was not feasible to extend mwifiex without risk
> of regressions. Thus, a new driver is introduced. Future NXP Wi-Fi chipsets
> will also be supported under `nxpwifi`.
> 
> The driver passes checkpatch. WPA2/WPA3 personal/enterprise is currently
> handled in host via wpa_supplicant/hostapd.
> 
> v4 adds support for TWT, monitor mode, WPA3 Enterprise Suite-B, and various
> fixes and improvements. See below for full changelog.
> 
> Data sheet is available at:
> https://www.nxp.com/docs/en/data-sheet/IW612.pdf
> 
> Change history:
> 
> v7:
>    - Addressed review feedback from v6
>      - Removed unused variable `ext_rate_info` in `nxpwifi_rxpdinfo_to_radiotapinfo()
>      - Radiotap handling fixes:
>        - Converted fields to `__le16`/`__le64`
>        - Applied `cpu_to_le16()`/`cpu_to_le64()` for endian correctness
>        - Replaced `jiffies` with `ktime_get_ns()/1000` for timestamp
>        - Validated channel frequency conversion and removed redundant code
>    - General cleanup of endian conversions and Sparse warnings
>      - Improved HE capability setup via `_ieee80211_set_sband_iftype_data()`
>      - TWT configuration fixes:
>        - Updated structs to `__le16`/`__le32`
>        - Corrected debugfs write helpers for endian conversions
>        - Removed redundant conversions in `nxpwifi_cmd_twt_cfg()`
>      - Scan handling fixes:
>        - Changed OUI variables to `__be32`
>        - Used `le16_to_cpu()` for `ext_cap->header.len`
>        - Moved element pointer declaration outside `switch`
>      - HW spec parsing fix:
>        - Added `le32_to_cpu()` before `GET_MPDU_DENSITY()`
>      - Cfg80211 handling fix:
>        - Moved `legacy_rates[]` definition outside `switch` block
> 
> v6:
>    - Removed custom locking (main_locked, main_proc_lock, more_task_flag)
>    - Refactored main process to rely solely on workqueue
>    - SDIO interrupt now only queues main_work; avoids direct call to nxpwifi_main_process()
>    - Introduced atomic iface_changing flag to block main process during interface transitions
>    - Split monolithic main process logic into helper functions for better readability
>    - Improved exit logic to avoid lost-kick scenarios and ensure all pending tasks are processed
>    - Replaced rcu_read_lock()/unlock() pairs with guard(rcu)() for modern kernel style
>    - Code cleanups based on review feedback
> 
> v5:
>    - Fixed build errors introduced in v4.
> 
> v4:
>    - Added support for TWT (STA mode)
>    - Added support for Monitor mode
>    - Added support for WPA3 Enterprise Suite-B
>    - Bug fix: In BGN/AN HT40 mode, throughput was 50% lower than expected
>    - Bug fix: In STA 2.4G HE40 mode, throughput was 80% lower than expected
>    - Use wiphy work instead of general workqueue for cfg80211 ops
>    - Introduced RCU protection for ba, rx_reorder, and sta_lists
>    - Used per-TID spinlock for tx_ba / rx_reorder lists to improve
>      concurrency
>    - Replaced mutex_lock with wiphy_lock
>    - Reverted "use tasklet for Rx" (back to workqueue)
>    - Refactored HE capability handling for better clarity and
>      maintainability
>    - Used standard kernel helpers for MAC address handling
>    - Replaced proprietary nxpwifi_ieee80211 with standard ieee80211_mgmt
>      structure
>    - Used u32_get_bits() for VHT capability field access
>    - Replaced LOW_PRIO_TID with TC_PRIO_BESTEFFORT for skb priority
>    - Removed static WPA/RSN OUI table; now derived from cipher suite ID
>    - Removed redundant helper functions: has_vendor_hdr and has_ieee_hdr
> 
> v3:
>    - Enable 802.11ax (Wi-Fi 6) for both AP and STA mode.
>    - Extend driver verion string with hotfix number.
>    - Remove Rx mlme work.
>    - Remove all useless check of netif_carrier_ok().
>    - Merge decl.h to cfg.h.
>    - Remove unnecessary check for wiphy parameters setting.
>    - Synchronize following commits from Mwifiex:
>      wifi: mwifiex: replace open-coded module_sdio_driver()
>      wifi: mwifiex: Fix interface type change
>      wifi: mwifiex: Do not return unused priv in mwifiex_get_priv_by_id()
>      wifi: mwifiex: increase max_num_akm_suites
>      wifi: mwifiex: duplicate static structs used in driver instances
>      wifi: mwifiex: keep mwifiex_cfg80211_ops constant
>      wifi: mwifiex: Fix uninitialized variable in
>                     mwifiex_cfg80211_authenticate()
>      wifi: mwifiex: remove unnecessary checks for valid priv
>      wifi: mwifiex: Fix memcpy() field-spanning write warning in
>                     mwifiex_cmd_802_11_scan_ext()
>      wifi: mwifiex: Use IRQF_NO_AUTOEN flag in request_irq()
> 
> v2:
>    - Rename ioctl.h and sta_ioctl.c to cfg.h and sta_cfg.c.
>    - Remove useless header file semaphore.h.
>    - Use static variable for cookie.
>    - Modify nxpwifi_register to use ERR_PTR, IS_ERR and PTR_ERR.
>    - Use error number for error code.
>    - Remove unnecessary private ie definitions.
>    - Remove mutex async_mutex and related code.
>    - Remove unnecessary work queue.
>    - Add the support for PSK SHA256.
>    - Use tasklet for Rx.
>    - Remove unused functions.
>    - Remove compile warning.
> 
> Jeff Chen (22):
>   wifi: nxpwifi: Add 802.11n support for client and AP modes
>   wifi: nxpwifi: add initial support for 802.11ac
>   wifi: nxpwifi: add initial support for 802.11ax
>   wifi: nxpwifi: add support for 802.11h (DFS and TPC)
>   wifi: nxpwifi: add support for WMM
>   wifi: nxpwifi: add scan support
>   wifi: nxpwifi: add join and association support
>   wifi: nxpwifi: add channel/frequency/power (cfp) support
>   wifi: nxpwifi: add configuration support
>   wifi: nxpwifi: implement cfg80211 ops for STA and AP modes
>   wifi: nxpwifi: add firmware command and TLV definitions
>   wifi: nxpwifi: introduce command and event handling infrastructure
>   wifi: nxpwifi: add data path support for STA and AP modes
>   wifi: nxpwifi: add debugfs support for diagnostics and testing
>   wifi: nxpwifi: add ethtool support for Wake-on-LAN
>   wifi: nxpwifi: add utility and IE handling support
>   wifi: nxpwifi: add driver initialization and shutdown support
>   wifi: nxpwifi: add core driver implementation
>   wifi: nxpwifi: add initial SDIO bus driver support
>   wifi: nxpwifi: add NXP vendor and IW61x device IDs to sdio_ids.h
>   wifi: nxpwifi: add Kconfig and Makefile for kernel integration
>   wifi: nxpwifi: add MAINTAINERS entry for nxpwifi driver
> 
>  MAINTAINERS                                   |    8 +
>  drivers/net/wireless/Kconfig                  |    1 +
>  drivers/net/wireless/Makefile                 |    1 +
>  drivers/net/wireless/nxp/Kconfig              |   17 +
>  drivers/net/wireless/nxp/Makefile             |    3 +
>  drivers/net/wireless/nxp/nxpwifi/11ac.c       |  289 ++
>  drivers/net/wireless/nxp/nxpwifi/11ac.h       |   33 +
>  drivers/net/wireless/nxp/nxpwifi/11ax.c       |  596 +++
>  drivers/net/wireless/nxp/nxpwifi/11ax.h       |   77 +
>  drivers/net/wireless/nxp/nxpwifi/11h.c        |  346 ++
>  drivers/net/wireless/nxp/nxpwifi/11n.c        |  887 ++++
>  drivers/net/wireless/nxp/nxpwifi/11n.h        |  164 +
>  drivers/net/wireless/nxp/nxpwifi/11n_aggr.c   |  275 ++
>  drivers/net/wireless/nxp/nxpwifi/11n_aggr.h   |   21 +
>  .../net/wireless/nxp/nxpwifi/11n_rxreorder.c  |  924 ++++
>  .../net/wireless/nxp/nxpwifi/11n_rxreorder.h  |   71 +
>  drivers/net/wireless/nxp/nxpwifi/Kconfig      |   22 +
>  drivers/net/wireless/nxp/nxpwifi/Makefile     |   39 +
>  drivers/net/wireless/nxp/nxpwifi/cfg.h        |  984 ++++
>  drivers/net/wireless/nxp/nxpwifi/cfg80211.c   | 4049 +++++++++++++++++
>  drivers/net/wireless/nxp/nxpwifi/cfg80211.h   |   19 +
>  drivers/net/wireless/nxp/nxpwifi/cfp.c        |  475 ++
>  drivers/net/wireless/nxp/nxpwifi/cmdevt.c     | 1283 ++++++
>  drivers/net/wireless/nxp/nxpwifi/cmdevt.h     |   98 +
>  drivers/net/wireless/nxp/nxpwifi/debugfs.c    | 1221 +++++
>  drivers/net/wireless/nxp/nxpwifi/ethtool.c    |   58 +
>  drivers/net/wireless/nxp/nxpwifi/fw.h         | 2400 ++++++++++
>  drivers/net/wireless/nxp/nxpwifi/ie.c         |  500 ++
>  drivers/net/wireless/nxp/nxpwifi/init.c       |  680 +++
>  drivers/net/wireless/nxp/nxpwifi/join.c       |  910 ++++
>  drivers/net/wireless/nxp/nxpwifi/main.c       | 1834 ++++++++
>  drivers/net/wireless/nxp/nxpwifi/main.h       | 1836 ++++++++
>  drivers/net/wireless/nxp/nxpwifi/scan.c       | 2859 ++++++++++++
>  drivers/net/wireless/nxp/nxpwifi/sdio.c       | 2649 +++++++++++
>  drivers/net/wireless/nxp/nxpwifi/sdio.h       |  340 ++
>  drivers/net/wireless/nxp/nxpwifi/sta_cfg.c    | 1319 ++++++
>  drivers/net/wireless/nxp/nxpwifi/sta_cmd.c    | 3449 ++++++++++++++
>  drivers/net/wireless/nxp/nxpwifi/sta_event.c  |  868 ++++
>  drivers/net/wireless/nxp/nxpwifi/sta_rx.c     |  250 +
>  drivers/net/wireless/nxp/nxpwifi/sta_tx.c     |  208 +
>  drivers/net/wireless/nxp/nxpwifi/txrx.c       |  358 ++
>  drivers/net/wireless/nxp/nxpwifi/uap_cmd.c    | 1234 +++++
>  drivers/net/wireless/nxp/nxpwifi/uap_event.c  |  490 ++
>  drivers/net/wireless/nxp/nxpwifi/uap_txrx.c   |  506 ++
>  drivers/net/wireless/nxp/nxpwifi/util.c       | 1570 +++++++
>  drivers/net/wireless/nxp/nxpwifi/util.h       |  132 +
>  drivers/net/wireless/nxp/nxpwifi/wmm.c        | 1379 ++++++
>  drivers/net/wireless/nxp/nxpwifi/wmm.h        |   78 +
>  include/linux/mmc/sdio_ids.h                  |    3 +
>  49 files changed, 37813 insertions(+)
>  create mode 100644 drivers/net/wireless/nxp/Kconfig
>  create mode 100644 drivers/net/wireless/nxp/Makefile
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/11ac.c
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/11ac.h
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/11ax.c
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/11ax.h
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/11h.c
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n.c
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n.h
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n_aggr.c
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n_aggr.h
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n_rxreorder.c
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n_rxreorder.h
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/Kconfig
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/Makefile
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/cfg.h
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/cfg80211.c
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/cfg80211.h
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/cfp.c
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/cmdevt.c
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/cmdevt.h
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/debugfs.c
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/ethtool.c
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/fw.h
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/ie.c
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/init.c
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/join.c
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/main.c
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/main.h
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/scan.c
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/sdio.c
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/sdio.h
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/sta_cfg.c
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/sta_cmd.c
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/sta_event.c
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/sta_rx.c
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/sta_tx.c
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/txrx.c
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/uap_cmd.c
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/uap_event.c
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/uap_txrx.c
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/util.c
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/util.h
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/wmm.c
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/wmm.h
> 

So that this series would have an additional set of eyes I ran this through
the automation I use for ath.git.

It reports multiple instances of using the now obsolete networking multi-line
comment style.
Starting from the first patch:
+/* Fills HT capability information field, AMPDU Parameters field, HT extended
+/* This function returns the pointer to an entry in BA Stream
+/* This function handles the command response of delete a block
...

Current guidance is to use the standard multi-line comment style
/*
 * first line of comment
 * [more lines of comment]
 * last line of commnt
 */

It also flagged one incorrect use of kernel-doc comment style:
+       /** rate for LG pkt, RATE flag will be present, it shows datarate in

There are also numerous spelling issues reported by checkpatch.pl --codespell
TYPO_SPELLING: 'interation' may be misspelled - perhaps 'iteration'?
TYPO_SPELLING: 'Dimentions' may be misspelled - perhaps 'Dimensions'?
TYPO_SPELLING: 'interfacces' may be misspelled - perhaps 'interfaces'?
TYPO_SPELLING: 'formate' may be misspelled - perhaps 'format'?
TYPO_SPELLING: 'verion' may be misspelled - perhaps 'version'?
TYPO_SPELLING: 'Timstamp' may be misspelled - perhaps 'Timestamp'?
TYPO_SPELLING: 'intializes' may be misspelled - perhaps 'initializes'?
TYPO_SPELLING: 'statistc' may be misspelled - perhaps 'statistic'?

Also "wifi: nxpwifi: add initial SDIO bus driver support" reports
UNDOCUMENTED_DT_STRING: DT compatible string "nxp,iw61x" appears un-documented
-- check ./Documentation/devicetree/bindings/

Is there an associated DT patch out there?

The MAINTAINERS patch reports multiple instances of:
MAINTAINERS_STYLE: MAINTAINERS entries use one tab after TYPE:

So suggest you use all options to checkpatch.pl on your series

/jeff

