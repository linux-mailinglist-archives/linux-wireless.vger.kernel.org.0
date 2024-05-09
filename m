Return-Path: <linux-wireless+bounces-7374-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F4C8C0B7A
	for <lists+linux-wireless@lfdr.de>; Thu,  9 May 2024 08:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDDD11C20A39
	for <lists+linux-wireless@lfdr.de>; Thu,  9 May 2024 06:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6531494CF;
	Thu,  9 May 2024 06:21:47 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AC3149C57
	for <linux-wireless@vger.kernel.org>; Thu,  9 May 2024 06:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715235707; cv=none; b=TyPuoKysu56aCj+fNodIaM2LVMxICPmE6lPrFmTlldDx+FWQc+y8sVaL0/cmgw1l2z80HTipoqZe8KHR96jAdctAXNWjQjNkwYVq6X6puCp+l3ftNoUPNu53xAg4T2wn+8e2m4HKFAICwnghdAUjztGv+DotrFE+IWcWyXC6vc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715235707; c=relaxed/simple;
	bh=IC/OxyH3Nwr/6h+KvPs9CjlX0fJVnPC8njI5ELXeYRE=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=Xx/ecdLYYi/U4BbiOmALYXVXerqmc2R/udqh8DhtDnYBebMLmZ3UbrCi94XlGwx/+B9LE1G/SZEVu/YZl1GaJREvvZ3EcW/8hGzbSR6eUCzyHMhUrppGeioc3iL3Op4JUGvShm3LGH72xZTFubWhNEmvRxvjUF1vPlmaxv0ihac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4496LRB701290157, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4496LRB701290157
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 May 2024 14:21:27 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 9 May 2024 14:21:27 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 9 May
 2024 14:21:27 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Ping-Ke Shih <pkshih@realtek.com>, Sascha Hauer <sha@pengutronix.de>,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: [PATCH v2] wifi: rtw88: usb: Simplify rtw_usb_write_data
In-Reply-To: <2479507e-3946-492f-857e-83e54969aad2@gmail.com>
References: <2479507e-3946-492f-857e-83e54969aad2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <896ba1b7-9b0e-4d93-953f-6d40e3d65774@RTEXMBS04.realtek.com.tw>
Date: Thu, 9 May 2024 14:21:27 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> The skb created in this function always has the same headroom,
> the chip's TX descriptor size. (pkt_info->offset is set by
> rtw_usb_write_data_rsvd_page() to chip->tx_pkt_desc_sz.) Use
> chip->tx_pkt_desc_sz directly.
> 
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Tested-by: Larry Finger <Larry.Finger@lwfinger.net>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

a892f6ffbec7 wifi: rtw88: usb: Simplify rtw_usb_write_data

---
https://github.com/pkshih/rtw.git


