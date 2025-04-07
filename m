Return-Path: <linux-wireless+bounces-21187-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C013AA7D6C3
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Apr 2025 09:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D143188499C
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Apr 2025 07:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5AB1A3142;
	Mon,  7 Apr 2025 07:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="sWopx7xv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F6D2253FF;
	Mon,  7 Apr 2025 07:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744012250; cv=none; b=rMiWxqx8QP9GtwHt4HUkBTTNKvdE5qeSpTEbXTBoLilHAH95kwGLl9JZwa3oezyS3rwgqLG7rxKRkua2VofH6QcSZxoJ/d8Tpks+COUcIaoaFFz0NyD+dj6UoJL3moKPHEiDZ3E+QbYlzC9O+9CtXsuqWoxkMqpRatEZOr4TFHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744012250; c=relaxed/simple;
	bh=qzqYqpX1n+9iBoljfssVQ71YHV7yXI4Hc7MudyfJowk=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=qXPNqW6qbdsJU6NJtoU3nPqYEonPJSO5D+W5ogs3BU5Em/Zvz79iIdYxn6rYLSazr/ouC37Zfa/zwvN+pY5z9bJTuwQp6F0gow5boTcbUVP5jGSnVayncXmixEVfOd8i3ShqSu2YJOI+IGE06wxoXCkLOVptuIzCOOXOKPnGh7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=sWopx7xv; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1744012236; x=1744617036; i=markus.elfring@web.de;
	bh=qzqYqpX1n+9iBoljfssVQ71YHV7yXI4Hc7MudyfJowk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=sWopx7xvOIqDpk/rw3r8Q95+2HHtLbsF1C7cTccGgg996R71sAiDqnthOsSoJOrA
	 6+A1nDQ07zh03mN0PygsY2P0q4205ukJoh+ludqIVU4cipZJx6wSLMg/x2r1t9M/T
	 39YCcGFSOjEnQBA6UdXKHJxdd1pNSOS63kvgEHub9DQfBcLet2hhtJcvZXbV7Rky9
	 g5xBFRSv5PbapbXNW5NNFoGX+Kquua33hdCODj6BlZ6l6WiBt9SD5y9jWqv9bf/G8
	 w/zqb2T/JuX+Gg3QEmCuOh5IYgOyM58axcrDnKYEicAbR/yoWrsyH9BUF7laZx6p2
	 2UvuugT255GYBM7JAw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.4]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N7gXQ-1sx8BC26vS-013ax6; Mon, 07
 Apr 2025 09:50:36 +0200
Message-ID: <b429eb4d-514d-410f-8443-7e3f40709951@web.de>
Date: Mon, 7 Apr 2025 09:50:34 +0200
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
 Peter Chiu <chui-hao.chiu@mediatek.com>, Felix Fietkau <nbd@nbd.name>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Rex Lu <rex.lu@mediatek.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
 Shayne Chen <shayne.chen@mediatek.com>, Shengyu Qu <wiagn233@outlook.com>
