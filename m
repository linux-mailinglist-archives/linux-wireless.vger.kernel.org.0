Return-Path: <linux-wireless+bounces-20697-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC31A6CA60
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Mar 2025 14:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88CB817DAE0
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Mar 2025 13:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518E31FE443;
	Sat, 22 Mar 2025 13:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="AmAu4Y5s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7671F1E9907;
	Sat, 22 Mar 2025 13:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742650821; cv=none; b=EJSC2bulkyIhOYmBbhcCcWSc7Dy90+3CpKYDdnSk6c9W5ZkRjxaRaesSXs+OpqaBDZI86ojetgAtFxt3TZ2I0nB14eTPeKWv2Iw1V0eFYmdvTVAnwqFqJNvz+ukGW4O1eIt6m54EqZ3BZe97710hknHpe+ieDz/NkeyRhSeQ7N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742650821; c=relaxed/simple;
	bh=xjUf1ryZi1oB5Nn5ayqZmUpZSv1nmZtfvq35vnb/yRU=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Qjh9VnDVph6ImcCt5XadKVW9ylxiOxHqne1a1oKs9xyN6Sh/GGgzS3xRJ4Z5wXqFMVjOBVop6oWMynJLopyzK3j2S7btzg1C31xMfDCYZERaHfzUlGby+CXEyJKAmHZTqjLVSbC99cJhBhhz+8X5bjUXO4FsSFgBkSJdi+GfOYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=AmAu4Y5s; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1742650807; x=1743255607; i=markus.elfring@web.de;
	bh=xjUf1ryZi1oB5Nn5ayqZmUpZSv1nmZtfvq35vnb/yRU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=AmAu4Y5siP8bgaxCR/tjJpZDXc4vBtRdtx2dN0LBAxfsBeIOXhj7N1F+R7BdAmA0
	 8Os3zQURBeGuVmRhotQf81yEbRVonsvgzZmfgjiIasFbjPXaxDwkBx5/khVSmG+MI
	 x6GXMu3Qfrczs+zLtMCQavjR1FlCGaJkQsdJgsUXNlHvH6v6g8HJ1W5zBvdF46ywo
	 4ZvXCLOTgPJEHZPgmtByHHiMq+MLz6/MwfwSFCBzWZgvCIoCtrwt0Pj1G8ukqAB5L
	 8wJ2vDaEQ112v+mRKIaqpt+ZqURlHAfFWGqty+1HnC18PQzUMqzK/kPOdhyogucJK
	 BaPYzqjYLA6PXNyOJA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.73]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MwR4R-1t4Hvm3Edp-016Jbe; Sat, 22
 Mar 2025 14:40:07 +0100
Message-ID: <52071c76-dd06-4b11-bb79-a5e0c28b94ca@web.de>
Date: Sat, 22 Mar 2025 14:40:05 +0100
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
References: <20250322105052.19136-1-qasdev00@gmail.com>
Subject: Re: [PATCH] wifi: mt76: mt7996: avoid NULL pointer dereference in
 mt7996_set_monitor()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250322105052.19136-1-qasdev00@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hzCFADGYDQPr010FsI8NS36pmqMY5yW3QkMd+OSetiqm5SCom4J
 7AjbzuRM69zCOx9flAZw0f6Q2kfc9mfXIfyPHQ9dZKyMtyex+p5/HYFXnkSPf5+n2iE2rra
 egN+bJ+bR6yR5s0wg5v/3Lrdi8+A3Yh5+XbtrgbGVlQ49JLjVsnHnME90Mp40SdN2C/3SDa
 /B5nCfICHGfKstaODc0yg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:n8ATnK4I5Oo=;Kxt+BdHKzWc+Hw88z3c4SFWzJd3
 8Z98fF/4yja44CleXzzt0MBLe5L9ZsvAgg7WznESaEm82dFuC6mLRf8n4h9wXk6XmzzEcgZEl
 dgPnTsgn1eIGnk0MIZqfP2IEYs8BklNiVxIy/zRyu4JsGkjujf1V6z0vQkOf4EoaHI36M7ahV
 7zjIaf0Rcg6QS508Zk06o8xnga6OstVcrrN89cY3f4uddAomk8yWo/1OJyq1Kxcvaea2GxPCO
 aGzBeTfnqQXETpVj2iGkiS6vA37soRG8zSZhjVRU62n7r0RfgLSd1zc/KUHNNtrNG3B31fZOv
 NzKFO/3AunErQo8qD2Ll+URYFwuuwdMZFr2LLgGswAFNKPoKOxEyrKp4nmCnGH3BpMayZRq8j
 Yj+8fBQmlXWW90yBun8M0XkKCAcXobjfhPl6X2d+87yS+XAH2RwFsPnzCtRPHtVqZPW3eKpkT
 DaCYyxQ5LLUAD2yS6jeki97TaWPG68Su/R45hNUJx/6DH6yqv1GnwChBc9EGlyYqSdzf0J6zq
 jjRstdAUhY6QIQ0iOmOBCGI3rn2mYawx7i6NhUhqZJC3KBxoHgKL0vcaqqAhKQoUm3r+hdkrt
 lTJKLuITpLaDKQWsOxKAN9nbhh6P5cav1Kaap4JGbCfr9uuej0hZ6y3PP8WGRA380Y0kyKhZ1
 4u6d1ZPnXYasfvwCPPiInGZ4bdxbTP1vzA/iy4sO2of44wQ8zk1NC4A3aoai2RT8OfKl8YCoR
 hqVxPQQ6Koij0nmTklNdgP4nayDjuff2xpQ7B8oTWEV7ghRJoL9904KiXMUuiDARg+/nN0H67
 s3ZrJktIQXThuUSjTflH9ClguGqlI23CwNj9LsqC55CLULowbDqplaoNCEy6nnMYcFicpVjWJ
 fDFivJno7jO9NsepDyaMuyF6s/nyeL1IQCjqNubMdXMjaSC7aQIaFtSiz4/+vJLx/smoQ3Dxv
 MRRPAHCR8URV1D31iBHtedxjIH24y4jkpFvM9j+vPWPD3hnxx2WLVIeDGXtQXlQ2OhoutP+Jt
 G7RImvr3kDPhXGnh7CODBOasOlatCUFf1gt06w76enNXhEiJj66mkoN8KSN3wZHizwEz64yry
 88SbxFStB1HKHlIZlVbTXflfaiyakSRp8b9WJqQR2b1+IXDFxdhkoGCAomFlp3XP0zlJPd8zX
 L9E1ebeYHUoaRnKdmdJ/GDu9ND+qDLmbliMTBrYOM3gwUJk9h+BzoJep+NxvQUSJNJkdUMVxS
 ZJFCZvYanSbpNMb1wgbGlF0t/s96eS8badeQ5voeJ6k+8Pl0kfI6SboiTs4McugH2O5GtRJ3I
 HJHG987uao+qmMjXMXBGwnJhAtdGp2lnvQV9Hvnnz09/I4cCF5GmFQewrPfao9qMVzs5rPref
 WLdRAD7fpSBZ5gV4zpl6IGdYYdxa8HZlhHGr6TCYVuFSOQLWGL0NsnUjpr1S8VDsu/cQX9LAU
 kLUo7SBH/5eJtXfCYpm94TK4/X/K23ySAeiq52M08xVuSrQq3

> The function mt7996_set_monitor() dereferences phy before
> the NULL sanity check.
>
> Fix this to avoid NULL pointer dereference by moving the
> dereference after the check.

Were any known source code analysis tools involved for this software impro=
vement?

Regards,
Markus

