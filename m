Return-Path: <linux-wireless+bounces-31848-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qO6XF3fokGkMdwEAu9opvQ
	(envelope-from <linux-wireless+bounces-31848-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 22:26:15 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C6C13D579
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 22:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7B2493031AC1
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 21:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9832D979F;
	Sat, 14 Feb 2026 21:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fH3eQ6Gi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76D130F922;
	Sat, 14 Feb 2026 21:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771104321; cv=none; b=vGhjriHfQ9wrzNSMcA1pOPuBlfTnnO60SQv4P9cOf3LDpqLSeo/XuwDW8CZ+lpdSD/dftGqg4p81QrFAbOd/Yd+ReT07EUi2pquoeJ6N5IHqu3n6lOsEZRotk2MItF694AvV47mV11wFwLhJx1hqm7oMajYG4ryH+6NwwqJ9kNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771104321; c=relaxed/simple;
	bh=jjsKllGq21ePVmg+7k8v0M6ijQC0OZ2uqA/+v8sKS70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fqFHXu670I/tkarqqiL6NZ1BOdfAol7QdqHj12Ggs9DyOkPhK11/nMA13fW90HCG/20hDhxtb9S+brwTDw4Hgu2zkONChp1D/ECVkH3dUvj98ZQboRJx0W5LJDroRquo7UvQoV9kkDwEUMy3JhkH9SjEuDgOZ+CRyFKYN6o30NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fH3eQ6Gi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F621C19422;
	Sat, 14 Feb 2026 21:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771104321;
	bh=jjsKllGq21ePVmg+7k8v0M6ijQC0OZ2uqA/+v8sKS70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fH3eQ6GiPhCI4X9sOJvPA8+bJJpDRqECn/xT+KFEtRqY0DQ2OWg5GjSIuX8wxuliu
	 g9oZ95MmFPGzZTwe3VK9JMBGXVJORAvpLjqqTIUVSx0RU4Uo1R1vqMtu4cYou3aZNo
	 PPsrhb9Epd8mq64YE4U0UsqUToF/8JZFXgBvxPcGiAx3HzWnUng0rXkvAi57viDpLX
	 zrma87rsYsl7uflNMvIyhx41JX6CL/qoqZhgzDFkIuiEORZmGbRDW0Abh47XiQUxJ0
	 qmK78rZhmyiduZRFQnvApvazkYgYx4G9LzkMfkuz0jXQGbeA6Nfn8on9I9l1n69Pd1
	 EXTtBdUNOZPpw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Chih-Kang Chang <gary.chang@realtek.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19-6.18] wifi: rtw89: mcc: reset probe counter when receiving beacon
Date: Sat, 14 Feb 2026 16:22:41 -0500
Message-ID: <20260214212452.782265-16-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260214212452.782265-1-sashal@kernel.org>
References: <20260214212452.782265-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.19
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31848-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:email,msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E7C6C13D579
X-Rspamd-Action: no action

From: Chih-Kang Chang <gary.chang@realtek.com>

[ Upstream commit 1b40c1c7571fcf926095ed92f25bd87900bdc8ed ]

For BE chips, needs to transmit QoS null data periodically to ensure
the connection with AP in GC+STA mode. However, in environments
with interference, the Qos null data might fail to transmit
successfully. Therefore, when receive the beacon from AP will
reset the QoS null data failure counter to avoid unnecessary
disconnection.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20251223030651.480633-13-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Good — the tree shows the **pre-patch** version. The `last_sync_bcn_tsf`
field and `sync_bcn_tsf` already exist, so the infrastructure needed by
this commit is present. The commit itself makes a clean, self-contained
modification.

### 7. SUMMARY

**Problem**: In rtw89 WiFi driver, when operating in MCC (Multi-Channel
Concurrency) GC+STA mode, the driver uses QoS null data frames to verify
AP connectivity. In environments with interference, these frames can
fail even though the connection is actually alive (beacons are still
being received). This causes false `ieee80211_connection_loss()` calls,
disconnecting the user unnecessarily.

**Fix**: Before incrementing the probe failure counter, check if a
beacon has been received since the last check (by comparing
`sync_bcn_tsf` to `last_sync_bcn_tsf`). If a beacon was received, the
connection is still alive, so reset the counter instead of incrementing
it.

**Stable criteria assessment**:
- **Obviously correct**: Yes — the logic is simple: if we received a
  beacon, the connection is alive, don't disconnect
- **Fixes a real bug**: Yes — false disconnection in interference-heavy
  WiFi environments
- **Important issue**: Yes — unnecessary WiFi disconnection is a
  significant user-facing issue
- **Small and contained**: Yes — ~10 lines of logic in 2 files, all
  within the rtw89 driver
- **No new features**: Correct — this only improves connection loss
  detection accuracy
- **Dependencies**: The `sync_bcn_tsf` and `last_sync_bcn_tsf` fields
  already exist in the tree; the initialization in mac80211.c is trivial

**Risk**: Very low. The change is confined to the rtw89 driver's MCC
path, and the worst case (if somehow wrong) is that the original
disconnection behavior triggers slightly differently — still better than
the false disconnection scenario.

**YES**

 drivers/net/wireless/realtek/rtw89/chan.c     | 5 ++++-
 drivers/net/wireless/realtek/rtw89/mac80211.c | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index 86f1b39a967fe..8fe6a7ef738f7 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -2608,17 +2608,20 @@ bool rtw89_mcc_detect_go_bcn(struct rtw89_dev *rtwdev,
 static void rtw89_mcc_detect_connection(struct rtw89_dev *rtwdev,
 					struct rtw89_mcc_role *role)
 {
+	struct rtw89_vif_link *rtwvif_link = role->rtwvif_link;
 	struct ieee80211_vif *vif;
 	bool start_detect;
 	int ret;
 
 	ret = rtw89_core_send_nullfunc(rtwdev, role->rtwvif_link, true, false,
 				       RTW89_MCC_PROBE_TIMEOUT);
-	if (ret)
+	if (ret &&
+	    READ_ONCE(rtwvif_link->sync_bcn_tsf) == rtwvif_link->last_sync_bcn_tsf)
 		role->probe_count++;
 	else
 		role->probe_count = 0;
 
+	rtwvif_link->last_sync_bcn_tsf = READ_ONCE(rtwvif_link->sync_bcn_tsf);
 	if (role->probe_count < RTW89_MCC_PROBE_MAX_TRIES)
 		return;
 
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index f39ca1c2ed100..d08eac3d99266 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -127,6 +127,7 @@ static int __rtw89_ops_add_iface_link(struct rtw89_dev *rtwdev,
 	rtwvif_link->reg_6ghz_power = RTW89_REG_6GHZ_POWER_DFLT;
 	rtwvif_link->rand_tsf_done = false;
 	rtwvif_link->detect_bcn_count = 0;
+	rtwvif_link->last_sync_bcn_tsf = 0;
 
 	rcu_read_lock();
 
-- 
2.51.0


