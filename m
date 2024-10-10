Return-Path: <linux-wireless+bounces-13827-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B44F9979BF
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Oct 2024 02:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95ECF1C2138F
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Oct 2024 00:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F9EF9CB;
	Thu, 10 Oct 2024 00:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="DfzIkbJs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07433EADB
	for <linux-wireless@vger.kernel.org>; Thu, 10 Oct 2024 00:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728521075; cv=none; b=VjaoJR5HDnuCMzi+GmtKQWbmj1h8qjN60ywH6wxyZsnuZMedGVxESHcEtPfkz+Ll0dLeZkXHLfYx3tgzBEz+8mbHitOb7YbrzPn4JIOv7+Tkt1G1udaFUbPvqZpY075hSnXZ5Xoc+kyTl0oSg52FKmx3O8QzMy/nSJenukxBOUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728521075; c=relaxed/simple;
	bh=qzQ0pHQsHBUeIGsm/tzKKQ3DuDNKSxoQs/VjgO17/NQ=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=J5F2W3kM2jrfNZrLAFutTU2WctdZ+nK/nzruZLLLmShrq2Zot0TAYWTkAZcukWNEbE0qvYnl1CJ+TwBNX1sidn723xPhfEionHxbyWqQCkGQbQKjJj5kOKuEh53//NAC/n9Zqj4/JNIPmvNqTeTJk0wlEvrIxAA0VaWYkrrs3D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=DfzIkbJs; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 49A0iMm151570792, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1728521062; bh=qzQ0pHQsHBUeIGsm/tzKKQ3DuDNKSxoQs/VjgO17/NQ=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=DfzIkbJsS1NzTKq6jRW5tc51RnDSmcSPRAIhEOMqgbp3/SLPRCi3+jC11Ai1FFUdo
	 7XkDJvXkbM2qAQkInsE37nm5sJPV9SUCOKWYva43lnuImHvXVqQYJdFJzGRg2moEDv
	 SKDOKI6qjTe+Jx9ogatawteRuz24IUZCHfx4GPsMde2K6TWKvloGX/kk+LOcfWc28K
	 0gmSYYrJ1nzTiTd1Oa3dpK1X0/n27ywEvwa+Qrj8RQY73rnYh2WWNw5xSo5CaENv54
	 xbRKt4nYDbvA4RuRlDz7c8HgPH392ohb2ITQdcFTE9olsDl1p7Sz1r8KQLXspT8oxh
	 7QDJKvu3hyOpA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 49A0iMm151570792
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 10 Oct 2024 08:44:22 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 10 Oct 2024 08:44:23 +0800
Received: from [127.0.1.1] (172.16.17.99) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 10 Oct
 2024 08:44:22 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: Re: [PATCH 1/4] wifi: rtw89: coex: Update priority setting for Wi-Fi is scanning
In-Reply-To: <20241003105140.10867-2-pkshih@realtek.com>
References: <20241003105140.10867-1-pkshih@realtek.com> <20241003105140.10867-2-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <c0fc80cf-8c5b-49a1-81a4-0ab552e732f4@RTEXMBS04.realtek.com.tw>
Date: Thu, 10 Oct 2024 08:44:22 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Ching-Te Ku <ku920601@realtek.com>
> 
> Update coexistence priority setting for Wi-Fi scanning channel, the new
> setting will allow Wi-Fi do RX while Bluetooth audio is not busy. Forced
> to set new TDMA policy while RF calibration request come, to make sure
> the calibration can do well, and switch to normal setting while the
> calibration is done. Remove the code that no longer use.
> 
> Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

4 patch(es) applied to rtw-next branch of rtw.git, thanks.

e6802d1e6974 wifi: rtw89: coex: Update priority setting for Wi-Fi is scanning
afa753d823ae wifi: rtw89: coex: Reorder Bluetooth info related logic
e7a7f705a854 wifi: rtw89: coex: Solved BT PAN profile idle decrease Wi-Fi throughput
5ab2f7830228 wifi: rtw89: coex: Add function to reorder Wi-Fi firmware report index

---
https://github.com/pkshih/rtw.git


