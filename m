Return-Path: <linux-wireless+bounces-27772-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D64A9BB2444
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Oct 2025 03:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 724EB19C8375
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Oct 2025 01:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A039334BA2B;
	Thu,  2 Oct 2025 01:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b="0O2+DbiL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from cdmsr1.hinet.net (210-65-1-144.hinet-ip.hinet.net [210.65.1.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5387262A
	for <linux-wireless@vger.kernel.org>; Thu,  2 Oct 2025 01:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.65.1.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759368326; cv=none; b=Qqnxr/rFSNLvvEwO6mXHejrsd40jj7ccy13YW5nFIYtMG2dVAJFJsSXjFON7ewuHJbyb5Qq01XoJX0V6yC2OBACDdDLK0Qk5aKPMSsBqiJiz6LvH3HXVdzi0igtOyWeN3YeZS+lZrlHz3UujwHMg0nplifaB94meDgt9vun5Xc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759368326; c=relaxed/simple;
	bh=+MnGzmqBb67I1t0Sei2bE/vo4z5vwGS0J6E+W5fx1HQ=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type; b=MzNuIZwK95FWtJHfDzeQxWo3E4RduLwqgRcTXRBPg3l2dgocqz5fSttCLkcXabwSBGOzMyNjqsImmIol9XBYWri9RzlUkqpyHayW/i9ZZVrWN6iviv7tTknZJUefOkwuWRobGauDzM3qCij8gKoAvf032wODVPtcYk9+Ejo3kFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net; spf=pass smtp.mailfrom=ms29.hinet.net; dkim=pass (1024-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b=0O2+DbiL; arc=none smtp.client-ip=210.65.1.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ms29.hinet.net
Received: from cmsr3.hinet.net ([10.199.216.82])
	by cdmsr1.hinet.net (8.15.2/8.15.2) with ESMTPS id 5921PIFG326744
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-wireless@vger.kernel.org>; Thu, 2 Oct 2025 09:25:21 +0800
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=ms29.hinet.net;
	s=default; t=1759368321; bh=/9jXDfhWXo9xJFl5VAss8K1Ka4U=;
	h=From:To:Subject:Date;
	b=0O2+DbiLQY5KhBB10YuKWUeIwO9+jMamjIywNlGqVl8fmPolAsWV4KRKZ4gSMMmRT
	 BBIvidQNaHo6b2WduiqOsP2fakbBeDRcnCP9UD/6nTrvIDm6sSPfBC0AhnPwnzh6Ku
	 dylggGkeCQVKmT4yFFrimem1XG0zukaCB7Kn4tCo=
Received: from [127.0.0.1] (114-40-138-72.dynamic-ip.hinet.net [114.40.138.72])
	by cmsr3.hinet.net (8.15.2/8.15.2) with ESMTPS id 5921M9ZD890380
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-wireless@vger.kernel.org>; Thu, 2 Oct 2025 09:23:39 +0800
From: "Info - Albinayah 301" <Linux-wireless@ms29.hinet.net>
To: linux-wireless@vger.kernel.org
Reply-To: "Info - Albinayah." <europe-sales@albinayah-group.com>
Subject: =?UTF-8?B?TmV3IFNlcHRlbWJlciBPcmRlci4gMTQ3OTEgVGh1cnNkYXksIE9jdG9iZXIgMiwgMjAyNSBhdCAwMzoyMzozNyBBTQ==?=
Message-ID: <ec497700-db66-27a0-976d-f3ef354f93b7@ms29.hinet.net>
Content-Transfer-Encoding: 7bit
Date: Thu, 02 Oct 2025 01:23:38 +0000
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-HiNet-Brightmail: Spam
X-CMAE-Score: 100
X-CMAE-Analysis: v=2.4 cv=a8CT9lSF c=0 sm=1 tr=0 ts=68ddd41c
	p=OrFXhexWvejrBOeqCD4A:9 a=3sk9Fkwrcsq+ee0OSwuUkQ==:117 a=IkcTkHD0fZMA:10
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

