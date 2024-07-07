Return-Path: <linux-wireless+bounces-10064-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EE09299C7
	for <lists+linux-wireless@lfdr.de>; Sun,  7 Jul 2024 23:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD645B20D96
	for <lists+linux-wireless@lfdr.de>; Sun,  7 Jul 2024 21:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36BA6AB6;
	Sun,  7 Jul 2024 21:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="Y0NJFyVF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6330D6F2E3;
	Sun,  7 Jul 2024 21:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720386120; cv=none; b=m+bhRLjtNDyb3b/VPfC8AdtziUVam3nlbkktQYTGF+fKhjczNNb7cvxVj7PmnFy1SCd1mLq/N3tGeTb5cWv8kUUv17g6Gyk3B+BFO6qs4bOyx3xsl0x96b9mbHljzGywLD4H/030g0bREhUHeZtfjrRekv6+/M2uvJMgGLCoN9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720386120; c=relaxed/simple;
	bh=13myIrKBZd02D0pPjABj8yjdERMnwlmTsjolDybM08Q=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Ps+xEVp6q92kSEaEwfW4D767Sj+FWUYLWLXknSLTL5/Sbln+Qyl6+ZUnXOjN3sVYH0NaQAqvHTe/NL6EGZXac7J2KfVuTfT+NMFJ/68iZ5NvfbP6ggbWXUxwInQP3158RnQkgvC4AFbIBo4c6pSiV8agRQHyuvOzn3sroyZJ/Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=Y0NJFyVF; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4WHKSK0SZyz9sqW;
	Sun,  7 Jul 2024 23:01:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1720386113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=13myIrKBZd02D0pPjABj8yjdERMnwlmTsjolDybM08Q=;
	b=Y0NJFyVF8qxq17cd6EV76+XqZL36+mgYqefJQFcZ5PB2qBJ1vpGa+RWt+h5cZcpHBoP97x
	Dk8xrzc8ny3V5GogmP4QUQ0CupWdc3QK72s1c5n12aUkz4fbt36QySwU8JBJusR8AFKy3S
	758XxMo7KHEPkXfby/wnNbCRdR2JH7lqnO67/HpoVZ9Q1QGQO02qlk9rVJ7O3MG2pwPDAo
	dlT23HEReS5Gcan7rcoEZt3fF+P1u9RaZbTmsUMIDtE0LFk89UFIQYvKbZk7aBODVNJ/4g
	TRSYBu0v2iBmmIuJR+ttylTPIlGn1seiA6/dLfmij/jB6LYNnJ86qccSrvG+MQ==
Message-ID: <eb191875-8333-4ad9-bdb5-6170cd980763@hauke-m.de>
Date: Sun, 7 Jul 2024 23:01:52 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
To: backports@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
From: Hauke Mehrtens <hauke@hauke-m.de>
Subject: wireless backports 6.1.97-1 released
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi

backports-6.1.97-1 was released. This is based on Linux 6.1.97.
https://cdn.kernel.org/pub/linux/kernel/projects/backports/stable/v6.1.97/backports-6.1.97-1.tar.xz

There is now a updated wiki page with the releases:
https://backports.wiki.kernel.org/index.php/Releases

The source code can be found here:
https://git.kernel.org/cgit/linux/kernel/git/backports/backports.git/

Hauke

