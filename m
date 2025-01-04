Return-Path: <linux-wireless+bounces-17067-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4185BA01428
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Jan 2025 12:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D2AC1619B8
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Jan 2025 11:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05E615ECDF;
	Sat,  4 Jan 2025 11:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b="oci9orCs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9545315624B
	for <linux-wireless@vger.kernel.org>; Sat,  4 Jan 2025 11:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735990817; cv=none; b=hceQCAshBS9oFdwhUWo7nkQc7Cw83Av/W3+6zH40CkwhcWLYubQ1KzB8n+cvsY/0BTSZ4NDGbwlVUZS7Ryx6J+grMSciNz4FhZKROhWg+uFKoqOCACSV6MVW8EcLzwq34ZR3CeMXEXCjl/VOw27ApxV42RIOqllTQ+7U+u+ipks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735990817; c=relaxed/simple;
	bh=VDlHpJUBYm/Cn1DqitWnvyxp3OqAUEcQPE9MLAx/3ok=;
	h=MIME-Version:Message-ID:From:To:Cc:Subject:Content-Type:
	 In-Reply-To:References:Date; b=eZRXmFoHF3mlU/prd7w7UY2Qj991oxrKd6NAapLiIoxpsov72Pz5er5S6JCUlDXxJGcSKro+upLw5hC6mdtQ6ALb4pSvPO9GGe58zxPsoeUr9tGicf5DLu8Cvk6DiSWw+ZC+LuXwOwbt0fM5kdJMH8U/EncpWMNg03RsZoldUNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de; spf=pass smtp.mailfrom=public-files.de; dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b=oci9orCs; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
	s=s31663417; t=1735990797; x=1736595597; i=frank-w@public-files.de;
	bh=icByOsF7hNZZ337PJRmMU4jt4Kwhpb3YWVmnD8BK//Q=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
	 Content-Type:In-Reply-To:References:Date:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=oci9orCsBP997NsO6Webcy/QtxqLtCu3n+Ffp6T6UlCi73AGINFMwr662IQDRHoC
	 KLIdlbs59GgfiWBYJ8/N6+6gW7NF1Wx2sABrWNaPllIOaRWpwv/syMc2j28DhohG2
	 NPzxNjFna/sujqgZ3VBX1y4mn7jZaibSH45BACuuJRDI9YqO2HdFg8zOwhj4sUjia
	 to5058xv3GAveKMh+pjFQ8huMzsimYGuZ3GXnuFzZAIJqVrGf+cp7c26NfjgFRrzk
	 M2GBeSuGdPV0GUT3Sr81Vu7cMeE8iG7zV08AhgwLoHNyZ210KgyfWvJ6/EJZDiK3U
	 o1JG8ZtGnb1NCLLKkw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [194.15.87.187] ([194.15.87.187]) by
 trinity-msg-rest-gmx-gmx-live-bbc95d94c-9m2wx (via HTTP); Sat, 4 Jan 2025
 11:39:57 +0000
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-0eec3a68-fc9a-4ec6-8c95-1cd58f3bcff8-1735990797237@trinity-msg-rest-gmx-gmx-live-bbc95d94c-9m2wx>
From: Frank Wunderlich <frank-w@public-files.de>
To: frank-w@public-files.de, shayne.chen@mediatek.com
Cc: linux-wireless@vger.kernel.org, nbd@nbd.name, lorenzo@kernel.org,
 ryder.lee@mediatek.com, evelyn.tsai@mediatek.com,
 linux-mediatek@lists.infradead.org, shayne.chen@mediatek.com
Subject: Aw: Aw: [PATCH wireless] wifi: mt76: mt7996: fix invalid interface
 combinations
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <trinity-67c63297-52b5-4d2c-bcdd-1e86936c4b26-1728494589152@3c-app-gmx-bap26>
Importance: normal
References: <20241007135133.5336-1-shayne.chen@mediatek.com>
 <trinity-67c63297-52b5-4d2c-bcdd-1e86936c4b26-1728494589152@3c-app-gmx-bap26>
