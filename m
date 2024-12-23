Return-Path: <linux-wireless+bounces-16731-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C80A9FAB6C
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Dec 2024 09:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 478877A052F
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Dec 2024 08:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8C58624B;
	Mon, 23 Dec 2024 08:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="XtfMp7J9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD44EEB5
	for <linux-wireless@vger.kernel.org>; Mon, 23 Dec 2024 08:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734941277; cv=none; b=jufO3Q940dR36aLe2izG+CrZTcqpFioCRyT4+da1wIrx0NsFIxTrMuMdImi+n7x1G5MPJ8OR/ugouC5axIWLvH+GlLqjdpanfBCv31oroyvjVGXAU0OpK+LQDlPXc6Y0c/iJmdReGGmCTrzXUh/x1/3F8pVjOOGnrFROfztiJyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734941277; c=relaxed/simple;
	bh=zybpKyddyAObbZUxiVdzyg+1ANmjDlaByvnxNczid6s=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=CyhdoKyRam/Q55yZn7uSnTUANsnJxDDd+v0Lu4ADBUG81zIEUGBgsAcmLHF5qJTeJD5Ehkkq5wIntudtIR7y7MbS+PqVKRz4HCLUdKSPrzlYoi5xRSCR6rXU3KIPIOziVfHq8L2xvlcc0fTBpKpVJBa2IbtwSuTA9EzXaDdSBxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=XtfMp7J9; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4BN87h1B21506218, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1734941263; bh=zybpKyddyAObbZUxiVdzyg+1ANmjDlaByvnxNczid6s=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=XtfMp7J9YXZXFhOsV+IyOrVwb3MlPN7jqYF8tONZtZqlnGzrCM8CXhqtwQRYTA59q
	 iuRs2TcHJ4MF6B5HNljWM7hHkcuX5PFqGK2Ld0q53fIqdYE7aAtMGs3s97dwvlRmeC
	 D+rJqbfWwUSmxXibs+eFmbO1zrCWAMTRBzlA/0h+tFuegx9PZGZSADSMCoMKONZmlL
	 IawaBCsLrzWeEnCwpruaASX1XDKfGnbRg0GfsJliIBzIcodkZQiFJPocuNx0MT/XiE
	 ZpGqeIhM4Od00VBoqSfriAIEznWxc53dEzquPWb9+YZVYz0Xhx2vPw0bSc/Gj4kj62
	 f+HmgRb4q5JgQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4BN87h1B21506218
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Dec 2024 16:07:43 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 23 Dec 2024 16:07:42 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 23 Dec
 2024 16:07:41 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Ping-Ke Shih <pkshih@realtek.com>, Sascha Hauer <sha@pengutronix.de>
Subject: Re: [PATCH v2 1/3] wifi: rtw88: usb: Copy instead of cloning the RX skb
In-Reply-To: <8c9d4f9d-ebd8-4dc0-a0c4-9ebe430521dd@gmail.com>
References: <8c9d4f9d-ebd8-4dc0-a0c4-9ebe430521dd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <99d6b4ad-5c55-4b75-a5b1-bdeb0ebba050@RTEXMBS04.realtek.com.tw>
Date: Mon, 23 Dec 2024 16:07:41 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> "iperf3 -c 192.168.0.1 -R --udp -b 0" shows about 40% of datagrams
> are lost. Many torrents don't download faster than 3 MiB/s, probably
> because the Bittorrent protocol uses UDP. This is somehow related to
> the use of skb_clone() in the RX path.
> 
> Don't use skb_clone(). Instead allocate a new skb for each 802.11 frame
> received and copy the data from the big (32768 byte) skb.
> 
> With this patch, "iperf3 -c 192.168.0.1 -R --udp -b 0" shows only 1-2%
> of datagrams are lost, and torrents can reach download speeds of 36
> MiB/s.
> 
> Tested with RTL8812AU and RTL8822CU.
> 
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

3 patch(es) applied to rtw-next branch of rtw.git, thanks.

e9048e2935f7 wifi: rtw88: usb: Copy instead of cloning the RX skb
13221be72034 wifi: rtw88: Handle C2H_ADAPTIVITY in rtw_fw_c2h_cmd_handle()
3e3aa566dd18 wifi: rtw88: usb: Preallocate and reuse the RX skbs

---
https://github.com/pkshih/rtw.git


