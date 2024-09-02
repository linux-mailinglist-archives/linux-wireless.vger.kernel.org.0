Return-Path: <linux-wireless+bounces-12304-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34523967D4C
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2024 03:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5BEA28133A
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2024 01:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C095379C0;
	Mon,  2 Sep 2024 01:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="qsH0y1Qx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEDF182D2
	for <linux-wireless@vger.kernel.org>; Mon,  2 Sep 2024 01:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725240233; cv=none; b=O4HWKvowchrf7zLejbcZwLUwQ//Bq/u9S2oZlrjmDLjcV2AL6c5qFNBdHysXZlruz6wgjjgKafJl22wohuzQswrCppHih5nX1dEvbYAtkdbOtiN/R/eYtcuzQWIVXkzlhR/Y4WoloGYw8FF69ADqxtehrdZqjg0pRtkIv5opjN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725240233; c=relaxed/simple;
	bh=3Lldd2Wk28/5kRncAx+o6RZXJhYw6v5oaaDjhx5B8Ho=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=d8c/hO0yoX89EGu0JSpjTKtjXYV/COmZ+Qh1AlBoyoiPKTJVzbn/TV+pscFBBZYWEzZH/JMbXuz0FBCHzKLFD9SoVnXBBSjMiEiHDC+6yq6HktM7ea5m/72nOdiZer+K1/aZqJJ39bZyzswps3VxhCDQn8Ty4F75oI6XevvONKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=qsH0y1Qx; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4821Nmz263487225, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1725240228; bh=3Lldd2Wk28/5kRncAx+o6RZXJhYw6v5oaaDjhx5B8Ho=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=qsH0y1QxcbUdjVttjirk59kpGESIU2gZL6EdojfiyNRYUpzQQpAXWoaP51fAasXWH
	 i5h7T18Xaf7STGSOZDfUhhPVPUNdYITHpeG1jVSEN1gYWrrWvXBuJ+8cNQ7bCD2WMX
	 fl1RO4tyBEuYNRZj15JsyVUFy5ttPYkbs3kzsWCkMubYQDDSEkbM3hl6XN+rF5L6YU
	 4DkDGFvfmBYDzklplZ+ZcyJDrEM5pus+Pa9mieTlpZJULib2Melk8UCUuVTQVjOsTs
	 i5BK06fWSlm+gqKblKakk88jLIySDtp+b6Emkgc76DdWNZVl9mcT4o4v0TrqLDMJlc
	 AYy7TLM0DfH8w==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 4821Nmz263487225
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 2 Sep 2024 09:23:48 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 2 Sep 2024 09:23:48 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 2 Sep
 2024 09:23:48 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>, <kevin_yang@realtek.com>
Subject: Re: [PATCH 1/4] wifi: rtw89: wow: fix wait condition for AOAC report request
In-Reply-To: <20240826090439.17242-2-pkshih@realtek.com>
References: <20240826090439.17242-1-pkshih@realtek.com> <20240826090439.17242-2-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <e739acbc-d448-47b1-a7dd-225ff716037d@RTEXMBS04.realtek.com.tw>
Date: Mon, 2 Sep 2024 09:23:48 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
> 
> Each condition binding to the same wait should be unique. AOAC code misused
> the wait of FW offload series and broke the above rule. It added another
> macro to generate wait condition of WoWLAN/AOAC, but the results conflict
> to the ones of FW offload series. It means that we might be completed
> wrongly in logic. We don't want things work/read like this and should
> have avoided this.
> 
> Fix this by adding another wait which aims for WoWLAN functions.
> 
> Fixes: ff53fce5c78b ("wifi: rtw89: wow: update latest PTK GTK info to mac80211 after resume")
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

4 patch(es) applied to rtw-next branch of rtw.git, thanks.

d9dd3ac77cf7 wifi: rtw89: wow: fix wait condition for AOAC report request
f6409a8a0aab wifi: rtw89: wow: add wait for H2C of FW-IPS mode
1de40069417e wifi: rtw89: wow: add net-detect support for 8922ae
30ce797d4654 wifi: rtw89: wow: add scan interval option for net-detect

---
https://github.com/pkshih/rtw.git


