Return-Path: <linux-wireless+bounces-14486-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC8C9AF743
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 04:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 592B6B21F52
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 02:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8044409;
	Fri, 25 Oct 2024 02:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="kvGoTUmb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5ACD4C8C
	for <linux-wireless@vger.kernel.org>; Fri, 25 Oct 2024 02:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729822174; cv=none; b=uG4GcsaGgdyy8woPqkApx0kDjHjjFZuSGn3BPcBI1cf9bJBG+4WAMh7TDZCQULh7oMSrrd2MHSo7Wg478eG0OY1pkI5MoFzxQ7mGsq8DX8rrGbaw8P54rq8CUX9vLziTpKIHE8givbY21CsNHfzWpZKdX8wS90uY+EkEGdsZ5fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729822174; c=relaxed/simple;
	bh=3JNRkPUW5KBq0vSLZMLDbiy5QEVo7n4tPUH8nPB36Ko=;
	h=From:To:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Message-ID:Date; b=iiIzePigdFY7F5W4UT0mbt/wZN4pfEHsyt+4ZDfgaZ4PMqr+Tel3J9c8LmJyQRZvx5AVRQ6dSdSu/b6+SGn+nqemis/G5kW+ya6r5dFSSAtk/19w2hhoBzYD1kEAMjtXPKpmAsniGpqidgoeFsf7+CgETzach/5RggnJ+uY2LgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=kvGoTUmb; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 49P29ShZ44053988, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1729822168; bh=3JNRkPUW5KBq0vSLZMLDbiy5QEVo7n4tPUH8nPB36Ko=;
	h=From:To:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Message-ID:Date;
	b=kvGoTUmbsFEiHaIu0j8j97IEWCrE4TjrsDNiudPjr/mLkefu6mhPvwtab1kT+9ly6
	 0lhoO6M2FIUtBwHRJrYHyorQBqy+/0igp0jJGqpku/wgFKZ+SMFTUroSxxLgqhwWoA
	 15rL0Ys8jq9wCyPCMdLEEdYOBr4EK5/QPEhSAW3StOh2hYKrCSAnqTT1QBlUs9Y7Au
	 XNqxDlnOXHd7OV3Nmhgcej6Hp62Bwz5hDbwylsxm0Yum3w/V7nMZGHIAwFW48dM8tJ
	 q3s9o6Oxec4s445oX8hw3z9Nylp896L2NZ4ZvSFNkp3zCHCx+PDt5EblOvrHCNr/Cn
	 3Um7Qd5xYsphg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 49P29ShZ44053988
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 25 Oct 2024 10:09:28 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 25 Oct 2024 10:09:28 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 25 Oct
 2024 10:09:27 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 1/2] wifi: rtw89: add thermal protection
In-Reply-To: <20241016133735.7571-2-pkshih@realtek.com>
References: <20241016133735.7571-1-pkshih@realtek.com> <20241016133735.7571-2-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <a1929a2e-29d6-411c-af34-0994ff65d0d1@RTEXMBS04.realtek.com.tw>
Date: Fri, 25 Oct 2024 10:09:27 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> To prevent chip overheating, reduce TX duty as the mechanism of thermal
> protection. When temperature is raising over a threshold, send a firmware
> command to reduce TX duty. If temperature is still raising, higher level
> is adopted to have lower active duration.
> 
> The equation and unit of thermal values are different from chip to chip,
> so define constant thresholds of thermal value to corresponding absolute
> temperature of 110 and 120 degree Celsius.
> 
> Latter patch will decide which thermal threshold is adopted, and current
> is still not enable thermal protection.
> 
> For debugging, add a flag to disable_dm that thermal protection can be
> disabled to clarify low throughput in field.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

2 patch(es) applied to rtw-next branch of rtw.git, thanks.

63aca1726213 wifi: rtw89: add thermal protection
9ef90a49b0db wifi: rtw89: pci: add quirks by PCI subsystem ID for thermal protection

---
https://github.com/pkshih/rtw.git


