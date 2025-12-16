Return-Path: <linux-wireless+bounces-29818-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F65CC44A4
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 17:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AAA2E301B127
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 16:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E1635965;
	Tue, 16 Dec 2025 16:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="HAcTtf7K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E1627A907
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 16:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765902268; cv=none; b=aDyPIP10uXAuZdn/Qnv4oyommfiXOEqgG9egcItHbTpb5AFimn6lE/5VAlLorZRBiBMrRwdxEgWjO/fXWt+8Zb1RyBCNIM1a8R6Ay1HI3OuDQOo8uCF8Q6loMN5bAuRobxVPeJLcPVbJEFNsWcnbk//9242IOSw+TQpnDXzL0tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765902268; c=relaxed/simple;
	bh=yKiPK4Y7Wa2W2ZFjxoX650MTOgggfy0BrekcyG1wbhc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Z2g4VFMR1rNuMdoYwgB/a9EyOWqWO4gsA5cDUBkeAcprNn3FKD0EQ9if4k45BzfMk2fKjaXgIEKpL4od00dDQJXiQeHPg1tJZcrexsrexLtgpgRdoNbQBx1vGwGgQbFHX+V24+EtJTJDizhzYPWvatnnqO3sxTqPe/6Cdkf2yBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=HAcTtf7K; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:To:From:Content-Type:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=yKiPK4Y7Wa2W2ZFjxoX650MTOgggfy0BrekcyG1wbhc=; t=1765902267; x=1767111867; 
	b=HAcTtf7KZ28HVxg6Vla4hL0oQeb30NyTRlxERKAAEQ8xdFl3rga1HJzARn4zv5cl+6vCm3LSHFA
	OCL7qFLLLEZO58p6UQ8N9eOeyBnMTPLNCTdy8lwXUzf76xy3P/dSeVNf1ALGbhrdCRdsFsp7RyH0X
	4+FQuvPb64ozqfxtvz2EFhbq30L7Zx3GQE0HSsnjsUyuZgIJSONGZLE/8t5Xy53TWtXUpHncLAvOh
	MvmGfEUL5Z2NpxxmhT/RExlvtO1uOaIeNf1LAj8vE2wYNsFOHvIcJ/+faLe5VXWYxQ52mIlHU4F6F
	k425iBbvpKHpAWw+3G4tsazTwVgRCGw/sOqQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vVXqZ-0000000AaUr-3mQi
	for linux-wireless@vger.kernel.org;
	Tue, 16 Dec 2025 17:24:24 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Subject: [RFC v2 wireless-next 0/3] wifi: add initial UHR support
Date: Tue, 16 Dec 2025 17:23:34 +0100
Message-ID: <20251216162421.40066-5-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now with net/mac80211/uhr.c, sorry.

johannes


