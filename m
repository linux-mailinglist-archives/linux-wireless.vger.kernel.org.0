Return-Path: <linux-wireless+bounces-36124-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YP+HI/2D/mkusQAAu9opvQ
	(envelope-from <linux-wireless+bounces-36124-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 09 May 2026 02:46:53 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7AA4FD1A7
	for <lists+linux-wireless@lfdr.de>; Sat, 09 May 2026 02:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3D30D30099B5
	for <lists+linux-wireless@lfdr.de>; Sat,  9 May 2026 00:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D61136672;
	Sat,  9 May 2026 00:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFRODFRv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6873A1B5
	for <linux-wireless@vger.kernel.org>; Sat,  9 May 2026 00:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778287608; cv=none; b=UgLaB9E5m5kp3PP2FLg0cfRhhHSf7AOV20r0sAONyLA9kB38vG9xavPEu/Zp39Hxy+0fZbvasFFvywrEbuc+Fu9EUyU2rpnaZIMtGr4IcQh5tmwKwS3yLIMaNC18xvi/r8uwh3PSofEa55vJ8QOlDu9USQs3LIoNcUSnf3AYZwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778287608; c=relaxed/simple;
	bh=Qy/C8lPPAxSDdYSX0HVNrhkDW+Sflu2K6O7wQ27lKDE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pjPKICg48uHcjhAJSSkgrAp4ooLwx688K9JQVpzsmwjgzXuCCbAmi1LdcSgmrD0dBsTs6KZbgDVsz/m8poGE0yXkuewdjlZXCaHmgiuLCOFDMTGTwG8j1T2c5vHqFks/HD7VRUyboAKSiTw55V+SRgDVBGgM11ET+sufi4iqEas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YFRODFRv; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-36622412e97so1474735a91.2
        for <linux-wireless@vger.kernel.org>; Fri, 08 May 2026 17:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778287607; x=1778892407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m5ayDC9zM93PcmzZdMOeR4wwyCx+XWYV6FtY/Z5CzfA=;
        b=YFRODFRvD+ETpiD651mx2nKNTCxLzWs6jsqMUwrxWp+mdj3DasvY5IqYz6c/XM9BNM
         ZnE/J4IiLIBPNvYFnn7UsrC4f3Ba8/vfP4yx/uIiKcxyuo2/DYOIvlbnvqN4ZSd3d9dm
         3Uba8qnIpiWu9UCmZvAYFk+lReL2thqaz0Gdc61w8xcrF6vA6KrIBjkCUeLswH33Orj0
         B6u4zUG5vS8JG4XHuzvDa+v11SQbK+LBJstZ0E6WSfJhg281zXPNdSByUEW6VumELFg1
         QxXS5l3ssWJGfSbs2lm1j4h0j/eMdkLSIAm6SI1mI+U3cV8D6+s9jiTea08IJ1/N1INq
         RZGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778287607; x=1778892407;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m5ayDC9zM93PcmzZdMOeR4wwyCx+XWYV6FtY/Z5CzfA=;
        b=p2sIWU7pWrtToUJNVnpFv3monzr1bA1yceQbac6nN4uNOqnlhfspLLuxcLKcqyVSzg
         A58QJrAgerb2bNcBAs5fvjNrA4mfo4LdHf9EIYhQ6ejn8Zx3d7ryw3Xsud9y3LZzE4vy
         DiKVA87rOM0esDM99yKO1/gtJl2WSkDi3/le1bieb7ag6dNMbXy9pqJ9PlkBjZUWfZs6
         jKMjFMwB4jlwkO321BVcsJ1fgL52EX10bPAChVKAQY2nn1dehWrvNxJ4t5Y5trFJwxoN
         c1EwjwejgDB4AxAsI/dadDK+sJQCljchXD2JE09aGvPWL5uzJ3FnUrPLGqClELg2eSXB
         fHCg==
X-Forwarded-Encrypted: i=1; AFNElJ9XWC9GSWlHt7X2yQhVwI+4wLo+ihntmIN0Qbg5Y5SZLIqzrvAyHJ2TRAo0vxt2z/LMema6i8WylhQCAgi5Cg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzZBGd4hz5K2IUsY9SpLpN3cxPhyyE8NCrwT7QFkYfAZwF/mszU
	TEqUXz4dBAjiZFUJ1v26R5GlDeAbD60MAjfySt5qgW1tQ9TNEeW+KKdwvY3Lyw==
X-Gm-Gg: Acq92OEKe9r5lO24EGgivV4HkGqMdLRAK9xm+WP7mCSwr0Ehda77lLMsYvFBDwMT9x5
	LXGdqh3X497y/IHucV294YrNQP/iNciI+1LOv5p+WjcJyQQ1ZINo0NnYi5tbqCTUQ3vcS623Jh0
	VwSurMq2eNkkREjAa0KT9K+FC9nsxw3kEOVHOGUnRG1gHqoa0GTjUy8FFh0D8ucBTVdU5ZXP+wE
	8BLO+J5pdL5JVvPExsEi0DlxwzON+S6Vd/GgwAaxuSaoBIbaj8jekNhbyej4xZtRMMb5qpCMJv8
	xuTC3CGupyt9IhsuSyxJ7y9y0G8l1tOBMwErbjgHd1cH8aj1dHPWpey6Fjgz9hPVJB0lRny/geJ
	mYTDBLCtX8k6Gop1OWUKiX0B9SdH1yZWQp62V+pYP8VWr3e7Hpmrj/K9Vt4GNlJSdj/65D1JM4A
	KIat3BEhDTHvJ+LqzZYemL1aF8VefxXyTmT0grFogjeFBvBK/v1A3s/7LDj2uhQMa44SLHKW5QX
	/r616DVW0veTYmpcw==
X-Received: by 2002:a17:90b:4c46:b0:35b:e56e:a17e with SMTP id 98e67ed59e1d1-367d48465f6mr845498a91.17.1778287606686;
        Fri, 08 May 2026 17:46:46 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:383f:1ef5:8ccc:13df:edc6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367d6262349sm266926a91.6.2026.05.08.17.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 17:46:45 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: johannes@sipsolutions.net
Cc: daniel.gabay@intel.com,
	miriam.rachel.korenblit@intel.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+2002864e6c6895cb0ac3@syzkaller.appspotmail.com
Subject: [PATCH] wifi: mac80211_hwsim: reject NAN on multi-radio wiphys
Date: Sat,  9 May 2026 06:16:28 +0530
Message-ID: <20260509004628.79446-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: ED7AA4FD1A7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,vger.kernel.org,gmail.com,syzkaller.appspotmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36124-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kartikey406@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,2002864e6c6895cb0ac3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,appspotmail.com:email,syzkaller.appspot.com:url]
X-Rspamd-Action: no action

