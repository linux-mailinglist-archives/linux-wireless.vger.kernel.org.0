Return-Path: <linux-wireless+bounces-16175-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B77EF9EB5DD
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2024 17:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA78B16782F
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2024 16:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688331C2DAE;
	Tue, 10 Dec 2024 16:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PXEkG5qm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CA5237A2B;
	Tue, 10 Dec 2024 16:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733847311; cv=none; b=UXqeuh3DUnvvhWadesaVRZ5+eA3lcvGM8F55ctc7MP9VUloLechrY/9f/ABw9v3HQeJj0mRixKWnLfalRDoY0wluz66l5iyzUahko1RiZMTayoHLSrIYAcB0Yh1eEgdkfe0LVTvcPdqn1FjpVmV9tvt3BT17U71elO4TXQpvHNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733847311; c=relaxed/simple;
	bh=8Uqgb2fHinjNCwy66BvqLD3Ru4K88xyMePILKOpl6Tk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k4CF5LS62RriKByOBCotVM/xkEikOSrvpEwgxLVp7JqonVAGovR70jAB1kon9fsX0QCqZ7M2f+cjTBFlZ9FW0iI39Mu8LllBswiXh8eFbvrcxg8aFAzzxHMQj/YnRBgK2NixkAPgYBP7uWn5Kj/KVx9XxPcq3RD1sITeWP2TydI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PXEkG5qm; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-434a736518eso64294315e9.1;
        Tue, 10 Dec 2024 08:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733847306; x=1734452106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I/Re7QtAMsq+yAjF58tbutaG0NL6IjsfLrtFNa+tF0A=;
        b=PXEkG5qmcA065YKzZPb8GqY3co8zJfJEbbEzU6FqTeF8LEs7kqkiCdjBMQS20DByAL
         syb++pOOqf85UDcTBv6AyZS3JnTs8WcqCX0eJN1zwC7uj+ML6bfeCYqEOB6p06DHSdq4
         iCl9dPlDCMQJkTGeOwVTeWuWwr4Idsz3aBKlJ6jL5YgFCcn+qHpUYlmP6EH4P3GbhhTv
         5kaban4JiccoiZfU2VjBZ/LC3SJcim5FAjVFO7aUb6LmX81qZow86oSXiduo+YxomyDV
         SquTtmNLms2rMjFX9LH6BUxDUnLOEmobV2ImFdk6YD7J+bwtwz+buzhIO3OBKX6znOhn
         45nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733847306; x=1734452106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I/Re7QtAMsq+yAjF58tbutaG0NL6IjsfLrtFNa+tF0A=;
        b=VP8I2c3YJ7nLYJLK8ajY7FuaJwqMgFCqXjBtPJMRVhoRS7D6EFz+UJR1zryrjP9/zl
         c8fn8PN+jFFt0IdG0cTC+SO0aq3oP7sic7+RTLppS2F8SjnKZRlerJCQfgLJTrUnixfk
         +w34asxj6dgNqSzDNzq3YtLgM4eefxcSz5sR1ZeDcIiJuq1U2ocNGODbp5C5X2ourwGt
         f7Ut7r0NjFyvlvAzKMMA1ar6+e/QXXveqh/qjo7hQkOLk+KT1QwBLSHj/kB8kNvvwQ9h
         u2FTveQlgBQXF3jhvAt5ycf/DNG9pTdNSXEF9vu1JhkH2iGfTlm4JJuLIR550NVmN3di
         Fiug==
X-Forwarded-Encrypted: i=1; AJvYcCXlZoiiVF1+ku303m8jejExdjd+Cksr1U4xTymxXak7FwwjmvHbu4ocsD9PrwRZ2RN3waQiE8OgJuWP1GrOgg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrmmxy6lu+l/fRhywsyAt7GCNa+yCIJDW86QznNBdbMuwgKamw
	WmsDuV2goU6sUFm1M3lC7Cmz0GTca2cj7zvZBZAONe+Nkh6nVtqXryXoZA==
X-Gm-Gg: ASbGncsQkhoc8GYymr2QSLgQKj35CPOXrExi4XrdzRRzwOv5Mknv2x9lpKEgKcvjPZB
	9afCIDuhIt5McSb+YOQ5zHimcciRIA7ljlwVc0PVzASZWtqGwpdkC8hm+Nt1UrfIJP7q3P1FSH/
	wWjN1hSAiIrRj20/8CYluROQthPikr2Tjgbpq+RS9qJJB0Y8nL/+y827ANabvnpcdr/eT/RqBj9
	8PULQxnEsGTxw+PD1xsnymckA+d9MnZSQif7vJyMnGvPIQq2k0qkwv3OPTjJgSIuOK1phs3
