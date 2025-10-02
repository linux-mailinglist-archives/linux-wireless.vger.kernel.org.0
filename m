Return-Path: <linux-wireless+bounces-27775-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F45CBB34EE
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Oct 2025 10:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D2967B5442
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Oct 2025 08:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A972EC57C;
	Thu,  2 Oct 2025 08:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gepEVYIF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C882DC796
	for <linux-wireless@vger.kernel.org>; Thu,  2 Oct 2025 08:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759394668; cv=none; b=CXfs5hvXPfjc1wl6Fw24lLNG10m1CX0rR2ludhMapDWnSGjYQRoHrnCljpUOZ/+INsjABo1EXaGnNx2iKE5ilroLsmS4qcY0YRPtkRmUvYEJzj6nFNJTzP2IG1Np+LX061TLrNuOvbVvD/PDAklo0GZih5G9Bgh2BugLtrlRce8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759394668; c=relaxed/simple;
	bh=Acbhkd9lS03nfWsecuBmd2/6Kw5xGRUqbSCZp2aY2ic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nQYSfX8DFv5eVYtiDyrE68fUsSWR/X+W0Ol2e4uPlgcwBIsenJDnBKNFpV2pDMz28X0qI4HxXV+51NX8CLIJ+YoQba6l6CtJIwNYa6FYfVKKJJj9QOE7KUAt1q/iwlUEyjPiSxfT8UBXTuzc/42fNGR3sv89lsgVv5jHOCvTZiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gepEVYIF; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-795be3a3644so5576786d6.0
        for <linux-wireless@vger.kernel.org>; Thu, 02 Oct 2025 01:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759394665; x=1759999465; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o/HKfNBHiUIW/c2ThfvIww12xx7/OlmaUHLYGKUy0r0=;
        b=gepEVYIFG7L6PLvBwcjaWBVqozi2orkywea65w2qfxImmE11h8a5wcIs5ADOCi0r4U
         aizGea/j6Sttx9oEvWU30qrjEXBgwYYgLykuCTMOZ7EP5tD7IWGiCCivsFuFS2andf1B
         CSSyTi/IBoE+al6T9hRXzOSqF+P0nJmLIUYPmlesJyjy70te0E6Kbu+5fRtbKFIryN7V
         228I1KkmLwWBAlvRYbypNBqHRRkiGI/IoDvvML9a9Wii/UPOQmr22IA8dlbs5veGJBh0
         ruRjO86k/j//kgyIxhAwDmD6bjg/KLTk1tk9mfDR02rug8ZU3RSpi3O4nyaKpEvUV76B
         vY3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759394665; x=1759999465;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o/HKfNBHiUIW/c2ThfvIww12xx7/OlmaUHLYGKUy0r0=;
        b=L69/QIUH7jsiLc/zp9s3OkdYOQ/IGnRkWFGolbN11RhUj2t9cevEMVHO+i1FkwcEn9
         N1lVrf+VFsvDZplhs8y0zo/OQqPkiGFWRD5u2Vetkfpiko/l5EeQOcLz3f2cPiNIqXpI
         5DoyhaKcwvaqD9T7YT0HnS/zvTrPC9KfLYsG3fWsBoLksOws5t7ch2GTTk2yJXlcSuKy
         tYqObpjynLqw6v6mUe8uIv5jw9HbBYObVngpG5vhKR5ScXK7b8eYd09h9/5/ezQQXlso
         TP1AMPs6Auz31W0eeobrzCAgUoONPbhzL97ZARvQe0nJlGjJb7kkwhjU+fY1gmbJRuAy
         sd5A==
X-Gm-Message-State: AOJu0YxaQ6QE15mBnrFSUhCvtfTRKT1xxA6Ky5Z7pJa+HTq+oXLmWl/6
	nva9gYCj+02Cvsg5/1J8j+yvqcNuummoYhwa5uk9f2amaWlEuQUcW3uGmX9xbd4d9mDMW4fUy2F
	OMvTLqEws482poqp88R15IY4gcSoWBvL9dhb6
