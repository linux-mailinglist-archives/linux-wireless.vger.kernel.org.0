Return-Path: <linux-wireless+bounces-35086-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKmCF69G5mk+uAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35086-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 17:30:55 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4210B42E400
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 17:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E5421309519A
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 15:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FBF22B8C5;
	Mon, 20 Apr 2026 15:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4GI57oQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D69A17A31C
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 15:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776698354; cv=none; b=Fszmtwv5dbFBnRPqPB9yBj/xKxkagkeeSgTZCmOWuAG/CX0WIWg9Puytsm+nxRfSZR6AweKNTGz2rPbPHqM9//ImOGuj6THnwfBOyyKadOZ1XxXtE2Bpxi5TLTLpwwhjqT03dNpcYxldnudNdiU/D9/32DWHIj53zs+ezgOZegM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776698354; c=relaxed/simple;
	bh=1RIbNCwAwPZ+tO6yRtl9kZg4OcH4KIufSEgKwjXtJas=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Z0jxt46SDtMpMXET86EdZZNREVs9yA18Z68m9D9vh+SzPVPfnzxADEjzz8rqxFr3B+2qb+Hgsfcr+/ztT4m6rcPtnMnkmKFK+lh4d62GcrajUkya21jGm+Evx6kLui4lRt2mS1Fz1l4eqNHrIkg/Lqcf6F2rkEVSdvXw83A4WLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N4GI57oQ; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43eada6d900so3197534f8f.0
        for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 08:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776698351; x=1777303151; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n3FD/s7AW/AHmwjCwKG79GXRWosFi6qB1cnUUHCz7DA=;
        b=N4GI57oQ04uNRA3ZJs9n1vawtacpjFGw7guLW337vUk7gecjBFmMJhZk2i6WzrsWh9
         Wz5q/VQb8C/xoJStA4dXFPHVbMdrQ18FkSbCpOuGapNbk4v6aXQWlABmlkeNziS2NK3S
         eSsnf0hSp1rGVLUgrwOCbN4V9SyepGekBScHUAeOdKRpgatz+QIt82DHHiPhYTL6rw2o
         QAy0Q96UtjHUtl01oJ3ttWVJK5ckn+njLs1xsnd4xMhwEMD5tLJvYpUP6ZODJ/b9gJEi
         UsAynPizdQXeAFerf18/qb9I3P/g8LuLs2tyIgD6Bm2WiuivcqN2RNQBjKKX/PyxOomg
         j/sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776698351; x=1777303151;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n3FD/s7AW/AHmwjCwKG79GXRWosFi6qB1cnUUHCz7DA=;
        b=DRAwekrQICcC5ETDQ3zBpwGTDlST3dF52D/ULXHFj/5Wop57vlpjpTrEfGVxNSRfX7
         FxL3DjBAA5w/ga8CFGCdb3jGhUvtXZpLsLrOPJy3qYIO/UMFf3SUwt0svrOQSY8Hj0NH
         T+My2r8AlHSczkhM+BI9bTnXuZcZ2jdKlfmN81i3BXRcmH8h5fiLPf3P4jFIBhVz22PJ
         qXq2eTg1y1je6Yhyc4zoJOc+brMU/vDZieXfQBhcHLGExPUdlLRYx6D9c7xtKMQZMm06
         vBTyVfuqzOR0DWoJicCWjK+h26Jtr9AC0yNmxGFGMmc78w3kgAYNINBZK/ryiLZcNHx3
         Cb+Q==
X-Forwarded-Encrypted: i=1; AFNElJ/DbldIIB7Oi42wM4u9WZHx7Uua4lK7yVIy6UZwV0eYLz91nBkWAxDWLYK9p28AfEnPujUWsvkOsOClDO1EIw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzmLDoZxrQeedbk4o8NDMou+23HyeQLbGwGDoQCnD2XinWmqtIC
	aDkg2gIWsB6VSCxTux9vgjAiWeAST4vLZxbJRLZQSZ2HrNcH+uYG/cbb