When userspace creates a new hwsim radio with both
HWSIM_ATTR_MULTI_RADIO and HWSIM_ATTR_SUPPORT_NAN_DEVICE,
hwsim_new_radio_nl() sets BIT(NL80211_IFTYPE_NAN_DATA) in
wiphy->interface_modes while configuring the wiphy with
n_radio > 1. This violates the invariant checked in
wiphy_register():

    (interface_modes & BIT(NL80211_IFTYPE_NAN_DATA)) &&
    (!nan_capa.phy.ht.ht_supported || n_radio > 1)

triggering a WARN reachable from userspace via genetlink.
With panic_on_warn this becomes a denial of service.

Refuse the combination at parse time with -EINVAL and an
extack message, matching the cfg80211 constraint that NAN
is not supported on multi-radio wiphys.

Reported-by: syzbot+2002864e6c6895cb0ac3@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=2002864e6c6895cb0ac3
Fixes: 2c7c70ee7cee ("wifi: mac80211_hwsim: enable NAN_DATA interface simulation support")
Tested-by: syzbot+2002864e6c6895cb0ac3@syzkaller.appspotmail.com
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim_main.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_main.c b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
index dc9775cd9f54..a625a9e3caa7 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_main.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
@@ -6766,9 +6766,15 @@ static int hwsim_new_radio_nl(struct sk_buff *msg, struct genl_info *info)
 		param.p2p_device = true;
 	}
 
-	if (param.nan_device)
+	if (param.nan_device) {
+		if (param.multi_radio) {
+			NL_SET_ERR_MSG(info->extack,
+				       "NAN is not supported on multi-radio wiphys");
+			return -EINVAL;
+		}
 		param.iftypes |= BIT(NL80211_IFTYPE_NAN) |
 				 BIT(NL80211_IFTYPE_NAN_DATA);
+	}
 
 	if (info->attrs[HWSIM_ATTR_CIPHER_SUPPORT]) {
 		u32 len = nla_len(info->attrs[HWSIM_ATTR_CIPHER_SUPPORT]);
-- 
2.43.0


