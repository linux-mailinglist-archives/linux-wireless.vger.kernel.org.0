Return-Path: <linux-wireless+bounces-21629-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2DBBA91368
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 07:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 291773A5A83
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 05:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE601DE89B;
	Thu, 17 Apr 2025 05:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="wH3V7R+A"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417861B4223
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 05:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744869539; cv=none; b=a1yHyxwX7IJXWHHJg798qUtt/rxEAs6+orBPoFO6IuFEKnlk06PftCT8k44VJREox/UPnn4we+NH9YmSW3G77Pd1qy27Zmqns6h+Wsvcuf5QWz3eYKy5bXvwwSlIlDni+tlb21MLMaok8AEo2h5Nzpf4bgRh5GygMbqh3JuVmSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744869539; c=relaxed/simple;
	bh=hkq/nCVfd4OnRpw1SKFkzJCEGk5ISc/DcLzVCzSqYHs=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=JEVqyxUdxcliZhLaPMYOawyyjN+r2sWr5yYCSGhJ8Y6iIWSppk0M/4gZGXN9qukt6mOGOhcUzTNDqLBcfZrr22jPply7/SM4cTP6gKZLgLeL3JePXqZVjf9K47OyKgXoFSspudpl4mqgCNlhQOaYI54EySYsHgtFsLqVIQomBY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=wH3V7R+A; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53H5wfgmF385702, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1744869521; bh=hkq/nCVfd4OnRpw1SKFkzJCEGk5ISc/DcLzVCzSqYHs=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=wH3V7R+Amyy917LJt3sySgStbaZIRONC9YfgdKYU5PF5YT9aoo2TlH2g7WjuHo9QY
	 xT2ntBAlr1tkIH4wQtWoRIMhb1U2XFvr7i4Te0MBB6gExpxw9DKcqTJs1kOOl+W5YV
	 mlOFnvNrpb3AnS9HkWqbfRVPMpBaAotux8Mb4GN2ck9xw2Cdq8lMgzIaKaczH1Okad
	 EDGhPbngP5KjuglRGb1Xx4VacpKV3d9TqHVdBZa8eDwHnFrEyJf8zneCvDH8BzzzST
	 HedPoMcrwNGjywNysp1g674csmjv5WpcW32j0D99oDBZuOeis/qMNs+91Zq9a2eZU1
	 WrBzd2BeoNb2A==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53H5wfgmF385702
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Apr 2025 13:58:41 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 17 Apr 2025 13:58:41 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 17 Apr
 2025 13:58:39 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Dmitry Antipov <dmantipov@yandex.ru>, Ping-Ke Shih <pkshih@realtek.com>
CC: <linux-wireless@vger.kernel.org>, <lvc-project@linuxtesting.org>,
        "Dmitry
 Antipov" <dmantipov@yandex.ru>
Subject: Re: [PATCH] wifi: rtw88: do not ignore hardware read error during DPK
In-Reply-To: <20250415090720.194048-1-dmantipov@yandex.ru>
References: <20250415090720.194048-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <36ac3693-d738-42ed-8cb1-89fd67b40192@RTEXMBS04.realtek.com.tw>
Date: Thu, 17 Apr 2025 13:58:39 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Dmitry Antipov <dmantipov@yandex.ru> wrote:

> In 'rtw8822c_dpk_cal_coef1()', do not ignore error returned
> by 'check_hw_ready()' but issue a warning to denote possible
> DPK issue. Compile tested only.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 5227c2ee453d ("rtw88: 8822c: add SW DPK support")
> Suggested-by: Ping-Ke Shih <pkshih@realtek.com>
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

20d3c19bd8f9 wifi: rtw88: do not ignore hardware read error during DPK

---
https://github.com/pkshih/rtw.git


