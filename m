Return-Path: <linux-wireless+bounces-36825-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qALKHOFmEWo2lgYAu9opvQ
	(envelope-from <linux-wireless+bounces-36825-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 23 May 2026 10:35:45 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C0E5BDF3D
	for <lists+linux-wireless@lfdr.de>; Sat, 23 May 2026 10:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A88530151EB
	for <lists+linux-wireless@lfdr.de>; Sat, 23 May 2026 08:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D3223A562;
	Sat, 23 May 2026 08:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nTW4alfI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1910A33FE09
	for <linux-wireless@vger.kernel.org>; Sat, 23 May 2026 08:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779525242; cv=pass; b=opYKvNCfZ/Ej2DIijJiIAY2SA2N8q5DeYWpnU3Ym58R4851zEIJmLDzQD8f8HhIFGdyI+oJTYHMHr/QUGN7qGK8vKPuh42aE3ZfeKABInXLEvXFZF+lXwmWki+4PJg0Jt9sTZsoGvKM5qAz8FS5qKushBf3bkK5+CzP7Y2Pf1jc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779525242; c=relaxed/simple;
	bh=py9+TVm007PvdYCnoWugZ//nTkD+/ojYPc9oZ/9D7d0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=fQCvEcwVwTKXQ7ZYqyQPgQ4WHt0QsBj8zFZYnGlayJXFK19uJk/G5lZgYmaJsdSjJO0i/crgjqlOpe8e5I2hNWgVGoY+AOE0sfldy4oViNdI0o50M8HtQVR3bpmA66HXeRanWYn7w7mlkzRp5goyqS4kMOVonHnCteLYqCtgDHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nTW4alfI; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-68707d88626so8355905a12.0
        for <linux-wireless@vger.kernel.org>; Sat, 23 May 2026 01:34:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779525239; cv=none;
        d=google.com; s=arc-20240605;
        b=ZHZhLPORSElI7bgI0bMifzPrn35uVptnpZFbFCqFIiI70PkYOuzu0ncQfvR9Xgcd1w
         Qa6ARjGYte/wu3s8eea/O1QkAW+qe3n5Ut+1cuBOboJyBoh8Vg4ScIrR6Z79HcOmBOg8
         Tk5kd2X71JAARUPYQliT2XteuFq5AQd7jO0cxXsPP0RW3SnvV6AcUmqSOxO6Lz5bHrYu
         8tRXx4jl1GEY4vJlKpAXiihYdeLOQ86WweXooM+qePQIcvbW3flJ2lYhzgIDqdWsLkw1
         QtJYI2WcbsXM5DqlZH7rEH2h+5iZ6eu8u4r7z4Nb4ltvWs/BFl6Aen7hEdtM1xOpT6bM
         9sdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=8Xq2cjiaSUu6eNocrw28UJ5Mqc85pDkV8ASkmLXScnI=;
        fh=qW0phhq3fb3oiohK/Mu9j1KY1zyRNiiioKFc5anvatM=;
        b=Hm24L3s9S9c2f8tNokdU/G0GbyHZgALU6ih9Ud+05pq4FrzFdixZZC0Pe9sXgbn1gp
         X/uOZ8B3nW2sZxzZGzC26IFCohLSwBcvXCoU6Q9I4Hj6IKMlQK2wN7l2giYGLFS1ZvX3
         HFCzYzERJpc2KdmSsVFOjR1qHfQpphx1kns6XwPWALQMVqbp3sQr6lnjR/Qi9uz3zi7n
         SqylOopW9m+LMexa0Lxn93re6+V5e0PHQfFcO4IhMZ2LXGy+Q6mUZJq2tvLyVhYcsITz
         J0PnYLjuL2HUZJKkpzz+eGjX9jPujXF/RXMTT9XHiPeJisRVyX6sra/kH3ZIwe/7e48n
         hvAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779525239; x=1780130039; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8Xq2cjiaSUu6eNocrw28UJ5Mqc85pDkV8ASkmLXScnI=;
        b=nTW4alfIBQPTI/JLE917AqnmBPdaYKhEoqOTQC4DF+6QxvvQF4XC3gERUjphY8VxYa
         FAD74fj0cL5ZtwIsGnwWVM0Of2P6naycb/CMRvHKTvzla53g8Hl2e6LxHMjt5+HnICBw
         rTcZIXBb23056VI2JUkuP09WkqoX/Jd2739tg1F/bZOQyY5epCVpPLPXTUrI9Uu78kCb
         Ve4z0SPz0L4o4JqgGTaqMR2oGwoO9w1hsTw/iRLumdMIhA8FbeT8QRa/1VD+o2sRwfTQ
         MRKzO+aMyss2fORH2UZHHelB2TWRSoIYNcIWrPVwTenEg5cYmel9jQRFhCVGvGn7mdXL
         Vc8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779525239; x=1780130039;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Xq2cjiaSUu6eNocrw28UJ5Mqc85pDkV8ASkmLXScnI=;
        b=KlPWgDNU9POvelSkIjEX3CRZn+KVnmQAPt5Dp2UbK+TFJZDmcoPRTxnZXNppX2iQ2x
         PxPXQCz606dlsITfXs+lDVzrTjsQkGuLlQeOfU7lf+p8627s5Em8nn650Vcn4zdCUatk
         V1KV/liNvgadn0BCbVFXfpezOQozIxDDXnanlN8x6C6bBu9AiZR6yAF0KkBM5PJuo3zA
         lsSkm/QEomFKqQSWtbWW0kGhZ2f69oLq2wImD4mlDZ7Or8JI42zhowTO8NoZPRupJps9
         dKIWCO4sC/cY0R/OBkKs6jFbFvgST23M5Jgf+QimsUtMp65NXupdRT/E4i9l9t+hL9BF
         jE9Q==
X-Gm-Message-State: AOJu0YyuB4qB/tGLXuqzPsD0r+ALJeegq8lshxIu4Dvp2+PYW0Nn6Lc4
	9ZUJxeRSWBL8T1IsCIVA2eoYCXL3DejeaypwO/holE+O16yeiAR7pYBmbmKgE+tYyshEnGheQuV
	0YTP5DzKOaSzhgV9uUAIvKBBDUt6WHcAfPXhWH0s=
X-Gm-Gg: Acq92OGaNJ+bIW4U+2mtjGaautFw09PW6a/aXMH9NK2KshShxGo3IYwFeGbKUuXXDEJ
	ew3g2A9WfT8pj634R745WFvtXmoR2SRfmZDuftfFGY2P0zG8vENfMVAWgfUlO6BN/BzA526iF7n
	PAhr3iavrFUmU2POTV68dPjDZo3pAg5peLyJtdYjbJM4/rrVl5dTtl5tJnhoSFo7CdlfnibRe/Q
	FJ8eHOhiAts9yDy1/XvjeUqr0e7WUDIxMZTSta3YyQTsiwkEeLd/psw/6+oR9mpa3OvubyuZHRx
	Z7Rh98/Dq8aDEkcdsUh2F+BVBl+ygpxrojcrTnmtY1KP3XJFnjxgeorLX/u18Y3H10P9nmx0IA=
	=
X-Received: by 2002:a05:6402:11d3:b0:687:ece2:aac6 with SMTP id
 4fb4d7f45d1cf-6889cc37582mr3751455a12.15.1779525239431; Sat, 23 May 2026
 01:33:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Michael Blake <mgblake7@gmail.com>
Date: Sat, 23 May 2026 10:33:47 +0200
X-Gm-Features: AVHnY4LPQECEH9xjMfJ9Xbhc5flQyy_1b23xWr9rVYabjlwiDDQp3ddwrGfFGSA
Message-ID: <CAAecyrURg5npc+coGw7nG58EMUoM2wu1rao0EGL3cV8CqcVA-g@mail.gmail.com>
Subject: iwlwifi: 6 GHz band not exposed on BE201 in ZA regulatory domain
To: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-36825-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mgblake7@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: C9C0E5BDF3D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

The Intel Wi-Fi 7 BE201 card does not expose any 6 GHz channels in
country code ZA (South Africa), even though:

  - The global regdomain authorises 6 GHz operation in ZA
  - The card's self-managed regdomain table includes a 6 GHz entry
  - The hardware supports 6 GHz
  - A 6 GHz radio is operating in range (TP-Link Deco XE75)

Hardware / software:

  PCI ID:           8086:7740 (Arrow Lake CNVi WiFi)
  Card:             Intel Wi-Fi 7 BE201 320 MHz
  Driver:           iwlwifi + iwlmld
  Kernel:           7.0.9-arch1-1
  Firmware:         101.6e695a70.0 bz-b0-fm-c0-c101.ucode op_mode iwlmld
  linux-firmware:   20260410

Regulatory state (`iw reg get`):

  global
  country ZA: DFS-ETSI
    (2402 - 2482 @ 40), (N/A, 20), (N/A)
    (5170 - 5250 @ 80), (N/A, 20), (N/A), AUTO-BW
    (5250 - 5330 @ 80), (N/A, 20), (0 ms), DFS, AUTO-BW
    (5490 - 5710 @ 160), (N/A, 30), (N/A)
    (5925 - 6425 @ 320), (N/A, 14), (N/A)

  phy#0 (self-managed)
  country ZA: DFS-UNSET
    [2.4 GHz and 5 GHz channels listed, omitted for brevity]
    (5945 - 6425 @ 480), (6, 22), (N/A), NO-OUTDOOR, AUTO-BW,
                                          IR-CONCURRENT, PASSIVE-SCAN

The phy's self-managed regdomain lists 6 GHz frequencies in its
output, but `iw phy phy0 info` shows only Band 1 (2.4 GHz) and Band 2
(5 GHz). There is no Band 3. No 6 GHz frequencies are listed under
either Band 1 or Band 2.

This means no 6 GHz channels can be scanned or associated with, and
the neighbouring 6 GHz radio is invisible to the card. iPhone clients
in the same location can see and use the 6 GHz radio.

Is enabling 6 GHz for ZA on Bz / BE2xx-family cards waiting on:

  (a) a country-code table update in iwlmld (or wherever the driver
      whitelists 6 GHz enablement),
  (b) a card NVM/OTP regulatory data update from Intel firmware, or
  (c) something else?

Happy to provide additional debug info (full `iw phy phy0 info`,
dmesg with cfg80211 debug enabled, NVM dump if useful) or test
patches.

Thanks,
--
Michael Blake
mgblake7@gmail.com

