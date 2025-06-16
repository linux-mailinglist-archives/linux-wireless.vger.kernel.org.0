Return-Path: <linux-wireless+bounces-24122-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C0FBADA6FE
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 05:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18C5616CDEE
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 03:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F61819E97B;
	Mon, 16 Jun 2025 03:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Z+CnCxEH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D9D72626;
	Mon, 16 Jun 2025 03:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750046192; cv=none; b=NDMo7ZU5a3MSUXyq4b3CxLQW1Z+LWuQGaqZFBelyW+aUyI1LwMA3n9aMjtX6rRr57FQem6axZH1gTWMPnd0s5swksaF1v493yKtRkfe7WO8g0V+Bl1JxgSuDkne7QvCCob3jIWkOwx7GbKFaKBh9ZW+Tdg3jMfCtUGKHAUMYhqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750046192; c=relaxed/simple;
	bh=KlSDBlmI+X5TdbQLbaiFZk4wvCLS0m5RcscOkbOnO2g=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=pWzwhtlXHtV0aXqkhhROVtkFPuhTk6kgirbC3VNreVRVBxwK5dNkxKO9ER7jJxivygVK4HoL+bXnOyAtzFPi4b5UuxE9LO5mhfHKdpm0BhGi8t4Gw8U9lUtC/UV1atYd8JEvklKlYflEgqlAtMSCln1tLHVFdgaOeyjpDz5TBns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Z+CnCxEH; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55G3uQqT54019997, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1750046186; bh=C3623BsTv5Mq9sG0ZdAgXIU8dPO3wMGnP8Fy2JSD8w4=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=Z+CnCxEHb1yWHLwswcJgonK0K2oMKu3+MFaX9Nf3+dKKVlllWQJ0dG8HGux3BHQgB
	 EKYsoa1tVRz/n8JzJeYOZBgsYs7seLs8KbtxHtzKQIbSw4cxzKGtIi/g8gENtUbC3/
	 PW6r1Q9xpeceuKWzIfdBHiLZKntHA+SBM7lUML8KGu7XFBwoBnrk07CZj0DYlACjQi
	 tU6dby6DzCNKptSBK5X0GXP1bcokktn8pQr6tmYd/YVyGfx4d2aDY0dTKOjhVP2Ox/
	 9fGFms3KJKcGwnIU0zk3V3pKPDMEK2xRa0S+TokRSwG/wlaTBncwXj0YEZI0QY8+RT
	 m6tGzZLKBk1XA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55G3uQqT54019997
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Jun 2025 11:56:26 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 16 Jun 2025 11:56:20 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 16 Jun
 2025 11:56:19 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Thomas Fourier <fourier.thomas@gmail.com>
CC: Thomas Fourier <fourier.thomas@gmail.com>,
        Ping-Ke Shih
	<pkshih@realtek.com>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rtw-next] wifi: rtlwifi: fix possible skb memory leak in _rtl_pci_init_one_rxdesc()
In-Reply-To: <20250613074014.69856-2-fourier.thomas@gmail.com>
References: <9800869271a34ca3835743207c0a4109@realtek.com> <20250613074014.69856-2-fourier.thomas@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <3fd86a9b-532d-41c6-8366-73e8273d3267@RTEXMBS04.realtek.com.tw>
Date: Mon, 16 Jun 2025 11:56:19 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Thomas Fourier <fourier.thomas@gmail.com> wrote:

> When `dma_mapping_error()` is true, if a new `skb` has been allocated,
> then it must be de-allocated.
> 
> Compile tested only
> 
> Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

76b3e5078d76 wifi: rtlwifi: fix possible skb memory leak in _rtl_pci_init_one_rxdesc()

---
https://github.com/pkshih/rtw.git


