Return-Path: <linux-wireless+bounces-18688-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1EAA2E2E3
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2025 04:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACC95188799E
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2025 03:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1169546447;
	Mon, 10 Feb 2025 03:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="L+OBY37E"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BBCEAF9
	for <linux-wireless@vger.kernel.org>; Mon, 10 Feb 2025 03:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739159051; cv=none; b=WKO0VgFbpfWrdgZ5BGM80BOMBUza9r+gmYpOUI5v7j2qARSiR2hPqWwAU5uvWhvMTbLmmVwJqfDu/RZkxuakUX9GbpUhON8/n+ZyXSj+l2p9YGA3bNT/3ofCjC4AE2SLCM61HaOQgojl4pSM9s2OzUUjmRBqdUrnMVKgPUx/WrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739159051; c=relaxed/simple;
	bh=5V9YSwEwGcgAUuRdscLm7/9ZZtU7awv55D48d02F+04=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=sEoPIsLQY8ERD5T2b3piClbKzJwiKtqCqrpZvR4v2rCjfONmxviptI4yyK0iYeRGMJeP/QYc7KJ+gekQSYJW5DHIhUc6bSXpjXZAdRuciz4xSylMqsMsQZtY1eqNGAFmUd3dmYmf2cI3HWzto8ELEgaut6fEMm3ygCyfrr20yHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=L+OBY37E; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51A3i5Vo91593598, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1739159045; bh=5V9YSwEwGcgAUuRdscLm7/9ZZtU7awv55D48d02F+04=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=L+OBY37EwYpePESW6wT1kgloX5Wan0tLSyaoZQGcmPwtYQaRNdj9ZcVYUalGOMxfo
	 SX7QITXrAdjsVDkQxpjZQ5KSs56yZ2cC1DUUMZ/QO5dnaeBymWSG+1uDbw9dqQr0X7
	 bPnuasiZSJJzMkjXjb4WGt7S4n2R6pHpWujp1MPyGIQPTO0alSaOAvLWr9OxCHGGah
	 VioD/mO882oUyKP8HQIQH1Pgbwj/QUub4n5SdtEMOBY3qlBwhBhuorzVW0cBTECW8I
	 mlVQiejpqW62ClB3ju1GT9gV3GktmUJadDuANI2S/3LIMq7eKe+ctt+ZCFXRQqtpFy
	 ECv0ExspSP2ng==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51A3i5Vo91593598
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Feb 2025 11:44:05 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 10 Feb 2025 11:44:06 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 10 Feb
 2025 11:44:05 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Ping-Ke Shih <pkshih@realtek.com>
Subject: Re: [PATCH v2 1/9] wifi: rtw88: Fix __rtw_download_firmware() for RTL8814AU
In-Reply-To: <55b5641f-094e-4f94-9f79-ac053733f2cf@gmail.com>
References: <9fc518ae-7708-42c6-99ca-56ee307555b6@gmail.com> <55b5641f-094e-4f94-9f79-ac053733f2cf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <d952bf69-6109-4d9e-a0c3-19a596102cdc@RTEXMBS04.realtek.com.tw>
Date: Mon, 10 Feb 2025 11:44:05 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> Don't call ltecoex_read_reg() and ltecoex_reg_write() when the
> ltecoex_addr member of struct rtw_chip_info is NULL. The RTL8814AU
> doesn't have this feature.
> 
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

9 patch(es) applied to rtw-next branch of rtw.git, thanks.

8425f5c8f04d wifi: rtw88: Fix __rtw_download_firmware() for RTL8814AU
9e8243025cc0 wifi: rtw88: Fix download_firmware_validate() for RTL8814AU
62f726848da4 wifi: rtw88: Extend struct rtw_pwr_track_tbl for RTL8814AU
d80e7d9b6ba3 wifi: rtw88: Extend rf_base_addr and rf_sipi_addr for RTL8814AU
8f0076726b66 wifi: rtw88: Extend rtw_fw_send_ra_info() for RTL8814AU
e66f3b5c7535 wifi: rtw88: Constify some more structs and arrays
ad815f392003 wifi: rtw88: Rename RTW_RATE_SECTION_MAX to RTW_RATE_SECTION_NUM
0f98a5959657 wifi: rtw88: Extend TX power stuff for 3-4 spatial streams
9f00e2218e15 wifi: rtw88: Fix rtw_update_sta_info() for RTL8814AU

---
https://github.com/pkshih/rtw.git


