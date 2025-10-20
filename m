Return-Path: <linux-wireless+bounces-28091-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B21BEFB87
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Oct 2025 09:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C92D73BF45E
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Oct 2025 07:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F5F2DF3D1;
	Mon, 20 Oct 2025 07:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="JG6pweGx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB1C2DF152
	for <linux-wireless@vger.kernel.org>; Mon, 20 Oct 2025 07:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760946192; cv=none; b=JUhQTILr7glTH0Zhwn3R9+kGdte9ZXp3p3SnVFLMcWg7kCHcTk+MBEWoCisTucdLmobnX4QVjWAZXqyVRrB5QPZN4c8pJloG8zJZKabSU32WDzGtW/RjbmbY0E1C4CkooJrK1brwlMDa2scrRTEUxzk6mYdGtUdCbQv2k4m4w3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760946192; c=relaxed/simple;
	bh=o+heA2VtKssVsnSvCli3/DTTUXGigEu/1MF6I3kXoGM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LqzB/U+YU2ipJGjviDInDNjMhWsJoGnaCY8eOP5QP9kBcNsVPNTzSkbH3bTeLeocBb4XVAbLSfyglYCkAiYVrE9gzXPuzquXdlPplLqrT5KbmZHbdQ59X7k8uNmsZqj4B/0xMwThZ59J+/uq/SSB0DwSZgKnnQrfXD6Rshays+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=JG6pweGx; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=o+heA2VtKssVsnSvCli3/DTTUXGigEu/1MF6I3kXoGM=;
	t=1760946190; x=1762155790; b=JG6pweGxW2hjJJkS0+mXrcgHFPufjt4ZaDbO7D4Laj5lCut
	kntjDV257KMakP1Xlrp89cwEzmaxaX2O0orAupCx5JD1Tszb6wZBksBHfQitm9wofSuNtagl19IHp
	SGAJl8k2ZTfD66BG1jYBN3h9kun2Zozjop3iy7Q3RDSPSEXDT5yUgLM0Ubi2zpfrdc0XJZRKU25bf
	bNUr4COeorwjVbaaH98Ub2R1+o4o+39NlHR0eEB9y0iqTHU2Oxg+cBI6uc6Yo0KDy2QF792BfJBv2
	QWrKVM9sz2tLFNxlobu6xADkS6w328N61EtT8BSJ3UqWfzUN+HUbQOsPyzah1baA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vAkXk-00000008LCW-15WY;
	Mon, 20 Oct 2025 09:43:00 +0200
Message-ID: <cee56c0828cbb555578aa09dfdf4bc9fa54f8f44.camel@sipsolutions.net>
Subject: Re: [PATCH wireless] wifi: nl80211: call kfree without a NULL
From: Johannes Berg <johannes@sipsolutions.net>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: linux-wireless@vger.kernel.org, Emmanuel Grumbach
	 <emmanuel.grumbach@intel.com>
Date: Mon, 20 Oct 2025 09:42:59 +0200
In-Reply-To: <20251019120040.c62e9b9a0eec.Ice40c7be5447410ee74d48a6eeef1711c719c55f@changeid>
References: 
	<20251019120040.c62e9b9a0eec.Ice40c7be5447410ee74d48a6eeef1711c719c55f@changeid>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

That subject doesn't make sense?

johannes

