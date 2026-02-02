Return-Path: <linux-wireless+bounces-31480-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YACuKKAbgWm0EAMAu9opvQ
	(envelope-from <linux-wireless+bounces-31480-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Feb 2026 22:48:16 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52DB2D1C9D
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Feb 2026 22:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 59C3F301FBEC
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Feb 2026 21:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330F23164C1;
	Mon,  2 Feb 2026 21:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lAfeHZTm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB3C29ACD7;
	Mon,  2 Feb 2026 21:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770068839; cv=none; b=PrV/oiuSbTvKdcGnyqSRDI9HaOS5+XSETC3aodRzqzgJNKXTX8mxIbdOdzagPoW3aifHTLadSJ30FJ61f0Qat51shqWYgmXYfwvG8EaAJSjppVyS0EKdMopxKx0ZagYCIdbFTCNNgN7kJM47qSm9DDZvLwHnHbXcIcWK1yMqNjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770068839; c=relaxed/simple;
	bh=ZI+fCFtjOz2oqnn00AeNgkHp2Y04okKoJp/N2I2qaiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K1O1tYtFXpzGx67H69QIZzuDOyn6wSUcA0bA5JJqtTRNWNIMf7DnIQtrAHGs15w1SUhzN2Fr/YR26shr+lJwOuMe+mNGTFm/dEEiKWEhtHAxCRixfJ2LPcbUHoWtvzbqQulvX7A4NcGHRdOEHUpx0SsfGcIVCKpA+YFweB8U/XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lAfeHZTm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3618AC116C6;
	Mon,  2 Feb 2026 21:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770068838;
	bh=ZI+fCFtjOz2oqnn00AeNgkHp2Y04okKoJp/N2I2qaiY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lAfeHZTmXZed3kmiD5O0MuJ/05cvQE0CQvLIssYlg1mJ1uajri0sQXu1/cpJcEfMb
	 xKPgMuOZbnq8sYKk010QbNe/sYw3NVTdBaCQ1hkx9fKlpf+0z9VW+wRia01Id8DRFG
	 C+DBat5POc9LQwFP04AAqXErVMcNs3RPI75EhGDOIZhTbbe/Y7qDYFuzo4lrxQxvNP
	 VrDRi8P0WPj0r2XPyLw/yqDfk8WANHLejg3/VhajNk3EJewZDuLBixeGAgc20Ndq8b
	 HC8ctGaFsaLdGmfARAWvEbbncRWgqKSeRlA//mXboP9VnLTcJqhkBIfRUoWTU7cceC
	 Z6PdhJ7lKTdvQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18-5.10] wifi: mac80211: don't increment crypto_tx_tailroom_needed_cnt twice
Date: Mon,  2 Feb 2026 16:46:11 -0500
Message-ID: <20260202214643.212290-16-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260202214643.212290-1-sashal@kernel.org>
References: <20260202214643.212290-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.18.8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31480-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 52DB2D1C9D
X-Rspamd-Action: no action

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

[ Upstream commit 3f3d8ff31496874a69b131866f62474eb24ed20a ]

In reconfig, in case the driver asks to disconnect during the reconfig,
all the keys of the interface are marked as tainted.
Then ieee80211_reenable_keys will loop over all the interface keys, and
for each one it will
a) increment crypto_tx_tailroom_needed_cnt
b) call ieee80211_key_enable_hw_accel, which in turn will detect that
this key is tainted, so it will mark it as "not in hardware", which is
paired with crypto_tx_tailroom_needed_cnt incrementation, so we get two
incrementations for each tainted key.
Then we get a warning in ieee80211_free_keys.

To fix it, don't increment the count in ieee80211_reenable_keys for
tainted keys

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20260118092821.4ca111fddcda.Id6e554f4b1c83760aa02d5a9e4e3080edb197aa2@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

So KEY_FLAG_TAINTED was introduced in v4.20. The bug being fixed is
likely in all kernels from 4.20 onward. Let me verify the current state
after the patch would be applied.

