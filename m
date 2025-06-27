Return-Path: <linux-wireless+bounces-24635-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9153AEC1C5
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 23:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 900201C4547F
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 21:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49DB329DB8F;
	Fri, 27 Jun 2025 21:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="bwskmLKo";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="gc09tE6m"
X-Original-To: linux-wireless@vger.kernel.org
Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CB22405E5
	for <linux-wireless@vger.kernel.org>; Fri, 27 Jun 2025 21:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.141.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751058795; cv=none; b=uaXD0cJ0L7SvJbBqMJAJ27cLnJqxa/pNPpGmt55F7zEswTzmet51jssQuK/hIjhoVbGGyk3t6TLeMNfO+K/DFG6o2PC2RoWPNmxLpUPjXHTOLDA8tc5DtwBYpLy2+x74AYwpO0kFTS1d0MSRIROwVAGb+YjoSrjmMbvXOpS+Hfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751058795; c=relaxed/simple;
	bh=bD8cKSDZiZkprHqsi2qiN6AuHVqQo0WDu1prDQBjhQw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FXnL7znR7/kWPBA7JpCGBrY0MBBegAmD8DnVb1E/2VZoeekCZPRvShhl7gbP7VJHKaQrWXssJz3WopaxQPZSf8uwrf1S3XlGr4nw2sRQdxIuYBzul2BRf9F5m+yJ7oB+6USTovqLSkmY+dwUGtlaxk5te3Tu75rLPslPbtAIM5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=bwskmLKo reason="unknown key version"; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=gc09tE6m; arc=none smtp.client-ip=103.2.141.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1751059691; h=Feedback-ID:
	X-Smtpcorp-Track:Message-Id:Date:Subject:To:From:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=xBK5bN5wTTBfmYhTDoMi/DBtiYeX8oamm6c7VYxGRq0=; b=bwskmLKoVN9+G0JCa4pRG7AyAA
	Lso7EjcfPipTJTxP3UC942DHB/YB/y3DZN1xxWgYbTh5uz++QDJgANQNHB4ZSJOZavvRpjPGZIUQv
	sBGkilKnszBSK/QpmyGV1zhLpvny5ZKv2uH5FemwnMRKoZG2Y9TFs34AoHvIAchz92YDddEs/a6E0
	fmki42x0mTUzeCNVvfVuiLHf9nHo+g0p4zUvD7WykD3+mV3u5rCAaoms4pTZmUGFK8DR+FieSWbH0
	YfxcrzFtL+c8VgG5hkouY8tFxoDAaaKWI6b5TuHUmpRZg2+rbc49tJAEIYaBskJuheeBI7RsfI+aq
	8vDg/ULw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1751058791; h=from : subject
 : to : message-id : date;
 bh=xBK5bN5wTTBfmYhTDoMi/DBtiYeX8oamm6c7VYxGRq0=;
 b=gc09tE6mIEquuQBya0/OH4G7cZXJzaNl9SzXxuBZHoDu6QaomBQVTbXQ7ACoIoOWQ+PL+
 9Wquwj/QKn4SU6r+NdjgU/ravIpXBhywmsxV3GCnufQA4jaE21jJVxAue7MHNzNxrg/l/uH
 JsV4JFpv332BphFG4M2qKg11w9JgV76cazO3If/Tb4HVqFtPY5+hPiCtdfFQV+CbSuSQH+a
 n6BEu5/08Hy0VDuGrTLkPMRNm0QNylm4v1BtPSOZXzH3dnj5WqTuq2gYp4AqFRQm+X/ziOA
 wcSyDu+9c5nOlt4oSk4Exf/yo7sLTVWUkSLZ/E0+HZoAUd1fDUVmU0ab+UsQ==
Received: from [10.139.162.187] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1uVG7T-TRk3TU-WA; Fri, 27 Jun 2025 20:56:23 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.98.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1uVG7T-4o5NDgrn9kK-n5xn; Fri, 27 Jun 2025 20:56:23 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
 Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH wireless-next 0/3] Allow non-MLD sta to roam between MLD AP
 links
Date: Fri, 27 Jun 2025 22:46:46 +0200
Message-Id: <cover.1751057146.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.40.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Smtpcorp-Track: dEVpXBm4PAjK.X8BsdPgEWIvU.ElS-uAIangg
Feedback-ID: 510616m:510616apGKSTK:510616sVRmeXDyK1
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

This serie aims to allow non-MLD sta to roam between same MLD AP links
as if they were two BSSs belonging to the same ESS.

The first issue is that when a non-MLD STA is connected to one MLD AP
link all received management frames are reported to userland with the
current associated link id even if STA sent those frames on one of the
other links (e.g. offchannel probe request). Because hostapd relies on
this link id information to select the proper link for answering those
management frames, probe responses to offchannel requests are sent
through the wrong link and the sta misses them.

To fix that, the first patch of this serie does not report management
frames with a link id (link id == -1) and let hostapd do the freq to
link conversion to respond. This relies on the fact that hostapd knows
how to do this freq to link conversion which is needed anyway for the
first pre-association scan. We can also do this conversion in mac80211
instead if it is deem preferrable.

The second issue comes from the fact that hostapd queries a sta removal
for the previous association even after the sta has successfully roamed
to the new link, causing the current sta to be removed. To avoid that
the second patch checks the sta removal link id parameter. If a link id
is supplied and the sta is not currently using this link, this removal
is ignored. An additionnal hostapd patch is needed so that a link id
parameter is added with NL80211_CMD_DEL_STATION requests, and will be
sent to hostapd mailing if it appears that this serie makes sense.

The third patch fixes the link id information initialization when tx
frame with 802.11 HW offloading, this will be needed later to get sta
roaming working with ath12k. An additionnal ath12k fix will also be
provided in order to get non-MLD sta roaming working with this driver.

This serie along with the mentionned hostapd patch allowes a non-MLD
STA to successfully roam between several MLD AP links with hwsim.

Remi Pommarel (3):
  wifi: mac80211: Do not set link_id for received management frame
  wifi: mac80211: Check link id at station removal
  wifi: mac80211: Correctly init MLO link in ieee80211_8023_xmit()

 net/mac80211/cfg.c      | 3 ++-
 net/mac80211/rx.c       | 7 ++++++-
 net/mac80211/sta_info.c | 7 ++++++-
 net/mac80211/sta_info.h | 2 +-
 net/mac80211/tx.c       | 2 ++
 5 files changed, 17 insertions(+), 4 deletions(-)

-- 
2.40.0


