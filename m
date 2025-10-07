Return-Path: <linux-wireless+bounces-27865-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C40ABC22E8
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Oct 2025 18:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 816B219A5592
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Oct 2025 16:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266652E8DEA;
	Tue,  7 Oct 2025 16:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=martyn.welch@collabora.com header.b="BoQrBaYJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender4-op-o10.zoho.com (sender4-op-o10.zoho.com [136.143.188.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31A42E092E;
	Tue,  7 Oct 2025 16:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759855829; cv=pass; b=kg+ebGN15JfHsLQuMPucJziqeLyf6cv68cg/cgz8jrRZN4fVB+s4hFRkfy+Cyl6zy5KqzXX8t9X3uUrug4PQd5UKhVPlq60Qbv0F36illnulLwslsPMlHc/JOWmOdTSuDx3emE2fMbZHDIKgSckj4b6gKlBnxmd88AJk1YQ6QXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759855829; c=relaxed/simple;
	bh=qVgLaiSMFmjcTqtxzKUzSJ/p69getcGMTOUSmcceP4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=caOKLzLYRLm8V9qK1DNgnn1jrjf20sIhV8wVDP3bwdSpH5g2OlCt+fTKo5zIiuFb+Sg6iMHC3yaVY6S2V6quP3ACcxb2f8JZd1O/iEn9klazAH+FgfM60KGwt++6UH6GI9D692TdcEqTle6wVSqRPjXIMfFmw+vbvjFipUT03pk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=martyn.welch@collabora.com header.b=BoQrBaYJ; arc=pass smtp.client-ip=136.143.188.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1759855808; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=RXINFNUMUFs0v0nzjC3qR4mMK14+5vMGKJDGrb3dBlpkTk9PWpiT3HwtuoviTqPJJuJaF5swW+MQgdmEBqn7nLtMlH9xbGNXQTLlkzgHHs069eZM2UBBw/ClTbIdbspvIn7SD0mo6mNzQjGDoYrTG9JXe38X20MhSwBmqstUtNA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1759855808; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=28fTeNGRiLWS3FEGLkHs27peDqzHM2o/niSEx5qE1aw=; 
	b=KVU+38cJ3OzqvThnv5t/DLdhOzi1ss1Yn5bluyzoeCgQWyQjbCzOF2RaFRveraacUNhAwSUbYsJIxvlPgNnHbvJVI1MdI9NOWEfx/ARMxIr6g3iDO+yPjvT5BDkqzYvmxdr07VPncvElfXoMI2UWhEEjHtPXhV7zo6jul+/DHyU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=martyn.welch@collabora.com;
	dmarc=pass header.from=<martyn.welch@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1759855808;
	s=zohomail; d=collabora.com; i=martyn.welch@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=28fTeNGRiLWS3FEGLkHs27peDqzHM2o/niSEx5qE1aw=;
	b=BoQrBaYJFQTVosCRsESrAZwi4rNs0DvaT9Ty2f/CP41UYN+8ZKsymWoX58kk7FFa
	1+CgX7FRohIGF1KY9lGrlBvrnCVKkiTdqxXr+j7NuiQMJmYlroTFyaYvGsUl0n1S60u
	lPcWz+KSuE4gQGBV0Yu9ETOBsBT2AbMrDMmquBYY=
Received: by mx.zohomail.com with SMTPS id 1759855805204489.75007646978963;
	Tue, 7 Oct 2025 09:50:05 -0700 (PDT)
Message-ID: <164050d7-e0db-4a67-bf47-6d88e80d78ab@collabora.com>
Date: Tue, 7 Oct 2025 17:49:59 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/22] wifi: nxpwifi: create nxpwifi to support iw61x
To: Jeff Chen <jeff.chen_1@nxp.com>, linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, briannorris@chromium.org,
 johannes@sipsolutions.net, francesco@dolcini.it, tsung-hsien.hsieh@nxp.com,
 s.hauer@pengutronix.de, brian.hsu@nxp.com
References: <20250804154018.3563834-1-jeff.chen_1@nxp.com>
Content-Language: en-US
From: Martyn Welch <martyn.welch@collabora.com>
In-Reply-To: <20250804154018.3563834-1-jeff.chen_1@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 04/08/2025 16:39, Jeff Chen wrote:
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

This seems to be working well for me, at least for Wifi. I'd like to get 
Bluetooth up as well. The bluetooth driver (btnxpuart) doesn't seem 
happy loading the bluetooh firmware:

