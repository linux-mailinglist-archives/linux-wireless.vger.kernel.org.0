Return-Path: <linux-wireless+bounces-27751-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1096BAD154
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Sep 2025 15:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5669D3A135D
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Sep 2025 13:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E661DFD8B;
	Tue, 30 Sep 2025 13:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYdaWFeE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118CB269CE1
	for <linux-wireless@vger.kernel.org>; Tue, 30 Sep 2025 13:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759239314; cv=none; b=T8EiWHMv6LSvUZm0in0r/RNIO6blyS1nAWuPWY/5AcJzSngbzeG6F+dnWkdQXnExPntabBWzTizibAvSOSXSxu+w2d2zYgEARJLM4JPdSdesC7h2MgF0/MeZkIwA7LLeo0clCUSBGWbLQrpSMFgB8pOliU07gNsv30F2L8GwJOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759239314; c=relaxed/simple;
	bh=wZ+ef0N7HPwr2CTVfNTgcm9iAGQDKeFdF4gb1mQFyBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fGoM8tJ/plOYTZmB1DGQ6imHzebQR1NipYhAzBnBTz2lwd0S4xXP0D5g9lkt9nPpIXjcOsGkFSltE48P8vCckuQABq7xBG7/Z3Unyyv7HJbr5z5MJFP1fzSi+79mwmTpVd/qQKdpspFT+EMIpT3uh4ah7TdESsFGuhvjMV6vkOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BYdaWFeE; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-855733c47baso840493985a.0
        for <linux-wireless@vger.kernel.org>; Tue, 30 Sep 2025 06:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759239310; x=1759844110; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XY9lCLXBcQRVW3P645odqE/nmJoloK6t/4kDtYkchtA=;
        b=BYdaWFeEg/HNCrNBBP5jVrz9TmMiXuw5t+jp/B8iZPvOG/lNTdqRLJPWIDeZjos+NB
         uW8Z12zZDp0T7yNGrKuJUUwqHzGnI4NMGmlvSSQI1TLaKePWb9UCGRCS6Q7spB0WDoIE
         NGvrgGexF1/UEs9fXG4kobfvVebwAjmCIngq9jemj+/jS82aHZy2Sbgk1RE9+1ZIZVYM
         C0z1op+vMKWsFZ3LAJl/2KjxvwRadtv5I3HliH3IKfKRGLBlmQXFFmVxThJorS5TGUeQ
         Z5N9DrTi+XgPl3ltZFh8Duwr84jLOCrBPcb2tJcnOhHida+IjgdVSVoxnCl1fgiMK4P7
         Fahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759239310; x=1759844110;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XY9lCLXBcQRVW3P645odqE/nmJoloK6t/4kDtYkchtA=;
        b=sE1vx71dzXX4J6P/oKZCwakif7bMLBZUABZH61eVBwhO6SUoNg/SEkmWXusNb+R29s
         avnPsTy8Y/tkmHyW/xg6m8JACxIu8H5L0mTeniK7B2/iINa3+pJ9RmIrdis9BZJH/+ll
         Y5nBJa7je5R5Jke2cdTgG9K7AXawaXr+r8RJB+0Ek/kzTVaczku2WaevdWoPRafYiJZb
         xEtIKminHca4jKlJNwOAaE7FHpc0QpCBNrTa6BWIvqLN6c6MBcO9KkJ4NTI9dBnmYWdj
         Sn+aJa3cMzpxVw7tsnR1L+iN5cyGd8OoIOATti2RlXOaO3iHI1pL1FMxocCUMhDLy1Xh
         9+eQ==
X-Gm-Message-State: AOJu0YxPYz2Kgvk+KXa3yXPcJ0WboL2nTGDdzNT1L7VZFSpW8EvH9mUS
	WTQwPqu3y8z2FyhGAHkhUVkeb4c6iRZcybhwV4fz45a8As7qyAs0y9WXogGRap++oPpTtVBa44z
	vgGyi430q5h+z+iyOxF6Ot/n1ZTbjqVFzK7Ws
