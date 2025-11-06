Return-Path: <linux-wireless+bounces-28661-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F36FEC394C7
	for <lists+linux-wireless@lfdr.de>; Thu, 06 Nov 2025 07:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 827A71A4008C
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Nov 2025 06:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4D82D877B;
	Thu,  6 Nov 2025 06:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="bkOiMRlJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55C12D94A0;
	Thu,  6 Nov 2025 06:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762411435; cv=none; b=Mc9hnMou9k0FN5PtZVSOmFA8l8/CxgN9hy8W1v2T91v9Yt6EBYHHNAdyUGXWf/LpTu1IyuPD+5VrBd/DJ8w50FRyRxklExZBCk3zMLttxC8L3ImDTe7cyUo7BenROWGlcFSS+jOXfgK1cCa82aV4vAK52G+L45Eqd9DsABK1ZoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762411435; c=relaxed/simple;
	bh=sdPpKOlMPpXJsrKDL8C0oXR8rtqNi0ifslHvd8W+2Rs=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=qawk3goR5mgq0gcxPPLMH2PfkRZHUnI6zc4Y+Pj2Zr6MTK9nN1k0AaLpbodxenbuxXsccv299hpB5Qb3Vi/SLATMkTuM7Xaa8WdLa/ZxJHecjZt2wcMLzuoKvQAMfdNLHtTW5PTWKP4MC3g9zJjf8SHO0dPFrewp/7WSlSAgcrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=bkOiMRlJ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5A66hTwwD2549481, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1762411409; bh=YBrxlmxk+vHX2vriF2/SroLVFj748EX7es43zrBBaFA=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=bkOiMRlJI0Bo7lyFFALOInHN3KcsRgq8K/Uaa3BU84E5QrX7i0AfLxTlVWqMfVDfX
	 ISviunOiytLcjMSpnLbf1wFq58P54KiZCBLkaApA5J5m7yNJ5QC9mcoJ0psz2EqmTh
	 jCEgkUWjSmFr+32T88L77hxXeqUENe1PZ0EmV/OMq+lIz/5bULfh2//uJ6ugynbOsv
	 Mb3YBBq7tmk21pf/JlOYVEJzqQKPPuRAZ5pIQCth1ecX+XABqYmm3GYqttxuKk2PwK
	 o+WNw2/4GMoLIVkc4hrIkcMSKYFsqMpB+2snKjXTapTOOpt7IIorXILHS82kq8mbKl
	 9UpnCyx5Rx3MQ==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5A66hTwwD2549481
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Nov 2025 14:43:29 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Thu, 6 Nov 2025 14:43:30 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Thu, 6 Nov 2025 14:43:25 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Fedor Pchelkin <pchelkin@ispras.ru>, Ping-Ke Shih <pkshih@realtek.com>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>
CC: Fedor Pchelkin <pchelkin@ispras.ru>,
        Zong-Zhe Yang
	<kevin_yang@realtek.com>,
        Po-Hao Huang <phhuang@realtek.com>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: Re: [PATCH rtw-next v5 01/10] wifi: rtw89: usb: use common error path for skbs in rtw89_usb_rx_handler()
In-Reply-To: <20251104135720.321110-2-pchelkin@ispras.ru>
References: <20251104135720.321110-1-pchelkin@ispras.ru> <20251104135720.321110-2-pchelkin@ispras.ru>
Message-ID: <f1367d69-307f-4c44-889b-7e4cfe7fcfe0@RTKEXHMBS03.realtek.com.tw>
Date: Thu, 6 Nov 2025 14:43:25 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Fedor Pchelkin <pchelkin@ispras.ru> wrote:

> Allow adding rx_skb to rx_free_queue for later reuse on the common error
> handling path, otherwise free it.
> 
> Found by Linux Verification Center (linuxtesting.org).
> 
> Fixes: 2135c28be6a8 ("wifi: rtw89: Add usb.{c,h}")
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>

10 patch(es) applied to rtw-next branch of rtw.git, thanks.

28a45575289f wifi: rtw89: usb: use common error path for skbs in rtw89_usb_rx_handler()
7543818e97d5 wifi: rtw89: usb: fix leak in rtw89_usb_write_port()
45a6a88f011f wifi: rtw89: usb: use ieee80211_free_txskb() where appropriate
8986bafb0945 wifi: rtw89: refine rtw89_core_tx_wait_complete()
c33c6a1b6f72 wifi: rtw89: implement C2H TX report handler
21b946104087 wifi: rtw89: fill TX descriptor of FWCMD in shortcut
26a42d804aa8 wifi: rtw89: usb: anchor TX URBs
816e849ef83a wifi: rtw89: handle IEEE80211_TX_CTL_REQ_TX_STATUS frames for USB
cc7070e41786 wifi: rtw89: provide TX reports for management frames
d5da3d9fb05f wifi: rtw89: process TX wait skbs for USB via C2H handler

---
https://github.com/pkshih/rtw.git


