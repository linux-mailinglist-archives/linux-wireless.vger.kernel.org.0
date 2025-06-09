Return-Path: <linux-wireless+bounces-23906-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78AF9AD26F4
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 21:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB3B07A9AE7
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 19:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9867B155A25;
	Mon,  9 Jun 2025 19:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ti0RjYMP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1480821E082
	for <linux-wireless@vger.kernel.org>; Mon,  9 Jun 2025 19:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749498165; cv=none; b=SaUtT0t43z9J5Qo8218Vm3hVx2U5aSNFe5M9UjVt+mMI/sYed2NLEz3k9qfqQAZHs9Me9X+uKGj/cBSa3PCTGPYDfUxGXyAw1uFriaJzCxSPWhiuKM4CMZXnPYUWm0H0kgvp46voiJzx4ftQuRQQbD4CLwLo4eWIaig9o2W7dfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749498165; c=relaxed/simple;
	bh=A5qZejXgYhDbWfxjhrhDV+dglLLl8N+6OuuSx3j8hho=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Ke0SEzJxOuro4eRGiIezUjL5a33rDaFNjqyPZvhsdA4GKYZ1h4VlwuScXC9tqzO74gq4jcITjRrK9+cLIY0Q5IzJhtcXryZPaItgz6B+rV7hpjX5v1goC+Vl8wmeKSYakFoyW68HbHdDBDax+aOnWPGNBmnoCG70/fiV0V0w9oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ti0RjYMP; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e73e9e18556so4465089276.0
        for <linux-wireless@vger.kernel.org>; Mon, 09 Jun 2025 12:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749498163; x=1750102963; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6Zf0suIXK7l9tUj4sDwSEuq16I7VSWcqaNo380WkrMA=;
        b=Ti0RjYMPFDOrHVLKhCdcdMHF5g6UBqfzuCmkXN4CF9hkQ1QaV9PEQvNga/l6sR0bdW
         tZY1sBbdhzIlO3gJJdYSc1yfx7fO1Z8wtSbCBaBuz9XxQWEAuaHtE4bu3cjln+Jt5tFW
         XdPEEfudMUGYBg14pb50qeI3PCo9cVBWS4asYxtIj65nU/aTzgqAPIVzMb7Ui177y5C9
         QPPUoqRKPaMFrTPzmz3Yi7jg/ScbrYcBlktHL275hQUx/keXeSridxt0D15o6XKqKpnk
         eEgUglWChkS98O6tc1xbtS1v1r3edBzBO6sg/WLErkf97uiaaCg8ceT+G4nq9HjcP3+6
         HPxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749498163; x=1750102963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Zf0suIXK7l9tUj4sDwSEuq16I7VSWcqaNo380WkrMA=;
        b=HFh7/SCByykiFCJRgwsMapND0v85MccKtZwd5DOp492U2HGaQLSE5XjbBbY3MzcQ3u
         IKwcvaceK4kZwV8tPFHMXkBTssRift8MhoUs1tPs4XzC3MrKhgB9ZkcPAE1Jn28O0ekZ
         F/cMTCD9SpYWfYkRMkXu0XSopfdp1dxT7HvGyi6DP/aa43Nx5HDiLjsETsj34Eedha/j
         2hzButmvE8R9mE4vuB6G6jwsIt6lx5mslqLTGfHIrGiC0NjrRrvWxUZekmSNj2gc/MYB
         s2UScD1zQPbwRUDfLwsu4VLMtac9Doqr4s5L/VlqkSk0gENqRm9jt07vAnYHCwT9uaIj
         gz3g==
X-Forwarded-Encrypted: i=1; AJvYcCUm1YqRcBsBW+le8b2KLiHglbcoTrfAPPUljp9bSWs7sXQfB6YB7Zuz6s/o5+cFmRr8FZfddIM1nTln9gja6Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzOP1QW5NC2LQWuPfhZUyI5Kkgi37K7TuSJt4xKUmFW0KOd+h5v
	/c6kCqJc/X2kM523sjVn/tZrmN+sQ5Qz6abvSwudkaxmoIUuPHFBrEP00TiMWUP7ZLkougfNqZz
	64A3uddLQ5KK2V16dTVQkLDKA6hWdmYM=
