Return-Path: <linux-wireless+bounces-38798-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ijmtACWsTmqqSAIAu9opvQ
	(envelope-from <linux-wireless+bounces-38798-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Jul 2026 21:59:33 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6123072A09B
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Jul 2026 21:59:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=opCMbN+8;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38798-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38798-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6B3813028C50
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jul 2026 19:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EF33DEAD8;
	Wed,  8 Jul 2026 19:59:29 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881323CFF50
	for <linux-wireless@vger.kernel.org>; Wed,  8 Jul 2026 19:59:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783540769; cv=none; b=LmQwCAmpmsHK8ujM6YMqF1r0N1YWFw+t1jW61TMHJBpTvISgbFf2EwShOMh95XQuZJwPNcP83o9g0TZjSNTH3oArNuLAfEn8MXD7QlyZULnlaxV4hnmFItMyghd38QcH4Sy77YjbgpT6/UF0zOcw+/pWGbZM2kJhjxjOA/wzoCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783540769; c=relaxed/simple;
	bh=6b+OKTBXJLin46o7fI8ZjbLsknwlqT2udjnzde6o+/o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qe+uw/JmaWkuHfP3yvf+MII2ws/An520zBjcK8HEARGmxbcvDVeIIFkNH/DX1W+fQfh4aVDiWnanOoIfQLu1JENhMyzjOQyBOSMW1y4XrE+tyglV09qCIe8lrVPwqLln0beCdQwhiflzfRBIZXbdyKtWRLrnwSYrD70okL5+KhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=opCMbN+8; arc=none smtp.client-ip=209.85.214.171
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cace91f112so11718685ad.0
        for <linux-wireless@vger.kernel.org>; Wed, 08 Jul 2026 12:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783540768; x=1784145568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9SLXuxSjMjH+b7omN5N/fV/XznfXy4RVRoriiTuBMrw=;
        b=opCMbN+8ZY7ZN1UP3WlYgE0Hi1jheol8JbR4MLpilX+EujSZG3/lYJQ66qGvG4j7im
         m224nb1I9eYkhsORZ8PtD9BSF02Fj7btwXo4QbkyK6BrY4hJoNbT1K/Wyxjqw3SEJWXE
         4oZ50ktct6cpUxQRP1MIvpUE+RIYSDVHcG+IHAWATnZbmK+gAA6liY9cf+gmlnzrV7Z3
         oo3zFCdf9ngSo+O+X0lG7UE6yjORr84TV1OiQK2QeNbqfL+/3fZ2NIbXGqh/XYwmz95V
         OY5cZbbEag8z6OXnK0RleB2HYBZlXqT2nX+ibWA9Ec4p9DF/a9xzlQ5UkVyxvrRRqjhI
         pW7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783540768; x=1784145568;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9SLXuxSjMjH+b7omN5N/fV/XznfXy4RVRoriiTuBMrw=;
        b=ieosP1S+IqodjsgalmjUp+fvJYg5IiaZFRzYMRb+lMzlKgmjqltfMTY/HNVTRcNgEy
         AWaRhSb4qb7Iu1/9qqgaJV2NzSuUyr/p4qO6CRdhqcjhk5Zlm0UYPf9txqfG98eI6BGv
         KYwuQUG/OLAcD83Tg0dunetfqhcIU8vElijD6vTftxmy+cd9uR0MZEbRbAdvx1qKgjuY
         pxDL215RgpTlCGz+N9VtmNKJfTfINYZVzH/Fg9nSaCCBslgnjbfpVuC74L/L6BIcZzx1
         pIHm4jWksPskgVQiGDllToqZ4nIA3GVOx2OeG7ZEjKryTmwhGccx1D6ESuwQRDvHPE5j
         Ugvg==
X-Gm-Message-State: AOJu0YwmsAVBbT5dp/FFpFUCAKD70/hxF11Qb3EAG90JDW8p1um7/rxV
	aLx81bkEH13TcZslTZHmWPlg4HfymUINeWkiuigW+KRSkVDxaCfGrBT2uwRM/Nd9pK4VMg==
X-Gm-Gg: AfdE7cntLPJAexHHK40Jlit7Qj7qa/0bQdw5Bi/9u7bCd+3K8GmPh1v4Od4bAg93tMX
	x/te9XQlsISOUxTHbKV9YZ6bP3CzMyhfjRhAUiOl5lfWPdA7udhNK78Y96U+ZegSo6/NJsu9e6W
	BjWeTeCbz4/tgB9drrnc8jRaeWcaqWQGh8KNuozVCuxaQao6TjMcB+wu7mi1u42VLO4gPSVErTq
	uvryRGP8VK05+U+ymH1uwPfGjC4S0OydwsNfq5Q6Atw1APpiOx9fr9Bo9n/2eLrbNtUo+v61il/
	Xd75wgJMn4jJ7Vr3+2R7KIO60E75dQWm587hwWacx6uoH9lAn4yNwvKlpaLHKkOAx6w4j/LV3nK
	vEK8QJlYpXIVbVPltIUS1pEeXd8e63lZyjpvZmWxb4QpR/WS4at+PBjpvKEsyA+jhbAubrrpJhU
	XZXxi7uJ79Wfo0xx55ldTw8diBAg+PPJpd6TlYc/ugkvfJ3lnusEp0
X-Received: by 2002:a05:6a20:3ca3:b0:39f:acae:f12e with SMTP id adf61e73a8af0-3c0bced482bmr5675043637.22.1783540767624;
        Wed, 08 Jul 2026 12:59:27 -0700 (PDT)
Received: from KRHW1CJW23.bytedance.net ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174a8f521sm22585395eec.22.2026.07.08.12.59.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 08 Jul 2026 12:59:27 -0700 (PDT)
From: Zhao Li <enderaoelyther@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jaewan Kim <jaewan@google.com>,
	Daniel Gabay <daniel.gabay@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
	Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	John Crispin <john@phrozen.org>,
	Avinash Patil <patila@marvell.com>,
	Cathy Luo <cluo@marvell.com>,
	"John W. Linville" <linville@tuxdriver.com>,
	Aloka Dixit <quic_alokad@quicinc.com>,
	Zhao Li <enderaoelyther@gmail.com>
Subject: [PATCH 0/8] wifi: fix PMSR lifetime and frame validation issues
Date: Thu,  9 Jul 2026 03:59:03 +0800
Message-ID: <20260708195911.84365-1-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,chromium.org,dolcini.it,sipsolutions.net,google.com,oss.qualcomm.com,kernel.org,phrozen.org,marvell.com,tuxdriver.com,quicinc.com,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-38798-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:miriam.rachel.korenblit@intel.com,m:briannorris@chromium.org,m:francesco@dolcini.it,m:johannes@sipsolutions.net,m:jaewan@google.com,m:daniel.gabay@intel.com,m:emmanuel.grumbach@intel.com,m:benjamin.berg@intel.com,m:pagadala.yesu.anjaneyulu@intel.com,m:peddolla.reddy@oss.qualcomm.com,m:lorenzo@kernel.org,m:john@phrozen.org,m:patila@marvell.com,m:cluo@marvell.com,m:linville@tuxdriver.com,m:quic_alokad@quicinc.com,m:enderaoelyther@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[enderaoelyther@gmail.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enderaoelyther@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6123072A09B

Hi,

This series fixes a set of PMSR lifetime and management-frame
validation issues found while reviewing the wireless stack.

It is based on wireless/main commit cb8afea4655f ("wifi: cfg80211: bound
element ID read when checking non-inheritance").

The patches cover:

- PMSR lifetime handling in mac80211_hwsim and iwlwifi MLD: hwsim drops
  its saved cfg80211 request pointers once an abort succeeds, hwsim
  reports are accepted only from the registered wmediumd sender in the
  matching netgroup, and iwlwifi MLD gains an abort hook for active FTM
  PMSR requests.
- cfg80211 parsing of the optional FTM NOMINAL_TIME attribute.
- fixed-field validation for mac80211 probe-response countdown offsets,
  S1G individual TWT setup frames before driver callbacks, and mwifiex
  action frame category/action-code fields.
- an nl80211 color-change error path that leaked the beacon data parsed
  for the request; it is now freed as in the other beacon setters.

A larger local draft covered more issues, but the AP-template
double-free, MLE and assoc/MLME length validation, S1G beacon TSF, and
RNR cleanup fixes have since landed in wireless/main and are dropped
here.

Checks run:

- git am of patches 1-8 on wireless/main cb8afea4655f: clean
- scripts/checkpatch.pl --strict --no-signoff on this draft: clean
- VPS x86_64 KASAN build: bzImage plus iwlwifi MLD and mwifiex
  modules build clean
- VPS QEMU boot of the patched KASAN+hwsim kernel: a PMSR-capable
  hwsim radio completed PMSR_START; the stale REPORT_PMSR attempt was
  rejected with -EINVAL; no KASAN, use-after-free, out-of-bounds,
  general protection, or "unable to handle" splat was observed

Zhao Li (8):
  wifi: mac80211_hwsim: clear PMSR request state on abort
  wifi: mac80211_hwsim: authenticate PMSR report senders
  wifi: iwlwifi: mld: abort active PMSR requests
  wifi: cfg80211: guard optional PMSR nominal time
  wifi: mac80211: validate probe response countdown offsets
  wifi: mac80211: validate S1G TWT params before driver setup
  wifi: mwifiex: validate action frame fixed fields
  wifi: nl80211: clean up color-change beacon data on errors

 .../intel/iwlwifi/mld/ftm-initiator.c         | 22 +++++++++++++++++++
 .../intel/iwlwifi/mld/ftm-initiator.h         |  2 ++
 .../net/wireless/intel/iwlwifi/mld/mac80211.c | 10 +++++++++
 drivers/net/wireless/marvell/mwifiex/util.c   |  9 ++++++++
 .../wireless/virtual/mac80211_hwsim_main.c    | 19 +++++++++++++---
 net/mac80211/s1g.c                            |  4 ++++
 net/mac80211/tx.c                             |  4 ++++
 net/wireless/nl80211.c                        | 10 +++++----
 net/wireless/pmsr.c                           |  5 +++--
 9 files changed, 76 insertions(+), 9 deletions(-)

-- 
2.50.1 (Apple Git-155)

