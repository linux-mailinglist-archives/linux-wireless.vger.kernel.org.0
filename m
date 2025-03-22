Return-Path: <linux-wireless+bounces-20692-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FE0A6C9BA
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Mar 2025 11:43:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1116F3B7621
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Mar 2025 10:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD281F55F2;
	Sat, 22 Mar 2025 10:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="pe6nHEN4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E38F20EB;
	Sat, 22 Mar 2025 10:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742640201; cv=none; b=nqQ4fEbwf6JXs+KVEN3mJ6DFaykokLMs2wXcL7JFMBSGok7uh78yIgt3wuVK9DUTtg84WZi8XjWqNqhkXMAok+TtQgCoGUIDDDSTLUOLd8HNDi69A+pnyfxZ4mTZPRpUjDS1GRslZIBe8ik92wmEJhs5hCURVk1xuw/aE6UTVUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742640201; c=relaxed/simple;
	bh=YkMRAD9WlCYn1xOedFDEZ4kBwzZAibmza3SX4Cxq/dQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lAWtvODlvdmcLj9/9Zc4HlNfGDT2AQ3349Zp7CHdN9d/NclH28Ze66RUYXS4krzojYVlPtztdfj+UPoLiMbqoiLsx733LLKPTmvjo42+PaKmQ4HS+VzRYbpfb8pYQKNjH7W+M2GfKohT2xI7zOnvQxKKnHq08hlwft8cgFixooA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=pe6nHEN4; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1742640191; x=1743244991; i=markus.elfring@web.de;
	bh=YkMRAD9WlCYn1xOedFDEZ4kBwzZAibmza3SX4Cxq/dQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=pe6nHEN443O7V290nCMNqYFbUgzsFFTjoyl3Wvqbwnzf4w+p6zpK7BS8UhSmffsL
	 ytu6vkmtKI46ys4CuejZ8O3NfzlnfpkzXq21WjmgnkvTppBZFi/Da182mZOKCP+yD
	 SJo5LedQ2w0i/cE3gqelDZd2z3Fv4qx34jI2pszdZFuXj5/2OgslotItEXzN+DUwm
	 zlTv2mq6Uk12nFst4Sj9/YVT5g2RPJomoDfzDsKlmziZQVJ5zTK6ivkp34kD5k9hz
	 TZg72zAZyTG2ECGn5aova03xZ/QOahFG2QVTpvoAg9YZltklVN7J0361U5pXU2ESx
	 nMC71wFJIWlof2J5eA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.73]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MqqTb-1tRIWF3nrl-00cVNO; Sat, 22
 Mar 2025 11:43:10 +0100
Message-ID: <68543b3c-2004-43e8-999c-a6579b6aeb23@web.de>
Date: Sat, 22 Mar 2025 11:43:09 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: wifi: mt76: mt7996: prevent uninit return in
 mt7996_mac_sta_add_links
To: Johannes Berg <johannes@sipsolutions.net>, Qasim Ijaz
 <qasdev00@gmail.com>, linux-wireless@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Angelo Gioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Bo Jiao <bo.jiao@mediatek.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Peter Chiu <chui-hao.chiu@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>
