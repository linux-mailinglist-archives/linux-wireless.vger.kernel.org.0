Return-Path: <linux-wireless+bounces-38146-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +HJhK/4xPmo7BQkAu9opvQ
	(envelope-from <linux-wireless+bounces-38146-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 10:02:06 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B49346CB309
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 10:02:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=NBFXIr+c;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38146-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38146-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 826E630315F6
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 08:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A084533F59B;
	Fri, 26 Jun 2026 08:02:03 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9F726D4C3
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2026 08:02:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782460923; cv=none; b=ili7KVoRpz4vFhxKdWyY7Jk9C0tWvbUeU9s+ZKrDWPMOsXe4wYM06VUKiHXym0VsaQ5yYOI/BpV252Dw81mBFJCu3XgSjCWOzfsb+DMOZFoZGEJZmzHyNu30V/mGrrsw8UP36V2rMqWg5rbfgDcz9qFJjhZSWKTw4FL84ZmLKzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782460923; c=relaxed/simple;
	bh=kfDhEh1ecFaE5hBuz9gWrMAZg8EmziJVbbAjcblMWdg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OQR/DdPpxyInlmFvWp+FDN1ZSDPx2/0u4i8x/SHfT7e9IbQjX3TG7zfkpXx4pA9RLxOCSF2Mfc3iykbf9G/hQsOxuxyQKtIJpoJIpmt7PMq4KY7RghyPDh3GuFyerKQA9ljOZ5sFcJ0KlrR5W8UWJbJXAlsnM/NsbBzmgQ3gBik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NBFXIr+c; arc=none smtp.client-ip=209.85.210.170
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-845a3c05df9so598480b3a.3
        for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2026 01:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782460922; x=1783065722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HMtS9i4yWxly+kvLEOLIToel4pXtI/EX7S4tR3htL3o=;
        b=NBFXIr+cQs246auyOmO7J3BULmjYeTZzKi2700rPE5GeIP/OugoDjsh7LsN46400bz
         W25DiFyXCh1cb8iakrGkGxUWAzGbZ8uhcJ8iMpjvAZYqbt9CjFU8XMRaJjXDq5z8qVjs
         uaeRqi5BuJaW8PzVa7Mak/zYM6e9KIfx2yjSAiZASV28Gy//IfrxhkKCZ0b/zFHXaKbs
         JabcIK4tQBooZ1BBICpqkPPK2s8lEEpPeKVGCcobt6OluFt/OrqN0HENoqFi0EEPAhze
         Mb8KxTSNDc1+faJ4ycMrxqC4elMvMJ4TSDHolY8cegOgLFcQTrBojYs/D6AW324FdklH
         vZ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782460922; x=1783065722;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HMtS9i4yWxly+kvLEOLIToel4pXtI/EX7S4tR3htL3o=;
        b=HOTqlfhgeY0Qd8CB52Q1OK9C/Q+UnOD5wP1cAvNd/ZIOrazxZq+WmEJIjXypUStZyL
         fiW9GmhmyhJLIbxxlfsaBFr5TSKg9KNQJZzdmunHYo/yijIUhQ5WoS/MjilQqsqnJyDN
         8ojCnL0vZEqykIi6j8xDKgR0J1yr3YXRuw/GZLpGoQ+XZ6WH6a2GD/BFALvL28bq2J+S
         VwHa7TFdecEzVEuwBDX4zF6l4yGFp3bx7Glf+wMkntRrSXDChOqnulv+pDHolomCcKH3
         69IF9KnWnMj2dySX0xd79QH+mR4WsSEl5RNg1t2HTraGvqqalbzSAMPeV2unXIpJVwp+
         hF5w==
X-Forwarded-Encrypted: i=1; AFNElJ9SPoBgRfIlbhleJvsROGAdeV9+AFiYtO4z5iNrV6eC23fhAKd6En0AxVT5ujXxzAzeg+Flu9qlQW/H7/EFeA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxHBANJcXvFsuyrkGD6pNumRD4DyZoQJsEKem0PXgw5D4b/pjAw
	50FBHNN3MGHYc/7ZVudVCOQKvKCbpNgKBPL12K+TokUK/hdj3yT+Ig3S
X-Gm-Gg: AfdE7clZGjJFAXgMLkizFzrx1k/XuQUXGi24WyzhFTulfO+twMRZcqfjZLnFqttL+Fu
	dLmcQy4BNXnkZSEZzmcaJXHXBNC8+kZ8dF+Zt98HdnDOu9yZJvVJT5V4vYxPs87poRWXPjtNqEg
	FvKvMuv4to4sui2BIK2DfoQ8Ug55cfYf4bFwt6vB1rO5kWdq1mKXr6dYOMnYdly3TPll9NwYLVT
	F+PqjjA3nuwONpP5NiS+LGSNZ3SBLY9MUyTIHPvL5nczN+4zBQGhIcBQc5jB1d4JE+JceqwsnUk
	iqmeLgNy4I2MFfr/ZojF4U5hI2tlK8CUyezt/Cdr0ETAoPEH18XkyEFg6hjsmYT4ZVPD221Iqpp
	Nj63QIXRGkeL/SE08afsg8l9pN6gisOXAwINGbJy//TT6THPWlD9+Dv0BBwTZMGJqreKjGALQ9w
	qOTazbU9AY6OX95JjBUZ1kuydfkmhNrUnRWcmMHA==
X-Received: by 2002:a05:6a00:22ca:b0:845:3fec:5799 with SMTP id d2e1a72fcca58-845b3a9c888mr7201294b3a.3.1782460921640;
        Fri, 26 Jun 2026 01:02:01 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845a3fedb50sm6235758b3a.24.2026.06.26.01.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 01:02:01 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Maoyi Xie <maoyixie.tju@gmail.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: mac80211: MLO link removal frees link RX stats percpu without RCU grace
Date: Fri, 26 Jun 2026 16:01:58 +0800
Message-Id: <20260626080158.3589711-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER(0.00)[maoyixietju@gmail.com,linux-wireless@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-38146-lists,linux-wireless=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:maoyixie.tju@gmail.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:maoyixietju@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,maoyixie.com:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B49346CB309

Hi Johannes,

I think there is a use after free on the MLO link removal path in
net/mac80211/sta_info.c. The link RX stats percpu buffer is freed while a
concurrent RX softirq can still write to it. I would appreciate it if you
could take a look.

sta_remove_link() frees the link stats and defers only the container:

	sta_info_free_link(&alloc->info);
	kfree_rcu(alloc, rcu_head);

sta_info_free_link() does the free right away:

	free_percpu(link_sta->pcpu_rx_stats);

So the container waits for a grace period but the percpu stats are
reclaimed at once. The RX fast path runs in softirq under rcu_read_lock
only. It resolves link_sta early and writes the percpu stats later:

	stats = this_cpu_ptr(link_sta->pcpu_rx_stats);
	stats->last_signal = status->signal;

A reader that resolved link_sta before the removal NULLed it keeps the
pointer. The container is still alive from the kfree_rcu, so the read of
link_sta->pcpu_rx_stats works. But the percpu block it points to is
already freed. This needs uses_rss. That is when pcpu_rx_stats is
allocated. The trigger is an MLO link removed over the air through a
Multi-Link Reconfiguration element.

The full STA teardown does this safely. __sta_info_destroy calls
synchronize_net() before sta_info_free() frees the deflink stats. The MLO
link removal path has no such barrier. That path was added in
cb71f1d136a6 ("wifi: mac80211: add sta link addition/removal").

I do not have WiFi 7 hardware. This is from reading the code. A small test
that frees the stats buffer and writes it through the live container trips
KASAN with a slab use after free.

Does this look like a real use after free to you? Is the right fix to
defer the percpu free to RCU, like the container already is? I am happy to
send a patch once you confirm.

Kaixuan Li and I found this together.

Thanks,
Maoyi
https://maoyixie.com/

