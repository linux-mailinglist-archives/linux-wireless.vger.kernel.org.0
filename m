Return-Path: <linux-wireless+bounces-37980-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mKTNL9ldOWqlrAcAu9opvQ
	(envelope-from <linux-wireless+bounces-37980-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2026 18:07:53 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 322F86B0FA8
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2026 18:07:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=AkD74Aqy;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37980-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37980-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8982530449D6
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2026 16:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5478E3B813E;
	Mon, 22 Jun 2026 16:03:03 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141AD3CB2DB
	for <linux-wireless@vger.kernel.org>; Mon, 22 Jun 2026 16:03:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782144183; cv=none; b=X8RicME25e9FZyJO5m+5t5ROa+UTf4SBtvDWQhplVTpmpO51w1JPJ/8m7cqbqgnhPUl9VZgPqvCzmeUoykdOvT2zPFfRkHfDkd+ygA+T6z5kHxA0B/+ww7aqXUocF71QD0UT4srpin0oxPo/F+5Ns4zamgnyIHfiGgzzPoggSiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782144183; c=relaxed/simple;
	bh=+5VtcywrfYSETUagn4J9ivVLSqQ5OKfTp7Oz4HoZsG8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=k7jz37Kj94Qa7Narv633nR5zuBnhj1L6Chw/DxKmS+a7o0SdTrrSEg1CtqAsoEHksDU0EtU2fjjFVHlTrsgqUZ3qHRoitnInlutqROlSrLFrkTRiCDMgBFJsc0FYQCZLurf48iwj0L9Z8RxsI+3iRTNiHt3LQlspn9TQS1zx9NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AkD74Aqy; arc=none smtp.client-ip=209.85.214.170
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2c68190ade4so304275ad.0
        for <linux-wireless@vger.kernel.org>; Mon, 22 Jun 2026 09:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782144181; x=1782748981; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jLQ9EFjJ0O0sXXVX/p0kgIxm/pfqnXagQ5iqRb72qZY=;
        b=AkD74Aqypxvn+jH7DSPnUexcZWq9trXuySZjHWI4NQ0nAnlAcyKGnZk8Ywu9t5Gwas
         gc55VTa0C7pN1pasKPhACPdbN3mPb7+u6Ts5VDWMCmwj7mLPB4VffZ5lO7hdBpjLF7kZ
         IUK1tsQ9nP/B11hZ4XySxJbv9duwsjNbALXS+mhGG8dKpARxh+AB9GqZHy7CERPpxMx8
         HtWmcmiKCYD9qTMhbiZ8CMx2GKoEnsKacxIh/4gkC63De4CnRzwBgyKXLVM4j6g1s/9p
         8tv8xQybyoelsMsA0qsd8nmutopl+J71rjUbPTEJnTgpTrvpdWwcYWS77d9eLI1k9Sly
         QDhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782144181; x=1782748981;
        h=mime-version:content-transfer-encoding:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jLQ9EFjJ0O0sXXVX/p0kgIxm/pfqnXagQ5iqRb72qZY=;
        b=osCEdQoKlA5jmlwlVuU5/o7B9yRus0XximN6YrpjbosfO9ojssaurvt55SNwS/FqB0
         ya0nbPYMVTNEUv5gFcxIqVTRva+d3gTwXnV8E5RWHrW/12ypfQ7ppiSsl+MoITqizbYt
         KbRoH3jf+9FIZdzg8GpAatUDDcZBtzPd8zs3iWsYJs35binvfMEPVf9CfWCJIe9UpcO7
         2klCwPj/x1m1FMYdgLxWpAUxn7XPn6WdPvA/JOiAQL255mXnQL38ewJC/vArVxKc80Nn
         pfAgWizJ3Wghno9jtrlEM18Dep0jojKbjepfTpIh5ZIfRu37NfVLugFIBiP4jt1tgrk2
         I7/w==
X-Gm-Message-State: AOJu0YyjHxMhOk6Fd68FWxFgQI3R4XvtJfdfTIOs0z1PiJ9eb/FPdpXY
	dKVs3SR2oatNhgXsexz3iyMtWeGu3a00Hx3qHnnq6pg4c2Dd7vSMc0Dq
X-Gm-Gg: AfdE7clV4ZGH2d7SnoXNUxqM3DFUN6jPIMcSmTXY+c294PpTBJsKmpyL/L601WWapkz
	Z+5bHjL7nO5npzS+eOLlob6IRC2w/yW7Yb/1Cxna5xbeDyFkbvuXvo5VDycCIWNPbu49H3MeT0o
	uK/Bm77HyBO4t23Ud5QaQnEAlCmBHBz4msGQJR/Znux7KTNTqnRT9NyOK/A81bd5QcDbJ/kORO/
	gyZMO77CnR7Qxt0VHa3o1li99//zROghjVAtZkhi7AigGBtzfcSb9CSmIZyEuG10C5k7f3tgtC0
	3TWK1Vh+EhgTX0m1yT73jwCEwjIyo1i7oLc+FNrOwBkahzFGqcfLZ7S7ZthRrUQ+VLPBZ5AlnAv
	XUijyacH8wnDxhsMNferMqRUNqvIKCQ/1iW1avG+etRnOJvz8i/sboMnex518OLAYLBjSP7JTdV
	cCxmc1dKSA+6zu6UoNUeemJli0/wTE6L5c4r58Ww==
X-Received: by 2002:a17:903:19e3:b0:2c6:b429:f100 with SMTP id d9443c01a7336-2c7c3ece247mr489955ad.15.1782144181230;
        Mon, 22 Jun 2026 09:03:01 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7439f8d11sm87049995ad.43.2026.06.22.09.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 09:03:00 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject:
 brcmfmac: heap overflow in brcmf_notify_auth_frame_rx() on a short auth frame
Date: Tue, 23 Jun 2026 00:02:57 +0800
Message-ID: <178214417708.2368577.16740907093694208834@maoyixie.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37980-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[maoyixietju@gmail.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:arend.vanspriel@broadcom.com,m:linux-wireless@vger.kernel.org,m:brcm80211@lists.linux.dev,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,maoyixie.com:url,maoyixie.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 322F86B0FA8

Hi all,

I think brcmf_notify_auth_frame_rx() in
drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c can overflow the
heap when the firmware reports a short external auth frame. I would
appreciate it if you could take a look.

The handler takes the frame length from the event, then allocates a buffer
for it.

	u32 mgmt_frame_len = e->datalen - sizeof(struct brcmf_rx_mgmt_data);
	...
	if (e->datalen < sizeof(*rxframe)) {
		...
		return -EINVAL;
	}
	...
	mgmt_frame = kzalloc(mgmt_frame_len, GFP_KERNEL);

The only length check is e->datalen >= sizeof(*rxframe). So mgmt_frame_len
can be anything from 0 up. The frame body is then copied with a length that
subtracts the management header offset.

	memcpy(&mgmt_frame->u, frame,
	       mgmt_frame_len - offsetof(struct ieee80211_mgmt, u));

offsetof(struct ieee80211_mgmt, u) is 24. If mgmt_frame_len is less than 24,
the subtraction wraps around as an unsigned value to a huge number. The
memcpy then runs far past the small kzalloc buffer. That is a heap overflow
driven by the frame the firmware passes up. A malicious or malfunctioning AP
can make the frame short during the external SAE auth exchange.

The p2p path in the same driver allocates with the header offset included,
so it does not have this shape.

I reproduced the overflow on 7.1-rc7. With mgmt_frame_len set below the 24
byte header offset, the subtracted length wraps to a huge value and the copy
faults.

  BUG: unable to handle page fault ... in memcpy_orig

A check that mgmt_frame_len is at least offsetof(struct ieee80211_mgmt, u)
before the copy would close it.

Does this look like a real bug to you, and is that the right place to bound
it? If so I am happy to send a proper patch with a Fixes tag and Cc stable.

Kaixuan Li and I found this together.

Thanks,
Maoyi
https://maoyixie.com/