X-Gm-Gg: ASbGncuVk+UbKjfWLJh9A7//A3i7CTVGf2lbfFD9X5L51Ee/lfNnRcUi4zm3iqrX31J
	Ht0t5gRr/q4UkmQGTnJwWnNc0y0vJ8cG5ewCd2odNtYNHsWI8jRQJI/3vH0HCfRkvVr8ryqmdWW
	MGXBSj8AHCYtqoZpMQpC3t9LobY7VUvUz3JQ3neb/qsMd4/dErrlhyoWMmt2LI1rA4b2hVrdSI9
	ZINxg5/1d6HLLG+Vk586TIc3Kto3jukD244GNQ=
X-Google-Smtp-Source: AGHT+IGqmKFzOawiDa8nMrtlCqgJg7nxz7hxeWwx9lHHEw24vm8JcT835PwqKbJN2m6fBmCC7n+8skIWTwJ3kJIx7gg=
X-Received: by 2002:a05:6214:262c:b0:795:7af3:6ffb with SMTP id
 6a1803df08f44-7fc439506a6mr288728946d6.63.1759239307923; Tue, 30 Sep 2025
 06:35:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFXXzTbHabF2hZKWM=RquQXB_tFq-24SPifnyL9ZA5-HL30X1A@mail.gmail.com>
 <76fa4cd8d3598c771f5e1c8bb305c241907edc77.camel@sipsolutions.net>
In-Reply-To: <76fa4cd8d3598c771f5e1c8bb305c241907edc77.camel@sipsolutions.net>
From: Francesco Bergesio <francescobergesio1@gmail.com>
Date: Tue, 30 Sep 2025 15:34:55 +0200
X-Gm-Features: AS18NWBdchHCSNq7zZbmYN4aEWdDqmB9PxNgF3zx_-mhIXgGlxqAtq_YGBGrMVc
Message-ID: <CAFXXzTZD3Wfywo2Mug8=3TrV2b0hsFSMERyd8YpzUgnBzP4uDA@mail.gmail.com>
Subject: Re: [Bug Report] Intel AX1775 / AX1790 / BE20 / BE401 / BE1750 2x2
 (Wi-Fi 7) fails to resume after suspend (s2idle)
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,
The only feedback in DE is the icon not connected and wireless active
but no network visible. I disabled the power save settings, restarted
the driver iwlwifi.

iwconfig
lo        no wireless extensions.

enp45s0   no wireless extensions.

docker0   no wireless extensions.

br-3558f493dc1a  no wireless extensions.

wlp44s0f0  no wireless extensions.

nmcli device
DEVICE           TYPE      STATE                   CONNECTION
lo               loopback  connected (externally)  lo
br-3558f493dc1a  bridge    connected (externally)  br-3558f493dc1a
docker0          bridge    connected (externally)  docker0
wlp44s0f0        wifi      disconnected            --
enp45s0          ethernet  unavailable             --

cat /sys/bus/pci/devices/0000\:2c\:00.0/power/control
on

after nmcli connection up 77cb0111-a245-41ea-884e-ad5b8234fd15 ifname wlp44s0f0
in DE it shows connecting icon and the SSID (only  that network), but
it doesn't connect

