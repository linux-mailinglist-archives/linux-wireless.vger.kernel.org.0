Return-Path: <linux-wireless+bounces-38227-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AONwN9QrQWqrlwkAu9opvQ
	(envelope-from <linux-wireless+bounces-38227-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jun 2026 16:12:36 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0386D4059
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jun 2026 16:12:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=jVlMSejA;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38227-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38227-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E67213001001
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jun 2026 14:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E6E3AB47B;
	Sun, 28 Jun 2026 14:12:34 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7A31D5CD1
	for <linux-wireless@vger.kernel.org>; Sun, 28 Jun 2026 14:12:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782655954; cv=none; b=pCrs/AHLl5i0+m5FggHfhD+wpQEQz2KHznJH0576f8+jhdcki2XnMRxe/RWY8yiKmuNB/EU0WqyUD9b/rAIUezNsf5/27O6XhpyjFmOTAUkd8egJtjCuZ23S34v5bC7qgHufS32uOG91hmEBk+kApxUSW9KZ6ijnvDcb+q2odow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782655954; c=relaxed/simple;
	bh=hWytLo5lhGIClSKGyWEQEW+FaoLMyC8Sz0+WjVAkKZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iTbVdnzGTzLsXt1ZyseQYAQExl6ZuvcQ9dw2/kgQv1+OwoeoWbFUB+QFL8SY699gPXWG/r+UFjgM9/EOfp+O1DV6/0yV13GJ5F4lNyfCJzSieSP+DWj8/hWlsnPjnsVRE7skE2puckHDHcYi9mxi2iJL9xSZXR7TubbHHclJbao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jVlMSejA; arc=none smtp.client-ip=209.85.215.174
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c8584e80d59so1026071a12.2
        for <linux-wireless@vger.kernel.org>; Sun, 28 Jun 2026 07:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782655953; x=1783260753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hWytLo5lhGIClSKGyWEQEW+FaoLMyC8Sz0+WjVAkKZw=;
        b=jVlMSejAB7GjfmocxIFlKpnQGpcXZLnSvoPvRJdvWWOqKjrnzIXBtrACXBbOkKShQG
         9q+7rkKXRKoa/vd85CzRLPa8y9zhkMJql1DNusd/nYK3mDIQGs0Z/3aAxW63m+mhXohO
         qjo5fBrArG1etho6Puxaygizzz2JARW0SJSmVEotj904c+DBlgzv2AQ+2b6H81CyhaVv
         waqXt1jcpcwhxt5qGCXFcXbIWa5YRdWPPA3Ke5ityG0rFFjsNu6KhNFL5CYTBxFtXZty
         VvOYtnf4nekP1jXyKpZWKhzG0JbFn9Af59nOWbteQ1VtCQ7pyCzD5qSfR/2DAxMi+Vyx
         E6zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782655953; x=1783260753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hWytLo5lhGIClSKGyWEQEW+FaoLMyC8Sz0+WjVAkKZw=;
        b=QHIcmX66FMbtfDx8krxxdmHWa38GrRuOQo2Yv1h2GkK2woRogosdziEXPCDwuhRfhz
         MVynJtNkDnueHfnFyZPohxMEnC11v9C9urPAyPi7j4zhVBV5fppecW7xjyS8yP1EpMFZ
         +JZVcdD7CJeHkIvbKVeRhcOZPUzIXgyn3XSXQ7czd5N8gSnZ/e9wnKb57vLFeETBoZw8
         hqze2oGb+IcAjUpocT0V+/MG6jWMfbqA+tkLVRS0vxc7lGeE1zvkWgya+E7if4UfZjiT
         pGQNZ0KenJxXDoNjlsWEHm52bEQ//jpb27a1DHboXMt1+fsrjMzWrFu/CkSoo7Ym4ccD
         UAhA==
X-Gm-Message-State: AOJu0YxEdFNvqgnMaOcpsi0bPhIQeChyfXjfRaq8ZASE+Xd0AhidtHcu
	3XQcsTtdZh8rGKgqL7Zqo4CLxGAMIJ32vMxw7Esc17EhqmsPMs/2rTfy
X-Gm-Gg: AfdE7cmS/wj/kshhDlwU8JwSd3fVoivLslUvrpbnHX4woe4/26WAsW2cCrKnOzgB5mk
	oI57mQFyLqbdKzillFicdimTAmFWEKqrZACIc4loOjlb2cYTqlIgvwCD33ylYZHUUInap7qL1Wi
	cv9A4RgcLh1cxRUD2ePhzT/y8phPlm9wWw9DRXlsLwcyLoBLIQnLlGiib1jisHcTTutS07fzW3/
	hZz/n3qYIFTWTIeJi1exMx584mPU0OV63Pu1oSKOHTToy17aOA7EJtTGr3wHTUQz/j1QuxTWadR
	+cxA/6WyXrXB8eqw2JL4c7L7YPUUlDkvPE5Ce5bVJDlG3cGY/HcyFTDM5RHxhTI/LrY7w5unENq
	T2jdihdtx2NHhS2w5Ca57p2BWuMOLGZmssyKUfXcbeFCqW2E30C1UkanhBoJFK9A6JaDXoKM1n6
	Owg5+FjzWZM3HdusjRzY4LpCEJibg=
X-Received: by 2002:a05:6a21:9982:b0:3ba:e5e2:73bf with SMTP id adf61e73a8af0-3bd4afd8113mr13935636637.43.1782655952941;
        Sun, 28 Jun 2026 07:12:32 -0700 (PDT)
Received: from localhost.localdomain ([112.166.204.241])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c96ed000907sm1330488a12.4.2026.06.28.07.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 07:12:32 -0700 (PDT)
From: Hojun Choi <ghwns6743@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepak Karn <dkarn@redhat.com>,
	syzbot+ca7a2759caaa6cd4e3db@syzkaller.appspotmail.com,
	Hojun Choi <ghwns6743@gmail.com>
Subject: Re: [PATCH wireless] wifi: mac80211: clear beaconing state in ieee80211_do_stop()
Date: Sun, 28 Jun 2026 23:13:11 +0900
Message-ID: <20260628141311.12488-1-ghwns6743@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260628130802.7698-1-ghwns6743@gmail.com>
References: <20260628130802.7698-1-ghwns6743@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38227-lists,linux-wireless=lfdr.de];
	FORGED_SENDER(0.00)[ghwns6743@gmail.com,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,syzkaller.appspotmail.com,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dkarn@redhat.com,m:syzbot+ca7a2759caaa6cd4e3db@syzkaller.appspotmail.com,m:ghwns6743@gmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ghwns6743@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,ca7a2759caaa6cd4e3db];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7B0386D4059

Following up with the concrete path, since the question is whether
cfg80211_leave() already covers this. It does not for AP start failure:
ieee80211_start_ap() sets enable_beacon before its fail-able steps, but
its error path (cfg.c:1930) only releases the channel, never clearing it
(unlike the IBSS/mesh paths), while cfg80211 leaves ap.beacon_interval at
0. A later interface-down then makes ___cfg80211_stop_ap() short-circuit
(-ENOENT, net/wireless/ap.c:30) and skip the stop_ap clear, so
ieee80211_do_stop() runs with enable_beacon still set. I could not get a
driver to fail start_ap() there, so this is by inspection, not a
reproducer.

I can fold this into the commit message in a v2, or instead fix the
producer by clearing enable_beacon on the start_ap() error path
(mirroring IBSS/mesh) - whichever you prefer. I used do_stop() since
you suggested it might need to clear that bit.

Thanks,
Hojun

