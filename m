Return-Path: <linux-wireless+bounces-38801-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hK33NJOsTmrOSAIAu9opvQ
	(envelope-from <linux-wireless+bounces-38801-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Jul 2026 22:01:23 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B2172A0DF
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Jul 2026 22:01:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=DhD5CZN+;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38801-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38801-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB3E0305777C
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jul 2026 19:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9D13E1233;
	Wed,  8 Jul 2026 19:59:53 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDB13E0C47
	for <linux-wireless@vger.kernel.org>; Wed,  8 Jul 2026 19:59:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783540793; cv=none; b=giCcoE8Ms7ggXn3vI77XU8dvugNFiCJfRCGDn4HaOpVkBdB0yQKsf1AOvpnVgzFEfs0GouVLpGXJtkW8n8Bqo1F7bUp5dYMvGkZXBAwVOWuFiiSIKEmeNrPUmVeovRhHMI+/NR+CXHv4DdMuA8bpnqbYFhW+e2IoDADLdHVkd6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783540793; c=relaxed/simple;
	bh=Uf9pnj9cZCbPf/zyBG62pNQsDuDlVajrDgR/OyoOBs0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IODs+QVdmx2F189DWlEExvzLhusastvN+E9BkkP47VIofD580939fLgFLkFx4jbXYhTKdd9s9mgsIn8eA2xNHodlKvcHdmnBGHb68anxCMP3a/3G36KjflXVps1lDdi28QIEn3ArR16Augka+8tWtHhXlWxm7BjBineFV5Bv3hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DhD5CZN+; arc=none smtp.client-ip=209.85.214.172
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2c9b1edf2bdso16428465ad.1
        for <linux-wireless@vger.kernel.org>; Wed, 08 Jul 2026 12:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783540791; x=1784145591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+/ey8QeZ6+UPoe0vo9GrwAwJd/n64hr2yFgoo4y/5Ps=;
        b=DhD5CZN+HdXAlvLwuovbzDczT9+hGf17YgFmLd+4IIPVRtT7q2/GkuhhPGfuI8A0co
         wsdWa+/0qEn20Exe0DYu5/9zVrRrrJJAGvHhQo9a+/8Q1KxhpEuRzh2Kr+hTL5TC5EAU
         MwcK2nOrGEYMp+n8zzdUBQqUHJdheqx9jLlLdLgWZ7Hyzq4tWP0d1FYBAVMebXXFy83W
         wGFbJ5RHCeZhzqkyabpesk2CP/iygMAISOrdAdSJ+ywoZjMvYvwyYMF2kx1L6emZ9xhC
         xM0ymJ2tp4EVSbXscI3+rWG9CnUiKrhLGC5KkXFfIaUFnfJG+l/EJBvhSk5k7Sd5ctfy
         PHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783540791; x=1784145591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+/ey8QeZ6+UPoe0vo9GrwAwJd/n64hr2yFgoo4y/5Ps=;
        b=rtdosd6JsW2rr+0xBpj63DL8E4RPKSzaJf675b/yJSYPwSHXWEaZNs4Jqu6wv27vKK
         WY4jiAPfxuTqDAtQdc9qf11AoxbKwvGoiNISs4giB1lHHKl3TU95l9rgNNIKk7SboLn0
         mF/I00Y0Zab01PuJALCXKaTENadfl9/kXYTNPwtydoTmj3a0titF+x6zNWt2ZXqFase6
         pjq5T9HSSVyGN6UJu6g0InYviiIWNmf+ivNe00JEIVKeReV15zoolIUmF+hDAkImS5AA
         T04mvnNz5vLPMAo/Jiu+Lx/v0WsRZNuXB0a6aGmJ7wzMkR/69UIUPvRMkatt02ChfEuj
         WvAA==
X-Gm-Message-State: AOJu0YxS0YU0yeeIo6Jwxe5tyvNvJTgjOpb8oCTfLxxohkxZFuQAJPW/
	naJ6IOzBazbSgTkBQOshHcbphLp7mKkYjfQV6zBt8Davc9qycyqZXkti1SSvekcOMoMxNQ==
X-Gm-Gg: AfdE7clEw3NNikRwYMLQdb3X5WcyzLBOh39cdJxN2PQ2yLaVqGd4IBScTkxD4vSsdwG
	cMvzgsX9lbVpJTPS1UZoset69GpK1angQHA0MB6f0YHUC+9+gS/KYZJf99cDSLb9lmvFiPBJ7Jk
	PT+Uzuz9hDGuUZMgH+1xD5PYJJEBfpOvHj7soQbNzxTd5+6y1pNiKaPCVSDuDQatgXLRLp5bCV2
	+V5pYPD5CCREdmxmef3tEF6SRMCOQX6BIMFD2qJf5lCXWLIuClwPybNUaPt0cALi+HywdHfPFai
	rD2QUnknML4BJwESfp7Y9B+drhsb/gW5mt9kPK+y0CqnrVgE3rEnERhgsrbHO+vuWYTRBaWLA3j
	9pT0aUENISr6MBZQVFlFkbsIBDHnSqNcRmIYnMrrRqRrkOj6jrQumxaa9aCB6Y1FyR6Su/tVamb
	jDaUqL0mqZTIq7QJhJImDeD86mPrzGxDZn2PZPdJF2tiNnxtaV6vNt
X-Received: by 2002:a05:6a21:e8a:b0:3bf:bfd0:2a11 with SMTP id adf61e73a8af0-3c0bcbc03c5mr4785352637.43.1783540791051;
        Wed, 08 Jul 2026 12:59:51 -0700 (PDT)
Received: from KRHW1CJW23.bytedance.net ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174a8f521sm22585395eec.22.2026.07.08.12.59.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 08 Jul 2026 12:59:50 -0700 (PDT)
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
	Zhao Li <enderaoelyther@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 3/8] wifi: iwlwifi: mld: abort active PMSR requests