[   35.930755] Bluetooth: hci0: Request Firmware: nxp/uartspi_n61x_v1.bin.se
[   37.953107] Bluetooth: hci0: FW Download Complete: 396444 bytes
[   37.953167] Bluetooth: hci0: Frame reassembly failed (-84)
[   39.277635] Bluetooth: hci0: Frame reassembly failed (-84)
[   39.292011] Bluetooth: hci0: Frame reassembly failed (-84)
[   39.310094] Bluetooth: hci0: Frame reassembly failed (-84)
[   39.330273] Bluetooth: hci0: Frame reassembly failed (-84)
[   39.351381] Bluetooth: hci0: Frame reassembly failed (-84)
[   39.373112] Bluetooth: hci0: Frame reassembly failed (-84)
[   41.353087] Bluetooth: hci0: Opcode 0x1002 failed: -110
[   41.358411] Bluetooth: hci0: command 0x1002 tx timeout

I think the "combo" firmware needs to be loaded by the WiFi driver 
right? I assume this isn't supported yet?

Martyn

> Data sheet is available at:
> https://www.nxp.com/docs/en/data-sheet/IW612.pdf
> 
> Change history:
> 
> v5:
>     - Fixed build errors introduced in v4.
> 
> v4:
>     - Added support for TWT (STA mode)
>     - Added support for Monitor mode
>     - Added support for WPA3 Enterprise Suite-B
>     - Bug fix: In BGN/AN HT40 mode, throughput was 50% lower than expected
>     - Bug fix: In STA 2.4G HE40 mode, throughput was 80% lower than expected
>     - Use wiphy work instead of general workqueue for cfg80211 ops
>     - Introduced RCU protection for ba, rx_reorder, and sta_lists
>     - Used per-TID spinlock for tx_ba / rx_reorder lists to improve
>       concurrency
>     - Replaced mutex_lock with wiphy_lock
>     - Reverted "use tasklet for Rx" (back to workqueue)
>     - Refactored HE capability handling for better clarity and
>       maintainability
>     - Used standard kernel helpers for MAC address handling
>     - Replaced proprietary nxpwifi_ieee80211 with standard ieee80211_mgmt
>       structure
>     - Used u32_get_bits() for VHT capability field access
>     - Replaced LOW_PRIO_TID with TC_PRIO_BESTEFFORT for skb priority
>     - Removed static WPA/RSN OUI table; now derived from cipher suite ID
>     - Removed redundant helper functions: has_vendor_hdr and has_ieee_hdr
> 
> v3:
>     - Enable 802.11ax (Wi-Fi 6) for both AP and STA mode.
>     - Extend driver verion string with hotfix number.
>     - Remove Rx mlme work.
>     - Remove all useless check of netif_carrier_ok().
>     - Merge decl.h to cfg.h.
>     - Remove unnecessary check for wiphy parameters setting.
>     - Synchronize following commits from Mwifiex:
>       wifi: mwifiex: replace open-coded module_sdio_driver()
>       wifi: mwifiex: Fix interface type change
>       wifi: mwifiex: Do not return unused priv in mwifiex_get_priv_by_id()
>       wifi: mwifiex: increase max_num_akm_suites
>       wifi: mwifiex: duplicate static structs used in driver instances
>       wifi: mwifiex: keep mwifiex_cfg80211_ops constant
>       wifi: mwifiex: Fix uninitialized variable in
>                      mwifiex_cfg80211_authenticate()
>       wifi: mwifiex: remove unnecessary checks for valid priv
>       wifi: mwifiex: Fix memcpy() field-spanning write warning in
>                      mwifiex_cmd_802_11_scan_ext()
>       wifi: mwifiex: Use IRQF_NO_AUTOEN flag in request_irq()
> 
> v2:
>     - Rename ioctl.h and sta_ioctl.c to cfg.h and sta_cfg.c.
>     - Remove useless header file semaphore.h.
>     - Use static variable for cookie.
>     - Modify nxpwifi_register to use ERR_PTR, IS_ERR and PTR_ERR.
>     - Use error number for error code.
>     - Remove unnecessary private ie definitions.
>     - Remove mutex async_mutex and related code.
>     - Remove unnecessary work queue.
>     - Add the support for PSK SHA256.
>     - Use tasklet for Rx.
>     - Remove unused functions.
>     - Remove compile warning.
> 
> Jeff Chen (22):
>    wifi: nxpwifi: add 802.11n files
>    wifi: nxpwifi: add 802.11ac files
>    wifi: nxpwifi: add 802.11ax files
>    wifi: nxpwifi: add 802.11h file
>    wifi: nxpwifi: add WMM files
>    wifi: nxpwifi: add scan.c
>    wifi: nxpwifi: add join.c
>    wifi: nxpwifi: add cfp.c
>    wifi: nxpwifi: add configuration files
>    wifi: nxpwifi: implement cfg80211 ops
>    wifi: nxpwifi: add host command file
>    wifi: nxpwifi: add command and event files
>    wifi: nxpwifi: add data path files
>    wifi: nxpwifi: add debugfs file
>    wifi: nxpwifi: add ethtool.c
>    wifi: nxpwifi: add utility files
>    wifi: nxpwifi: add initialization file
>    wifi: nxpwifi: add core files
>    wifi: nxpwifi: add sdio bus driver files
>    wifi: nxpwifi: modify sdio_ids.h
>    wifi: nxpwifi: add makefile and kconfig files
>    wifi: nxpwifi: modify MAINTAINERS file
> 
>   MAINTAINERS                                   |    9 +
>   drivers/net/wireless/Kconfig                  |    1 +
>   drivers/net/wireless/Makefile                 |    1 +
>   drivers/net/wireless/nxp/Kconfig              |   17 +
>   drivers/net/wireless/nxp/Makefile             |    3 +
>   drivers/net/wireless/nxp/nxpwifi/11ac.c       |  289 ++
>   drivers/net/wireless/nxp/nxpwifi/11ac.h       |   32 +
>   drivers/net/wireless/nxp/nxpwifi/11ax.c       |  590 +++
>   drivers/net/wireless/nxp/nxpwifi/11ax.h       |   72 +
>   drivers/net/wireless/nxp/nxpwifi/11h.c        |  346 ++
>   drivers/net/wireless/nxp/nxpwifi/11n.c        |  895 ++++
>   drivers/net/wireless/nxp/nxpwifi/11n.h        |  167 +
>   drivers/net/wireless/nxp/nxpwifi/11n_aggr.c   |  275 ++
>   drivers/net/wireless/nxp/nxpwifi/11n_aggr.h   |   21 +
>   .../net/wireless/nxp/nxpwifi/11n_rxreorder.c  |  938 ++++
>   .../net/wireless/nxp/nxpwifi/11n_rxreorder.h  |   71 +
>   drivers/net/wireless/nxp/nxpwifi/Kconfig      |   22 +
>   drivers/net/wireless/nxp/nxpwifi/Makefile     |   39 +
>   drivers/net/wireless/nxp/nxpwifi/cfg.h        |  984 ++++
>   drivers/net/wireless/nxp/nxpwifi/cfg80211.c   | 4071 +++++++++++++++++
>   drivers/net/wireless/nxp/nxpwifi/cfg80211.h   |   19 +
>   drivers/net/wireless/nxp/nxpwifi/cfp.c        |  475 ++
>   drivers/net/wireless/nxp/nxpwifi/cmdevt.c     | 1284 ++++++
>   drivers/net/wireless/nxp/nxpwifi/cmdevt.h     |   98 +
>   drivers/net/wireless/nxp/nxpwifi/debugfs.c    | 1230 +++++
>   drivers/net/wireless/nxp/nxpwifi/ethtool.c    |   58 +
>   drivers/net/wireless/nxp/nxpwifi/fw.h         | 2401 ++++++++++
>   drivers/net/wireless/nxp/nxpwifi/ie.c         |  501 ++
>   drivers/net/wireless/nxp/nxpwifi/init.c       |  684 +++
>   drivers/net/wireless/nxp/nxpwifi/join.c       |  911 ++++
>   drivers/net/wireless/nxp/nxpwifi/main.c       | 1716 +++++++
>   drivers/net/wireless/nxp/nxpwifi/main.h       | 1850 ++++++++
>   drivers/net/wireless/nxp/nxpwifi/scan.c       | 2805 ++++++++++++
>   drivers/net/wireless/nxp/nxpwifi/sdio.c       | 2656 +++++++++++
>   drivers/net/wireless/nxp/nxpwifi/sdio.h       |  340 ++
>   drivers/net/wireless/nxp/nxpwifi/sta_cfg.c    | 1319 ++++++
>   drivers/net/wireless/nxp/nxpwifi/sta_cmd.c    | 3449 ++++++++++++++
>   drivers/net/wireless/nxp/nxpwifi/sta_event.c  |  868 ++++
>   drivers/net/wireless/nxp/nxpwifi/sta_rx.c     |  250 +
>   drivers/net/wireless/nxp/nxpwifi/sta_tx.c     |  208 +
>   drivers/net/wireless/nxp/nxpwifi/txrx.c       |  358 ++
>   drivers/net/wireless/nxp/nxpwifi/uap_cmd.c    | 1234 +++++
>   drivers/net/wireless/nxp/nxpwifi/uap_event.c  |  490 ++
>   drivers/net/wireless/nxp/nxpwifi/uap_txrx.c   |  506 ++
>   drivers/net/wireless/nxp/nxpwifi/util.c       | 1580 +++++++
>   drivers/net/wireless/nxp/nxpwifi/util.h       |  132 +
>   drivers/net/wireless/nxp/nxpwifi/wmm.c        | 1379 ++++++
>   drivers/net/wireless/nxp/nxpwifi/wmm.h        |   78 +
>   include/linux/mmc/sdio_ids.h                  |    3 +
>   49 files changed, 37725 insertions(+)
>   create mode 100644 drivers/net/wireless/nxp/Kconfig
>   create mode 100644 drivers/net/wireless/nxp/Makefile
>   create mode 100644 drivers/net/wireless/nxp/nxpwifi/11ac.c
>   create mode 100644 drivers/net/wireless/nxp/nxpwifi/11ac.h
>   create mode 100644 drivers/net/wireless/nxp/nxpwifi/11ax.c
>   create mode 100644 drivers/net/wireless/nxp/nxpwifi/11ax.h
>   create mode 100644 drivers/net/wireless/nxp/nxpwifi/11h.c
>   create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n.c
>   create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n.h
>   create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n_aggr.c
>   create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n_aggr.h
>   create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n_rxreorder.c
>   create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n_rxreorder.h
>   create mode 100644 drivers/net/wireless/nxp/nxpwifi/Kconfig
>   create mode 100644 drivers/net/wireless/nxp/nxpwifi/Makefile
>   create mode 100644 drivers/net/wireless/nxp/nxpwifi/cfg.h
>   create mode 100644 drivers/net/wireless/nxp/nxpwifi/cfg80211.c
>   create mode 100644 drivers/net/wireless/nxp/nxpwifi/cfg80211.h
>   create mode 100644 drivers/net/wireless/nxp/nxpwifi/cfp.c
>   create mode 100644 drivers/net/wireless/nxp/nxpwifi/cmdevt.c
>   create mode 100644 drivers/net/wireless/nxp/nxpwifi/cmdevt.h
>   create mode 100644 drivers/net/wireless/nxp/nxpwifi/debugfs.c
>   create mode 100644 drivers/net/wireless/nxp/nxpwifi/ethtool.c
>   create mode 100644 drivers/net/wireless/nxp/nxpwifi/fw.h
>   create mode 100644 drivers/net/wireless/nxp/nxpwifi/ie.c
>   create mode 100644 drivers/net/wireless/nxp/nxpwifi/init.c
>   create mode 100644 drivers/net/wireless/nxp/nxpwifi/join.c
>   create mode 100644 drivers/net/wireless/nxp/nxpwifi/main.c
>   create mode 100644 drivers/net/wireless/nxp/nxpwifi/main.h
>   create mode 100644 drivers/net/wireless/nxp/nxpwifi/scan.c
>   create mode 100644 drivers/net/wireless/nxp/nxpwifi/sdio.c
>   create mode 100644 drivers/net/wireless/nxp/nxpwifi/sdio.h
>   create mode 100644 drivers/net/wireless/nxp/nxpwifi/sta_cfg.c
>   create mode 100644 drivers/net/wireless/nxp/nxpwifi/sta_cmd.c
>   create mode 100644 drivers/net/wireless/nxp/nxpwifi/sta_event.c
>   create mode 100644 drivers/net/wireless/nxp/nxpwifi/sta_rx.c
>   create mode 100644 drivers/net/wireless/nxp/nxpwifi/sta_tx.c
>   create mode 100644 drivers/net/wireless/nxp/nxpwifi/txrx.c
>   create mode 100644 drivers/net/wireless/nxp/nxpwifi/uap_cmd.c
>   create mode 100644 drivers/net/wireless/nxp/nxpwifi/uap_event.c
>   create mode 100644 drivers/net/wireless/nxp/nxpwifi/uap_txrx.c
>   create mode 100644 drivers/net/wireless/nxp/nxpwifi/util.c
>   create mode 100644 drivers/net/wireless/nxp/nxpwifi/util.h
>   create mode 100644 drivers/net/wireless/nxp/nxpwifi/wmm.c
>   create mode 100644 drivers/net/wireless/nxp/nxpwifi/wmm.h
> 


