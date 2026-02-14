Return-Path: <linux-wireless+bounces-31866-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MriCQHpkGkadwEAu9opvQ
	(envelope-from <linux-wireless+bounces-31866-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 22:28:33 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E0AE413D6F9
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 22:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8A1153034AE2
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 21:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0DC310774;
	Sat, 14 Feb 2026 21:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ikwc2sn6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5B330DD00;
	Sat, 14 Feb 2026 21:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771104413; cv=none; b=RiOQ401j75blze+LfTtt/jrt2u6ZgoXShKaptiKHpk1kGWEd9r2ey7wmYYUDh3ZGlwaJAVodXJX2NHN1QeCLgKALj3Tof2Y8svrtlBF8m866+bbMzIMewiqxZuE9Vf2tyI+O3Un2a++awUfIMWJBiwbsWu+afLXBNovDrbutMCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771104413; c=relaxed/simple;
	bh=74cp8VZWvs0+3X0KelKl0XIdZFubgwLJoFNl+INLND4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZLq++rvBuQrWyKeGwsUbtKmQDvlN/XS8sSYCoj3g6Z2KLVUaHa7enb+lZBD5AOigtD20adY1arB4DfpNfhGe9hJ5cvvIhmx6W5ku/ale8L6hPuhPlUz6lq9sCx5XFahqYUFXOjPEW2o5ycWFqcPpQhCwBq3yRp0MSzzgmIGgvJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ikwc2sn6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36733C19422;
	Sat, 14 Feb 2026 21:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771104412;
	bh=74cp8VZWvs0+3X0KelKl0XIdZFubgwLJoFNl+INLND4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ikwc2sn6Gy2uajEROU3HjmOqHK5NFDJTuk0RDEwTxK4jCjc+E4Qg1sZnNqv/cr03n
	 FtvJDtXhKDOOSDAw6rRdlIMemsY9tgvg8qGKJBCvc37RQnDzA0nmiWVtElLV/uQ/zs
	 npDSPy2pT6q/PLMSljWXdVZMwwjlPhnrlGr5NhVb7U30+qI0gCTntCEEWWF4mf5ZGA
	 PsOCA+iPoo87+t56vrz58cbRokqV8aPfQta8OD6SeVophpuZWTNDBjNze2NYyBJaq6
	 mYfIql+IVEc8a4jcRASWQm1fToDKhBnrfPdqlu5Ht/KwlNl3FvYoh6tagg4FjiP6gX
	 JHhZhHtpJCaXQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Zong-Zhe Yang <kevin_yang@realtek.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19-6.18] wifi: rtw89: regd: 6 GHz power type marks default when inactive
Date: Sat, 14 Feb 2026 16:23:35 -0500
Message-ID: <20260214212452.782265-70-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31866-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,realtek.com:email]
X-Rspamd-Queue-Id: E0AE413D6F9
X-Rspamd-Action: no action

From: Zong-Zhe Yang <kevin_yang@realtek.com>

[ Upstream commit 8c96752d99c0b094af68317a8c701b09bd0862d9 ]

When inactive, 6 GHz power type has been assigned to the default one,
but missed to mark the local control variable, dflt, true. Then, this
might let some 6 GHz power info of disconnected APs keep being taken
into account under certain cases.

So, mark default when inactive.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20251229030926.27004-12-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## Commit Analysis: wifi: rtw89: regd: 6 GHz power type marks default
when inactive

### 1. Commit Message Analysis

The commit message clearly describes a bug: when a 6 GHz connection
becomes inactive, the code correctly sets the power type to the default
value (`RTW89_REG_6GHZ_POWER_DFLT`), but **fails to set the local
variable `dflt = true`**. This is a logic error where two related state
updates are out of sync.

The consequence: "this might let some 6 GHz power info of disconnected
APs keep being taken into account under certain cases." This means stale
power configuration from a previously connected AP could persist and
affect regulatory behavior.

