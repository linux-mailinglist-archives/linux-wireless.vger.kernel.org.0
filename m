Return-Path: <linux-wireless+bounces-37087-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 3+Q7AcURGWpKqAgAu9opvQ
	(envelope-from <linux-wireless+bounces-37087-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 06:10:45 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C64715FCEA9
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 06:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC1173015E23
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 04:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6CA370D77;
	Fri, 29 May 2026 04:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="EKx2YRiH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244B7370AFE;
	Fri, 29 May 2026 04:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780027828; cv=none; b=qaI19YHqQoKXQc7nFouJlYRlrYbo4HLB+VRg3lgE1jepVLz8JD+YMND/nVZBzt03xEC5I6BoNuHVou63efL85Nf0nhYbF/HEf2L+SXyNQy3zZHNGA2KLUe6kAaW1sSeTUBTOrxQmdyTD5Zit9XyqaAL2Zj+FUcjKSfYNhj3OhLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780027828; c=relaxed/simple;
	bh=xQRrgxbFECh+xCJ1c/S146mZT+SmdEygtLmBspAcoX8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RrSotUtVR0e20CTSMEvTHwDpzhwGEYzwa20Hw/1Xx9XD8nJqTOtyNxHuyvJOFLm4kZ1Wcch3B8EnWgIqQIMMGjHJP6x1yB2wLeuId4yT8oc3WNGvJ6Zl38sRhq6GC+N2E7DtWJ/+bf4aXaDOqoyP+eQKYSDT6trFrgAoY5LfjXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=EKx2YRiH; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1780027799;
	bh=fOdxBJ/vsVFRBPuf6cKhChQgV4pfjqwQ43njmWshWKA=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=EKx2YRiHZ044vARLoYGuAYOEJt1ldhFSnxYnC+M4SVPboSHpP4Kn33KiQKIX4OjSA
	 rD6Z7j1yuPASXbwZdoqZImj2hCmS8Wt3A0R7doCQe+XXEqZwvTZrJWrT9FCdCpCDvG
	 /tazB4ssIQSbF7PxPfOaMHdJ8KjdhB1rX3JpgOgY=
X-QQ-mid: zesmtpsz8t1780027772t8bdf7c2e
X-QQ-Originating-IP: l0F0vEj/ROf7WiC6UVosjlCTC/EGHFgKAWz+St+ptaA=
Received: from localhost.localdomain ( [124.126.19.250])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 29 May 2026 12:09:29 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 11107544085504726839
EX-QQ-RecipientCnt: 6
From: meihaipeng <meihaipeng@uniontech.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Andrei Otcheretianski <andrei.otcheretianski@intel.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	meihaipeng <meihaipeng@uniontech.com>,
	syzbot+c0472dd80bb8f668625f@syzkaller.appspotmail.com
Subject: [PATCH] wifi: mac80211_hwsim: handle 5/10 MHz chanctx in rc update
Date: Fri, 29 May 2026 12:09:23 +0800
Message-Id: <20260529040923.9816-1-meihaipeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5b-2
X-QQ-XMAILINFO: Of5inzNvXaPsJ9zOszJed1Cjbw1qoObhgHaJZ9wPRzqNLxwgUCkSM2D7
	HS2T2oaE4Cs90GVls0Egpl86rZ98cVRXQ3vw3WwOq6WFkP1/+ewxtXb3EFQF76p9zrZvBu3
	mSyzGopXzgH0s5Pc93d7lMH0lm0RiZGzMrp/XQfoObAO6qFrV+4kBGdKva16NqEnSBE6vd7
	2XCxbiwii5X5vtR+xpzmUBHH+FkY2wuzCgbtGCuQ1IceYBfZJibxK9ff7R73r58QeHq3eC+
	He+cnEwRpkfk4LQXtWR1OFWMXeqGy4hh7kw/E3rVG0cn77xjr5LRbbZ/5NiOGB5uvpAWtVW
	QwxqapkrVLlHKznLoY8Tg19WHOUuwweGP0m0+nqTtBSnlTQnIwawzvRiDPotyT+h8wn+NHd
	ePASHMgvD6zpQPLwDhPW1aQ3AhvVPW7fP1IJj2N+0cLKAV5R6v1byF+6BgXr2AQHokDiVxi
	kHQru9TKWWsiVGkL4SIF/nS1DnPcKOKCfzMFwM8mDMLz/RzTmSCGSZ7iDVIYmqPbWvCsqCM
	YLA3+WdTGro4kirS4ospLSA5qWh9aA+LdMeptyCOZiDpEoaVYKperjzFk7jucOgWmJvj/bQ
	bCGnnqrO4gszI/AFZyr0MqnX2ypf9eyFsipzcl4H9uNjkGs+sIhPgaQHWEBNy29Uub3FV7V
	bW+EMd1eFWQcsB2EMU7ialel5/szsPFMDiicA/o7DFPqfqCmkHXjG9SnIOVkAj7oweuH2Py
	DzNXNO8kx7tZaD7/HqL68faNBAzT+VmLn3o8RQ85fN0OClDwL3F0LGctDl/YhYrgIH3SiR7
	MIr+r+WxhNpiyLdD/w/laPw+DaaU8FGKon7CcoLF+AJ3UsWcyeNqSOJ2trgfRzM+ryqpdAf
	ATrUHgy8nSQftpyKdcO8/4NdWhv/IPzZ+aRI0Z6oFiKac08tpA84tL3u3n2Vxp5yFHCuzJa
	9TzPZJoHxKXz1XmC1VhLh0LC4ar9UPM0RSHtkSDrVHS6Jv854SOJd6YSmqWccDmj4Ynw887
	NmF2ARBzZPlEhaankaNeZX2A/21HarwtYqEb6hGIWcBQqzIUaBtaHpRB0uZLo2iIPEeh+dX
	g==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-37087-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[meihaipeng@uniontech.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[uniontech.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,c0472dd80bb8f668625f];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,syzkaller.appspot.com:url,uniontech.com:email,uniontech.com:mid,uniontech.com:dkim]
X-Rspamd-Queue-Id: C64715FCEA9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

mac80211_hwsim_sta_rc_update() compares ieee80211_sta_rx_bandwidth against 
the current channel context width. 

The STA bandwidth enum has no sub-20 MHz states, so a normal 20 MHz link 
STA falsely trips the warning on 5/10 MHz OCB channel contexts.so 
a normal 20 MHz link STA falsely trips the warning on 5/10 MHz OCB 
channel contexts.

Treat sub-20 MHz channel contexts as 20 MHz for this validation and use 
the actual channel-context width in the warning message.

Fixes: aea9a6088ae46 ("wifi: mac80211_hwsim: do rc update per link")
Reported-by: syzbot+c0472dd80bb8f668625f@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c0472dd80bb8f668625f
Signed-off-by: meihaipeng <meihaipeng@uniontech.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 1fcf5d0d2e13..3d759fb328a8 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -2793,6 +2793,7 @@ mac80211_hwsim_sta_rc_update(struct ieee80211_hw *hw,
 	for (link_id = 0;
 	     link_id < ARRAY_SIZE(vif->link_conf);
 	     link_id++) {
+		u32 confbw_mhz = 20;
 		enum nl80211_chan_width confbw = NL80211_CHAN_WIDTH_20_NOHT;
 		struct ieee80211_bss_conf *vif_conf;
 
@@ -2826,10 +2827,17 @@ mac80211_hwsim_sta_rc_update(struct ieee80211_hw *hw,
 				confbw = chanctx_conf->def.width;
 		}
 
-		WARN(bw > hwsim_get_chanwidth(confbw),
+		/*
+		 * ieee80211_sta_rx_bandwidth does not represent sub-20 MHz
+		 * channels, so treat 5/10 MHz channel contexts as 20 MHz when
+		 * validating the link bandwidth.
+		 */
+		confbw_mhz = max_t(u32, confbw_mhz, hwsim_get_chanwidth(confbw));
+
+		WARN(bw > confbw_mhz,
 		     "intf %pM [link=%d]: bad STA %pM bandwidth %d MHz (%d) > channel config %d MHz (%d)\n",
 		     vif->addr, link_id, sta->addr, bw, sta->deflink.bandwidth,
-		     hwsim_get_chanwidth(data->bw), data->bw);
+		     hwsim_get_chanwidth(confbw), confbw);
 
 
 	}
-- 
2.20.1


