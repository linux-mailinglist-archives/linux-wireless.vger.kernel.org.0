Return-Path: <linux-wireless+bounces-20695-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF13A6C9F0
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Mar 2025 12:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D832D3BDE61
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Mar 2025 11:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9CD1FAC30;
	Sat, 22 Mar 2025 11:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="nd3PdTXR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D47206F3D;
	Sat, 22 Mar 2025 11:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742643907; cv=none; b=scPx5ZBedwv9k2IUc5XpuzvQbMktk+9PBxIEncV/4WvfNIUlXUGPyzxOPuOcDeY0vMlFnBZnyJtJ3HZH7r6ylI7D+N4iezpgtan0rIlWSONIiu0iCam+Ey98zj+Y8UxROm6O/onADcPn8angHtcI0CNJAZy+ZcrsvLbTC0VthJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742643907; c=relaxed/simple;
	bh=ruEfVNgbZDAkGFT/2iFxMdCJ133X4F96nJbULz0TS6s=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=df1UwsbIzj12Yk4tHkLBjUgVXz+wbhN5RQJe46CABUKwhDMAMPU53Em460rYDXuASkFytksOr1BZye3fXMjx9+Ob2NG4WxIK2t3czQ6lnSu5RLkcDPyz9Ghr+EEJOWA5VZifrKHCmX9U1MQvjnC1ivAJME/oQczCL1dvjd0XmMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=nd3PdTXR; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1742643893; x=1743248693; i=markus.elfring@web.de;
	bh=mFfnpU97awFes9jgUdDKwNpgjmWlBXvjCr68+Ux49Bs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=nd3PdTXR2NHOG4NLMEtbvWuTS6pf4HfFYMaXTVZHgmhomrR3xJlntI2yzZLAgspe
	 7rl03NZQH7x/eN7YxpOQYV6YKtbVXw+LmLaRb1wF1tQIkQxAOCkt+5kxZxITxLuRP
	 ytTIWG1VJ42nVQHucEmDC9Pmc+VADHmqIHwfXRW/Fq1pi3AXuaLrGWA+5mJTPtzaF
	 /G7iyv6Aajm/FrYFtQNsjbbVlAlZLLhwWig+n3XQSLHZeRJxlqEikf20LEYyHhb7R
	 LQcAbDVMOQ8Iz8cuP/jhsc0rm0gjD0Quoa0Y9yM/cEBNF6ZlI3xtn1RDQY0fACa+q
	 V7dRmWgfRbsCYHwugQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.73]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MyNwk-1sxQ6b2pjw-00zyyA; Sat, 22
 Mar 2025 12:44:53 +0100
