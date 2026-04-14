Return-Path: <linux-wireless+bounces-34725-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJj9GS7L3WlqjQkAu9opvQ
	(envelope-from <linux-wireless+bounces-34725-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2026 07:05:50 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D70A83F5A77
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2026 07:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D20B4303DF4C
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2026 05:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D1E2820AC;
	Tue, 14 Apr 2026 05:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=r26.me header.i=@r26.me header.b="pciELZ1d"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-08.mail-europe.com (mail-08.mail-europe.com [57.129.93.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C18282F33
	for <linux-wireless@vger.kernel.org>; Tue, 14 Apr 2026 05:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.129.93.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776142966; cv=none; b=omYIDvwKe/WU2Uac8Brutsj+v6Hc386pBXlgULLK7EKDSeRA0oDOzaywey1zreqN/RpMZYu2sB63gfLp2gIsb6YayEyQyR3vbMgI4q0Hq30QN6QkaUl77o9dbqddliwT9KuSozAv2OuPE3Ka1e0UNZvaQqG2H5K+tP6wIi1H4hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776142966; c=relaxed/simple;
	bh=OCWLcsNHwCEk6LHbC54ErXgKWLnSLLirH7MrRfWtx/o=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rb8OOJoaVSfGd5QjjqzfAhLbCL6NqgnX2xuxd0AL5hK2Sdwtl0jBvaB5eRyLNFV5jxb1s8WQ+EOPUhhaJDK5veV6UtRc5pF0Y+7PO821PiC17ckyd0HCmGx/zdelJWS2UZcI4r5jxijtUUX4W9Mvx9inznnV2ABADSm7OxlxcqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=r26.me; spf=pass smtp.mailfrom=r26.me; dkim=pass (2048-bit key) header.d=r26.me header.i=@r26.me header.b=pciELZ1d; arc=none smtp.client-ip=57.129.93.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=r26.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=r26.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=r26.me;
	s=protonmail; t=1776142951; x=1776402151;
	bh=OCWLcsNHwCEk6LHbC54ErXgKWLnSLLirH7MrRfWtx/o=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=pciELZ1d9XEsOXKnyAdFvX4fin0TH6YjSqA3xZktddGHRvoT/teGA1YvIVcRlR8hp
	 x6wwj6vezwRisTwGfL+jdraXMty0Eb4iwhyrJoSyfYsiqSDoVEk+5FjWw0b4XcE3ri
	 YnUJDLKrCh5QFGRpdWqqFcioRkcv2RaqpSjKBExFw5ZRIDZ39we6YHUOdygC6HJPfT
	 tmfncuycxahorSmqTJNq4+pHh0FjgWtryIh0mzpAs4Yh5AsRSKM0bd4Zcfm4YlT9Wi
	 7PaxxeBw8bkW9DCX/PgJ7fpCW4OPC0yF6dBQiCqdyNk2Ifx2eu1Pt0FCp99IOZd/a4
	 KLfDV1GJi5ZrQ==
Date: Tue, 14 Apr 2026 05:02:26 +0000
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Rio Liu <rio@r26.me>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "johannes@sipsolutions.net" <johannes@sipsolutions.net>, "benjamin.berg@intel.com" <benjamin.berg@intel.com>
Subject: [PATCH] Skip ieee80211_verify_sta_ht_mcs_support check in non-strict mode
Message-ID: <AKVRf_yEu2mRCJekCJpre5xXMuHa_3_dO7_H1UU8fiKZRjJUf96ZKepiR999NwpiVwmzWBYoKipBpx1rqZatVihMYOCvANUnbeoyI2U7ct0=@r26.me>
In-Reply-To: <7h5kwW8K-FIgMb5P9VQ1BwuECi1JtpQP3RNBytb3F0k2g6DtBAnz65o1smDvWOr2ag9Kla-YpMSGyN1NsU7yYslLU-K9NCyTAxjyx-PEEF8=@r26.me>
References: <7h5kwW8K-FIgMb5P9VQ1BwuECi1JtpQP3RNBytb3F0k2g6DtBAnz65o1smDvWOr2ag9Kla-YpMSGyN1NsU7yYslLU-K9NCyTAxjyx-PEEF8=@r26.me>
Feedback-ID: 77429777:user:proton
X-Pm-Message-ID: 3024d96ba447ae0cae267b55b94a25e2c14dfc74
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
	R_DKIM_ALLOW(-0.20)[r26.me:s=protonmail];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	DKIM_TRACE(0.00)[r26.me:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-34725-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rio@r26.me,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,reddit.com:url,r26.me:dkim,r26.me:email,r26.me:mid]
X-Rspamd-Queue-Id: D70A83F5A77
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Some AP advertise 3 or 4 spatial stream MCS indexes in their basic
HT-MCS set. On cards with lower (2x2) spatial streams, the check would
fail, and we'd be stuck with no HT when it in fact work fine with
2-stream rate. This change makes it so the check is only performed in
strict mode.

Signed-off-by: Rio Liu <rio@r26.me>
---
My previous mail is showing up as empty on LKML for some reason.
Apologies for that, trying again.

There has been some reports that WIFI speed is capped on some routers:

Link: https://linuxcommunity.io/t/intel-ax210-speeds-capped-at-20-mbps-on-m=
ultiple-distros/6708/28
Link: https://bbs.archlinux.org/viewtopic.php?id=3D312952
Link: https://bbs.archlinux.org/viewtopic.php?id=3D313033
Link: https://www.reddit.com/r/Rogers/comments/1s89j9f/xb8_5ghz_dfs_channel=
_broadcasting_at_54_mbps/
Link: https://www.reddit.com/r/Comcast_Xfinity/comments/1s7fc3f/recent_firm=
ware_update_to_wifi_gateway_breaking/
Link: https://www.reddit.com/r/Comcast_Xfinity/comments/1sg9r6z/slow_intern=
et_for_linux_computers/

Apparently some APs advertises higher MIMO streams than the device
supports. In that case, HT-MCS check would fail and we fall back to
20MHz channel. A patch exists here that bypasses the check completely:
https://github.com/WoodyWoodster/mac80211-mcs-patch, and have been
reported to get 80MHz channel back.

This patch adds a check on STRICT flag before verifying HT MCS set from
the AP, similar to how it is done in ieee80211_verify_sta_vht_mcs_support.
---
 net/mac80211/mlme.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 810bea1aacc5..0e33733ac634 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -419,6 +419,15 @@ ieee80211_verify_sta_ht_mcs_support(struct ieee80211_s=
ub_if_data *sdata,
 =09memcpy(&sta_ht_cap, &sband->ht_cap, sizeof(sta_ht_cap));
 =09ieee80211_apply_htcap_overrides(sdata, &sta_ht_cap);

+=09/*
+=09 * Some AP advertise 3 or 4 spatial stream MCS indexes in their basic H=
T-MCS
+=09 * set. On cards with lower (2x2) spatial streams, the check would fail=
, and
+=09 * we'd be stuck with no HT when it in fact work fine with 2-stream rat=
e. So
+=09 * check it only in strict mode.
+=09 */
+=09if (!ieee80211_hw_check(&sdata->local->hw, STRICT))
+=09=09return true;
+
 =09/*
 =09 * P802.11REVme/D7.0 - 6.5.4.2.4
 =09 * ...
--
base-commit: d65b175cfac64ee65506eea7fa573d291a9694ca

