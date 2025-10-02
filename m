Return-Path: <linux-wireless+bounces-27778-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D79BB3725
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Oct 2025 11:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87DE23ABE59
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Oct 2025 09:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F0E2FD7DF;
	Thu,  2 Oct 2025 09:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJCkuL9h"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9362F0C61
	for <linux-wireless@vger.kernel.org>; Thu,  2 Oct 2025 09:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759396981; cv=none; b=RXSWkRz/+Ym1SDwS7aSXioCJ5qHnwBgREY4LRZU4/Gge3tInysXK0XxB7lqnIKmM5VK9gnGXkTbQxHo2IRNwScoOSqxyhu/izSoRoNlTlaVOTJBKQTiJ73w7TIuGimjajb8V/8ZOPbsait6I8Pf3hT+rZYBaMFR69YdjgQh6MsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759396981; c=relaxed/simple;
	bh=7N8WbUr0zXRQTCYujkVqzpSmi5B2q/NqBImM7esP1/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WHgcjzfrnYkrPBNNy5oeOAMaG0YuY8vaB+x6bsJHciJLBQcfIAQmSpEB2Z2KZwuHzoONv3Gt9lb0aKMFZr+9KA7QIKFoDDE39s5WgI16n8kMBsUPUzOub+OG1FHP6YUVV1ARPgSofFsLdBlYcnS0HQZCf/75/zEC/f/v5Dq76tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJCkuL9h; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-869ecba3bd2so97832085a.0
        for <linux-wireless@vger.kernel.org>; Thu, 02 Oct 2025 02:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759396976; x=1760001776; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j8Squ7X9HgNxQonVUqG2uQitoep0vBjFj7FG7OTN3XQ=;
        b=iJCkuL9ht675LUlO/bc4hKNZUIcxtNEQ7Lorv37E/syDD8mrwi+x0Hrxa3hIHhu+e7
         pwH3p+QRTPgoAkRgC69WqKZCMGFtdizfCYhlfdh8XOBxqrn1sGrmCu4NMyG+xmBmEjaE
         PDoKf4ZGqDm2clmmO0H0Xn42N9O+ZI/cGHy/NceZ464vCIztHYDdsZI7xK+M6rDEqhC8
         YTOxna4UqYlSrWISREhzV2kbinR+rde7hdhaWX/lZRTgcm0bI1CSCa5G9PGAQitMSh88
         qSO0nxVpCMZEFhgdHbs1tqDQUwyUh4Bgv5P/ZiAn1HxzNDJOP6l6qxd5ZaCqtrGc4cnE
         rmCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759396976; x=1760001776;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j8Squ7X9HgNxQonVUqG2uQitoep0vBjFj7FG7OTN3XQ=;
        b=MqdqlG0r6LYDGV+iPrmqGO7zsQXV2w8MpEae7iYfTozWL0+qFgBbHPiueIncVSp7PG
         Ss29RdJvN5UIXpZRTe4GTQP2NNIWCPOOgC5fsp5MeXScxllGq2itJmfTgkmw/iX3PR4O
         ojE5AVSLM6LsnOv4o1FLtLtCvAFRlCic1boPiMcOqrxwz6fCJDz84gbbQvE9QE43XaUx
         5EYtVTceipkiCgf1rzAbM8R+yNuA0HYNwO4GES+TNgSAbP2MBZ868VJXMsfYGbqyK+mG
         qPrOhtxtkVqLB3xMew9yNX7ZCZKZtYQSwkyFu4b3/bc556ZqnKCwVK6QtimGeVB7w4Xf
         Jlxg==
X-Gm-Message-State: AOJu0Yxxya5Pzl2JnjLcMH3R15jWwWj1GVmXu5suEmgo9m2nZFtLyYA0
	DwGbtnPwZ/7ZCh27FDGxKmXwFOjcMtu+xgsDS5eI01RFjfHXY68fqQ6ysrOzFKoBXkh3N+XMcL2
	1zYR1EUEUJBBUWsQJtXM74x5rJIH8lwAFpp1i
X-Gm-Gg: ASbGncuA5Yu0+QsJyqlY4h0PPj0VbbNXnrXKCcHumIoYdho1G7vhreQMmn5uxRjOh2e
	PCrIBnQy+U4T/eIe4EXyKsXFT+LngItikhAhqEhKe/1ubZyAjiOm/RdwR90D9jdirm92weHqEbf
	yGlu6fiNlX5gDNkSUhqQgEe0TmHYGkAtLto+9+9XFt87eJEOwn//cU5PwqBqQJdrZeuWZeGXite
	rfycMgU2GK+wMf6+w1pyWKGj468BPUJWQ==
X-Google-Smtp-Source: AGHT+IHfc84gQ5wGLESBvtps1rjgfixyI3FNkrzJxT2069V7v+STXYJvG6KE/iEZUDthV3hoMamaumYCjV1vjOZgRc8=
X-Received: by 2002:ad4:5dee:0:b0:7ef:f440:2b40 with SMTP id
 6a1803df08f44-873a704d8f5mr89267126d6.53.1759396975866; Thu, 02 Oct 2025
 02:22:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFXXzTbHabF2hZKWM=RquQXB_tFq-24SPifnyL9ZA5-HL30X1A@mail.gmail.com>
 <76fa4cd8d3598c771f5e1c8bb305c241907edc77.camel@sipsolutions.net>
 <CAFXXzTZD3Wfywo2Mug8=3TrV2b0hsFSMERyd8YpzUgnBzP4uDA@mail.gmail.com>
 <64ac5b780b412f9a663e86d2745e580a7db6b8e3.camel@sipsolutions.net>
 <CAFXXzTYQxq9cAob__q2G+AT0PNYp72=cPTR+gRAF2ouAZguzrQ@mail.gmail.com> <07c9465b6c80253975a7a4a70454fa5e6a536ad1.camel@sipsolutions.net>
