Return-Path: <linux-wireless+bounces-27222-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BED1EB51E46
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Sep 2025 18:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E7221C8767D
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Sep 2025 16:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2336620E702;
	Wed, 10 Sep 2025 16:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b="31VuIBTA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from cdmsr2.hinet.net (210-65-1-144.hinet-ip.hinet.net [210.65.1.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3507227990B
	for <linux-wireless@vger.kernel.org>; Wed, 10 Sep 2025 16:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.65.1.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757523027; cv=none; b=PfVAOFweJXzlWBvvS/qU2cjCVblKU4ic5N9IQ7hcRfQabrl1dRzYI9CyIIMFwso1yzJmTkQBxkO4vN7Li1qVKeeyy5BCn827pnx3EgxJ5gX/Kroou7Iid75KwELpnlNkPhxbs5gy7XJZ8GvqSGGvIHEjIuea0T5vL25Fv2hvLx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757523027; c=relaxed/simple;
	bh=+MnGzmqBb67I1t0Sei2bE/vo4z5vwGS0J6E+W5fx1HQ=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type; b=GixsgRSgLxsNnBohYJP0Mb/6PvMQq861NB5MtrYu9ZwdUc6ZdJRXW+ezV089j+6daXs3DBlDz+oT32nO/tkal7Pt7nnQRGwCC64Fl1AChTX/nNqAnXWEvav443KAccpi0oQHWKUY41SsNakfpnv6oQj4+Keaznt9bFIHl6wIYZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net; spf=pass smtp.mailfrom=ms29.hinet.net; dkim=pass (1024-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b=31VuIBTA; arc=none smtp.client-ip=210.65.1.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ms29.hinet.net
Received: from cmsr4.hinet.net ([10.199.216.83])
	by cdmsr2.hinet.net (8.15.2/8.15.2) with ESMTPS id 58AGoIji795943
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-wireless@vger.kernel.org>; Thu, 11 Sep 2025 00:50:21 +0800
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=ms29.hinet.net;
	s=default; t=1757523021; bh=/9jXDfhWXo9xJFl5VAss8K1Ka4U=;
	h=From:To:Subject:Date;
	b=31VuIBTARuOoFwlMPD5TiQw1iMYl/PToXftYCMIFzwrqAZM7aBgSV9fAGKR5ezSSg
	 N9C2XpjVzTdaYh61Na05ZY8dIYjgRn6HkJu0HRa5FHC9Tym6XTH5RUBQH0dVms0ugF
	 O/5TTQ+tGJIbvJ4kZTKdaAEYalmLtkGcqmJhowYI=
Received: from [127.0.0.1] (36-228-21-234.dynamic-ip.hinet.net [36.228.21.234])
	by cmsr4.hinet.net (8.15.2/8.15.2) with ESMTPS id 58AGhXbt269599
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-wireless@vger.kernel.org>; Thu, 11 Sep 2025 00:47:40 +0800
From: "Info - Albinayah 570" <Linux-wireless@ms29.hinet.net>
To: linux-wireless@vger.kernel.org
Reply-To: "Info - Albinayah." <europe-sales@albinayah-group.com>
Subject: =?UTF-8?B?TmV3IFNlcHRlbWJlciBPcmRlci4gMTI4MjIgV2VkbmVzZGF5LCBTZXB0ZW1iZXIgMTAsIDIwMjUgYXQgMDY6NDc6MzkgUE0=?=
Message-ID: <7b58c68d-e5cc-da17-b0cf-3255c83db657@ms29.hinet.net>
Content-Transfer-Encoding: 7bit
Date: Wed, 10 Sep 2025 16:47:40 +0000
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-HiNet-Brightmail: Spam
X-CMAE-Score: 100
X-CMAE-Analysis: v=2.4 cv=BPEQr0QG c=0 sm=1 tr=0 ts=68c1abad
	p=OrFXhexWvejrBOeqCD4A:9 a=dXKTvvsuB3/8LTYzcIUs4w==:117 a=IkcTkHD0fZMA:10
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

