Return-Path: <linux-wireless+bounces-20995-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DDDA763D6
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Mar 2025 12:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C71807A2D11
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Mar 2025 10:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57491DF244;
	Mon, 31 Mar 2025 10:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="g8yl8tmh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF2D1DF248;
	Mon, 31 Mar 2025 10:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743415659; cv=none; b=mnnYq5mD2uhOtDSkDJt05VrsBX9eYyY8CI1bEOj6fpSmx3DFJWW9j6BPGPWce+KnD6B8ms3xSyCB7VMRehnyUsRwbFA8UMPKFIZbK+clRIWFEgPcRqJjZo2G15Udn/eKa9dunY9md3aCg4LbCRMiaQV6ufTUrqsZltWixpsKC+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743415659; c=relaxed/simple;
	bh=sU7HrxlC9X3SIigWg3LaSJnHeY4oUGBQMCo+9Mv3unk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U+0HcAfuq45kQ0MqOL/qzFo5KKy9dnv/U7sCEocMG9Av+eV80p8wKckQ4edfhvoiygKgpu7btUkZo9bmnKQ6nYFuh0EDvZmlkfQfJI6amG5GyZN4pOjUE5NDLJ0JVCyKOMQnDjoVn0jyb9UU9PSGMbL9S15khG/jhbs4iOyRBBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=g8yl8tmh; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=BzRbmbdVH64WkPtUMsoKFbvdXYbRjm6+e5C6pk5/ync=; t=1743415658; x=1744625258; 
	b=g8yl8tmhzuS62Dhku9sh0QB0M9luFn11x2E8dQGuyGZYzUBaIT1H4MoB0CJP/CB5/NHbIipb/Ro
	TUlqmN9x1o9pinPlSQZXfFtwWjF7aj6LLY36fOumGDoTXQLMZVYdgwbXWzGfLB4D/Ti6B37xf0rPW
	4PycnpqCfnf7OC1kVQ2YrfVSnASiqGBI383IBEtlLeN9Id79ng59bqZ7fWDWQAbssDOa57sqfX9+c
	dVgSCtFzMVpA/dDhs0v7947DkH+RcZBKa6osDDLsKR6v8xDhrYKCq9QkuUiQocLRn2BPowp1amdWc
	3Tufvo3pucUXym5bjTkQ92m8QmfXz07O5+sw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tzC3K-0000000B8h4-0OPy;
	Mon, 31 Mar 2025 12:07:34 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-mediatek@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [RFC] net: ethernet: mtk_wed: annotate RCU release in attach()
Date: Mon, 31 Mar 2025 12:07:32 +0200
Message-ID: <20250331120731.ac482033a33a.I550c501b29788714dad469cf99e2a81ed06d0565@changeid>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

There are some sparse warnings in wifi, and it seems that
it's actually possible to annotate a function pointer with
__releases(), making the sparse warnings go away. In a way
that also serves as documentation that rcu_read_unlock()
must be called in the attach method, so add that annotation.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/linux/soc/mediatek/mtk_wed.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/soc/mediatek/mtk_wed.h b/include/linux/soc/mediatek/mtk_wed.h
index a476648858a6..d8949a4ed0dc 100644
--- a/include/linux/soc/mediatek/mtk_wed.h
+++ b/include/linux/soc/mediatek/mtk_wed.h
@@ -192,7 +192,7 @@ struct mtk_wed_device {
 };
 
 struct mtk_wed_ops {
-	int (*attach)(struct mtk_wed_device *dev);
+	int (*attach)(struct mtk_wed_device *dev) __releases(RCU);
 	int (*tx_ring_setup)(struct mtk_wed_device *dev, int ring,
 			     void __iomem *regs, bool reset);
 	int (*rx_ring_setup)(struct mtk_wed_device *dev, int ring,
-- 
2.49.0


