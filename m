Return-Path: <linux-wireless+bounces-22188-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D00AA0560
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 10:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49F3B16D90F
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 08:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3629127A934;
	Tue, 29 Apr 2025 08:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OaR2C2IF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D20F221737
	for <linux-wireless@vger.kernel.org>; Tue, 29 Apr 2025 08:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745914743; cv=none; b=T/5fEYfuk2RCq+kbJrol5/RPKeFLYbkzWvoC1rahlYWmYp1nhuqR/ye4ujH+KDbbglC1g8EQ9yZ2/CEZ7jShIfKY/GdbG884WROkKoYlnzAlv/LqYsyPJTvZoqCGc3q93L/z5zZBwZSNMNVED+yzhfg9RkmSHcSEfA0LMP/JCjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745914743; c=relaxed/simple;
	bh=fyeAUEwLUYKSRsuVTgiJXl67h2Z0MGSJEx4fLZd4c/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j39sJi280zdndJdtLvjSRZtDwTXJ8kD2sLKrW4P+iDQe1F+Kag2Y+Z+CeeqLOvJd8+ha+0sDlaCi9QNAWUfdhFvhzpaa2ONLvkpy0Gm5gsQcKKoHXhi8Fkzki/JE+JOhjfAi38Mn/QiWfN2fqOY3IlbS4I/Jg56SbYUsp4K0MmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OaR2C2IF; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5ed43460d6bso8430808a12.0
        for <linux-wireless@vger.kernel.org>; Tue, 29 Apr 2025 01:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745914740; x=1746519540; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WbzJw1Y0dP0F/OzgjAdJU3vqXnQX132JQqwwW18Z+U8=;
        b=OaR2C2IF1IjvmhLFbfcgdJ68GzzneeJzf5kEuEkXzdlwAg9zonUjWDkuaTLjbzhh+S
         IP/f02vuYHY+wdu5IOarbjdjmvVPKg/+tG+nAvybyjTxa6fzmyfepgjiqAPpWqFJCPsu
         wRqvqO9P1FoBFRhPeFaQ7oKgmuHOzA1CY5/0Z/8TwU4/s1cwcCoahMj0/vhkp5SngXkZ
         7TDA6amJznESTTTzs0xKNo+TumS2LOkBBLcvWVJ+Cyaoomnb2/dPleQKmyZdrsN3SWyP
         b1ROruw88d7emzPwXhpGyXH+mR++vJDNvDoEg2BvH+NHPn3/vFVGL1RYsUpORpOecPtu
         I1Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745914740; x=1746519540;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WbzJw1Y0dP0F/OzgjAdJU3vqXnQX132JQqwwW18Z+U8=;
        b=XzEXs8Ns0mz5Ki5wp9mn/Q8QNIEzzwpqHjs+S0GD/jvt8FGoXsdGk0q4bcF40rGxsX
         mGjjb6X6TdJHH3Oy9U5v2voeyocwESAQ/KyNZ04Iq1urXXQla+a+MCRFECIdT2omHAfM
         wkmGU3jgyFBbhf8q5RaVpe1dFvg020cERpeMRR31XL/IuUZ0PVDZZB0tpKcNpSPBRGV9
         tyhmaMxadYd6Ct8T47i7CNB8xc3zbPKxdLsvncNftSt8cuEmvbItqG4QvagyTMcBHOPM
         fKU0txRLB1oS8Y6aOi2lP8L/dT1rF64PfWWCIWJRj8Et8139Q8AN7NnhdKubEGFDtv0o
         WBxA==
X-Forwarded-Encrypted: i=1; AJvYcCUy93+QLL87zwSE6oC93OvIIXbHiIDYDD3JaUMoDwGvDfBgpKNDS1LDPBKg3xT6pwsywkcxGdWhBYMs+42CCA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzL9mtKkczOhhnSpCgD4IRDOGmOVKYcGSzk6oViUqFC5cIOQGB0
	clcB9c2nZErzMVkZBVcRU4zeek8X0gDjMk4dmv0I45/9Gbu7OsxXZBRyzPEgEb9bm7KAQD+evq1
	xpVRFpCpX8rbeC5XwMlCdgvhNHso=
X-Gm-Gg: ASbGncvkAoqQkMOzaURUnZVOwlhT+9pn6ypUBvh6UDCKcvTcmhiTUiWg3txmJTD2NCv
	fGqF8cVb6m3YJsoPqJOWE5w1mJ2/0bIZx7uBEmNn0SFCH54or1skU6uKl5dIKf7PW3zs7E1MEru
	tQTubNb1igNZ37M+yhmn/eCYPKM69kj712UKwsZVd18IEfGiOo0sAZLKU=
X-Google-Smtp-Source: AGHT+IETjecjzVnvadBYjwmWixpUnfb/F7xiEGuxsW17ElaZNjEcgdGuUSRHEcq7Si4m5JfkqrurgMcBvTS3eMngTo0=
X-Received: by 2002:a05:6402:3513:b0:5e4:99af:b7c with SMTP id
 4fb4d7f45d1cf-5f83884a96cmr2119205a12.9.1745914739430; Tue, 29 Apr 2025
 01:18:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250425085519.492267-1-arend.vanspriel@broadcom.com>
 <CALeDE9MGXiSN=8E+T_ZGOLHsk8DB4iL=hV7ircqqb9=q1xTUYw@mail.gmail.com> <1967fbdeea0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <1967fbdeea0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Tue, 29 Apr 2025 09:18:47 +0100
X-Gm-Features: ATxdqUEJ0d1PPV6nWd6qlInI1IYFadSUjgxjpfVfwgK-s7SH_A3ESsBFyzAcJC0
Message-ID: <CALeDE9ONCUH0pQ4Yux=30Lim_SZMcbQsnWx0R+aPhF0E7tf9=g@mail.gmail.com>
Subject: Re: [PATCH wireless-next v3 0/4] wifi: brcmfmac: external auth
 support for Infineon devices
To: Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org, 
	brcm80211@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

> > I will try and find a couple of other devices with an appropriate
> > cypress/infineon.
>
> Thanks for giving the patches a spin. The firmware should have a feature
> named sae_ext. I think the one you with iw are indicating same support in
> general.

I am not so sure.

RPi4 (BCM4345/6 - 7.45.234 (4ca95bb CY) FWID 01-996384e2)
        Supported extended features:
                * [ CQM_RSSI_LIST ]: multiple CQM_RSSI_THOLD records
                * [ 4WAY_HANDSHAKE_STA_PSK ]: 4-way handshake with PSK
in station mode
                * [ 4WAY_HANDSHAKE_STA_1X ]: 4-way handshake with
802.1X in station mode
                * [ DFS_OFFLOAD ]: DFS offload
                * [ SAE_OFFLOAD ]: SAE offload support
                * [ 4WAY_HANDSHAKE_AP_PSK ]: AP mode PSK offload support
                * [ SAE_OFFLOAD_AP ]: AP mode SAE authentication offload support

Jetson TX1 (BCM4354/1 - fw 7.35.349.104 (775a9ab CY) FWID 01-d55901b0):
        Supported extended features:
                * [ CQM_RSSI_LIST ]: multiple CQM_RSSI_THOLD records
                * [ DFS_OFFLOAD ]: DFS offload

So I have different brcmfmac HW reporting different features.

> You can check the firmware features in debugfs under
> <mount>/ieee80211/phyX/fwcap.

I don't get fwcap on either of the above devices:

ls /sys/kernel/debug/ieee80211/phy0/
fragmentation_threshold  ht40allow_map  long_retry_limit
rts_threshold  short_retry_limit

Peter

Peter

