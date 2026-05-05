Return-Path: <linux-wireless+bounces-35944-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJXsClom+mlIKQMAu9opvQ
	(envelope-from <linux-wireless+bounces-35944-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 19:18:18 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1464D1EE4
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 19:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 84B58300D177
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2026 17:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C8730EF77;
	Tue,  5 May 2026 17:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=met-dubbel-l.nl header.i=@met-dubbel-l.nl header.b="dHZ90Gpc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-24422.protonmail.ch (mail-24422.protonmail.ch [109.224.244.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7942B264614
	for <linux-wireless@vger.kernel.org>; Tue,  5 May 2026 17:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778001492; cv=none; b=juDC7P7/w1fKfZcbu3zb7/GDsQ++RV0WO4Kj6xkqoaTh884uF+IytpMr2RPEmLM43dqE0mJOkkm3zstIEOqCJXM1YHoyKDGs9nYAacQ6gcFG1q3jmKZlFpy8Qbe79oDa0V0PKM9GrnALu0TvJZjnsKdMP6XRt9QGINCB/CkpXOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778001492; c=relaxed/simple;
	bh=a6eI7IFmsnRxyoPP9Vp5tmenNOKqs93c4E03CQkljug=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=DYP85fhV+FQXOXN5/qgEhkkMQArC2hA/hPtaozne8NFgXuP+AxZcMX4m1m2pONI+fBznFplhQCkCK4LaR+p5ns+fC37Y6KZgE+WWowQ+WxtA3iFbMlPGazHAV1YcjsL1w/ayOHAcYDcgak1JZjcPEzX/y57UhTmHJk55Y0A9JJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=met-dubbel-l.nl; spf=pass smtp.mailfrom=met-dubbel-l.nl; dkim=pass (2048-bit key) header.d=met-dubbel-l.nl header.i=@met-dubbel-l.nl header.b=dHZ90Gpc; arc=none smtp.client-ip=109.224.244.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=met-dubbel-l.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=met-dubbel-l.nl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=met-dubbel-l.nl;
	s=protonmail; t=1778001474; x=1778260674;
	bh=a6eI7IFmsnRxyoPP9Vp5tmenNOKqs93c4E03CQkljug=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=dHZ90Gpcz/CtCzU4Y60M8eWzofsRUBLzXY8Tf+auivdtZ8GU65PGlS+ZBuE2151aq
	 Ftt9H1D9njHthcnGfxwKEZLc4EBfRhn+DLNr0yyDDj/KhWiMhZj2kqEYNtR44diR5C
	 r4XSy1qMU0Q3wJx6YkVCVf0mqVhhc1YXaMgSJfywD7jJoXajx3qYTwm2Kvc1eLvcbu
	 /IaR3VVqXz4Iz0OZhFtSktWRYWY+U60vyadxz2xX5dBJ9RlJZdBmWm0kJ6uAEUXiKQ
	 wKjTlZRVecmCDudBFoynDUmobmsO23fOFbCl6qshFyhBopcVVIarsxos5p1TfqPWA1
	 ivxnA7b0NLKzQ==
Date: Tue, 05 May 2026 17:17:43 +0000
To: jjohnson@kernel.org
From: Willmar Knikker <willmar@met-dubbel-l.nl>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Subject: [PATCH v2] wifi: ath11k: fix use after free in ath11k_dp_rx_msdu_coalesce.
Message-ID: <20260505171709.547274-1-willmar@met-dubbel-l.nl>
Feedback-ID: 179140708:user:proton
X-Pm-Message-ID: 2281339faea54f13495509c164443c2375dad580
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 9C1464D1EE4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[met-dubbel-l.nl,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[met-dubbel-l.nl:s=protonmail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[met-dubbel-l.nl:+];
	TAGGED_FROM(0.00)[bounces-35944-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willmar@met-dubbel-l.nl,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

In ath11k_dp_rx_msdu_coalesce the loop uses ->is_continuation after
the dev_kfree_skb_any. This can cause a use after free kfence.

Use flag for caching is_continuation for use after the
dev_kfree_skb_any.

Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
Signed-off-by: Willmar Knikker <willmar@met-dubbel-l.nl>
Changes in v2:
 - add bool _is_continuation for use after the free.
 - Add Fixes, label to commit.
---
 drivers/net/wireless/ath/ath11k/dp_rx.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless=
/ath/ath11k/dp_rx.c
index fe79109adc70..16364f76fc3c 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -1761,6 +1761,7 @@ static int ath11k_dp_rx_msdu_coalesce(struct ath11k *=
ar,
 =09int buf_first_hdr_len, buf_first_len;
 =09struct hal_rx_desc *ldesc;
 =09int space_extra, rem_len, buf_len;
+=09bool is_continuation;
 =09u32 hal_rx_desc_sz =3D ar->ab->hw_params.hal_desc_sz;
=20
 =09/* As the msdu is spread across multiple rx buffers,
@@ -1810,7 +1811,8 @@ static int ath11k_dp_rx_msdu_coalesce(struct ath11k *=
ar,
 =09rem_len =3D msdu_len - buf_first_len;
 =09while ((skb =3D __skb_dequeue(msdu_list)) !=3D NULL && rem_len > 0) {
 =09=09rxcb =3D ATH11K_SKB_RXCB(skb);
-=09=09if (rxcb->is_continuation)
+=09=09is_continuation =3D rxcb->is_continuation;
+=09=09if (is_continuation)
 =09=09=09buf_len =3D DP_RX_BUFFER_SIZE - hal_rx_desc_sz;
 =09=09else
 =09=09=09buf_len =3D rem_len;
@@ -1828,7 +1830,7 @@ static int ath11k_dp_rx_msdu_coalesce(struct ath11k *=
ar,
 =09=09dev_kfree_skb_any(skb);
=20
 =09=09rem_len -=3D buf_len;
-=09=09if (!rxcb->is_continuation)
+=09=09if (!is_continuation)
 =09=09=09break;
 =09}
=20
--=20
2.54.0



