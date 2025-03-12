Return-Path: <linux-wireless+bounces-20262-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A651FA5E528
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 21:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78B111896BFE
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 20:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BA81EDA32;
	Wed, 12 Mar 2025 20:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="fokXjfwP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2D0FBF6;
	Wed, 12 Mar 2025 20:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741810614; cv=none; b=kDbzfUe48FoLC5mGWeuP2Ut2OsxhRoBh6WPA8fkOoKppHP6jO29J09exENkfKXXYol54kmKFnw60HqU+NcbTtnIIoP9ji3W7bQPoJ5MD9UoCZ4reVsjKeh5RneZmLaRbYJbEZVgUEIp/N/z7GwkkE2VYd5sxH072hye/HVF3ZqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741810614; c=relaxed/simple;
	bh=Akp4FrSGg1WIV98VBqwZ/4Q7by/C7cNcynpUz9Rjxbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=irDS0qfgwSt6lmav9K7izraUW6qPrF2tBLrKemDhUEEvLqvcCUYXX6pDmzi7k23APicRTUnBe3Sj4c+1mttxgSZXm4+Xy7lFENDZ+snQMyUP3Vckkv6KeZdLmnbTXWBydKLboM4P3vcFjPDGty4o2v2j1hMnSFd2OXXRDHp5Suc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=fokXjfwP; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741810606; x=1742415406; i=markus.elfring@web.de;
	bh=Akp4FrSGg1WIV98VBqwZ/4Q7by/C7cNcynpUz9Rjxbo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=fokXjfwPgqkxy/HL9t5yE0vj2GZ7rq1+1fHRK/fDjBn03e6W4qjCpgZH9cJ9m9K+
	 0Ix9zJfrpKlEiV55yCzK8JP+mL/k9/OcdOzZ5lSopM4c0snj2FI2I0nz+g2nD6MgN
	 cJB/kSTp7Bg7VVabcqrpNktLRZ9X2zNkb+gRkSVmrazrZ21G8b4hjVbZfYFNtmQfd
	 BLSoJzfu+YRcgtc6ww31R+ExCThF99eZKWlxNxFZanyQCcxz2zgS5Kq0lKH4PFG/k
	 IJW57k5NjeUzbVfVNbHmXeAsKha2goHY7fyz1iP/17WXl35CahcIq55pH0zIkpNbA
	 cpZ0IA+tW8/GJXOFQw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.19]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1My6lX-1t0dlZ2Hi3-00wida; Wed, 12
 Mar 2025 21:16:46 +0100
Message-ID: <7ea83bd5-b19b-4bd8-ac2a-8fb2ad616f8b@web.de>
Date: Wed, 12 Mar 2025 21:16:42 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: wifi: iwlwifi: Fix uninitialized variable with __free()
To: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, linux-wireless@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
 Avraham Stern <avraham.stern@intel.com>,
 Daniel Gabay <daniel.gabay@intel.com>,
 Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
 Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
 Johannes Berg <johannes.berg@intel.com>,
 Yedidya Benshimol <yedidya.ben.shimol@intel.com>
