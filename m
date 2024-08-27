Return-Path: <linux-wireless+bounces-12013-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 687A995FF9F
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 05:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC30CB2227B
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 03:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7D52E62B;
	Tue, 27 Aug 2024 03:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="RoH0divm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FC828689
	for <linux-wireless@vger.kernel.org>; Tue, 27 Aug 2024 03:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724728011; cv=none; b=sv0rx7/pYM/IwgBArrxsPIy7lOPfBOKZgua+d+VojLuWA1/xoY8y7p+5XkZWQS31+MbkkFk+ongWsvOiq8UaqGncKj3nZ97fW0SJehCNOxYj1AxyYt8jy/XgTpnNSXXkJhjdlRs2TFRU5ze6LmwTgeG/1AFu6bcvq5TVUBq3HNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724728011; c=relaxed/simple;
	bh=BQRDsvGw2HffR8qITihy+EHjTWc9Wz1ol4MajA/kz3E=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=oxZhy6U/qipSJnFHdcY4w1K5BnDlUO6jxwi0gAkh8WA+9ho0eRHOnD3chqlD5zO5eW80eJ4RQvnEFWUWR+P3S2msPw39SjCYHjepNCcUwC7ideDRW1ruPchjzPp2j1K4Hes/mdWv1KpGGrjCGqUlfIEeHRbySOLUur7lyLCEDXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=RoH0divm; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47R36jzgE528939, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1724728006; bh=BQRDsvGw2HffR8qITihy+EHjTWc9Wz1ol4MajA/kz3E=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=RoH0divmEnj5w4VZQALlt0w0qDcI5/WuJ3CNqN8Aacw/o8bMmp4BeROKOa1ZwC5fP
	 owGY+Ue+L4uldMMbyR7tfwbctOduxD5GnQMXrwM57ashyOP4M0OToufWavA+WJ5S/6
	 fUthaRy4RhIT1EjuozcNvnt/QRiTRwNHYAemQc27La8zTNv+JK0Tc8vhzhJpnNEQtH
	 EnV25K6qeNOvCL7leDaL0YoFprLM9Jc/CpIK6McSppImrFWlbalQ7jJkPiF0CkJZQf
	 RthsPOdm20y4vpVt/eZtACyohmMhNDKesv9fkPKbQlbpQMIGTXd8fF2d6d82XP0r7y
	 4guQY91NJn5/g==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47R36jzgE528939
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 27 Aug 2024 11:06:45 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 27 Aug 2024 11:06:46 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 27 Aug
 2024 11:06:45 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: Re: [PATCH 1/8] wifi: rtw89: pass chan to rfk_band_changed()
In-Reply-To: <20240819091724.33730-2-pkshih@realtek.com>
References: <20240819091724.33730-1-pkshih@realtek.com> <20240819091724.33730-2-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <fdadd4b4-f3d0-47b4-9388-56c2de47ffb7@RTEXMBS04.realtek.com.tw>
Date: Tue, 27 Aug 2024 11:06:45 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
> 
> Originally, all chips have implemented rfk_band_changed() and access chan
> with hard-code RTW89_CHANCTX_0 in it. But, it's problematic when the chip
> supports multiple channels.
> 
> So, change the prototype of rfk_band_changed() and pass chan ahead. And,
> we will refine the implementation of each chip in the following.
> 
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

8 patch(es) applied to rtw-next branch of rtw.git, thanks.

7c31f102030f wifi: rtw89: pass chan to rfk_band_changed()
e3a2f20991fe wifi: rtw89: 8851b: use right chanctx whenever possible in RFK flow
fcad7da7d3fc wifi: rtw89: 8852a: use right chanctx whenever possible in RFK flow
50b3da25abc6 wifi: rtw89: 8852bx: use right chanctx whenever possible in RFK flow
395bd59c95fd wifi: rtw89: 8852c: use right chanctx whenever possible in RFK flow
abc129676897 wifi: rtw89: 8922a: use right chanctx whenever possible in RFK flow
d03b3d7493f5 wifi: rtw89: rename roc_entity_idx to roc_chanctx_idx
fef63150940c wifi: rtw89: introduce chip support link number and driver MLO capability

---
https://github.com/pkshih/rtw.git


