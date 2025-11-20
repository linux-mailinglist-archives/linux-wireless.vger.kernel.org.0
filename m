Return-Path: <linux-wireless+bounces-29154-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DBDC72FB2
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 09:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 6004E2FB59
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 08:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CF778F54;
	Thu, 20 Nov 2025 08:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="SSO18NN3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646C62E5B27;
	Thu, 20 Nov 2025 08:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763628887; cv=none; b=N8Ab4uqrR5GdLquxskyr3MYQOoXSiwd+rwB33SyJVGFR0n8iBw80Yax9ecTwER21YpMY2gBKGuUGSVkjgDzRGQ77JmDhPpIDuVk/il8Mm7lmo2cCB2G+/SdQHLi6cDsGGlMrjT3gzVF4eR9PmBp2QM21HW4Llrw4MDJMy4DXK7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763628887; c=relaxed/simple;
	bh=9t1SLxFTTCgCigMvfFlPg6CelyPqV1hURNLUMl91xq0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D1tGX/XWNtQs+HaHa56k09gliNmlM7iOrpwIfwtegB2JhzSyNRYUEF5KKtCzat5LmfRZ/hQuSZpZH7sEaEk+R5UUTGniTbvJ29odIo7aKNEeQN0xGUjx4eiTZZKLvMyMJwA7PNE2eiGXSZB2jA6Wpbgj8M+flJXmjv/n/p4+LRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=SSO18NN3; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=QNlzwkQe/71Dme4S0LR70KyKvDEY9cH88QbfMbdfoqY=; t=1763628885; x=1764838485; 
	b=SSO18NN3uHqnsJWSTJdawFmi3Ug3i3cBUX7i4VIQLN0oJS7I64pyFyJ+bcM7YrfwK6nhEU3TIch
	I6b69GCG0iFEJfDyngK1Z4f9a3ONYvzoF308iDwr7ucuVjB4ZERxYLtPM2yElfb8e2ppJ20IKuaiI
	MnAZNgMJk7cEvoEatsixF6oV4VqSSYBoaSl8o8Fa2RLw0WlWXNN6bvvZVyGNUsJhZaQ5xV2k4DAzW
	hBMV5rqoQLVpQqHOBOWqTE03ZpEeupOkLtP1Qw0pjJ+yea3aeA6ud2iByP87JA9b2wesGeuuG+GCw
	f3AmPwXb/pWf3lTXXRTZBeFkfTpnyLUTSPdw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vM0R3-00000004TSl-2S5K;
	Thu, 20 Nov 2025 09:54:37 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Subject: [GIT PULL] wireless-2025-11-20
Date: Thu, 20 Nov 2025 09:53:10 +0100
Message-ID: <20251120085433.8601-3-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Looks like things are quieting down, I fear maybe _too_ quiet
since we only have a single fix for rtw89 scanning.

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit d0309c054362a235077327b46f727bc48878a3bc:

  Merge tag 'net-6.18-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-11-13 11:20:25 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git tags/wireless-2025-11-20

for you to fetch changes up to 0ff8eeafba5c5742effb9e2cfdb52daa17b1b7d7:

  Merge tag 'rtw-2025-11-20' of https://github.com/pkshih/rtw (2025-11-20 09:44:08 +0100)

----------------------------------------------------------------
A single fix for scanning on some rtw89 devices.

----------------------------------------------------------------
Bitterblue Smith (1):
      wifi: rtw89: hw_scan: Don't let the operating channel be last

Johannes Berg (1):
      Merge tag 'rtw-2025-11-20' of https://github.com/pkshih/rtw

 drivers/net/wireless/realtek/rtw89/fw.c | 7 +++++++
 1 file changed, 7 insertions(+)

