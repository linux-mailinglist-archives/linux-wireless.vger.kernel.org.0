Return-Path: <linux-wireless+bounces-36183-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBU4Ons9AWqcSQEAu9opvQ
	(envelope-from <linux-wireless+bounces-36183-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 04:22:51 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE7F5072A4
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 04:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 36BFD300796B
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 02:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64EC263F5E;
	Mon, 11 May 2026 02:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b="Sxl8OIpK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F70175A6B
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 02:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778466167; cv=none; b=KJr05ZbXoO37/MogtVm2QkPa5lrOV6zknYMiO8aNxfLABnA13DZVphr9bh9qUvRDeATH2/GihadPYzOxiqeq7q7lAGy2XSPgTyG1ySWn1JaC7aEZVPK+tcVDU13LojSRI67FjmgKzIqVX3R2QK26H0OWZr1Hf/uVqeWGwUtEVeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778466167; c=relaxed/simple;
	bh=P5b8yxYPfyAANI5U5tIfYy8OHoL+A6T8uuLLf+MS2IY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fIz6haE8CqsBP/IHtv3eR87aAFK+3p4x8gTfr/SCoEadIyQLSoyquYFt4SbLh3PAKheYK8PEm11+a+vDGlx7VyQoTJCnTo6fJlAqs9J6Dgf8JZD0BN6ZbthA1fZ8trAtZ4DRWrTC3ksiJcEOF6TBxVwy09mAkFJMGHKPS0nfkK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b=Sxl8OIpK; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-367d88b9940so772372a91.1
        for <linux-wireless@vger.kernel.org>; Sun, 10 May 2026 19:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20251104.gappssmtp.com; s=20251104; t=1778466166; x=1779070966; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vWtWKj/H/hggR9+BAUGtE7bs1FF6c85mqJVTgnUQx8o=;
        b=Sxl8OIpKExWsFmsxjVC0PITka4z6TfVDJgNdVFoMlRhkh8e5f69VM9QH3Gt1bSVSl0
         K3kxwpjS3weqK7L4txk3VC1gaYmKOzig5seoWUUCxhFOh7zy+GldyPIFeV9B2N209mx6
         x352w89wVdK9JCFIUqkCaYH58Ulv7ySosjuxme0Zf6vXBGsfRIet7xHyYEVK8sbhMlJq
         cDHBzHvYbS77tMJSIft3MGl23LkU4GhSR5IIEtKtNMiddJ2vwpnEeIM+GbQCPQVAxbL9
         gJTwCBMeoLUKqJpWFpZkbDnqLqSaSmTlvU8Fp4HZh8H0/BsN+dlE7qfv9UuRmpPIK4B5
         MSPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778466166; x=1779070966;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vWtWKj/H/hggR9+BAUGtE7bs1FF6c85mqJVTgnUQx8o=;
        b=He/gbFtaCb65qTZbwpIotj8NO2ILeWpfxeTX7mnccTRTAIgsV8LvtzKTOLYe19WEar
         95Xs318eFw/GUCSU9atbTrmNDOcU1dySr21sjbW2WNFtVwFG3BshAkrV3UHkp8lm+fGU
         e5HFUlC8zdRDNB7o/6Q90hieBqivapNIktC2pYDaMFe98HT9ZCSDB0w9xP5MoVoQCEOl
         YnXV4l92blIpRo5YsHsmgiURji2rnudcMiqhGzL21GVEx6BNty6IXUc5CsGrcVaZmscv
         W+Cfvuku++JkW6o6e1np+cDrLWg6RviFfEtSnyevxvFFcdtc5BHGgHfiXunwhvSYM8Va
         nJeg==
X-Forwarded-Encrypted: i=1; AFNElJ8YAqusq6j6uzLsnvPN7JEeTAVyjLLmDiIZYNyb/WimvVsWTMp4ZsL02tHZ8z/uPDV0lOTtFCeTXIgbtfKMBw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwcQo6M3xDyCan7YVFInPsmGmGcmQgT8K9d+tkBFYtBoqvVbwTy
	kS0dIyAF9z/yt65mHH5BGphj7/0mFpgC6qLnSf+JX3tlq2Yol8SEBmklU4LqXMpMWd0=
X-Gm-Gg: Acq92OF5JESAKzILQoMOSFq6HoLqMAvuGtF9gQRaQISq1ezafrkUGNYmEQ9uN0SAPjz
	VQZGxq7orzmvCihLQnx/0lm/Hf/rW+DUZRoAhPsh0EbwCl019wNIMl7nY9EF3HsvQWXldsYMazn
	UeG8IXH8vd4+SXs0WsnuaVZREQOwA5rGaj1NyRDzPExCWKk7vpbWtojNHl8xzswaxSrYzOMqwNr
	HXiJFsgMFcVTO71IoIJfDtIIavZ49cgQPh04bqGLa0jYFLDMc9pQpXIk0jTAxkp98DpxYr6xDoF
	vpUkZORAjCJpCRtIMHvPaiHUeC06Cr6qb0B+9b8IeIVZmdZk6zhrHftg+XGSOSpcpvn5b4IwAyD
	x7d1JPZOIXkgC8NskqMun9FnnzNhrRxNPgVm8EQAx52cr3CgStPRsovi/BqvXqorInYrzE9c03I
	m4HdsNjmvWezZdZdHQiEnlBLhOMm1dlM3AXQ3/9tok88oTGrQ8u/yk0hH5q/RCDBOVZ7VlUmI7p
	t73Bpq93PoGtLHGWkKa3BA=
X-Received: by 2002:a17:902:e547:b0:2b2:b117:1d5d with SMTP id d9443c01a7336-2baf0e4fedcmr127957845ad.33.1778466165669;
        Sun, 10 May 2026 19:22:45 -0700 (PDT)
Received: from localhost (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e3715csm87472735ad.45.2026.05.10.19.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 19:22:45 -0700 (PDT)
Date: Mon, 11 May 2026 12:22:42 +1000
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: syzbot <syzbot+e2a0da81361722f4df3b@syzkaller.appspotmail.com>
Cc: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [wireless?] WARNING in ieee80211_sta_current_bw
Message-ID: <64ddfb37q7ll3uyxbf3vuaicurz2p2lwqf5shnoepk53bucsll@o6uvujysizof>
References: <6a00ff4e.170a0220.1c0296.021e.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a00ff4e.170a0220.1c0296.021e.GAE@google.com>
X-Rspamd-Queue-Id: 5FE7F5072A4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36183-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,morsemicro-com.20251104.gappssmtp.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[morsemicro-com.20251104.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless,e2a0da81361722f4df3b];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Action: no action

> WARNING: ./include/net/mac80211.h:8114 at ieee80211_chan_width_to_rx_bw include/net/mac80211.h:8114 [inline], CPU#1: syz.4.4769/22510
> WARNING: ./include/net/mac80211.h:8114 at ieee80211_sta_current_bw_tx_to_sta net/mac80211/sta_info.c:3719 [inline], CPU#1: syz.4.4769/22510
> WARNING: ./include/net/mac80211.h:8114 at ieee80211_sta_current_bw+0x36d/0x510 net/mac80211/sta_info.c:3745, CPU#1: syz.4.4769/22510
> Modules linked in:
> CPU: 1 UID: 0 PID: 22510 Comm: syz.4.4769 Not tainted syzkaller #0 PREEMPT(full) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
> RIP: 0010:ieee80211_chan_width_to_rx_bw include/net/mac80211.h:8114 [inline]
> RIP: 0010:ieee80211_sta_current_bw_tx_to_sta net/mac80211/sta_info.c:3719 [inline]
> RIP: 0010:ieee80211_sta_current_bw+0x36d/0x510 net/mac80211/sta_info.c:3745
> Code: 00 00 00 eb 49 41 83 fe 05 74 30 41 83 fe 0d 75 13 e8 47 8f af f6 b8 04 00 00 00 eb 31 e8 3b 8f af f6 eb 28 e8 34 8f af f6 90 <0f> 0b 90 eb 1d e8 29 8f af f6 b8 02 00 00 00 eb 13 e8 1d 8f af f6
> RSP: 0018:ffffc90006f4eed8 EFLAGS: 00010283
> RAX: ffffffff8b161cfc RBX: 1ffff1100d1da030 RCX: 0000000000080000
> RDX: ffffc9000e5d2000 RSI: 0000000000000e31 RDI: 0000000000000e32
> RBP: 0000000000000004 R08: ffff888054ad5c40 R09: 0000000000000007
> R10: 000000000000000d R11: 0000000000000002 R12: ffff888068ed0180
> R13: dffffc0000000000 R14: 0000000000000007 R15: 0000000000000000
> FS:  00007fe58f5f66c0(0000) GS:ffff888125389000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000110c2c8823 CR3: 0000000038486000 CR4: 00000000003526f0

This looks to be 10MHz given R14 = 7 which seems to be the operand
being compared I think. The 2 patches I sent the other week should
fix this occuring for any S1G bandwidths, not sure about 5 and 10MHz.

Atleast for this situation, it would be the same - we don't wanna
recalc the mindef for 5 and 10MHz since the mindef isn't recalculated
for 5/10MHz like S1G. But then I'm not sure the S1G workaround for
ieee80211_sta_init_nss_bw_capa since maybe nss might be greater than
1 for 5/10MHz?

lachlan

