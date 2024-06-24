Return-Path: <linux-wireless+bounces-9470-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48EE5913F9F
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jun 2024 03:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8D431F212AA
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jun 2024 01:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46241396;
	Mon, 24 Jun 2024 01:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="g6hpOq1e"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926BE1373
	for <linux-wireless@vger.kernel.org>; Mon, 24 Jun 2024 01:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719191113; cv=none; b=R6yRSbVMpx57uGREcKSMv/eaZWMFZr7Gq3rkWIxJ8mY0VDJefDSR6V0SrZ33biiKa9i/86PHRzXBdcxllBfvLnmYikPfQ5Fn6+Gz+lSzwG3/ik7lz7M8kkPtagIvBlP1dtIksfaRP7Z5KZ++RXF/QgLOj3P41Q471ZE1L3k4ghE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719191113; c=relaxed/simple;
	bh=22JuyHDYU6p9wTvzLAoFAAmFcfyj8g2rUAxim4hhHvU=;
	h=Message-ID:From:To:Cc:Subject:Date:In-reply-to; b=XYTIt3F39VtKFll+1RR1jILeWfWQYNKJLWK7tMLfNArC+rvKMcR+24uOdSPL8deNMx8M4DBxvd38Ifz7Pvb5jGfwVT4YgEbmse2UcVoQ1EUsWI+qX3TX0SQHwIK9Dpu+JnSWBSYYx2H//7X6HH1ShWt3LYynJqxtrRGmbAGx2xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=g6hpOq1e; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4W6qWQ4K69z9smn;
	Mon, 24 Jun 2024 03:05:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1719191106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:in-reply-to:in-reply-to;
	bh=vpfdx3hd/c/9mVF1tPjLu2yhodg62YVfmJcamqfdi4E=;
	b=g6hpOq1e3M/tWyWZsDUGLgVTssND49L/V2rF6+Z0fjA1Iqst0nzP6XhVdP9s4oJorNcZGK
	ab7enjDodBcpoJMTPZ5aC/IuDJEE5wqreJY2bCycexygFsLZ86CHmZYAkv0NyBhN43OzBp
	Th8apMsDN/vMtsXRrtzy2JxBYHrP+OtB1XdZiW3CLJRegl3/fBTvRsMbe4sRzDn8xds11H
	QtAb+tk19Ij6SCUKAzFM/Rd3XDT2a4ezFSn+6S/kuuYSA/3qrOE1b6Qb+lqGEOKeyre3G3
	jmKAp54Pdh93VdKsmzOJQes5o2xXgeu6qNoKxb5CyCYQZChdiHsppEmX+8bOzA==
Message-ID: <2b9285d92664a1834ae3758a684d1cb4.brian.witte@mailbox.org>
From: Brian Witte <brian.witte@mailbox.org>
To: Paul Rotering <rotering@animalcules.com>
Cc: linux-wireless@vger.kernel.org
Subject: Re: subscribe
Date: Sun, 23 Jun 2024 19:55:53 -0500
In-reply-to: <d6f2e068-ef28-443a-9d4a-6e609dd62b0d@animalcules.com>
X-MBO-RS-ID: 5650445d78a61bc58c3
X-MBO-RS-META: 9ou537eu8fwicixgj9rx3tn9g74yzkpg
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>


Paul Rotering <rotering@animalcules.com> writes:

> subscribe linux-wireless

Hi, Paul

The kernel mailing lists now manage subscriptions this way:
https://subspace.kernel.org/subscribing.html

Here is brief explanation on what changed:
https://subspace.kernel.org/vger.kernel.org.html#what-happened-to-majordomo

You can subscribe to this list by emailing the email address below:
linux-wireless+subscribe@vger.kernel.org

You will have to reply to a confirmation email and then you will be able
to stay up-to-date.

-- 
regards,
brian witte

