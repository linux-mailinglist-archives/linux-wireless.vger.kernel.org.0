Return-Path: <linux-wireless+bounces-31629-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oH5nCwnHhmkNQwQAu9opvQ
	(envelope-from <linux-wireless+bounces-31629-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Feb 2026 06:00:57 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE1F104F99
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Feb 2026 06:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C0DA3021EB4
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Feb 2026 05:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A150425CC74;
	Sat,  7 Feb 2026 05:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZdI1V/5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709561D9663
	for <linux-wireless@vger.kernel.org>; Sat,  7 Feb 2026 05:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770440454; cv=none; b=P1SoYvuIQRbshzIj88t3pd2nHQJARQPNih4PaMT7/wUwrz3CIUVxER/QTJi03xTx+98kg32qkmo6d0/Wpoq6EABhKR6r0BJNEgkKpLix5Dav1JT8+3sLxGHtQYGpF5GYYUSXHwjkPm7XcTLgg0jrcPy+Ul95MXjrpY/8r746r6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770440454; c=relaxed/simple;
	bh=X8qEI1ff3VbLHD7+B6dwIVFUO82QIYblDYBEbjqBmlY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O2Y4W11g02o4xCmuqgEkiWf29j+Ad8YTXq0pcXJCUsrVws607/zH3Dipbu+uD9XBquMGpDT7IgWusx1ko9tW3R25/ovHrkYJoWfDVehiePjGdDn6Yclxp1c4XVJcmAZSgyBMBjl6pn9yuuRhvniOTWfTluuwz7sqK4J+zIow6F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZdI1V/5; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c613161b489so584705a12.0
        for <linux-wireless@vger.kernel.org>; Fri, 06 Feb 2026 21:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770440454; x=1771045254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nsxg3ZQLoiyLW/eFeiw5qS1ROT/9NleasWakHk+SOks=;
        b=eZdI1V/58AuaTVvYf3KdbDsa6ucxf9acCaMGW5pN9ijIg+uwFeVzlQasEclnoRPqVI
         Bzj6iAa00TfWgRd9L9FwpkydWOdP8MYz2l/DF+122WatbSbar80/vnNlY16xVRkTZMTk
         6JtS4JJJEKO2HH8FAOPFVNeYg5wTYWV2q08eMjDpxdtNF5wEivhaiDxKLlFRYbnJfQkG
         oUSBzO8/C5yNyp+rlNyUyNFl3h0cAp6dekxDVfzeEZrS2PjDxz9e7aeFkCAG6SFcWb0V
         r1Kd1daP+HpmhLSDqiWT621n24X6Uy4uBw7NBR+OnPpdWhPHYNMGt1YDq6DM+41WWKyE
         PDfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770440454; x=1771045254;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nsxg3ZQLoiyLW/eFeiw5qS1ROT/9NleasWakHk+SOks=;
        b=Ofm+eP8Tvmm95pKvJNiJRRKpCwoPvTI//TnbpXTHxtp7CDChMmNVW+jRSeJD+FRSE6
         2S/vfDpODLMfPMIjcSkUSQMfDwO6ilNSNGCdL/moDRzKr4+eIOqll5Z63H5drP+TmTyZ
         /j+CyonQKWVdbJdombotd28m29yf9iBdFSPW5pWHa2mDdBU4jknt+BhoNuC7gr0gkRg6
         sbyMxaF/3op7a16zrOEjXJgteF0OKAtICkojOGekR/j0cfBpYGBI68rhBY77HADBlEvT
         Rop9Hr0Z9dvAdPENcl8aMVxq+HmEiVHjjMPAOls6SPhv9wtZlr6149vZmUyjkR8ssrfE
         VRew==
X-Gm-Message-State: AOJu0Yx5OgduWcX53B43Frwy6z9BHdXI+2a+urZO5NNrqoX76FHhd+5o
	G8nC1j1iT6LtDXqvmXgnWt+bGJKUS9tYQc2lJmmBxYHezS6HGvYL4Lj+TQvK1IRS
X-Gm-Gg: AZuq6aJk9t2rINRgbLhj1CsCxWNyn9QR4nSm1mDhqxypG8h0e5cNoqRPuvM+aFmKBub
	tfOqqnZt35tLixNfXlIj9gyXQRhrl7AxaSUBhPtxHcyCaiL5eiL9GVDRUjZfshPCBno4qg9kc3s
	t5NDmpOlgDbaPVoflRi11UvJJiSI8PalEYQYFPAVo3RSpydsPSw45Bmw5dSeuHkkopLXdmhZa4R
	w9QHYbP8+Nni7k7i4pRmGTxTEjlb9CXnTeWQ3R/z3PWqnDVHdml0K7iWveyiVQiSKdacmDbLL5o
	VZ43PsgmqSSiqVuPaYivuOBZGb1eEjpnFqACaURE5QS1Ld+GkDp8WxXRBP12/R98qiWusvFQTut
	PCEeHR5DXFD3Kb4kspb6FqQ5i208NoLlUUDgmOghXftdRp36ECSNywDxWKkGEWVoNemfdlXw4je
	TEe7pdF08CmaM=
X-Received: by 2002:a17:90a:dfc7:b0:32e:1b1c:f8b8 with SMTP id 98e67ed59e1d1-354b3e456fbmr4220547a91.26.1770440453478;
        Fri, 06 Feb 2026 21:00:53 -0800 (PST)
Received: from mint.. ([2401:4900:5635:97a4:2a92:ca6f:9799:d0b8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3549c5955a7sm7354095a91.17.2026.02.06.21.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 21:00:52 -0800 (PST)
From: Dhyan K Prajapati <dhyan19022009@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dhyan K Prajapati <dhyaan19022009@gmail.com>,
	Dhyan K Prajapati <dhyan19022009@gmail.com>
Subject: [PATCH] wifi: mac80211: skip BSS_CHANGED_TXPOWER notification for monitor mode
Date: Sat,  7 Feb 2026 10:30:35 +0530
Message-ID: <20260207050035.6720-1-dhyan19022009@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-31629-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhyan19022009@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8BE1F104F99
X-Rspamd-Action: no action

From: Dhyan K Prajapati <dhyaan19022009@gmail.com>

Monitor mode interfaces don't maintain BSS context. The BSS_CHANGED_TXPOWER notification
indicates transmit power constrains recieved from an associated access point which isn't really
applicable to monitor mode as it does not associate with any BSS

after a commit back in july 2025,("wifi: mac80211: fix WARN_ON for monitor mode
on some devices") monitor interfaces with WANT_MONITOR_VIF began recieving link
change notifications during ieee_add_virtual_monitor(), when ieee_link_use_channel()
assigns a channel context it triggers ieee_recalc_power() which sends BSS_CHANGED_TXPOWER
notifications to driver, driver using legacy bss_info_changed callbeack recieve
link->conf as the bss_conf parameter for monitor mode that points to vif.bss_conf which is not fully initialised
in monitor interfaces, so drivers like iwldvm dereference null and crash
since BSS_CHANGED_TXPOWER notifications are meaningless for monitor mode, we can skip
the notification entirely,monitor mode transmit power remains configurable via
nl80211
Hardware: Dell Latitude E6430
Device: Intel Centrino Advanced-N 6205 [Taylor Peak]

Crash trace:
  BUG: kernel NULL pointer dereference at 0000000000000000
  RIP: iwlagn_bss_info_changed+0x19d/0x640 [iwldvm]
  Call Trace:
   drv_link_info_changed+0x2b5/0x2c0
   ieee80211_link_info_change_notify+0x13d/0x160
   __ieee80211_recalc_txpower+0x44/0xd0
   ieee80211_recalc_txpower+0x5c/0x60
   ieee80211_assign_link_chanctx+0x182/0x410
   ieee80211_link_use_channel+0x413/0x450
   ieee80211_add_virtual_monitor+0x17c/0x2b0

Tested-by: Dhyan K Prajapati <dhyan19022009@gmail.com>
Signed-off-by: Dhyan K Prajapati <dhyan19022009@gmail.com>
---
 net/mac80211/iface.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 515384ca2..2d5b4cc60 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -76,10 +76,16 @@ bool __ieee80211_recalc_txpower(struct ieee80211_link_data *link)
 void ieee80211_recalc_txpower(struct ieee80211_link_data *link,
 			      bool update_bss)
 {
+	struct ieee80211_sub_if_data *sdata = link->sdata;
+
 	if (__ieee80211_recalc_txpower(link) ||
-	    (update_bss && ieee80211_sdata_running(link->sdata)))
+	    (update_bss && ieee80211_sdata_running(link->sdata))) {
+		if (sdata->vif.type == NL80211_IFTYPE_MONITOR)
+			return;
+
 		ieee80211_link_info_change_notify(link->sdata, link,
 						  BSS_CHANGED_TXPOWER);
+	}
 }
 
 static u32 __ieee80211_idle_off(struct ieee80211_local *local)
-- 
2.43.0


