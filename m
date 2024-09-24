Return-Path: <linux-wireless+bounces-13124-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5995A984B89
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Sep 2024 21:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BA001C23160
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Sep 2024 19:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8480084E11;
	Tue, 24 Sep 2024 19:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="SdM9jk1Q";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="TrXAzbuB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from e3i110.smtp2go.com (e3i110.smtp2go.com [158.120.84.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138DF12E1CD
	for <linux-wireless@vger.kernel.org>; Tue, 24 Sep 2024 19:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.84.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727206046; cv=none; b=gDEfEu9EkOVfdKhwCwhLrOFF7BLNpYGWRk21ioM4mq7JFs+JrZT8ehmbc5nwth80NiLEps56WvEI0Ok6X8ncKfZ2Bqzgyv3zLc1+MNLV/V7UT+vO1B95AA10dZFQu/dPl4gIvFM7brzSWYqhc88R0PJX3ERPiaRAU284mj/MJlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727206046; c=relaxed/simple;
	bh=o9AheMXyJ5Cmyc7lZF52KShBkTdeQHX7e9sg1eH8R50=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZBNSVERDfhx5EA1NPipVSppF39kiDdBE/3pnaBm+IpTbtPpNQQYrU0k6evz9t4mBO8p46uhffO4QbtyRaadatM+Ihq+GGMbQCyJpw5LAETd287GFoRUfv60kIk6Kxbg5mZvRlluq1DhhN6qpI+KGQry51+3QKE8W67UZFqeQyYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=pass (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=SdM9jk1Q; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=TrXAzbuB; arc=none smtp.client-ip=158.120.84.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1727206039; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe : list-unsubscribe-post;
 bh=jHlTPG4NgHWnOrGLqSDIw8d/8MpR/1AQpbQk+oiNe2Q=;
 b=SdM9jk1Q9ViuS75Bi0ZJ0Ohaiu+23OdISF0P1mLYY7u1yr2TU9/TsRr1cE0aVX2NEa8Wz
 szitM+n7OnN4sc+0dKiqB21xLLTYUzba8I8D0csp37qEfce1C09dNy9smV8Jewpcf2Y6boj
 8bYFwcM9HgEVp1LFEOZg0PZlUCeQwVhuB13XY9zAeihW9bWgw/CKSR0/XDDTSCTt1vaa/5L
 dQS26u3Zwax1Hj0WUp1WDUsC4sg4dzrFwIFJ9N3j47G9Tk8NHUWOIceRvOiXGMIQ+IVcuEV
 oe/696DFfdbC/0/R/ytoH23uX3VfgzfXNBTnXfyrhiA4dj6yWxos/RPgrRBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1727206039; h=from : subject
 : to : message-id : date;
 bh=jHlTPG4NgHWnOrGLqSDIw8d/8MpR/1AQpbQk+oiNe2Q=;
 b=TrXAzbuBNvNR3psAVDd+bQ9Loa3xIAPl7kuOuSVaOyzLJdyhMHXld3U8lkPgDnFwg1R6z
 OjffqFjcoNh35Pr//Tnr4ot5ani6XaRTbXj40cWXKMTFeeRmX/wys/AMMByVTTeIPc+0ouk
 4rfjdXd7Lz9DJutdPH13T0rI1ZTcJr/cysi9uDe5K0XHATWETwEJlWgm2zhDDHw2dEiVmpe
 fkLAJ1j9vd9U8nEqkDtrWC61nxbtOG6ZGn+l0n3x4cVShSINZHBGQXOM2hUE9Rmaudxm2IK
 lMzSb8TRxgko3Fe307Qg/8cmuq3lZ146Hy5g0Nuxgth6WBqes+bSoYVoIcew==
Received: from [10.12.239.196] (helo=localhost)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97.1-S2G)
	(envelope-from <repk@triplefau.lt>)
	id 1stBBs-4o5NDgrlCD5-plB2;
	Tue, 24 Sep 2024 19:27:16 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Nicolas Cavallari <Nicolas.Cavallari@green-communications.fr>,
	Nicolas Escande <nescande@freebox.fr>,
	Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH 1/2] wifi: cfg80211: Add wiphy_delayed_work_pending()
