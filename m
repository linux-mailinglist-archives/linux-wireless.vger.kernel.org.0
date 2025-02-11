Return-Path: <linux-wireless+bounces-18768-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D55F7A30B10
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 13:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA739188718D
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 12:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547671F9F62;
	Tue, 11 Feb 2025 12:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jooJYfwC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5BB2206B5;
	Tue, 11 Feb 2025 12:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739275317; cv=none; b=VhHX2tF50wHHbQcvqmeMJHcRQRrFeDSJiv3IKFq8FbRmzlm2+K1pn1QiEqS4MBlsvR8q0/NaQg3kmzHe+/gh4chRKUmGqtN1gx3hSwH8xFOSvbFcvosEuvlfic2d7Vg5/UmU9Qg8LepT0Yu5fgBZTJOWgKLNfCHcFOMkHQcGQ2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739275317; c=relaxed/simple;
	bh=5h3d+hDFZgiBzzKkkNO3eYJz7i3ksjWKPp/oakZoF7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R414mJHsni0c7GEcRJAXHF2kjaFrFteL755L+uqypD+tDAC3Cp00IdjRym8i8k9X6Ayo9vU8HCPtGKX0tWF+MsKhsmhj1crmzvYdMRXYjZXl+GLua9UsAwNmJdZkuEMFZmGI2jMUXrOmfx9ZRxKvHw55xkZBpFRBtZSKW9LByYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jooJYfwC; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-38dc9eba8a1so3428798f8f.1;
        Tue, 11 Feb 2025 04:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739275312; x=1739880112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cR78AkxIa2Az7+jLUIlRk9lQTkKC8dZbc8Nu2FqeNnc=;
        b=jooJYfwCU8bpOo/COtCslTJj0nEi01kSH0iZaZ6rqSsqMBDjY0eD52FIQd++OUUeSe
         k4DAa66K4nLyZ+5/gI0fU+f2Qn40TEzpdqzUmdvXIOlBwHexq+bCzYz696VuSpnBGoEz
         pZ/XY6EByJNB/6AE6nowRiXDxgP/T/96rZ6GzHy2evXLqr2c13Y1uhncUa4SAwoUOR1k
         izgQBQljG1YHtRZDRv64TeYcCqKMk6iIY15pD9jq4lRJk++xOcVYbkylqQ+8oQfjA9rc
         lEo4LAhEpZrB5trF1kdfexQSfcHz/YilQGwpe77PeNOdrYDXtqtl9a7JxeFnS4dLfhxv
         kR4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739275312; x=1739880112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cR78AkxIa2Az7+jLUIlRk9lQTkKC8dZbc8Nu2FqeNnc=;
        b=OeShEM3MEhxsf4isVJdHYpL/c8blg9FG7n8YM23rXd0hnqUFpxad0LZhvv2MjEOo1C
         bXCy195ncah2fyVN7wx1ZnFE3A3RwPSltmsBCb0oyJvFG6/oSafmCH9dU7Etp1JNXcVl
         JlFoe8akT8x+hXG/uRGAhaP5BZzfR/J4xyoNWImpbHs3i2IdXtQG3I5lTpSSiKL9hYpT
         iwO+kwmJ3x85evDhAFbyZfEOGwC4NoWu0WzDgXy6FXIjTjw5PiZsgxxYNpbUAVOwmLmH
         SAPVYufVZEIh+7peRn2mWHjgh6LugceSInuxU7S9okmVPhRvzVOufeVP91SGLwiuDQLF
         KW7w==
X-Forwarded-Encrypted: i=1; AJvYcCUbVmKV9bk8Js1whRt//WSr1NOsZM80H6RbcWg1NFKkackZ8dkuuQ0cL3HSKqMJvH/ZCkqwRttHAZsL/LBdRA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxV89J6NQeQMndgqoRiO99KYDeXB7+7ssJzS+X+20VSpIRiIY1V
	U3N9TwbjcpuvMwQouMBLjR4G2Z0T1bxSRagApBQT6SxjspSaKGeb7aziEQ==
X-Gm-Gg: ASbGnctLM8DJtisy57c/4Y/acsoVkoh2JHBklW+qvsq7BoTQrTJJSoCWJpe474SoYE0
	qRZk70zrbvAbZLXNb2jqLjw6MKFAlKp6BRUYpcw2H0UG8O+GyYaTo0CqSfGBa3+08QiuofoVH+2
	rihoIWQ31WwIiyC6uYvC5rCLXJaZAIlDgwwhsqtIoH5CMNb8to9sIZMXzkMCx/DKfmWbldyXya0
	Zd4RP9T+b4GciH+IBMw/AEDhHlI3Iggn5yv9sCKsAjhl1dbFzajWjAInGkPhzkLpPBG3bafpkVf
	9nPulq34v5o0YbcVD8xPNAPfdbLhcVe+xQ==