Date: Thu,  9 Jul 2026 03:59:06 +0800
Message-ID: <20260708195911.84365-4-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260708195911.84365-1-enderaoelyther@gmail.com>
References: <20260708195911.84365-1-enderaoelyther@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,chromium.org,dolcini.it,sipsolutions.net,google.com,oss.qualcomm.com,kernel.org,phrozen.org,marvell.com,tuxdriver.com,quicinc.com,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-38801-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:miriam.rachel.korenblit@intel.com,m:briannorris@chromium.org,m:francesco@dolcini.it,m:johannes@sipsolutions.net,m:jaewan@google.com,m:daniel.gabay@intel.com,m:emmanuel.grumbach@intel.com,m:benjamin.berg@intel.com,m:pagadala.yesu.anjaneyulu@intel.com,m:peddolla.reddy@oss.qualcomm.com,m:lorenzo@kernel.org,m:john@phrozen.org,m:patila@marvell.com,m:cluo@marvell.com,m:linville@tuxdriver.com,m:quic_alokad@quicinc.com,m:enderaoelyther@gmail.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[enderaoelyther@gmail.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 28B2172A0DF

The iwlwifi MLD driver registers .start_pmsr (iwl_mld_start_pmsr ->
iwl_mld_ftm_start) but not .abort_pmsr. iwl_mld_ftm_start() stores the
cfg80211 peer-measurement request in mld->ftm_initiator.req and the
owning wdev in mld->ftm_initiator.req_wdev, and keeps both until a TOF
range response completes the measurement.

When the user space that started the FTM session closes its netlink
socket (or the wdev goes down) while the measurement is still in
flight, cfg80211_release_pmsr()/cfg80211_pmsr_wdev_down() schedule the
abort work and cfg80211_pmsr_process_abort() runs:

	rdev_abort_pmsr(rdev, wdev, req);
	kfree(req);

rdev_abort_pmsr() only calls the driver op when ops->abort_pmsr is
set, so for MLD it is a no-op. The request is freed while
mld->ftm_initiator.req still points at it; nothing clears the
pointer.

A subsequent TOF range response from the firmware reaches
iwl_mld_handle_ftm_resp_notif(). The !mld->ftm_initiator.req guard
does not catch this because the pointer is dangling, not NULL, so the
handler dereferences the freed request (req->cookie, req->n_peers,
req->peers[]) and passes it with req_wdev to
cfg80211_pmsr_report()/cfg80211_pmsr_complete(); a use-after-free of
the already freed request.

Implement .abort_pmsr. iwl_mld_ftm_abort() checks that the aborted
request is the active one, cancels the pending FTM notifications,
resets the ftm_initiator state (clearing req and req_wdev), and sends
TOF_RANGE_ABORT_CMD to the firmware so no further range responses are
generated for the aborted request.

Fixes: d1e879ec600f ("wifi: iwlwifi: add iwlmld sub-driver")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5
Assisted-by: Claude:opus-4.8
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
 .../intel/iwlwifi/mld/ftm-initiator.c         | 22 +++++++++++++++++++
 .../intel/iwlwifi/mld/ftm-initiator.h         |  2 ++
 .../net/wireless/intel/iwlwifi/mld/mac80211.c | 10 +++++++++
 3 files changed, 34 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/ftm-initiator.c b/drivers/net/wireless/intel/iwlwifi/mld/ftm-initiator.c
index 81df3fdfcbf56..b18e4fa9dedf1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/ftm-initiator.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/ftm-initiator.c
@@ -13,6 +13,7 @@
 #include "constants.h"
 #include "fw/api/location.h"
 #include "ftm-initiator.h"
+#include "hcmd.h"
 
 static void iwl_mld_ftm_cmd_common(struct iwl_mld *mld,
 				   struct ieee80211_vif *vif,
@@ -282,6 +283,27 @@ static void iwl_mld_ftm_reset(struct iwl_mld *mld)
 	       sizeof(mld->ftm_initiator.responses));
 }
 