X-Gm-Gg: ASbGncsQXU3meDAAApg19ha4oTyZOUWGjmCHoNBjyJp4fRkUiMqZY/RBkhnzOCyYDX4
	ASOSJMxzSRuesTaL9xqnz2oS6d6C0y7iI1fvX8FQE+QrnAYRMnG2dnmJ1IQ+A6Og+eeV6DAqq09
	uUwHRT7dZG7r5++gqp1DbGSPCEjUrorFevlrJYzee4Xx1TqcuXcYxOTHfZHv4Eww1nHYHMnzyxR
	AvbJs1ol/EYDRbbUwuh7vuVRYLfoSoXPQ==
X-Google-Smtp-Source: AGHT+IFb/ANbgvNW0SyKCRGbZLl5EOeY2jjcb/1RfXW4hsP2rvH6QtyNGsZVQQVOwJJCMzAFyGUqRlWBucDTctUEaV8=
X-Received: by 2002:a05:6214:d4f:b0:809:5095:4153 with SMTP id
 6a1803df08f44-873a54801bfmr83098376d6.31.1759394664869; Thu, 02 Oct 2025
 01:44:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFXXzTbHabF2hZKWM=RquQXB_tFq-24SPifnyL9ZA5-HL30X1A@mail.gmail.com>
 <76fa4cd8d3598c771f5e1c8bb305c241907edc77.camel@sipsolutions.net>
 <CAFXXzTZD3Wfywo2Mug8=3TrV2b0hsFSMERyd8YpzUgnBzP4uDA@mail.gmail.com> <64ac5b780b412f9a663e86d2745e580a7db6b8e3.camel@sipsolutions.net>
In-Reply-To: <64ac5b780b412f9a663e86d2745e580a7db6b8e3.camel@sipsolutions.net>
From: Francesco Bergesio <francescobergesio1@gmail.com>
Date: Thu, 2 Oct 2025 10:44:13 +0200
X-Gm-Features: AS18NWA85p3jjDUtmUSLDS78VR1RV1gv7dYIU7L2zNTZQnVYNNPLfudUw8f5jR4
Message-ID: <CAFXXzTYQxq9cAob__q2G+AT0PNYp72=cPTR+gRAF2ouAZguzrQ@mail.gmail.com>
Subject: Re: [Bug Report] Intel AX1775 / AX1790 / BE20 / BE401 / BE1750 2x2
 (Wi-Fi 7) fails to resume after suspend (s2idle)
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,
I took wpa_supplicant log with sudo wpa_supplicant -i wlp44s0f0 -c
/dev/null -ddd