X-Google-Smtp-Source: AGHT+IHSCYuAx911i65Wa/bhjFfYraBmUr0//nvn3VkY/9Q6cMRGNt29yeI/+/J71dDcXnpLJqM1zQ==
X-Received: by 2002:a5d:6da8:0:b0:38d:e57e:d21 with SMTP id ffacd0b85a97d-38de57e0e7dmr1750312f8f.30.1739275311340;
        Tue, 11 Feb 2025 04:01:51 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:ac07:4372:f96c:546e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dc933ff9fsm12466658f8f.96.2025.02.11.04.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 04:01:50 -0800 (PST)
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
Subject: [PATCH net-next v5 10/10] netlink: specs: wireless: add a spec for nl80211
Date: Tue, 11 Feb 2025 12:01:27 +0000
Message-ID: <20250211120127.84858-11-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250211120127.84858-1-donald.hunter@gmail.com>
References: <20250211120127.84858-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a rudimentary YNL spec for nl80211 that covers get-wiphy,
get-interface and get-protocol-features.

./tools/net/ynl/pyynl/cli.py --family nl80211 \
    --do get-protocol-features
{'protocol-features': {'split-wiphy-dump'}}

./tools/net/ynl/pyynl/cli.py --family nl80211 \
    --dump get-wiphy --json '{ "split-wiphy-dump": true }'

./tools/net/ynl/pyynl/cli.py --family nl80211 \
    --dump get-interface

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
Acked-by: Johannes Berg <johannes@sipsolutions.net>
---
 Documentation/netlink/specs/nl80211.yaml | 2000 ++++++++++++++++++++++
 tools/net/ynl/Makefile.deps              |    1 +
 2 files changed, 2001 insertions(+)
 create mode 100644 Documentation/netlink/specs/nl80211.yaml

