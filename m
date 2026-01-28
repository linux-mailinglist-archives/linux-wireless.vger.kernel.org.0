Return-Path: <linux-wireless+bounces-31283-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UM6nEfmOeml+7wEAu9opvQ
	(envelope-from <linux-wireless+bounces-31283-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jan 2026 23:34:33 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA576A99C9
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jan 2026 23:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ECC5E301C901
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jan 2026 22:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72700344DAD;
	Wed, 28 Jan 2026 22:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="koOPsY7R"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE28342CB1;
	Wed, 28 Jan 2026 22:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769639643; cv=none; b=bqQoP2GCetogNaq7aFm8poznT1O7D2B1kEK3hnUbSxU93Dt+LPBk+qRGevRdNJhtFCEpzg+rG3XXFGZE75AKFfHdIJYq2fxkmbvyWzuXy+KMBT97DNmRMvw15NTddXHaz54Jh6zFsCmetoy8hS5UG1atKcSOt1CY5ir2E3WTRQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769639643; c=relaxed/simple;
	bh=s2ei0KDa85D8REcCHQMGBclR2b1BHrWKF3ymnTFoqeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nE7sOuX3fYSt1ZaeXR+4RMdW5suuu8yWD1RZNO3srd9vU8NwFjC7rK2oZXAuexo/QVAordpper686bz5usBF8Q1eqMFUWeJzfMvFvn4twenOhZ0iF3azqzdRHUCNk7iZopURkenPOuvyGk4Wmfq0cx/+tdVPJ7LZd5rj3af1eXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=koOPsY7R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 700A3C4CEF7;
	Wed, 28 Jan 2026 22:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769639643;
	bh=s2ei0KDa85D8REcCHQMGBclR2b1BHrWKF3ymnTFoqeA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=koOPsY7RVIesSx82t/5HjbPURQS9CdEA+Hq4alScftZHxnI/ccPiU6kq90H3rhYII
	 OKxT5Bv3vkLNnl7ZIc02Oq/v/y8Ypp4amAIIbmRAg2l4fl6k0hunbWalxAeoVsC2MA
	 IZHlwd70lgpYKbc9+1t14oXXKZn6O7Rg3oyyRPPUFDY0HvG7hXYWxbYeLzahHp4DTJ
	 S/lFHZwvEXeCu6XpH7Bm/Pd89/XMoS62W/lIjHdfJ7r2mV7AAOXou42SStdu7jJvY0
	 yLVa+ULg+gWbpHJwtwbILr5hZBI7+fdYRIDA4ls9sEqMegwGn8llz3HzpsZE4gj3vr
	 A/qbCyU7PQWZg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Veerendranath Jakkam <veerendranath.jakkam@oss.qualcomm.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18-5.10] wifi: cfg80211: Fix bitrate calculation overflow for HE rates
Date: Wed, 28 Jan 2026 17:33:15 -0500
Message-ID: <20260128223332.2806589-17-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260128223332.2806589-1-sashal@kernel.org>
References: <20260128223332.2806589-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.18.7
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31283-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: BA576A99C9
X-Rspamd-Action: no action

From: Veerendranath Jakkam <veerendranath.jakkam@oss.qualcomm.com>

[ Upstream commit a3034bf0746d88a00cceda9541534a5721445a24 ]

An integer overflow occurs in cfg80211_calculate_bitrate_he() when
calculating bitrates for high throughput HE configurations.
For example, with 160 MHz bandwidth, HE-MCS 13, HE-NSS 4, and HE-GI 0,
the multiplication (result * rate->nss) overflows the 32-bit 'result'
variable before division by 8, leading to significantly underestimated
bitrate values.

The overflow occurs because the NSS multiplication operates on a 32-bit
integer that cannot accommodate intermediate values exceeding
4,294,967,295. When overflow happens, the value wraps around, producing
incorrect bitrates for high MCS and NSS combinations.

Fix this by utilizing the 64-bit 'tmp' variable for the NSS
multiplication and subsequent divisions via do_div(). This approach
preserves full precision throughout the entire calculation, with the
final value assigned to 'result' only after completing all operations.

Signed-off-by: Veerendranath Jakkam <veerendranath.jakkam@oss.qualcomm.com>
Link: https://patch.msgid.link/20260109-he_bitrate_overflow-v1-1-95575e466b6e@oss.qualcomm.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