+void iwl_mld_ftm_abort(struct iwl_mld *mld,
+		       struct cfg80211_pmsr_request *req)
+{
+	struct iwl_tof_range_abort_cmd cmd = {
+		.request_id = req->cookie,
+	};
+
+	lockdep_assert_wiphy(mld->wiphy);
+
+	if (req != mld->ftm_initiator.req)
+		return;
+
+	iwl_mld_cancel_notifications_of_object(mld, IWL_MLD_OBJECT_TYPE_FTM_REQ,
+					       (u8)req->cookie);
+	iwl_mld_ftm_reset(mld);
+
+	if (iwl_mld_send_cmd_pdu(mld, WIDE_ID(LOCATION_GROUP, TOF_RANGE_ABORT_CMD),
+				 &cmd))
+		IWL_ERR(mld, "failed to abort FTM process\n");
+}
+
 static int iwl_mld_ftm_range_resp_valid(struct iwl_mld *mld, u8 request_id,
 					u8 num_of_aps)
 {
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/ftm-initiator.h b/drivers/net/wireless/intel/iwlwifi/mld/ftm-initiator.h
index 3fab25a52508a..7b807605af503 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/ftm-initiator.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/ftm-initiator.h
@@ -21,6 +21,8 @@ struct ftm_initiator_data {
 
 int iwl_mld_ftm_start(struct iwl_mld *mld, struct ieee80211_vif *vif,
 		      struct cfg80211_pmsr_request *req);
+void iwl_mld_ftm_abort(struct iwl_mld *mld,
+		       struct cfg80211_pmsr_request *req);
 
 void iwl_mld_handle_ftm_resp_notif(struct iwl_mld *mld,
 				   struct iwl_rx_packet *pkt);
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index 17286b3341c02..614c55967fcca 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -2853,6 +2853,15 @@ static int iwl_mld_start_pmsr(struct ieee80211_hw *hw,
 	return iwl_mld_ftm_start(mld, vif, request);
 }
 
+static void iwl_mld_abort_pmsr(struct ieee80211_hw *hw,
+			       struct ieee80211_vif *vif,
+			       struct cfg80211_pmsr_request *request)
+{
+	struct iwl_mld *mld = IWL_MAC80211_GET_MLD(hw);
+
+	iwl_mld_ftm_abort(mld, request);
+}
+
 static enum ieee80211_neg_ttlm_res
 iwl_mld_can_neg_ttlm(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		     struct ieee80211_neg_ttlm *neg_ttlm)
@@ -2974,6 +2983,7 @@ const struct ieee80211_ops iwl_mld_hw_ops = {
 	.prep_add_interface = iwl_mld_prep_add_interface,
 	.set_hw_timestamp = iwl_mld_set_hw_timestamp,
 	.start_pmsr = iwl_mld_start_pmsr,
+	.abort_pmsr = iwl_mld_abort_pmsr,
 	.can_neg_ttlm = iwl_mld_can_neg_ttlm,
 	.start_nan = iwl_mld_start_nan,
 	.stop_nan = iwl_mld_stop_nan,
-- 
2.50.1 (Apple Git-155)