The patch being analyzed changes:
```c
list_for_each_entry(key, &sdata->key_list, list) {
    increment_tailroom_need_count(sdata);  // OLD: unconditional
    ieee80211_key_enable_hw_accel(key);
}
```

to:
```c
list_for_each_entry(key, &sdata->key_list, list) {
    if (!(key->flags & KEY_FLAG_TAINTED))  // NEW: skip for tainted
        increment_tailroom_need_count(sdata);
    ieee80211_key_enable_hw_accel(key);
}
```

This is correct because:
- For non-tainted keys: increment once here, and if HW accel succeeds,
  it will be decremented in `ieee80211_key_enable_hw_accel()` (line
  187). Net result: proper accounting.
- For tainted keys: skip here, let `ieee80211_key_enable_hw_accel()`
  handle the increment (line 141) when clearing
  `KEY_FLAG_UPLOADED_TO_HARDWARE`. Net result: proper accounting.

## Analysis Summary

**1. COMMIT MESSAGE ANALYSIS:**
- Clear explanation of the problem: double increment of
  `crypto_tx_tailroom_needed_cnt` for tainted keys during reconfig
- The symptom is a warning in `ieee80211_free_keys`
- Reviewed-by from Johannes Berg (mac80211 maintainer) adds confidence

**2. CODE CHANGE ANALYSIS:**
- The bug: In `ieee80211_reenable_keys()`, for each key:
  1. `increment_tailroom_need_count(sdata)` is called unconditionally
  2. `ieee80211_key_enable_hw_accel(key)` is called

- For tainted keys (marked when driver requests disconnect during
  reconfig), `ieee80211_key_enable_hw_accel()` will:
  - Also call `increment_tailroom_need_count(sdata)` at line 141 if the
    key was uploaded to hardware
  - Clear the `KEY_FLAG_UPLOADED_TO_HARDWARE` flag

- Result: Two increments per tainted key instead of one

- The fix: Skip the first increment for tainted keys since they'll get
  their increment inside `ieee80211_key_enable_hw_accel()`

**3. CLASSIFICATION:**
- This is a clear BUG FIX for a reference counting error
- Not a feature addition
- Fixes a real warning that users would see in kernel logs

**4. SCOPE AND RISK ASSESSMENT:**
- Very small change: adds a simple conditional check (1 line changed)
- Localized to mac80211 key handling
- Low risk: the logic is straightforward and has been reviewed by the
  subsystem maintainer
- The worst-case if the fix is wrong would be the opposite accounting
  error

**5. USER IMPACT:**
- WiFi users doing rekeys or going through suspend/resume/HW restart
  with certain driver/firmware combinations could hit this
- The symptom is a kernel warning (WARN_ON_ONCE in
  `ieee80211_free_keys`)
- It causes incorrect tailroom accounting which could potentially lead
  to issues with software encryption

**6. STABILITY INDICATORS:**
- Reviewed-by: Johannes Berg (mac80211 maintainer)
- The code path and fix are straightforward

**7. DEPENDENCY CHECK:**
- KEY_FLAG_TAINTED exists since v4.20
- The function `ieee80211_reenable_keys()` exists in stable trees
- The code affected exists in all supported stable kernels
- No dependency on other commits - this is a standalone fix

The fix is small, surgical, reviewed by the subsystem maintainer, fixes
a real bug (warning + incorrect reference counting), and meets all
stable kernel criteria.

**YES**

 net/mac80211/key.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/key.c b/net/mac80211/key.c
index d5da7ccea66e0..04c8809173d7f 100644
--- a/net/mac80211/key.c
+++ b/net/mac80211/key.c
@@ -987,7 +987,8 @@ void ieee80211_reenable_keys(struct ieee80211_sub_if_data *sdata)
 
 	if (ieee80211_sdata_running(sdata)) {
 		list_for_each_entry(key, &sdata->key_list, list) {
-			increment_tailroom_need_count(sdata);
+			if (!(key->flags & KEY_FLAG_TAINTED))
+				increment_tailroom_need_count(sdata);
 			ieee80211_key_enable_hw_accel(key);
 		}
 	}
-- 
2.51.0


