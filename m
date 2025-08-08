Return-Path: <linux-wireless+bounces-26226-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9F3B1E93B
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Aug 2025 15:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B45C84E3AF8
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Aug 2025 13:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E7D27EFE9;
	Fri,  8 Aug 2025 13:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monroe.io header.i=@monroe.io header.b="T1OGgHpv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67DC27E079
	for <linux-wireless@vger.kernel.org>; Fri,  8 Aug 2025 13:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.79.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754659807; cv=none; b=Uxo2vR15tBTEiyvaLaTvekhINxeNQhq5VeqY+GCe7JS1gw0tOW4RtzlMofnqTsVhe1cK7rm8WntWzyU8nKyrVdmCFqwSbJtrFpE8HWssxvEsEUwIR9s3LMwDxuCKbV9kmStCvLWZm5KUudNZm9RbOxg2PRWtdq2CJ7zaKPG8d4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754659807; c=relaxed/simple;
	bh=wF0xbMG8tZTBUrc1y/ZPV7ibruodGcB6nZNxjIP218A=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=qqj11J5ReU0kncaya1oHvttcRrbHzfTNIBOG4HPI1BF02yWl7EZ3HM0gfuNcMeztDZ6OwqA/4jfKYoqIkBSFgs3k5qxk3EcVILcjf1NvroOgryDurbepfrsLEHPAWxlZMoIgXHf6rRXhw0riS4AqbGJZpeN3CF6+ltwQS182RU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=monroe.io; spf=pass smtp.mailfrom=monroe.io; dkim=pass (2048-bit key) header.d=monroe.io header.i=@monroe.io header.b=T1OGgHpv; arc=none smtp.client-ip=51.77.79.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=monroe.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monroe.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monroe.io;
	s=protonmail2; t=1754659792; x=1754918992;
	bh=JgWMhkvaWwS7Ic7D5DggHNFRz1ZgfJ1G5+UNUzTR8XY=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=T1OGgHpv+b0XwOon7ODNAb0S8+p9z7r90wmwjkMyOPT0kDuAF0zTdLq+MR8DVqDsV
	 6H70kDSW772CyWVs0xYuzKkj8a1m/z2u2s98tURcysDfX8WbtKXKRa0RkO15lFXG4G
	 KB9tq4eD8v6/3NUDEpFB8ERQquxmJPioHSAMdAYRLSaMaRdg5xqyB7qVNeBb2AKm3t
	 ERwC4wCyQ8a1+KVMrf3va7y/i0y1Yax0y2N+GdZkaXg8wQouQRT9bJ9h8NHuUc52hu
	 If/cGAqBCT7AzZ9iGNFAy0fBA36XMCqk+duKwHkwtRD2q4RoxmM26b3hr18WeXrpAO
	 eEbCukqRaj6Sg==
Date: Fri, 08 Aug 2025 13:29:48 +0000
To: Felix Fietkau <nbd@nbd.name>, Johannes Berg <johannes.berg@intel.com>
From: Chad Monroe <chad@monroe.io>
Cc: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>, Shayne Chen <shayne.chen@mediatek.com>, Evelyn Tsai <evelyn.tsai@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>, linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org, Chad Monroe <chad@monroe.io>
Subject: [PATCH] wifi: mt76: mt7996: use the correct vif link for scanning/roc
Message-ID: <180fffd409aa57f535a3d2c1951e41ae398ce09e.1754659732.git.chad@monroe.io>
Feedback-ID: 9731019:user:proton
X-Pm-Message-ID: cfdb5118aa7660394b7ca1f4b8bfb9e76b2779f1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

restore fix which was dropped during MLO rework

Fixes: f0b0b239b8f3 ("wifi: mt76: mt7996: rework mt7996_mac_write_txwi() fo=
r MLO support")
Signed-off-by: Chad Monroe <chad@monroe.io>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/=
wireless/mediatek/mt76/mt7996/mac.c
index 226534490792..6333a064c4f7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -903,8 +903,12 @@ void mt7996_mac_write_txwi(struct mt7996_dev *dev, __l=
e32 *txwi,
 =09=09=09=09       IEEE80211_TX_CTRL_MLO_LINK);
=20
 =09mvif =3D vif ? (struct mt7996_vif *)vif->drv_priv : NULL;
-=09if (mvif)
-=09=09mlink =3D rcu_dereference(mvif->mt76.link[link_id]);
+=09if (mvif) {
+=09=09if (wcid->offchannel)
+=09=09=09mlink =3D rcu_dereference(mvif->mt76.offchannel_link);
+=09=09if (!mlink)
+=09=09=09mlink =3D rcu_dereference(mvif->mt76.link[link_id]);
+=09}
=20
 =09if (mlink) {
 =09=09omac_idx =3D mlink->omac_idx;
--=20
2.47.2



