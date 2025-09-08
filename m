Return-Path: <linux-wireless+bounces-27068-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86EA2B48241
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Sep 2025 03:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64461189B569
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Sep 2025 01:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F188315D3A;
	Mon,  8 Sep 2025 01:45:30 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAD7210FB;
	Mon,  8 Sep 2025 01:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757295930; cv=none; b=PjDsduO4S15SP8RaBFmXKvQziRswJ5nTAZnmwWlCIq86lshiEmD5l4YKQT1RnB1o0IuReeoRQRfemGOd4XH8/d3yhZzF32n5hnaEd5RLOLTBtD7hxV1IeXGGqxUhpUfgUq2HaOxt8cGTsVRZ2kD7tHghTxzglW10I4Nh7DWREO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757295930; c=relaxed/simple;
	bh=+D/cuszWapYFsKduS4S62GNvgKJ4ZVtrfO4oV3gwmso=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HZpr/w6h8mi7TSl4KWQfQXj8SqoXySiiC+WDcMOBrCbDu0yjerWQOeBZZ5HTDW+in2z0Yr9IFNrMoWMuePK6bqvko1TDx2k2YQ17+4EnGanNaCsmRbWHGnfvQnKOivjgBrIkIHfm/JsdISjYMWKJwApFVU6omDxmi5ZmaXcnhQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 755c33a48c5511f0b29709d653e92f7d-20250908
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:0069c780-fc42-4fbc-aecd-891d28ee24a6,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:065c8e9014fa844e4fbc973e109a1575,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|817|850,TC:nil,Content:-
	10|-8|-5|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 1,FCT|NGT
X-CID-BAS: 1,FCT|NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 755c33a48c5511f0b29709d653e92f7d-20250908
Received: from node4.com.cn [(10.44.16.170)] by mailgw.kylinos.cn
	(envelope-from <tanzheng@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1058610830; Mon, 08 Sep 2025 09:45:11 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id 68E2B16004282;
	Mon,  8 Sep 2025 09:45:11 +0800 (CST)
X-ns-mid: postfix-68BE3527-140220412
Received: from localhost.localdomain (unknown [10.42.20.101])
	by node4.com.cn (NSMail) with ESMTPA id A986B160038C1;
	Mon,  8 Sep 2025 01:45:10 +0000 (UTC)
From: tanzheng <tanzheng@kylinos.cn>
To: johannes@sipsolutions.net
Cc: arend.vanspriel@broadcom.com,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	tanzheng@kylinos.cn
Subject: Re: [PATCH v3] wifi: cfg80211: Remove the redundant wiphy_dev
Date: Mon,  8 Sep 2025 09:45:09 +0800
Message-Id: <20250908014509.190317-1-tanzheng@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <e02385300c075395346ccf70b46a648698a66a3d.camel@sipsolutions.net>
References: <e02385300c075395346ccf70b46a648698a66a3d.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

>> There is no need to call wiphy_dev again.Simplifying the
>> code makes it more readable.
>>=20
>> Signed-off-by: Zheng tan <tanzheng@kylinos.cn>
>>=20
>
>The bot complains this doesn't match your From: line, is that
>intentional?

Yes, I set it up this way on purpose. Sorry, I don't know=20
this rule. I'll modify Signed-off-by. Thank you for your comment.

Best regards,
TanZheng