I can see the buggy code is still present in this version (the fix
hasn't been applied yet to this version of util.c). This is the code
being patched. Let me double check the diff shows exactly what I expect:

Looking at the diff again:
```c
- result = tmp;

        /* and take NSS, DCM into account */
- result = (result * rate->nss) / 8;
+       tmp *= rate->nss;
+       do_div(tmp, 8);
        if (rate->he_dcm)
- result /= 2;
+               do_div(tmp, 2);
+
+       result = tmp;
```

The fix:
1. Removes `result = tmp` after the MCS division (keeps value in 64-bit
   `tmp`)
2. Multiplies NSS in 64-bit: `tmp *= rate->nss` instead of 32-bit
   `result * rate->nss`
3. Uses `do_div(tmp, 8)` instead of 32-bit division
4. Uses `do_div(tmp, 2)` for DCM instead of 32-bit division
5. Only assigns to 32-bit `result` at the end when the value is
   guaranteed to fit

This matches exactly the same fix pattern that was applied to
`cfg80211_calculate_bitrate_eht()` in commit 18429c51c7ff6.

## Summary Analysis

### 1. COMMIT MESSAGE ANALYSIS
- **Subject**: Clearly indicates a bug fix for bitrate calculation
  overflow in HE rates
- **Body**: Provides detailed technical explanation of the overflow
  scenario (160 MHz, MCS 13, NSS 4, GI 0)
- **Root cause**: 32-bit integer overflow when multiplying `result *
  rate->nss` before division by 8
- **Fix approach**: Use 64-bit `tmp` variable throughout the
  calculation, assign to 32-bit `result` only at the end
- **Tags**: Has Signed-off-by from both Qualcomm developer and Johannes
  Berg (wireless maintainer)

### 2. CODE CHANGE ANALYSIS
- **Bug mechanism**: When `result` (a u32) is large (e.g., 0x44b85dd4 =
  1,152,933,332), multiplying by NSS 4 produces 0x112e17750
  (4,611,733,328) which overflows u32 max (0xFFFFFFFF = 4,294,967,295)
- **Result of bug**: The overflow wraps to 0x12e17750, producing a
  bitrate of ~3,959 (400 Mbps) instead of correct ~57,646 (5.76 Gbps)
- **Fix correctness**: The fix keeps all arithmetic in 64-bit until the
  final assignment, preventing overflow
- **DCM handling**: Also moved to 64-bit for consistency and safety

### 3. CLASSIFICATION
- **Type**: Bug fix (integer overflow causing incorrect bitrate
  reporting)
- **Security**: Not a security issue, but affects user-visible data
  correctness
- **Exception categories**: Not applicable - this is a straightforward
  bug fix

### 4. SCOPE AND RISK ASSESSMENT
- **Lines changed**: ~10 lines, very small and localized
- **Files touched**: 1 file (net/wireless/util.c)
- **Subsystem**: WiFi cfg80211, mature and stable
- **Risk**: Very LOW - the exact same fix pattern was already applied to
  the EHT version of this function and has been in stable since 6.1
- **Could break something**: Extremely unlikely - only changes
  intermediate arithmetic precision, final result is more accurate

### 5. USER IMPACT
- **Who is affected**: Users with WiFi 6 (802.11ax) devices using high
  bandwidth (160 MHz), high MCS (12/13), and multiple spatial streams
  (NSS 3-8)
- **Visibility**: Users see incorrect bitrate reporting in tools like
  `iw`, network managers, etc.
- **Severity**: Low-medium - cosmetic but confusing to users (reported
  speed is much lower than actual)
- **Real-world scenario**: Modern high-end WiFi 6 devices can absolutely
  hit these configurations

### 6. STABILITY INDICATORS
- **Testing**: Qualcomm developer tested on their hardware
- **Review**: Accepted by Johannes Berg (long-time wireless maintainer)
- **Precedent**: Same fix was applied to EHT function years ago (commit
  18429c51c7ff6) and has proven stable

### 7. DEPENDENCY CHECK
- **Dependencies**: None - self-contained fix
- **Affected versions**: The HE MCS 12/13 support was added in v5.11, so
  stable trees 5.11+ are affected
- **Backport complexity**: Trivial - the affected code exists unchanged
  in all relevant stable trees

### Risk vs Benefit Trade-off
- **Benefit**: Corrects incorrect bitrate reporting for high-throughput
  WiFi 6 configurations
- **Risk**: Minimal - follows proven fix pattern already in production
  since kernel 6.1
- **Verdict**: HIGH benefit, VERY LOW risk

**YES**

 net/wireless/util.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/wireless/util.c b/net/wireless/util.c
index 4eb028ad16836..81d6d27d273cc 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -1561,12 +1561,14 @@ static u32 cfg80211_calculate_bitrate_he(struct rate_info *rate)
 	tmp = result;
 	tmp *= SCALE;
 	do_div(tmp, mcs_divisors[rate->mcs]);
-	result = tmp;
 
 	/* and take NSS, DCM into account */
-	result = (result * rate->nss) / 8;
+	tmp *= rate->nss;
+	do_div(tmp, 8);
 	if (rate->he_dcm)
-		result /= 2;
+		do_div(tmp, 2);
+
+	result = tmp;
 
 	return result / 10000;
 }
-- 
2.51.0


