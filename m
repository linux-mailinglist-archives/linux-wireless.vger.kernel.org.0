Return-Path: <linux-wireless+bounces-9435-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0319125F2
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 14:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB9B51C231F8
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 12:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D5F1552F9;
	Fri, 21 Jun 2024 12:47:56 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B8F15530F;
	Fri, 21 Jun 2024 12:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718974076; cv=none; b=E3fTc5+nIhGDOVfszXgXzJzY5cSDSAhKg3RmO7l7z13rTzQrbp190nlJppnPK5WlI7ZvRe2ne2yUv6Asw4UCuuDg55VFF8KrNdE5OSr/oH1eIhF6Bl08j/FKaSdJHc/SQ8V2i+cStTlC/SsnBCQGn/YoAMFgqQD2MG6QjIFApr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718974076; c=relaxed/simple;
	bh=0d8wlO0X6tVXHNhI6T5ozsQARyGGQggyq/qs8MeKrbM=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=EkjRXQZeQUewaySupMHpfacpFwNPOvIbreQRfqPN5YxyV139obQI6wYqlDABPovknNgLq86Wz7jlRuKAseBFUzBRw6goQE8NuchL5TMuxEVST1ez3HaBLIBwu4A1iLFVePC8dMgIJPewkdbHUXX1tG8rzht0Omqk1YA24YBSlNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45LClYJV14097679, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 45LClYJV14097679
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 20:47:34 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 21 Jun 2024 20:47:34 +0800
Received: from [127.0.1.1] (172.16.22.19) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 21 Jun
 2024 20:47:34 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, <Jes.Sorensen@gmail.com>
CC: <kvalo@kernel.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Jiapeng Chong
	<jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] wifi: rtl8xxxu: use swap() in rtl8xxxu_switch_ports()
In-Reply-To: <20240619024017.53246-1-jiapeng.chong@linux.alibaba.com>
References: <20240619024017.53246-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <a735918b-ed0e-4fb2-9b95-d3eeb48b0f17@RTEXMBS04.realtek.com.tw>
Date: Fri, 21 Jun 2024 20:47:34 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Jiapeng Chong <jiapeng.chong@linux.alibaba.com> wrote:

> Use existing swap() function rather than duplicating its implementation.
> 
> ./drivers/net/wireless/realtek/rtl8xxxu/core.c:6749:30-31: WARNING opportunity for swap().
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9358
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

6c3b5970b0c4 wifi: rtl8xxxu: use swap() in rtl8xxxu_switch_ports()

---
https://github.com/pkshih/rtw.git


