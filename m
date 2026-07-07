Return-Path: <linux-wireless+bounces-38717-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id chBUJglqTGqnkAEAu9opvQ
	(envelope-from <linux-wireless+bounces-38717-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 04:52:57 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2056716E6F
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 04:52:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=aae0lUia;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38717-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38717-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6007030276A3
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jul 2026 02:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD4E379C24;
	Tue,  7 Jul 2026 02:52:54 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436D33783A0
	for <linux-wireless@vger.kernel.org>; Tue,  7 Jul 2026 02:52:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783392774; cv=none; b=PsE1n9JZFjV4zca24B+O7pYpcNmRqzy08KZ9MQix4RcjsLQ52KpewTawHE7Bm1/w0GnLD9kayl5WV0lUwAmOmz39jz76TpBT1YJKXoQRVkDcJJt2t5qvrcZVQyev+iam87iSVjEsxZHEstKGZuhUtMI1q3h35tb3XCDa6AZkBic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783392774; c=relaxed/simple;
	bh=5M2YrcPiptfqbXGkJTbIpEJldIHFNKqIymihIVN/6sE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qbeIFG36pNZ+5VEIhVRBpnfKuqdo6L7nvFE6bev2uM6WJ3LRB62HpEowU3Cqomq7KniiRN2mdQX5H2JQMOaUNMQkCkK/FTVOhX628ld5yPmgIAo1Lfl9lWS7ROHvkdBDa/XcoRJZo+vQTd9JaSJ4fjvx8K612IlktcoDVKpxDTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aae0lUia; arc=none smtp.client-ip=209.85.214.171
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cabc0a1ab6so40401175ad.0
        for <linux-wireless@vger.kernel.org>; Mon, 06 Jul 2026 19:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783392772; x=1783997572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PoCszZUb0XOemc0ojDDfrmQI7JkvJWihi2/+4QrQwik=;
        b=aae0lUiah55hRbbWxvvOOgkSQIDA7x/rFoBMQGDhOjz+F2zJr7nsUwUyDTUj3NqH+5
         w1kMDNjvtjHB9wRkvIzGMr52/VVOChyjteGuCepI8qb/Fh2oOBUZf0z6+0pEfrmKRhbo
         Fr/VIuh/DQfKzMxcdvPG35aHfGDwFqS/r9TCJzAmKMXeEl+RrPgi0VbxAiNj8RC9C3hC
         aN53iNzG7IzMVABc806jQisLxR2V+AIspqlvnqQB4+/+IjfP5Qbr4ivpT2b3lMpi5NeR
         KAaSZFiu1OPrH/jypIpOJguZMQ2God0gK5VNoQ/0U2jnz9qTm7Te9aPxyF1WjjwLpPrf
         rEmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783392772; x=1783997572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PoCszZUb0XOemc0ojDDfrmQI7JkvJWihi2/+4QrQwik=;
        b=hyyxyxCX4zULsqM/HpsKnru7jr/y9zYlpy+bf/zEjVIbxDNWNhMxZVnwa3MK9Tcq/r
         uxSAjvSP7J0huqItGTR+zA5g8UsOHmMqy3Qm4bOstLpXWlYTUmtw9Mn+x/5h/Royjnbn
         llJ7xT7YJorx34bE3IrAltotnORZVLEX0EsgyA1FfXw3b0dnlsDQMki2dbQXqDKQdChk
         p/kJux+VQfkukgSnC1t0oSb2iEUmqXu92F8UVvq0BzZtkB9hrzPtH2ieFq7F04I/RgWG
         uZZ1hKbm1btQyGVxT1EXscCsWMHS6MlXipxzSzqOo92BBYH9uFHbCvjfjyX9jisNi8Nu
         B4Hg==
X-Gm-Message-State: AOJu0Yz+eZkJXBm92fTFjTJTOvYnKzsbr55be+YDUbrFmD27OjpGbGPU
	epesBXWeQq8IQbo5it1LRc0qcj6wlwrxSwOa6EjOTschpvDVJMz7bySl
X-Gm-Gg: AfdE7ckUDVztRzH1+IeNJNadF1WM1vsCiqf+v2H7YeriWGZxaRsqga7r40FmNrjUPIv
	T1aKCKhf8AAcTqhN8lAVRC6BEGSgM4wAbfQHKVOjYT1d0AlIoMw9+vLEDpfdgXXEKmkUrGy3Bks
	SqIGnWqFZp41Zy++JP1xY2TumoPpW8pPZbLgp3sdHJaOlNmWiRAo2+a/68fnvwWPW3QXwG3jpAx
	gT7mSHMSA6AxY/y8I73+TuGyBwbJ1L97w7031r1MT1sJn7cXGCsyZPbQQujMPI+7NAe9QYthglI
	CLA9KAhLRcgDI2EKBZhd5A21i6KQ+NQ4+XIJqVR7VHifXUESIwJAdmoKGWrbO/fTBnKtl0kereX
	NBGw9QTwU0LzW/Wo9EyUV/bUlTk3B7EPtEkHZk08LvWpIC7rqGBagWlhAp1t50dtV9l7YnPiLOH
	70lzr6Gvg03agbkSCL469hoEwupQfg6KYqaScJu9KyEZHJSbQ6izTa
X-Received: by 2002:a17:903:b4b:b0:2ca:b1f6:b0c5 with SMTP id d9443c01a7336-2ccbf1a43edmr34606565ad.38.1783392772292;
        Mon, 06 Jul 2026 19:52:52 -0700 (PDT)
Received: from KRHW1CJW23.bytedance.net ([139.177.225.229])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d1e914sm3333165ad.50.2026.07.06.19.52.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 06 Jul 2026 19:52:51 -0700 (PDT)
From: Zhao Li <enderaoelyther@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] wifi: cfg80211: validate rx/tx MLME callback frame lengths before access
Date: Tue,  7 Jul 2026 10:52:41 +0800
Message-ID: <20260707025241.22223-1-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <488ed9862d5196b8f5ecf23f037fa6725fbe9a52.camel@sipsolutions.net>
References: <20260612185042.66260-4-enderaoelyther@gmail.com> <488ed9862d5196b8f5ecf23f037fa6725fbe9a52.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38717-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[enderaoelyther@gmail.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enderaoelyther@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E2056716E6F

On Mon, 2026-07-06 at 18:37 +0800, Johannes Berg wrote:
> > Side effects of this change:
> >  - The WARN_ON(len < 2) is replaced by a silent early return, since
> >    these cfg80211 callbacks can legitimately receive short frames from
> >    drivers.
>
> Can they? How?

You're right, that wording is wrong; no in-tree caller passes len < 2.
mac80211 gates every path well above that (ieee80211_rx_mgmt_auth() at
len < 24 + 6, ieee80211_rx_mgmt_deauth()/disassoc() at len < 24 + 2), and
the locally built deauth/disassoc frames are always full size.

The frames that do reach these callbacks undersized are short relative
to their subtype, not shorter than 2 bytes. mwifiex accepts a 4-address
ieee80211_hdr plus the 2-byte firmware length prefix. After it strips
the prefix and removes addr4, pkt_len can be exactly 24: a bare
3-address management header with no reason-code body.
WARN_ON(len < 2) does not fire on that, and cfg80211_process_deauth()
then reads u.deauth.reason_code as a two-byte access starting at offset
24, immediately past the 24-byte buffer.

So the len >= 2 check only guards the frame_control read; the per-subtype
offsetofend() checks are the actual fix. I'll drop the WARN rather than
keep it, because these are exported callbacks and a malformed frame from
a driver should be dropped silently instead of backtraced.

v2 rewrites the commit message to describe the mwifiex path instead of
the inaccurate "legitimately receive short frames" claim; no code change.

Thanks,
Zhao Li

