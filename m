Return-Path: <linux-wireless+bounces-1015-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F05818EC3
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 18:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95EE81C24E8F
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 17:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F62374FC;
	Tue, 19 Dec 2023 17:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=w1.fi header.i=@w1.fi header.b="QdxzYqNN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.w1.fi (mail.w1.fi [212.71.239.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990DC37D12
	for <linux-wireless@vger.kernel.org>; Tue, 19 Dec 2023 17:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=w1.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w1.fi
Received: from localhost (localhost [127.0.0.1])
	by mail.w1.fi (Postfix) with ESMTP id 37761116DE;
	Tue, 19 Dec 2023 17:49:18 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at w1.fi
Received: from mail.w1.fi ([127.0.0.1])
	by localhost (mail.w1.fi [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OmrPUL6OMIMT; Tue, 19 Dec 2023 17:48:45 +0000 (UTC)
Received: by jm (sSMTP sendmail emulation); Tue, 19 Dec 2023 19:48:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=w1.fi; s=default;
	t=1703008125; bh=I9U4uRYAD8D9AwfeRF52HtAcu0i+PlUaKEl43B3G84I=;
	h=From:To:Cc:Subject:Date:From;
	b=QdxzYqNNyF/C3j10Kwpe3EOMRXF56Ch4RrZDrcBbn5+pmEvrmPd4TngSrv0iBVq5F
	 K7nRfyu402f7bu0dpCvadbe0jSdyhePzbP7GWmpKBEMQLeTyqGvHf9uc9hkC7LO8WU
	 nD5YEiQb2RWxwKWlE3HXaelyRNbpntZ8TXj5Ufiyg4ljf1jK5JGAbcBEhiLg229Oor
	 fknT0PaAoTHNU4cOee4QVsu+m8v/B8sJ4SUNVTow351a7ZXRtmPcQBjr6WaP/2Wr8T
	 fYbjcL8oXD1AqoviJEJMTvqNuWgv+Jl9yaB5pZhN/bKzHdfG/QYOSsZ4gT6rc7fhlG
	 FxTYb3ujoPBCg==
From: Jouni Malinen <j@w1.fi>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Jouni Malinen <quic_jouni@quicinc.com>
Subject: [PATCH] wifi: mac80211: Skip association timeout update after comeback rejection
Date: Tue, 19 Dec 2023 19:48:14 +0200
Message-Id: <20231219174814.2581575-1-j@w1.fi>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jouni Malinen <quic_jouni@quicinc.com>

It is possible for the TX status report for the (Re)Association Request
frame to be delayed long enough for the AP's (Re)Association Response
frame to be received and processed before it. If that were to happen for
a case where the AP rejects the association with indication to come back
later, the association timeout and retry state should not be modified
anymore with the TX status information that would be processed after
this. Updating the association timeout in such a reverse order of events
could result in shortening the timeouts for the association comeback
mechanism and that could result in the association failing.

Track whether we have already processed association rejection with
comeback time and if so, skip the timeout and retry update on any
following TX status report.

Signed-off-by: Jouni Malinen <quic_jouni@quicinc.com>
---
 net/mac80211/ieee80211_i.h |  1 +
 net/mac80211/mlme.c        | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index cd483787f795..32b7d3f6b4b4 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -439,6 +439,7 @@ struct ieee80211_mgd_assoc_data {
 	bool need_beacon;
 	bool synced;
 	bool timeout_started;
+	bool comeback; /* whether the AP has requested association comeback */
 	bool s1g;
 
 	unsigned int assoc_link_id;
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index a693ca2cf8cd..0c7ce022d2ed 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -5381,6 +5381,7 @@ static void ieee80211_rx_mgmt_assoc_resp(struct ieee80211_sub_if_data *sdata,
 			   assoc_data->ap_addr, tu, ms);
 		assoc_data->timeout = jiffies + msecs_to_jiffies(ms);
 		assoc_data->timeout_started = true;
+		assoc_data->comeback = true;
 		if (ms > IEEE80211_ASSOC_TIMEOUT)
 			run_again(sdata, assoc_data->timeout);
 		goto notify_driver;
@@ -6718,8 +6719,18 @@ void ieee80211_sta_work(struct ieee80211_sub_if_data *sdata)
 			}
 			ifmgd->auth_data->timeout_started = true;
 		} else if (ifmgd->assoc_data &&
+			   !ifmgd->assoc_data->comeback &&
 			   (ieee80211_is_assoc_req(fc) ||
 			    ieee80211_is_reassoc_req(fc))) {
+			/*
+			 * Update association timeout based on the TX status
+			 * for the (Re)Association Request frame. Skip this if
+			 * we have already processed a (Re)Association Response
+			 * frame that indicated need for association comeback
+			 * at a specific time in the future. This could happen
+			 * if the TX status information is delayed enough for
+			 * the response to be received and processed first.
+			 */
 			if (status_acked) {
 				ifmgd->assoc_data->timeout =
 					jiffies + IEEE80211_ASSOC_TIMEOUT_SHORT;
-- 
2.34.1


