Return-Path: <linux-wireless+bounces-27524-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DF0B8A5C9
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Sep 2025 17:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7995B3AABD2
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Sep 2025 15:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8039031BC86;
	Fri, 19 Sep 2025 15:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b="b7bZlvl4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from cdmsr2.hinet.net (210-65-1-144.hinet-ip.hinet.net [210.65.1.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280AA1E5718
	for <linux-wireless@vger.kernel.org>; Fri, 19 Sep 2025 15:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.65.1.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758296496; cv=none; b=bRldRRLws4ctZTtzp/1uXpPGLURxOv65L4pgSZf92ML5lmV3FBhUGi+c95CPEU3SpikJyoBCxa6irZEfaFe3ElAYcRjWPAYBb8vtvnzuIMU/E+a2ahck1GlcHya/qJIdzwrk/42k5m3xkJwGGLtAW0y37ru98MMTxNTbVD+PW5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758296496; c=relaxed/simple;
	bh=+MnGzmqBb67I1t0Sei2bE/vo4z5vwGS0J6E+W5fx1HQ=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type; b=d6uK40HSM9kAWZFY8xOoElLLG+IDD6VdkfhYBfFDBh5SBJMM4ZjbW9uEc0iqXJVwC/fW547telgSlSo51VKl3euHiC+ePSHA5eAnhumGyFGvml8iGXEW+yZSPlAbGAu7QjOzzyM6KJPgG6iqfvEromIthEkf6Eg8UyUBQTAbMQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net; spf=pass smtp.mailfrom=ms29.hinet.net; dkim=pass (1024-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b=b7bZlvl4; arc=none smtp.client-ip=210.65.1.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ms29.hinet.net
Received: from cmsr1.hinet.net ([10.199.216.80])
	by cdmsr2.hinet.net (8.15.2/8.15.2) with ESMTPS id 58JFfPSH853698
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-wireless@vger.kernel.org>; Fri, 19 Sep 2025 23:41:30 +0800
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=ms29.hinet.net;
	s=default; t=1758296490; bh=/9jXDfhWXo9xJFl5VAss8K1Ka4U=;
	h=From:To:Subject:Date;
	b=b7bZlvl4XkE26EZGBQ2Wop5JvmD2JBItfwQgRpTxPx/AZkw5+M5qX28unse18lP0l
	 JDWumxmeCWZi5o06WMyn7rgffkJfAAMq5ICifTwDYJyW2WeTAOhjhgZhOJ05ua6Tr5
	 37jY1D7QxF8s7BnAE94HOswrS2XdAUXSdns006fE=
Received: from [127.0.0.1] (1-170-171-126.dynamic-ip.hinet.net [1.170.171.126])
	by cmsr1.hinet.net (8.15.2/8.15.2) with ESMTPS id 58JFZSjL557869
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-wireless@vger.kernel.org>; Fri, 19 Sep 2025 23:38:32 +0800
From: "Info - Albinayah 723" <Linux-wireless@ms29.hinet.net>
To: linux-wireless@vger.kernel.org
Reply-To: "Info - Albinayah." <europe-sales@albinayah-group.com>
Subject: =?UTF-8?B?TmV3IFNlcHRlbWJlciBPcmRlci4gNTMwNDQgRnJpZGF5LCBTZXB0ZW1iZXIgMTksIDIwMjUgYXQgMDU6Mzg6MzEgUE0=?=
Message-ID: <d1ce4819-817b-970c-1223-77b2346b950c@ms29.hinet.net>
Content-Transfer-Encoding: 7bit
Date: Fri, 19 Sep 2025 15:38:32 +0000
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-HiNet-Brightmail: Spam
X-CMAE-Score: 100
X-CMAE-Analysis: v=2.4 cv=D/nkKeRj c=0 sm=1 tr=0 ts=68cd78fa
	p=OrFXhexWvejrBOeqCD4A:9 a=JTR6ulth4X3MfQSnu1ztMg==:117 a=IkcTkHD0fZMA:10
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