X-Gm-Gg: ASbGncuW88EArGx2OOibo0qb1LGSmE7ZY94fcvYJeH9ImzlJlaZJ0Z1U+xZ/eRXUd6o
	odmQtHjbcptURQsxXvFDfLMxxjvYAELZDy6hOBmkJ09Z2SKBfmWTr5J6efLGIH6ut0+1uvEhQqK
	P+tMd2lFBF1fVdi3GiEprjiXoeG+JNb4mcA9E=
X-Google-Smtp-Source: AGHT+IGiPRCBM71VlQZOqTkUdEvQLPtmrUYm9pvIz+jXqH+F6YtTl/PJKJkt0Yyz/XT6RBuIerdS2+/IBq7VCwvYPo8=
X-Received: by 2002:a05:6902:1682:b0:e7d:7963:941 with SMTP id
 3f1490d57ef6-e81f07b27bamr1310375276.16.1749498162877; Mon, 09 Jun 2025
 12:42:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: KeithG <ys3al35l@gmail.com>
Date: Mon, 9 Jun 2025 14:42:32 -0500
X-Gm-Features: AX0GCFsFLqM9dk08aKYpOa2H33M-oI2qV2wz2gFfGA6FutHHd1sklEtKD6O6Xwo
Message-ID: <CAG17S_P0WmE4o3wCbi4Pq0j28C-HUZHwGJXzurTME4TsgYLQOQ@mail.gmail.com>
Subject: wpa_supplicant floods the log with scan error
To: brcm80211@lists.linux.dev, linux-wireless@vger.kernel.org
Cc: Arend Van Spriel <arend.vanspriel@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I am using wpa_supplicant on RPiOS with the laterst kerenel 6.12.x
I have wpa_supplicant set up systemd service 'wpa_supplicnat@wlan0'
and use wpa_cli to manage the known networks. I use systemd-networkd
to manage DHCP and such. When the RPi is not connected to a wireless
SSID, I get tons of this in the log:
Jun 09 14:29:56 rpi wpa_supplicant[420]: wlan0: Failed to initiate sched sc=
an
Jun 09 14:30:03 rpi wpa_supplicant[420]: wlan0: Failed to initiate sched sc=
an
Jun 09 14:30:10 rpi wpa_supplicant[420]: wlan0: Failed to initiate sched sc=
an
Jun 09 14:30:16 rpi wpa_supplicant[420]: wlan0: Failed to initiate sched sc=
an
Jun 09 14:30:22 rpi wpa_supplicant[420]: wlan0: Failed to initiate sched sc=
an
Jun 09 14:30:29 rpi wpa_supplicant[420]: wlan0: Failed to initiate sched sc=
an
Jun 09 14:30:35 rpi wpa_supplicant[420]: wlan0: Failed to initiate sched sc=
an
Jun 09 14:30:41 rpi wpa_supplicant[420]: wlan0: Failed to initiate sched sc=
an
Jun 09 14:30:47 rpi wpa_supplicant[420]: wlan0: Failed to initiate sched sc=
an

It repeats about every 6 seconds. I know it is scanning, because when
my known SSID reappears, it connects, so it *is* scanning.

My wpa_supplicant@wlan0 config has not much in it:

# cat /etc/wpa_supplicant/wpa_supplicant-wlan0.conf
ctrl_interface=3D/run/wpa_supplicant
update_config=3D1

network=3D{
        ssid=3D"KnownSSID"
        psk=3D"password"
        mesh_fwding=3D1
}

the service is using the default, debian 'wpa_supplicant@.service'
that comes with RPiOS and uses my config shown above.# systemctl
status wpa_supplicant@wlan0.service
=E2=97=8F wpa_supplicant@wlan0.service - WPA supplicant daemon
(interface-specific version)
     Loaded: loaded (/lib/systemd/system/wpa_supplicant@.service;
enabled; preset: enabled)
     Active: active (running) since Mon 2025-06-09 11:24:42 CDT; 3h 6min ag=
o
   Main PID: 420 (wpa_supplicant)
      Tasks: 1 (limit: 1654)
        CPU: 6.727s
     CGroup: /system.slice/system-wpa_supplicant.slice/wpa_supplicant@wlan0=
.service
             =E2=94=94=E2=94=80420 /sbin/wpa_supplicant
-c/etc/wpa_supplicant/wpa_supplicant-wlan0.conf -iwlan0

the base wpa_supplicant.service is not running.

I have this in my brcmfmac.conf under /etc/modprobe.d/

options brcmfmac feature_disable=3D0x200000

Is there something I can do to keep this from flooding the log?

Keith

