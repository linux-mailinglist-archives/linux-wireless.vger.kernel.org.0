Return-Path: <linux-wireless+bounces-32414-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEXeNDIRp2k0cwAAu9opvQ
	(envelope-from <linux-wireless+bounces-32414-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 17:49:54 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF641F41E2
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 17:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4771A30B3D2D
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Mar 2026 16:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781B73264CB;
	Tue,  3 Mar 2026 16:44:28 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394CC370D6C
	for <linux-wireless@vger.kernel.org>; Tue,  3 Mar 2026 16:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772556268; cv=none; b=DB+8cJPEWYRLqSaKk9YtpsVQbuACEM7sHM7hOm1wrJd260aioJCebyIFWdgUDgURAtMHJT1+IZUlZZmSzGMhRA3ZhBIVE5lr/ONlQ929HDLb8b0BNVtFtSKigiMcbhgxvd2Ti4gDNdC0hhIXbo6sXpizdq+nm9OY6UAcd4iO+kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772556268; c=relaxed/simple;
	bh=zicAUpEW8baw4ChtUGe9CI+tPJqmVpO6djDZ1HH8leY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=suSIFKpqHmSsOgbrXUyxdz0ZxeHVMZVhYa7yQpRmZeMf0MlILq6BPFJMSnEGXISsPrbenmvfD7HY0cpNfHZOxi4t4ZjLdtXE+c4Tsy4sR+x/jmf5cOtFMIWCH61/nZZBSCllNj22mhzWdp0frdRV2hLmEbVbBuP20ZdOw3LuSZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=green-communications.fr; spf=pass smtp.mailfrom=green-communications.fr; arc=none smtp.client-ip=212.227.17.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=green-communications.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=green-communications.fr
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue108
 [213.165.67.119]) with ESMTPSA (Nemesis) id 1N0o7f-1vj76s2A7B-00zmjb; Tue, 03
 Mar 2026 17:19:39 +0100
From: Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH wireless v2] wifi: mac80211: use jiffies_delta_to_msecs() for sta_info inactive times
Date: Tue,  3 Mar 2026 17:06:39 +0100
Message-ID: <20260303161701.31808-1-nicolas.cavallari@green-communications.fr>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:5tWoa7ThpOKN8sHK63Mct8oNXwach6y51yyxP8INNG5kxLt+dHJ
 Nz6WMMtu/3M/StMDRAhbHh+eYWIugN7HDJpJR4LO8dqCo1FiSuerOwgOhK7gSlZSVIdWJJZ
 LunorFXf/fAYXnMisWlTuRcVYjMVtKj4Ks809n8Wf1KaUiA614u6LPx2KmmPFj7bJAvqyqC
 hPO07enmXM18iwAG5uKQQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/6Wx3ketHWU=;8RIbB4kImqy1fAeM2fD4hEmkyUj
 7g13YIa58VPXfkrMZz6QLgO8Zdjic7Qxy+c5gEdU/et/ecfi1892lcIPEflK8ephiNieehKwg
 jQ+gs5t6tpfvTUj8PaRWWJMdKg1mtQnJiY/dpDsc+c0uK10egTCItAkvlQkKmSjW3O/rH+Agw
 Op3VHzs2DidgCgas0hUXtBsWZxo3tD5tH0ClVzAXviPxCLjuCfOen1l77U6196a6rQydrFi7L
 EaIvlK7aXDTeQgMrsJi2wpRD/3lxBFcx/b+8/7W01+FNevYTJyqmb5IjuvhTkBS7hGCJ1BxCb
 Q7coJ8LgHB01+5gAUuMr9/AFz3sKkYFfyUb+a6sIzZ2FTVCdajPDN1Ve18HIc+TaSUEMK4glx
 6b0o1LTSh1sH0pMclZLBJ/kPTzQJbSS5o8lcmbyJ5WEqwWQMMKcyvDOvePrXlGD91ISjMGAb1
 ciV1SlZyycJ+RbhpIXq4go8sRWxJvJOc+Xu31pOhOa6aqKiQCJD9Hc0YecCcxX1/UmK48S7K8
 L4PuyOsKZLNb2GF2JUrWzODGCiZqy7jI0G3QqTeuzMWz4sclWxlcvhGZnmGChlt7+9ldskCa2
 TXK59eYIrfPeTIIOcsPP5GZ0PdDIOEJsdm7LKpyc5qv1ICyytdb1jmjcezlDwCT2JMQrwvNeU
 MrFFqTNlxcJjj+65xR0VFJZBP8mRBSw8jgEjtqfrBe/S458RuRy+RZZNkbF7xk/VdjjuAjn+e
 59jSTPVD0BefXLzx1hK48rokJOnCJM1y+iQmUbA8qWALCg4A+C1P2ACYxzQzfuNaM8gVgVfN3
 36WcengaMl/ucXK9rIm+b23TeoWXFe/9KGxLIqDmqyObQd2e/gPMRs12OeS8rTnillf2NAuX3
 BPkL9Rpi/1Dyk8l+YPNlhDgsxGMCFZKNfNgMbYkXg4SeUVNrtCU4ZwKCctF8J/nCs1QwZbbKO
 6CtyduzcjjlvNhU9Ddy9hhNqJZBfta4bD/AkZ5h6p5kfSkUD0egyQsoSR4TJ9RHVcrx5SHDnY
 2KVtUtB552DfFg+p1DkIBcMoG/yuPbXg8UnFBm/1z3DnT38ldsmeOZMo/ETIVbeKYjns0Yk9w
 dpNRHNLfBqrDoBeiIWUSTHn6t/RPAziP+T8OtKfS5XYUqzuzAjF81/Cb5GR+HWIOD6Va5lNhH
 rVxF9nVI+RQKZrYn5XCFW0zNW0F2ewhIHYZ2BfX0gB3Xj2qe6jjViTzWGTlCU4Ag0nYIu4DHQ
 jEz+Wg3rhDtJOak41jbvzkfQPJf6bNyms3zkgiSQjh9txWszhTyPhbO7cyUCuvbhdFL/T3e6i
 ZvZ3yopZUooj4HxI+6LpHSCHYVHAp4Vls8xkYLc7VwImjEqZKf4R6qCG8puG5y/CONvvFMskU
 eViOWis/L01DH588ZytAmYnSnfmyhw2wpDJL7G6xdovjnFOVLTrU8qv02LSfRIMik4wRbCnBR
 UUExEgGFi8FOByCPYnMT9ormcbaNqy/KgJmQNcC4RZkIzj5QRO4lWogZgduADu5Vxs6mGG8Ch
 z9GKvJ1Azmt5WXJsg9d0okCJxqhvictR07dqQAgKwr7st3wE4f7ftn3W0BPap6+2H969j09Dy
 Y+6kqPiTknNw9YQFOhf8Cj36JXP8LMhySEojdAbKiUVfWWgH+3YFMD+TyUGA5hf2Utuho+m1F
 NWchh8+/9gZQDgc5OABHsOmWSts10zCyQKJdE2clb6zMZHwf1U8E3MFNvXZwqjuJ0=