Date: Tue, 24 Sep 2024 21:28:04 +0200
Message-Id: <20240924192805.13859-2-repk@triplefau.lt>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20240924192805.13859-1-repk@triplefau.lt>
References: <20240924192805.13859-1-repk@triplefau.lt>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 510616m:510616apGKSTK:510616sPHEybd7wU
X-smtpcorp-track: IgEDHJFpJN41.DWGipXZXseCk.zu7SRA7TtCs

Add wiphy_delayed_work_pending() to check if any delayed work timer is
pending, that can be used to be sure that wiphy_delayed_work_queue()
won't postpone an already pending delayed work.

Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 include/net/cfg80211.h | 44 ++++++++++++++++++++++++++++++++++++++++++
 net/wireless/core.c    |  7 +++++++
 2 files changed, 51 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 192d72c8b465..01697b624095 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -6129,6 +6129,50 @@ void wiphy_delayed_work_cancel(struct wiphy *wiphy,
 void wiphy_delayed_work_flush(struct wiphy *wiphy,
 			      struct wiphy_delayed_work *dwork);
 
+/**
+ * wiphy_delayed_work_pending - Find out whether a wiphy delayable
+ * work item is currently pending.
+ *
+ * @wiphy: the wiphy, for debug purposes
+ * @dwork: the delayed work in question
+ *
+ * return value: true if timer is pending, false otherwise
+ *
+ * How wiphy_delayed_work_queue() works is by setting a timer which
+ * when it expires calls wiphy_work_queue() to queue the wiphy work.
+ * Because wiphy_delayed_work_queue() uses mod_timer(), if it is
+ * called twice and the second call happens before the first call
+ * deadline, the work will rescheduled for the second deadline and
+ * won't run before that.
+ *
+ * wiphy_delayed_work_pending() can be used to detect if calling
+ * wiphy_work_delayed_work_queue() would start a new work schedule
+ * or delayed a previous one. As seen below it cannot be used to
+ * detect precisely if the work has finished to execute nor if it
+ * is currently executing.
+ *
+ *      CPU0                                CPU1
+ * wiphy_delayed_work_queue(wk)
+ *  mod_timer(wk->timer)
+ *                                     wiphy_delayed_work_pending(wk) -> true
+ *
+ * [...]
+ * expire_timers(wk->timer)
+ *  detach_timer(wk->timer)
+ *                                     wiphy_delayed_work_pending(wk) -> false
+ *  wk->timer->function()                          |
+ *   wiphy_work_queue(wk)                          | delayed work pending
+ *    list_add_tail()                              | returns false but
+ *    queue_work(cfg80211_wiphy_work)              | wk->func() has not
+ *                                                 | been run yet
+ * [...]                                           |
+ *  cfg80211_wiphy_work()                          |
+ *   wk->func()                                    V
+ *
+ */
+bool wiphy_delayed_work_pending(struct wiphy *wiphy,
+				struct wiphy_delayed_work *dwork);
+
 /**
  * enum ieee80211_ap_reg_power - regulatory power for an Access Point
  *
diff --git a/net/wireless/core.c b/net/wireless/core.c
index 4d5d351bd0b5..c9a1158dbdd1 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -1704,6 +1704,13 @@ void wiphy_delayed_work_flush(struct wiphy *wiphy,
 }
 EXPORT_SYMBOL_GPL(wiphy_delayed_work_flush);
 
+bool wiphy_delayed_work_pending(struct wiphy *wiphy,
+				struct wiphy_delayed_work *dwork)
+{
+	return timer_pending(&dwork->timer);
+}
+EXPORT_SYMBOL_GPL(wiphy_delayed_work_pending);
+
 static int __init cfg80211_init(void)
 {
 	int err;
-- 
2.46.0


