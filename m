Return-Path: <linux-wireless+bounces-23910-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD83AD2B61
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jun 2025 03:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EBCF7A12A5
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jun 2025 01:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17AF41A23B0;
	Tue, 10 Jun 2025 01:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="pFsxF+HM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4384110A3E;
	Tue, 10 Jun 2025 01:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749519723; cv=none; b=mXaURPnHeAMoMjRMJMG2xtgRYNdoVDXUfKKPNTdVR+5zkqaXQUNwIhf6BY7LeukaC57TQhMs3OD2pmWm7DGshLBtcWi1A+t+GVe10TFaE/DoSvDSEKEoMUyQhDRliX1MkqLWZDbDsika5duuf3Yss089TDHvHMwQ8qupfyc4Dsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749519723; c=relaxed/simple;
	bh=binGtlCsJ/7JM1ivZ8sKZmKZeU+R1zcPtedx02DlsO0=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=V8utWATw6avZd1mxBcJxIYs5Nlvsj8WsrMHG1pShp4zV7g4iUK7B13yVxKL0vGzEF5ZeT2cNJnxBYFzlSxq0kPoLGi/GirJFU4p9Xtd1Yv69qpt+06T1XJOfQluMh7mpDo7U7h89f2c438QIgMtGxZqzpOJwL8z6sySq91YQ6TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=pFsxF+HM; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55A1fa1F32061687, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1749519696; bh=W1a2uYlisaDbGdsA6lB5zHKybjW5kuNXOOtBgpx3dwI=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=pFsxF+HMMLZKIc0UyTWJ5Gler7LOnv8ogJyHmD4vkmQcE+VzcKK1p5WdakgqreT9W
	 dzxXqbJZFG/ufeoRD0vBdU7Dug1vLrqnBTDN4fMfNCjomVzyGYNaGU4Hy1iepO8ah4
	 jQQY2Rc+KPyrFzaIWSZXTvIlQHEmYros/mvLEQ2KEYZioZZK7yKNMT64zAjoEtAcar
	 Qo+n/2trkxeLDg+QeQXqsEw7wd3xB5SvwU8EUZpuflk9YaLxN80FlulRKIvtbhLeUr
	 T0DccHFcHEJMOS/MQTSP+hAKXS1o56LWd82sHBnWFq0zQBvmTiirZ1uGvmiR5n/KI1
	 1TElk2DeO9o5A==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55A1fa1F32061687
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Jun 2025 09:41:36 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Jun 2025 09:41:36 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXDAG02.realtek.com.tw
 (172.21.6.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 10 Jun
 2025 09:41:36 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Fedor Pchelkin <pchelkin@ispras.ru>, Ping-Ke Shih <pkshih@realtek.com>
CC: Fedor Pchelkin <pchelkin@ispras.ru>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: Re: [PATCH rtw-next] wifi: rtw89: fix spelling mistake of RTW89_FLAG_FORBIDDEN_TRACK_WORK
In-Reply-To: <20250603153124.188755-1-pchelkin@ispras.ru>
References: <20250603153124.188755-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <a2f7b12c-9836-4ffd-85aa-fe9e1802d22d@RTEXDAG02.realtek.com.tw>
Date: Tue, 10 Jun 2025 09:41:36 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXDAG02.realtek.com.tw (172.21.6.101)

Fedor Pchelkin <pchelkin@ispras.ru> wrote:

> Rename RTW89_FLAG_FORBIDDEN_TRACK_WROK -> RTW89_FLAG_FORBIDDEN_TRACK_WORK.
> 
> Found by Linux Verification Center (linuxtesting.org).
> 
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

74f3516f94f4 wifi: rtw89: fix spelling mistake of RTW89_FLAG_FORBIDDEN_TRACK_WORK

---
https://github.com/pkshih/rtw.git


