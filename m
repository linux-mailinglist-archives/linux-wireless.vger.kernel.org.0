Return-Path: <linux-wireless+bounces-36458-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHKeF8/+BmpiqgIAu9opvQ
	(envelope-from <linux-wireless+bounces-36458-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 13:09:03 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BF454E1B5
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 13:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 31D5830C59DA
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 10:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B674C3D0C1C;
	Fri, 15 May 2026 10:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AK+F8Vfp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEA33D0BED
	for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 10:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778840972; cv=none; b=AaOKITC9P3ToRLvNxNsqp9dhr8UEtY5TNg7uJpoNMX7RySkRPglR8CLg4cc3cAsqY0zqwUE9+sQqau/rXbo+OwsuqsAtxGyhoZhgdsA23OTLWt0dCB3beH790zgELb2RaPWWbcovEwCjhmztA8X7QCuhfkK2Uuo+PwOT1An19WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778840972; c=relaxed/simple;
	bh=er+VPAXbatkw7V4bzkd54CKNZfcNcVFF2LecyOSnC74=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VOt9tXZ1eucXF3bXvafAjNw+oYUW3qdtItAB/fs7Gq2NV0KaZIrhMQnffZPj6Z94QDpy+EwveYzkVwqeBVMc/Ye7y/Z9lVz7KCpr/sRTc3fvf/uf7RyiKI6IgpVuRU4OX31iKQ5huSrElUIHqKUe3sNSh6lRX+/7FdQKQ1cHImo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AK+F8Vfp; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-67b6da5a618so13234579a12.2
        for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 03:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778840970; x=1779445770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2dFRR0YqoO/uOT0mubVZdvujclLqeOQBDRrkQLRytwA=;
        b=AK+F8Vfpls8S8O7Xqz6iWcayy6G2Q/Q3zhXEQyKhWvYnw807bUnI5fYDs3jYyxl5uL
         KHgWxxRwKwyb6KpzHTP0QFXh5xTmT+1o9C9CiDNP7rWom4gQv5VS6/eqaCw7BtN9+HyL
         OVitNv2hL+Lo11bxGuhvTXqu87Ftngc7PYj9APTVc9SbI7/Eb0MuAPm8ZTnnZOeFEu6H
         YyuH69nkjnKg38NNqTMPpoiQOIDzXTFnf4JvOLfqXoXFw6FcEpUZ2ULtl/J0ZFq4o6IT
         DFI/4WvC9sPTQsAZN5TQ4Dvh04ZNn2QYFLxV0AWmm7Pj18UWkPqPfSCSG4npvk0VMFbq
         9RNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778840970; x=1779445770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2dFRR0YqoO/uOT0mubVZdvujclLqeOQBDRrkQLRytwA=;
        b=fvyThCWC1wjg4In4//tGAY3OK8h0pDg+EsT3i/oSkmxXQHFmLPgZmSMGdZIr38kkHb
         ls/8zCwIBFbSeksV3ceINc6sy83hJq/SIiEUrT+6Tj4RyivR3mZlCCzqnRMF411+I45N
         zCWYGNZys1mKvW2+YyenTYk27OKv9TBBeIg/QJB8ndmy8wAskb7QMn4qaNahiZXUyGLZ
         xwcb53XE8s4UcOkHB4YGZQ7aI7cVzJyW021r5qzHwDBfBfYcAaEUKUSjUsMbu6CkGjv4
         7xTI9dNVuFePN1k1h2+5uSMtNdIRbBsyixdHJfkItiqfrdDv9aXp2bOdSiBEOILPcCBn
         EbSQ==
X-Gm-Message-State: AOJu0YwwOwtRydPxWF5cqQPIljaIb3JwfLyyZ2L0WloASUZfiZjt8a8c
	foLTwCamoMn8PWxeNe27T0PT8J4IkMhSbcmfetx7bHlF4fv3kfEWSZtc4tW6/PzC3MM=
X-Gm-Gg: Acq92OF9d3Evn3LjKbSdvkRnQgUdJszRAtnrgagL9283hSz4wDujZ3dGlWTI9rl/ePO
	n6OEN6vxkOPGz2alYzXkhm4+vtvnMVNbALdRPgRA2PVImXmkLZn5tje4qf6KiYGpWF3d6piqc5m
	qsnhMAW54ZLRL4q0Eda9y9yRMg3W3/erzccuscehKdXZSDdeTcTa0G3Iqp+LyWT/yUZgTH1hW6o
	4SPZAXq9N81Jkc38auQf7uFt6pEHTAz/YjRYNWkccbbCIQXbSrw07FSWPfJru5wDCJ9QtLDptEW
	aCxer1jlRPzTD0z89lrR8f9pTtdWc6Pk866ci8wSfIGvSxPnwlEVXDiwvo+JK5+N/KD+/cZnmb0
	w7FjIkUw3xT2/hAQlIkZZh6QMTiB6N5msBOu1j+Q+dUEfaSIW/W63XRKcRaOpUCIjZhsn34fC+c
	0j+mgd08wP5Q3Z6cTRayAif3rjsI78xW8QZHzJsR5XWNqMAToXHunWjR/uQl8YDdvGda1EtyRWQ
	zSwLOR7H2wkWnY6GBSKrVLXsEg1TWYr3cClx+JK0pb/AKNtmepovYnE4V7Negl5NDPrQ/h7zOon
	7r8jBY7KZ6Vd7u+FvYA87wU2S9Yz
X-Received: by 2002:a17:907:c248:b0:bcd:bd6:94d with SMTP id a640c23a62f3a-bd5177f054cmr190400866b.20.1778840969376;
        Fri, 15 May 2026 03:29:29 -0700 (PDT)
Received: from ahossu.localdomain (ip-217-105-56-94.ip.prioritytelecom.net. [217.105.56.94])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4e21b1esm205726566b.44.2026.05.15.03.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 03:29:28 -0700 (PDT)
From: Alexandru Hossu <hossu.alexandru@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	miriam.rachel.korenblit@intel.com,
	ilan.peer@intel.com,
	netdev@vger.kernel.org,
	Alexandru Hossu <hossu.alexandru@gmail.com>
Subject: [PATCH] wifi: mac80211: bounds-check link_id in ieee80211_ml_epcs
Date: Fri, 15 May 2026 12:29:08 +0200
Message-ID: <20260515102908.1653088-1-hossu.alexandru@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 76BF454E1B5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36458-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[sipsolutions.net,intel.com,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hossualexandru@gmail.com,linux-wireless@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

IEEE80211_MLE_STA_EPCS_CONTROL_LINK_ID is 0x000f, so link_id extracted
from a PRIO_ACCESS ML element PER_STA_PROFILE subelement can be 0..15.
sdata->link[] has IEEE80211_MLD_MAX_NUM_LINKS (15) entries (indices 0..14),
making index 15 out-of-bounds.

A connected WiFi 7 AP can trigger this by sending an EPCS Enable Response
action frame with a PER_STA_PROFILE subelement where link_id = 15.  The
unsolicited-notification path (dialog_token = 0) is reachable any time
EPCS is already enabled, without any prior client request.

sdata->link[15] reads into the first word of sdata->activate_links_work
(a wiphy_work whose embedded list_head is non-NULL after INIT_LIST_HEAD),
so the NULL check on the result does not catch the invalid access.  The
garbage pointer is then passed to ieee80211_sta_wmm_params(), which
dereferences link->sdata and crashes the kernel.

The same class of bug was fixed for ieee80211_ml_reconfiguration() by
commit 162d331d833d ("wifi: mac80211: bounds-check link_id in
ieee80211_ml_reconfiguration").

Fixes: de86c5f60839 ("wifi: mac80211: Add support for EPCS configuration")
Signed-off-by: Alexandru Hossu <hossu.alexandru@gmail.com>
---
 net/mac80211/mlme.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 5b02141b0cb2..0403ebd11a4d 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -11214,6 +11214,9 @@ static void ieee80211_ml_epcs(struct ieee80211_sub_if_data *sdata,
 		control = get_unaligned_le16(pos);
 		link_id = control & IEEE80211_MLE_STA_EPCS_CONTROL_LINK_ID;
 
+		if (link_id >= IEEE80211_MLD_MAX_NUM_LINKS)
+			continue;
+
 		link = sdata_dereference(sdata->link[link_id], sdata);
 		if (!link)
 			continue;
-- 
2.50.0