X-Google-Smtp-Source: AGHT+IH2IBOkOAhozZU6dKK+jtSeXgglwkbBhODQKTn+RcMmCRgsdtiVFHx3QAFrfTfRpScgYqBIQA==
X-Received: by 2002:a05:600c:4511:b0:434:9fac:b157 with SMTP id 5b1f17b1804b1-434fff3de64mr58313115e9.13.1733847305970;
        Tue, 10 Dec 2024 08:15:05 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:75bb:8102:943a:2eb2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434f30bceadsm102383045e9.41.2024.12.10.08.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 08:15:05 -0800 (PST)
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
Subject: [PATCH net-next v2 7/7] netlink: specs: wireless: add a spec for nl80211
Date: Tue, 10 Dec 2024 16:14:48 +0000
Message-ID: <20241210161448.76799-8-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241210161448.76799-1-donald.hunter@gmail.com>
References: <20241210161448.76799-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a rudimentary YNL spec for nl80211 that covers get-wiphy,
get-interface and get-protocol-features.

./tools/net/ynl/cli.py \
    --spec Documentation/netlink/specs/nl80211.yaml \
    --do get-protocol-features
{'protocol-features': {'split-wiphy-dump'}}

./tools/net/ynl/cli.py \
    --spec Documentation/netlink/specs/nl80211.yaml \
    --dump get-wiphy --json '{ "split-wiphy-dump": true }'

./tools/net/ynl/cli.py \
    --spec Documentation/netlink/specs/nl80211.yaml \
    --dump get-interface

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/netlink/specs/nl80211.yaml | 1938 ++++++++++++++++++++++
 1 file changed, 1938 insertions(+)
 create mode 100644 Documentation/netlink/specs/nl80211.yaml

diff --git a/Documentation/netlink/specs/nl80211.yaml b/Documentation/netlink/specs/nl80211.yaml
new file mode 100644
index 000000000000..5c2650d88790
--- /dev/null
+++ b/Documentation/netlink/specs/nl80211.yaml
@@ -0,0 +1,1938 @@
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
+  -
+    name: protocol-features
+    type: flags
+    entries:
+      - split-wiphy-dump
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
+        type: nest
+        nested-attributes: nl80211-iftype-attrs
+      -
+        name: rx-frame-types
+        type: nest
+        nested-attributes: nl80211-iftype-attrs
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
+        type: nest
+        nested-attributes: sar-spec-attrs
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
+        type: nest
+        nested-attributes: band-attrs
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
+    name: iftype-data-attrs
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
+      -
+        name: he-6ghz-capa
+        type: binary
+      -
+        name: vendor-elems
+        type: binary
+  -
+    name: nl80211-iftype-attrs
+    attributes:
+      -
+        name: unspecified
+        type: nest
+        value: 0
+        nested-attributes: nl80211-attrs
+      -
+        name: adhoc
+        type: nest
+        nested-attributes: nl80211-attrs
+      -
+        name: station
+        type: nest
+        nested-attributes: nl80211-attrs
+      -
+        name: ap
+        type: nest
+        nested-attributes: nl80211-attrs
+      -
+        name: ap-vlan
+        type: nest
+        nested-attributes: nl80211-attrs
+      -
+        name: wds
+        type: nest
+        nested-attributes: nl80211-attrs
+      -
+        name: monitor
+        type: nest
+        nested-attributes: nl80211-attrs
+      -
+        name: mesh-point
+        type: nest
+        nested-attributes: nl80211-attrs
+      -
+        name: p2p-client
+        type: nest
+        nested-attributes: nl80211-attrs
+      -
+        name: p2p-go
+        type: nest
+        nested-attributes: nl80211-attrs
+      -
+        name: p2p-device
+        type: nest
+        nested-attributes: nl80211-attrs
+      -
+        name: ocb
+        type: nest
+        nested-attributes: nl80211-attrs
+      -
+        name: nan
+        type: nest
+        nested-attributes: nl80211-attrs
+  -
+    name: sar-spec-attrs
+    attributes:
+      -
+        name: type
+        type: u32
+      -
+        name: specs
+        type: indexed-array
+        sub-type: nest
+        nested-attributes: sar-attr-specs-attrs
+  -
+    name: sar-attr-specs-attrs
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
+    name: wmm-attrs
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
+      dump:
+        request:
+          attributes:
+            - wiphy
+            - wdev
+            - ifindex
+            - split-wiphy-dump
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
+    -
+      name: get-protocol-features
+      doc: Get information about supported protocol features
+      attribute-set: nl80211-attrs
+      do:
+        request:
+          value: 95
+        reply:
+          value: 95
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


