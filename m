Return-Path: <linux-wireless+bounces-15858-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9209E1D17
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Dec 2024 14:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 351B72832F4
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Dec 2024 13:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234131EE01F;
	Tue,  3 Dec 2024 13:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5yFlQMx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403331F427E;
	Tue,  3 Dec 2024 13:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733231236; cv=none; b=e//r0hDA0NsiSt+Q9STAO2y8pmfAdgC42hI2rPqRSp9rAymI+GEAG06lXaJi4euUjeG0G7mshVSlKF52iLQ1GjDQwhInKN9pRUAy3EgiYB6ioYM6a+QY4axu+9lNkq4Li3RBHY92NmmwpSYjyKq0E4eJ5McLJqPNlV+osJ+K9w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733231236; c=relaxed/simple;
	bh=K/FqCq7g6EhAhorLpjsjeaQoMRD4/prtZPirn0E1Mvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rPAihnOXT5IsXAVxtCpzKKnpwg3rkp91RIZGLL3BNuky6N2effjKXrAmtOtMC8mO8ioybAe3mKRzJDeRHmCQZYUOTbWgJEsSgQ8hJWwhFnX2mShbJp3wPmYbNX7afJRE9+8i9/mLSUjb/mJf224qHygiVNyBTOsMRZYA9vySruE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K5yFlQMx; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-434aabd688fso35502465e9.3;
        Tue, 03 Dec 2024 05:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733231231; x=1733836031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BIGUsaxc1kniQIUGCLJXlSbVgIskHyY7fhwT5YQn2uE=;
        b=K5yFlQMxZwM051iV9pydesafw93GoPSvtaXmnLzwEvmQPXfUDIE6OQ5s0RdBovUFzW
         7P2d31Pdx27vNsjQ6fa7RjyOGZ8Xb2tmRWXJ2fvD1KfMqlrKXZ1P0Kv/zKSkpspWILl0
         Y07K2ffkH3o8J1Sb+IbbE1jkNYpicJ7Cijph3CZvwlGL3t8UUNpe2KhEskWkMukETBW/
         OKzKsUaz9Yiy1cKztfxb7s8JTvCUIvzqmFCJDDTiznfYvN5QXaUs0qC5nXvEtkF2eDYJ
         FWKXd+iM5vU8Vnq3oMqjRDhP/cR8MR1F1PpeV9sLRJEL7YePW0/zy640Vu+wNPvIhpwr
         UGkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733231231; x=1733836031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BIGUsaxc1kniQIUGCLJXlSbVgIskHyY7fhwT5YQn2uE=;
        b=qrS+S17qSPt07ScDdxAY9LASMj2G94itHaINJnkkP9n7xJuz+HuWOfXKpngebNmpuq
         hrCKaYRWuAI4Mm/fDHhZbvURoFv0NmmbZPxNKvK5k/mWxZ0g250V+enYXyA4LfjA31Uw
         WC5MmSEhRRnEicLMAcApMTSvnLLpuT24KNMnDBh7aeeSFKj3vlSTO9wHRMaQXWf0vdKx
         IIjUi4Chux66kCaKBlnT/tw7tCsSAQSVSUBhkkvOQ1hrS4+y4YSIho5OXJHTRi3WsK/Z
         9ym1PS1KRv0TY8Y44lMO7/JEKebvi9nAJyBWVkm1jVqNw0gU63qLlf4zHvtCMw24k932
         by1A==
X-Forwarded-Encrypted: i=1; AJvYcCV2eUoWltUPQI5nfwVvU5oTyIbV6mf+0KC0BjudzBjdNY+6xGOUhmP3JmgPdXCwBtCwWZqCoB2ju6ZD0p+Daw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwiWsFrb2YGo9/iIK305NnfkbvFoRGrbMGfzFBKpVehJsdZGLa5
	cnDPnBH9I2rnpeu1WbRSJZevPm5EaJiee+f7gixbOT7xVL8pJJWpGiAdww==
X-Gm-Gg: ASbGnctMqM6N4gbLSGNxHcDj+EEDnIAY4WSlnNc5i8X3mM0CL/uC6q5h9ibPpTk0ZOm
	EWJONglcD9sQJ7LCIYfXUTlTJ0vpy4NUEsoX9GtCRQXGV68Hjz/x5eSAL8TD0r0qlnTeP9UhU0A
	qSh49mCarzHsEki9O0Q5LMpOx3E0ukDnRfuUuseU77c+QZ6Q1sFSlLZGrD44cLCdu/dvz1MEjYE
	2roJCHD1XxPJb+oajsXy+u7ZJRwW+KYeOVfOTsAIV0XHw/1MPAGxxgdBd/IEiuTU5k=
X-Google-Smtp-Source: AGHT+IF/XkLi9GfBNI6tIeWjXx0E7hiJyMvv7Smz9ky/Dm6c9+F5gczHzCH2Mppa3N8H0NSabtf04A==
X-Received: by 2002:a05:600c:3b8d:b0:431:6153:a258 with SMTP id 5b1f17b1804b1-434d3fa051emr1188115e9.13.1733231230349;
        Tue, 03 Dec 2024 05:07:10 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:6140:2ef3:aaa:55ca])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7e4d42sm219142365e9.37.2024.12.03.05.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 05:07:09 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v1 7/7] netlink: specs: wireless: add a spec for nl80211
