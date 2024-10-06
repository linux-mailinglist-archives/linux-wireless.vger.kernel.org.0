Return-Path: <linux-wireless+bounces-13570-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C37992223
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 00:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6055D1F213D0
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Oct 2024 22:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D79B18A6BA;
	Sun,  6 Oct 2024 22:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="XZCtBEbu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E7416F858;
	Sun,  6 Oct 2024 22:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728255195; cv=none; b=OFrLPVS79wzZasWf6r7bpOMSr9CT4bBPwwZaDtULqBuBalKpGmufWnMBt8pGxFD9VaDOiRia0VJirTt3z0g7uWODsvYfKUAtg+M/7qQgvtkGLuNifGTIU69d5+il26/IJNoVHDriRbNgrFz2CGWUfBTPyo22aAPLR3pJ5uAEVPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728255195; c=relaxed/simple;
	bh=XFwrI8XxWICjlpwEBKdFcifZFMs4l9GCb+DOXufcVlc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I0KwUfwFe6I/uXL+RSAbIomWcfqMSi24G3Y3edQu1U3Pl3yY5os1whv+6s0vnnqSD52z1FFLIlmfaXgJo2W0mn5ybosokfy6bz7ZR8BnBl7QnRtnZlfCgLqadWHhKzwLuDyknyf2Lms/Tb1n8aRwNovZhMGcRPDx0lgQDeg47UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=XZCtBEbu; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=jtiWoE34WuUUJ7TunblVC2arXjPBgbgFmdliX7DTq48=; b=XZCtBEbuqKLO/flo
	P62AVQSVYAwNymaVnAdSKnU1f+bej6YOob6JOBpy1j84mlvjqdbiC8t7owHIs+sDmqQP4+wr5MrMh
	v7WG8+GE5yVzg2xW5yk/I5h6XVoQfwHyC11z4fKEXQ2peWcEJVRW4WUVskmM0em8uXuWVnzDuUt8Y
	Wz9rhkIhNu0+LogtuvetRUIuZV3YO8/zR9OnbijUxfx/haiijrc2Objd8Ai1k9/uZr5s+UPTLYA5w
	2RR/Fdvg6IEFfqtf3gVpWvngq6U3VWFbWZRiEin1C5DshIRoYFp8LhhOdy4Gulqqj2mQ5PRMO3R+h
	yeKWNKKtT726VTNLhg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1sxa7c-009LcO-1f;
	Sun, 06 Oct 2024 22:53:04 +0000
From: linux@treblig.org
To: johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 0/2] Some cfg80211 deadcode removal
Date: Sun,  6 Oct 2024 23:53:01 +0100
Message-ID: <20241006225303.121445-1-linux@treblig.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

Hi,
  These are a few unused functions a script of mine
found.  They've been unused for a few years.

Dave

Dr. David Alan Gilbert (2):
  cfg80211: Remove unused cfg80211_background_cac_abort
  cfg80211: Remove unused cfg80211_vendor_ functions

 include/net/cfg80211.h | 54 ------------------------------------------
 net/wireless/mlme.c    |  8 -------
 net/wireless/nl80211.c | 11 ---------
 3 files changed, 73 deletions(-)

-- 
2.46.2


