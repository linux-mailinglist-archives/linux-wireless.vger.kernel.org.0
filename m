Return-Path: <linux-wireless+bounces-37106-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNsHM2dOGWrzuQgAu9opvQ
	(envelope-from <linux-wireless+bounces-37106-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 10:29:27 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E3A5FF2AA
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 10:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9413230099BA
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 08:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25CF367297;
	Fri, 29 May 2026 08:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="R19ZlWLV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FFF2DEA89
	for <linux-wireless@vger.kernel.org>; Fri, 29 May 2026 08:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780043211; cv=none; b=NzYN0Xr/YNe8XJmnpVtIK/yz9u4zOpropFBVKpVKUd+R6+LSVCwrrH/EKt8QGmnfL6GctegHTCa3sD86Yh87F3fBCXHN1gYR3huPLza4XUU1A1n7bUqBFvmILDDX8DKenGIpFp8baza6I8SbthFzsyBpkmLL6cBVZIb485c1zi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780043211; c=relaxed/simple;
	bh=3lEmY+lSlP0v2Ha4hzuwqMJMYvCnDUSGSN5l1bolkB8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=HfSgbIDtvgz4y8B/rOHgctEiu2okc1PcvkARBNKHnDpupOSdBdEDw9u6xAkvMUF4HzpKLguWQPQc9H2wTc7yLtpB19NRKu8uLhHRQpXyU8Ij/ct8mAu+rp1F2LbAkWWuVj+u3zIBC4GgSEO+xIawhtUrgyAl7filGlQqhK6DC14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=R19ZlWLV; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:To:From:Content-Type:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=3lEmY+lSlP0v2Ha4hzuwqMJMYvCnDUSGSN5l1bolkB8=; t=1780043210; x=1781252810; 
	b=R19ZlWLVhjhtBQhv8NQvkFtm0BUs+p/Pb1MdfTvkBzcXRkfhKsngdaoyX0fOSgzquCal4rrrIbm
	Yfj6Pcj0H912muAv/5zkMyHtyQe3l4t/FDvAZ4EITB91Zqm+SFyX4lMUu25NhPvlkRUjciF/TVJS2
	O9zp25eIWCqQ3vVTHEZcZRPXzcXPIIPLjWAde3JZrtPoQDuuO1EPdBlwRoYfn/SevVjRrhwWUuWeA
	/8UC4BkGG7eW+mZFXm0phDsuPkNdlVJqwp4k0geyL7QG4d2WCJoerMLyypftq7meX6F91EXA2BUeT
	YekVEpVAQKNY2UzLIYZttKkaJeU4oGSzABBw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wSsYK-00000009bVp-0Lgj
	for linux-wireless@vger.kernel.org;
	Fri, 29 May 2026 10:26:48 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Subject: [PATCH wireless-next 00/16] more UHR work to support DBE
Date: Fri, 29 May 2026 10:24:53 +0200
Message-ID: <20260529082644.106145-18-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	RCPT_COUNT_ONE(0.00)[1];
	TAGGED_FROM(0.00)[bounces-37106-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,sipsolutions.net:mid,sipsolutions.net:dkim]
X-Rspamd-Queue-Id: 36E3A5FF2AA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Since I had already posted the tests for this as part of the hostap
patch series for UHR, I really should post the kernel code too.

Some of the initial patches are more preparation and/or refactoring
for critical update as well, but then I have DBE. I didn't want to
pull this all apart, it'd likely just result in conflicts.

Note that the patches 13-15 have had less internal review so far.

johannes


