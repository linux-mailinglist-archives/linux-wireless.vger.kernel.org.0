Return-Path: <linux-wireless+bounces-7982-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 430A08CCB2F
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 05:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B0E11C20D59
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 03:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D3E3B29D;
	Thu, 23 May 2024 03:32:32 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7A639FEB
	for <linux-wireless@vger.kernel.org>; Thu, 23 May 2024 03:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716435151; cv=none; b=QoiiWBQh2W1z85K7D+44IuxvjF1LxikhC9h2it5Bi/Jeqh8pTNSBc+nMtPXrH7Ms4DuJX6wDOMOjKozaKvuDC8XqfzJ+bnDF76wWGmCgoccsVgrnAMLqJL2fEZhWvOL9jlpy57QXp3IrABlSajqSpDya+rOKeVsg2EEo2TbIzU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716435151; c=relaxed/simple;
	bh=8dvz1nHY1V+QTpZGBbCuFBcyf6b1ASItSMm3w6ifjA4=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=qdSzeT607pjHmpyjpFBLaSMcFjhVRtE9njIj1IqK6sGvaND96oDDlMJG8U3eGaszPg+pGn6EsJE+nWQ5SMNHoft/tbDuDfQScbBVfne1pRYsfYts1TJ8YX0MnEW+BquqhE5BDA8fY3d3kJbKnKeS8OCJTJjR94D9JbhvWVzxQTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 44N3WRmqC465037, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 44N3WRmqC465037
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 23 May 2024 11:32:27 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 23 May 2024 11:32:28 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 23 May
 2024 11:32:27 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <phhuang@realtek.com>
Subject: Re: [PATCH v2] wifi: rtw89: fix HW scan not aborting properly
In-Reply-To: <20240517013350.11278-1-pkshih@realtek.com>
References: <20240517013350.11278-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <1c6bb047-c474-43d5-8d0c-37bc2657e2f2@RTEXMBS04.realtek.com.tw>
Date: Thu, 23 May 2024 11:32:27 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Po-Hao Huang <phhuang@realtek.com>
> 
> There is a length limit on the commands we send to firmware, so
> dividing to two commands is sometimes required when scanning.
> When aborting scan, we should not send second scan command to
> firmware after the first one is finished. This could cause some
> unexpected errors when we cannot receive firmware events
> (e.g. in suspend).
> 
> Another case is scan happens before suspending, ieee80211_do_stop() is
> called to abort scan and driver indicate scan completion by
> ieee80211_scan_completed(), which queues event to scan work. But scan work
> might be late to execute after ieee80211_do_stop(). To correct this, driver
> indicates ieee80211_scan_completed() before returning, so that
> ieee80211_do_stop() can flush scan work properly.
> 
> Fixes: bcbefbd032df ("wifi: rtw89: add wait/completion for abort scan")
> Cc: stable@vger.kernel.org
> Co-developed-by: Chih-Kang Chang <gary.chang@realtek.com>
> Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
> Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

669b692247d4 wifi: rtw89: fix HW scan not aborting properly

---
https://github.com/pkshih/rtw.git