Date: Sat, 4 Jan 2025 11:39:57 +0000
Sensitivity: Normal
X-Priority: 3
X-UI-CLIENT-META-MAIL-DROP: W10=
X-Provags-ID: V03:K1:6g1zFbGGvW8NaDhbU4zUxc/9aXAyRBjiFU7KoxiifwqVPEXDsU65UuwpojdCJmmV7pPY9
 c/Y2OzgRPCXRjNLJTq8adLOY4ZyBi9rwZ7n5n4kHIpaP507jrKCmfRMHxeCRyASoGZmf1Yog7oj8
 fVu44HpeJq4gIaTTUwbIxqzlNJTumwJT5Bxu09kSKmhLC8k2Gj9f3gQ+YaF+9C2QnGn/Xk1YC8F2
 JAg7W5dJ6Mpbmg4vOfgv6kiakbvWV9UX7gjltnJAx8IOaPkdY6BGhsaZqUtxMdJ72oQRElOd6pz/
 EbJpVQyfGeuNX10Vj5JQXomdsFQBFvZNUKDVJJRvg6gXIv+c5KLOuGmLP8T/XRml2E=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HM0e+AwcpAo=;V2FPj4vVb906xKpudUMHhsDAmxg
 XKUMfqwDKM37XSgIo0lC+zES26AGSiY6Hd5YJo8m68Cl133F2Vk8IK3MKO5U0mHHsXY++zHl8
 fgy0cG7oBXFp/dxx9N0ZNj1QDenCWaZzmRUMJJP82a2i/0FbXTltXik2LMZmswReH88Sep+/Q
 4WhC0QC7tL0SpP0YfXNmL0gLU0WGIm10/zpiZVPopbaCA9dqqDogahLl25++fOctX2PxqT/ik
 IGrax0NdXXebnllfBs/QVKhGr1xlgmkHLMrIWtfvjrjhv1hE9RKeOPOemHk26J331iNXaxT6m
 bM3sypsS+SxX+KpflA2qQRfsGG+y9Yb7El+iW9tRxysUJgvt7brn5ySG7oUsz76Zjm5quLLPI
 /6YlU1OGtfC4++vOqeC29iK/2euV0q/Wm89LQBCD0ZBnpeZJNsj364zenmM4VmjNLSK4xvuQY
 x1O36I4lCnaCsF1//1O8FG9nhrfh82030+MrA7L/KrI8k+XwiYM4L9TmtJLeRkRT2COhJowUs
 T98uUnihYioM2gviOsU4kZcthzfbozdpxBYYdt/6BWxKsg1FGt7pRTbOIyM/5wOMmXTaj8vKj
 BNVrPwStWoTmsGB1YojyAr7T6n2kZFb3dlYPCKgOZwRXZt38rK0b2DnAB/UJxsvBwnGkyjQdM
 FX8zXuoHlNbhhnBfk3iDuwiT5doP+l+cI5SrNFNpvgTQE0Cc1f5vOHm7+3oQZrvdJnfLy03Gb
 XODB6soyBkWvJjLB7wRnM2GRd1LjrjCQXJTz9xnbKVh+TiGgIaUfDzPoXZFEEFCowXO0Xr7a6
 vh+Gj5UL1XQH9dKwIx0IjUdkOO9dOPVBif8M+7iRBjqFvcXemdYEZNzlrt5Fa8/8tGeC5UYSb
 ye29bWJmUbo0JtMWVmmsueIG9ZpitzW5g0wc=
Content-Transfer-Encoding: quoted-printable

Hi

this seems still not merged to next.

can wireless/mtk Maintainer please pick this up?

> Gesendet: Mittwoch, 9. Oktober 2024 um 19:23
> Betreff: Aw: [PATCH wireless] wifi: mt76: mt7996: fix invalid interface =
combinations
>
> Hi Shayne
>
> > Gesendet: Montag, 07. Oktober 2024 um 15:51 Uhr
> > Von: "Shayne Chen" <shayne.chen@mediatek.com>
> > Betreff: [PATCH wireless] wifi: mt76: mt7996: fix invalid interface co=
mbinations
> >
> > Setting beacon_int_min_gcd and NL80211_IFTYPE_ADHOC in the same interf=
ace
> > combination is invalid, which will trigger the following warning trace
> > and get error returned from wiphy_register().
> >
> > [   10.080325] Call trace:
> > [   10.082761]  wiphy_register+0xc4/0x76c [cfg80211]
> > [   10.087465]  ieee80211_register_hw+0x800/0xac4 [mac80211]
> > [   10.092868]  mt76_register_device+0x16c/0x2c0 [mt76]
> > [   10.097829]  mt7996_register_device+0x740/0x844 [mt7996e]
> >
> > Fix this by removing unused adhoc iftype.
> >
> > Fixes: 948f65249868 ("wifi: mt76: mt7996: advertize beacon_int_min_gcd=
")
> > Reported-by: Frank Wunderlich <frank-w@public-files.de>
> > Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
>
> thx for the patch. I can confirm it fixes the issue/trace.

if tested-by is necessary:

Tested-By: Frank Wunderlich <frank-w@public-files.de>

> regards

