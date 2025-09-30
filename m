Return-Path: <linux-wireless+bounces-27755-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9079BAE3C5
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Sep 2025 19:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E35AE7B06A2
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Sep 2025 17:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353D51F5851;
	Tue, 30 Sep 2025 17:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tutamail.com header.i=@tutamail.com header.b="gr82xLda"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.w13.tutanota.de (mail.w13.tutanota.de [185.205.69.213])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452672727F8
	for <linux-wireless@vger.kernel.org>; Tue, 30 Sep 2025 17:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.205.69.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759254161; cv=none; b=FLvaAM1giYI9h52+ju/9igC2rUMVNX0YG6A6NyyY3JgjS0hgY1uVrPqUNjwVs7eNHPt0kv76hI2NeoNY3J2kfzsLZqFT2c1e4JLOROeNaw+6xPv5tASW2c1ZEcEUQZvyeLuh46N2nNLGUJcspAO5j35sAQ588og3o3Hz1f6BfqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759254161; c=relaxed/simple;
	bh=R5dvFGaSlvc4ruS9XzTg8/PFchGaaZ5+vMWXBrTxD4o=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type; b=IT9PCeCzPMPjWf0nKG890LWsSS/xLc0Hdnk6Vp5XiZgPRErkCPOzU1u37qO498g2j+kUdNbMCcG2W4xcV1r/tJLDx1JF4lUQf3RavcZT11SiXjXpmIEeG5YbMIbXjDASKZrb75JfvmaO5Nw23Ew+lKlCwCW/hHvQHmUzmO+KN7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tutamail.com; spf=pass smtp.mailfrom=tutamail.com; dkim=pass (2048-bit key) header.d=tutamail.com header.i=@tutamail.com header.b=gr82xLda; arc=none smtp.client-ip=185.205.69.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tutamail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tutamail.com
Received: from tutadb.w10.tutanota.de (w10.api.tuta.com [IPv6:fd:ac::d:10])
	by mail.w13.tutanota.de (Postfix) with ESMTP id 6A044C93496E
	for <linux-wireless@vger.kernel.org>; Tue, 30 Sep 2025 19:42:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1759254152;
	s=s1; d=tutamail.com;
	h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Date:Date:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:Sender;
	bh=R5dvFGaSlvc4ruS9XzTg8/PFchGaaZ5+vMWXBrTxD4o=;
	b=gr82xLdaIOzrL/HA8XXXYW8ElZx0xcwfOJtrCo8NQUX0nYxyAwxUdmh+qiaoBfim
	6DuX2yufGKhKF1vzlx2AvCFXMS7E3FYJi3Bnyouirvr1EOp1gvCqtzwaAX9BZoxPT37
	iSJKoJqqi98UC4ivnVAP8eMcrYaRVrR6quYrI1W678WevYFyX+151x7JCoimAmD6xqa
	J/vhhM6MA6UXvhqeRSCQd7EHje25N+C59wkfV+akDNe4piw4njyYbCPll/DPtaaB225
	wg202bendrv/LaCX2v6EmjIQqOuOIccKGex/w8TqvQ8R1RYmwsrcLCKo4Qrk7OzoM24
	NOxq2OvhHg==
Date: Tue, 30 Sep 2025 19:42:32 +0200 (CEST)
From: cybersnow_2001@tutamail.com
To: Linux Wireless <linux-wireless@vger.kernel.org>,
	Netdev <netdev@vger.kernel.org>
Message-ID: <OaQhzY6--F-9@tutamail.com>
Subject: Module param requested for module mac80211 to disable frame 80211h
 (txpower and country)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

I request a module param requested for module mac80211 to disable frame 80211h. The pwr_reduction thing is enforced but it shouldn't.
The 80211.h and 80211.d cannot be enforced if a user doesn't want to.

In the file /linux/net/mlme.c, I want the whole functions 'ieee80211_find_80211h_pwr_constr' and 'ieee80211_handle_pwr_constr' to be put under a module parameter so users can disable them if needed.

The AP sending advertised TXpower (dBm) and country could be misconfigured and lead to a problematic connection.
It is a user choice. For example, If I have a governement authorization or I'm somewhere else that have no regulation, I must be able to disable these functions.
In 2015, things changed. Why Am I still enforced to use this? See: https://www.silextechnology.com/unwired/802-11d

