Return-Path: <linux-wireless+bounces-10195-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 199B792EE6B
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jul 2024 20:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B95EA1F22550
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jul 2024 18:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A94C16F848;
	Thu, 11 Jul 2024 18:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="FL+vMd7Q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B757516E87D
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jul 2024 18:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720721177; cv=none; b=RLHmyZaYSDW9HrNXRi1pjX5qMfyk5hbNPM+6XR3/fm1VeMu79/UPV5YD1cinWcP8ubnUcPaGNMnlhgUP5VxR/1qdasQ8TTzfI+1/SJloR1+xoaMvzBOL/bGzrZpXt/nKTXrG6v5xNKrPtrWNbaGBQy/6aarmPd4mL11rW5Yah1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720721177; c=relaxed/simple;
	bh=rWZw2uSppDRdluJRuv2WYP40sGBG0hh2UFbMn1nxL1U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Et4TWsjbQqPBfiQR8um/YtcAbH5y4spUL0hGDno3x3pWeBStOv6ROGE0BiR0+2blkIFMmimENfwVht++m8P3lSZxvlSx5U6vaF/0eurhkAZ7xKTz0KEgQQq52Ndi00LQdzGthrZY4G8S/PPmahaeLC8sN5yxXSolKXVV3iZlDGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=FL+vMd7Q; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720721152; x=1721325952; i=spasswolf@web.de;
	bh=9t23BqUwT489+BhKxEd/YtWGz38FvcAET34q8jd+6aU=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=FL+vMd7Qb+gNo3bykV/mgNvhzTYkya83jCONMTQBNO6ulHHktTN3uD1sWytxUK7v
	 P6F7j1w8S9FcKM8o0c9oA+ELGFEFcfM/ttbA3rTJ2bDJCZ4Jv2X1DOvnuTgUrIcjj
	 L+kdsOaIFqfbECbwLqQF1Iw9i5TrbMJsunON8TdQi60qaLDlK4RZimy9M9Uuj+7vv
	 9INDpzGfqIgG3JjZV+k7ADForrXZnmGeFDDRJQyzKcl8I8uEm5kMH1QV0zsnNmGWm
	 QmDB/Sx8F0hNleq7l0YVi4K8QG0lti1PRFTzyiK7IzAcw954asY0Nyp1GXs+JkjCo
	 esy4K5SJumPD0D/2qA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([84.119.92.193]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MOUxu-1sj3Us0Qf8-00LmZV; Thu, 11
 Jul 2024 20:05:52 +0200
Message-ID: <a88dbf3d811970044ae1e489f5711d40347596d6.camel@web.de>
Subject: Re: patch 46/47 causes NULL pointer deref on mt7921
From: Bert Karwatzki <spasswolf@web.de>
To: sean.wang@kernel.org
Cc: deren.wu@mediatek.com, linux-mediatek@lists.infradead.org, 
	linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com, 
	mingyen.hsieh@mediatek.com, nbd@nbd.name, sean.wang@mediatek.com
Date: Thu, 11 Jul 2024 20:05:50 +0200
In-Reply-To: <20240711175156.4465-1-spasswolf@web.de>
References: <20240711175156.4465-1-spasswolf@web.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-1 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:fmiCmur7DOthIlGeLEcj2oMXAni9f2RVelfzIWnDiCqpnUS2nbk
 g2FyM2irqsvtiS2PN+xxXXo184ooyIZCQS9bjCYtRdYZnoRzwUMAr6A/OvHG2pVIPXolj4E
 OAhSAVFXB1vPzYNfvrYH7sau/Wspkq96ZIjWGS5tLPEOOFTX/75cBv4CznAqQjyq/QiDm/l
 6muW7ZcHEVWRI4yGEFK3g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XCwTzY2aVto=;bGRQHaF2Q61qGel0hkST9eCrCsP
 bYq/vQHFhwGzuCsDvO3qj+0sVQC7sGMzyenNdMwjd+eouJfNtSMDDjb0psUwjwn5E2D8/Zx5+
 WqkBImxAepJLZsBK024HNGqChu+yBuoX8qo5xm4qo9rSi8iVk2yDRyGyWK7YCq1mNbYHY0wkI
 sVjhhYV5BlmCr9Vo8C82Sxyvl/kCz2Fw1uzoTelrSzKNBQ1QH/HwW4XAoDenGujiCcLB/L/EC
 dAPwrTyKaIX2BSKuSjQXuh/8aahR+5QvxXbSrsqHyOY1tUyeOUmI4rEuJQhLpkO8rEb8Jd9sJ
 thRHtlV3BolpicTFKIM98ubajc+e5Hl9TCJAwxqt715LI12L309SgMXi26Xud/KYSyQsiUNkX
 0DiEC2Hj82LOtXNf1WY/sx+JDRtp8L0pbVCj5Zbci/k99cL4I3EUnXo5qwIfV2rhCmTMH5c31
 Pyu3YRnUpQ44MkbB4XpiIvJhLubcx1po0aZJCKDoqoMDaaSO+1zaHg7suXduQ09GTvWlVZaA/
 evZThSJbBrBbK4abwzZJtB7tLyJ+OFKOkK4PhbqWFQrDhcHUsXExlyvaHYxPep3LUUiAp9x10
 44I0mYgmckyeVf3YlMlrPLzn3X+vCW3NGyo2uuEqCuH98g/62XpjL0oF1fan0VepwLPkicZy/
 RDb+m5pZYKmO5EmadGeqoamvNJCDKmq51WwehHYDfB7dCyROrnT+k3WHn9ocEAUXlOM+tFmFS
 fyVWPkzMIG3lE4jfzFQC+ZJduUYlSZ09KRM44DFe/eaqy7xFgoVpE5hazU9RKCosybFRvbgLl
 bhDgdSOdvyeMNmWltPRJnIXQ==

The mt7925_ops struct contains these four ieee80211_ops which
are not present in the mt7921_ops struct. In mt7925_change_vif_links
mconf->vif is set.

from drivers/net/wireless/mediatek/mt76/mt7925/main.c:
	.vif_cfg_changed = mt7925_vif_cfg_changed,
	.link_info_changed = mt7925_link_info_changed,
	.change_vif_links = mt7925_change_vif_links,
	.change_sta_links = mt7925_change_sta_links,

So I think you're probably breaking generic code (i. e. code that is also used
on mt7921) with mt7925 specific changes.

Bert Karwatzki