References: <20250320201914.48159-1-qasdev00@gmail.com>
 <061ebbe3-557b-46d7-acb8-308ae87105dd@web.de>
 <631977c57b2236edfefb8db7a28885ff6888c823.camel@sipsolutions.net>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <631977c57b2236edfefb8db7a28885ff6888c823.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UOKGF5y3H0aWty2Ge0EpsSI/+m+zx9k401Kz+ZPa+Cty5ktLW31
 aihaZWCSZQ8UUJgs2fdMpbXv4M4sIsk5Bxl7nEJPGy2WBVUKBFYy8wi7tWGf1oEjpgsZixk
 /zt7z4uFGe47bHkQS5dpSgKfXmZtmxhcfnfQudPNSGBUUn7ZG5GyaLLRocR95xZtOmtgqLQ
 zBz2rpg5XWYDmenTzovSw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Ds9ibI0GWBM=;KJP8Mkrg79VhvVfIdkUcJpe2zWw
 P4FSt08PPWUj2iQAHDT2ruL4CnVguLWR/EwQmh5ySL8KLQV8wvvPPVc3Pg5XjgT6UfndggAIt
 crBf/FF+ra359BEX3+RFfoAmwLY1bsSWK8LtYzcC4Xo8nSJmfoT8YGG0va8RVeCZXPTfZ1JyE
 fo77rKDX/dwZquTpr5HkJvexItJty5X70gKOOej1U+/DHlFGWoScPyE+TC4xld/8+MsnmX/+C
 fS9MYGnhSt3p2xDG0Q3IavWIFDjOvFVv8IMug8R1gjEzHoovQXGk9iiukvMi4NhPN3zPbE+Rp
 jjSZCA5ECkkD8ZCHKS+0BgfdrrAjCvewf0Ewxw5S074ft/P6hQJweWl+z14Jl1ZpECe95hHNh
 RuU1q67X5ijvKU22JtCBh7Zpu8sbOmqCQiCGJlAk9lkYdjEZKFwUcaTmJJ0C2XvScqn1h6OAA
 czaWdhbakIwsDa90vnrdYhoS5di/DlGlDmb+DLfFn+toh9+XRuiF/ku5Y1HOSudYPso7Mn5Vo
 RHKLkqF5B3cV5IGJZvP/dQdeabUJilc10MCeVWUwIxG92W7Ldbf8YF7QleC1sySfx0Gt/P+BF
 46vrloA2HHBuW/3tv0uYPFHEawnA59KCxdzO3Uhg9nlciIzKRmeC1+a0M6I/8zBvCMKuS7oh2
 U0+f9TuhXbB6EWYZ4dqtoDFiu26hxSHHR2kyYd80zi744upWndXlH6OqBthdIwIZCSXaHD6dF
 XsHbKPrlOrFtNCwRIx7QJuaWp8gF/j/D3gpS5HvdbFQuE6hspgsN8b61VVNgtL7oordRAnBnG
 y0WzoBoywS1+WF67aj9zp30yldJg9IGz1AmE+LS1/4n/xQpIHHcjdsWFrPWsEETZlnJ11j9xX
 v8G2Ix86kmrXvondv5Y9wXIyAj9PfYWcsi8Wys/fM4K69DcKqrEvYaEOdeA857urm7Pzf6V8B
 J1OOe4YBOuAeRU0qVeNOVK/bWGj1I/iWqCO3L1O3ITV4wCU25pnC04nHFmFlHPAqqecKpdDij
 yxhzYnGs548fLEEN6yf94h2DwlgcOIgFZWpEo0V+Ul3U0GCztOCIZIAyVRecOTT72DB5BKpxc
 N0FJtx2mwxxI83c4hPAYNJ2PWCRmcEB0Pgi/HJ/BPlF8oH++LwF+JnF4SsnM8M3fHhWS9neF2
 RGz1jn5avDfjjineWyQKkpHiU8eE9QHFe+EfiQsM0uRH7g9CyN89bsp+U3M7l42H1VH0MwDDO
 YeS+2yh+Fx/GxiU8meTZYKpNXVTkjJMO5VJVuUYzrlw8MMIB8EXAJrSdVcYkJ4g9QD/CjtRlB
 FONI1G0+X+O/lwgsREGWmEesogl5yX1XtrB0I6MKB4J38f62JTBpoqX3pRd+BU20oBd1jmuzq
 Ysv+X7Na/mNoWxfoBBrLJLZZ9n849354WbPMd/JpqdAf/O3Xa1hdYwGlHrq0itSbb6P0a79hX
 QuI+5Trhw9lfwEUS6aej6VmRaj53xRJfUD9pXjzpQQ0fj2DCt

>> I suggest to avoid such repeated error code assignments.
>> Can an additional label be applied instead for this purpose?
>
> Please stop your "suggestions" on this list. None have really been
> helpful.
It seems that you care less then for the avoidance of duplicate source cod=
e
also for affected error/exception handling.

Regards,
Markus