diff --git a/Documentation/netlink/specs/nl80211.yaml b/Documentation/netlink/specs/nl80211.yaml
new file mode 100644
index 000000000000..1ec49c3562cd
--- /dev/null
+++ b/Documentation/netlink/specs/nl80211.yaml
@@ -0,0 +1,2000 @@
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
+    name: commands
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
+      - wfa-tpc-ie-in-probes
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
+    name: channel-type
+    type: enum
+    entries:
+      - no-ht
+      - ht20
+      - ht40minus
+      - ht40plus
+  -
+    name: sta-flag-update
+    type: struct
+    members:
+      -
+        name: mask
+        type: u32
+      -
+        name: set
+        type: u32
+  -
+    name: protocol-features
+    type: flags
+    entries:
+      - split-wiphy-dump
+
+attribute-sets:
+  -
+    name: nl80211-attrs
+    name-prefix: nl80211-attr-
+    enum-name: nl80211-attrs
+    attr-max-name: num-nl80211-attr
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
+        enum: channel-type
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
+        enum: commands
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
+        display-hint: hex
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
+        struct: sta-flag-update
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
+        type: nest
+        nested-attributes: iftype-attrs
+      -
+        name: rx-frame-types
+        type: nest
+        nested-attributes: iftype-attrs
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
+        nested-attributes: if-combination-attributes
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
+        enum: protocol-features
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
+        name: want-1x-4way-hs
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
+        nested-attributes: txq-stats-attrs
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
+        type: nest
+        nested-attributes: sar-attributes
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
+    name: frame-type-attrs
+    subset-of: nl80211-attrs
+    attributes:
+      -
+        name: frame-type
+  -
+    name: wiphy-bands
+    name-prefix: nl80211-band-
+    attr-max-name: num-nl80211-bands
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
+        type: nest
+        nested-attributes: band-attrs
+      -
+        name: 6ghz
+        type: nest
+        nested-attributes: band-attrs
+      -
+        name: s1ghz
+        type: nest
+        nested-attributes: band-attrs
+      -
+        name: lc
+        type: nest
+        nested-attributes: band-attrs
+  -
+    name: band-attrs
+    enum-name: nl80211-band-attr
+    name-prefix: nl80211-band-attr-
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
+        type: indexed-array
+        sub-type: nest
+        nested-attributes: iftype-data-attrs
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
+    name-prefix: nl80211-bitrate-attr-
+    attributes:
+      -
+        name: rate
+        type: u32
+      -
+        name: 2ghz-shortpreamble
+        type: flag
+  -
+    name: frequency-attrs
+    name-prefix: nl80211-frequency-attr-
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
+        name-prefix: __nl80211-frequency-attr-
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
+        type: indexed-array
+        sub-type: nest
+        nested-attributes: wmm-attrs
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
+    name: if-combination-attributes
+    enum-name: nl80211-if-combination-attrs
+    name-prefix: nl80211-iface-comb-
+    attr-max-name: max-nl80211-iface-comb
+    attributes:
+      -
+        name: limits
+        type: indexed-array
+        sub-type: nest
+        nested-attributes: iface-limit-attributes
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
+    name: iface-limit-attributes
+    enum-name: nl80211-iface-limit-attrs
+    name-prefix: nl80211-iface-limit-
+    attr-max-name: max-nl80211-iface-limit
+    attributes:
+      -
+        name: max
+        type: u32
+      -
+        name: types
+        type: nest
+        nested-attributes: supported-iftypes
+  -
+    name: iftype-data-attrs
+    name-prefix: nl80211-band-iftype-attr-
+    attributes:
+      -
+        name: iftypes
+        type: binary
+      -
+        name: he-cap-mac
+        type: binary
+      -
+        name: he-cap-phy
+        type: binary
+      -
+        name: he-cap-mcs-set
+        type: binary
+      -
+        name: he-cap-ppe
+        type: binary
+      -
+        name: he-6ghz-capa
+        type: binary
+      -
+        name: vendor-elems
+        type: binary
+      -
+        name: eht-cap-mac
+        type: binary
+      -
+        name: eht-cap-phy
+        type: binary
+      -
+        name: eht-cap-mcs-set
+        type: binary
+      -
+        name: eht-cap-ppe
+        type: binary
+  -
+    name: iftype-attrs
+    enum-name: nl80211-iftype
+    name-prefix: nl80211-iftype-
+    attributes:
+      -
+        name: unspecified
+        type: nest
+        value: 0
+        nested-attributes: frame-type-attrs
+      -
+        name: adhoc
+        type: nest
+        nested-attributes: frame-type-attrs
+      -
+        name: station
+        type: nest
+        nested-attributes: frame-type-attrs
+      -
+        name: ap
+        type: nest
+        nested-attributes: frame-type-attrs
+      -
+        name: ap-vlan
+        type: nest
+        nested-attributes: frame-type-attrs
+      -
+        name: wds
+        type: nest
+        nested-attributes: frame-type-attrs
+      -
+        name: monitor
+        type: nest
+        nested-attributes: frame-type-attrs
+      -
+        name: mesh-point
+        type: nest
+        nested-attributes: frame-type-attrs
+      -
+        name: p2p-client
+        type: nest
+        nested-attributes: frame-type-attrs
+      -
+        name: p2p-go
+        type: nest
+        nested-attributes: frame-type-attrs
+      -
+        name: p2p-device
+        type: nest
+        nested-attributes: frame-type-attrs
+      -
+        name: ocb
+        type: nest
+        nested-attributes: frame-type-attrs
+      -
+        name: nan
+        type: nest
+        nested-attributes: frame-type-attrs
+  -
+    name: sar-attributes
+    enum-name: nl80211-sar-attrs
+    name-prefix: nl80211-sar-attr-
+    attributes:
+      -
+        name: type
+        type: u32
+      -
+        name: specs
+        type: indexed-array
+        sub-type: nest
+        nested-attributes: sar-specs
+  -
+    name: sar-specs
+    enum-name: nl80211-sar-specs-attrs
+    name-prefix: nl80211-sar-attr-specs-
+    attributes:
+      -
+        name: power
+        type: s32
+      -
+        name: range-index
+        type: u32
+      -
+        name: start-freq
+        type: u32
+      -
+        name: end-freq
+        type: u32
+  -
+    name: supported-iftypes
+    enum-name: nl80211-iftype
+    name-prefix: nl80211-iftype-
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
+    name: txq-stats-attrs
+    name-prefix: nl80211-txq-stats-
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
+  -
+    name: wmm-attrs
+    enum-name: nl80211-wmm-rule
+    name-prefix: nl80211-wmmr-
+    attributes:
+      -
+        name: cw-min
+        type: u16
+      -
+        name: cw-max
+        type: u16
+      -
+        name: aifsn
+        type: u8
+      -
+        name: txop
+        type: u16
+  -
+    name: wowlan-triggers-attrs
+    enum-name: nl80211-wowlan-triggers
+    name-prefix: nl80211-wowlan-trig-
+    attr-max-name: max-nl80211-wowlan-trig
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
+      doc: |
+        Get information about a wiphy or dump a list of all wiphys. Requests to dump get-wiphy
+        should unconditionally include the split-wiphy-dump flag in the request.
+      attribute-set: nl80211-attrs
+      do:
+        request:
+          value: 1
+          attributes:
+            - wiphy
+            - wdev
+            - ifindex
+        reply:
+          value: 3
+          attributes: &wiphy-reply-attrs
+            - bands
+            - cipher-suites
+            - control-port-ethertype
+            - ext-capa
+            - ext-capa-mask
+            - ext-features
+            - feature-flags
+            - generation
+            - ht-capability-mask
+            - interface-combinations
+            - mac
+            - max-csa-counters
+            - max-match-sets
+            - max-num-akm-suites
+            - max-num-pmkids
+            - max-num-scan-ssids
+            - max-num-sched-scan-plans
+            - max-num-sched-scan-ssids
+            - max-remain-on-channel-duration
+            - max-scan-ie-len
+            - max-scan-plan-interval
+            - max-scan-plan-iterations
+            - max-sched-scan-ie-len
+            - offchannel-tx-ok
+            - rx-frame-types
+            - sar-spec
+            - sched-scan-max-reqs
+            - software-iftypes
+            - support-ap-uapsd
+            - supported-commands
+            - supported-iftypes
+            - tdls-external-setup
+            - tdls-support
+            - tx-frame-types
+            - txq-limit
+            - txq-memory-limit
+            - txq-quantum
+            - txq-stats
+            - vht-capability-mask
+            - wiphy
+            - wiphy-antenna-avail-rx
+            - wiphy-antenna-avail-tx
+            - wiphy-antenna-rx
+            - wiphy-antenna-tx
+            - wiphy-bands
+            - wiphy-coverage-class
+            - wiphy-frag-threshold
+            - wiphy-name
+            - wiphy-retry-long
+            - wiphy-retry-short
+            - wiphy-rts-threshold
+            - wowlan-triggers-supported
+      dump:
+        request:
+          attributes:
+            - wiphy
+            - wdev
+            - ifindex
+            - split-wiphy-dump
+        reply:
+          attributes: *wiphy-reply-attrs
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
+          attributes: &interface-reply-attrs
+            - ifname
+            - iftype
+            - ifindex
+            - wiphy
+            - wdev
+            - mac
+            - generation
+            - txq-stats
+            - 4addr
+      dump:
+        request:
+          attributes:
+            - ifname
+        reply:
+          attributes: *interface-reply-attrs
+    -
+      name: get-protocol-features
+      doc: Get information about supported protocol features
+      attribute-set: nl80211-attrs
+      do:
+        request:
+          value: 95
+          attributes:
+            - protocol-features
+        reply:
+          value: 95
+          attributes:
+            - protocol-features
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
diff --git a/tools/net/ynl/Makefile.deps b/tools/net/ynl/Makefile.deps
index d027a07c1e2c..f3269ce39e5b 100644
--- a/tools/net/ynl/Makefile.deps
+++ b/tools/net/ynl/Makefile.deps
@@ -23,6 +23,7 @@ CFLAGS_handshake:=$(call get_hdr_inc,_LINUX_HANDSHAKE_H,handshake.h)
 CFLAGS_mptcp_pm:=$(call get_hdr_inc,_LINUX_MPTCP_PM_H,mptcp_pm.h)
 CFLAGS_net_shaper:=$(call get_hdr_inc,_LINUX_NET_SHAPER_H,net_shaper.h)
 CFLAGS_netdev:=$(call get_hdr_inc,_LINUX_NETDEV_H,netdev.h)
+CFLAGS_nl80211:=$(call get_hdr_inc,__LINUX_NL802121_H,nl80211.h)
 CFLAGS_nlctrl:=$(call get_hdr_inc,__LINUX_GENERIC_NETLINK_H,genetlink.h)
 CFLAGS_nfsd:=$(call get_hdr_inc,_LINUX_NFSD_NETLINK_H,nfsd_netlink.h)
 CFLAGS_ovs_datapath:=$(call get_hdr_inc,__LINUX_OPENVSWITCH_H,openvswitch.h)
-- 
2.48.1