In-Reply-To: <07c9465b6c80253975a7a4a70454fa5e6a536ad1.camel@sipsolutions.net>
From: Francesco Bergesio <francescobergesio1@gmail.com>
Date: Thu, 2 Oct 2025 11:22:44 +0200
X-Gm-Features: AS18NWDgaotmHcQdSCOy5Q6PhNxKy6e2CgiVAcoL_S-uPdCvOx1U-5s50u0-XYc
Message-ID: <CAFXXzTYQt=LaUW_EdSPWEv7uQ+CTSXB8jY6GoEMcoVWUF55kTg@mail.gmail.com>
Subject: Re: [Bug Report] Intel AX1775 / AX1790 / BE20 / BE401 / BE1750 2x2
 (Wi-Fi 7) fails to resume after suspend (s2idle)
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I hope this is what you need
I got this with journalctl -u wpa_supplicant.service, the service
running is "/sbin/wpa_supplicant -u -O /run/wpa_supplicant -ddd -t",
first line is before the suspend.

ott 02 11:13:46 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396426.964468: RTM_NEWLINK: ifi_index=5 ifname=docker0 operstate=2
linkmode=0 ifi_family=0 ifi_flags=0x1003 ([UP])
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.723771: RTM_NEWLINK: ifi_index=2 ifname=enp45s0 operstate=2
linkmode=0 ifi_family=0 ifi_flags=0x1002 ()
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.724961: dbus: org.freedesktop.DBus.Properties.Set
(/fi/w1/wpa_supplicant1) [ssv]
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.724971: properties_get_or_set: Set(WFDIEs)
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.724975: WFD: Wi-Fi Display disabled
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.724976: WFD: Update WFD IE
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.724977: WFD: Wi-Fi Display disabled - do not include WFD IE
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.751518: dbus: fi.w1.wpa_supplicant1.Interface.Disconnect
(/fi/w1/wpa_supplicant1/Interfaces/0) []
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.751530: wlp44s0f0: Cancelling scan request
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.751536: wlp44s0f0: No ongoing scan/p2p-scan found to abort
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.751541: wlp44s0f0: Request to deauthenticate -
bssid=84:d8:1b:70:59:82 pending_bssid=00:00:00:00:00:00 reason=3
(DEAUTH_LEAVING) state=COMPLETED
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.751543: TDLS: Tear down peers
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.751546:
wpa_driver_nl80211_deauthenticate(addr=84:d8:1b:70:59:82
reason_code=3)
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.846812: wlp44s0f0: Event DEAUTH (11) received
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.846832: wlp44s0f0: Deauthentication notification
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.846835: wlp44s0f0:  * reason 3 (DEAUTH_LEAVING)
locally_generated=1
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.846838: Deauthentication frame IE(s) - hexdump(len=0):
[NULL]
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.846841: wlp44s0f0: CTRL-EVENT-DISCONNECTED
bssid=84:d8:1b:70:59:82 reason=3 locally_generated=1
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.846844: wlp44s0f0: Auto connect disabled: do not try to
re-connect
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.846847: wlp44s0f0: Ignore connection failure indication
since interface has been put into disconnected state
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.846850: TDLS: Remove peers on disassociation
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.846852: wlp44s0f0: WPA: Clear old PMK and PTK
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.846905: wlp44s0f0: Disconnect event - remove keys
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.846928: wpa_driver_nl80211_set_key: ifindex=3 (wlp44s0f0)
alg=0 addr=(nil) key_idx=0 set_tx=0 seq_len=0 key_len=0 key_flag=0x10
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.846932: nl80211: DEL_KEY
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.846936:    broadcast key
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.846961: wpa_driver_nl80211_set_key: ifindex=3 (wlp44s0f0)
alg=0 addr=(nil) key_idx=1 set_tx=0 seq_len=0 key_len=0 key_flag=0x10
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.846964: nl80211: DEL_KEY
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.846965:    broadcast key
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.846975: wpa_driver_nl80211_set_key: ifindex=3 (wlp44s0f0)
alg=0 addr=0x5dcf5e5d51c0 key_idx=0 set_tx=0 seq_len=0 key_len=0
key_flag=0x20
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.846977: nl80211: DEL_KEY
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.846979:    addr=84:d8:1b:70:59:82
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.846980:    pairwise key
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.847010: nl80211: Data frame filter flags=0x0
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.847065: wlp44s0f0: State: COMPLETED -> DISCONNECTED
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.847068: nl80211: Set wlp44s0f0 operstate 1->0 (DORMANT)
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.847070: netlink: Operstate: ifindex=3 linkmode=-1 (no
change), operstate=5 (IF_OPER_DORMANT)
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.847080: bgscan: Deinitializing module 'simple'
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.847082: nl80211: Signal monitor threshold=0 hysteresis=0
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.847095: WMM AC: WMM AC is disabled
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.847099: wlp44s0f0: Determining shared radio frequencies
(max len 2)
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.847102: wlp44s0f0: Shared frequencies (len=0): completed
iteration
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.847106: P2P: Add operating class 81
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.847108: P2P: Channels - hexdump(len=13): 01 02 03 04 05 06
07 08 09 0a 0b 0c 0d
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.847126: P2P: Update channel list
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.847132: P2P: channels: 81:1,2,3,4,5,6,7,8,9,10,11,12,13
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.847134: P2P: cli_channels:
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.847138: EAPOL: External notification - portEnabled=0
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.847140: EAPOL: SUPP_PAE entering state DISCONNECTED
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.847142: EAPOL: Supplicant port status: Unauthorized
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.847143: nl80211: Skip set_supp_port(unauthorized) while not
associated
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.847144: EAPOL: SUPP_BE entering state INITIALIZE
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.847147: EAPOL: External notification - portValid=0
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.847148: EAPOL: External notification - EAP success=0
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.847161: nl80211: Data frame filter flags=0x0
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.847176: wlp44s0f0: State: DISCONNECTED -> DISCONNECTED
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.847179: nl80211: Set wlp44s0f0 operstate 0->0 (DORMANT)
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.847180: netlink: Operstate: ifindex=3 linkmode=-1 (no
change), operstate=5 (IF_OPER_DORMANT)
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.847183: EAPOL: External notification - portEnabled=0
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.847184: EAPOL: External notification - portValid=0
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.847186: QM: Clear all active DSCP policies
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.847187: wlp44s0f0: CTRL-EVENT-DSCP-POLICY clear_all
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.847257: RTM_NEWLINK: ifi_index=3 ifname=wlp44s0f0
operstate=2 linkmode=1 ifi_family=0 ifi_flags=0x1003 ([UP])
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.847270: nl80211: Event message available
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.847278: nl80211: Ignored event 20 (NL80211_CMD_DEL_STATION)
for foreign interface (ifindex 3 wdev 0x0)
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.847280: nl80211: Drv Event 20 (NL80211_CMD_DEL_STATION)
received for wlp44s0f0
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.847282: nl80211: Delete station 84:d8:1b:70:59:82
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.847285: nl80211: Event message available
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.847289: nl80211: Ignored event 39
(NL80211_CMD_DEAUTHENTICATE) for foreign interface (ifindex 3 wdev
0x0)
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.847291: nl80211: Drv Event 39 (NL80211_CMD_DEAUTHENTICATE)
received for wlp44s0f0
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.847293: nl80211: MLME event 39 (NL80211_CMD_DEAUTHENTICATE)
on wlp44s0f0(a0:02:a5:6b:d6:5e) A1=84:d8:1b:70:59:82
A2=a0:02:a5:6b:d6:5e
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.847295: nl80211: MLME event frame - hexdump(len=26): c0 00
00 00 84 d8 1b 70 59 82 a0 02 a5 6b d6 5e 84 d8 1b 70 59 82 00 00 03
00
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.847299: nl80211: Deauthenticate event
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.847301: nl80211: Ignore deauth event triggered due to own
deauth request
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.847304: nl80211: Event message available
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.847307: nl80211: Ignored event 48 (NL80211_CMD_DISCONNECT)
for foreign interface (ifindex 3 wdev 0x0)
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.847310: nl80211: Drv Event 48 (NL80211_CMD_DISCONNECT)
received for wlp44s0f0
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.847311: nl80211: Ignore disconnect event when using
userspace SME
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.847348: RTM_NEWLINK: ifi_index=3 ifname=wlp44s0f0 wext
ifi_family=0 ifi_flags=0x1003 ([UP])
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.848257: dbus: fi.w1.wpa_supplicant1.Interface.RemoveNetwork
(/fi/w1/wpa_supplicant1/Interfaces/0) [o]
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.848272: dbus: Unregister network object
'/fi/w1/wpa_supplicant1/Interfaces/0/Networks/0'
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.849793: dbus: fi.w1.wpa_supplicant1.Interface.Scan
(/fi/w1/wpa_supplicant1/Interfaces/0) [a{sv}]
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.849816: wlp44s0f0: Add radio work 'scan'@0x5dcf5e5f79d0
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.849824: wlp44s0f0: First radio work item in the queue -
schedule start immediately
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.849854: wlp44s0f0: Starting radio work
'scan'@0x5dcf5e5f79d0 after 0.000030 second wait
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.849863: wlp44s0f0: nl80211: scan request
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.849884: nl80211: Scan SSID
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.851388: Scan requested (ret=0) - scan timeout 30 seconds
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.851408: nl80211: Event message available
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.851416: nl80211: Ignored event 33
(NL80211_CMD_TRIGGER_SCAN) for foreign interface (ifindex 3 wdev 0x0)
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.851419: nl80211: Drv Event 33 (NL80211_CMD_TRIGGER_SCAN)
received for wlp44s0f0
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.851422: wlp44s0f0: nl80211: Scan trigger
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.851428: wlp44s0f0: Event SCAN_STARTED (47) received
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.851433: wlp44s0f0: Own scan request started a scan in
0.000030 seconds
ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396588.854935: dbus: flush_object_timeout_handler: Timeout -
sending changed properties of object
/fi/w1/wpa_supplicant1/Interfaces/0
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.091009: RTM_NEWLINK: ifi_index=3 ifname=wlp44s0f0
operstate=2 linkmode=1 ifi_family=0 ifi_flags=0x1002 ()
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.091073: nl80211: Interface down (wlp44s0f0/wlp44s0f0)
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.091081: wlp44s0f0: Event INTERFACE_DISABLED (26) received
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.091090: wlp44s0f0: Interface was disabled
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.091136: nl80211: Data frame filter flags=0x0
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.091170: wlp44s0f0: State: DISCONNECTED -> DISCONNECTED
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.091180: nl80211: Set wlp44s0f0 operstate 0->0 (DORMANT)
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.091185: netlink: Operstate: ifindex=3 linkmode=-1 (no
change), operstate=5 (IF_OPER_DORMANT)
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.091191: EAPOL: External notification - portEnabled=0
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.091195: EAPOL: External notification - portValid=0
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.091199: wlp44s0f0: Remove radio work 'scan'@0x5dcf5e5f79d0
(started)
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.091232: wlp44s0f0: radio_work_free('scan'@0x5dcf5e5f79d0):
num_active_works --> 0
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.091234: wlp44s0f0: State: DISCONNECTED ->
INTERFACE_DISABLED
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.091238: wlp44s0f0: Determining shared radio frequencies
(max len 2)
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.091240: wlp44s0f0: Shared frequencies (len=0): completed
iteration
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.091244: P2P: Add operating class 81
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.091246: P2P: Channels - hexdump(len=13): 01 02 03 04 05 06
07 08 09 0a 0b 0c 0d
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.091266: P2P: Update channel list
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.091271: P2P: channels: 81:1,2,3,4,5,6,7,8,9,10,11,12,13
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.091274: P2P: cli_channels:
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.091283: nl80211: Event message available
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.091288: nl80211: Ignored event 35
(NL80211_CMD_SCAN_ABORTED) for foreign interface (ifindex 3 wdev 0x0)
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.091290: nl80211: Drv Event 35 (NL80211_CMD_SCAN_ABORTED)
received for wlp44s0f0
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.091292: wlp44s0f0: nl80211: Scan aborted
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.091294: nl80211: Scan probed for SSID ''
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.091298: nl80211: Scan included frequencies: 2412 2417 2422
2427 2432 2437 2442 2447 2452 2457 2462 2467 2472 5180 5200 5220 5240
5260 5280 5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680
5700 5720 5745 5765 5785 5805 5825 5845 5865 5885
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.091303: wlp44s0f0: Event SCAN_RESULTS (3) received
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.091311: l2_packet_receive - recvfrom: Network is down
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.092796: dbus: fi.w1.wpa_supplicant1.RemoveInterface
(/fi/w1/wpa_supplicant1) [o]
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.092817: wlp44s0f0: Removing interface wlp44s0f0
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.092826: Remove remaining child interface p2p-dev-wlp44s0
from parent wlp44s0f0
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.092829: p2p-dev-wlp44s0: Removing interface p2p-dev-wlp44s0
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.092833: nl80211: Getting wowlan status
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.092863: nl80211: Getting wowlan status failed
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.092870: p2p-dev-wlp44s0: Request to deauthenticate -
bssid=00:00:00:00:00:00 pending_bssid=00:00:00:00:00:00 reason=3
(DEAUTH_LEAVING) state=DISCONNECTED
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.092874: TDLS: Tear down peers
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.092895: p2p-dev-wlp44s0: State: DISCONNECTED ->
DISCONNECTED
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.092898: nl80211: Set p2p-dev-wlp44s0 operstate 0->0
(DORMANT)
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.092901: netlink: Operstate: ifindex=0 linkmode=-1 (no
change), operstate=5 (IF_OPER_DORMANT)
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.092909: EAPOL: External notification - portEnabled=0
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.092912: EAPOL: External notification - portValid=0
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.092914: QM: Clear all active DSCP policies
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.092916: p2p-dev-wlp44s0: CTRL-EVENT-DSCP-POLICY clear_all
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.101386: p2p-dev-wlp44s0: WPA: Clear old PMK and PTK
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.101409: p2p-dev-wlp44s0: BSS: Remove id 0 BSSID
84:d8:1b:70:59:81 SSID 'TP-Link_5982_5G' due to wpa_bss_flush
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.101412: p2p-dev-wlp44s0: BSS: Remove id 1 BSSID
86:d8:1b:70:59:81 SSID 'TP-Link_Guest_5982_5G' due to wpa_bss_flush
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.101413: p2p-dev-wlp44s0: BSS: Remove id 2 BSSID
84:d8:1b:70:59:82 SSID 'TP-Link_5982' due to wpa_bss_flush
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.101415: p2p-dev-wlp44s0: BSS: Remove id 3 BSSID
86:d8:1b:50:59:82 SSID 'TP-Link_Guest_5982' due to wpa_bss_flush
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.101417: p2p-dev-wlp44s0: BSS: Remove id 4 BSSID
86:d8:1b:60:59:82 SSID '' due to wpa_bss_flush
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.101419: p2p-dev-wlp44s0: BSS: Remove id 5 BSSID
ec:fd:f8:1b:d6:36 SSID 'AP_2375293218' due to wpa_bss_flush
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.101421: p2p-dev-wlp44s0: BSS: Remove id 6 BSSID
c4:a8:1d:3a:bb:da SSID 'CASA' due to wpa_bss_flush
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.101423: p2p-dev-wlp44s0: BSS: Remove id 7 BSSID
62:45:b1:0e:15:b9 SSID '' due to wpa_bss_flush
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.101425: p2p-dev-wlp44s0: Cancelling delayed sched scan
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.101428: p2p-dev-wlp44s0: Cancelling scan request
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.101429: p2p-dev-wlp44s0: Cancelling authentication timeout
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.101437: Off-channel: Clear pending Action frame TX
(pending_action_tx=(nil)
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.101481: HS20: Delete all stored icons
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.101484: Off-channel: Action frame sequence done
notification: pending_action_tx=(nil) drv_offchan_tx=1
action_tx_wait_time=0 off_channel_freq=0 roc_waiting_drv_freq=0
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.101763: QM: Clear all active DSCP policies
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.101767: p2p-dev-wlp44s0: CTRL-EVENT-DSCP-POLICY clear_all
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.101769: p2p-dev-wlp44s0: P2P: Disable P2P since removing
the management interface is being removed
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.101771: P2P: All ASP advertisements flushed
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.101773: P2P: Disabling Extended Listen Timing
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.101775: P2P: Stopping find
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.101777: P2P: Clear timeout (state=IDLE)
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.101778: P2P: State IDLE -> IDLE
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.101781: P2P: All ASP advertisements flushed
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.101782: Remove interface p2p-dev-wlp44s0 from radio phy0
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.101784: nl80211: deinit ifname=p2p-dev-wlp44s0
disabled_11b_rates=0
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.101786: nl80211: Remove monitor interface: refcount=0
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.101788: netlink: Operstate: ifindex=0 linkmode=0
(kernel-control), operstate=6 (IF_OPER_UP)
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.186152: nl80211: Stop P2P Device p2p-dev-wlp44s0 (0x2):
Success
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.186167: nl80211: Unsubscribe mgmt frames handle
0x8888d547d6ec3349 (deinit)
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.198772: nl80211: Delete P2P Device p2p-dev-wlp44s0 (0x2):
Success
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.198798: Control interface directory not empty - leaving it
behind
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.198803: nl80211: Getting wowlan status
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.198811: nl80211: wowlan is disabled
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.198815: wlp44s0f0: Request to deauthenticate -
bssid=00:00:00:00:00:00 pending_bssid=00:00:00:00:00:00 reason=3
(DEAUTH_LEAVING) state=INTERFACE_DISABLED
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.198820: TDLS: Tear down peers
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.198829: nl80211: Data frame filter flags=0x0
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.198856: QM: Clear all active DSCP policies
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.198858: wlp44s0f0: CTRL-EVENT-DSCP-POLICY clear_all
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.220848: wlp44s0f0: WPA: Clear old PMK and PTK
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.220869: wlp44s0f0: BSS: Remove id 0 BSSID 84:d8:1b:70:59:81
SSID 'TP-Link_5982_5G' due to wpa_bss_flush
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.220872: dbus: Unregister BSS object
'/fi/w1/wpa_supplicant1/Interfaces/0/BSSs/0'
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.220902: wlp44s0f0: BSS: Remove id 1 BSSID 86:d8:1b:70:59:81
SSID 'TP-Link_Guest_5982_5G' due to wpa_bss_flush
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.220905: dbus: Unregister BSS object
'/fi/w1/wpa_supplicant1/Interfaces/0/BSSs/1'
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.220924: wlp44s0f0: BSS: Remove id 3 BSSID 86:d8:1b:50:59:82
SSID 'TP-Link_Guest_5982' due to wpa_bss_flush
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.220926: dbus: Unregister BSS object
'/fi/w1/wpa_supplicant1/Interfaces/0/BSSs/3'
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.220938: wlp44s0f0: BSS: Remove id 2 BSSID 84:d8:1b:70:59:82
SSID 'TP-Link_5982' due to wpa_bss_flush
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.220940: dbus: Unregister BSS object
'/fi/w1/wpa_supplicant1/Interfaces/0/BSSs/2'
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.220951: wlp44s0f0: BSS: Remove id 4 BSSID 86:d8:1b:60:59:82
SSID '' due to wpa_bss_flush
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.220953: dbus: Unregister BSS object
'/fi/w1/wpa_supplicant1/Interfaces/0/BSSs/4'
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.220963: wlp44s0f0: BSS: Remove id 5 BSSID ec:fd:f8:1b:d6:36
SSID 'AP_2375293218' due to wpa_bss_flush
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.220966: dbus: Unregister BSS object
'/fi/w1/wpa_supplicant1/Interfaces/0/BSSs/5'
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.220976: wlp44s0f0: BSS: Remove id 6 BSSID c4:a8:1d:3a:bb:da
SSID 'CASA' due to wpa_bss_flush
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.220978: dbus: Unregister BSS object
'/fi/w1/wpa_supplicant1/Interfaces/0/BSSs/6'
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.220989: wlp44s0f0: BSS: Remove id 7 BSSID 62:45:b1:0e:15:b9
SSID '' due to wpa_bss_flush
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.220991: dbus: Unregister BSS object
'/fi/w1/wpa_supplicant1/Interfaces/0/BSSs/7'
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.221001: wlp44s0f0: Cancelling delayed sched scan
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.221004: wlp44s0f0: Cancelling scan request
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.221006: wlp44s0f0: Cancelling authentication timeout
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.221012: Off-channel: Clear pending Action frame TX
(pending_action_tx=(nil)
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.221058: nl80211: Data frame filter flags=0x0
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.221084: HS20: Delete all stored icons
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.221086: Off-channel: Action frame sequence done
notification: pending_action_tx=(nil) drv_offchan_tx=1
action_tx_wait_time=0 off_channel_freq=0 roc_waiting_drv_freq=0
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.221090: QM: Clear all active DSCP policies
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.221091: wlp44s0f0: CTRL-EVENT-DSCP-POLICY clear_all
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.221093: Remove interface wlp44s0f0 from radio phy0
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.221094: Remove radio phy0
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.221096: nl80211: deinit ifname=wlp44s0f0
disabled_11b_rates=0
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.221098: nl80211: Remove monitor interface: refcount=0
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.221100: netlink: Operstate: ifindex=3 linkmode=0
(kernel-control), operstate=6 (IF_OPER_UP)
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.221111: nl80211: Set mode ifindex 3 iftype 2 (STATION)
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.221121: nl80211: Unsubscribe mgmt frames handle
0x8888d547d6d54b99 (mode change)
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.221142: dbus: Unregister interface object
'/fi/w1/wpa_supplicant1/Interfaces/0'
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.856970: RTM_DELLINK: ifi_index=3 ifname=wlp44s0f0
operstate=2 linkmode=0 ifi_family=0 ifi_flags=0x1002 ()
ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396589.856984: RTM_DELLINK: Interface 'wlp44s0f0' removed
ott 02 11:16:36 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396596.792185: RTM_NEWLINK: ifi_index=6 ifname=wlan0 operstate=2
linkmode=0 ifi_family=0 ifi_flags=0x1002 ()
ott 02 11:16:36 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396596.793314: RTM_NEWLINK: ifi_index=6 ifname=wlp44s0f0
operstate=2 linkmode=0 ifi_family=0 ifi_flags=0x1002 ()
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.427735: RTM_NEWLINK: ifi_index=2 ifname=enp45s0 operstate=2
linkmode=0 ifi_family=0 ifi_flags=0x1003 ([UP])
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.847401: RTM_NEWLINK: ifi_index=6 ifname=wlp44s0f0
operstate=0 linkmode=0 ifi_family=0 ifi_flags=0x1043 ([UP][RUNNING])
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.847567: RTM_NEWLINK: ifi_index=6 ifname=wlp44s0f0
operstate=2 linkmode=0 ifi_family=0 ifi_flags=0x1003 ([UP])
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.849949: dbus: fi.w1.wpa_supplicant1.CreateInterface
(/fi/w1/wpa_supplicant1) [a{sv}]
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.849956: wpa_dbus_dict_open_read: start reading a dict entry
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.849959: wpa_dbus_dict_get_entry: dict entry key: Driver
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.849960: wpa_dbus_dict_get_entry: dict entry variant content
type: s
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.849961: _wpa_dbus_dict_fill_value_from_variant: string
value: [omitted]
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.849964: wpa_dbus_dict_get_entry: dict entry key: Ifname
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.849965: wpa_dbus_dict_get_entry: dict entry variant content
type: s
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.849966: _wpa_dbus_dict_fill_value_from_variant: string
value: [omitted]
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.849973: Override interface parameter: ctrl_interface
('(null)' -> '/run/wpa_supplicant')
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.849975: Initializing interface 'wlp44s0f0' conf 'N/A'
driver 'nl80211,wext' ctrl_interface '/run/wpa_supplicant' bridge
'N/A'
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.850020: nl80211: deinit ifname=wlp44s0f0
disabled_11b_rates=0
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.850021: nl80211: Remove monitor interface: refcount=0
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.850022: netlink: Operstate: ifindex=6 linkmode=0
(kernel-control), operstate=6 (IF_OPER_UP)
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.850034: wlp44s0f0: Failed to initialize driver interface -
try next driver wrapper
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.850048: WEXT: cfg80211-based driver detected
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.850057: wext: interface wlp44s0f0 phy: phy0
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.850095: rfkill: initial event: idx=2 type=1 op=0 soft=0
hard=0
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.850102: ioctl[SIOCSIWMODE]: Operation not supported
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.850103: Could not configure driver to use managed mode
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.850104: ioctl[SIOCGIWRANGE]: Operation not supported
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.850105: ioctl[SIOCGIWMODE]: Operation not supported
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.850106: ioctl[SIOCSIWAP]: Operation not supported
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.850107: WEXT: Failed to clear BSSID selection on disconnect
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.850108: ioctl[SIOCSIWESSID]: Operation not supported
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.850109: WEXT: Failed to clear SSID on disconnect
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.850115: WEXT: Driver: iwlwifi
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.850116: netlink: Operstate: ifindex=6 linkmode=1
(userspace-control), operstate=5 (IF_OPER_DORMANT)
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.850135: Add interface wlp44s0f0 to a new radio phy0
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.861533: wlp44s0f0: Own MAC address: a0:02:a5:6b:d6:5e
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.861544: wpa_driver_wext_set_key: alg=0 key_idx=0 set_tx=0
seq_len=0 key_len=0
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.861549: ioctl[SIOCSIWENCODEEXT]: Operation not supported
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.861550: Driver did not support SIOCSIWENCODEEXT, trying
SIOCSIWENCODE
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.861551: ioctl[SIOCSIWENCODE]: Operation not supported
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.861552: wpa_driver_wext_set_key: alg=0 key_idx=1 set_tx=0
seq_len=0 key_len=0
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.861553: ioctl[SIOCSIWENCODEEXT]: Operation not supported
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.861554: Driver did not support SIOCSIWENCODEEXT, trying
SIOCSIWENCODE
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.861555: ioctl[SIOCSIWENCODE]: Operation not supported
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.861555: wpa_driver_wext_set_key: alg=0 key_idx=2 set_tx=0
seq_len=0 key_len=0
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.861556: ioctl[SIOCSIWENCODEEXT]: Operation not supported
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.861557: Driver did not support SIOCSIWENCODEEXT, trying
SIOCSIWENCODE
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.861557: ioctl[SIOCSIWENCODE]: Operation not supported
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.861558: wpa_driver_wext_set_key: alg=0 key_idx=3 set_tx=0
seq_len=0 key_len=0
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.861559: ioctl[SIOCSIWENCODEEXT]: Operation not supported
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.861560: Driver did not support SIOCSIWENCODEEXT, trying
SIOCSIWENCODE
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.861560: ioctl[SIOCSIWENCODE]: Operation not supported
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.861561: wpa_driver_wext_set_key: alg=0 key_idx=4 set_tx=0
seq_len=0 key_len=0
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.861562: ioctl[SIOCSIWENCODEEXT]: Operation not supported
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.861562: Driver did not support SIOCSIWENCODEEXT, trying
SIOCSIWENCODE
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.861563: ioctl[SIOCSIWENCODE]: Operation not supported
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.861564: wpa_driver_wext_set_key: alg=0 key_idx=5 set_tx=0
seq_len=0 key_len=0
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.861564: ioctl[SIOCSIWENCODEEXT]: Operation not supported
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.861565: Driver did not support SIOCSIWENCODEEXT, trying
SIOCSIWENCODE
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.861566: ioctl[SIOCSIWENCODE]: Operation not supported
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.861566: wpa_driver_wext_set_countermeasures
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.861567: wlp44s0f0: RSN: flushing PMKID list in the driver
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.861570: wlp44s0f0: State: DISCONNECTED -> INACTIVE
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.876478: TDLS: TDLS operation supported by driver
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.876486: TDLS: Driver uses internal link setup
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.876488: TDLS: Driver does not support TDLS channel
switching
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.876513: wlp44s0f0: WPS: UUID based on MAC address:
525e5d5f-f229-54c2-b565-01f70b79ca44
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.876718: ENGINE: Loading builtin engines
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.876822: ENGINE: Loading builtin engines
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.876838: EAPOL: SUPP_PAE entering state DISCONNECTED
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.876840: EAPOL: Supplicant port status: Unauthorized
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.876841: EAPOL: KEY_RX entering state NO_KEY_RECEIVE
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.876842: EAPOL: SUPP_BE entering state INITIALIZE
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.876843: EAP: EAP entering state DISABLED
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.876877: MBO: Update non-preferred channels,
non_pref_chan=N/A
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.876882: dbus: Register interface object
'/fi/w1/wpa_supplicant1/Interfaces/1'
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.876991: wlp44s0f0: Added interface wlp44s0f0
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.876995: wlp44s0f0: State: INACTIVE -> DISCONNECTED
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.876996: wpa_driver_wext_set_operstate: operstate 0->0
(DORMANT)
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.876998: netlink: Operstate: ifindex=6 linkmode=-1 (no
change), operstate=5 (IF_OPER_DORMANT)
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.877033: RTM_NEWLINK: ifi_index=6 ifname=wlp44s0f0
operstate=2 linkmode=1 ifi_family=0 ifi_flags=0x1003 ([UP])
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.877037: wlp44s0f0: Event INTERFACE_STATUS (5) received
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.877039: RTM_NEWLINK: operstate=0 ifi_flags=0x1003 ([UP])
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.877040: RTM_NEWLINK, IFLA_IFNAME: Interface 'wlp44s0f0'
added
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.877049: WEXT: if_removed already cleared - ignore event
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.877562: dbus: org.freedesktop.DBus.Properties.Set
(/fi/w1/wpa_supplicant1/Interfaces/1) [ssv]
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.877568: properties_get_or_set: Set(BSSExpireAge)
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.877575: wlp44s0f0: Setting bss expiration age: 250 sec
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.877580: dbus: org.freedesktop.DBus.Properties.Set
(/fi/w1/wpa_supplicant1/Interfaces/1) [ssv]
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.877581: properties_get_or_set: Set(BSSExpireCount)
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.877582: wlp44s0f0: Setting bss expiration scan count: 2
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.877585: dbus: org.freedesktop.DBus.Properties.Set
(/fi/w1/wpa_supplicant1/Interfaces/1) [ssv]
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.877587: properties_get_or_set: Set(Pmf)
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.877588: pmf=1
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.877592: dbus: org.freedesktop.DBus.Properties.GetAll
(/fi/w1/wpa_supplicant1/Interfaces/1) [s]
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.877692: dbus: org.freedesktop.DBus.Properties.GetAll
(/fi/w1/wpa_supplicant1/Interfaces/1) [s]
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.877694: dbus: fill_dict_with_properties
dbus_interface=fi.w1.wpa_supplicant1.Interface.P2PDevice
dbus_property=P2PDeviceConfig getter failed
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.878638: dbus: fi.w1.wpa_supplicant1.Interface.Scan
(/fi/w1/wpa_supplicant1/Interfaces/1) [a{sv}]
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.878650: wlp44s0f0: Add radio work 'scan'@0x5dcf5e666480
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.878655: wlp44s0f0: First radio work item in the queue -
schedule start immediately
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.878678: wlp44s0f0: Starting radio work
'scan'@0x5dcf5e666480 after 0.000022 second wait
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.878687: ioctl[SIOCSIWSCAN]: Operation not supported
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.878690: Scan requested (ret=-1) - scan timeout 10 seconds
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.878703: wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.878708: wlp44s0f0: Radio work 'scan'@0x5dcf5e666480 done in
0.000030 seconds
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.878712: wlp44s0f0: radio_work_free('scan'@0x5dcf5e666480):
num_active_works --> 0
ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396597.883741: dbus: flush_object_timeout_handler: Timeout -
sending changed properties of object
/fi/w1/wpa_supplicant1/Interfaces/1
ott 02 11:16:38 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396598.877880: EAPOL: disable timer tick
ott 02 11:16:42 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396602.066785: dbus: fi.w1.wpa_supplicant1.Interface.Scan
(/fi/w1/wpa_supplicant1/Interfaces/1) [a{sv}]
ott 02 11:16:42 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396602.066818: wlp44s0f0: Add radio work 'scan'@0x5dcf5e666480
ott 02 11:16:42 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396602.066829: wlp44s0f0: First radio work item in the queue -
schedule start immediately
ott 02 11:16:42 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396602.066858: wlp44s0f0: Starting radio work
'scan'@0x5dcf5e666480 after 0.000029 second wait
ott 02 11:16:42 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396602.066871: ioctl[SIOCSIWSCAN]: Operation not supported
ott 02 11:16:42 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396602.066873: Scan requested (ret=-1) - scan timeout 10 seconds
ott 02 11:16:42 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396602.066886: wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
ott 02 11:16:42 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396602.066890: wlp44s0f0: Radio work 'scan'@0x5dcf5e666480 done in
0.000033 seconds
ott 02 11:16:42 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396602.066893: wlp44s0f0: radio_work_free('scan'@0x5dcf5e666480):
num_active_works --> 0
ott 02 11:16:42 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396602.071956: dbus: flush_object_timeout_handler: Timeout -
sending changed properties of object
/fi/w1/wpa_supplicant1/Interfaces/1
ott 02 11:16:47 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396607.068282: dbus: fi.w1.wpa_supplicant1.Interface.Scan
(/fi/w1/wpa_supplicant1/Interfaces/1) [a{sv}]
ott 02 11:16:47 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396607.068314: wlp44s0f0: Add radio work 'scan'@0x5dcf5e666480
ott 02 11:16:47 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396607.068327: wlp44s0f0: First radio work item in the queue -
schedule start immediately
ott 02 11:16:47 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396607.068343: wlp44s0f0: Starting radio work
'scan'@0x5dcf5e666480 after 0.000016 second wait
ott 02 11:16:47 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396607.068352: ioctl[SIOCSIWSCAN]: Operation not supported
ott 02 11:16:47 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396607.068353: Scan requested (ret=-1) - scan timeout 10 seconds
ott 02 11:16:47 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396607.068359: wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
ott 02 11:16:47 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396607.068361: wlp44s0f0: Radio work 'scan'@0x5dcf5e666480 done in
0.000018 seconds
ott 02 11:16:47 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396607.068362: wlp44s0f0: radio_work_free('scan'@0x5dcf5e666480):
num_active_works --> 0
ott 02 11:16:47 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396607.073419: dbus: flush_object_timeout_handler: Timeout -
sending changed properties of object
/fi/w1/wpa_supplicant1/Interfaces/1
ott 02 11:16:54 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396614.066843: dbus: fi.w1.wpa_supplicant1.Interface.Scan
(/fi/w1/wpa_supplicant1/Interfaces/1) [a{sv}]
ott 02 11:16:54 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396614.066862: wlp44s0f0: Add radio work 'scan'@0x5dcf5e666480
ott 02 11:16:54 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396614.066869: wlp44s0f0: First radio work item in the queue -
schedule start immediately
ott 02 11:16:54 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396614.066887: wlp44s0f0: Starting radio work
'scan'@0x5dcf5e666480 after 0.000018 second wait
ott 02 11:16:54 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396614.066897: ioctl[SIOCSIWSCAN]: Operation not supported
ott 02 11:16:54 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396614.066899: Scan requested (ret=-1) - scan timeout 10 seconds
ott 02 11:16:54 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396614.066907: wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
ott 02 11:16:54 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396614.066909: wlp44s0f0: Radio work 'scan'@0x5dcf5e666480 done in
0.000022 seconds
ott 02 11:16:54 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396614.066911: wlp44s0f0: radio_work_free('scan'@0x5dcf5e666480):
num_active_works --> 0
ott 02 11:16:54 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396614.071994: dbus: flush_object_timeout_handler: Timeout -
sending changed properties of object
/fi/w1/wpa_supplicant1/Interfaces/1
ott 02 11:17:04 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396624.072630: Scan timeout - try to get results
ott 02 11:17:04 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396624.072659: wlp44s0f0: Event SCAN_RESULTS (3) received
ott 02 11:17:04 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396624.072682: ioctl[SIOCGIWSCAN]: Operation not supported
ott 02 11:17:04 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396624.072686: wlp44s0f0: Failed to get scan results
ott 02 11:17:04 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396624.072690: wlp44s0f0: Failed to get scan results - try
scanning again
ott 02 11:17:04 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396624.072694: wlp44s0f0: Short-circuit new scan request since
there are no enabled networks
ott 02 11:17:04 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396624.072699: wlp44s0f0: State: DISCONNECTED -> INACTIVE
ott 02 11:17:04 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396624.072766: dbus: fi.w1.wpa_supplicant1.Interface.Scan
(/fi/w1/wpa_supplicant1/Interfaces/1) [a{sv}]
ott 02 11:17:04 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396624.072778: wlp44s0f0: Add radio work 'scan'@0x5dcf5e6472a0
ott 02 11:17:04 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396624.072782: wlp44s0f0: First radio work item in the queue -
schedule start immediately
ott 02 11:17:04 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396624.072839: wlp44s0f0: Starting radio work
'scan'@0x5dcf5e6472a0 after 0.000056 second wait
ott 02 11:17:04 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396624.072846: ioctl[SIOCSIWSCAN]: Operation not supported
ott 02 11:17:04 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396624.072848: Scan requested (ret=-1) - scan timeout 10 seconds
ott 02 11:17:04 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396624.072858: wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
ott 02 11:17:04 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396624.072862: wlp44s0f0: Radio work 'scan'@0x5dcf5e6472a0 done in
0.000024 seconds
ott 02 11:17:04 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396624.072865: wlp44s0f0: radio_work_free('scan'@0x5dcf5e6472a0):
num_active_works --> 0
ott 02 11:17:04 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396624.077909: dbus: flush_object_timeout_handler: Timeout -
sending changed properties of object
/fi/w1/wpa_supplicant1/Interfaces/1
ott 02 11:17:14 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396634.080255: Scan timeout - try to get results
ott 02 11:17:14 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396634.080299: wlp44s0f0: Event SCAN_RESULTS (3) received
ott 02 11:17:14 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396634.080329: ioctl[SIOCGIWSCAN]: Operation not supported
ott 02 11:17:14 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396634.080337: wlp44s0f0: Failed to get scan results
ott 02 11:17:14 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396634.080344: wlp44s0f0: Failed to get scan results - try
scanning again
ott 02 11:17:14 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396634.080351: wlp44s0f0: Short-circuit new scan request since
there are no enabled networks
ott 02 11:17:14 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396634.080359: wlp44s0f0: State: INACTIVE -> INACTIVE
ott 02 11:17:18 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396638.075073: dbus: fi.w1.wpa_supplicant1.Interface.Scan
(/fi/w1/wpa_supplicant1/Interfaces/1) [a{sv}]
ott 02 11:17:18 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396638.075111: wlp44s0f0: Add radio work 'scan'@0x5dcf5e6472a0
ott 02 11:17:18 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396638.075127: wlp44s0f0: First radio work item in the queue -
schedule start immediately
ott 02 11:17:18 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396638.075184: wlp44s0f0: Starting radio work
'scan'@0x5dcf5e6472a0 after 0.000057 second wait
ott 02 11:17:18 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396638.075204: ioctl[SIOCSIWSCAN]: Operation not supported
ott 02 11:17:18 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396638.075209: Scan requested (ret=-1) - scan timeout 10 seconds
ott 02 11:17:18 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396638.075235: wlp44s0f0: CTRL-EVENT-SCAN-FAILED ret=-1
ott 02 11:17:18 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396638.075244: wlp44s0f0: Radio work 'scan'@0x5dcf5e6472a0 done in
0.000060 seconds
ott 02 11:17:18 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396638.075250: wlp44s0f0: radio_work_free('scan'@0x5dcf5e6472a0):
num_active_works --> 0
ott 02 11:17:18 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396638.080293: dbus: flush_object_timeout_handler: Timeout -
sending changed properties of object
/fi/w1/wpa_supplicant1/Interfaces/1
ott 02 11:17:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396648.076563: Scan timeout - try to get results
ott 02 11:17:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396648.076585: wlp44s0f0: Event SCAN_RESULTS (3) received
ott 02 11:17:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396648.076606: ioctl[SIOCGIWSCAN]: Operation not supported
ott 02 11:17:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396648.076608: wlp44s0f0: Failed to get scan results
ott 02 11:17:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396648.076611: wlp44s0f0: Failed to get scan results - try
scanning again
ott 02 11:17:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396648.076613: wlp44s0f0: Short-circuit new scan request since
there are no enabled networks
ott 02 11:17:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
1759396648.076616: wlp44s0f0: State: INACTIVE -> INACTIVE

