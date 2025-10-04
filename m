Return-Path: <linux-wireless+bounces-27807-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BB8BB8C82
	for <lists+linux-wireless@lfdr.de>; Sat, 04 Oct 2025 12:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C7CF54E110A
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Oct 2025 10:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E4423E25B;
	Sat,  4 Oct 2025 10:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b="E017c+DT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from cmsr-t-1.hinet.net (cmsr-t-1.hinet.net [203.69.209.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4731EA7C6
	for <linux-wireless@vger.kernel.org>; Sat,  4 Oct 2025 10:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.69.209.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759575452; cv=none; b=GVsPILxGxmBgCv7Fn9D53GHVBvpKQcNnEzl3QTq3blofjcTbCru2XN4/mzIHC6ICnhf/GzaNFaSo7lfjXBqVB4GHnu1GX4xCCne6ODFEYBrZnk1ocJP4wl9cgWWC/fxAm+nYjxi4oA0vqCT2UXOoMbbDDD426j3ryjWqySElH/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759575452; c=relaxed/simple;
	bh=Np1kNnBfsSnPND9962ObVkv3qf50u2G9dw0Nx4aTOBM=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type; b=rZ8DjrWWagISsGTbdgRvMLDiB9m/Fy9egIJErz/TsE15nEVfL9o48vDTgkX0hRNcK1OIPCjYeDILrLjcXRW8PoDUjFTKp7jRfQ5+pmC31wjruQfTEq1sj9+oQrYH4+cHu5pGMmLr5HoK7V0D4/N1B0ONhmEOhfbUXBmJJy9qNwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net; spf=pass smtp.mailfrom=ms29.hinet.net; dkim=pass (2048-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b=E017c+DT; arc=none smtp.client-ip=203.69.209.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ms29.hinet.net
Received: from cmsr4.hinet.net ([10.199.216.83])
	by cmsr-t-1.hinet.net (8.15.2/8.15.2) with ESMTPS id 594ANnJ5172612
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-wireless@vger.kernel.org>; Sat, 4 Oct 2025 18:23:49 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ms29.hinet.net;
	s=s2; t=1759573429; bh=Np1kNnBfsSnPND9962ObVkv3qf50u2G9dw0Nx4aTOBM=;
	h=From:To:Subject:Date;
	b=E017c+DTMy57pbusVm9j4DE4VauuxT3JkbrTRwicyiAoxIatTQvdhbApTO/+M8SuF
	 mGbu/l+mHYanC7o4c/G5224Mir4h1sfGJdF8o3duLAPEgP+dNszJjwlkJWb2hdMENo
	 YvzeumtNvGLtkqL+LuJ7W0XY0L6ySgIylnqTnCGMUjIIESM28gLiGniuykXeHYGt+C
	 RYNu8B09qm+bdtJUqobE7LhIsb10vfcTMxXK3TlDQIPruqjAF3tFzWHCQMviUyhU4J
	 so+8Kq8H3WKqeZfASZg6O94BG/KxAU/LsXYcsdNjeYqw3yhriz2T3jdbsvkqFroG6D
	 QhdTLr7eYL4dg==
Received: from [127.0.0.1] (111-243-182-71.dynamic-ip.hinet.net [111.243.182.71])
	by cmsr4.hinet.net (8.15.2/8.15.2) with ESMTPS id 594AMQlB134376
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-wireless@vger.kernel.org>; Sat, 4 Oct 2025 18:23:47 +0800
From: "Sales - iGTI 711" <Linux-wireless@ms29.hinet.net>
To: linux-wireless@vger.kernel.org
Reply-To: "Sales - iGTI." <sales@igti.space>
Subject: =?UTF-8?B?Rmlyc3QgT3JkZXIgQ29uZmlybWF0aW9uICYgTmV4dCBTdGVwcw==?=
Message-ID: <7e6a9828-b584-f641-4675-af0dd5580c08@ms29.hinet.net>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 04 Oct 2025 10:23:47 +0000
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=IM+hCRvG c=1 sm=1 tr=0 ts=68e0f5b5
	a=v3rR5sLxZxqax9fDnybKrQ==:117 a=IkcTkHD0fZMA:10 a=5KLPUuaC_9wA:10
	a=ggywIp0tIZrEgnU2bSAA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10

Hi Linux-wireless,

I hope this message finds you well.

We are a diversified general trading company with multiple business streams=
 and affiliated sister companies. While our operations span various sectors=
, we currently have a strong focus on the resale of industrial equipment to=
 our partners and associates in the UAE, UK, the beverage industry, and =
several other verticals.

Having reviewed your website and product offerings, we are pleased to move =
forward with our first order. To proceed, we would like to align on the =
following key details:

-Minimum Order Quantity (MOQ)
-Delivery timelines
-Payment terms
-Potential for a long-term partnership

To facilitate this discussion and finalize next steps, we will be sharing a=
 Zoom meeting invitation shortly.

We look forward to your confirmation and the opportunity to build a =
mutually beneficial relationship.

Best regards,
Navraj Viera
Purchasing Director
sales@igti.space
iGeneral Trading Co Ltd
igt.ae - igti.space

