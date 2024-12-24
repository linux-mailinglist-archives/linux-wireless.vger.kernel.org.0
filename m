Return-Path: <linux-wireless+bounces-16741-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFE79FB849
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Dec 2024 02:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2FBD165898
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Dec 2024 01:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE76DA927;
	Tue, 24 Dec 2024 01:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="eWJ7o3xA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469E018D;
	Tue, 24 Dec 2024 01:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735003983; cv=none; b=qQ9/kmA8WExSwXcO4kA4yJ97QZ3259ki1ILZNixCKAu2YJo+JybmDMIjaME2laKei4NC9NDcwg+qcznv56tfylo/OZqYhL63Jsjpy7+LLClWZaB+2B2/exkds6nFKR4PAb2pSMwr2jfjkdwCUiYDPYE68COI0WLnl4N+40R7794=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735003983; c=relaxed/simple;
	bh=I6HsCen+wr2tjtFGdSqX+iivqi08LwcSwoLbs4zwjes=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N0UrzUHM9HTWlb2Oq8MAQrdcd7aPBJclb2bBFCxolaGdgUo+RqC5D3ZxBEO1ep2fhj5OLTdvlrGu3WLf0uR74yqAl5zD2aepe94GAqLRh/gzSdwuYGJC83t21p6OOZdCEVwpnRL71tfrONjuj/O91k4JadueP0Kgt6Lo6IIgw/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=eWJ7o3xA; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=HE7Dpqf5uSd1NhKlnSd3V1r/CToo4kCxt2SjpZIIs+k=; b=eWJ7o3xA3PQOle8y
	eUXRXWio/9iXstFNRqaZzY1Py6ztMEG7jd3geq57sGUcgtPZCDMmPi0HhvGn34jUwxytMlgrdn5qx
	Ed1Brye1p0mdooqqlq94lydN+uTGrOIq5/UHqD+c1FvoIOWDCKpaM6x3n083l6q3/zkGVooU7UHXq
	UQX3qt4StyvT1DfNDxguw8+AeuG50ol3BRqLnAAI5Sn7AJ5wKwBSJESO57TzoJjs49RECn7wb7WBn
	VgMqVTS1hBmZUrbkzdfg5eYQ5auyemN9UWB8sIqwTaN+Mhu6kM+L78BrnwlOX4/TPkftjPMJLiJmi
	5CWDFYeDaV2ywyCAwQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tPtn8-006wDg-2B;
	Tue, 24 Dec 2024 01:32:58 +0000
From: linux@treblig.org
To: johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 0/2] wifi: mac80211: Deadcode cleanup
Date: Tue, 24 Dec 2024 01:32:55 +0000
Message-ID: <20241224013257.185742-1-linux@treblig.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

Hi,
  This pair of patches removes a bunch of functions that haven't
been called for more than a few years.

I suspect I could go further; in particular I wonder
if
  ieee80211_debugfs_key_remove_beacon_default()
and
  ieee80211_debugfs_key_remove_mgmt_default()

could go together with a data structure somewhere?

Also, ieee80211_nan_func_match() was the last use of
cfg80211_nan_match(); but that would be in a separate area.

Dave

Dr. David Alan Gilbert (2):
  wifi: mac80211: Clean up debugfs_key deadcode
  wifi: mac80211: Remove unused ieee80211_nan_func_match

 include/net/mac80211.h     | 15 ------------
 net/mac80211/cfg.c         | 25 --------------------
 net/mac80211/debugfs_key.c | 47 --------------------------------------
 net/mac80211/debugfs_key.h | 15 ------------
 4 files changed, 102 deletions(-)

-- 
2.47.1