Message-ID: <3bef0804-83ca-44e1-87da-db5b777d68cb@web.de>
Date: Sat, 22 Mar 2025 12:44:51 +0100
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
References: <20250320201914.48159-1-qasdev00@gmail.com>
Subject: Re: [PATCH] wifi: mt76: mt7996: prevent uninit return in
 mt7996_mac_sta_add_links
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250320201914.48159-1-qasdev00@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:E32HW/LuQAt+dgxIqxH4J6+FnSTIt/wYp4Z7yidI5yov1if9MIm
 R4aFvdUtaYcFB3aT2mQF4V3IxZgYhhxiRpsVvAKkfRMw1DUb0UaNNaWroo1LwiWkwN7yXER
 Hg2Clkx01/urCsqt+quQn5aFjk8YqnuplRUIOryX7XX2d4LNYm1CFOpIzXjg1nBwxmX+Jsm
 bh7bBd9fp79aMr5sDMB0w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ei96pu+qF4A=;kiDEfaqAiBKtwiRBQgBPgncthLu
 Ym1qAWuaLKjSJzbM2owQxFnQf5EkpRaPg9v93YrdGx4sDJa9rwQasu2Fxm6yd2EFzMTQHco+4
 L/gj1VVspKWJG6lbLiFkHQ3cQv+/pTRuQQXvKXIBYKf4Mbf0vBRGdPcKi9Erx868xBt5r+Y0h
 mej4vYbdk3+ExUu4BXLxpRqo6xHa+6Fr+WtD3E2V9LlU8QWiaMgfKLit0Bv/ADYVz751DCo8Z
 BSU+DNN1u30vS+JY5cC6Diq/81HhrYVy2ORYWh8RSvtE80HvR5NIUL6GtyVLPfRHGdJvZNvHt
 fYKSCVV27WVQtcnhjAmITzuNm9EgR30dwSkW+7prH5nhCli2LFr0YaO7DOgbcvuFI83tw8mye
 oRamgKeGi7Ox/P+ugi/rSdqMWV3+V5Gblw+AQR2j3nG/cwrPIJJGhHuLa/4I4a7kweBFGqX5m
 lHLQOqRwh+sTULuMfr+C/6wuFoFli+yoJcJtc/6GN/CQQcu0WlluLyo6KPNyo/HsAcdKtRpH2
 S6kr0SBHI7YjHv5fNtLEAf12onKpbVU7Upac7msxu8TLGqfo49VPPP5iO/MhAcafN6MyssmP8
 7Vj1/VTnygipmzUalsD4eU3yONPq5YliRTfErIv7UYATA5bZiOOxW+6LIGvP++PCJ5me6IIPS
 FSCMu1TOeQtekJuRb4P40sXwQwJYvgRCsTesCfDJpG34BN/uEUD/B15tHPUbWFLV6TNKWmMl1
 PJhBEmVym/1jQmLKnkij9E7G4CdZezRpHfbTkInpiv7yWEi+/ZAfQqQRvH2g+SXjgUour/c6D
 SID5mGs5wqD4u9QpvnoZbTdOEQM8ujbqokp7iej1UmfMsuAwwQZfcHyaXxoYStH2SAhT+lXoR
 WmBgF9Fr/VNMAxFCSc0y3y31ZPiF9/fEhZyXWSL2xnPLILulefIkisAa9H90Zea1v2WBo3ixo
 rCDu4NI3QsjebZ6UBlGID3LcMm1ghhjjJYJFRaFBsuEXyIBi3R2FQ+NRxCZJW5qEWg6mPNjO1
 RX/6KvIe075nZZBHqsCxDEeMTOxK96iV8DBrrfu8b3QL/vmtzj3NwcnSF8gK3fF+DLXw5nzWo
 JzwSbQ9TDeKR6FHKMtdmmCaDRZ1Du3B2F9gO3wD6FVMNLTkbeaWygdoPM+EnoW6gxkgPZPq9u
 AI0kgXk4hGBqrz8OPxL7D7EGaZUIaagxnjMbjEvGWrKWzMfhOv8YcA7RtTnW9KH8yhEqWyl8G
 RddxPRgJMVfa/YAcg4woQVCbeZIs9vehR7FFncA0J9H204vogTDS1NoOqlMECFCD9/fNMqsVT
 KG4Uc4q0y1sne8/bIkgatZgtK+jlaDdVMFdVgSmIdFCUP6u6Pq6GB/AL/cvhMsn60u3Jx1YjL
 I/wLcOEDJzn822oAsiVGU1gkp0BIW3FDodWdcucWQAb+YI/JwQmVB+wmUYe3KXn7YKpVkvFUO
 boaowATydHoTLzEGiyW1r+DPMp6p5aR60ifYq0Ojn9nrHh0QZxpXS8synnr/8odEEj6zWXw==

> If link_conf_dereference_protected() or mt7996_vif_link()
> or link_sta_dereference_protected() fail the code jumps to

                                      call failed?


> the error_unlink label and returns ret which is uninitialised.

                                     a value from a local variable
                                     which was not initialised properly?


Can the summary phrase be improved also another bit?

Regards,
Markus

