Return-Path: <linux-wireless+bounces-20699-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFC8A6CA6A
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Mar 2025 14:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C17303BBEB2
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Mar 2025 13:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565892222AC;
	Sat, 22 Mar 2025 13:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="YiKp52KE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D381FBEBE;
	Sat, 22 Mar 2025 13:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742651716; cv=none; b=P8LFOU3PRKdbBWGmMhLg5tCd2gbOtHymLneYxDwy9zpm1buFGCuKi0inPlZibLBDWqUumiEjHOrxR6OivY6l64nKAl7/zyGuqcMzwdLEk3YaldOt94kegtyvh3gCXTEqYtPSoJx9Glt+FR0aqGSNvhhixNuge/VmmpB8w/F0PtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742651716; c=relaxed/simple;
	bh=OAzFoIi1Dk+BKN3Jo2OTfZpRc7Ma9GfswGDsRpVCJaU=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=dOyg0QN1shWqffWvuoOx7jtn8l4qWbePZeTUP4I8GqTq3A2iMToNj5bY40CQU3kz2nrCCkAEsb+rycdVrnZiEptzjU+/n8Dz6Ba3yrBvIW8lT4U8U2asZnARiOLA8TjrvorozDObIQlzgAF99scGKdhC8+gPvECZKQKpouan24w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=YiKp52KE; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1742651694; x=1743256494; i=markus.elfring@web.de;
	bh=O7Hp1tNsZwhgz/P3of7TrlgazlFotvgvbBxQfbyyEq8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=YiKp52KEUdkpdR2h91Py+7fkEdypXTEXQmZQzBPl67h3S3zIzBFWKdA0sw7J1Nyt
	 PRvhrrg3cNv56LdspsbIzhWSEi1jkDTPazgqSTYXfGuzo5afhV8RLOfmSkJmwlkzU
	 v0JeqDZaUeX9Tm//p5lLludy664pFXpcXLiRs0SLSGeAx//FrObAebjn6M7Xsfq4D
	 9dTDT2GD79CK2uHXlbGXQpxW1BHcD/HEZmK+f6l63iDSwUlKqMrSDeqy21jo2/wpW
	 NxaljBRcIHiGwZJk/1wIVKdMJ03Mau32xfQJqTsPMAi6zHNN+QF3/T1GMVFPY75WC
	 R9YDY4DdS9BkjcD8qw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.73]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MElV3-1txyRZ1hVL-00FxQ2; Sat, 22
 Mar 2025 14:54:54 +0100