X-Rspamd-Queue-Id: 2EF641F41E2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[green-communications.fr];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32414-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[nicolas.cavallari@green-communications.fr,linux-wireless@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.966];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,green-communications.fr:mid,green-communications.fr:email]
X-Rspamd-Action: no action

Inactive times of around 0xffffffff milliseconds have been observed on
an ath9k device on ARM.  This is likely due to a memory ordering race in
the jiffies_to_msecs(jiffies - last_active()) calculation causing an
overflow when the observed jiffies is below ieee80211_sta_last_active().

Use jiffies_delta_to_msecs() instead to avoid this problem.

Fixes: 7bbdd2d98797 ("mac80211: implement station stats retrieval")
Signed-off-by: Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
---
 net/mac80211/sta_info.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

v2: reformat patch, change commit message to obey unwritten rule

also, the wireless tree does not compile on ARCH=um as of d973b1039ccd

diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 6dc22f1593be..dd51a578fbc5 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -2782,7 +2782,9 @@ static void sta_set_link_sinfo(struct sta_info *sta,
 	}
 
 	link_sinfo->inactive_time =
-		jiffies_to_msecs(jiffies - ieee80211_sta_last_active(sta, link_id));
+		jiffies_delta_to_msecs(jiffies -
+				       ieee80211_sta_last_active(sta,
+								 link_id));
 
 	if (!(link_sinfo->filled & (BIT_ULL(NL80211_STA_INFO_TX_BYTES64) |
 				    BIT_ULL(NL80211_STA_INFO_TX_BYTES)))) {
@@ -3015,7 +3017,8 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 	sinfo->connected_time = ktime_get_seconds() - sta->last_connected;
 	sinfo->assoc_at = sta->assoc_at;
 	sinfo->inactive_time =
-		jiffies_to_msecs(jiffies - ieee80211_sta_last_active(sta, -1));
+		jiffies_delta_to_msecs(jiffies -
+				       ieee80211_sta_last_active(sta, -1));
 
 	if (!(sinfo->filled & (BIT_ULL(NL80211_STA_INFO_TX_BYTES64) |
 			       BIT_ULL(NL80211_STA_INFO_TX_BYTES)))) {

base-commit: d973b1039ccde6b241b438d53297edce4de45b5c
-- 
2.53.0


