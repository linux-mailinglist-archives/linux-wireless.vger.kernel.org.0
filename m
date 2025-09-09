Return-Path: <linux-wireless+bounces-27118-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87EFCB49EA9
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 03:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4840A3ADAFC
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 01:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9F91E9906;
	Tue,  9 Sep 2025 01:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="eFCMFkB1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CFA1E5718
	for <linux-wireless@vger.kernel.org>; Tue,  9 Sep 2025 01:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757381072; cv=none; b=bvEimejh0OVyEXAvhRY4L9EkpirYd/A4Hky/XzsheWH8lleRzwN8cJK6Xhneh1jGKlDq/aB1YC5TZphh871bGTqQwBCN53j7lW6xqZ/4gk8WjhZ8VKWF/J2Nl1uZsj+AOarcyxDrdVLIuIyuD19SxVXeunFkIW/9rgUeDpc6/8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757381072; c=relaxed/simple;
	bh=Xik99Wfk8v76YuVDwYRaHLirr/C5ijnFC6+1hvXRd7s=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=i4da8S7eCB29952OggmjiXSw1Cd7n5F1Bu0phcUs93nDoalh3XGcY0sVMqYXSJpHqtDV6xYqhWoidvXqoOBDpVfVLdC46bBMjTyolY4O73B6n11hSGauqcp7vxk5pgDSvzgkW8uDzvQVIy1Low7RMmeJsP3R+rbRYONZozitoZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=eFCMFkB1; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5891OPh142889390, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1757381066; bh=3EVVvVHqtocclYJT/tXK3/JTrdZ9bmdNxV9Fbbi4NJs=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=eFCMFkB1QRFTwtah5hjQ78RtTERd69yXVQYZebJy6/tpOZHI9pq2MOR/2W79H5tka
	 zMMhQGql4ODnIyxMCy0PQjd4dbyxmaNhv+rhrQU2ENQCXWXD4R4+W1fr8ISvNUklwj
	 Wsm+jHWA6UZ6ggS3jWRRrFamENIvAnpbunrvWi++XIM1F2NJWpWeE2y90NWJuB9T5E
	 sL+nyIQAlxSTTDUfhquPJ8vO1SU5cjSg4WV4s6gO+LpgPwaREj3kPemdl4Qa/AKwX3
	 5OPdF7kIbb/0OROdkYL3JKQRfre2haeDTk8QBLreDIMjFoa4o4PtBLHuXyfqlvRKcy
	 a43kHpUDJ91jg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5891OPh142889390
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Sep 2025 09:24:26 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 9 Sep 2025 09:24:25 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Tue, 9 Sep
 2025 09:24:25 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Zenm Chen <zenmchen@gmail.com>, <linux-wireless@vger.kernel.org>,
        <pkshih@realtek.com>, <rtl8821cerfe2@gmail.com>
CC: <usbwifi2024@gmail.com>, <zenmchen@gmail.com>
Subject: Re: [PATCH rtw-next] wifi: rtw89: Add USB ID 2001:3327 for D-Link AX18U rev. A1
In-Reply-To: <20250903223100.3031-1-zenmchen@gmail.com>
References: <20250903223100.3031-1-zenmchen@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <a8d4ed9c-6e01-4edb-b86d-3758e185fbf1@RTKEXHMBS06.realtek.com.tw>
Date: Tue, 9 Sep 2025 09:24:25 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTKEXHMBS06.realtek.com.tw (10.21.1.56)

Zenm Chen <zenmchen@gmail.com> wrote:

> Add USB ID 2001:3327 for D-Link AX18U rev. A1 which is a RTL8832BU-based
> Wi-Fi adapter.
> 
> Link: https://github.com/morrownr/rtw89/pull/17
> Signed-off-by: Zenm Chen <zenmchen@gmail.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

17002412a82f wifi: rtw89: Add USB ID 2001:3327 for D-Link AX18U rev. A1

---
https://github.com/pkshih/rtw.git


