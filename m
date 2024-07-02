Return-Path: <linux-wireless+bounces-9835-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D83F923C93
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 13:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33EA31F23CDF
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 11:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0FF8155741;
	Tue,  2 Jul 2024 11:40:00 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE39153BE3
	for <linux-wireless@vger.kernel.org>; Tue,  2 Jul 2024 11:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719920400; cv=none; b=QWNsuz2utoRzQes4YxHeXywBhTcy3ChSKea0+Sb12EETxGG64o79IPn1noanl9t61S5Sq2TlxDvDkLWxFtN5Yy4WkHpBj3sV89s3yEo3ij/cAzwYfOWKJExn0XtKjbwlzoaNZq8wab6Z4HXazSxn1GuuxaL/neRqXOWlu2fz3QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719920400; c=relaxed/simple;
	bh=QziJEkpBWvwyVSL69i3F5cdyH3R/+kHMwEc+WhzFWzE=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=XErrvQW8/jt5cdw7/w+1bcFB2j36DPG7b0FEHBwvXKqT+3H0nlpJH8tjqoHJLudzCo7Xj2FZnoZgu/2AKGZvOcrjXmmqPiD+mbGtLucciDCi/DGgBB6x4JvBax5b/kQwiHOEGAmkrSOt4eSwWpajbhrigVP0D1Z8pq3h3MT352I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 462BduNI3877534, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 462BduNI3877534
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 2 Jul 2024 19:39:56 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 2 Jul 2024 19:39:56 +0800
Received: from [127.0.1.1] (172.16.17.57) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 2 Jul
 2024 19:39:55 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: Re: [PATCH] wifi: rtw89: constrain TX power according to Transmit Power Envelope
In-Reply-To: <20240626023237.7901-1-pkshih@realtek.com>
References: <20240626023237.7901-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <b426dbc0-4936-4d07-8e86-e1272c176b84@RTEXMBS04.realtek.com.tw>
Date: Tue, 2 Jul 2024 19:39:55 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
> 
> Calculate a TX power constraint based on content of ieee80211 Transmit
> Power Envelope (TPE). Since HW control registers aren't designed as many
> as all kinds of TPE fields, we strictly intersect all TPE inputs in driver.
> Then, according to result, constrain TX power via TX power limit/limit_RU.
> 
> Besides, extend dbgfs txpwr_table to show info about 6 GHz regulatory.
> 
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

dcf920ff8c16 wifi: rtw89: constrain TX power according to Transmit Power Envelope

---
https://github.com/pkshih/rtw.git