References: <f7c17a7f-f173-43bf-bc39-316b8adde349@stanley.mountain>
 <1b32cd5b-aa46-4a23-bd21-908196c4bab3@web.de>
 <MW5PR11MB5810329D2D44A188239D3093A3D02@MW5PR11MB5810.namprd11.prod.outlook.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <MW5PR11MB5810329D2D44A188239D3093A3D02@MW5PR11MB5810.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Zg3T6KfdUN0TrgR8KKHJquhbB2IqpLXk7grLPw/Lllh3EVJCrX+
 Lo1FfqOS9qnhAwtIgKTgShPyAptLPzxPRZf58ZIorxYbzJ6fci9EvlRAw8bYWPEZ+pdSaVD
 iPy2k1tWIDJ/cRjHzrTJb9ITbltpOnh16rbaIuJhlW628hOq9T2c2OCevYyNwJJC3mZjmzS
 XF6+NvGfF83+RXCq8tg2Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NjZ6SfH1+LQ=;/K1/xCQTLSn0sdXG0wculEthvjB
 kgK+UUvwFV/ALemTZMQlDhLzpfXr7Bg05Bi3Wr//h621Ptt1W/2VJYY2KnOW5Z/kV554I+9p5
 Uykg9AiYCl+8+ilSP2FZdD6nWh9eeb2AD67Jghdoe+Qe3RZbVbVhwP2B+RlRxT/dwmAR/vB8T
 gCpwwx+8aIZLAf0zBqHXfQBpuqcvUASbj9nNItnUzwgEWrtkmP9mIVLiU3lCwwSbrC5vT1MfS
 2Q+pUxPJdiNGsCxUOn6goqTxN+MgYZ0cSEPsHcMYroPsLOQ0dnE1pBqW2aAmddH44R+YZqsDe
 Z5SSqZyZxwhKI2WMG0iUmtS54l2EMDO6GWtj4l5RZ4opBT4+8CgIlzT9Hwqh482WQYp0/EY23
 TtnKsiKBd5cewRvu1xr4RXVuqGSqnNRUfZ98yqKSpa8AJnmd4A5pel41z4lyg7Te6jk5zNsRf
 JHhOtqOqe8FBdgWtuyT3Pjb+8dETWuZEF0OEOpIZ7y1e+kykdQIYTmUGopod9m9qu/v5yWMLz
 kKFqqy5fwd1O3dpPx6UzHLK567N+wtXcv+taqvRP12gzbiLJf2hiuNjy8TpSDHFAT2bfZ8T99
 OjLklJHYi2cU8P8TkZDb507/ByuCFU6tsFLCyaHt0WUX5WjR4mbqVPta1UDmxy+I0Ea0nh+y9
 CKErf6HPqdpHdtwDAudQxUIbg8bzPpVFW9vbsOpTFimg+cS6ktCFFmMjoQTOLEeVEFHOc3+P5
 K3UDhiteevt2NS/9rxx9IOJyxxleovzW3iaUO78IR0Zt3npq0UpEmveuLj/DnQfRAxLqNrfla
 KN6uxhOF/l61SJZqqfvroY/v8u9ubd+jHGRfMg6Q7ySVBz/DOxGH8ZlxDSaCf0tXJtGuO/ktd
 WMn8S5wP91wWWEy7Yrl+MrsZKTKUHvJGHG820u7020gKauY8Gf0dFP53nkXaIny6KWBDt8tsb
 XJsCrC90Q4uCzqiVE1g7tY+bPPRYMbxsMBGLIBxhUXZP5B6VQt/nPAo7PDpa8s4GGv1PD5Sqp
 /ViZlTYT7BC42C261b+yxWs4h6roSruols+tLLsBWuGf8r/QrAZnTufIFwQTn+M/0vR0chH/O
 ahIafdVvBcOmYNPl6CCeD5rp8oRYf4j58nVTJUVkpI9iKuHTeQroxjNS9e8pXktTL6kCP1MVo
 vOotYQpYxCzs/JRaYpHJHUwvV9yuAbXFu3Ub4mphoeqLUzrq+NC0loC2hxCv4jlbU/4V55xNr
 DUYbG7qbruHIgwQfnPBXyHWXZO41SQHshrLlkYZIzmhjBViADgZASY/L1fYp+pa+0eRGkLq/D
 dQhus3JSS4OiuHkLMXlAixpUYRhkIvL2WiFmmFrl1OuJZrEAUr0yyo3rY9cZ/B6KU8UAJ+brB
 AzHcB52yIaHW3wu3NTqRs9O8eqAo2QWYE2j/v1V7+oEzOLOeTktQMszjcanUqEJNY7Ej/5TAO
 kbc+hNELVpSp3+nB8G8PaJ85R+I+mTCRRokprOFrJ+j1TkIB2

>> Can it be recommended to reduce the scope for the affected local variab=
le instead?
>> https://elixir.bootlin.com/linux/v6.14-rc6/source/include/linux/cleanup=
.h#L129-L133
>
> As said in reply to Jeff's review -
> This is recommended if you have multiple __kfree variables (and the orde=
r of freeing matters)
> Or if there is a guard() later in the function.
How does such a view fit to the documentation of this programming interfac=
e?

Regards,
Markus

