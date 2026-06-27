Return-Path: <linux-wireless+bounces-38196-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1uclB6GCP2odUAkAu9opvQ
	(envelope-from <linux-wireless+bounces-38196-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jun 2026 09:58:25 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4618F6D16D3
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jun 2026 09:58:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=LeW+q+QC;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38196-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38196-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82360302B381
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jun 2026 07:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3833033D8;
	Sat, 27 Jun 2026 07:58:20 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4AB2D0C62
	for <linux-wireless@vger.kernel.org>; Sat, 27 Jun 2026 07:58:19 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782547100; cv=pass; b=UHq76xXfMpWZjus6d8kskYvPqd0GPTQUvpIYD41GsPFmdb3vTyVCTLodZmPjNHxJFWpPlmMAGNUu1LYII8fbIcTeaPmK+Fg8cCoIEdhMONjWBDEAGlmuLG3K88LvHP5Xtwatv8YyHGc3jl71lJNKeEh1uuda8sh6OH00YoA9uvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782547100; c=relaxed/simple;
	bh=q33S4nIcVhaCasRbH+VPP84AsYp7c0QQFwPFTtp6kmE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Rem9ynaRHEU71UU/g+RHRQQlrv4tmLfV3RpU5q+MA+9/VcxibvuL5U8ZtjKBaQeFvRgzuX4lZ4GW23iyssrTm99FpHM3vU5oNajugj1/xYxe8eYjxKMWBIeGi34J0wncwzFTotHnLVIBwT3JP1xlFSHs/6VkpR0UJleuuUrKRZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LeW+q+QC; arc=pass smtp.client-ip=209.85.210.53
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7e6128bd9b3so920869a34.1
        for <linux-wireless@vger.kernel.org>; Sat, 27 Jun 2026 00:58:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782547098; cv=none;
        d=google.com; s=arc-20260327;
        b=U9lycHDZVYPuIh60/WJJ3poC/5rHFyLLoGfiP0Jhh2QW3r9NthVyhyp4Cv77TzpuXV
         JmjPcEQcz2K4BXNskif+jYqB+OKZK7FBcOns9+tigogQgBhjQAsZg2pCstMby7mST47S
         +3+TikHq8nvwcVkoxX2iUZlB2QRCCf0L7B557+WB5wSMKneC9ZgsKUU4thkNqyGMm3iw
         lv3qX1ozvui9yo1U3DSvTfRAgHAmnp+qKL75HBXFI2csikfpkgyZn36qmJ4gPM5g5x/V
         gdzLsBHQloDYSxyucInC8oOOE1iB4NikA9G+bwM/RabgkVnWk3WxDc6a2WMAcUnZ0eor
         cpEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=q33S4nIcVhaCasRbH+VPP84AsYp7c0QQFwPFTtp6kmE=;
        fh=qW0phhq3fb3oiohK/Mu9j1KY1zyRNiiioKFc5anvatM=;
        b=E5e5auZ5B6kMIFYfDCZ29YR/SjjxmJx/CJ4TO6rZ5q7KzD4gNZb5NzEMFZvxBYNXfR
         YSZ1IsoB2CWoQSGMJgOxh7Tp/xgH5sAkH23q+eF+/7e14Tre60Rnax7DIz/bNeMyCyHN
         2vIowo5gkIyzDO/LDjEVA4mn1WCD/P6Mr6X8l4c2ovKl+eKjGugjcthvqkgJK/tLI+zm
         EDfiALn7vjA6YInTaM2O1X2oCQo2y3hixXXS0EscrGA6Go4dirpfc4hQ2qqgvUYPRlJ8
         5rvijhDpGDQjQHXJ+VKT6NBfqHQp5snlH2XjT7KJ6Bff7Ay3P8PFJtpX+/X6kGjFvi3M
         MRpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782547098; x=1783151898; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=q33S4nIcVhaCasRbH+VPP84AsYp7c0QQFwPFTtp6kmE=;
        b=LeW+q+QCir2l1YoY91G4amZQaUz2EP2SLFcJvThK/iW6bb2Ihp4VQpYZbctVhY8Syx
         avXOzPNZ9/HSDU2X8mpwaojKyImZSRfUgo9gfLBWzx77/y48Mr6yaQ2TsC2eEEC2T/mo
         T96U1VPaabxc5U2qC17pgccPZt/y6IRkyN53T5oCmIbObA47bXFnCUG/3D6tFZ5v6rSO
         1tsMj3z0Ng4iMH2c5Bozw9ZzL9KIfyta8eOMhxnTq3nw1dyI6BFB/eNFf+NNVxIPPOoq
         P7gD1WoEy2NcR6rfVBsZpjBeOqeBp/qLe0tuXvLM7Qkb+dDbnEjhyVEyoL+TkggBndus
         EDfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782547098; x=1783151898;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q33S4nIcVhaCasRbH+VPP84AsYp7c0QQFwPFTtp6kmE=;
        b=WeNqDk6mQ87Eog1u4lTDcLS9zAfzFJ8RX6beNIzg9ab7PFOoxvJSJ/4VRbIzi8nKol
         HQXvXEuJsxaR3ev66QsSI24eGiI9cBnwU088s9HnDImntOCpg+T1cbdcKJ2J2Io4NdLo
         MZVWXFeqsqSnOVTn8tnXYJam95n2/bs7Hqwrv3kI0cA+DBbS015RYBW0PnWLGd7oo8Zl
         TFdABmkBJuDsCBsdvpCk0ZToHDFTtYstgMh+q2uFccxNMuvXk3Gp1WuqSKQ32b0Z+34G
         AbKavDaTA64Ezcc/jXcQHYzKVItiZ4N/eIYO0RkZIUzaHKIVndYSe1PfGJkElQsYKNcX
         rbDA==
X-Gm-Message-State: AOJu0YzN+AGa2pUGlM1z7qlug5y5hkSsTjm/HuBkqY0u8t7/Prq9zXL9
	bC0nJ0YL/RF0iBh3YHKzeaeWXFiP19S5v0khePByZElgv1jJIjqh93JHyraYss/+1emnv7VOvRu
	XXPKMkY0YiIJK1b1Tirt8HKRwGKLPq2FW/YnEEN8=
X-Gm-Gg: AfdE7cmBup5Hk+kCE8bnLeuuo+2hQZIefYpacgq8T9BQ+W+xshmqxx1xMNbnDAQxIU9
	pj3svomIpGm5m06uq8GMwpgOZz8EOriKO/IF+zlLBE4joJW2GA3cRN4E/Te5JVvo97H/MnFa1Rc
	peYzL4iVS8PSibx3lJDSudpfPO054Q8sYojXS4ae65TwpHkTq3S5b1tBEUZ+P8+7BNxClNuMaK9
	3Y2KOUHcf9xPswiQrDN/FVGDr95FajIQeMB6gpRaTXEF7SfyJdOpAQxXcRc2Y5hQKbjpkuy
X-Received: by 2002:a05:6808:150d:b0:490:d1cb:af42 with SMTP id
 5614622812f47-4921a7193a9mr8597458b6e.28.1782547098343; Sat, 27 Jun 2026
 00:58:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: JZARGO <z.ishanov04@gmail.com>
Date: Sat, 27 Jun 2026 12:58:05 +0500
X-Gm-Features: AVVi8Cf_j0Qy3yE7B-YG2imAzET4w9aRi5WtwoqHxhg04c16OBxWtaMgTcB-Zq0
Message-ID: <CAHLiC+o_ZX8GZSK=01Z-baf3+1w89mpz3pfTQpgxi3T1hPUKiQ@mail.gmail.com>
Subject: [BUG] MT7902: Severe Wi-Fi latency during Bluetooth A2DP playback on
 2.4 GHz
To: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38196-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[zishanov04@gmail.com,linux-wireless@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zishanov04@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4618F6D16D3

Hello,

I'm using Linux 7.1.0-1-mainline with a MediaTek MT7902 (PCI ID:
14c3:7902), which is supported by the mt7921e driver.

I've noticed what appears to be a reproducible Wi-Fi/Bluetooth
coexistence issue.

When I connect my Bluetooth headphones (Soundcore P30i) and start
playing audio (A2DP), the Wi-Fi connection becomes almost unusable.
Ping to my local router (192.168.0.1) increases from around 1 ms to
over 1700 ms, and ping to external hosts can reach several seconds.

I also consistently receive duplicate ICMP replies (DUP!) while the
issue is occurring, even when pinging the local gateway. For example:

64 bytes from 192.168.0.1: icmp_seq=18 ttl=64 time=116 ms
64 bytes from 192.168.0.1: icmp_seq=18 ttl=64 time=116 ms (DUP!)
64 bytes from 192.168.0.1: icmp_seq=18 ttl=64 time=117 ms (DUP!)

The problem is fully reproducible. As soon as Bluetooth audio starts,
Wi-Fi latency increases dramatically. As soon as I stop playback or
disconnect the Bluetooth device, Wi-Fi immediately returns to normal.

My router only supports 2.4 GHz, so I cannot test the same setup on a
5 GHz network.

I checked dmesg, journalctl and captured Bluetooth traffic using
btmon, but I couldn't find any obvious firmware crashes, driver
errors, or HCI errors while reproducing the issue.

Is this a known limitation of the current MT7902 support, or does it
sound like a driver issue? I'd be happy to provide additional logs or
test patches if needed.

Thanks.

