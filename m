Return-Path: <linux-wireless+bounces-13544-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA60A991408
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Oct 2024 05:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74FE21F23B35
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Oct 2024 03:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9021BC2A;
	Sat,  5 Oct 2024 03:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="wwE3TcAk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789AD231CA7
	for <linux-wireless@vger.kernel.org>; Sat,  5 Oct 2024 03:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728097212; cv=none; b=phelhvr4qvHcvhalR4OiR2CS4lE7jC7Tx+8MaQj8YqzYLGX/D/BGeR6p2m285hMS8UTUs6K7oV2I+gB5IC1mopOptOSoYdV10y9zGqHUjaSFiVCoKvjkM0hJFGUsf+p41H1Wxieen40cEY2cgX8t/c7g2SFVZuSqY9WJUH4CyCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728097212; c=relaxed/simple;
	bh=kvuqYRmmdLUwWD1gz6bgfo48GQJtpNBjvOgwVrzkBWk=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=WGaLgSH8v9Q3rclIFwfIn+ULJa4HpHLTkee+rgGnbwM9Oytv3rOlfhWZz16HAUrRvZfmODpVKBnVvASH04oQzLWfdscNvb5YaSyc8Kb411PkvVOpk9CqWdtCAnUg+0D7MF+n/4O8h0B6jpu9La2KySiuXDRdpraT7lriVTsfgU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=wwE3TcAk; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4952xoOJ32458028, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1728097190; bh=kvuqYRmmdLUwWD1gz6bgfo48GQJtpNBjvOgwVrzkBWk=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=wwE3TcAkYn34Fuc40gJNS1RTK69gcPiDHnXlby5+RC9OYD9MTIJzsdwzKpCeqL/q8
	 ZkO1vN33+eOxgDCz9MrhmBSWr/EjRAjmnbBOT9knMhiUtn6vyrKueC0AhBYCFfsXJN
	 QZaXUjAtBXXwlbULpk0QjiNrZ1X4wZX9Z5Tb/ZAtVsYpQMs6JLTm3XtSgIH6CKppK4
	 zLpMdtfWDMt9TpkAvkFJqLHjdA5oCG/C2jJsrR51hw9K6MTXBOIUQ3iHgq1UtpnBY+
	 AsFiuNON4pWnHeIQpiwZbAR7OIfzoFEOlLWz+EUgeIJ7FESRXulgrU7gZhpAQZyvgM
	 nv49QBd3iUNqg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4952xoOJ32458028
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 5 Oct 2024 10:59:50 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 5 Oct 2024 10:59:50 +0800
Received: from [127.0.1.1] (172.16.20.49) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sat, 5 Oct
 2024 10:59:50 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Martin Kaistra <martin.kaistra@linutronix.de>,
        <linux-wireless@vger.kernel.org>
CC: Jes Sorensen <Jes.Sorensen@gmail.com>, Ping-Ke Shih <pkshih@realtek.com>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: [PATCH] wifi: rtl8xxxu: Perform update_beacon_work when beaconing is enabled
In-Reply-To: <20240930084955.455241-1-martin.kaistra@linutronix.de>
References: <20240930084955.455241-1-martin.kaistra@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <12a59502-9f3e-49e4-b567-b05666baf380@RTEXMBS04.realtek.com.tw>
Date: Sat, 5 Oct 2024 10:59:50 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Martin Kaistra <martin.kaistra@linutronix.de> wrote:

> In STA+AP concurrent mode, performing a scan operation on one vif
> temporarily stops beacons on the other. When the scan is completed,
> beacons are enabled again with BSS_CHANGED_BEACON_ENABLED.
> 
> We can observe that no beacons are being sent when just
> rtl8xxxu_start_tx_beacon() is being called.
> 
> Thus, also perform update_beacon_work in order to restore beaconing.
> 
> Fixes: cde8848cad0b ("wifi: rtl8xxxu: Add beacon functions")
> Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

d7063ed6758c wifi: rtl8xxxu: Perform update_beacon_work when beaconing is enabled

---
https://github.com/pkshih/rtw.git


