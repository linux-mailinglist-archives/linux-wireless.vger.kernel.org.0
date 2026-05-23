Return-Path: <linux-wireless+bounces-36827-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eD6jKAW5EWpupAYAu9opvQ
	(envelope-from <linux-wireless+bounces-36827-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 23 May 2026 16:26:13 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD105BF5B2
	for <lists+linux-wireless@lfdr.de>; Sat, 23 May 2026 16:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6149B301690C
	for <lists+linux-wireless@lfdr.de>; Sat, 23 May 2026 14:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE603A6B94;
	Sat, 23 May 2026 14:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/DjFZUA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913983A6B7E
	for <linux-wireless@vger.kernel.org>; Sat, 23 May 2026 14:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779546314; cv=none; b=UQHA022ZDiKARznYZe59lS2mwHnkrFc7ILhSeXISlsy0EqnDQR/q8mDkyypnc5QDvRFaYtm23urEt+NeU/g9tmMlF7NsrRgbcSCCvNdINDqHzvsh3AJML7XGFggL7hI6gqwP5KEetwly6oOe46re8GBn2kM3cKEO6ScmgjzJ678=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779546314; c=relaxed/simple;
	bh=fxeEt8WOJ8LIimxgCQJSjj/eTbmjRqeA5dJmCD7G15k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DGfsXnXaMQNWAoHLOUfqDhYre3X4wI7m37raJyKt5bonPkbinC3UcVC9tyz1PDJxiaC8QaH0ZNruktpJmUbbHIMpygSjOiiKGLdE/uRPzH4jSBVnLDQkMKm8TM5Jvn9zGGOg48/vT7bwTv+6K+AzKFTFRcx2cPm8psyd76hI6Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/DjFZUA; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8b701756684so99489746d6.1
        for <linux-wireless@vger.kernel.org>; Sat, 23 May 2026 07:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779546313; x=1780151113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JsSvQplB7jvK5Z1Ih49srVWHDqYh9wF4q8heYj0Wpvo=;
        b=J/DjFZUAP7r2Oqfeuf3Gc90NjKD73HXNb1UM8gRRjiQ2lpjd0sxv7k3KUx+ul/Rjck
         lQAcT2xMignzVZDVWpM19nPdYD/d9Pa4ZFOoBgmKTWLIFCKDzFVrCCHliUYt32m82FbQ
         INKiPVBQ9yEGHLYcvyEOs/F3SKDAs5pMpBTA3emBnTuE3HfaHxhFc+Q4shhhqJ30c5pm
         rx6ZMardSB7sP0vvDd9ZIpXFuqx4sAxIBiRawwIZLbbqOJdu/EjMTgfHEFVhF6ysH1xB
         Xur+zXDslG9179QE4QNdhTZopJBgRecFPo4iKH8zMcmIN3CIW8Y4HKvnBzB9rr4VjYIY
         Giag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779546313; x=1780151113;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JsSvQplB7jvK5Z1Ih49srVWHDqYh9wF4q8heYj0Wpvo=;
        b=Id/yqhS+EMP6FQfFTKBZ7tsDRb54fTkAfvqQOegp1qnrKU41KpVKsGqcraFUd7QQ8B
         rzOmlew3mgx9dVX1+XHNqqlWgrihdSW6hk59f/pHcyW49h/OAh13eU9QH937XmmZaTT/
         xRb1b3OMcue0W+jHUAzFijZQr5X2N5rtyuGbf9BbTS4FyEJphYMW7b2fBMXmg1vTiEes
         B52EXxzcpVJSbrqzFrqkguwGV1YRaI57X3ydtt1gqg2JI6u34WdekAyo0hh/Ronmiq8m
         gCqE02okypdhMJN0RoJAFYlrdjOZKsxokX4yZba1N03M+VFogfgswTDJ4yGBQ8C/fyoV
         lrKw==
X-Forwarded-Encrypted: i=1; AFNElJ9OeQU6yHpYgCgmsfbyTSEw+dshWoVNv2sPQcNPLVpnF95A3JNC/oPwaVu01Dq11ruylJ07kID9eMvqpjpU/g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzFbchLXv+3k3QF4ZZERpLUJyHNDQjC71nF2gwBCNfj38Bqsuei
	opc2pkJyzj1EMKi/DZKXUraTnS2y/e+v1lhZ5mAZea30XR5/SddiU1DFt/gC5RkMtJE=
X-Gm-Gg: Acq92OHQ03rSB2IUZJ20vFQHjVlVOFfCecrVaeemQ5i9c+EIvZpLEv+BvQUQM2E3lri
	s2UMN4iWLkDZa47ZgbSiHElGTX4NST/K18wIxS/t5qixlvFjrml0rFLmr5ZtUsTnyrPt3271AWe
	64IYgObE9H6XbamKo9CWfWRWvo23Skr0JYkibDv6wTU/+DGX0MsFN3Q27X4Ag+ng5UF1b2q483a
	INPyDrCgem55ZiBQu3OBq4TJSEiB8Vr4o99DEbOBO6cx5zabxpBmtbfHX3kaV7oY6qrU6NecJN0
	Usaj7pqf89q2knX80uIfC1Fu1ObxPaHJiuhvio3v8bWA6ne5WiCCeHVEQsjcMmgcqghFSfJKz8L
	DgQ3Vus/VJsHhvIxMOQs0PkdXFlYm0qppVxj+3NAvnHDlLI1jJcUpblnXt5vflsDzkVp9+b8NGV
	mbnmz3tAAufIpKlT1+SLgoVLnOD/0VwXHdjo4/rK10tuqowBz8eSxS+W7UPnSlturGO0bJhcx0V
	OiGb9xc8MGu25Ysvnua
X-Received: by 2002:a05:6214:498b:b0:8ae:6293:78ca with SMTP id 6a1803df08f44-8cc7bee818fmr122390976d6.18.1779546312568;
        Sat, 23 May 2026 07:25:12 -0700 (PDT)
Received: from mobile5 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc812e2018sm47914196d6.28.2026.05.23.07.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 07:25:12 -0700 (PDT)
From: Mike Bommarito <michael.bommarito@gmail.com>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: Johannes Berg <johannes.berg@intel.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] wifi: iwlwifi: mvm: handle SEC_UNKNOWN in non-AMPDU rx path
Date: Sat, 23 May 2026 10:24:38 -0400
Message-ID: <20260523142438.118284-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36827-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,linux-wireless@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2BD105BF5B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

