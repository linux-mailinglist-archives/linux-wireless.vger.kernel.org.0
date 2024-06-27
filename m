Return-Path: <linux-wireless+bounces-9646-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB5F91A19C
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2024 10:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E99D1C20283
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2024 08:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B253B7BB14;
	Thu, 27 Jun 2024 08:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="q7S1nZSC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F05A41A94;
	Thu, 27 Jun 2024 08:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719477404; cv=none; b=Va5rNgnYV7D+NIvs50dX5q7GnvmSpF0/HqzXTQgEcu/cDpirYsWfn3W7mN/gBmue9gxzhQYXAZBf9ETbApKbT7cFdhs63bVf9fUv1YQn6hSbtE+VHBhkoBfOc1iqQALq93YP56pqvsgjGG3MsEbs6lLTz09E+ZHgES6TqAvJBTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719477404; c=relaxed/simple;
	bh=C9Q82Xb6WT07HYBRnOgMxEUjQnu1mVJkiULQSBL494U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jJCWCLRf7Wq77U7DjFG94QRWEQsZzgx7pcyxca6DXAkX4DkCKe31c2/19ZwdtmV/5QZMEmWZ7Uq2yBZVv6hge32asxnOuFp6BCbvQTeM3P8ennOsR9+Nfe4LzlseMXl6MWhV1s6PbeDjWCYK2JTuq17jyfon+6O/680R2FFweAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=q7S1nZSC; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=TkM8NqnljI+Rt6yPnu0irxS2PtsUW1iULN/Fr5UZCA4=; t=1719477400; x=1720687000; 
	b=q7S1nZSC9dX7+y0aNOJGE4PNFl7lDPhzBTweZQ2VjMHSidxPNLCdcZh/xXG4DQ5ycgTymBSz0MT
	VCVyaPgjdAMiZyeUtlEzcnJpgQ/U82yMQ5iVMwzppvTRvvWHtXaJEUcYn/rJZZMdjXAlVlaIenhwf
	GTmEgoCJYj18zDJ2J5+M8SRshCReNaxYLY37Dd4cmJdYDSAKjQHr5ttxTkECETkTZbUCh0LRYhBsy
	fP+tuUxrMci+jLqEy1I0J+Fp8WxWdIWBqjLpPZlPlmTeONzeMWQz2lEZDBT3gVvLWKp93J60fsRgP
	BVQ1bz+rDbVyLxRYbPstglZ9I5axuTcXfdyQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sMkcJ-00000006Ykc-30Rn;
	Thu, 27 Jun 2024 10:36:32 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Subject: pull-request: wireless-2024-06-27
Date: Thu, 27 Jun 2024 10:31:50 +0200
Message-ID: <20240627083627.15312-3-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

So you probably heard Larry Finger passed away, he will
be missed. Others have written more about him elsewhere,
Kalle has updated the MAINTAINERS/CREDITS files for him.

Other than that, just a few small fixes, really the only
one likely to matter in practice is the fix from Russell,
for those who use the TI chip in AP mode.

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit 0d9c2beed116e623ac30810d382bd67163650f98:

  wifi: mac80211: fix monitor channel with chanctx emulation (2024-06-14 09:14:08 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git tags/wireless-2024-06-27

for you to fetch changes up to c40ff9b662d08c86b7a46067155a97af0074bb93:

  MAINTAINERS: wifi: update ath.git location (2024-06-26 20:35:30 +0300)

----------------------------------------------------------------
Just a few changes:
 - maintainers: Larry Finger sadly passed away
 - maintainers: ath trees are in their group now
 - TXQ FQ quantum configuration fix
 - TI wl driver: work around stuck FW in AP mode
 - mac80211: disable softirqs in some new code
   needing that

----------------------------------------------------------------
Eric Dumazet (1):
      wifi: cfg80211: restrict NL80211_ATTR_TXQ_QUANTUM values

Johannes Berg (1):
      wifi: mac80211: disable softirqs for queued frame handling

Kalle Valo (2):
      MAINTAINERS: Remembering Larry Finger
      MAINTAINERS: wifi: update ath.git location

Russell King (Oracle) (1):
      wifi: wlcore: fix wlcore AP mode

 CREDITS                                   |  4 ++++
 MAINTAINERS                               | 13 +++++--------
 drivers/net/wireless/ti/wlcore/cmd.c      |  7 -------
 drivers/net/wireless/ti/wlcore/main.c     | 17 ++++++++---------
 drivers/net/wireless/ti/wlcore/tx.c       |  7 ++-----
 drivers/net/wireless/ti/wlcore/wlcore_i.h |  6 ++++++
 net/mac80211/main.c                       |  1 +
 net/mac80211/util.c                       |  2 ++
 net/wireless/nl80211.c                    |  6 +++++-
 9 files changed, 33 insertions(+), 30 deletions(-)

