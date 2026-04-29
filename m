Return-Path: <linux-wireless+bounces-35619-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNmXCxoH8mkimwEAu9opvQ
	(envelope-from <linux-wireless+bounces-35619-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 15:26:50 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E250D494C8C
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 15:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1AB75300AC87
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 13:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A943FB069;
	Wed, 29 Apr 2026 13:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="S5dA1J92"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EDC3FD142
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 13:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777469190; cv=none; b=cDBYOEcI+9GM71O9CsIQH5lgSGlsKFWUmp9fiISbpEJ2IuO+MFrA9ZMs+yrGSR3QnJBn8mid9gpaNSl81X2DrWuxyWf3wu439NjO9PlyHEQfbjedqg3O8OkzGnYB22M8sDnP74jGbo/E/6wBinl3j16V5kmntaKvXjINy3UTGR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777469190; c=relaxed/simple;
	bh=EL3QBWc0quKekI6dhJsFPXU7L3GmScu0M8qQT8DntiI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iLFoATwff7cElvDZxT97/TI6307MzPPwnjD/SFXSLpW7Vujwwae2x3qYyegPS16Un9CFyhbufDFDH/N4y9faT3GgrwuLA8KxbIZxWt9b7Sma7369rIOv6lD3+W9cUrDbzvGmE5+AMjYGUt0jt0Sb8PkVWtc4KdOljo358f/W2iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=S5dA1J92; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63TDQQ2p81222977, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1777469186; bh=J1WiRJQEayavvQia+BnnOI29YqBVWKCw7mjYFTwEHa0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=S5dA1J92gIuZtMpCbCRWrZsAFhK11yiG9a3ptwOV1+lLWY5Oh8bNrWCgRru4zv2dn
	 e40pcJ+uw5k2nNO+L7vx6Bru3MbR/oP+rsCDHnj985Jt/jLvuPY+CmciCBB84SwUrW
	 J/gPAvv/U2MNYVbTcA3bDgKvu8ce8FIFFPPxyWnih/+YiItdIYNGp+uFGkQDtX/yMK
	 uLsMwHE/PYXdJ2vFg+Bbl1HkLSvxcilJOjNlSBU8Ovtfg12WIdfQkSB9XEyTd3Ltps
	 FfCTA62M7U5IP/UGS4peLiFJRn50kk47ctoGhDqXNcZv/jCUZjHZPqHfkFm7+g1pDr
	 EY0Ah8jceYjyg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 63TDQQ2p81222977
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 21:26:26 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 29 Apr 2026 21:26:26 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 29 Apr 2026 21:26:25 +0800
Received: from [127.0.1.1] (172.21.40.76) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Wed, 29 Apr 2026 21:26:25 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>
Subject: [PATCH rtw-next 0/7] wifi: rtw89: debug: introduce BB diagnosis
Date: Wed, 29 Apr 2026 21:26:18 +0800
Message-ID: <20260429132625.1659182-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Queue-Id: E250D494C8C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35619-lists,linux-wireless=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]

In order to debug in field, introduce a BB diagnosis to assist in debugging
in remote environment. Add many counters to monitor the environment states,
and end user can report the counters via debugfs if connection isn't good
or disconnection.

This function is in initial stage, so detection and precision are still
continue to improve.

Kuan-Chung Chen (7):
  wifi: rtw89: mlo: rearrange MLSR link decision flow
  wifi: rtw89: phy: support per PHY RX statistics
  wifi: rtw89: debug: bb_info entry including TX rate count for WiFi 7
    chips
  wifi: rtw89: debug: add PMAC counter in bb_info
  wifi: rtw89: debug: extend bb_info with TX status and PER
  wifi: rtw89: debug: add RX statistics in bb_info
  wifi: rtw89: debug: add BB diagnose

 drivers/net/wireless/realtek/rtw89/core.c     |  68 ++-
 drivers/net/wireless/realtek/rtw89/core.h     | 163 +++++-
 drivers/net/wireless/realtek/rtw89/debug.c    | 482 ++++++++++++++++--
 drivers/net/wireless/realtek/rtw89/fw.c       | 128 ++++-
 drivers/net/wireless/realtek/rtw89/fw.h       |  35 ++
 drivers/net/wireless/realtek/rtw89/mac80211.c |  11 +-
 drivers/net/wireless/realtek/rtw89/phy.c      | 476 ++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/phy.h      |  28 +
 drivers/net/wireless/realtek/rtw89/phy_be.c   |  54 ++
 drivers/net/wireless/realtek/rtw89/reg.h      | 164 ++++++
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |  49 ++
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  54 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  49 ++
 .../net/wireless/realtek/rtw89/rtw8852bt.c    |  49 ++
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  49 ++
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |  49 ++
 drivers/net/wireless/realtek/rtw89/rtw8922d.c |  49 ++
 drivers/net/wireless/realtek/rtw89/txrx.h     |   2 +
 18 files changed, 1887 insertions(+), 72 deletions(-)


base-commit: 83d38df6929118c3f996b9e3351c2d5014073d87
-- 
2.25.1


