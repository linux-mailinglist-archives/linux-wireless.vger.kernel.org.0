Return-Path: <linux-wireless+bounces-27440-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F209B7CC60
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 14:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B59721B262F8
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 10:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796E1285CA1;
	Wed, 17 Sep 2025 10:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="nqX4hXc6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29DC2D05D;
	Wed, 17 Sep 2025 10:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758106328; cv=none; b=qzdjjXH/QlC1rVaRVp45SEdaXE6AzQEHBAkhTf6csgeAzG2jtMSGxAveqa7w2YxGmUhEZD6NFE32ySm39koGCZxVj072Yenm5Uel9AT26GCgycaFhW2Twz5bIYcn34urxaLTRsd2l8fpUuOJuWi4oNf2yiAFACHosz6r80Gwjdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758106328; c=relaxed/simple;
	bh=MguEq0RFysX6iVHApwFAjBaZigxJOOEDap5FC+ybZ9E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oMg6+CHeff87QRC22qAYn6xHwofL6ed34aUU6yYyj3nkb42sPr8FpJu28vTZ/BPRI3T3VVE+2aIpyF5loaQyxqDblTeUixvqqRGX23oDeMabRcCzQwoPzCRyOz7eo3QVgW9ttuylLbkO9Q+1hb9zwAJjLcHwxtXTg3cPDqjglcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=nqX4hXc6; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=lr3uZ43uOxqUdkQuwA7YKfaJGPDt8d6P0M2HrbHSyoA=; t=1758106326; x=1759315926; 
	b=nqX4hXc6YRmHp9U3PjEgQzmqShyzSCXug4vpdm+njpFqyef9TKiZnevDA90M8qcKPhQptPPTAj/
	27NSbVQdrjLylMDN3l5NGpCNHNmTJwcZgi2IJJCJzKQFAHi25DUrmyzAXMUVul0f3XHSnhqe6Gfkc
	SQ0DqLoN/Va+1kq8maILePc9/AohM3GFPaTt9bn3l0+24ERA6vWcbxkVWte8Zd3kNQeYCnmbFuqbe
	UYDPMbgeQmjnwXxu+QaS6doZg3OecURwQ3Ksaho1QC5FsiVAgZJ/iDvS8W0H7YaVraPMNo6xT55f0
	WBzocL0O60yLg6JWdkt9aGUBQydEeQiYEVng==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uyplc-0000000AoDo-1930;
	Wed, 17 Sep 2025 12:52:04 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Subject: [GIT PULL] wireless-2025-09-17
Date: Wed, 17 Sep 2025 12:49:50 +0200
Message-ID: <20250917105159.161583-3-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Two more fixes, but I think things have quieted down to say
we probably won't have more. The iwlwifi aggregation thing
is myself having messed up some recent changes, while rfkill
has a potential crash that doesn't really seem to happen in
practice, or only on some select machines.

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit db87bd2ad1f736c2f7ab231f9b40c885934f6b2c:

  Merge tag 'net-6.17-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-09-11 08:54:42 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git tags/wireless-2025-09-17

for you to fetch changes up to b6f56a44e4c1014b08859dcf04ed246500e310e5:

  net: rfkill: gpio: Fix crash due to dereferencering uninitialized pointer (2025-09-17 12:37:05 +0200)

----------------------------------------------------------------
Just two fixes:
 - fix crash in rfkill due to uninitialized type_name
 - fix aggregation in iwlwifi 7000/8000 devices

----------------------------------------------------------------
Hans de Goede (1):
      net: rfkill: gpio: Fix crash due to dereferencering uninitialized pointer

Johannes Berg (2):
      wifi: iwlwifi: pcie: fix byte count table for some devices
      Merge tag 'iwlwifi-fixes-2025-09-15' of https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next

 drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/tx.c | 2 +-
 net/rfkill/rfkill-gpio.c                            | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

