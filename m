Return-Path: <linux-wireless+bounces-37806-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OuZEFHa7L2ogFQUAu9opvQ
	(envelope-from <linux-wireless+bounces-37806-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2026 10:44:38 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E05684AD1
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2026 10:44:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="XdMKBo/s";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37806-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37806-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 53848307BFE0
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2026 08:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CEE2391E43;
	Mon, 15 Jun 2026 08:37:56 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D51636DA13
	for <linux-wireless@vger.kernel.org>; Mon, 15 Jun 2026 08:37:54 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781512676; cv=pass; b=O1ivisGC9g6aK1LJ0cEnsEjbfoZ7dmeFYTQnVCFXMp6bQU9xzli5XWRAZoC+h2kKdOTO7rotSiJc9UxhN+DsMyDAlMVJ3CHPfi9w5cB4rhSQJOPd2YWCOk84G6oTssZL+hdgWhMb9wp6a7+j/2r1vfv/gCcrZqc1Idp4Fe8mR+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781512676; c=relaxed/simple;
	bh=2SU/5lv1NqATLiyxytCdIIpKNW3uAdIA0HRA1nkK7ww=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=CbtWDA3R44OjDyn3uaXJapSrtHovDl9dJBSnGw/ZGvAHhHn1MdjUp0lu+tyoF/RUIjvaLLV6JbisA2AmQhURn0QIRiBAXvsDdbmE+67OwAtunEees5A+TW2ULnAAJZiVYQGAoL+WA524EW7fZWQ1tLEsRwD1kNsAsRoCQdi9eH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XdMKBo/s; arc=pass smtp.client-ip=209.85.222.181
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-91578122305so504774885a.0
        for <linux-wireless@vger.kernel.org>; Mon, 15 Jun 2026 01:37:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781512674; cv=none;
        d=google.com; s=arc-20240605;
        b=SPwR+enfy99bKlkQs5LZeyXfFuvpuCuiMmOVV4lXN8TY7bhxxolevQpsB5Z6qNhX+1
         OK+rVXOGyTY/jvOHWyQbYDGsOfUU9IoVbGfZGfrnFa7NDK2IQNJLcmfZ9/PkP7n92XDt
         8H8kn8OSYxiSXiK4Ii9QyzSGqvhnWqfv2SR8jyW+48w0Z4AumzZTHH5C0w3wc72wSvgk
         VspXv+POGJpigJ6H5GeeruilpUYWPtlARQHfHEh9tIBRosBoG1GQNwmaaFypRrGA8eG6
         pYE7O/lvqTOnVZ6n4NLlzUQTRwExIfEBlMC6DTfI32NAJ0K1QXfA/Rq3rC54CfUv1DBI
         RjPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=FpQspOt3oBlmx1ICglqJz9lIvpUfboVOloEqqL6E+S0=;
        fh=7aUtyT8zpJGScMHyGjywsrvfXXRZJK3Rofi+q1nz8Gk=;
        b=icdUjzKlLIyLen1pBmYD4nTJ9DttvPJ7+6TwXlxC8VPUgXCzZk1YI0q79QfkLc9X47
         d0ZaAXVt9J4W5I8KK7IdGVJFn5DnFm4ZCCdOdhwu0x0y0NwmSNM1FlqLMyLWA8clL/y3
         9wX+2+mriXFNGsjrfiFgXH7h4dnyFXJ/F5gK/I0dyPtUluGCQmlbN1YkbHN0r7r1hHF3
         WGnQ4+ApjiIEdNu+gmV//6CgEzwUfRfIaUVIPFW0agikbYWN69Qw+icsoVDO4Ccyjr+a
         cisLwWlM4OoX3ZKgFk+ANfbeqcTG2j55Cpk7gochSA+tfqkrtvanSjddjoivxYaFUPu0
         xY3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781512674; x=1782117474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FpQspOt3oBlmx1ICglqJz9lIvpUfboVOloEqqL6E+S0=;
        b=XdMKBo/sBdE/+b1Bg60KNwt740ZXavj9OzKvN17iwQA6zNWPUgcW27QArgIi2nmfFY
         TAduP0VJzOGbNUEyWbto9i8PrRCqFfHFI5ng5XkrOmwfad2At1hLxW8fVBAiOUc4hni6
         gc+uTpcB8wMhDRy/7360sdnguq4qvsDQdi3NWj/llIJMdlPFo6Yd0vRzFefIOdsk7yK4
         8rK5Lj/QmGjKILgmrNTAOer6LeOsmC0LmnQ39xaTPJh9sq2et1w6kWAZN35PZgRTCTV3
         A8PJUItEKHMa5sfFVyNVNHdl6q2Rdxvxw0eS3LpxCDkqUcxvX/X0FuO8ZbMZdhan3Foc
         RyNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781512674; x=1782117474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FpQspOt3oBlmx1ICglqJz9lIvpUfboVOloEqqL6E+S0=;
        b=bKZvuXNw4GHhuOGNcuzLkeNYIx42rKgGUHZHemc4CE0A7LRpGGeyxCJkfjQc1YJPOo
         3rPvhmhfWGauad8L9tGhNNMOmkwTkGpFIeN8kQZI8tdlxnGgmvauWHlNrW4tyqulXey9
         6c1+ff7yBq+llI6woE7EQXwu9p6Uw9dZqV1p0vamg/L49f8oBdvNUvH2bvfBe0Abt1lN
         79flOGrkqLNNcMkC7eEUi/gJuxQK3t7aLHrxELCHBub1sc/qvLKxQdP1d5YjSnkggXeR
         lGPpS91UrLjUgA8Y1gJz8PPaPurZFFhCsA9c4yLg4G5XGW91lRcq5r1o5XeJnWsPkB3D
         sWIw==
X-Gm-Message-State: AOJu0Yxp7WyI3siNnE+45fFfsi038vbYxt1GThuW3Zn1O12VNcH1ysD9
	5jXokdwlJKlIutQLB1uK6GRmNqpw5gXn3zE/C8ibLDz1mjDXkZ7HgNBvXyyPfB0l85IwFbrufCT
	S4emfIHULtBDJsuIZ6gZwGyPdorSSVoIkxQ36vjM=
X-Gm-Gg: Acq92OH0xriTaOJNGBhPsQ13QUs33tRIs/eFycbj27e+kWWLCviAGm/nitLpeh+es1Z
	SxpeMMCNJMLP8/TOYoe+YpnC+PLtdKtQMl7AiVrBDZu/oMn4zgh/5kCGR7Gibi84MdiBtlMCk3u
	tFzr6HRnmFYvSzrEt0o2+ZQ5dSLVV74vYLobNzCOtBJQATBN5jpuJ1qEc9eXDOJdN49uPr7GGkp
	DQ9FTxjHJhm3DRvb9TtG+bD09lNcOrk5ZDa+EykvqF9BgREdZtjLmxne3hhfshO7jxS9jiyEIGG
	0+pTTyCT+ypnqMpWSwTw/uBrDx7YwN7zRFeO99yEEjZkkp4A0w==
X-Received: by 2002:a05:620a:2a15:b0:915:b9f6:71a1 with SMTP id
 af79cd13be357-917f1f4b4fcmr1445280985a.45.1781512673970; Mon, 15 Jun 2026
 01:37:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Paolo Ferraris <paoloferrarisperso@gmail.com>
Date: Mon, 15 Jun 2026 10:37:42 +0200
X-Gm-Features: AVVi8CdNIkSw2jDRK5rfxm4oEMNyllliAxvyxzjlLQaUxh_QzJuI80m1x50uFzU
Message-ID: <CALHCNm8dsuWWYRCsGNa=1ii-Xx=Qeu4LPQ7XfbaPwhwA61zxsw@mail.gmail.com>
Subject: [Feature Request] ath12k: Optimize s2idle wake latency / Implement
 Fast Resume for WCN785x
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, kvalo@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37806-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:kvalo@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[paoloferrarisperso@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paoloferrarisperso@gmail.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A8E05684AD1

Hello ath12k maintainers and developers,
I am writing to respectfully request an optimization for the  ath12k
firmware/driver regarding the resume latency from  s2idle  on modern
Intel platforms.
Hardware Details:
  =E2=80=A2 Laptop: HP Spectre 16 (Intel Meteor Lake Ultra 7 155H)
  =E2=80=A2 Wi-Fi Module: Qualcomm WCN785x Wi-Fi 7 (FastConnect 7800)
  =E2=80=A2 Kernel: Linux 7.0 (Arch Linux)
The Issue
When the laptop resumes from  s2 idle  sleep, the WCN785x takes a
consistent 10 to 15 seconds to establish a connection. Based on  dmesg
 logs, it appears the firmware undergoes a full cold-boot sequence (
fw_version  is re-logged) followed by a lengthy passive regulatory
sweep of the channels before allowing Authentication

Diagnosis & Isolation:
To ensure this was not a motherboard ACPI issue or an Intel PCIe
dropout bug (like the  0xffffffff  ASPM bug seen on some Intel cards),
we physically swapped the Wifi module on this exact same motherboard
to a MediaTek MT7922 (Wi-Fi 6E). The MT7922 resumed and authenticated
almost instantly upon waking from  s2idle . This confirms that the HP
BIOS and the Linux kernel are handling the PCIe wake states correctly,
and the latency is strictly isolated to the  ath12k  firmware
initialization and scanning routine.

Feature Request:
Would it be possible for the Qualcomm firmware team to implement "Scan
Caching" or a "Fast Resume" state for  s2idle  in a future firmware
release? Ideally, allowing the chip to cache the connected AP's
channel before sleep to bypass the massive 15-second passive sweep
upon waking.
Thank you very much for your hard work on the ath12k driver!

Best regards,
Paolo Ferraris