Message-ID: <d220d52e-f656-4d4c-bf28-1ab40879c93e@web.de>
Date: Sat, 22 Mar 2025 14:54:52 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Qasim Ijaz <qasdev00@gmail.com>, linux-wireless@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Angelo Gioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Bo Jiao <bo.jiao@mediatek.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 Felix Fietkau <nbd@nbd.name>, Johannes Berg <johannes@sipsolutions.net>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Peter Chiu <chui-hao.chiu@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>
References: <20250322111354.23800-1-qasdev00@gmail.com>
Subject: Re: [PATCH] wifi: mt76: mt7996: avoid null deref in mt7996_stop_phy()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250322111354.23800-1-qasdev00@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6+6jc3mgaKHdDWSU214w3i+vaNpI+UR6kf62/B56NF7sQSZ0BN7
 K2+M7vsDBJv+CtuDDJF+E7V/FCmJYgU7dl5+SDuxA5tjoLrTG/Fm0xX4vSpTIvHVyh6/Oqu
 odH/QN0GhWh0+wLs6KFQoZamz5+bRtWPkOKJe3mYyaSO/DGKxDdga5a67AJY2OgJG1YwHtv
 RAuPmRE10H+OXtEga1q4A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rdP+VCTfhI4=;GwHqWqJRzDKtExJFBhXi/Zr4hrO
 ec6MamJVTbLn1W5cwj1er4s7koPp5kSW2snJ57zI2TCaevDAfpAGfWMs/mkBCHlw5XR3+wGNA
 XgMPzDSge0j8jiARLaKAlCVUweXmstu6Z16cMSF1uVtu1tYerMyV+8ygh97hIgdDAIwDsDGJH
 3tXktmg01RAAEDCYtu5OpjW6vo5U2JD8silK24r+Hgqk8wnpyEArbJvazsRVf6N9yMoOFigkP
 Zi61x/WnqIT8F60CwY1jLhnRaQe10S6IB0kp7x294d0XMYCf7dvNtLKvMFxmbPSH0bAFVLwz1
 0j6xzFr8Ep28Xn68/sxnyTeoQc/jZjRhOpNYN+NBcUlDzKYnJqDtWmsZwS8lfiytpfpKjHteC
 JRv/kmmLRRHLgkbEoBYUBD3kjmORin7myhnKEyOrJOXsOkhkKlPp97p0lSukQ+c8UcDy3zhza
 CffZJ0QC3pUMhJCUN5+RTumJFWvW6IWgkVBD1elkglTZj3m6EoQcr5DNxIY+l1QqzANagqUZa
 Vx0+8j0GjUShsgyDvCqfk/dIEqsoxCsMG0whLmXap8eKhQlHO2uOVHVtLJH9K4txuPfTkIXBf
 MrcCMaAy3O2HWyO5Df3auccmeEOSxN3m697qkuvDUkUrmv28Ni4+oA6FZl/j5qxaUMq9pChLb
 tYa4Tg0+EmVgLfqPNDu8Y+wTS4BKUnzY/wx4SS5A7XlxiPCNAUUJf9hQC/Q9EnBjNyUzW7dCf
 laOQbxxwzNRil0Oc+6IDfGe+S25HQKGa1jQIUJNoUYD5NYItArQryO6h5vqHgBugS5EnVZtnV
 llb49wyxKJIAu1tDcJf3yDszicEb+DAXOv+1QcHiTDxSyLqWqJ0vfryNb5hRyXWrE2dOYc1Ry
 S/MbiMwnpPIvcREFGhndkD0R/rIpzEKJJuTCJAIZ/+u7DBVAgBUy54RA93/KLGQEBLfsbjLxG
 BCfATaUl86PmOXCKQ/k8U6La0tj0Xgfxl9x+O+gt9pi3y1VPmFlJ99ZkWlvx1Y8Qvf7JuemYv
 +bvXiAqDj0fKsSFN3hOxkw8Ry++qmOUX6i2BFe+jSsyfCSfIpt63Y4djGqHvWJr8No6XzI5CQ
 lAcup+WSaCHFsXTVtWwpUud5PGCH+tNTRez160rDixg2WRiZ8fE1fimW6ZEDJxuKxUqbHg1S3
 nNJpZ1Y9Gj9kYjXjHdQslK6oXVRNqzK9dIPyHTJQuNPZmj9eneryfNDQ4ncFWqEPFpeTGVmdr
 z0VIrwUbczQzd6OehtTZkLmmL9svBjQrxnJWTqXocW2w4FBJircN+bhHzgEt1UNINqxefdj1z
 bX/LVBT+5woKNFu2mqpnRDzW/yNAqwYi988PXc6wg10xf58Ble6oZ7G/ppz68yJwkU8k30klt
 E5jp5ggSQnpnX859i16K5r0uOsx3nueQ9u/QX2R1TECmGBzvUkwUBcsp4VEo6AdZAqJXnuHV4
 jHQULGbvvlK21tM7CpQb+hP9y2ovKXj2dyNQ8YOH36c9kEx4I

> In mt7996_stop_phy() the mt7996_phy structure is
> dereferenced before the null sanity check which could
> lead to a null deref.
>
> Fix by moving the dereference operation after the
> sanity check.

* You may occasionally put more than 53 characters into text lines
  of such a change description.

* Would you like to use the term =E2=80=9Cnull pointer dereference=E2=80=
=9D consistently?

* Were any known source code analysis tools involved also for
  this software improvement?


Regards,
Markus