network manager log
set 30 15:15:48 linux-Stealth-16-AI-Studio-A1VGG
NetworkManager[209395]: <info>  [1759238148.2557] agent-manager:
agent[21145e3eacd428e7,:1.3854/nmcli-connect/1000]: agent registered
set 30 15:15:48 linux-Stealth-16-AI-Studio-A1VGG
NetworkManager[209395]: <info>  [1759238148.2575] device (wlp44s0f0):
Activation: starting connection 'Auto TP-Link_5982'
(77cb0111-a245-41ea-884e-ad5b8234fd15)
set 30 15:15:48 linux-Stealth-16-AI-Studio-A1VGG
NetworkManager[209395]: <info>  [1759238148.2575] audit:
op="connection-activate" uuid="77cb0111-a245-41ea-884e-ad5b8234fd15"
name="Auto TP-Link_5982" pid=214789 uid=1000 result="success"
set 30 15:15:48 linux-Stealth-16-AI-Studio-A1VGG
NetworkManager[209395]: <info>  [1759238148.2575] device (wlp44s0f0):
state change: disconnected -> prepare (reason 'none', sys-iface-state:
'managed')
set 30 15:15:48 linux-Stealth-16-AI-Studio-A1VGG
NetworkManager[209395]: <info>  [1759238148.2576] manager:
NetworkManager state is now CONNECTING
set 30 15:15:48 linux-Stealth-16-AI-Studio-A1VGG
NetworkManager[209395]: <info>  [1759238148.2578] device (wlp44s0f0):
state change: prepare -> config (reason 'none', sys-iface-state:
'managed')
set 30 15:15:48 linux-Stealth-16-AI-Studio-A1VGG
NetworkManager[209395]: <info>  [1759238148.2579] device (wlp44s0f0):
Activation: (wifi) access point 'Auto TP-Link_5982' has security, but
secrets are required.
set 30 15:15:48 linux-Stealth-16-AI-Studio-A1VGG
NetworkManager[209395]: <info>  [1759238148.2579] device (wlp44s0f0):
state change: config -> need-auth (reason 'none', sys-iface-state:
'managed')
set 30 15:15:48 linux-Stealth-16-AI-Studio-A1VGG
NetworkManager[209395]: <info>  [1759238148.2582] device (wlp44s0f0):
state change: need-auth -> prepare (reason 'none', sys-iface-state:
'managed')
set 30 15:15:48 linux-Stealth-16-AI-Studio-A1VGG
NetworkManager[209395]: <info>  [1759238148.2582] device (wlp44s0f0):
state change: prepare -> config (reason 'none', sys-iface-state:
'managed')
set 30 15:15:48 linux-Stealth-16-AI-Studio-A1VGG
NetworkManager[209395]: <info>  [1759238148.2583] device (wlp44s0f0):
Activation: (wifi) connection 'Auto TP-Link_5982' has security, and
secrets exist.  No new secrets needed.
set 30 15:15:48 linux-Stealth-16-AI-Studio-A1VGG
NetworkManager[209395]: <info>  [1759238148.2601] Config: added 'ssid'
value 'TP-Link_5982'
set 30 15:15:48 linux-Stealth-16-AI-Studio-A1VGG
NetworkManager[209395]: <info>  [1759238148.2601] Config: added
'scan_ssid' value '1'
set 30 15:15:48 linux-Stealth-16-AI-Studio-A1VGG
NetworkManager[209395]: <info>  [1759238148.2602] Config: added
'bgscan' value 'simple:30:-65:300'
set 30 15:15:48 linux-Stealth-16-AI-Studio-A1VGG
NetworkManager[209395]: <info>  [1759238148.2602] Config: added
'key_mgmt' value 'WPA-PSK WPA-PSK-SHA256'
set 30 15:15:48 linux-Stealth-16-AI-Studio-A1VGG
NetworkManager[209395]: <info>  [1759238148.2602] Config: added
'auth_alg' value 'OPEN'
set 30 15:15:48 linux-Stealth-16-AI-Studio-A1VGG
NetworkManager[209395]: <info>  [1759238148.2602] Config: added 'psk'
value '<hidden>'
set 30 15:16:13 linux-Stealth-16-AI-Studio-A1VGG
NetworkManager[209395]: <warn>  [1759238173.6185] device (wlp44s0f0):
Activation: (wifi) association took too long, failing activation
set 30 15:16:13 linux-Stealth-16-AI-Studio-A1VGG
NetworkManager[209395]: <info>  [1759238173.6186] device (wlp44s0f0):
state change: config -> failed (reason 'ssid-not-found',
sys-iface-state: 'managed')
set 30 15:16:13 linux-Stealth-16-AI-Studio-A1VGG
NetworkManager[209395]: <info>  [1759238173.6190] manager:
NetworkManager state is now DISCONNECTED
set 30 15:16:13 linux-Stealth-16-AI-Studio-A1VGG
NetworkManager[209395]: <warn>  [1759238173.6193] device (wlp44s0f0):
Activation: failed for connection 'Auto TP-Link_5982'
set 30 15:16:13 linux-Stealth-16-AI-Studio-A1VGG
NetworkManager[209395]: <info>  [1759238173.6195] device (wlp44s0f0):
state change: failed -> disconnected (reason 'none', sys-iface-state:
'managed')
set 30 15:16:14 linux-Stealth-16-AI-Studio-A1VGG
NetworkManager[209395]: <info>  [1759238174.3019] device (wlp44s0f0):
supplicant interface state: disconnected -> inactive