References: <20250407032349.83360-1-bsdhenrymartin@gmail.com>
Subject: Re: [PATCH v2] wifi: mt76: mt7996: Fix null-ptr-deref in
 mt7996_mmio_wed_init()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250407032349.83360-1-bsdhenrymartin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UyaaN9+jk/ECW7DFcQreDAuUpqxrW+hgEQpFAN5vL+Xk7uyrKqV
 +EUNAU6Cv+xDaECNkjN1LIEyvYICi2AFBiQ7r8mrRBmYsSeNd2UwCd9XqUkY2JPnRBVUmN2
 h0gmmb0mHyQ87sV39w4LuwIWX4ajZh5cdb/0APWFFd2VQlMvSFkeIPe7VuOiKjZTg1ArzQv
 Yf6BT3zSFj+s8FojjKDGA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rGWYfE/QzDg=;DQE66In2XWKiA1TpSrWROWLIh1P
 Caplna0f2CPkP/kc2OpqsL1kow6F+YtowFp+R9whgFTLaOpBZpHsCr+0/OeHoAztVkmlNtpNF
 1EodH7GJcu4KJsiEP1VkNQspO9Z5/E7yjy5Xwy0mEtHN4gQ+paobRTm25kHiFirSO0Hes4nQj
 DiGL14Kihm1t7DjPi9smIDkvCn3yICFqnBUP4lZ3fOyVqdWT5o2Z1rBwGzw7IlgKnGWVoIim6
 HxAZSJrOvEapTKXeWrhjKLqXVt0AgmgFVVau56CLh3YtGaw+uw9umRrmgQfcWwpVB8EgVf/Ba
 DPwQI/KsLI6lz2BeVuRS1OAaMUNYZnAsColfR2D1dYA+BRvT9TPLXb7ovFJwe5AY/24Eg+RGv
 x7EE7skkdkz2P4QagnJI5pZhmclxNFYHgN+4henoy2txUgjTpuwJItWky3vJlGU0MvAhBWZ/E
 ddnziPFxXPntKyCRI0NpG1wF1xoo139zfa16c+/fuJuZbM6H074XZ59PF0sYtA+Exqtm4lizM
 nAFZ4eiI/9PcdTDZnpi+uvKcJPBwPbYFOB17L5M1M+zUQ7UFaW7XW0lelP09S4jzZp0OjkZM5
 f6ZjrWPZpH8AdBZ6cZADZouqTTUHVfKdaBISTcmX65FktrGIUMRV7zZzmVRBFC/ZFYn9Vb8RW
 mhS4B4irb/UWYrStuei0fpjSaJbMU0Wb51WbQr5W80yNLTDimff4B6GpQfcTUSWAeX531Wyk7
 Fegu8S+iXB8w/PhW2AvQGH8hBMrCAKeMeRyjELdr6BTSJPy34H4XRanpy7pEi5kj/jvh5iQf7
 6OWTV/6wmgTdyn383O9L5PH/49Bz/kj1YnkywIuuKQhsZUndmjioEh8z8ZEdooAtMFq4+rsuP
 y/Ecf4EFz5LfN4ebl7itTooFQJkQJ3McG3QSXPGpLKD0Ga7HaDdD8DUYgPShgRArEa0t9JIA6
 60oGy/8puUokr/j7kikD+tOC9bK/xl0Vo8RNCE73CCwDlzAX5HMu6czFM7YWJpzusOlnaH+q7
 SPHtYAgZSWFGeiQ7cY3Q6ylbyR8QDl1g+UU7e9T5JLbaoIRvRNg71L2DxqfJWKQY8PSqsBRlS
 sh1QP5I4mKbYp8gVaNh/hZK9iGX8rD8ska95FpWMoPdru5/gmy+Z8Zt5e4GdM+Cpeoxma/2CA
 kyW2fKe+/t45jiyxtjtaVBpP+8y3MYuB1fUjZbT2jntQoEhDhts+GeWJ9JPkTlBQZFqHaVvSs
 RasTOa+y+NB4TI+1v61qnNK770x90O0htoHtBKXswg6mYw6ViBdfZFY1BneciPd7o4ZpMTzol
 Nm5xMh2L4q5ls7RI0ogQm6Dx3J7lXN2mOyBdDvQfRUbIn9TNUEWzvlsYKo8Mnjhb+OC7Xa7Yf
 DPtf6J6PQIhx2WZ84tYq3om6RY8C0PmujbcXElsvs9uILVsNx325SEOpQTj7tvfKnUT5LoM0M
 V0kZs7j8DvoweK+IZfGFW5J1+NgrQ2J+w+4wGREwWK4jkr7Z9nIO9ITblGKXphb5+OXO+Qw==

=E2=80=A6
> Prevent null pointer dereference in mt7996_mmio_wed_init()

Would you occasionally like to mark the end of sentences with a dot?


Can any other summary phrase variant become more desirable accordingly?

Regards,
Markus

