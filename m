Return-Path: <linux-wireless+bounces-27552-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28295B8EDFC
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Sep 2025 05:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FB5C3A9B87
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Sep 2025 03:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F9853A7;
	Mon, 22 Sep 2025 03:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b="eEDIHPp1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from cdmsr2.hinet.net (210-65-1-144.hinet-ip.hinet.net [210.65.1.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947AF20E6
	for <linux-wireless@vger.kernel.org>; Mon, 22 Sep 2025 03:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.65.1.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758512731; cv=none; b=Lv95poRYn0Z7Ig7EG0vlmKzWKRu8MSPUqMeLfjvrO8YvhIa8F6bubfrZp+56DidJfrx2DlbyG4QlbLe/ofytUKcXhh9yMr0FFdqQlpvWH9iAH2pI26dxnWiZZcLDEBJN7ZdSfGlCNyGY75IakmeIB5i7hgLfkKKAmJq1evN0C4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758512731; c=relaxed/simple;
	bh=+MnGzmqBb67I1t0Sei2bE/vo4z5vwGS0J6E+W5fx1HQ=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type; b=koEiovyp394uWG2Xr0oAaFpCya/bWmV0+orWwPXyY2NIXCVDdIx14dKxpCGfi3WFjXsRByv1VZ+opG/9ilcR+85Ax2cymUMBPrnay/Lg0Z7k8rJ9717vnR2vBhbfL3Jbu02niL/Wa/OwqK+SBOhSq5xWXpzixAQZSmrjxIi/R3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net; spf=pass smtp.mailfrom=ms29.hinet.net; dkim=pass (1024-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b=eEDIHPp1; arc=none smtp.client-ip=210.65.1.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ms29.hinet.net
Received: from cmsr3.hinet.net ([10.199.216.82])
	by cdmsr2.hinet.net (8.15.2/8.15.2) with ESMTPS id 58M3jGRU396573
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-wireless@vger.kernel.org>; Mon, 22 Sep 2025 11:45:20 +0800
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=ms29.hinet.net;
	s=default; t=1758512720; bh=/9jXDfhWXo9xJFl5VAss8K1Ka4U=;
	h=From:To:Subject:Date;
	b=eEDIHPp1wl1gDwdaA2gU4uzSq6xKgMRMrjJ2XFRwpAwSoLp5P+4mhyW1LGw2Nxvyy
	 GtRxHp3/A4xtB/oP+511gU6G8nME/y9Xal8XcYfLaltx7a4lYIwrXPgD32srAQv1h6
	 wgXyzXt6DBeSBlhilyeP29J7ojsjyWiVMP+zeFcE=
Received: from [127.0.0.1] (118-166-77-202.dynamic-ip.hinet.net [118.166.77.202])
	by cmsr3.hinet.net (8.15.2/8.15.2) with ESMTPS id 58M3dVaM417606
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-wireless@vger.kernel.org>; Mon, 22 Sep 2025 11:43:10 +0800
From: "Info - Albinayah 290" <Linux-wireless@ms29.hinet.net>
To: linux-wireless@vger.kernel.org
Reply-To: "Info - Albinayah." <europe-sales@albinayah-group.com>
Subject: =?UTF-8?B?TmV3IFNlcHRlbWJlciBPcmRlci4gODk5OTYgTW9uZGF5LCBTZXB0ZW1iZXIgMjIsIDIwMjUgYXQgMDU6NDM6MDggQU0=?=
Message-ID: <c517b6de-c964-9f65-ea21-8ea1a6e09d00@ms29.hinet.net>
Content-Transfer-Encoding: 7bit
Date: Mon, 22 Sep 2025 03:43:09 +0000
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-HiNet-Brightmail: Spam
X-CMAE-Score: 100
X-CMAE-Analysis: v=2.4 cv=D/nkKeRj c=0 sm=1 tr=0 ts=68d0c5cf
	p=OrFXhexWvejrBOeqCD4A:9 a=aOLPtS5+W4zrI/fJI0lAUw==:117 a=IkcTkHD0fZMA:10
	a=5KLPUuaC_9wA:10

Hi Linux-wireless,

Please provide a quote for your products:

Include:
1.Pricing (per unit)
2.Delivery cost & timeline
3.Quote expiry date

Deadline: September

Thanks!

Kamal Prasad

Albinayah Trading

