Return-Path: <linux-wireless+bounces-26606-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49BD4B35226
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 05:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09F9917C410
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 03:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81C42594B7;
	Tue, 26 Aug 2025 03:17:08 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FD71F4165;
	Tue, 26 Aug 2025 03:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756178228; cv=none; b=YNbGRxfUlUbJrzHDnYV5Wjv3TYyK9PmygAWieuzhA2TGcX6nnkS5ucak/W06msfKnXmhy5S9PcS5sw8oXUf9MAihDzFXp+afWAZcEM3H/tjRG/lA+fLGZlydgvoi6lzwFRq03SkR5gUV+4d0QC7aOh/fKEsj/tlRo7MBZHMu4uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756178228; c=relaxed/simple;
	bh=rZZS7XxvYff8UplxWngQ5EOMk9dIwfeqcUkMFXg8E5I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M5ZaWjLhpBlddI84P3SrXG6O9NKyKCL2OdeTB21NQ3cYpNmcDiJie3lW0h2XnI4bF2XnutKZSo+TXOJU8bnTOpljkV/IOMPZZwW9cXz4eO5LSszRkBRHS9ihWHD8zPS/xWCBhmncfZgYbD/3cxOg6Ie3VyhHqXFyW/N08wgtaGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 1d7e8f9e822b11f0b29709d653e92f7d-20250826
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:a4c2def1-cbd4-4832-8dc3-a9dcabd11ea7,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6493067,CLOUDID:27ec317d6c360ade35356f733918c402,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|83|102|850,TC:nil,Content:0|50,EDM
	:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 1d7e8f9e822b11f0b29709d653e92f7d-20250826
Received: from node4.com.cn [(10.44.16.170)] by mailgw.kylinos.cn
	(envelope-from <tanzheng@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 710774536; Tue, 26 Aug 2025 11:16:53 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id A735C160038C0;
	Tue, 26 Aug 2025 11:16:53 +0800 (CST)
X-ns-mid: postfix-68AD2725-464022963
Received: from localhost.localdomain (unknown [10.42.20.101])
	by node4.com.cn (NSMail) with ESMTPA id EC81516001A03;
	Tue, 26 Aug 2025 03:16:52 +0000 (UTC)
From: tanzheng <tanzheng@kylinos.cn>
To: arend.vanspriel@broadcom.com
Cc: johannes@sipsolutions.net,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	tanzheng@kylinos.cn
Subject: Re: [PATCH v1] wifi: cfg80211: simplify the code
Date: Tue, 26 Aug 2025 11:16:52 +0800
Message-Id: <20250826031652.454464-1-tanzheng@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <11546959-3090-4070-93fa-349bc64f3bdd@broadcom.com>
References: <11546959-3090-4070-93fa-349bc64f3bdd@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Arend,

This is my mistake. Here I confused driver name and device name.After you=
=20
reviewed the code, I tested it and found that it was wrong.=20

Thank you for your correction.I will remove the wrongly modified code and=
=20
submit a new patch for modification.

Best regards,
Zheng tan

