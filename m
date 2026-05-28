Return-Path: <linux-wireless+bounces-37047-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LdkIiKeF2pYLQgAu9opvQ
	(envelope-from <linux-wireless+bounces-37047-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2026 03:45:06 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6E25EB993
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2026 03:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CEEF730086B3
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2026 01:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E172D5925;
	Thu, 28 May 2026 01:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gf3ozyJo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A42279DC3
	for <linux-wireless@vger.kernel.org>; Thu, 28 May 2026 01:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779932700; cv=none; b=ON5G8Ur6v8xQfTDtlW0BRWRy/UeyMoS4oHjIjDYyOEMOzw6Z3NBJPw5OwAEdzyvHCSs9AIbXvjBjNea/i/42cUjo21EnIeP+Ic2LXs1Fan/Bw77CtNYAJVwwgrCA6s5x45AE6744T2r+c/5BJ9GtNLVuLsZCJ38riAFRkHfPpN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779932700; c=relaxed/simple;
	bh=TihydCDhbnrmWofd6f9s0IhBN6SU/IMiBvOdW9a+IzA=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=R+FC2U9VvxowOrBbbgvIah+Ppdox+uJ/ljE8qFh4wXwn+jVkGy4Uzvm36tQxCGof1ANynGOL5y4wYyjgJtA2qykXQ6nHHTyn1bcQmLUh/b22BFgJzU7HqkAyQ6Yg2umlU3cvxj7NVr0MDLcXL3WIG20fngf5yqq2Hf6+PNdMBSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gf3ozyJo; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-47c918c62b4so7758510b6e.0
        for <linux-wireless@vger.kernel.org>; Wed, 27 May 2026 18:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779932698; x=1780537498; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:content-language:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a+uySOFODUT13LofC+9cNkuL0s/KZOsb8fWjIGa1RrQ=;
        b=Gf3ozyJoaba1zrWiPSRXjeEBaSVHR+ZfjubdvvHVEPWxbr88GLu6GlW3gH0rcU8L5h
         GShYtJ6HoHuAEMRUhfNRd4ZKh+AJ4BmLl5ad4bph3WPJPljQ1HQtDEvGIopFBDMmHrGa
         GAITG+tFilKnzuWCrHti2LQbVTx4pX0qFhNIOBxC1kggauXOe5pDpdYfZuqoQAnT7JMT
         w2RlCviITFo3znz5Jj3ZVEudKIw4E0ym4tUhjbFHqhz17W+M3AtG8jWtzfbhvzTs1lo2
         E64cy7jyNJq4RVs6Ly6CPpz5sMcYEpzVELqWtWV1kJA+urIuZ9Zo2Bbvjx9et3cYYaQ8
         MGdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779932698; x=1780537498;
        h=content-transfer-encoding:subject:from:content-language:to
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a+uySOFODUT13LofC+9cNkuL0s/KZOsb8fWjIGa1RrQ=;
        b=L4hODd8RrfVrhTVRD/7sr8h1/XxdRFfOhlUGByH+GqC6kLDZBvyi1mOcX9haeVKOP9
         AZy9kgebGypn6GmukgDqrlcmJP4leT6HbGC5sxmMgCJlskyDKFWbAEvjIA6Dzq/Zr1GC
         Sm30ZdPjjPENVFTvrkhXKpMBk6HMk0paYuHwivehIY0L7HhJPB4JO+Wu2PJtoS4HELur
         2k7/URgLcRBMw2qZixhLO+MjsBepWQuB++b9SGHfadZHdK7uP3oy/Ltwmk+l9RByQ9tU
         tEutxBMBOZSSmk4vvRY3ImZGRGZPRkyXCJ8ORCBeGshGuwcVRvFBHgVpEoAbG592Hgec
         5Ksw==
X-Gm-Message-State: AOJu0YyReAtzfTIvUBw5Y4yzZRv+zY0EKbIwxgSwv3ARMvu7mYv4Epnz
	u2dmveiIocNEi06Vadb/3mr4+33APMeLTbYKL0c/263cpkY6LXMn5RYRYz5gTATM
X-Gm-Gg: Acq92OHSpSVlMPoteh7PkF2VIvK4LcJSMEOOnWheOGQlmHVW8ZVdCj+Qc80BigpFdEp
	c7iNt1YbO47/85DSqHfz1+Z2NPrm4WZs2vV6Gc1ZqOT7DxbVcTqh0vIhYPlevqjYBHLXJkRLglc
	9BGmy3wWqVIItRK/pNnxMaMp4KVlNL/SDnMi92HGgaY5zheP+5QHcdSwf371O1J+maHhev+Q7Ce
	ohQ9YOPDTWinwdoHwHKEu3W1Q73UvSaLhnG0vVY4Or3BqbIXqI63FLmaCRRlpeYEU8O+l41iAMo
	s6o4gONqCF7X+Ut6dyCgHG+5xC8HqKG0MCoicJ3ch2IRzu8RpPCX2bNjVfoozdtxvzggWPNf51V
	k5iiHBzIWdTNSLrq1LcK24Qm5O/f+3w0zNaw/F5LXrTlnsGtAlNi0ODnarrSVHSKuMTL0KLuqfc
	wpO5aRxR41M/prxcSiT3y0RQfhWf+Sm07E5zE3o2C6aaw0Awnp
X-Received: by 2002:a05:6808:1644:b0:485:29ad:d1a8 with SMTP id 5614622812f47-4854a487be9mr15462444b6e.36.1779932697482;
        Wed, 27 May 2026 18:44:57 -0700 (PDT)
Received: from [192.168.1.8] ([177.228.120.252])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-485546efac0sm8674041b6e.11.2026.05.27.18.44.52
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2026 18:44:57 -0700 (PDT)
Message-ID: <fa96f303-ba3d-47f0-8ffe-04c088d22913@gmail.com>
Date: Wed, 27 May 2026 18:44:44 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Linux Wireless Mailing List <linux-wireless@vger.kernel.org>
Content-Language: en-US
From: Angel Parra <jesusnavarrojr188@gmail.com>
Subject: [RESEND] Ongoing instability and connection loops with MT7922
 (mt7921e driver)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-37047-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jesusnavarrojr188@gmail.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7C6E25EB993
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,
I was advised to reach out to this mailing list regarding severe 
wireless connection issues with my MediaTek card. I am writing to 
request a review of the `mt7921e` driver. While I appreciate the 
significant improvements made to the `mt7902` driver recently, the 
support for some newer chipsets currently feels almost unusable in 
real-world conditions.

My hardware details are as follows:
```text
02:00.0 Network controller: MEDIATEK Corp. MT7922 802.11ax PCI Express 
Wireless Network Adapter
         Subsystem: Foxconn International, Inc. Device e0cd
         Kernel driver in use: mt7921e
```

Below are the most consistent bugs and instabilities I have observed to 
the date that constantly interrupt our workflow:

* The adapter often fails to discover nearby access points, despite 
multiple mobile phones confirming their active presence.
* Both 2.4GHz and 5GHz WLANs frequently remain undetected, even when the 
laptop is directly next to the router.
* Regardless of physical proximity to the modem, the connection process 
regularly hangs on "Configuring interface" (in the KDE Plasma desktop 
applet) for over 15 seconds. After this delay, the connection either 
succeeds or fails completely.
* When successfully connected to 2.4GHz bands, download speeds are 
remarkably slow and fall significantly below what my phone achieves on 
the same connection.
* The detection range is severely limited; establishing a link to a 5GHz 
SSID requires being in the exact same room as the access point.
* Introducing a single wall between the router and the laptop triggers 
the aforementioned 15-second "Configuring interface" hang, usually 
resulting in a failed connection.
* Upon failing to connect to an otherwise healthy access point, the 
system enters an infinite loop. It hangs on configuration, fails, jumps 
to the next saved SSID, fails again, and cycles endlessly through all 
saved profiles.
* Overall connection stability is exceptionally poor. A successful 
connection might persist only if the laptop remains perfectly 
stationary. Otherwise, the link randomly drops after a few minutes with 
a "Connection deactivated" state, triggering the failed connection loop.
* Attempting to bypass these issues by tethering to a mobile hotspot 
directly next to the laptop also fails. The adapter either cannot detect 
the hotspot at all or hangs during configuration, leaving the machine 
entirely offline.

The failing connection loop in `dmesg` looks like this over a span of 
several minutes, clearly illustrating the continuous authentication 
timeouts as the adapter cycles through my saved profiles:

```text
[148485.661369] PM: suspend exit
[148488.781860] wlp2s0: authenticate with f8:64:b8:b8:3d:7a (local 
address=38:d5:7a:12:c2:3b)
[148488.795305] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 1/3)
[148488.843935] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 2/3)
[148488.996043] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 3/3)
[148489.044916] wlp2s0: authentication with f8:64:b8:b8:3d:7a timed out
[148491.867424] wlp2s0: authenticate with f8:64:b8:b8:3d:7a (local 
address=38:d5:7a:12:c2:3b)
[148491.880895] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 1/3)
[148491.939014] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 2/3)
[148492.094896] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 3/3)
[148492.142676] wlp2s0: authentication with f8:64:b8:b8:3d:7a timed out
[148495.354718] wlp2s0: authenticate with f8:64:b8:b8:3d:7a (local 
address=38:d5:7a:12:c2:3b)
[148495.368216] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 1/3)
[148495.418798] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 2/3)
[148495.577799] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 3/3)
[148495.625990] wlp2s0: authentication with f8:64:b8:b8:3d:7a timed out
[148499.324558] wlp2s0: authenticate with f8:64:b8:b8:3d:7a (local 
address=38:d5:7a:12:c2:3b)
[148499.337991] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 1/3)
[148499.387641] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 2/3)
[148499.542987] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 3/3)
[148499.593575] wlp2s0: authentication with f8:64:b8:b8:3d:7a timed out
[148510.294935] wlp2s0: authenticate with f8:64:b8:b8:3d:7a (local 
address=38:d5:7a:12:c2:3b)
[148510.308356] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 1/3)
[148510.360427] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 2/3)
[148510.406754] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 3/3)
[148510.566970] wlp2s0: authentication with f8:64:b8:b8:3d:7a timed out
[148520.573843] wlp2s0: authenticate with 84:d8:1b:9f:91:10 (local 
address=38:d5:7a:12:c2:3b)
[148520.587285] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 1/3)
[148520.644274] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 2/3)
[148520.693177] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 3/3)
[148521.140382] wlp2s0: authentication with 84:d8:1b:9f:91:10 timed out
[148541.462597] wlp2s0: authenticate with 84:d8:1b:9f:91:10 (local 
address=38:d5:7a:12:c2:3b)
[148541.476062] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 1/3)
[148541.522330] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 2/3)
[148541.973505] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 3/3)
[148542.022304] wlp2s0: authentication with 84:d8:1b:9f:91:10 timed out
[148548.610998] wlp2s0: authenticate with f8:64:b8:b8:3d:7a (local 
address=38:d5:7a:12:c2:3b)
[148548.624376] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 1/3)
[148549.075668] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 2/3)
[148549.121771] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 3/3)
[148549.574886] wlp2s0: authentication with f8:64:b8:b8:3d:7a timed out
[148552.427178] wlp2s0: authenticate with 84:d8:1b:9f:91:10 (local 
address=38:d5:7a:12:c2:3b)
[148552.430014] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 1/3)
[148552.470639] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 2/3)
[148552.513942] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 3/3)
[148552.556374] wlp2s0: authentication with 84:d8:1b:9f:91:10 timed out
[148565.252575] wlp2s0: authenticate with 84:d8:1b:9f:91:10 (local 
address=38:d5:7a:12:c2:3b)
[148565.266023] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 1/3)
[148565.396382] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 2/3)
[148565.446749] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 3/3)
[148565.605849] wlp2s0: authentication with 84:d8:1b:9f:91:10 timed out
[148579.997166] wlp2s0: authenticate with 84:d8:1b:9f:91:10 (local 
address=38:d5:7a:12:c2:3b)
[148580.010594] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 1/3)
[148580.072257] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 2/3)
[148580.112398] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 3/3)
[148580.152361] wlp2s0: authentication with 84:d8:1b:9f:91:10 timed out
[148592.848439] wlp2s0: authenticate with 84:d8:1b:9f:91:10 (local 
address=38:d5:7a:12:c2:3b)
[148592.861867] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 1/3)
[148592.903480] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 2/3)
[148592.995422] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 3/3)
[148593.041528] wlp2s0: authentication with 84:d8:1b:9f:91:10 timed out
[148607.612953] wlp2s0: authenticate with f8:64:b8:b8:3d:7a (local 
address=38:d5:7a:12:c2:3b)
[148607.626393] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 1/3)
[148607.698476] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 2/3)
[148607.742091] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 3/3)
[148607.783429] wlp2s0: authentication with f8:64:b8:b8:3d:7a timed out
[148620.219579] wlp2s0: authenticate with 84:d8:1b:9f:91:10 (local 
address=38:d5:7a:12:c2:3b)
[148620.233011] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 1/3)
[148620.328013] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 2/3)
[148620.374159] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 3/3)
[148620.534020] wlp2s0: authentication with 84:d8:1b:9f:91:10 timed out
[148633.224869] wlp2s0: authenticate with 84:d8:1b:9f:91:10 (local 
address=38:d5:7a:12:c2:3b)
[148633.238306] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 1/3)
[148633.303939] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 2/3)
[148633.356603] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 3/3)
[148633.514978] wlp2s0: authentication with 84:d8:1b:9f:91:10 timed out
[148637.634640] wlp2s0: authenticate with f8:64:b8:b8:3d:7a (local 
address=38:d5:7a:12:c2:3b)
[148637.647620] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 1/3)
[148637.694360] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 2/3)
[148637.743291] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 3/3)
[148638.192244] wlp2s0: authentication with f8:64:b8:b8:3d:7a timed out
[148655.509368] wlp2s0: authenticate with 84:d8:1b:9f:91:10 (local 
address=38:d5:7a:12:c2:3b)
[148655.522809] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 1/3)
[148655.572981] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 2/3)
[148656.021379] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 3/3)
[148656.070061] wlp2s0: authentication with 84:d8:1b:9f:91:10 timed out
[148677.626050] wlp2s0: authenticate with f8:64:b8:b8:3d:7a (local 
address=38:d5:7a:12:c2:3b)
[148677.639450] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 1/3)
[148677.704689] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 2/3)
[148677.753188] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 3/3)
[148677.914243] wlp2s0: authentication with f8:64:b8:b8:3d:7a timed out
[148680.509871] wlp2s0: authenticate with 84:d8:1b:9f:91:10 (local 
address=38:d5:7a:12:c2:3b)
[148680.512694] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 1/3)
[148680.530021] wlp2s0: authenticated
[148680.530280] wlp2s0: associate with 84:d8:1b:9f:91:10 (try 1/3)
[148680.555487] wlp2s0: RX AssocResp from 84:d8:1b:9f:91:10 (capab=0x411 
status=0 aid=4)
[148680.582777] wlp2s0: associated
[149142.517235] nvidia-modeset: WARNING: GPU:0: Correcting number of 
heads for current head configuration (0x00)
[149361.823195] wlp2s0: Connection to AP 84:d8:1b:9f:91:10 lost
[149418.133906] wlp2s0: authenticate with 84:d8:1b:9f:91:10 (local 
address=38:d5:7a:12:c2:3b)
[149418.145316] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 1/3)
[149418.194402] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 2/3)
[149418.242746] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 3/3)
[149418.692292] wlp2s0: authentication with 84:d8:1b:9f:91:10 timed out
[149437.001016] wlp2s0: authenticate with 84:d8:1b:9f:91:10 (local 
address=38:d5:7a:12:c2:3b)
[149437.012391] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 1/3)
[149437.095855] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 2/3)
[149437.142168] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 3/3)
[149437.593548] wlp2s0: authentication with 84:d8:1b:9f:91:10 timed out
[149464.557438] wlp2s0: authenticate with 84:d8:1b:9f:91:10 (local 
address=38:d5:7a:12:c2:3b)
[149464.568407] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 1/3)
[149464.730630] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 2/3)
[149464.777125] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 3/3)
[149464.932766] wlp2s0: authentication with 84:d8:1b:9f:91:10 timed out
[149474.631073] wlp2s0: authenticate with 84:d8:1b:9f:91:10 (local 
address=38:d5:7a:12:c2:3b)
[149474.644554] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 1/3)
[149474.690700] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 2/3)
[149474.849313] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 3/3)
[149474.895328] wlp2s0: authentication with 84:d8:1b:9f:91:10 timed out
[149535.532981] wlp2s0: authenticate with 84:d8:1b:9f:91:10 (local 
address=38:d5:7a:12:c2:3b)
[149535.546820] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 1/3)
[149535.678835] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 2/3)
[149535.725111] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 3/3)
[149535.880819] wlp2s0: authentication with 84:d8:1b:9f:91:10 timed out
[149879.705065] wlp2s0: authenticate with 84:d8:1b:9f:91:10 (local 
address=38:d5:7a:12:c2:3b)
[149879.718556] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 1/3)
[149879.794297] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 2/3)
[149879.843592] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 3/3)
[149880.017253] wlp2s0: authentication with 84:d8:1b:9f:91:10 timed out
[149888.633997] wlp2s0: authenticate with 84:d8:1b:9f:91:10 (local 
address=38:d5:7a:12:c2:3b)
[149888.647548] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 1/3)
[149888.805077] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 2/3)
[149888.856075] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 3/3)
[149889.015401] wlp2s0: authentication with 84:d8:1b:9f:91:10 timed out
[149928.562888] wlp2s0: authenticate with 84:d8:1b:9f:91:10 (local 
address=38:d5:7a:12:c2:3b)
[149928.576448] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 1/3)
[149928.619097] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 2/3)
[149928.661687] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 3/3)
[149928.737998] wlp2s0: authentication with 84:d8:1b:9f:91:10 timed out
[149941.444820] wlp2s0: authenticate with 84:d8:1b:9f:91:10 (local 
address=38:d5:7a:12:c2:3b)
[149941.458370] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 1/3)
[149941.615999] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 2/3)
[149941.662509] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 3/3)
[149941.711201] wlp2s0: authentication with 84:d8:1b:9f:91:10 timed out
[149956.605669] wlp2s0: authenticate with 84:d8:1b:9f:91:10 (local 
address=38:d5:7a:12:c2:3b)
[149956.619156] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 1/3)
[149956.673039] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 2/3)
[149956.721411] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 3/3)
[149957.172885] wlp2s0: authentication with 84:d8:1b:9f:91:10 timed out
[149969.882794] wlp2s0: authenticate with 84:d8:1b:9f:91:10 (local 
address=38:d5:7a:12:c2:3b)
[149969.896301] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 1/3)
[149969.943140] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 2/3)
[149969.990954] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 3/3)
[149970.442757] wlp2s0: authentication with 84:d8:1b:9f:91:10 timed out
[149984.624558] wlp2s0: authenticate with f8:64:b8:b8:3d:7a (local 
address=38:d5:7a:12:c2:3b)
[149984.638187] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 1/3)
[149984.697458] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 2/3)
[149984.737544] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 3/3)
[149984.778744] wlp2s0: authentication with f8:64:b8:b8:3d:7a timed out
[150016.560488] wlp2s0: authenticate with f8:64:b8:b8:3d:7a (local 
address=38:d5:7a:12:c2:3b)
[150016.573492] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 1/3)
[150016.614971] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 2/3)
[150016.673246] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 3/3)
[150016.721924] wlp2s0: authentication with f8:64:b8:b8:3d:7a timed out
[150051.575890] wlp2s0: authenticate with f8:64:b8:b8:3d:7a (local 
address=38:d5:7a:12:c2:3b)
[150051.589489] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 1/3)
[150051.636535] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 2/3)
[150051.685162] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 3/3)
[150052.134899] wlp2s0: authentication with f8:64:b8:b8:3d:7a timed out
[150064.827990] wlp2s0: authenticate with f8:64:b8:b8:3d:7a (local 
address=38:d5:7a:12:c2:3b)
[150064.841478] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 1/3)
[150064.966855] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 2/3)
[150065.015378] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 3/3)
[150065.174847] wlp2s0: authentication with f8:64:b8:b8:3d:7a timed out
```

Thank you for your time and for reading through this report. I would 
greatly appreciate it if this could be routed to the appropriate 
maintainers to help address these driver issues. Have a great day 
wherever you are.