iwl_mvm_rx_crypto() does not handle IWL_RX_MPDU_STATUS_SEC_UNKNOWN
explicitly in the non-AMPDU path: the switch's default case fires
"Unhandled alg: 0x71b" for what the firmware documents as a benign
condition (a cipher class not enumerated in the RX status field, or
frames arriving before key install).  On a Meteor Lake laptop with
an AX210 this produced 152 warnings across ~43.5 hours of normal
use; net_ratelimit spaced them out but did not silence them.  The
AMPDU sibling path at the top of the function already handles this
status explicitly.

Add an explicit SEC_UNKNOWN case that breaks to the final return 0
(passing the frame undecrypted to mac80211, matching the default's
effective behavior), with a dev_info_once() so the condition stays
observable at default log levels without per-frame spam, and an
IWL_DEBUG_DROP per occurrence mirroring the AMPDU handler.  Behavior
for every other status value is unchanged.

Link: https://lore.kernel.org/all/0e1a890d2896791d7291f0174cc0e96832d7ed33.camel@intel.com/
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Mike Bommarito <michael.bommarito@gmail.com>
---
Historical context (for reviewers, not the changelog)

The same warning was reported on Intel 9260 in 2019 [1].  Emmanuel
Grumbach acknowledged then that "this print is harmless really",
attributed it to a deprecated firmware flag, and suggested two
fixes: "remove the warning message entirely or limit it to unicast
packets only -- this has been merged in our internal repository and
it will be upstreamed following the regular process."  The unicast
restriction is now in tree (the default case guards on
!is_multicast_ether_addr() && net_ratelimit()), but the
remove-the-warning half never landed upstream.

This patch is the narrower of Grumbach's two suggestions: only
IWL_RX_MPDU_STATUS_SEC_UNKNOWN is special-cased, the existing
default-case warning is preserved for genuinely unknown status
values.

Test data

Pre-patch baseline on Framework Laptop 13 (Intel Core Ultra 5 125H,
AX210, Linux 7.1-rc4): 152 "Unhandled alg: 0x71b" entries in dmesg
across ~43.5 hours of mixed use, plus a burst of three within 70 ms
during a single re-association:

    [162152.782317] iwlwifi 0000:aa:00.0: Unhandled alg: 0x71b
    [162152.813440] iwlwifi 0000:aa:00.0: Unhandled alg: 0x71b
    [162152.844499] iwlwifi 0000:aa:00.0: Unhandled alg: 0x71b

Status decoding: 0x71b & 0x700 == SEC_UNKNOWN; low bits are
informational and vary between frames.

Post-patch: module rebuilt + reloaded.  Triggered scans and
nmcli reconnect cycles until a SEC_UNKNOWN frame was received.
The new switch case fired its dev_info_once exactly once:

    iwlwifi 0000:aa:00.0: RX SEC_UNKNOWN (status=0x707)

Zero "Unhandled alg" warnings observed during the same window.
A CONFIG_IWLWIFI_DEBUG=y build with IWL_DL_DROP enabled would
additionally show one IWL_DEBUG_DROP per qualifying frame; the
test kernel had CONFIG_IWLWIFI_DEBUG=n so those entries are absent
but the dev_info_once carries the per-controller signature.

 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 7f0b4f5daa21..f36e99c90ee3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -494,6 +494,19 @@ static int iwl_mvm_rx_crypto(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 		return 0;
 	case RX_MPDU_RES_STATUS_SEC_CMAC_GMAC_ENC:
 		break;
+	case IWL_RX_MPDU_STATUS_SEC_UNKNOWN:
+		/*
+		 * Firmware-indicated unknown cipher; the AMPDU case is
+		 * already handled at the top of this function.  For
+		 * non-AMPDU frames this is valid (cipher not enumerated
+		 * by the RX status field, or frame before key install).
+		 * Pass undecrypted to mac80211.
+		 */
+		dev_info_once(mvm->dev,
+			      "RX SEC_UNKNOWN (status=0x%x)\n", status);
+		IWL_DEBUG_DROP(mvm,
+			       "RX SEC_UNKNOWN (status=0x%x)\n", status);
+		break;
 	default:
 		/*
 		 * Sometimes we can get frames that were not decrypted
-- 
2.53.0