wpa_supplicant v2.10
random: getrandom() support available
Successfully initialized wpa_supplicant
Initializing interface 'wlp44s0f0' conf '/dev/null' driver 'default'
ctrl_interface 'N/A' bridge 'N/A'
Configuration file '/dev/null' -> '/dev/null'
Reading configuration file '/dev/null'
nl80211: TDLS supported
nl80211: TDLS external setup
nl80211: Supported cipher 00-0f-ac:1
nl80211: Supported cipher 00-0f-ac:5
nl80211: Supported cipher 00-0f-ac:2
nl80211: Supported cipher 00-0f-ac:4
nl80211: Supported cipher 00-0f-ac:8
nl80211: Supported cipher 00-0f-ac:9
nl80211: Supported cipher 00-0f-ac:6
nl80211: Supported cipher 00-0f-ac:11
nl80211: Supported cipher 00-0f-ac:12
nl80211: Using driver-based off-channel TX
nl80211: Driver-advertised extended capabilities (default) -
hexdump(len=8): 04 00 00 00 00 00 00 40
nl80211: Driver-advertised extended capabilities mask (default) -
hexdump(len=8): 04 00 00 00 00 00 00 40
nl80211: Driver-advertised extended capabilities for interface type STATION
nl80211: Extended capabilities - hexdump(len=10): 04 00 c0 00 00 00 00 c0 01 20
nl80211: Extended capabilities mask - hexdump(len=10): 04 00 c0 00 00
00 00 c0 01 20
nl80211: Use separate P2P group interface (driver advertised support)
nl80211: Enable multi-channel concurrent (driver advertised support)
nl80211: use P2P_DEVICE support
nl80211: key_mgmt=0x1ff0f enc=0x76f auth=0x7 flags=0x44800d30fb5bfbe0
rrm_flags=0x19 probe_resp_offloads=0x0 max_stations=0
max_remain_on_chan=10000 max_scan_ssids=20
nl80211: interface wlp44s0f0 in phy phy0
nl80211: Set mode ifindex 6 iftype 2 (STATION)
nl80211: Subscribe to mgmt frames with non-AP handle 0x55820f925320
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION)
nl_handle=0x55820f925320 match=0104 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION)
nl_handle=0x55820f925320 match=040a multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION)
nl_handle=0x55820f925320 match=040b multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION)
nl_handle=0x55820f925320 match=040c multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION)
nl_handle=0x55820f925320 match=040d multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION)
nl_handle=0x55820f925320 match=090a multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION)
nl_handle=0x55820f925320 match=090b multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION)
nl_handle=0x55820f925320 match=090c multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION)
nl_handle=0x55820f925320 match=090d multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION)
nl_handle=0x55820f925320 match=0409506f9a09 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION)
nl_handle=0x55820f925320 match=7f506f9a09 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION)
nl_handle=0x55820f925320 match=0409506f9a1a multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION)
nl_handle=0x55820f925320 match=0800 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION)
nl_handle=0x55820f925320 match=0801 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION)
nl_handle=0x55820f925320 match=040e multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION)
nl_handle=0x55820f925320 match=12 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION)
nl_handle=0x55820f925320 match=06 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION)
nl_handle=0x55820f925320 match=0a07 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION)
nl_handle=0x55820f925320 match=0a11 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION)
nl_handle=0x55820f925320 match=0a0b multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION)
nl_handle=0x55820f925320 match=0a1a multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION)
nl_handle=0x55820f925320 match=1101 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION)
nl_handle=0x55820f925320 match=1102 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION)
nl_handle=0x55820f925320 match=0505 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION)
nl_handle=0x55820f925320 match=0500 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION)
nl_handle=0x55820f925320 match=0502 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION)
nl_handle=0x55820f925320 match=1301 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION)
nl_handle=0x55820f925320 match=1305 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION)
nl_handle=0x55820f925320 match=7e506f9a1a multicast=0
rfkill: initial event: idx=3 type=1 op=0 soft=0 hard=0
netlink: Operstate: ifindex=6 linkmode=1 (userspace-control),
operstate=5 (IF_OPER_DORMANT)
Add interface wlp44s0f0 to a new radio phy0
nl80211: No channel number found for frequency 5905 MHz
nl80211: Regulatory information - country=00
nl80211: 2402-2437 @ 40 MHz 22 mBm
nl80211: 2422-2462 @ 40 MHz 22 mBm
nl80211: 2447-2482 @ 40 MHz 22 mBm
nl80211: 5170-5190 @ 160 MHz 22 mBm (no outdoor) (no IR)
nl80211: 5190-5210 @ 160 MHz 22 mBm (no outdoor) (no IR)
nl80211: 5210-5230 @ 160 MHz 22 mBm (no outdoor) (no IR)
nl80211: 5230-5250 @ 160 MHz 22 mBm (no outdoor) (no IR)
nl80211: 5250-5270 @ 160 MHz 22 mBm (DFS) (no IR)
nl80211: 5270-5290 @ 160 MHz 22 mBm (DFS) (no IR)
nl80211: 5290-5310 @ 160 MHz 22 mBm (DFS) (no IR)
nl80211: 5310-5330 @ 160 MHz 22 mBm (DFS) (no IR)
nl80211: 5490-5510 @ 240 MHz 22 mBm (DFS) (no IR)
nl80211: 5510-5530 @ 240 MHz 22 mBm (DFS) (no IR)
nl80211: 5530-5550 @ 240 MHz 22 mBm (DFS) (no IR)
nl80211: 5550-5570 @ 240 MHz 22 mBm (DFS) (no IR)
nl80211: 5570-5590 @ 240 MHz 22 mBm (DFS) (no IR)
nl80211: 5590-5610 @ 240 MHz 22 mBm (DFS) (no IR)
nl80211: 5610-5630 @ 240 MHz 22 mBm (DFS) (no IR)
nl80211: 5630-5650 @ 240 MHz 22 mBm (DFS) (no IR)
nl80211: 5650-5670 @ 80 MHz 22 mBm (DFS) (no IR)
nl80211: 5670-5690 @ 80 MHz 22 mBm (DFS) (no IR)
nl80211: 5690-5710 @ 80 MHz 22 mBm (DFS) (no IR)
nl80211: 5710-5730 @ 80 MHz 22 mBm (DFS) (no IR)
nl80211: 5735-5755 @ 160 MHz 22 mBm (no IR)
nl80211: 5755-5775 @ 160 MHz 22 mBm (no IR)
nl80211: 5775-5795 @ 160 MHz 22 mBm (no IR)
nl80211: 5795-5815 @ 160 MHz 22 mBm (no IR)
nl80211: 5815-5835 @ 160 MHz 22 mBm (no IR)
nl80211: 5835-5855 @ 160 MHz 22 mBm (no IR)
nl80211: 5855-5875 @ 160 MHz 22 mBm (no IR)
nl80211: 5875-5895 @ 160 MHz 22 mBm (no IR)
nl80211: Added 802.11b mode based on 802.11g information
nl80211: Mode IEEE 802.11g: 2412 2417 2422 2427 2432 2437 2442 2447
2452 2457 2462 2467 2472 2484[DISABLED]
nl80211: Mode IEEE 802.11a: 5180[NO_IR] 5200[NO_IR] 5220[NO_IR]
5240[NO_IR] 5260[NO_IR][RADAR] 5280[NO_IR][RADAR] 5300[NO_IR][RADAR]
5320[NO_IR][RADAR] 5340[DISABLED] 5360[DISABLED] 5380[DISABLED]
5400[DISABLED] 5420[DISABLED]
nl80211: Mode IEEE 802.11a: 5955[DISABLED] 5975[DISABLED]
5995[DISABLED] 6015[DISABLED] 6035[DISABLED] 6055[DISABLED]
6075[DISABLED] 6095[DISABLED] 6115[DISABLED] 6135[DISABLED]
6155[DISABLED] 6175[DISABLED] 6195[DISABLED]
nl80211: Mode IEEE 802.11b: 2412 2417 2422 2427 2432 2437 2442 2447
2452 2457 2462 2467 2472 2484[DISABLED]
wlp44s0f0: Own MAC address: a0:02:a5:6b:d6:5e
wpa_driver_nl80211_set_key: ifindex=6 (wlp44s0f0) alg=0 addr=(nil)
key_idx=0 set_tx=0 seq_len=0 key_len=0 key_flag=0x10
nl80211: DEL_KEY
   broadcast key
