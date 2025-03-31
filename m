Return-Path: <linux-wireless+bounces-21002-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1616EA764CA
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Mar 2025 13:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69EC83A6B83
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Mar 2025 11:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B131E0E13;
	Mon, 31 Mar 2025 11:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="DuCYBdDh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4301F1DD0F2;
	Mon, 31 Mar 2025 11:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743419613; cv=none; b=mqqAFMOhPCfO6dJbI1lHVD8KcmE2swUpoyz4FsxSxAk1OxYdqHTfS55+qXFp/P27fIKsgBASrBtbXPtSyDzBYoQVpeOwUJWgi2LjhSmjpGOiZ2a/tSELMECrh53aAVHlWrkIHFpmGkKOnoiggZqkJ9s4uQCRP+laz2Peq7pdm/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743419613; c=relaxed/simple;
	bh=iMfWAYRdW5Zi9V6Q1JebZXoBiDtrLzoc62lGRJziAk0=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=l0t5JlGIZXohybo7KVr2w1gfbgz9olWb1rc4f8y26MFPh8lmFYSYT5fTLg6hSSjniLhdp6raUTr51st74BFEADtHEJ7D5HqIX/gtuZ/1GPKibUYGBNyYm7t3OjZ+Rki37CNOaPSJgOEueO7v52FBISDi+kMNvnKcQc5WTPtRxMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=DuCYBdDh; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1743419609; x=1744024409; i=markus.elfring@web.de;
	bh=63qFvfIzijRRXeWjG7Gdgug6Q2YIRJCYz23Ir1lfV7k=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=DuCYBdDhF8Fy4JQuEISj/xxgWJGxhskPvt7avwMknr9RnkdPIVq1ioV167HlIkwP
	 9jk277vaZTgu97yDUC6b2cQPnNu7vv1oCd2LzGq08lS8tusYDGCSZcG36L8k2GGN+
	 uSUUUqiojCVcpL99WiWvwrYWr5ltqW1wfyARA5wOUiGCx8Xv9oRHJcm1wUp++M2y0
	 7VdvBHsujjBwumoQTEfrvRYqU01apYwTZ9NDK98YuO6c7vDeyCaoSKRi+VcvXsHoW
	 9Mh+fBM/E7kMkALgFuN2rfzeKCIcFTKtgOnR6UyPYx/rg5D8tQdEpBTjAccq6LA7W
	 ipVscRTofRR5LHuWvw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.37]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MXoYQ-1tbzEb0Sjc-00JC9a; Mon, 31
 Mar 2025 13:13:29 +0200
Message-ID: <a2ba5805-3e2a-4967-9c78-2702bf55304c@web.de>
Date: Mon, 31 Mar 2025 13:13:26 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Henry Martin <bsdhenrymartin@gmail.com>, linux-wireless@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Angelo Gioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Felix Fietkau <nbd@nbd.name>, Howard Hsu <howard-yh.hsu@mediatek.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Peter Chiu <chui-hao.chiu@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>,
 StanleyYP Wang <StanleyYP.Wang@mediatek.com>
