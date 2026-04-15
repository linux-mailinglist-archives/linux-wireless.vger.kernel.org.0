Return-Path: <linux-wireless+bounces-34811-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oG5FHx3J32nVYwAAu9opvQ
	(envelope-from <linux-wireless+bounces-34811-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 19:21:33 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2135406C0C
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 19:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1EC6033164F8
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 16:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B822E3E5594;
	Wed, 15 Apr 2026 16:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=r26.me header.i=@r26.me header.b="p44Ny+tI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E2231AAA8;
	Wed, 15 Apr 2026 16:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776272244; cv=none; b=tkMS94ScpKDSLFoT0Xscc+FWZkxLIohTOcDjVh1a9CZd+p1JsM2fw1V6dSwxUaIZelAB6GaInu9h/W87+jkeF6aPxx7TYdirYlMG6zIgtzdBvBjKwNXNKmMy++DNnqpVFLIUG1NQWeEAzgVExZxZfuWdR5QpedUHkzPjDRCMivg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776272244; c=relaxed/simple;
	bh=V9T5Bgj31sBKP6pd9DlhQ0fIulRPEXKuRHEVPjkkrLk=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=oHQ+Bquz15/UxuyNAaL+UuzSkkr4/HXave6hj+Eguf3Mj78xBgzqEZbRH/MGV+ZgR+dAMJqBD3id31OI2cThwTMkvWkcCe4mX+T+v/J5TM9uL4kVDEX4T8fiORaF/llXAoTAytGv4Ddoty7m2R/xNlmFLtrUhLJk4K1q2JPDwTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=r26.me; spf=pass smtp.mailfrom=r26.me; dkim=pass (2048-bit key) header.d=r26.me header.i=@r26.me header.b=p44Ny+tI; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=r26.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=r26.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=r26.me;
	s=protonmail; t=1776272238; x=1776531438;
	bh=V9T5Bgj31sBKP6pd9DlhQ0fIulRPEXKuRHEVPjkkrLk=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=p44Ny+tIelN3XwDc51CBNqEsFxfwsUWb8onR9hV8hs9nFcupihzP954gx2Qnp+C5I
	 Bjx7KWCsC09bLTDi2c/S9WrhHFJ1QdmRzUXSyKMWKb+oeFswfoIVwPD/CyLR10xfAS
	 YE0q97ivtWEJAO6yCTYV6mQhbOwv9pXBET3bF7Nz2QBOu3xhAtLcfV1TKr8qeuR4BA
	 2hJNzjWSvousKIcGCGa4EH6tvgR24Am6/5gJOlhlGOr6KMrQ44IYOr6f0kzI50beL8
	 OBYpGArYWIfmPfqMfio3s9FhiLFB8wKbjqOfeByD3xZhvZq/BUM6fPsqG/OzmiBX1J
	 vAKKVw/J9oJ6g==
Date: Wed, 15 Apr 2026 16:57:13 +0000
To: Johannes Berg <johannes@sipsolutions.net>
From: Rio Liu <rio@r26.me>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "benjamin.berg@intel.com" <benjamin.berg@intel.com>
Subject: [PATCH v2] wifi: mac80211: skip ieee80211_verify_sta_ht_mcs_support check in non-strict mode
Message-ID: <99Mv9QEceyPrQhSP52MtAVmz0_kWJmzqotJjD9YW6LGLqk-AZloAueUyHCURilFkuqOh6Ecv8i2KKdSE1ujP3AnbU5QEouVisT1w_V3xdfc=@r26.me>
Feedback-ID: 77429777:user:proton
X-Pm-Message-ID: 53d93d6dcfe9b777cac89c2172c46285dc4aaa65
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[r26.me,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[r26.me:s=protonmail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34811-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rio@r26.me,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[r26.me:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[r26.me:email,r26.me:dkim,r26.me:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F2135406C0C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Some Xfinity XB8 firmware advertises >1 spatial stream MCS indexes in
their basic HT-MCS set. On cards with lower spatial streams, the check
would fail, and we'd be stuck with no HT when in fact work fine with its
own supported rate. This change makes it so the check is only performed
in strict mode.

Fixes: 574faa0e936d ("wifi: mac80211: add HT and VHT basic set verification=
")
Signed-off-by: Rio Liu <rio@r26.me>
---
v2 changes:
- update comment to include Xfinity router model
- generalize comment to include devices with only single spatial stream
- add Fixes tag
- add wifi: mac80211: to patch title

Link to v1: https://lore.kernel.org/linux-wireless/AKVRf_yEu2mRCJekCJpre5xX=
MuHa_3_dO7_H1UU8fiKZRjJUf96ZKepiR999NwpiVwmzWBYoKipBpx1rqZatVihMYOCvANUnbeo=
yI2U7ct0=3D@r26.me/T/#u

 net/mac80211/mlme.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 810bea1aacc5..44cb826263ba 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -419,6 +419,15 @@ ieee80211_verify_sta_ht_mcs_support(struct ieee80211_s=
ub_if_data *sdata,
 =09memcpy(&sta_ht_cap, &sband->ht_cap, sizeof(sta_ht_cap));
 =09ieee80211_apply_htcap_overrides(sdata, &sta_ht_cap);

+=09/*
+=09 * Some Xfinity XB8 firmware advertises >1 spatial stream MCS indexes i=
n
+=09 * their basic HT-MCS set. On cards with lower spatial streams, the che=
ck
+=09 * would fail, and we'd be stuck with no HT when it in fact work fine w=
ith
+=09 * its own supported rate. So check it only in strict mode.
+=09 */
+=09if (!ieee80211_hw_check(&sdata->local->hw, STRICT))
+=09=09return true;
+
 =09/*
 =09 * P802.11REVme/D7.0 - 6.5.4.2.4
 =09 * ...

base-commit: d65b175cfac64ee65506eea7fa573d291a9694ca
--
2.53.0