wpa_driver_nl80211_set_key: ifindex=6 (wlp44s0f0) alg=0 addr=(nil)
key_idx=1 set_tx=0 seq_len=0 key_len=0 key_flag=0x10
nl80211: DEL_KEY
   broadcast key
wpa_driver_nl80211_set_key: ifindex=6 (wlp44s0f0) alg=0 addr=(nil)
key_idx=2 set_tx=0 seq_len=0 key_len=0 key_flag=0x10
nl80211: DEL_KEY
   broadcast key
wpa_driver_nl80211_set_key: ifindex=6 (wlp44s0f0) alg=0 addr=(nil)
key_idx=3 set_tx=0 seq_len=0 key_len=0 key_flag=0x10
nl80211: DEL_KEY
   broadcast key
wpa_driver_nl80211_set_key: ifindex=6 (wlp44s0f0) alg=0 addr=(nil)
key_idx=4 set_tx=0 seq_len=0 key_len=0 key_flag=0x10
nl80211: DEL_KEY
   broadcast key
wpa_driver_nl80211_set_key: ifindex=6 (wlp44s0f0) alg=0 addr=(nil)
key_idx=5 set_tx=0 seq_len=0 key_len=0 key_flag=0x10
nl80211: DEL_KEY
   broadcast key
wlp44s0f0: RSN: flushing PMKID list in the driver
nl80211: Flush PMKIDs
wlp44s0f0: State: DISCONNECTED -> INACTIVE
TDLS: TDLS operation supported by driver
TDLS: Driver uses external link setup
TDLS: Driver does not support TDLS channel switching
wlp44s0f0: WPS: UUID based on MAC address: 525e5d5f-f229-54c2-b565-01f70b79ca44
ENGINE: Loading builtin engines
ENGINE: Loading builtin engines
EAPOL: SUPP_PAE entering state DISCONNECTED
EAPOL: Supplicant port status: Unauthorized
nl80211: Skip set_supp_port(unauthorized) while not associated
EAPOL: KEY_RX entering state NO_KEY_RECEIVE
EAPOL: SUPP_BE entering state INITIALIZE
EAP: EAP entering state DISABLED
MBO: Update non-preferred channels, non_pref_chan=N/A
wlp44s0f0: Added interface wlp44s0f0
wlp44s0f0: State: INACTIVE -> DISCONNECTED
nl80211: Set wlp44s0f0 operstate 0->0 (DORMANT)
netlink: Operstate: ifindex=6 linkmode=-1 (no change), operstate=5
(IF_OPER_DORMANT)
nl80211: Create interface iftype 10 (P2P_DEVICE)
nl80211: New P2P Device interface p2p-dev-wlp44s0 (0x7) created
Initializing interface 'p2p-dev-wlp44s0' conf '/dev/null' driver
'nl80211' ctrl_interface 'N/A' bridge 'N/A'
Configuration file '/dev/null' -> '/dev/null'
Reading configuration file '/dev/null'
nl80211: TDLS supported
nl80211: TDLS external setup
nl80211: Supported cipher 00-0f-ac:1
nl80211: Supported cipher 00-0f-ac:5
nl80211: Supported cipher 00-0f-ac:2
nl80211: Supported cipher 00-0f-ac:4
nl80211: Supported cipher 00-0f-ac:8
nl80211: Supported cipher 00-0f-ac:9
nl80211: Supported cipher 00-0f-ac:6
nl80211: Supported cipher 00-0f-ac:11
nl80211: Supported cipher 00-0f-ac:12
nl80211: Using driver-based off-channel TX
nl80211: Driver-advertised extended capabilities (default) -
hexdump(len=8): 04 00 00 00 00 00 00 40
nl80211: Driver-advertised extended capabilities mask (default) -
hexdump(len=8): 04 00 00 00 00 00 00 40
nl80211: Driver-advertised extended capabilities for interface type STATION
nl80211: Extended capabilities - hexdump(len=10): 04 00 c0 00 00 00 00 c0 01 20
nl80211: Extended capabilities mask - hexdump(len=10): 04 00 c0 00 00
00 00 c0 01 20
nl80211: Use separate P2P group interface (driver advertised support)
nl80211: Enable multi-channel concurrent (driver advertised support)
nl80211: use P2P_DEVICE support
nl80211: key_mgmt=0x1ff0f enc=0x76f auth=0x7 flags=0x44800d30fb5bfbe0
rrm_flags=0x19 probe_resp_offloads=0x0 max_stations=0
max_remain_on_chan=10000 max_scan_ssids=20
nl80211: interface p2p-dev-wlp44s0 in phy phy0
nl80211: Set mode ifindex 0 iftype 10 (P2P_DEVICE)
nl80211: Failed to set interface 0 to mode 10: -22 (Invalid argument)
nl80211: Subscribe to mgmt frames with non-AP handle 0x55820f992d90
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION)
nl_handle=0x55820f992d90 match=0104 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION)
nl_handle=0x55820f992d90 match=040a multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION)
nl_handle=0x55820f992d90 match=040b multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION)
nl_handle=0x55820f992d90 match=040c multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION)
nl_handle=0x55820f992d90 match=040d multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION)
nl_handle=0x55820f992d90 match=090a multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION)
nl_handle=0x55820f992d90 match=090b multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION)
nl_handle=0x55820f992d90 match=090c multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION)
nl_handle=0x55820f992d90 match=090d multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION)
nl_handle=0x55820f992d90 match=0409506f9a09 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION)
nl_handle=0x55820f992d90 match=7f506f9a09 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION)
nl_handle=0x55820f992d90 match=0409506f9a1a multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION)
nl_handle=0x55820f992d90 match=0800 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION)
nl_handle=0x55820f992d90 match=0801 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION)
nl_handle=0x55820f992d90 match=040e multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION)
nl_handle=0x55820f992d90 match=12 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION)
nl_handle=0x55820f992d90 match=06 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION)
nl_handle=0x55820f992d90 match=0a07 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION)
nl_handle=0x55820f992d90 match=0a11 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION)
nl_handle=0x55820f992d90 match=0a0b multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION)
nl_handle=0x55820f992d90 match=0a1a multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION)
nl_handle=0x55820f992d90 match=1101 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION)
nl_handle=0x55820f992d90 match=1102 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION)
nl_handle=0x55820f992d90 match=0505 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION)
nl_handle=0x55820f992d90 match=0500 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION)
nl_handle=0x55820f992d90 match=0502 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION)
nl_handle=0x55820f992d90 match=1301 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION)
nl_handle=0x55820f992d90 match=1305 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION)
nl_handle=0x55820f992d90 match=7e506f9a1a multicast=0
nl80211: Use (wlp44s0f0) to initialize P2P Device rfkill
rfkill: initial event: idx=3 type=1 op=0 soft=0 hard=0
nl80211: Start P2P Device p2p-dev-wlp44s0 (0x7): Success
Add interface p2p-dev-wlp44s0 to existing radio phy0
nl80211: No channel number found for frequency 5905 MHz
nl80211: Regulatory information - country=00
nl80211: 2402-2437 @ 40 MHz 22 mBm
nl80211: 2422-2462 @ 40 MHz 22 mBm
nl80211: 2447-2482 @ 40 MHz 22 mBm
nl80211: 5170-5190 @ 160 MHz 22 mBm (no outdoor) (no IR)
nl80211: 5190-5210 @ 160 MHz 22 mBm (no outdoor) (no IR)
nl80211: 5210-5230 @ 160 MHz 22 mBm (no outdoor) (no IR)
nl80211: 5230-5250 @ 160 MHz 22 mBm (no outdoor) (no IR)
nl80211: 5250-5270 @ 160 MHz 22 mBm (DFS) (no IR)
nl80211: 5270-5290 @ 160 MHz 22 mBm (DFS) (no IR)
nl80211: 5290-5310 @ 160 MHz 22 mBm (DFS) (no IR)
nl80211: 5310-5330 @ 160 MHz 22 mBm (DFS) (no IR)
nl80211: 5490-5510 @ 240 MHz 22 mBm (DFS) (no IR)
nl80211: 5510-5530 @ 240 MHz 22 mBm (DFS) (no IR)
nl80211: 5530-5550 @ 240 MHz 22 mBm (DFS) (no IR)
nl80211: 5550-5570 @ 240 MHz 22 mBm (DFS) (no IR)
nl80211: 5570-5590 @ 240 MHz 22 mBm (DFS) (no IR)
nl80211: 5590-5610 @ 240 MHz 22 mBm (DFS) (no IR)
nl80211: 5610-5630 @ 240 MHz 22 mBm (DFS) (no IR)
nl80211: 5630-5650 @ 240 MHz 22 mBm (DFS) (no IR)
nl80211: 5650-5670 @ 80 MHz 22 mBm (DFS) (no IR)
nl80211: 5670-5690 @ 80 MHz 22 mBm (DFS) (no IR)
nl80211: 5690-5710 @ 80 MHz 22 mBm (DFS) (no IR)
nl80211: 5710-5730 @ 80 MHz 22 mBm (DFS) (no IR)
nl80211: 5735-5755 @ 160 MHz 22 mBm (no IR)
nl80211: 5755-5775 @ 160 MHz 22 mBm (no IR)
nl80211: 5775-5795 @ 160 MHz 22 mBm (no IR)
nl80211: 5795-5815 @ 160 MHz 22 mBm (no IR)
nl80211: 5815-5835 @ 160 MHz 22 mBm (no IR)
nl80211: 5835-5855 @ 160 MHz 22 mBm (no IR)
nl80211: 5855-5875 @ 160 MHz 22 mBm (no IR)
nl80211: 5875-5895 @ 160 MHz 22 mBm (no IR)
nl80211: Added 802.11b mode based on 802.11g information
nl80211: Mode IEEE 802.11g: 2412 2417 2422 2427 2432 2437 2442 2447
2452 2457 2462 2467 2472 2484[DISABLED]
nl80211: Mode IEEE 802.11a: 5180[NO_IR] 5200[NO_IR] 5220[NO_IR]
5240[NO_IR] 5260[NO_IR][RADAR] 5280[NO_IR][RADAR] 5300[NO_IR][RADAR]
5320[NO_IR][RADAR] 5340[DISABLED] 5360[DISABLED] 5380[DISABLED]
5400[DISABLED] 5420[DISABLED]
nl80211: Mode IEEE 802.11a: 5955[DISABLED] 5975[DISABLED]
5995[DISABLED] 6015[DISABLED] 6035[DISABLED] 6055[DISABLED]
6075[DISABLED] 6095[DISABLED] 6115[DISABLED] 6135[DISABLED]
6155[DISABLED] 6175[DISABLED] 6195[DISABLED]
nl80211: Mode IEEE 802.11b: 2412 2417 2422 2427 2432 2437 2442 2447
2452 2457 2462 2467 2472 2484[DISABLED]
p2p-dev-wlp44s0: Own MAC address: a0:02:a5:6b:d6:5f
p2p-dev-wlp44s0: RSN: flushing PMKID list in the driver
nl80211: Flush PMKIDs
p2p-dev-wlp44s0: State: DISCONNECTED -> INACTIVE
p2p-dev-wlp44s0: WPS: UUID from the first interface:
525e5d5f-f229-54c2-b565-01f70b79ca44
ENGINE: Loading builtin engines
ENGINE: Loading builtin engines
EAPOL: SUPP_PAE entering state DISCONNECTED
EAPOL: Supplicant port status: Unauthorized
nl80211: Skip set_supp_port(unauthorized) while not associated
EAPOL: KEY_RX entering state NO_KEY_RECEIVE
EAPOL: SUPP_BE entering state INITIALIZE
EAP: EAP entering state DISABLED
P2P: Add operating class 81
P2P: Channels - hexdump(len=13): 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d
P2P: Own listen channel: 81:6
P2P: Random operating channel: 81:11
P2P: initialized
P2P: channels: 81:1,2,3,4,5,6,7,8,9,10,11,12,13
P2P: cli_channels:
MBO: Update non-preferred channels, non_pref_chan=N/A
p2p-dev-wlp44s0: Added interface p2p-dev-wlp44s0
p2p-dev-wlp44s0: State: INACTIVE -> DISCONNECTED
nl80211: Set p2p-dev-wlp44s0 operstate 0->0 (DORMANT)
netlink: Operstate: ifindex=0 linkmode=-1 (no change), operstate=5
(IF_OPER_DORMANT)
p2p-dev-wlp44s0: Determining shared radio frequencies (max len 2)
p2p-dev-wlp44s0: Shared frequencies (len=0): completed iteration
P2P: Add operating class 81
P2P: Channels - hexdump(len=13): 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d
P2P: Update channel list
P2P: channels: 81:1,2,3,4,5,6,7,8,9,10,11,12,13
P2P: cli_channels:
RTM_NEWLINK: ifi_index=6 ifname=wlp44s0f0 operstate=2 linkmode=1
ifi_family=0 ifi_flags=0x1003 ([UP])
EAPOL: disable timer tick
EAPOL: disable timer tick