References: <20250331103543.9154-1-bsdhenrymartin@gmail.com>
Subject: Re: [PATCH] wifi: mt76: mt7996: Add NULL check in mt7996_thermal_init
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250331103543.9154-1-bsdhenrymartin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:E43tro449Ol30lrF617necoQPncpjixgFyA64Up7dJH5TVfM12a
 hD/dqOom0bt25Jfaze2XNBarwKvOa1LS/m55Bc5iA/sBhQuCwrh7au622dfxiJia06I2OGZ
 cG/sSUU3rJ1Ez5QzZ36FLlM27NtFxYzhukaLhdZOtgMvC37BSK9drd6Yb0NeywLyBhmSfIQ
 791+ixOhWFt8ZhSqv6t5A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XgyDYicIh3M=;bQjk5pLYYjSB6PgM7fpD2zt5rkv
 j/Fd0srC+6SyjkmrZoyiw8Y+OzYhoxJHWVddoodtmtMmK2R5wkM6MzbLbPjHP07XTb7OVpiGd
 eFhSBuvgcfo6wzo4sYYjYq9BeLGcFHgMu65B309H54/zMdMSRoXIj3/DQQ9qQ5K3V8o4RXb3h
 2wNwWtFgcsxC5wqnW2Gqbck+7gHOtpp6gh/LNfBtnzoyCshTS+RbVB3S3NCw6A4bXGkXQBFWV
 4w5o2BAQqW7PE+K7WkkCBpk8ylEf3nFxAL7TBf6nXFWUkjpX9K6JDgXjAdmWf2wOps86cbVp3
 s8yDi3p87ZSgXD9bX25akKMkhk0tzFuZnhYS3hz9i73W99hw+AJuxIje5VnjVTwzOw2tfJSKP
 qTgesIXsoxHHlAOT7CIUR8yFYSQgjUjtdrrrrtlih739Cc0SYI0YI5/l0afpsGQzOR2fjlVrs
 0v3SJeHMtqvXnxC34SCdDUHfR9WHnVlfrIBSnvl5xIXoop0x5iwLwwalFijB+YNNTI49EXmrL
 /0oiAIjNUDFXY0yvdFrDTVD4x5DEx8HDJ5p7vkP0wE8x2LnChFfMSVnI80aWh0AOeHDnMRwMj
 y+g6KtyVVi9Sa4cZihCC+r7QP+nX912uKPcG8uJyg171lOWEyvaikcOoixUahqaKFbxsQ6XhJ
 zEhOqgiX57GvIHskk8gkCmFC0Y5AXnHHA/82PzF1o93Cc9UR7nMfViWfcIAFZFaa2e/HtucYk
 uaUUPpIZ6eu+WFGUy1BJdvCBggbfxReYuwGs0kGV01aS918t+fUbuIGCy1ocuZ/fOqDrZ+6Xs
 CKvx0qJocSxTnq6WDBogfwtg76u0kQqa7f9FepQBR0sMYhOdAwW40N0HojT7JAK7N5L9ptdFh
 BZj/V3Mzvb5Kr++h8OD479/RJi/p8cdr/ZhhrIHITs2r8XCxcMc96oNjXoF81eYlOk6Vqft3o
 v3To9SmOnP0z2S6k+DOdEUlCOSpZ60Aj7Dk0RhAI4wKoNzurNygP7RPcEuCmiYE9o/I9iH++C
 qTJJ1vCLk4TupbwswCqUhbq5X6MKtD+7sMZRykWqTJ3hNYcRrReR1PJDZac47lcSYnbkhHDgA
 XH+OYIziDKs092Wvp2CdoqZr461kz/Jo1yGtSVIWfe68MNjrBjM3OlHYhf5J6RGxfidhMj86G
 /4Inwo8Q1smp/X7Mnz8Slbipxjn6asyIooHZq+6ezca4R4D1MhqGt7OvJoJYoqBYt399dWF4N
 AH5eYqkJ5fPXay6DBIx2UPVNuHJD9+Qerb2rhvzQzLMJ4qdRctMKSDEimt+lTUcnJAv249Cx4
 WpaKgQN0ouxDKp4vxBGBaOwpX8Pio2O6eb2ux7zwwciPmo8Q0uaVrt+1+lXI3og77Aw6FF7zK
 c+gLrM3HzHHDIr7Mfp6F6UM2EqDBQa9QQr1U4y82rDto/zlXaECUt3npPP7tvuRJw43DPsWtF
 B35sLEqCMaxXjiiLt8p5+VOl7VvxbatTDjfuklmGX/yv2xSou

> When devm_kasprintf() fails, it returns a NULL pointer. However, this re=
turn value is not properly checked in the function mt7996_thermal_init.
>
> A NULL check should be added after the devm_kasprintf() to prevent poten=
tial NULL pointer dereference error.

* Please adhere to word wrapping preferences around 75 characters per text=
 line.

* How do you think about to choose the imperative mood for an improved cha=
nge description?
  https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/t=
ree/Documentation/process/submitting-patches.rst?h=3Dv6.14#n94

Regards,
Markus

