Return-Path: <linux-wireless+bounces-13123-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0B3984B88
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Sep 2024 21:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 614DAB2171F
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Sep 2024 19:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3ED51B85F1;
	Tue, 24 Sep 2024 19:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="xJfsJuau";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="iJeSkyS5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from e3i110.smtp2go.com (e3i110.smtp2go.com [158.120.84.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E33F84E11
	for <linux-wireless@vger.kernel.org>; Tue, 24 Sep 2024 19:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.84.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727206043; cv=none; b=ARIoJx7yIzk6kXF0HP7RE01H7vsnglJVlBD8UUE3dCimK+WnmmKv5Sk79LDPkP2SI9341Y92MDPtTgOAzpczo20Z/KvehwfDgGbCAKvVWbXeNjM+8FOXBzJsWDj9iPCccpeE1uK+Wxa7CYbrq7tAbOUiwNMFyhNRkqi+ZOckSEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727206043; c=relaxed/simple;
	bh=DTFUn5D+GS+8oAKFg96mSbEnHq7VklLZgnN8eBHLIVM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YWDHX7gNSu7mqhNFw30lJfzuY17ZTSVhlHe+/erClpEz16noxhLmnpkACvLjVoMQWd6KY2SxPTznUg37TQ5MWE0RID6GPcspbmUf85LaasjFJ9uSAzEmRjVoe2nxXFXJ9HOtq7pVIDHJoEvdcxZBQATma0BrRkRVJ6alJNNnN7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=pass (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=xJfsJuau; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=iJeSkyS5; arc=none smtp.client-ip=158.120.84.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1727206038; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe : list-unsubscribe-post;
 bh=DmPsxQ6uevwu4jCwUKgsQ7AW+OZEseqHR4yN51XYYYw=;
 b=xJfsJuauVp1RJ9OkSz3OR2685uCvbHltNKms3PlytKzXXhPgNiHjidVJKbRn//GVSgVjp
 mbWGxv7kHClRix79uzBl+RCTdi0FemweYF0m5ihiN4xolhfL54D0yJbNBKxlZBcYTG2Cv9z
 4oL6+RqmvyJydxlTunFBDY2QVNwBnLWQSlzNzPJjwGag6wY8ufOEzax9jfHf+r+ZlNXzpcB
 zrt711GptwgWpDXxhDioDc8jf0WIjpxCE8iKgiV6ebQNYc7kVBRTv1nXzItDZCZyANaIMIh
 B6G1xG9ZQVlqx/RT8sj6gFkTjvKWuHuoocnPLaQCUaTqJO/58xvCndEDBeVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1727206038; h=from : subject
 : to : message-id : date;
 bh=DmPsxQ6uevwu4jCwUKgsQ7AW+OZEseqHR4yN51XYYYw=;
 b=iJeSkyS5PAlMV6BtpXnqojJlKAU44tZb+GgPzBOKEJemd0jJ8Lz8gRFe95rmW9g9ByZv0
 RrtRiuZVX0cXQ1Ls5VtnMVgXCWqt8JnWuWEF3Kav/X+Wn0Ei1xPexK5jpPFgjlwvoRr14lm
 3S4+yl873EDWiHDGO2gp6ZhEMG5yaIQLqVOWFzmHXw+TN87uoyRZEOzNPtBwaOx7Hr3s/jl
 1kuCBe2CmaFxAlEZ29+NR3iCIe/RxQQrOYkcNgZ/BLfrXOOKaNUzZhEroo33lQDgWbkmMJj
 uydDjrmjYfVHZl7jmHKB1q69UbaNXEwj5+bILpd7LWF0HSYer2VdCj6QG+Kw==
Received: from [10.12.239.196] (helo=localhost)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97.1-S2G)
	(envelope-from <repk@triplefau.lt>)
	id 1stBBr-FnQW0hPyonv-mJZE;
	Tue, 24 Sep 2024 19:27:15 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Nicolas Cavallari <Nicolas.Cavallari@green-communications.fr>,
	Nicolas Escande <nescande@freebox.fr>,
	Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH 0/2] Fix ieee80211_color_collision_detection_work() locking
Date: Tue, 24 Sep 2024 21:28:03 +0200
Message-Id: <20240924192805.13859-1-repk@triplefau.lt>
X-Mailer: git-send-email 2.40.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 510616m:510616apGKSTK:510616sLKtpkydaK
X-smtpcorp-track: JmsON2KIFatd.5JkoGJXYU5VG.8ToCfQwkwaK

Call to ieee80211_color_collision_detection_work() needs wiphy lock to be
held. This lock cannot be taken directly in the delayed work because it
would cause a potential deadlock. Indeed ieee80211_link_stop() is calling
cancel_delayed_work_sync() with the lock held. To avoid such deadlock one
can use a wiphy delayed work instead.

Thus this patchset convert ieee80211_color_collision_detection_work() to
use wiphy delayed work instead of classical delayed work. But because
this work is used to ratelimit cfg80211_obss_color_collision_notify() a
way to tell if it has already been scheduled is needed as discussed in
[0]. In this thread three different solutions has been considered:

  - Implementing wiphy_delayed_work_pending() to detect if work can be
    queued without postponing a previous schedule

  - Using a __ratelimit or an equivalent to queue the work

  - Modifying wiphy_delayed_work_queue() to mimic queue_delayed_work() by
    not queuing the work if already queued (while also possibly having to
    add wiphy_delayed_work_mod() for those who need the mod_delayed_work()
    behavior).

This patchset implement the first solution.

[0]: https://lore.kernel.org/linux-wireless/D4A40Q44OAY2.W3SIF6UEPBUN@freebox.fr/

Remi Pommarel (2):
  wifi: cfg80211: Add wiphy_delayed_work_pending()
  wifi: mac80211: Convert color collision detection to wiphy work

 include/net/cfg80211.h     | 44 ++++++++++++++++++++++++++++++++++++++
 net/mac80211/cfg.c         | 17 ++++++++-------
 net/mac80211/ieee80211_i.h |  5 +++--
 net/mac80211/link.c        |  7 +++---
 net/wireless/core.c        |  7 ++++++
 5 files changed, 67 insertions(+), 13 deletions(-)

-- 
2.46.0


