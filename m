Return-Path: <linux-wireless+bounces-25262-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9DFB01973
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 12:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25C641899159
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 10:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0782727E7D8;
	Fri, 11 Jul 2025 10:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="Ioj3HCfI";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="Y3QmYXd4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A3E27055F
	for <linux-wireless@vger.kernel.org>; Fri, 11 Jul 2025 10:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.141.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752228809; cv=none; b=E3Qcy0oxlIym9q/1u4NBIYuDcHBcrQtRZVbaAq1+rDyCfi9IwwZSukGkPp41JID/yMuVzWAeaqjxPMyMxcdnzf0ZcvP+MzIS8fOSnq6O1Tha6qbmEp8thiiPMQp5lupBF/MdwgD7dfg0eZp0nhlLCPbAvLWQERQ9bBG0k0v0Vxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752228809; c=relaxed/simple;
	bh=ImKq2rn+4T7uQY59CuD2QZLaohTp66nHrgzJOoPpZlY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=j/C3RF/I6o0QUJ7FntaBcwIbjEcUhcq+GIJl2uMRLAdqPX6Y1nNVhNmj80MwoX5jl5XejpeK2HSVkfzSG95QysixT7w5RPxsmITt/DJHboCVhoHzl8L1e/ZpQyz6mO/Fo+CRm2VvvWvxB6mNqGxGFalZ6kU2nryL1dEz9cuPQnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=Ioj3HCfI reason="unknown key version"; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=Y3QmYXd4; arc=none smtp.client-ip=103.2.141.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1752229707; h=Feedback-ID:
	X-Smtpcorp-Track:Message-Id:Date:Subject:To:From:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=LWttc/saTpTqPkGokRytJGpWQYncHL0xmTev5i5twbU=; b=Ioj3HCfIiyXBlS+TTfTvrXn1xR
	xaRtaNCl+WHjehSPuO/nCl3tCmw2DNrjKb6kyjyW7kW6PPdvTI8Vn0sY7fakGSiFbWsurB/Wlt6Xg
	8pp9jftfJ3w32J7dQB8QKnKht1PExKNCqLmjrWDcRxXSWZ+oGpJCFdGwf6BEyanc7zvsISoHVN6JB
	Tch0DqxOtQqn4IPjmYoDsHyXI7UB/utLegniCQ6CMDtp263IvIeZcnoIrv06opU004VQJIOpTGN8e
	Ybct/rf7+I7xycWO6xHvToOMlHz5cZvgSZgXwC2hMXBQNPi/5kytgQLp9vXm2C//8puVOHi7RVJRh
	mEbsLwLQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1752228807; h=from : subject
 : to : message-id : date;
 bh=LWttc/saTpTqPkGokRytJGpWQYncHL0xmTev5i5twbU=;
 b=Y3QmYXd4Qio84BjxfMsRYLhBqOE/nGhftuaY95Zo/KfivMR4RSDM8ZcrgQjxDN4jX+O85
 fBAKrypOdcqoMKOukU4vO3PwlVpAij6QME12mPTPGrEsDdB4SXNBYWgN5mkyZVm3OpPxvl2
 P6GUk+93dCyM4yj7bgtOMYTqJXxzhksoz947s8vuLCqQyMQT5sMKvPoPIktp2O0SLRn3T9u
 Kpi/I/PYc65zaJgfG1AdiVLERJPEieq5VChRrTn3ZWTBY3bBMA+AcAjGaLcQFoSVfkPkoho
 MaAsQkd4KUM24pP2e1QBPt4o0gJMdXCpBS7GTlixC7IHEnl37DDskNRtq+Ew==
Received: from [10.172.233.45] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1uaAku-TRk66u-B2; Fri, 11 Jul 2025 10:13:24 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.98.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1uaAku-AIkwcC8mMi3-Gz1i; Fri, 11 Jul 2025 10:13:24 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
 Remi Pommarel <repk@triplefau.lt>
Subject: [RFC PATCH v2 wireless-next 0/3] Allow non-MLD sta to roam between
 MLD AP links
Date: Fri, 11 Jul 2025 12:03:17 +0200
Message-Id: <cover.1752225123.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.40.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Smtpcorp-Track: gLj5OFqZk6rH.uCIEHpI7r7nP.wdExgAbSYqQ
Feedback-ID: 510616m:510616apGKSTK:510616sr38dkfA4L
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

To fix that, the first patch of this serie tries to match reported
management frames link id with the received frequency. In case no
suitable link is found, frames are reported without link information
(link id == -1) and hostapd does the freq to link conversion to respond.

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

--- 
Changes v1 -> v2:
   - Moving this serie as RFC. I am not fully satisfied with Patch 1/3
     but can't find a leaner way to handle off channel mgmt frames.

Remi Pommarel (3):
  wifi: mac80211: Get link_id from freq for received management frame
  wifi: mac80211: Correctly init MLO link in ieee80211_8023_xmit()
  wifi: mac80211: Check link id at station removal

 net/mac80211/cfg.c      |  3 ++-
 net/mac80211/rx.c       | 41 ++++++++++++++++++++++++++++++++++++++++-
 net/mac80211/sta_info.c |  7 ++++++-
 net/mac80211/sta_info.h |  2 +-
 net/mac80211/tx.c       |  2 ++
 5 files changed, 51 insertions(+), 4 deletions(-)

--
2.40.0


