Return-Path: <linux-wireless+bounces-2822-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D40F38426D2
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 15:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 773B828C5B6
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 14:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A576EB4B;
	Tue, 30 Jan 2024 14:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="KxOug5Gs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C362F6DCE8
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jan 2024 14:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706624564; cv=none; b=bNUbWIEVWZJaJn5ipZOhGZtj5UprX2pmF9cMpvzPpInNOvy9Nx3dIQPbCStK9D3mBE0opt2VUaM6CVRAHtbkEaTGnzIWPA2qiIbvbLESWGvTBzYV/L2PCCkosEoCvcJ/xz8Y1Dtl00tgG9f/XElQCMXYep7IX0xUUNuk0edhPko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706624564; c=relaxed/simple;
	bh=jovUfV7P3Q8/DZ0aChzXvcwNX7L3Hayh3q3WEUitm8g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bmnPPSoDxxDNRlrk+rcUj+WeWZhQR3azYC3GCh3PJoHtYw7312f6tjjlhD6lG1Cx9eEwB8wCY77Gqgk52wdYM7KJGMtP6SEEjTX8u2PzF2ecm6nh5IK/NOw2Fa4R0n4eHdZUnFGNivEtwK5KxBS0q0F5Ja5r8c9Whonxqz17acw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=KxOug5Gs; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=v5eStm1dkrWRN26gj+rHtivEKZr1p45PZ4ddqjju9Z8=;
	t=1706624561; x=1707834161; b=KxOug5Gs/Ol06WGrJgS5cg4vWrp9bnms3bSYVQeC4xpHImH
	2pZDZbiRR+do3eb84/IiyX3jpeCMzOoxBZBFE2sf7lYGrgxNsKJdOv91TSJVWzIu4D4wjdniIPwTj
	h1AryFT9OQlyLYZNxY3pF85vjn1Bx6Y/Z1THoSiVUe/Ri40EK2eFqbDwqmZf1Uglew2GwB6EM0eVJ
	5KmiPNu7JOaIWUr2MNHpS6eo1yoGOq8P1n8k2dshMiX19D3FBWOMLqDFMER2kTV4Y2DpxNaj2PPLq
	y7oV+4vTEymoJHn1k9VYGWCyv9Ui79RslsMIwsHaLYmI1K9HN4FlF4qsmnoyX8eQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rUp0Y-000000065zr-0J1e;
	Tue, 30 Jan 2024 15:22:38 +0100
Message-ID: <119d60053afa6f5eb9af6597d895f1da1065d7c5.camel@sipsolutions.net>
Subject: Re: [PATCH 15/15] wifi: cfg80211/mac80211: move puncturing into
 chandef
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Tue, 30 Jan 2024 15:22:37 +0100
In-Reply-To: <20240129194108.307183a5d2e5.I4d7fe2f126b2366c1312010e2900dfb2abffa0f6@changeid>
References: <20240129184108.49639-17-johannes@sipsolutions.net>
	 <20240129194108.307183a5d2e5.I4d7fe2f126b2366c1312010e2900dfb2abffa0f6@changeid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

>=20
> Move puncturing into the chandef, and adjust all the code
> accordingly.

So I clearly forgot ath12k in "all the code" ;-)

Looking at the code, this seems to be an appropriate update for ath12k:

--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -2767,10 +2767,6 @@ static void ath12k_mac_op_bss_info_changed(struct ie=
ee80211_hw *hw,
 	}
=20
 	ath12k_mac_fils_discovery(arvif, info);
-
-	if (changed & BSS_CHANGED_EHT_PUNCTURING)
-		arvif->punct_bitmap =3D info->eht_puncturing;
-
 	mutex_unlock(&ar->conf_mutex);
 }
=20
@@ -6215,6 +6211,8 @@ ath12k_mac_update_vif_chan(struct ath12k *ar,
 		if (WARN_ON(!arvif->is_started))
 			continue;
=20
+		arvif->punct_bitmap =3D vifs[i].new_ctx->def.punctured;
+
 		/* Firmware expect vdev_restart only if vdev is up.
 		 * If vdev is down then it expect vdev_stop->vdev_start.
 		 */
@@ -6311,7 +6309,8 @@ static void ath12k_mac_op_change_chanctx(struct ieee8=
0211_hw *hw,
 		goto unlock;
=20
 	if (changed & IEEE80211_CHANCTX_CHANGE_WIDTH ||
-	    changed & IEEE80211_CHANCTX_CHANGE_RADAR)
+	    changed & IEEE80211_CHANCTX_CHANGE_RADAR ||
+	    changed & IEEE80211_CHANCTX_CHANGE_PUNCTURING)
 		ath12k_mac_update_active_vif_chan(ar, ctx);
=20
 	/* TODO: Recalc radar detection */
@@ -6371,7 +6370,7 @@ ath12k_mac_op_assign_vif_chanctx(struct ieee80211_hw =
*hw,
 		   "mac chanctx assign ptr %pK vdev_id %i\n",
 		   ctx, arvif->vdev_id);
=20
-	arvif->punct_bitmap =3D link_conf->eht_puncturing;
+	arvif->punct_bitmap =3D ctx->def.punctured;
=20
 	/* for some targets bss peer must be created before vdev_start */
 	if (ab->hw_params->vdev_start_delay &&


Any thoughts?

johannes