stuck there and when pressing ctrl-c
^Cp2p-dev-wlp44s0: Removing interface p2p-dev-wlp44s0
nl80211: Getting wowlan status
nl80211: Getting wowlan status failed
p2p-dev-wlp44s0: Request to deauthenticate - bssid=00:00:00:00:00:00
pending_bssid=00:00:00:00:00:00 reason=3 (DEAUTH_LEAVING)
state=DISCONNECTED
TDLS: Tear down peers
p2p-dev-wlp44s0: State: DISCONNECTED -> DISCONNECTED
nl80211: Set p2p-dev-wlp44s0 operstate 0->0 (DORMANT)
netlink: Operstate: ifindex=0 linkmode=-1 (no change), operstate=5
(IF_OPER_DORMANT)
EAPOL: External notification - portEnabled=0
EAPOL: External notification - portValid=0
QM: Clear all active DSCP policies
p2p-dev-wlp44s0: CTRL-EVENT-DSCP-POLICY clear_all
p2p-dev-wlp44s0: WPA: Clear old PMK and PTK
p2p-dev-wlp44s0: Cancelling delayed sched scan
p2p-dev-wlp44s0: Cancelling scan request
p2p-dev-wlp44s0: Cancelling authentication timeout
Off-channel: Clear pending Action frame TX (pending_action_tx=(nil)
HS20: Delete all stored icons
Off-channel: Action frame sequence done notification:
pending_action_tx=(nil) drv_offchan_tx=1 action_tx_wait_time=0
off_channel_freq=0 roc_waiting_drv_freq=0
QM: Clear all active DSCP policies
p2p-dev-wlp44s0: CTRL-EVENT-DSCP-POLICY clear_all
p2p-dev-wlp44s0: P2P: Disable P2P since removing the management
interface is being removed
P2P: All ASP advertisements flushed
P2P: Disabling Extended Listen Timing
P2P: Stopping find
P2P: Clear timeout (state=IDLE)
P2P: State IDLE -> IDLE
P2P: All ASP advertisements flushed
Remove interface p2p-dev-wlp44s0 from radio phy0
nl80211: deinit ifname=p2p-dev-wlp44s0 disabled_11b_rates=0
nl80211: Remove monitor interface: refcount=0
netlink: Operstate: ifindex=0 linkmode=0 (kernel-control), operstate=6
(IF_OPER_UP)
nl80211: Stop P2P Device p2p-dev-wlp44s0 (0x7): Success
nl80211: Unsubscribe mgmt frames handle 0x8888dd0a8711a519 (deinit)
nl80211: Delete P2P Device p2p-dev-wlp44s0 (0x7): Success
p2p-dev-wlp44s0: CTRL-EVENT-TERMINATING
wlp44s0f0: Removing interface wlp44s0f0
nl80211: Getting wowlan status
nl80211: wowlan is disabled
wlp44s0f0: Request to deauthenticate - bssid=00:00:00:00:00:00
pending_bssid=00:00:00:00:00:00 reason=3 (DEAUTH_LEAVING)
state=DISCONNECTED
TDLS: Tear down peers
nl80211: Data frame filter flags=0x0
wlp44s0f0: State: DISCONNECTED -> DISCONNECTED
nl80211: Set wlp44s0f0 operstate 0->0 (DORMANT)
netlink: Operstate: ifindex=6 linkmode=-1 (no change), operstate=5
(IF_OPER_DORMANT)
EAPOL: External notification - portEnabled=0
EAPOL: External notification - portValid=0
QM: Clear all active DSCP policies
wlp44s0f0: CTRL-EVENT-DSCP-POLICY clear_all
wlp44s0f0: WPA: Clear old PMK and PTK
wlp44s0f0: Cancelling delayed sched scan
wlp44s0f0: Cancelling scan request
wlp44s0f0: Cancelling authentication timeout
Off-channel: Clear pending Action frame TX (pending_action_tx=(nil)
nl80211: Data frame filter flags=0x0
HS20: Delete all stored icons
Off-channel: Action frame sequence done notification:
pending_action_tx=(nil) drv_offchan_tx=1 action_tx_wait_time=0
off_channel_freq=0 roc_waiting_drv_freq=0
QM: Clear all active DSCP policies
wlp44s0f0: CTRL-EVENT-DSCP-POLICY clear_all
Remove interface wlp44s0f0 from radio phy0
Remove radio phy0
nl80211: deinit ifname=wlp44s0f0 disabled_11b_rates=0
nl80211: Remove monitor interface: refcount=0
netlink: Operstate: ifindex=6 linkmode=0 (kernel-control), operstate=6
(IF_OPER_UP)
nl80211: Set mode ifindex 6 iftype 2 (STATION)
nl80211: Unsubscribe mgmt frames handle 0x8888dd0a871adba9 (mode change)
wlp44s0f0: CTRL-EVENT-TERMINATING

Thank you,
Francesco

Il giorno mer 1 ott 2025 alle ore 09:00 Johannes Berg
<johannes@sipsolutions.net> ha scritto:
>
> Hi,
>
> > iwconfig
> > lo        no wireless extensions.
> >
> > enp45s0   no wireless extensions.
> >
> > docker0   no wireless extensions.
> >
> > br-3558f493dc1a  no wireless extensions.
> >
> > wlp44s0f0  no wireless extensions.
>
> This is totally expected, FWIW, since you have a Wi-Fi 7 device. It's
> always this way.
>
> > set 30 14:48:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
> > nl80211: deinit ifname=wlp44s0f0 disabled_11b_rates=0
> > set 30 14:48:42 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
> > nl80211: deinit ifname=wlp44s0f0 disabled_11b_rates=0
> > set 30 14:48:42 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
> > ioctl[SIOCSIWMODE]: Operation not supported
>
> Evidently, for whatever reason, something in the system decided that
> wext instead of nl80211 should be used even though it's not even
> supported for that device ... but I really don't know how that might
> happen, I think you need to look further up the stack perhaps?
>
> This probably wasn't the _full_ wpa_s log, maybe you could increase the
> logging verbosity as well, and then show from boot over suspend/resume?
>
> johannes

