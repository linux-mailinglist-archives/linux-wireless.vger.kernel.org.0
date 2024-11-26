Return-Path: <linux-wireless+bounces-15732-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DB29D9E78
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Nov 2024 21:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4F651611A0
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Nov 2024 20:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA361CDA2E;
	Tue, 26 Nov 2024 20:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monroe.io header.i=@monroe.io header.b="ZvS5CaD4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF688831
	for <linux-wireless@vger.kernel.org>; Tue, 26 Nov 2024 20:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.79.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732653672; cv=none; b=pgV3MLX5TNWBzwFRYPcbFDhQO5peGmS3LnRxzv9tTR+MrZlBXrhY9WAvQn31M62eHi4JJj2WH5d1QtQZ8cgC1iJuqNntx6wzjRRoL9Wz5WbF/FnMys5n6tz//Az2woIAayI7Vfiaqt2X+Xcl9xSNHFjUAZRPhnepp1rvBSR+q0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732653672; c=relaxed/simple;
	bh=BHATuqEzXWan9Ue6g78j5Ob25RfRPbaHVDtMMsQf9QQ=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=tu0Eg5QzBj5eTTlenYRYsB7mn43WiY4xX2xWNYDZ/f4aEsV8WBVOvAy+mSXChonBLrOr3Yl0vjFAsPfZ1MEXaDJSux/c+C6kC+1Bk4VO8DSn0S9OByX8lRt/G+WYkOVPW1Lan09Qinmi1DLRdOlf+m8cl9kQUEV1tYbXfgVOFKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=monroe.io; spf=pass smtp.mailfrom=monroe.io; dkim=pass (2048-bit key) header.d=monroe.io header.i=@monroe.io header.b=ZvS5CaD4; arc=none smtp.client-ip=51.77.79.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=monroe.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monroe.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monroe.io;
	s=protonmail; t=1732653653; x=1732912853;
	bh=KG/Kg0ePMdkfS4t5EFLIRwRC4Dq4IlcBVb7Xm75eJbU=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=ZvS5CaD4YYZpKp/QfYVYA9QemezOwhZM6t4YgEV39H93i3QtHsjsItpbWecNF680e
	 FVBvdFM+NiNbxPx+bef6wr7sa4cP5YP8GrkyXZLx2tPVp66we2OZxYHWaTqxP2hmq5
	 gomYJnk7xfZfcEXoZIK0fIxtYEu2xO1euXiZ9ZpI8Qa9OKtyFOM5nC5cjDdvuPLbKc
	 v6dVm/2I4u6GBDP72Ihb1PTwtLwNYjULMeA1OxmKTJaq8NFHzdTb5RAmdOL5a+78PS
	 0Kk+DdNIZD/y3XHbjvFmlz6EVSsimdzp4u5tKSBActfwrMZIPXgfY/N/r4AjO8OI16
	 EGOuhQTU6qeJA==
Date: Tue, 26 Nov 2024 20:40:49 +0000
To: Felix Fietkau <nbd@nbd.name>, Johannes Berg <johannes.berg@intel.com>
From: Chad Monroe <chad@monroe.io>
Cc: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>, Shayne Chen <shayne.chen@mediatek.com>, Evelyn Tsai <evelyn.tsai@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>, linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org, Chad Monroe <chad@monroe.io>
Subject: [PATCH] wifi: mt76: mt7996: exclude tx backoff time from airtime
Message-ID: <88821d8f08e2715927939b35e630a06171962636.1732653612.git.chad@monroe.io>
Feedback-ID: 9731019:user:proton
X-Pm-Message-ID: 8f0a5ca459019cf184da20d2b34238f678a70372
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This helps to make STA airtime counters more accurate.

Signed-off-by: Chad Monroe <chad@monroe.io>
Suggested-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/init.c | 4 ++++
 drivers/net/wireless/mediatek/mt76/mt7996/regs.h | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net=
/wireless/mediatek/mt76/mt7996/init.c
index f6a010b61a8a..afc4884f7ba2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -460,6 +460,10 @@ mt7996_mac_init_band(struct mt7996_dev *dev, u8 band)
 =09mt76_clear(dev, MT_WF_RMAC_MIB_AIRTIME4(band),
 =09=09   MT_WF_RMAC_MIB_QOS23_BACKOFF);
=20
+=09/* clear backoff time for Tx duration */
+=09mt76_clear(dev, MT_WTBLOFF_ACR(band),
+=09=09   MT_WTBLOFF_ADM_BACKOFFTIME);
+
 =09/* clear backoff time and set software compensation for OBSS time */
 =09mask =3D MT_WF_RMAC_MIB_OBSS_BACKOFF | MT_WF_RMAC_MIB_ED_OFFSET;
 =09set =3D FIELD_PREP(MT_WF_RMAC_MIB_OBSS_BACKOFF, 0) |
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/regs.h b/drivers/net=
/wireless/mediatek/mt76/mt7996/regs.h
index 06e307b5b02e..1876a968c92d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
@@ -175,6 +175,9 @@ enum offs_rev {
 #define MT_WTBLOFF_RSCR_RCPI_MODE=09=09GENMASK(31, 30)
 #define MT_WTBLOFF_RSCR_RCPI_PARAM=09=09GENMASK(25, 24)
=20
+#define MT_WTBLOFF_ACR(_band)=09=09=09MT_WTBLOFF(_band, 0x010)
+#define MT_WTBLOFF_ADM_BACKOFFTIME=09=09BIT(29)
+
 /* ETBF: band 0(0x820ea000), band 1(0x820fa000), band 2(0x830ea000) */
 #define MT_WF_ETBF_BASE(_band)=09=09=09__BASE(WF_ETBF_BASE, (_band))
 #define MT_WF_ETBF(_band, ofs)=09=09=09(MT_WF_ETBF_BASE(_band) + (ofs))
--=20
2.39.5