Date: Tue,  3 Dec 2024 13:06:55 +0000
Message-ID: <20241203130655.45293-8-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241203130655.45293-1-donald.hunter@gmail.com>
References: <20241203130655.45293-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a rudimentary YNL spec for nl80211 that covers get-wiphy and
get-interface.

./tools/net/ynl/cli.py \
    --spec Documentation/netlink/specs/nl80211.yaml \
    --dump get-wiphy

./tools/net/ynl/cli.py \
    --spec Documentation/netlink/specs/nl80211.yaml \
    --dump get-interface

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/netlink/specs/nl80211.yaml | 1775 ++++++++++++++++++++++
 1 file changed, 1775 insertions(+)
 create mode 100644 Documentation/netlink/specs/nl80211.yaml

diff --git a/Documentation/netlink/specs/nl80211.yaml b/Documentation/netlink/specs/nl80211.yaml
new file mode 100644
index 000000000000..06e54233bb6a
--- /dev/null
+++ b/Documentation/netlink/specs/nl80211.yaml
@@ -0,0 +1,1775 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+
+name: nl80211
+protocol: genetlink-legacy
+
+doc:
+  Netlink API for 802.11 wireless devices
+
+definitions:
+  -
+    name: nl80211-commands
+    type: enum
+    entries:
+      - unspec
+      - get-wiphy
+      - set-wiphy
+      - new-wiphy
+      - del-wiphy
+      - get-interface
+      - set-interface
+      - new-interface
+      - del-interface
+      - get-key
+      - set-key
+      - new-key
+      - del-key
+      - get-beacon
+      - set-beacon
+      - new-beacon
+      - del-beacon
+      - get-station
+      - set-station
+      - new-station
+      - del-station
+      - get-mpath
+      - set-mpath
+      - new-mpath
+      - del-mpath
+      - set-bss
+      - set-reg
+      - req-set-reg
+      - get-mesh-config
+      - set-mesh-config
+      - set-mgmt-extra-ie
+      - get-reg
+      - get-scan
+      - trigger-scan
+      - new-scan-results
+      - scan-aborted
+      - reg-change
+      - authenticate
+      - associate
+      - deauthenticate
+      - disassociate
+      - michael-mic-failure
+      - reg-beacon-hint
+      - join-ibss
+      - leave-ibss
+      - testmode
+      - connect
+      - roam
+      - disconnect
+      - set-wiphy-netns
+      - get-survey
+      - new-survey-results
+      - set-pmksa
+      - del-pmksa
+      - flush-pmksa
+      - remain-on-channel
+      - cancel-remain-on-channel
+      - set-tx-bitrate-mask
+      - register-action
+      - action
+      - action-tx-status
+      - set-power-save
+      - get-power-save
+      - set-cqm
+      - notify-cqm
+      - set-channel
+      - set-wds-peer
+      - frame-wait-cancel
+      - join-mesh
+      - leave-mesh
+      - unprot-deauthenticate
+      - unprot-disassociate
+      - new-peer-candidate
+      - get-wowlan
+      - set-wowlan
+      - start-sched-scan
+      - stop-sched-scan
+      - sched-scan-results
+      - sched-scan-stopped
+      - set-rekey-offload
+      - pmksa-candidate
+      - tdls-oper
+      - tdls-mgmt
+      - unexpected-frame
+      - probe-client
+      - register-beacons
+      - unexpected-4-addr-frame
+      - set-noack-map
+      - ch-switch-notify
+      - start-p2p-device
+      - stop-p2p-device
+      - conn-failed
+      - set-mcast-rate
+      - set-mac-acl
+      - radar-detect
+      - get-protocol-features
+      - update-ft-ies
+      - ft-event
+      - crit-protocol-start
+      - crit-protocol-stop
+      - get-coalesce
+      - set-coalesce
+      - channel-switch
+      - vendor
+      - set-qos-map
+      - add-tx-ts
+      - del-tx-ts
+      - get-mpp
+      - join-ocb
+      - leave-ocb
+      - ch-switch-started-notify
+      - tdls-channel-switch
+      - tdls-cancel-channel-switch
+      - wiphy-reg-change
+      - abort-scan
+      - start-nan
+      - stop-nan
+      - add-nan-function
+      - del-nan-function
+      - change-nan-config
+      - nan-match
+      - set-multicast-to-unicast
+      - update-connect-params
+      - set-pmk
+      - del-pmk
+      - port-authorized
+      - reload-regdb
+      - external-auth
+      - sta-opmode-changed
+      - control-port-frame
+      - get-ftm-responder-stats
+      - peer-measurement-start
+      - peer-measurement-result
+      - peer-measurement-complete
+      - notify-radar
+      - update-owe-info
+      - probe-mesh-link
+      - set-tid-config
+      - unprot-beacon
+      - control-port-frame-tx-status
+      - set-sar-specs
+      - obss-color-collision
+      - color-change-request
+      - color-change-started
+      - color-change-aborted
+      - color-change-completed
+      - set-fils-aad
+      - assoc-comeback
+      - add-link
+      - remove-link
+      - add-link-sta
+      - modify-link-sta
+      - remove-link-sta
+      - set-hw-timestamp
+      - links-removed
+      - set-tid-to-link-mapping
+  -
+    name: feature-flags
+    type: flags
+    entries:
+      - sk-tx-status
+      - ht-ibss
+      - inactivity-timer
+      - cell-base-reg-hints
+      - p2p-device-needs-channel
+      - sae
+      - low-priority-scan
+      - scan-flush
+      - ap-scan
+      - vif-txpower
+      - need-obss-scan
+      - p2p-go-ctwin
+      - p2p-go-oppps
+      - reserved
+      - advertise-chan-limits
+      - full-ap-client-state
+      - userspace-mpm
+      - active-monitor
+      - ap-mode-chan-width-change
+      - ds-param-set-ie-in-probes
+      - wfa-tpc-ie-in-proves
+      - quiet
+      - tx-power-insertion
+      - ackto-estimation
+      - static-smps
+      - dynamic-smps
+      - supports-wmm-admission
+      - mac-on-create
+      - tdls-channel-switch
+      - scan-random-mac-addr
+      - sched-scan-random-mac-addr
+      - no-random-mac-addr
+  -
+    name: ieee80211-mcs-info
+    type: struct
+    members:
+      -
+        name: rx-mask
+        type: binary
+        len: 10
+      -
+        name: rx-highest
+        type: u16
+        byte-order: little-endian
+      -
+        name: tx-params
+        type: u8
+      -
+        name: reserved
+        type: binary
+        len: 3
+  -
+    name: ieee80211-vht-mcs-info
+    type: struct
+    members:
+      -
+        name: rx-mcs-map
+        type: u16
+        byte-order: little-endian
+      -
+        name: rx-highest
+        type: u16
+        byte-order: little-endian
+      -
+        name: tx-mcs-map
+        type: u16
+        byte-order: little-endian
+      -
+        name: tx-highest
+        type: u16
+        byte-order: little-endian
+  -
+    name: ieee80211-ht-cap
+    type: struct
+    members:
+      -
+        name: cap-info
+        type: u16
+        byte-order: little-endian
+      -
+        name: ampdu-params-info
+        type: u8
+      -
+        name: mcs
+        type: binary
+        struct: ieee80211-mcs-info
+      -
+        name: extended-ht-cap-info
+        type: u16
+        byte-order: little-endian
+      -
+        name: tx-bf-cap-info
+        type: u32
+        byte-order: little-endian
+      -
+        name: antenna-selection-info
+        type: u8
+  -
+    name: nl80211-channel-type
+    type: enum
+    entries:
+      - no-ht
+      - ht20
+      - ht40minus
+      - ht40plus
+  -
+    name: nl80211-sta-flag-update
+    type: struct
+    members:
+      -
+        name: mask
+        type: u32
+      -
+        name: set
+        type: u32
+  -
+    name: wlan-cipher-suites
+    type: enum
+    entries:
+      -
+        name: use-group
+        value: 0xfac00
+      -
+        name: wep40
+        value: 0xfac01
+      -
+        name: tkip
+        value: 0xfac02
+      -
+        name: reserved
+        value: 0xfac03
+      -
+        name: ccmp
+        value: 0xfac04
+      -
+        name: wep104
+        value: 0xfac05
+      -
+        name: aes-cmac
+        value: 0xfac06
+      -
+        name: gcmp
+        value: 0xfac08
+      -
+        name: gcmp-256
+        value: 0xfac09
+      -
+        name: ccmp-256
+        value: 0xfac0a
+      -
+        name: bip-gmac-128
+        value: 0xfac0b
+      -
+        name: bip-gmac-256
+        value: 0xfac0c
+      -
+        name: bip-cmac-256
+        value: 0xfac0d
+      -
+        name: sms4
+        value: 0x147201
+
+attribute-sets:
+  -
+    name: nl80211-attrs
+    attributes:
+      -
+        name: wiphy
+        type: u32
+      -
+        name: wiphy-name
+        type: string
+      -
+        name: ifindex
+        type: u32
+      -
+        name: ifname
+        type: string
+      -
+        name: iftype
+        type: u32
+      -
+        name: mac
+        type: binary
+        display-hint: mac
+      -
+        name: key-data
+        type: binary
+      -
+        name: key-idx
+        type: u8
+      -
+        name: key-cipher
+        type: u32
+      -
+        name: key-seq
+        type: binary
+      -
+        name: key-default
+        type: flag
+      -
+        name: beacon-interval
+        type: u32
+      -
+        name: dtim-period
+        type: u32
+      -
+        name: beacon-head
+        type: binary
+      -
+        name: beacon-tail
+        type: binary
+      -
+        name: sta-aid
+        type: u16
+      -
+        name: sta-flags
+        type: binary # TODO: nest
+      -
+        name: sta-listen-interval
+        type: u16
+      -
+        name: sta-supported-rates
+        type: binary
+      -
+        name: sta-vlan
+        type: u32
+      -
+        name: sta-info
+        type: binary # TODO: nest
+      -
+        name: wiphy-bands
+        type: nest
+        nested-attributes: wiphy-bands
+      -
+        name: mntr-flags
+        type: binary # TODO: nest
+      -
+        name: mesh-id
+        type: binary
+      -
+        name: sta-plink-action
+        type: u8
+      -
+        name: mpath-next-hop
+        type: binary
+        display-hint: mac
+      -
+        name: mpath-info
+        type: binary # TODO: nest
+      -
+        name: bss-cts-prot
+        type: u8
+      -
+        name: bss-short-preamble
+        type: u8
+      -
+        name: bss-short-slot-time
+        type: u8
+      -
+        name: ht-capability
+        type: binary
+      -
+        name: supported-iftypes
+        type: nest
+        nested-attributes: supported-iftypes
+      -
+        name: reg-alpha2
+        type: binary
+      -
+        name: reg-rules
+        type: binary # TODO: nest
+      -
+        name: mesh-config
+        type: binary # TODO: nest
+      -
+        name: bss-basic-rates
+        type: binary
+      -
+        name: wiphy-txq-params
+        type: binary # TODO: nest
+      -
+        name: wiphy-freq
+        type: u32
+      -
+        name: wiphy-channel-type
+        type: u32
+        enum: nl80211-channel-type
+      -
+        name: key-default-mgmt
+        type: flag
+      -
+        name: mgmt-subtype
+        type: u8
+      -
+        name: ie
+        type: binary
+      -
+        name: max-num-scan-ssids
+        type: u8
+      -
+        name: scan-frequencies
+        type: binary # TODO: nest
+      -
+        name: scan-ssids
+        type: binary # TODO: nest
+      -
+        name: generation
+        type: u32
+      -
+        name: bss
+        type: binary # TODO: nest
+      -
+        name: reg-initiator
+        type: u8
+      -
+        name: reg-type
+        type: u8
+      -
+        name: supported-commands
+        type: indexed-array
+        sub-type: u32
+        enum: nl80211-commands
+      -
+        name: frame
+        type: binary
+      -
+        name: ssid
+        type: binary
+      -
+        name: auth-type
+        type: u32
+      -
+        name: reason-code
+        type: u16
+      -
+        name: key-type
+        type: u32
+      -
+        name: max-scan-ie-len
+        type: u16
+      -
+        name: cipher-suites
+        type: binary
+        sub-type: u32
+        enum: wlan-cipher-suites
+      -
+        name: freq-before
+        type: binary # TODO: nest
+      -
+        name: freq-after
+        type: binary # TODO: nest
+      -
+        name: freq-fixed
+        type: flag
+      -
+        name: wiphy-retry-short
+        type: u8
+      -
+        name: wiphy-retry-long
+        type: u8
+      -
+        name: wiphy-frag-threshold
+        type: u32
+      -
+        name: wiphy-rts-threshold
+        type: u32
+      -
+        name: timed-out
+        type: flag
+      -
+        name: use-mfp
+        type: u32
+      -
+        name: sta-flags2
+        type: binary
+        struct: nl80211-sta-flag-update
+      -
+        name: control-port
+        type: flag
+      -
+        name: testdata
+        type: binary
+      -
+        name: privacy
+        type: flag
+      -
+        name: disconnected-by-ap
+        type: flag
+      -
+        name: status-code
+        type: u16
+      -
+        name: cipher-suites-pairwise
+        type: binary
+      -
+        name: cipher-suite-group
+        type: u32
+      -
+        name: wpa-versions
+        type: u32
+      -
+        name: akm-suites
+        type: binary
+      -
+        name: req-ie
+        type: binary
+      -
+        name: resp-ie
+        type: binary
+      -
+        name: prev-bssid
+        type: binary
+      -
+        name: key
+        type: binary # TODO: nest
+      -
+        name: keys
+        type: binary # TODO: nest
+      -
+        name: pid
+        type: u32
+      -
+        name: 4addr
+        type: u8
+      -
+        name: survey-info
+        type: binary # TODO: nest
+      -
+        name: pmkid
+        type: binary
+      -
+        name: max-num-pmkids
+        type: u8
+      -
+        name: duration
+        type: u32
+      -
+        name: cookie
+        type: u64
+      -
+        name: wiphy-coverage-class
+        type: u8
+      -
+        name: tx-rates
+        type: binary # TODO: nest
+      -
+        name: frame-match
+        type: binary
+      -
+        name: ack
+        type: flag
+      -
+        name: ps-state
+        type: u32
+      -
+        name: cqm
+        type: binary # TODO: nest
+      -
+        name: local-state-change
+        type: flag
+      -
+        name: ap-isolate
+        type: u8
+      -
+        name: wiphy-tx-power-setting
+        type: u32
+      -
+        name: wiphy-tx-power-level
+        type: u32
+      -
+        name: tx-frame-types
+        type: binary # TODO: nest
+      -
+        name: rx-frame-types
+        type: binary # TODO: nest
+      -
+        name: frame-type
+        type: u16
+      -
+        name: control-port-ethertype
+        type: flag
+      -
+        name: control-port-no-encrypt
+        type: flag
+      -
+        name: support-ibss-rsn
+        type: flag
+      -
+        name: wiphy-antenna-tx
+        type: u32
+      -
+        name: wiphy-antenna-rx
+        type: u32
+      -
+        name: mcast-rate
+        type: u32
+      -
+        name: offchannel-tx-ok
+        type: flag
+      -
+        name: bss-ht-opmode
+        type: u16
+      -
+        name: key-default-types
+        type: binary # TODO: nest
+      -
+        name: max-remain-on-channel-duration
+        type: u32
+      -
+        name: mesh-setup
+        type: binary # TODO: nest
+      -
+        name: wiphy-antenna-avail-tx
+        type: u32
+      -
+        name: wiphy-antenna-avail-rx
+        type: u32
+      -
+        name: support-mesh-auth
+        type: flag
+      -
+        name: sta-plink-state
+        type: u8
+      -
+        name: wowlan-triggers
+        type: binary # TODO: nest
+      -
+        name: wowlan-triggers-supported
+        type: nest
+        nested-attributes: wowlan-triggers-attrs
+      -
+        name: sched-scan-interval
+        type: u32
+      -
+        name: interface-combinations
+        type: indexed-array
+        sub-type: nest
+        nested-attributes: if-combination-attrs
+      -
+        name: software-iftypes
+        type: nest
+        nested-attributes: supported-iftypes
+      -
+        name: rekey-data
+        type: binary # TODO: nest
+      -
+        name: max-num-sched-scan-ssids
+        type: u8
+      -
+        name: max-sched-scan-ie-len
+        type: u16
+      -
+        name: scan-supp-rates
+        type: binary # TODO: nest
+      -
+        name: hidden-ssid
+        type: u32
+      -
+        name: ie-probe-resp
+        type: binary
+      -
+        name: ie-assoc-resp
+        type: binary
+      -
+        name: sta-wme
+        type: binary # TODO: nest
+      -
+        name: support-ap-uapsd
+        type: flag
+      -
+        name: roam-support
+        type: flag
+      -
+        name: sched-scan-match
+        type: binary # TODO: nest
+      -
+        name: max-match-sets
+        type: u8
+      -
+        name: pmksa-candidate
+        type: binary # TODO: nest
+      -
+        name: tx-no-cck-rate
+        type: flag
+      -
+        name: tdls-action
+        type: u8
+      -
+        name: tdls-dialog-token
+        type: u8
+      -
+        name: tdls-operation
+        type: u8
+      -
+        name: tdls-support
+        type: flag
+      -
+        name: tdls-external-setup
+        type: flag
+      -
+        name: device-ap-sme
+        type: u32
+      -
+        name: dont-wait-for-ack
+        type: flag
+      -
+        name: feature-flags
+        type: u32
+        enum: feature-flags
+        enum-as-flags: True
+      -
+        name: probe-resp-offload
+        type: u32
+      -
+        name: probe-resp
+        type: binary
+      -
+        name: dfs-region
+        type: u8
+      -
+        name: disable-ht
+        type: flag
+      -
+        name: ht-capability-mask
+        type: binary
+        struct: ieee80211-ht-cap
+      -
+        name: noack-map
+        type: u16
+      -
+        name: inactivity-timeout
+        type: u16
+      -
+        name: rx-signal-dbm
+        type: u32
+      -
+        name: bg-scan-period
+        type: u16
+      -
+        name: wdev
+        type: u64
+      -
+        name: user-reg-hint-type
+        type: u32
+      -
+        name: conn-failed-reason
+        type: u32
+      -
+        name: auth-data
+        type: binary
+      -
+        name: vht-capability
+        type: binary
+      -
+        name: scan-flags
+        type: u32
+      -
+        name: channel-width
+        type: u32
+      -
+        name: center-freq1
+        type: u32
+      -
+        name: center-freq2
+        type: u32
+      -
+        name: p2p-ctwindow
+        type: u8
+      -
+        name: p2p-oppps
+        type: u8
+      -
+        name: local-mesh-power-mode
+        type: u32
+      -
+        name: acl-policy
+        type: u32
+      -
+        name: mac-addrs
+        type: binary # TODO: nest
+      -
+        name: mac-acl-max
+        type: u32
+      -
+        name: radar-event
+        type: u32
+      -
+        name: ext-capa
+        type: binary
+      -
+        name: ext-capa-mask
+        type: binary
+      -
+        name: sta-capability
+        type: u16
+      -
+        name: sta-ext-capability
+        type: binary
+      -
+        name: protocol-features
+        type: u32
+      -
+        name: split-wiphy-dump
+        type: flag
+      -
+        name: disable-vht
+        type: flag
+      -
+        name: vht-capability-mask
+        type: binary
+      -
+        name: mdid
+        type: u16
+      -
+        name: ie-ric
+        type: binary
+      -
+        name: crit-prot-id
+        type: u16
+      -
+        name: max-crit-prot-duration
+        type: u16
+      -
+        name: peer-aid
+        type: u16
+      -
+        name: coalesce-rule
+        type: binary # TODO: nest
+      -
+        name: ch-switch-count
+        type: u32
+      -
+        name: ch-switch-block-tx
+        type: flag
+      -
+        name: csa-ies
+        type: binary # TODO: nest
+      -
+        name: cntdwn-offs-beacon
+        type: binary
+      -
+        name: cntdwn-offs-presp
+        type: binary
+      -
+        name: rxmgmt-flags
+        type: binary
+      -
+        name: sta-supported-channels
+        type: binary
+      -
+        name: sta-supported-oper-classes
+        type: binary
+      -
+        name: handle-dfs
+        type: flag
+      -
+        name: support-5-mhz
+        type: flag
+      -
+        name: support-10-mhz
+        type: flag
+      -
+        name: opmode-notif
+        type: u8
+      -
+        name: vendor-id
+        type: u32
+      -
+        name: vendor-subcmd
+        type: u32
+      -
+        name: vendor-data
+        type: binary
+      -
+        name: vendor-events
+        type: binary
+      -
+        name: qos-map
+        type: binary
+      -
+        name: mac-hint
+        type: binary
+        display-hint: mac
+      -
+        name: wiphy-freq-hint
+        type: u32
+      -
+        name: max-ap-assoc-sta
+        type: u32
+      -
+        name: tdls-peer-capability
+        type: u32
+      -
+        name: socket-owner
+        type: flag
+      -
+        name: csa-c-offsets-tx
+        type: binary
+      -
+        name: max-csa-counters
+        type: u8
+      -
+        name: tdls-initiator
+        type: flag
+      -
+        name: use-rrm
+        type: flag
+      -
+        name: wiphy-dyn-ack
+        type: flag
+      -
+        name: tsid
+        type: u8
+      -
+        name: user-prio
+        type: u8
+      -
+        name: admitted-time
+        type: u16
+      -
+        name: smps-mode
+        type: u8
+      -
+        name: oper-class
+        type: u8
+      -
+        name: mac-mask
+        type: binary
+        display-hint: mac
+      -
+        name: wiphy-self-managed-reg
+        type: flag
+      -
+        name: ext-features
+        type: binary
+      -
+        name: survey-radio-stats
+        type: binary
+      -
+        name: netns-fd
+        type: u32
+      -
+        name: sched-scan-delay
+        type: u32
+      -
+        name: reg-indoor
+        type: flag
+      -
+        name: max-num-sched-scan-plans
+        type: u32
+      -
+        name: max-scan-plan-interval
+        type: u32
+      -
+        name: max-scan-plan-iterations
+        type: u32
+      -
+        name: sched-scan-plans
+        type: binary # TODO: nest
+      -
+        name: pbss
+        type: flag
+      -
+        name: bss-select
+        type: binary # TODO: nest
+      -
+        name: sta-support-p2p-ps
+        type: u8
+      -
+        name: pad
+        type: binary
+      -
+        name: iftype-ext-capa
+        type: binary # TODO: nest
+      -
+        name: mu-mimo-group-data
+        type: binary
+      -
+        name: mu-mimo-follow-mac-addr
+        type: binary
+        display-hint: mac
+      -
+        name: scan-start-time-tsf
+        type: u64
+      -
+        name: scan-start-time-tsf-bssid
+        type: binary
+      -
+        name: measurement-duration
+        type: u16
+      -
+        name: measurement-duration-mandatory
+        type: flag
+      -
+        name: mesh-peer-aid
+        type: u16
+      -
+        name: nan-master-pref
+        type: u8
+      -
+        name: bands
+        type: u32
+      -
+        name: nan-func
+        type: binary # TODO: nest
+      -
+        name: nan-match
+        type: binary # TODO: nest
+      -
+        name: fils-kek
+        type: binary
+      -
+        name: fils-nonces
+        type: binary
+      -
+        name: multicast-to-unicast-enabled
+        type: flag
+      -
+        name: bssid
+        type: binary
+        display-hint: mac
+      -
+        name: sched-scan-relative-rssi
+        type: s8
+      -
+        name: sched-scan-rssi-adjust
+        type: binary
+      -
+        name: timeout-reason
+        type: u32
+      -
+        name: fils-erp-username
+        type: binary
+      -
+        name: fils-erp-realm
+        type: binary
+      -
+        name: fils-erp-next-seq-num
+        type: u16
+      -
+        name: fils-erp-rrk
+        type: binary
+      -
+        name: fils-cache-id
+        type: binary
+      -
+        name: pmk
+        type: binary
+      -
+        name: sched-scan-multi
+        type: flag
+      -
+        name: sched-scan-max-reqs
+        type: u32
+      -
+        name: want-1x-4-way-hs
+        type: flag
+      -
+        name: pmkr0-name
+        type: binary
+      -
+        name: port-authorized
+        type: binary
+      -
+        name: external-auth-action
+        type: u32
+      -
+        name: external-auth-support
+        type: flag
+      -
+        name: nss
+        type: u8
+      -
+        name: ack-signal
+        type: s32
+      -
+        name: control-port-over-nl80211
+        type: flag
+      -
+        name: txq-stats
+        type: nest
+        nested-attributes: txq-stats
+      -
+        name: txq-limit
+        type: u32
+      -
+        name: txq-memory-limit
+        type: u32
+      -
+        name: txq-quantum
+        type: u32
+      -
+        name: he-capability
+        type: binary
+      -
+        name: ftm-responder
+        type: binary # TODO: nest
+      -
+        name: ftm-responder-stats
+        type: binary # TODO: nest
+      -
+        name: timeout
+        type: u32
+      -
+        name: peer-measurements
+        type: binary # TODO: nest
+      -
+        name: airtime-weight
+        type: u16
+      -
+        name: sta-tx-power-setting
+        type: u8
+      -
+        name: sta-tx-power
+        type: s16
+      -
+        name: sae-password
+        type: binary
+      -
+        name: twt-responder
+        type: flag
+      -
+        name: he-obss-pd
+        type: binary # TODO: nest
+      -
+        name: wiphy-edmg-channels
+        type: u8
+      -
+        name: wiphy-edmg-bw-config
+        type: u8
+      -
+        name: vlan-id
+        type: u16
+      -
+        name: he-bss-color
+        type: binary # TODO: nest
+      -
+        name: iftype-akm-suites
+        type: binary # TODO: nest
+      -
+        name: tid-config
+        type: binary # TODO: nest
+      -
+        name: control-port-no-preauth
+        type: flag
+      -
+        name: pmk-lifetime
+        type: u32
+      -
+        name: pmk-reauth-threshold
+        type: u8
+      -
+        name: receive-multicast
+        type: flag
+      -
+        name: wiphy-freq-offset
+        type: u32
+      -
+        name: center-freq1-offset
+        type: u32
+      -
+        name: scan-freq-khz
+        type: binary # TODO: nest
+      -
+        name: he-6ghz-capability
+        type: binary
+      -
+        name: fils-discovery
+        type: binary # TOOD: nest
+      -
+        name: unsol-bcast-probe-resp
+        type: binary # TOOD: nest
+      -
+        name: s1g-capability
+        type: binary
+      -
+        name: s1g-capability-mask
+        type: binary
+      -
+        name: sae-pwe
+        type: u8
+      -
+        name: reconnect-requested
+        type: binary
+      -
+        name: sar-spec
+        type: binary # TODO: nest
+      -
+        name: disable-he
+        type: flag
+      -
+        name: obss-color-bitmap
+        type: u64
+      -
+        name: color-change-count
+        type: u8
+      -
+        name: color-change-color
+        type: u8
+      -
+        name: color-change-elems
+        type: binary # TODO: nest
+      -
+        name: mbssid-config
+        type: binary # TODO: nest
+      -
+        name: mbssid-elems
+        type: binary # TODO: nest
+      -
+        name: radar-background
+        type: flag
+      -
+        name: ap-settings-flags
+        type: u32
+      -
+        name: eht-capability
+        type: binary
+      -
+        name: disable-eht
+        type: flag
+      -
+        name: mlo-links
+        type: binary # TODO: nest
+      -
+        name: mlo-link-id
+        type: u8
+      -
+        name: mld-addr
+        type: binary
+        display-hint: mac
+      -
+        name: mlo-support
+        type: flag
+      -
+        name: max-num-akm-suites
+        type: binary
+      -
+        name: eml-capability
+        type: u16
+      -
+        name: mld-capa-and-ops
+        type: u16
+      -
+        name: tx-hw-timestamp
+        type: u64
+      -
+        name: rx-hw-timestamp
+        type: u64
+      -
+        name: td-bitmap
+        type: binary
+      -
+        name: punct-bitmap
+        type: u32
+      -
+        name: max-hw-timestamp-peers
+        type: u16
+      -
+        name: hw-timestamp-enabled
+        type: flag
+      -
+        name: ema-rnr-elems
+        type: binary # TODO: nest
+      -
+        name: mlo-link-disabled
+        type: flag
+      -
+        name: bss-dump-include-use-data
+        type: flag
+      -
+        name: mlo-ttlm-dlink
+        type: u16
+      -
+        name: mlo-ttlm-ulink
+        type: u16
+      -
+        name: assoc-spp-amsdu
+        type: flag
+      -
+        name: wiphy-radios
+        type: binary # TODO: nest
+      -
+        name: wiphy-interface-combinations
+        type: binary # TODO: nest
+      -
+        name: vif-radio-mask
+        type: u32
+  -
+    name: wiphy-bands
+    attributes:
+      -
+        name: 2ghz
+        doc: 2.4 GHz ISM band
+        value: 0
+        type: nest
+        nested-attributes: band-attrs
+      -
+        name: 5ghz
+        doc: around 5 GHz band (4.9 - 5.7 GHz)
+        type: nest
+        nested-attributes: band-attrs
+      -
+        name: 60ghz
+        doc: around 60 GHz band (58.32 - 69.12 GHz)
+        type: binary
+      -
+        name: 6ghz
+        type: binary
+      -
+        name: s1ghz
+        type: binary
+      -
+        name: lc
+        type: binary
+  -
+    name: band-attrs
+    attributes:
+      -
+        name: freqs
+        type: indexed-array
+        sub-type: nest
+        nested-attributes: frequency-attrs
+      -
+        name: rates
+        type: indexed-array
+        sub-type: nest
+        nested-attributes: bitrate-attrs
+      -
+        name: ht-mcs-set
+        type: binary
+        struct: ieee80211-mcs-info
+      -
+        name: ht-capa
+        type: u16
+      -
+        name: ht-ampdu-factor
+        type: u8
+      -
+        name: ht-ampdu-density
+        type: u8
+      -
+        name: vht-mcs-set
+        type: binary
+        struct: ieee80211-vht-mcs-info
+      -
+        name: vht-capa
+        type: u32
+      -
+        name: iftype-data
+        type: binary
+      -
+        name: edmg-channels
+        type: binary
+      -
+        name: edmg-bw-config
+        type: binary
+      -
+        name: s1g-mcs-nss-set
+        type: binary
+      -
+        name: s1g-capa
+        type: binary
+  -
+    name: bitrate-attrs
+    attributes:
+      -
+        name: rate
+        type: u32
+      -
+        name: 2ghz-shortpreamble
+        type: flag
+  -
+    name: frequency-attrs
+    attributes:
+      -
+        name: freq
+        type: u32
+      -
+        name: disabled
+        type: flag
+      -
+        name: no-ir
+        type: flag
+      -
+        name: no-ibss
+        type: flag
+      -
+        name: radar
+        type: flag
+      -
+        name: max-tx-power
+        type: u32
+      -
+        name: dfs-state
+        type: u32
+      -
+        name: dfs-time
+        type: binary
+      -
+        name: no-ht40-minus
+        type: binary
+      -
+        name: no-ht40-plus
+        type: binary
+      -
+        name: no-80mhz
+        type: binary
+      -
+        name: no-160mhz
+        type: binary
+      -
+        name: dfs-cac-time
+        type: binary
+      -
+        name: indoor-only
+        type: binary
+      -
+        name: ir-concurrent
+        type: binary
+      -
+        name: no-20mhz
+        type: binary
+      -
+        name: no-10mhz
+        type: binary
+      -
+        name: wmm
+        type: binary
+      -
+        name: no-he
+        type: binary
+      -
+        name: offset
+        type: u32
+      -
+        name: 1mhz
+        type: binary
+      -
+        name: 2mhz
+        type: binary
+      -
+        name: 4mhz
+        type: binary
+      -
+        name: 8mhz
+        type: binary
+      -
+        name: 16mhz
+        type: binary
+      -
+        name: no-320mhz
+        type: binary
+      -
+        name: no-eht
+        type: binary
+      -
+        name: psd
+        type: binary
+      -
+        name: dfs-concurrent
+        type: binary
+      -
+        name: no-6ghz-vlp-client
+        type: binary
+      -
+        name: no-6ghz-afc-client
+        type: binary
+      -
+        name: can-monitor
+        type: binary
+      -
+        name: allow-6ghz-vlp-ap
+        type: binary
+  -
+    name: if-combination-attrs
+    attributes:
+      -
+        name: limits
+        type: indexed-array
+        sub-type: nest
+        nested-attributes: iface-limit-attrs
+      -
+        name: maxnum
+        type: u32
+      -
+        name: sta-ap-bi-match
+        type: flag
+      -
+        name: num-channels
+        type: u32
+      -
+        name: radar-detect-widths
+        type: u32
+      -
+        name: radar-detect-regions
+        type: u32
+      -
+        name: bi-min-gcd
+        type: u32
+  -
+    name: iface-limit-attrs
+    attributes:
+      -
+        name: max
+        type: u32
+      -
+        name: types
+        type: nest
+        nested-attributes: supported-iftypes
+  -
+    name: supported-iftypes
+    attributes:
+      -
+        name: adhoc
+        type: flag
+      -
+        name: station
+        type: flag
+      -
+        name: ap
+        type: flag
+      -
+        name: ap-vlan
+        type: flag
+      -
+        name: wds
+        type: flag
+      -
+        name: monitor
+        type: flag
+      -
+        name: mesh-point
+        type: flag
+      -
+        name: p2p-client
+        type: flag
+      -
+        name: p2p-go
+        type: flag
+      -
+        name: p2p-device
+        type: flag
+      -
+        name: ocb
+        type: flag
+      -
+        name: nan
+        type: flag
+  -
+    name: txq-stats
+    attributes:
+      -
+        name: backlog-bytes
+        type: u32
+      -
+        name: backlog-packets
+        type: u32
+      -
+        name: flows
+        type: u32
+      -
+        name: drops
+        type: u32
+      -
+        name: ecn-marks
+        type: u32
+      -
+        name: overlimit
+        type: u32
+      -
+        name: overmemory
+        type: u32
+      -
+        name: collisions
+        type: u32
+      -
+        name: tx-bytes
+        type: u32
+      -
+        name: tx-packets
+        type: u32
+      -
+        name: max-flows
+        type: u32
+      -
+        name: txq-stats
+        type: u32
+  -
+    name: wowlan-triggers-attrs
+    attributes:
+      -
+        name: any
+        type: flag
+      -
+        name: disconnect
+        type: flag
+      -
+        name: magic-pkt
+        type: flag
+      -
+        name: pkt-pattern
+        type: flag
+      -
+        name: gtk-rekey-supported
+        type: flag
+      -
+        name: gtk-rekey-failure
+        type: flag
+      -
+        name: eap-ident-request
+        type: flag
+      -
+        name: 4way-handshake
+        type: flag
+      -
+        name: rfkill-release
+        type: flag
+      -
+        name: wakeup-pkt-80211
+        type: flag
+      -
+        name: wakeup-pkt-80211-len
+        type: flag
+      -
+        name: wakeup-pkt-8023
+        type: flag
+      -
+        name: wakeup-pkt-8023-len
+        type: flag
+      -
+        name: tcp-connection
+        type: flag
+      -
+        name: wakeup-tcp-match
+        type: flag
+      -
+        name: wakeup-tcp-connlost
+        type: flag
+      -
+        name: wakeup-tcp-nomoretokens
+        type: flag
+      -
+        name: net-detect
+        type: flag
+      -
+        name: net-detect-results
+        type: flag
+      -
+        name: unprotected-deauth-disassoc
+        type: flag
+
+operations:
+  enum-model: directional
+  list:
+    -
+      name: get-wiphy
+      doc: Get information about a wiphy or dump a list of all wiphys
+      attribute-set: nl80211-attrs
+      do:
+        request:
+          value: 1
+          attributes:
+            - wiphy
+        reply:
+          value: 3
+      dump:
+        request:
+          attributes:
+            - wiphy
+    -
+      name: get-interface
+      doc: Get information about an interface or dump a list of all interfaces
+      attribute-set: nl80211-attrs
+      do:
+        request:
+          value: 5
+          attributes:
+            - ifname
+        reply:
+          value: 7
+      dump:
+        request:
+          attributes:
+            - ifname
+
+mcast-groups:
+  list:
+    -
+      name: config
+    -
+      name: scan
+    -
+      name: regulatory
+    -
+      name: mlme
+    -
+      name: vendor
+    -
+      name: nan
+    -
+      name: testmode
-- 
2.47.1


