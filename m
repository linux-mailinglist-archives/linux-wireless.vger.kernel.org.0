Return-Path: <linux-wireless+bounces-28326-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 995A5C129C7
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Oct 2025 03:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 995E0580B47
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Oct 2025 01:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64D425D1F7;
	Tue, 28 Oct 2025 01:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="aW7KZY4F"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA50D24169F
	for <linux-wireless@vger.kernel.org>; Tue, 28 Oct 2025 01:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761616793; cv=none; b=MrIZ3la9DFeZ/hS9vjZtJX0h0/p8JYBDRCRsreQ3QzkL5JPIXicGW2/z855PTQVIVxsjDlbbemUlVSVBzU+s/8PE0Fs/DR4C7qjNNN8o8VUiDCDtgNfqQbEsESvxvBKxU7YiFtNSKL6t8eSje7I1dKtZm2bArR8j+sQcy/5RGOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761616793; c=relaxed/simple;
	bh=MSa668VN5YlDe8efZIEE6J23XJqV0UwG1wJBOl78wvQ=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=tc9tddn1fIOuQqA0icN8yxmEN3AC+7qboHT7bEo2GZYkggSRFld+o5apYUIK3rmJnU1gAdyvKC1iiIXgAPtVu+ngSNJQ4gGM40muOCxpSFwtqGaC3xROpYP4gUo43koeXwZOGCy1aPmcOqPVcqKgfihY/cbtViO7Tj5LCAGu9Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=aW7KZY4F; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 59S1xm0X31665456, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1761616788; bh=bfyUOSkz4rncW3Y3d6PwKHmTdbReRH+nMverzc1L+Bo=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=aW7KZY4FgioHyamT2WY5Irk7paxEAhp8DQmYTmQmMTW9lHg1t/jFC17QLO2sJFkyg
	 PuZQUmdAklQy70QP8IZcSCKAN/WBr77pGBQlUMEZLPJadJ7qBOa20xSGeBBvEI/KUe
	 Xj9c8bf8KHD58/ATtPIJLZF0XqyWvNSHuhS0JKyYhRSaTOQmjkCXx5icoG57cOP++B
	 BbPQg6KOo7kWIjcPTXPAWa7ihNEOlCNQG9JJkXGfTmpkTxsBCcyScW566AdKKhH3Mr
	 pAYzU51A2LURO+GxfJm1LXpVMZ5cPMa27o9xml3PTl4nhct6Sst5DltzipmEojZsoc
	 Tut7FbHXC/xaw==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 59S1xm0X31665456
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 28 Oct 2025 09:59:48 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 28 Oct 2025 09:59:48 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 28 Oct 2025 09:59:47 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Tue, 28 Oct 2025 09:59:47 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>, <emma_tsai@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: Re: [rtw-next 1/8] wifi: rtw89: splice C2H events queue to local to prevent racing
In-Reply-To: <20251021133402.15467-2-pkshih@realtek.com>
References: <20251021133402.15467-1-pkshih@realtek.com> <20251021133402.15467-2-pkshih@realtek.com>
Message-ID: <861dd8af-5ada-43f9-9baf-fc05e69dc70a@RTKEXHMBS03.realtek.com.tw>
Date: Tue, 28 Oct 2025 09:59:47 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ping-Ke Shih <pkshih@realtek.com> wrote:

> RX task enqueues C2H events and fork a C2H work to handle events, but
> the work uses skb_queue_walk_safe() without a lock causing potential
> racing. Use skb_queue_splice() and its friends with spin_lock to splice
> the queue to local, and then still use skb_queue_walk_safe() to iterate
> all events.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

8 patch(es) applied to rtw-next branch of rtw.git, thanks.

b47d748110fd wifi: rtw89: splice C2H events queue to local to prevent racing
f44a9b14a78f wifi: rtw89: use skb_dequeue() for queued ROC packets to prevent racing
e79382ab0347 wifi: rtw89: mlo: handle needed H2C when link switching is requested by stack
438c9178cd8a wifi: rtw89: support EHT rate pattern via bitrate mask
0ac5ead00bf9 wifi: rtw89: regd: apply ACPI policy even if country code is programmed
a48ae54a67f7 wifi: rtw89: 8852c: fix ADC oscillation in 160MHz affecting RX performance
e139b1c1f01a wifi: rtw89: restart hardware to recover firmware if power-save becomes abnormal
a62b65412506 wifi: rtw89: improve scan time on 6 GHz band

---
https://github.com/pkshih/rtw.git


