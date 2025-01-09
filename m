Return-Path: <linux-wireless+bounces-17211-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCDC5A06B2C
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 03:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B9583A1320
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 02:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C5839AEB;
	Thu,  9 Jan 2025 02:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="wclcdxi5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C389136E;
	Thu,  9 Jan 2025 02:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736390153; cv=none; b=gJZsCCorzADM6KmLu8k3HKjjXuw36zJCRL6g3URMXHVml1Eo7Gqi6OgyE3B4+4/sxY+3YyuXwIIqX+y5pKtu55iv0AQnWaNFM+eCG3cduwX7HnrCNBS/1EFtcU+Bz7urStJ9fc2UAKqZ8LmutZhx/DIM1pkxkARgzM4R30LAY9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736390153; c=relaxed/simple;
	bh=ILsbn2/8p+u7XbJFSdAXzGeL4I8trhdCudkzuygvND4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IkGAsit+vrAENnhb47NyfbblLNiPS6YdIpwlt5wJtuklMXb3qke7piLRp41mDNbvZzJOOtnpM5cxKBZ7fWa0OfcFP5Pqdoft/MufUHorN8bqG4WtpHQWgxxaQfLEBR9nEg/g/mNmanHkt80jd38GEjVGwl9hPZ3ADnk8x1uTwNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=wclcdxi5; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5092ZDxbC2336234, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1736390114; bh=ILsbn2/8p+u7XbJFSdAXzGeL4I8trhdCudkzuygvND4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=wclcdxi5htWLMU2liUzd3bZLT+TMSEHOwcpz5NMhoXKmGgb4E+b+EebVL1oRJhuZI
	 VVPTn5d6o8eHqlQLjwFwMjUi/XZJ3QCy60DhtDgT27OFZmA7UHa7jC1cR05C7k9wq2
	 5McUowPpumRz2XfN+ai2/ib9Jfx/GTRRefgBYlzU6yPjrcxfq5UnH5/i7AJS+5Rrxu
	 CDgKThyhHRDELjhePZsIQWWS+nClvKkjsFz+MWS5bbGeQRNzwFyURLaQeWp0Y4jQIy
	 k7PbAT2y7dHkhgfMsGtdbkDp4SbEdjsMd6fF70CITtEsHrRBOZXGQ+j8NB79VU0FIe
	 PmW+d5BrWgyZg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5092ZDxbC2336234
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jan 2025 10:35:14 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 9 Jan 2025 10:35:13 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 9 Jan 2025 10:35:12 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Thu, 9 Jan 2025 10:35:12 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Liang Jie <buaajxlj@163.com>
CC: "kvalo@kernel.org" <kvalo@kernel.org>, Bernie Huang <phhuang@realtek.com>,
        "fanggeng@lixiang.com" <fanggeng@lixiang.com>,
        "yangchen11@lixiang.com"
	<yangchen11@lixiang.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Liang Jie <liangjie@lixiang.com>
Subject: RE: [PATCH v3] wifi: rtw89: Correct immediate cfg_len calculation for scan_offload_be
Thread-Topic: [PATCH v3] wifi: rtw89: Correct immediate cfg_len calculation
 for scan_offload_be
Thread-Index: AQHbYj3vcAB7YR6EGkKkUrCfWXVJdbMNuZ4A
Date: Thu, 9 Jan 2025 02:35:12 +0000
Message-ID: <8aded74b33d1471fa822a2c599545775@realtek.com>
References: <20250109022557.1143215-1-buaajxlj@163.com>
In-Reply-To: <20250109022557.1143215-1-buaajxlj@163.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

Liang Jie <buaajxlj@163.com> wrote:
> From: Liang Jie <liangjie@lixiang.com>
>=20
> Ensures the correct calculation of `cfg_len` prior to the allocation of
> the skb in the `rtw89_fw_h2c_scan_offload_be` function, particularly when
> the `SCAN_OFFLOAD_BE_V0` firmware feature is enabled. It addresses an
> issue where an incorrect skb size might be allocated due to a delayed
> setting of `cfg_len`, potentially leading to memory inefficiencies.
>=20
> By moving the conditional check and assignment of `cfg_len` before skb
> allocation, the patch guarantees that `len`, which depends on `cfg_len`,
> is accurately computed, ensuring proper skb size and preventing any
> unnecessary memory reservation for firmware operations not supporting
> beyond the `w8` member of the command data structure.
>=20
> This correction helps to optimize memory usage and maintain consistent
> behavior across different firmware versions.
>=20
> Fixes: 6ca6b918f280 ("wifi: rtw89: 8922a: Add new fields for scan offload=
 H2C command")
> Signed-off-by: Liang Jie <liangjie@lixiang.com>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>