X-Gm-Gg: AeBDietEiDAPzpM9RTStwsWjK8+VE7MbuxGLV33F707z3aoWVaigO6KFdCHyY5Q1By7
	6mfuwYY6V5hhcSN5XRaArpu7l77bLL85wkdNt2dB+lF5pPMs+H6Fdn6+8eYFLhkM1wFh4CvITnB
	mC8p8lGqtiDMK4QSRB4gpQx0CVBgJBo+MSKzO2nVuZF81eZDWWNeyOVzrcdHSQV+eva0D9DoAFk
	qOzgs5NuStOs6NjG2OzrKUxmi9D9dgNHec2UN5+p1KUVlk7xqFP1QZY2PvQei8Yy8UYAE8DWqdp
	ol5/m0LAXfQBDimZ28SzQaD1Pa5rhfWeluWycrcJnYrdAaOACbsqFR3xkX5STvRRc7fFkQBeTho
	H3ifD0i97i+aO5SA5tgvy2qyaIiN4RyJ5SiAqj+FmIYH6XQ64fdhd77qmq7OyTVj6m12N/MmaBr
	4u41eXKypREvq5SDBzoIjXgiSXS60R/A==
X-Received: by 2002:a5d:64e6:0:b0:43d:26a2:f8c3 with SMTP id ffacd0b85a97d-43fe3e14047mr22847771f8f.35.1776698351391;
        Mon, 20 Apr 2026 08:19:11 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e3a174sm33822216f8f.18.2026.04.20.08.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 08:19:05 -0700 (PDT)
Date: Mon, 20 Apr 2026 18:18:58 +0300
From: Dan Carpenter <error27@gmail.com>
To: Ahmad Masri <quic_amasri@quicinc.com>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sumanth Gavini <sumanth.gavini@yahoo.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Kalle Valo <kvalo@kernel.org>, Maya Erez <quic_merez@quicinc.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] wifi: wil6210: wmi: prevent underflow in
 wmi_evt_auth_status()
Message-ID: <aeZD4hGhsrsSJczJ@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35086-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,intel.com,yahoo.com,kernel.org,quicinc.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[error27@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 4210B42E400
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The problem is this condition:

	if (ie_len < auth_ie_offset) {

The test is supposed to ensure that "d" is large enough to hold a struct
wmi_ft_auth_status_event and 3 additional u16 values.  The "ie_len"
variable can be negative but, because "auth_ie_offset" is type size_t,
then negatives are type promoted to high positive values and treated as
success.  The effect of this bug is that when we do:

	d_len = le16_to_cpu(data->ie_len);

then we may be beyond the end of the "d" / "data" buffer.  Fortunately,
on the next line:

	if (d_len != ie_len) {

the contition will be false so the negative effects of this bug are
quite limited.

Fix this bug by changing the type of "auth_ie_offset" to int.

Fixes: b9010f105f21 ("wil6210: add FT roam support for AP and station")
Cc: stable@vger.kernel.org
Signed-off-by: Dan Carpenter <error27@gmail.com>
---
 drivers/net/wireless/ath/wil6210/wmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/wil6210/wmi.c b/drivers/net/wireless/ath/wil6210/wmi.c
index 479b2418ca34..57e6a43a04cf 100644
--- a/drivers/net/wireless/ath/wil6210/wmi.c
+++ b/drivers/net/wireless/ath/wil6210/wmi.c
@@ -1629,7 +1629,7 @@ wmi_evt_auth_status(struct wil6210_vif *vif, int id, void *d, int len)
 	struct cfg80211_ft_event_params ft;
 	u16 d_len;
 	/* auth_alg(u16) + auth_transaction(u16) + status_code(u16) */
-	const size_t auth_ie_offset = sizeof(u16) * 3;
+	const int auth_ie_offset = sizeof(u16) * 3;
 	struct auth_no_hdr *auth = (struct auth_no_hdr *)data->ie_info;
 
 	/* check the status */
-- 
2.53.0