### 2. Code Change Analysis

The fix is a **single line addition**: `dflt = true;` in the `else`
(inactive) branch.

Let me trace the logic:

- `dflt` is a boolean that tracks whether the default power type is in
  use
- In the `active` branch, when the `default:` case of the switch is hit,
  both `reg_6ghz_power = RTW89_REG_6GHZ_POWER_DFLT` AND `dflt = true`
  are set
- In the `else` (inactive) branch, `reg_6ghz_power =
  RTW89_REG_6GHZ_POWER_DFLT` is set but `dflt` was **not** being set to
  `true`

The `dflt` variable is then checked at line `if (!dflt &&
blocked[rtwvif_link->reg_6ghz_power])`. When `dflt` is false and the
power type is `RTW89_REG_6GHZ_POWER_DFLT`, the code would incorrectly
check `blocked[RTW89_REG_6GHZ_POWER_DFLT]`, which could cause the
function to return `-EINVAL` erroneously when the link is inactive, or
it could allow stale power type information to persist.

### 3. Bug Classification

This is a **logic bug** — specifically a missing state update that
causes inconsistent behavior. When a WiFi interface goes inactive on 6
GHz:
- The power type is correctly reset to default
- But `dflt` stays false (from initialization), so the "blocked" check
  below could still evaluate the default power type against the blocked
  list, potentially returning an error when it shouldn't

This affects regulatory domain handling, which is important for proper
WiFi operation on 6 GHz bands.

### 4. Scope and Risk Assessment

- **Size**: 1 line added — minimal
- **Files touched**: 1 file
  (`drivers/net/wireless/realtek/rtw89/regd.c`)
- **Risk**: Extremely low — it's adding a missing boolean assignment
  that mirrors the behavior already present in the `default:` case of
  the `active` branch
- **Correctness**: Obviously correct — the inactive branch sets the same
  `RTW89_REG_6GHZ_POWER_DFLT` value as the default case in the active
  branch, so it should also set `dflt = true`

### 5. User Impact

- Affects users of Realtek RTW89 WiFi adapters using 6 GHz bands
- Could cause incorrect regulatory power type handling when
  disconnecting from 6 GHz APs
- In certain cases, stale power info from disconnected APs could be
  used, potentially causing regulatory compliance issues or connectivity
  problems

### 6. Stable Kernel Criteria

- **Obviously correct**: Yes — the fix is symmetric with the `default:`
  case in the active branch
- **Fixes a real bug**: Yes — logic error causing inconsistent state
- **Small and contained**: Yes — 1 line in 1 file
- **No new features**: Correct — pure bug fix
- **Tested**: From Realtek maintainers (Zong-Zhe Yang, Ping-Ke Shih)

### 7. Dependencies

This fix is self-contained. The surrounding code structure (the switch
statement, the `dflt` variable, the `blocked[]` check) all exist in
stable kernels that have the rtw89 driver with 6 GHz support.

### Conclusion

This is a clean, minimal, obviously-correct bug fix that addresses a
real logic error in WiFi regulatory power type handling. It has
negligible risk of regression and fixes a genuine issue for users of
Realtek WiFi adapters on 6 GHz networks.

**YES**

 drivers/net/wireless/realtek/rtw89/regd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/realtek/rtw89/regd.c b/drivers/net/wireless/realtek/rtw89/regd.c
index 209d84909f885..c3425ed44732e 100644
--- a/drivers/net/wireless/realtek/rtw89/regd.c
+++ b/drivers/net/wireless/realtek/rtw89/regd.c
@@ -1142,6 +1142,7 @@ static int rtw89_reg_6ghz_power_recalc(struct rtw89_dev *rtwdev,
 		}
 	} else {
 		rtwvif_link->reg_6ghz_power = RTW89_REG_6GHZ_POWER_DFLT;
+		dflt = true;
 	}
 
 	rcu_read_unlock();
-- 
2.51.0


