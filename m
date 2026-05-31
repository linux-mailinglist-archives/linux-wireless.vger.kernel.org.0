Return-Path: <linux-wireless+bounces-37180-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id tmAPEC+MG2o3EAkAu9opvQ
	(envelope-from <linux-wireless+bounces-37180-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 03:17:35 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CCF6141F7
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 03:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EB17230157DE
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 01:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BF3314D1D;
	Sun, 31 May 2026 01:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zm1aXvH7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178A3314B6E
	for <linux-wireless@vger.kernel.org>; Sun, 31 May 2026 01:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780190252; cv=none; b=dzl4cOwNDnXXHJRpPLS43vwk8klOLzNYDDm8YV5UPhCGCMveK1bA03FoGDKkcKJpk3UCA74F2H3jva2UJ4K58dmcb7DgwFdEma4WbfkAOmYOBpR3k26mS6Dol5pl7H8k/TO9lZ1tUXKciwrIS0Dt7b5l53tQKyQb48jql+1Yxfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780190252; c=relaxed/simple;
	bh=TzMtIekqFZQ4pyJ+QebnViVyPHre4Kj3xcBVFdEEkMU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fIY0yniPzWcY2A71BF5f5IAdFANQexXq7mBWYGg3uvvAvGolF7ppcOHyclCC2RV1ftCHDU+DCRuzHMnbT/8WE1q3eahdqoqQxVxRq41AnnXczpTVwpLSv+4FnVjmCyEDsjruEy2V2kbLC4vM07H0Rno8D6lvNkMsBRL4Ex//2Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zm1aXvH7; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8423f236418so58663b3a.1
        for <linux-wireless@vger.kernel.org>; Sat, 30 May 2026 18:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780190250; x=1780795050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2Go5vFC5tNtfqreeIQjYzU5aFsIfZiZVmcXpPFzjREA=;
        b=Zm1aXvH7btlMvXHTwUh6yce3mH1R+dyAGH6CJiBr3Xd5ET/VkWa79y9QR6WYAfxQBB
         cbbpY65PmGsbCzbdhQWZhwlcVicKLoJ2x7ZgPPHSLJvS6gFCdiFNnTmTC23Qz0xiHOvu
         ByXp+DJIGwqsyBWPz9LuocUBJW6ebkcQESNfGiL51iih6WWMt5BYatBx15E+GV9A56kE
         siH8OGt1hGKZyM4S2tw1mxCXaniUBwBIkcTXtplB+zzZ5xsF5zCsP/6cmM9169KlJP86
         YCclLrxJT2/zMzhwmC+zSM3u/Yl/OPowmE7xKfpGjqetTXgVgpH0AlYOp4k0YPyOyxxT
         eEpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780190250; x=1780795050;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Go5vFC5tNtfqreeIQjYzU5aFsIfZiZVmcXpPFzjREA=;
        b=cxFNrCCG1vLWV5BLMcXYjoqeSjDFfrdxuwiH4rs5VjBkFlBk0aNXQuI3xOZEUbAv70
         FJ1eIW/xNj5OdEkF6G8MWx3Ezex+TVuBaXIaW5UUJoQQwAdDRPTO4jG1JeEZmyc5ilNP
         5e2TIHZoPmrpxM/kl5OkHv9fRjHvQUUM9+IFNIGM6F9PmhG6GsmDbjR63laY2YucIE4P
         +UwEhgcVpLGoh6ufu0y4S+4kFMWyuypcVgrX7WjI18qcFdDmEiHarcVBm45Wg+91nVf4
         xGWt1ebz8gshS82TR91DXQm3X7mqhK2p/YrGljmr3dKOD771UT2uaD6Ma2j1RIZfP7IJ
         59qg==
X-Forwarded-Encrypted: i=1; AFNElJ+bnMQFA4QHyYopDkLpM9IPHO3p1mg1rJiKJOdbh5twfKsUoK2zsAOw5b1Tu8CvDJ8iet9+12dIzDKKgpD7Xg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy10wf3PUZpPTF+GZoZZR/8HOXR97lEH05fuA2f6HPeJE9FISCl
	Ac8B1k+3MLtOeUdIKg7Dycat71Vc5MBXFmoNIlcLc2iV5UzYV756MjVk
X-Gm-Gg: Acq92OFpTFFAKiWrPBRG7ztmLfAXApcbmGAZRNMVNaOZreKiI7NN07EdnMSJbXGkKhS
	jGo7xnBlWiThag+YtB5Dx7l3KOzGYMlJer2ozEwhQIrVhhTVSiAGq22fLrXmS5Ufnbs5PFT2Ud/
	3iy2qbKuoVF60Fg8kzKGWDuC8ROfIJweQO5wfdc4/Jd+xYjtsPRmvWf/aK77WzH/nNcuweW2SYi
	M9SDuje8ok7BQjYP/JydpIjwqxK544G5PC1mnzBk9dPR6GUUHdd2BjxshtlNJdO/wFdADh+WLfI
	wi6Y9XRWppFQLlmAOwwJM1aKHUXUI4iqSMZW6D49GkwyKILWEk+lnj+exkJUs4hNllaSyksLVWh
	6x0pMq/QWbk6i0Bb62w/1ppmUlAQLFSyLxhVMPcAIPmf+AuxnB9+8vpwyqegneOkUBgF5bHgon4
	q6LbjS9x483jdAi/MgNUnaoAh7N51eUHTFvm1xyqpAi2FeZJKUoK8a2yah7gktL9LZgatu7hcbg
	aePOK7s921Taca9
X-Received: by 2002:aa7:9a86:0:b0:824:afe1:f7e3 with SMTP id d2e1a72fcca58-84225376606mr5343989b3a.15.1780190250357;
        Sat, 30 May 2026 18:17:30 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:383f:5ff:3b84:efa9:8e7b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84214b31933sm5891818b3a.23.2026.05.30.18.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 18:17:29 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: johannes@sipsolutions.net
Cc: gregory.greenman@intel.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+8e0622f6d9446420271f@syzkaller.appspotmail.com
Subject: [PATCH] wifi: mac80211: limit injected antenna index in ieee80211_parse_tx_radiotap
Date: Sun, 31 May 2026 06:47:21 +0530
Message-ID: <20260531011721.102941-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,vger.kernel.org,gmail.com,syzkaller.appspotmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-37180-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kartikey406@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless,8e0622f6d9446420271f];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A4CCF6141F7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When parsing the radiotap header of an injected frame,
ieee80211_parse_tx_radiotap() uses the IEEE80211_RADIOTAP_ANTENNA value
directly as a shift count:

	info->control.antennas |= BIT(*iterator.this_arg);

