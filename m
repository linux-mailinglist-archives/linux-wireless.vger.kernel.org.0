Return-Path: <linux-wireless+bounces-34877-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YN+uGvKl4GlZkgAAu9opvQ
	(envelope-from <linux-wireless+bounces-34877-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 11:03:46 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F5940BF66
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 11:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C41593020EBA
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 09:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4446E352C2C;
	Thu, 16 Apr 2026 09:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHNGJ4MA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC2127E049
	for <linux-wireless@vger.kernel.org>; Thu, 16 Apr 2026 09:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776330189; cv=pass; b=EplNS0jYgFgM2tjNK6+y1EI0Mua/mRTnkTTaRM54/BFFzyb1EdhTe3FwNN7o/476t+VqjDVj0mPqfwKVKeg+2x6ihLsf23bC+IlOQsIuZwCo8bE9FHL+fxga44VUa3zR0w1pLg7j4hYaY8aFXkVN0QeNBZQQsW04t39YNDj+6HU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776330189; c=relaxed/simple;
	bh=YvvNRt8N44zcNbaa7IRqWXoi4C5QZ8FmEaaZXFM/OYw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=G4Zo3UeSICyh+KYdfWPdwueNquyaTBPRGyIE4YWcBZZ+5RoFB93EugPvTN6CD8U8xjpzS2lTVqACZyXiXG/tIboVYqrKfmy0gdfrbsdz8HQhlzblZOIer3XmVLQxpCxY2otp0fo7Qk/TmvpH5iMyd8tuHxk3JGy0DSnLQH+O2Ts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bHNGJ4MA; arc=pass smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2b6b0500e06so14715410eec.1
        for <linux-wireless@vger.kernel.org>; Thu, 16 Apr 2026 02:03:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776330187; cv=none;
        d=google.com; s=arc-20240605;
        b=kK91ADxzEMhWivL5pdMuSU5mOw7tey3sjZ/3YhYR3bG9i+neIfoYrGnR6FrFZ6EocT
         f7aaao6OL1ERd+Az6VoPqKmAHbw7gnxAHt1Al7dva53s7J7UJR1LtMeQxP8gvHotZbO9
         yhK+MAFNsjbxhTcQMezZwNxawSIA6gtwxML0eWH0GD+0cI5wxX9QHG3s8lrNyrHSBoXb
         q0Z0eehusBYYF3qU1QEb2bCssUdBHYD12phXYeGjaXuweAFALNsJ8nw8zA/sxQJXfLV+
         mBOdJy3wIW7D4sepBFx1oUoQowayXqdWvMA/Mty3oN/cdIlvE6IVdSKNOspUGGZnCGKH
         0AKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=YvvNRt8N44zcNbaa7IRqWXoi4C5QZ8FmEaaZXFM/OYw=;
        fh=JClNaBC8dlZl8iuzEdb+Ihos+KBgK/Eb/eOBTk59qjA=;
        b=BeFa5oe3zf3g2TyhCPw2L5H7//fGopHgLrO+Nh+IxwujRVChwq4dzyp4tq0MwLG1M6
         pAgnpFjo8UjVMka9Xl73IFS/K7QKk0PkcsEUsUKgCy5CPYaIIQZbk21gISzQPtShce4p
         Rf2gcRx1w3ckKPsr+JxD1/TKMXPVaVWR4M5autAA081Eh80ipxZOF2MGMH+Buxslepxc
         GsDuVAmM51UpT+L1PdYx0s0KKQ4eqlYb50rc7yakEqRcy7cqatLSKr92ZDZm57WIalO5
         Emxjy/zZzWr8RTe3PmtcHiLoMItt4X7GchYFvSDR4qVJYiLVG9XdBL+jHyql61FWi1+7
         Cmbg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776330187; x=1776934987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YvvNRt8N44zcNbaa7IRqWXoi4C5QZ8FmEaaZXFM/OYw=;
        b=bHNGJ4MAobeVkvI8QKZfhRPNM8Md+smviMi6qf83oZnnsl91sLyuQCdvWhuynv7RI7
         abVgG+9opD3zaei/pvjzkOmkyPOXYygy3bvWfeSnWvlgHkrgwtccxUoUM6TTImTeCf6r
         zIh7GH5x5T6wJNzzre7sZxuEp3sga/t+seV5EG0KQWwOU4qhA3SQ15pJZHVaj84AExdn
         lbuLFVIVg3lzuh3y/7kTv0Sypv9vbUG1RdQt9jsDRzai/l3OPONe6A4kdoWrbdoZAWng
         p5vYTgD/76dy0Whf4wNZOZWHWCV4rWq2ZLpG8zvjQRLEeg79QPEocIjUwOusWOVUuoRp
         uriQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776330187; x=1776934987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YvvNRt8N44zcNbaa7IRqWXoi4C5QZ8FmEaaZXFM/OYw=;
        b=OqVCVj0eM6mGoK+uDXFWdE6q3duqnPUmzhXSA4Z2QsADynJV5uelQZse4yMYsuL1B0
         f5jeqfABUD8YefgFjYCYkDDXpCp7hv1exOy/+klNHH1C1Q+ess+kJMKL0hZhyvKVv4QR
         G7eiMpayyHmZqq/Kx/ruJQnwaqV8SfGHJsEDMFDojfDO5IeNjzEVpa9I/OXNbUA4C5Tc
         lv17bn6IM7GRTV/MJ3A7KZhUj1mVHosMm5ZZqNgmuf0Uk7IAwr/u+Ts+4U+3yZrV36Cb
         y58B/vnxIL+kz5w+OTIEe7omPZxbmjYTpT2YOjgamR5sRSwEJU96jhFxCenJK9/6XVKK
         WOrQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Ax92x/yX+eA4vJTJMSAStOv0fX4BcEo49e4tHrZtSe7rA5UjhC7k272T6LL99mZK43AP2J7uAaBTcf6hxRw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxwtXU/deXOYfa9QJEmR5BtSA7Zj5KL1nqSOHdbZDjwb+/uHOFm
	DIsWqJRILEsTKVMR+iA6XiJzN5kxvECIy20kam+38hSdq79FLQU6i61ZxJoo6WUGdd3b5NGaUiE
	SMbdAZkIuE9myBRCjGc+w368Pvj5InWwy4kf0zpdNlg==
X-Gm-Gg: AeBDieubE+McAQ0A3zGNHSVQjTCqB+UuXBFgnhWzcMswPo74fwYn6kdd5etFFQwenfD
	5NLDuxWx82dnLlIGrXTQbQUI5MmQ2HI/QSKVtlKFM3YFrT1Q3ltoNyqkjVgmffBZPE7XDCfc/PL
	Y+9Y3pDHWHBuwBOX21xzQb3cVAlOfnzmg6d62BwG5lzv11KYRlrZwwhqxx2r5p5tb5Kkh7ciVXb
	Y2EWFs8yfL3/lKHjG1gs3qryKqxR3NtaVgDdYjMxGnWiKOhWSt1177AkzXEeuLz1Ijx2gC3bb9v
	KUrWL25Ub/RY6lP9Gm4=
X-Received: by 2002:a05:7300:6d05:b0:2da:44ac:6d17 with SMTP id
 5a478bee46e88-2da44ac73d7mr8430546eec.17.1776330186461; Thu, 16 Apr 2026
 02:03:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sheroz Juraev <goodmartiandev@gmail.com>
Date: Thu, 16 Apr 2026 14:02:53 +0500
X-Gm-Features: AQROBzCSZziCMqVSc-4LKPugtGbhRz9-Yhx2NybwpvyU40Cu7MOJ0VRdGoQO-n4
Message-ID: <CADPJysyMn_07rb+9b3SgR3xTn+uicSoRp5FMB=oeKNbABtZ5gg@mail.gmail.com>
Subject: RE: [PATCH wireless v2] wifi: iwlwifi: mld: stop TX during firmware restart
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.16 / 15.00];
	FAKE_REPLY(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34877-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.c.6.3.0.1.0.0.e.4.0.c.3.0.0.6.2.asn6.rspamd.com:query timed out];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[goodmartiandev@gmail.com,linux-wireless@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RSPAMD_EMAILBL_FAIL(0.00)[20260405054145.1064152-3-cole.unwrap.rs:query timed out];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 26F5940BF66
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Miri,

Thanks for the quick review. Let me address your points inline:

> Why is there a leak if we freeing the SKBs after we failed?

You're right, "leak" is not the precise term =E2=80=94 the skbs are freed
after iwl_trans_tx() returns -EIO. The issue is allocation churn:
mac80211 keeps scheduling TX via wake_tx_queue, so
iwl_mld_tx_from_txq() keeps dequeuing new frames, passing them to
the dead firmware, getting -EIO, and freeing them =E2=80=94 in a tight loop
for the entire duration of the firmware restart. The /proc/allocinfo
numbers I cited (10.8 GiB / 16.5M allocations) reflect cumulative
allocations during that window, not a persistent leak.

The practical impact is CPU waste (softirq spinning on
alloc-send-fail-free) and slab fragmentation from millions of rapid
kmalloc/kfree cycles, which can cause memory pressure on systems
with limited RAM. Adding the in_hw_restart guard eliminates this
churn entirely =E2=80=94 same as the existing guard in the RX path.

> This was fixed by
> https://patchwork.kernel.org/project/linux-wireless/patch/
> 20260405054145.1064152-3-cole@unwrap.rs/

Thank you for pointing this out. Cole's patch fixes the TSO
segmentation explosion when AMSDU is disabled (max_tid_amsdu_len =3D=3D 1
causing num_subframes =3D=3D 0 =E2=86=92 32000 tiny segments). That's a
different code path from what I observed =E2=80=94 my issue was the TX
dequeue loop running against dead firmware during restart, which
happens regardless of TSO/AMSDU state.

That said, the TSO segmentation explosion he fixed may explain
why the system freeze was so severe with TSO enabled =E2=80=94 both bugs
could have been compounding. The in_hw_restart guard in my patch
would prevent both scenarios by stopping TX entirely before we
ever reach the TSO segmentation code.

> Not sure I understand if you have a new FW or not?

The ucode version string is the same: 101.6e695a70.0
(bz-b0-fm-c0-c101.ucode). But the linux-firmware package snapshot
changed =E2=80=94 I was on an older nixpkgs snapshot when on kernel 6.19.5
(early March), and now I'm on linux-firmware-20260309. Since the
version string embedded in the ucode file is the same, the firmware
binary itself likely did not change. The NMI_INTERRUPT_UNKNOWN
crashes stopping may just be coincidental (different uptime,
different traffic patterns, or some other system-level change).

I don't have the old linux-firmware snapshot to do a binary diff,
so I can't say with certainty whether the firmware binary changed.
If you have a way to check internally whether there were firmware
fixes for Bz-series between, say, February and March 2026 releases,
that would clarify things.

Either way, the code path in iwl_mld_tx_from_txq() remains
unguarded =E2=80=94 any firmware crash under TX load will hit the same
alloc churn. The RX path and TXQ allocation worker both check
in_hw_restart; the TX dequeue path should too.

Thanks,
Sheroz

