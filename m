Return-Path: <linux-wireless+bounces-19241-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B09DA3EA98
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Feb 2025 03:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FF51700BA4
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Feb 2025 02:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DEB157A72;
	Fri, 21 Feb 2025 02:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="EaAjrST5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F229F1D63C7
	for <linux-wireless@vger.kernel.org>; Fri, 21 Feb 2025 02:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740103873; cv=none; b=t9Dw3I7wLhQKoo/iDF5SEU8PIBLF9qk7EUOqO5EycG3/9MylZ5ziLf6VP/gkS3cYrHc5Wm8foKiyLUMyswkowQ6wJAVTo8UBwdHTyC9rPkVa03Bpb2tabtfC9tj8c7GWB3/pVQKBRs2d1JviKA19MeEebsInQ3GnjzTzPz49vCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740103873; c=relaxed/simple;
	bh=LetCeiMoQITn0q0MwrFrU6wjaB6vlpH/nQAdir1Qvt8=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=cZ4hykRLH95+D1mWLjH4wPCoUQS0TbHET/vmHEkWBxBkbMj2U1XOJrkFw1W4opWiANZesccTmqz6KiwvHAkMznzRYs7bhCYcsFJjNUy4hbZ/uGDGC7dBTw369c07fkyisz5OM4KM/YXfVMCSJY1HnujG8/AaWV20z24enA/Uj7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=EaAjrST5; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51L2B8AR0853322, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1740103868; bh=LetCeiMoQITn0q0MwrFrU6wjaB6vlpH/nQAdir1Qvt8=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=EaAjrST53eMx9AxWNiz5wSOeNewSA9FPdzJZdu2iDZZgpZK8rEdiSR6QRuEeTd3FM
	 4iKswFgQ2oJQEfog3twPEoBUEXl4LjNH6bRqfHevLVsKxhOKhQF2bRr++v4pdMU7ap
	 xltPDIoTi3CcvhGIQsnY0yS3vFCg1jSu1+9riQ498wiI+Tk5igcsAoHOJICiUbe7z6
	 Q0Z8ZyluMOL1lFgs4dM/r90OhEbI6QK2Pcvsfd1BgHxwuOKMI7ND4HVBmHR0LrDQo6
	 ZcaFEqb8tXTbZm5P+3HDMywoWZgtuju6h2vIyNcoxAApW3fChv5oJYZwuTQIUy4wFo
	 l4gboZxmR59MQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51L2B8AR0853322
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 10:11:08 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 21 Feb 2025 10:11:08 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 21 Feb
 2025 10:11:07 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Ping-Ke Shih <pkshih@realtek.com>
Subject: Re: [PATCH v3 1/8] wifi: rtw88: Fix rtw_mac_power_switch() for RTL8814AU
In-Reply-To: <2f0fcffb-3067-4d95-a68c-f2f3a5a47921@gmail.com>
References: <3908a496-d687-40fb-a1af-6add5c7e1dd4@gmail.com> <2f0fcffb-3067-4d95-a68c-f2f3a5a47921@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <78c60cb9-47da-466f-9a7e-b671953efaa0@RTEXMBS04.realtek.com.tw>
Date: Fri, 21 Feb 2025 10:11:07 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> rtw_mac_power_switch() checks bit 8 of REG_SYS_STATUS1 to see if the
> chip is powered on. This bit appears to be always on in the RTL8814AU,
> so ignore it.
> 
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

8 patch(es) applied to rtw-next branch of rtw.git, thanks.

e66bca16638e wifi: rtw88: Fix rtw_mac_power_switch() for RTL8814AU
86d04f8f991a wifi: rtw88: Fix rtw_desc_to_mcsrate() to handle MCS16-31
c7eea1ba05ca wifi: rtw88: Fix rtw_init_ht_cap() for RTL8814AU
6be7544d19fc wifi: rtw88: Fix rtw_init_vht_cap() for RTL8814AU
053a7aace020 wifi: rtw88: Fix rtw_rx_phy_stat() for RTL8814AU
8b42c46cf665 wifi: rtw88: Extend rtw_phy_config_swing_table() for RTL8814AU
cfebabdd351e wifi: rtw88: Extend rtw_debugfs_get_phy_info() for RTL8814AU
c374281f8285 wifi: rtw88: Extend rtw_debugfs_get_tx_pwr_tbl() for RTL8814AU

---
https://github.com/pkshih/rtw.git