These are wpa-supplicant log (with journalctl -u wpa-supplicant) when resumed
set 30 14:48:36 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-DISCONNECTED bssid=84:d8:1b:70:59:82 reason=3
locally_generated=1
set 30 14:48:36 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-DSCP-POLICY clear_all
set 30 14:48:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
p2p-dev-wlp44s0: CTRL-EVENT-DSCP-POLICY clear_all
set 30 14:48:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
p2p-dev-wlp44s0: CTRL-EVENT-DSCP-POLICY clear_all
set 30 14:48:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
nl80211: deinit ifname=p2p-dev-wlp44s0 disabled_11b_rates=0
set 30 14:48:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-DSCP-POLICY clear_all
set 30 14:48:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-DSCP-POLICY clear_all
set 30 14:48:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
nl80211: deinit ifname=wlp44s0f0 disabled_11b_rates=0
set 30 14:48:42 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
nl80211: deinit ifname=wlp44s0f0 disabled_11b_rates=0
set 30 14:48:42 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWMODE]: Operation not supported
set 30 14:48:42 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCGIWRANGE]: Operation not supported
set 30 14:48:42 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCGIWMODE]: Operation not supported
set 30 14:48:42 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWAP]: Operation not supported
set 30 14:48:42 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWESSID]: Operation not supported
set 30 14:48:42 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWENCODEEXT]: Operation not supported
set 30 14:48:42 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWENCODE]: Operation not supported
set 30 14:48:42 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWENCODEEXT]: Operation not supported
set 30 14:48:42 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWENCODE]: Operation not supported
set 30 14:48:42 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWENCODEEXT]: Operation not supported
set 30 14:48:42 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWENCODE]: Operation not supported
set 30 14:48:42 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWENCODEEXT]: Operation not supported
set 30 14:48:42 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWENCODE]: Operation not supported
set 30 14:48:42 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWENCODEEXT]: Operation not supported
set 30 14:48:42 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWENCODE]: Operation not supported
set 30 14:48:42 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWENCODEEXT]: Operation not supported
set 30 14:48:42 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWENCODE]: Operation not supported
set 30 14:48:42 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
dbus: fill_dict_with_properties
dbus_interface=fi.w1.wpa_supplicant1.Interface.P2PDevice
dbus_property=P2PDeviceConfig getter failed
set 30 14:48:42 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 14:48:42 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
set 30 14:48:46 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 14:48:46 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
set 30 14:48:51 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 14:48:51 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
set 30 14:48:58 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 14:48:58 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
set 30 14:49:08 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCGIWSCAN]: Operation not supported
set 30 14:49:08 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 14:49:08 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
set 30 14:49:18 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCGIWSCAN]: Operation not supported
set 30 14:49:22 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 14:49:22 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
set 30 14:49:32 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCGIWSCAN]: Operation not supported
set 30 14:49:42 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 14:49:42 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
set 30 14:49:52 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCGIWSCAN]: Operation not supported
set 30 14:50:11 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 14:50:11 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
set 30 14:50:21 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCGIWSCAN]: Operation not supported
set 30 14:50:54 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 14:50:54 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
set 30 14:51:04 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCGIWSCAN]: Operation not supported
set 30 14:51:58 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 14:51:58 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
set 30 14:52:08 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCGIWSCAN]: Operation not supported
set 30 14:52:38 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 14:52:38 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
set 30 14:52:48 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCGIWSCAN]: Operation not supported
set 30 14:52:55 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 14:52:55 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
set 30 14:53:05 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCGIWSCAN]: Operation not supported
set 30 14:53:33 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 14:53:33 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
set 30 14:53:35 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 14:53:35 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
set 30 14:53:45 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCGIWSCAN]: Operation not supported
set 30 14:55:33 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 14:55:33 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
set 30 14:55:43 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCGIWSCAN]: Operation not supported
set 30 14:57:34 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 14:57:34 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
set 30 14:57:44 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCGIWSCAN]: Operation not supported
set 30 14:58:50 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 14:58:50 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
set 30 14:59:00 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCGIWSCAN]: Operation not supported
set 30 14:59:05 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 14:59:05 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
set 30 14:59:15 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCGIWSCAN]: Operation not supported
set 30 14:59:35 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 14:59:35 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
set 30 14:59:45 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCGIWSCAN]: Operation not supported
set 30 15:01:36 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:01:36 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
set 30 15:01:46 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCGIWSCAN]: Operation not supported
set 30 15:03:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:03:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
set 30 15:03:47 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCGIWSCAN]: Operation not supported
set 30 15:05:38 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:05:38 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
set 30 15:05:48 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCGIWSCAN]: Operation not supported
set 30 15:06:16 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-DSCP-POLICY clear_all
set 30 15:06:16 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-DSCP-POLICY clear_all
set 30 15:06:16 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCGIWMODE]: Operation not supported
set 30 15:06:16 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWAP]: Operation not supported
set 30 15:06:16 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWESSID]: Operation not supported
set 30 15:06:17 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
nl80211: deinit ifname=wlp44s0f0 disabled_11b_rates=0
set 30 15:06:17 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWMODE]: Operation not supported
set 30 15:06:17 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCGIWRANGE]: Operation not supported
set 30 15:06:17 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCGIWMODE]: Operation not supported
set 30 15:06:17 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWAP]: Operation not supported
set 30 15:06:17 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWESSID]: Operation not supported
set 30 15:06:17 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWENCODEEXT]: Operation not supported
set 30 15:06:17 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWENCODE]: Operation not supported
set 30 15:06:17 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWENCODEEXT]: Operation not supported
set 30 15:06:17 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWENCODE]: Operation not supported
set 30 15:06:17 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWENCODEEXT]: Operation not supported
set 30 15:06:17 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWENCODE]: Operation not supported
set 30 15:06:17 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWENCODEEXT]: Operation not supported
set 30 15:06:17 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWENCODE]: Operation not supported
set 30 15:06:17 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWENCODEEXT]: Operation not supported
set 30 15:06:17 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWENCODE]: Operation not supported
set 30 15:06:17 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWENCODEEXT]: Operation not supported
set 30 15:06:17 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWENCODE]: Operation not supported
set 30 15:06:17 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
dbus: fill_dict_with_properties
dbus_interface=fi.w1.wpa_supplicant1.Interface.P2PDevice
dbus_property=P2PDeviceConfig getter failed
set 30 15:06:17 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:06:17 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
set 30 15:06:20 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:06:20 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
set 30 15:06:22 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:06:22 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
set 30 15:06:26 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:06:26 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
set 30 15:06:33 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:06:33 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
set 30 15:06:43 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCGIWSCAN]: Operation not supported
set 30 15:06:43 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:06:43 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
set 30 15:06:53 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCGIWSCAN]: Operation not supported
set 30 15:06:57 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:06:57 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
set 30 15:07:07 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCGIWSCAN]: Operation not supported
set 30 15:07:17 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:07:17 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
set 30 15:07:27 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCGIWSCAN]: Operation not supported
set 30 15:07:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-DSCP-POLICY clear_all
set 30 15:07:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-DSCP-POLICY clear_all
set 30 15:07:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCGIWMODE]: Operation not supported
set 30 15:07:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWAP]: Operation not supported
set 30 15:07:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWESSID]: Operation not supported
set 30 15:07:34 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
nl80211: deinit ifname=wlp44s0f0 disabled_11b_rates=0
set 30 15:07:34 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWMODE]: Operation not supported
set 30 15:07:34 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCGIWRANGE]: Operation not supported
set 30 15:07:34 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCGIWMODE]: Operation not supported
set 30 15:07:34 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWAP]: Operation not supported
set 30 15:07:34 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWESSID]: Operation not supported
set 30 15:07:34 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWENCODEEXT]: Operation not supported
set 30 15:07:34 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWENCODE]: Operation not supported
set 30 15:07:34 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWENCODEEXT]: Operation not supported
set 30 15:07:34 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWENCODE]: Operation not supported
set 30 15:07:34 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWENCODEEXT]: Operation not supported
set 30 15:07:34 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWENCODE]: Operation not supported
set 30 15:07:34 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWENCODEEXT]: Operation not supported
set 30 15:07:34 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWENCODE]: Operation not supported
set 30 15:07:34 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWENCODEEXT]: Operation not supported
set 30 15:07:34 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWENCODE]: Operation not supported
set 30 15:07:34 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWENCODEEXT]: Operation not supported
set 30 15:07:34 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWENCODE]: Operation not supported
set 30 15:07:34 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
dbus: fill_dict_with_properties
dbus_interface=fi.w1.wpa_supplicant1.Interface.P2PDevice
dbus_property=P2PDeviceConfig getter failed
set 30 15:07:34 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:07:34 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
set 30 15:07:38 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:07:38 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
set 30 15:07:43 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:07:43 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
set 30 15:07:50 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:07:50 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
set 30 15:08:00 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCGIWSCAN]: Operation not supported
set 30 15:08:00 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:08:00 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
set 30 15:08:10 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCGIWSCAN]: Operation not supported
set 30 15:08:14 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:08:14 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
set 30 15:08:24 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCGIWSCAN]: Operation not supported
set 30 15:08:26 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: Driver does not support AP mode
set 30 15:08:51 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-DSCP-POLICY clear_all
set 30 15:08:51 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:08:51 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
set 30 15:08:52 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:08:52 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
set 30 15:08:55 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:08:55 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
set 30 15:08:57 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:08:57 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
set 30 15:08:59 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:08:59 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
set 30 15:09:06 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:09:06 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
set 30 15:09:16 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCGIWSCAN]: Operation not supported
set 30 15:09:16 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:09:16 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
set 30 15:09:26 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCGIWSCAN]: Operation not supported
set 30 15:09:30 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:09:30 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
set 30 15:09:33 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-DSCP-POLICY clear_all
set 30 15:09:34 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-DSCP-POLICY clear_all
set 30 15:09:34 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCGIWMODE]: Operation not supported
set 30 15:09:34 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWAP]: Operation not supported
set 30 15:09:34 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWESSID]: Operation not supported
set 30 15:09:34 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
nl80211: deinit ifname=wlp44s0f0 disabled_11b_rates=0
set 30 15:09:34 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWMODE]: Operation not supported
set 30 15:09:34 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCGIWRANGE]: Operation not supported
set 30 15:09:34 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCGIWMODE]: Operation not supported
set 30 15:09:34 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWAP]: Operation not supported
set 30 15:09:34 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWESSID]: Operation not supported
set 30 15:09:34 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWENCODEEXT]: Operation not supported
set 30 15:09:34 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWENCODE]: Operation not supported
set 30 15:09:34 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWENCODEEXT]: Operation not supported
set 30 15:09:34 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWENCODE]: Operation not supported
set 30 15:09:34 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWENCODEEXT]: Operation not supported
set 30 15:09:34 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWENCODE]: Operation not supported
set 30 15:09:34 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWENCODEEXT]: Operation not supported
set 30 15:09:34 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWENCODE]: Operation not supported
set 30 15:09:34 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWENCODEEXT]: Operation not supported
set 30 15:09:34 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWENCODE]: Operation not supported
set 30 15:09:34 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWENCODEEXT]: Operation not supported
set 30 15:09:34 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWENCODE]: Operation not supported
set 30 15:09:34 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
dbus: fill_dict_with_properties
dbus_interface=fi.w1.wpa_supplicant1.Interface.P2PDevice
dbus_property=P2PDeviceConfig getter failed
set 30 15:09:34 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:09:34 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
set 30 15:09:38 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:09:38 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
set 30 15:09:43 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:09:43 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
set 30 15:09:50 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:09:50 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
set 30 15:10:00 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCGIWSCAN]: Operation not supported
set 30 15:10:00 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:10:00 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
set 30 15:10:10 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCGIWSCAN]: Operation not supported
set 30 15:10:14 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:10:14 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
set 30 15:10:24 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCGIWSCAN]: Operation not supported
set 30 15:10:34 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:10:34 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
set 30 15:10:44 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCGIWSCAN]: Operation not supported
set 30 15:10:49 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: Driver does not support AP mode
set 30 15:11:14 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-DSCP-POLICY clear_all
set 30 15:11:14 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:11:14 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
set 30 15:11:15 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:11:15 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
set 30 15:11:16 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:11:16 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
set 30 15:11:18 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:11:18 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
set 30 15:11:22 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: Driver does not support AP mode
set 30 15:11:26 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:11:26 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
set 30 15:11:36 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCGIWSCAN]: Operation not supported
set 30 15:11:47 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-DSCP-POLICY clear_all
set 30 15:11:47 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:11:47 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
set 30 15:11:48 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:11:48 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
set 30 15:11:51 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:11:51 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
set 30 15:11:56 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:11:56 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
set 30 15:12:03 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:12:03 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
set 30 15:12:13 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCGIWSCAN]: Operation not supported
set 30 15:12:13 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:12:13 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
set 30 15:12:23 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCGIWSCAN]: Operation not supported
set 30 15:12:27 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:12:27 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
set 30 15:12:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCGIWSCAN]: Operation not supported
set 30 15:12:47 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:12:47 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
set 30 15:12:57 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCGIWSCAN]: Operation not supported
set 30 15:13:16 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:13:16 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
set 30 15:13:22 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:13:22 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
set 30 15:13:32 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCGIWSCAN]: Operation not supported
set 30 15:13:59 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:13:59 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
set 30 15:14:09 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCGIWSCAN]: Operation not supported
set 30 15:15:03 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:15:03 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
set 30 15:15:13 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCGIWSCAN]: Operation not supported
set 30 15:15:48 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:15:48 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1 retry=1
set 30 15:15:49 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:15:49 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1 retry=1
set 30 15:15:50 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:15:50 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1 retry=1
set 30 15:15:51 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:15:51 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1 retry=1
set 30 15:15:52 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:15:52 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1 retry=1
set 30 15:15:53 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:15:53 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1 retry=1
set 30 15:15:54 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:15:54 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1 retry=1
set 30 15:15:55 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:15:55 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1 retry=1
set 30 15:15:56 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:15:56 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1 retry=1
set 30 15:15:57 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:15:57 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1 retry=1
set 30 15:15:58 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:15:58 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1 retry=1
set 30 15:15:59 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:15:59 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1 retry=1
set 30 15:16:00 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:16:00 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1 retry=1
set 30 15:16:01 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:16:01 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1 retry=1
set 30 15:16:02 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:16:02 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1 retry=1
set 30 15:16:03 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:16:03 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1 retry=1
set 30 15:16:04 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:16:04 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1 retry=1
set 30 15:16:05 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:16:05 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1 retry=1
set 30 15:16:06 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:16:06 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1 retry=1
set 30 15:16:07 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:16:07 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1 retry=1
set 30 15:16:08 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:16:08 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1 retry=1
set 30 15:16:09 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:16:09 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1 retry=1
set 30 15:16:10 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:16:10 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1 retry=1
set 30 15:16:11 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:16:11 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1 retry=1
set 30 15:16:12 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:16:12 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1 retry=1
set 30 15:16:13 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:16:13 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1 retry=1
set 30 15:16:13 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-DSCP-POLICY clear_all
set 30 15:16:13 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:16:13 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
set 30 15:16:14 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:16:14 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
set 30 15:16:17 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:16:17 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
set 30 15:16:22 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:16:22 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
set 30 15:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
set 30 15:16:39 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCGIWSCAN]: Operation not supported
set 30 15:16:39 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:16:39 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
set 30 15:16:49 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCGIWSCAN]: Operation not supported
set 30 15:16:53 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:16:53 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
set 30 15:17:03 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCGIWSCAN]: Operation not supported
set 30 15:17:13 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:17:13 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
set 30 15:17:23 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCGIWSCAN]: Operation not supported
set 30 15:17:42 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:17:42 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
set 30 15:17:52 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCGIWSCAN]: Operation not supported
set 30 15:18:25 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:18:25 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
set 30 15:18:35 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCGIWSCAN]: Operation not supported
set 30 15:19:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:19:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
set 30 15:19:39 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCGIWSCAN]: Operation not supported
set 30 15:21:04 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:21:04 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
set 30 15:21:14 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCGIWSCAN]: Operation not supported
set 30 15:21:17 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:21:17 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
set 30 15:21:27 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCGIWSCAN]: Operation not supported
set 30 15:23:05 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:23:05 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
set 30 15:23:15 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCGIWSCAN]: Operation not supported
set 30 15:25:06 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCSIWSCAN]: Operation not supported
set 30 15:25:06 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
set 30 15:25:16 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
ioctl[SIOCGIWSCAN]: Operation not supported


For further information do not hesitate to contact me

Francesco

Il giorno mar 30 set 2025 alle ore 13:34 Johannes Berg
<johannes@sipsolutions.net> ha scritto:
>
> On Sun, 2025-09-28 at 20:51 +0200, Francesco Bergesio wrote:
> >
> > Steps to Reproduce:
> > - Connect to a Wi-Fi network.
> > - Suspend the system using systemctl suspend.
> > - Resume the system.
> > - Wi-Fi does not reconnect automatically; manual reconnection fails.
>
> How does it fail? Does userspace get errors? Is there a wpa_s log? The
> kernel log indicates the driver was restarted/reloaded or so, but
> nothing else.
>
> johannes