*iterator.this_arg is an 8-bit value taken straight from the frame
supplied by userspace, so BIT() can be asked to shift by up to 255. That
is undefined behaviour on the unsigned long and is reported by UBSAN:

  UBSAN: shift-out-of-bounds in net/mac80211/tx.c:2174:30
  shift exponent 235 is too large for 64-bit type 'unsigned long'
  Call Trace:
   ieee80211_parse_tx_radiotap+0xadb/0x1950 net/mac80211/tx.c:2174
   ieee80211_monitor_start_xmit+0xb1f/0x1250 net/mac80211/tx.c:2451
   ...
   packet_sendmsg+0x3eb6/0x50f0 net/packet/af_packet.c:3109

info->control.antennas is a 2-bit bitmap (u8 antennas:2), so only antenna
indices 0 and 1 can ever be represented. Ignore any larger value instead
of shifting out of bounds.

Reported-by: syzbot+8e0622f6d9446420271f@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=8e0622f6d9446420271f
Fixes: ef246a1480cc ("wifi: mac80211: support antenna control in injection")
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 net/mac80211/tx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index b487d2330f25..ea7f63e1fc17 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -2181,7 +2181,9 @@ bool ieee80211_parse_tx_radiotap(struct sk_buff *skb,
 
 		case IEEE80211_RADIOTAP_ANTENNA:
 			/* this can appear multiple times, keep a bitmap */
-			info->control.antennas |= BIT(*iterator.this_arg);
+			/* control.antennas is only a 2-bit bitmap */
+			if (*iterator.this_arg < 2)
+				info->control.antennas |= BIT(*iterator.this_arg);
 			break;
 
 		case IEEE80211_RADIOTAP_DATA_RETRIES:
-- 
2.43.0


