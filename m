Return-Path: <linux-wireless+bounces-20969-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54BFDA759B2
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Mar 2025 13:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDF61168519
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Mar 2025 11:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED00175D50;
	Sun, 30 Mar 2025 11:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="i+au7s5f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8AB155A25;
	Sun, 30 Mar 2025 11:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743332702; cv=none; b=IJSJ7sJfTyND7Dbo0isS+wYukyfFM6d06btbrseE9WhVuxXA8R5A5vMQCFN0uwGwOiEMipHht1SMHkNQJjxZaJkR0zsWLfPRy/pnepmb+PcBaOv7R3ToXMtDRPvqCl9C6MK72xJ65Ly6hkjyT19NtJov29WYHfASqBZ5yE+vIyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743332702; c=relaxed/simple;
	bh=pfNNxAdTq6eb1LHw7nhPWiLqqGrsqhtTtoSGYECEcEg=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=D0ywTIlc0v2+4J3CYkxH4jXHBksYbimuFVHAVImEhdmF+wMorJJaYcFcP7HfStbIEmxOrFUFQJQMxx3TtA39lxzPopybWT1nctECp7rx6lY285JpU+D0iOzJZWnK7La/mlRvIMm9ZF04Sjl2pzl1Y/PaIPPQ1z1I9C7a7F2VMgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=i+au7s5f; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1743332660; x=1743937460; i=markus.elfring@web.de;
	bh=7XNR047n0tXM8NmFwSJtrXlOT11ohyoE+m+0m0SvfAQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=i+au7s5fEodaGPXUL0fhpGDPzMV4f56PQ5wU3WXtw/p+vagplHY9Em3B8szdU5ka
	 BiDaVCj3c9/ywSK9/KoSgCipbL8hwFj8+Pu3vaugwCZJ5q9UmrzoPHo+ZbjzBddrz
	 I2apm6XMSJINtioCwVwpQP+LKbEHiENGABZek3BXnS4lgGF68JbRFzAbqDK+Vt7wt
	 cOX1lc/qyNk1OT+2l3bWaUES1692Kp4sp/ozQLEv/b34Z+TFrBTh3UOyuvyHe6mJc
	 IfK5KKD1sRRliqFL6F3yFCjzsavWcMf4sck9ktWtxCkX5kNuVVgJWeQzsBriEu4pt
	 CGVVxt4AQBU7A6/A5Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.13]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MtPrY-1t7iDC0hwM-0163PR; Sun, 30
 Mar 2025 13:04:20 +0200
Message-ID: <aaa4ce64-db4a-49b7-8725-4514c0a52e0b@web.de>
Date: Sun, 30 Mar 2025 13:04:17 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Abdun Nihaal <abdun.nihaal@gmail.com>, linux-wireless@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Kalle Valo <kalle.valo@nokia.com>,
 Kalle Valo <kvalo@kernel.org>, "John W. Linville" <linville@tuxdriver.com>,
 Luciano Coelho <luciano.coelho@nokia.com>,
 Luciano Coelho <luciano.coelho@intel.com>,
 Vidhya Govindan <vidhya.govindan@nokia.com>,
 Vidhya Govindan <vidhya.govindan@vvdntech.in>
References: <20250330093556.22417-1-abdun.nihaal@gmail.com>
Subject: Re: [PATCH] Fix memory leak in wl1251_tx_work
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250330093556.22417-1-abdun.nihaal@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:7aUbUz4Z3/RYjliKc8o9zNcxEEvOW9Bvrm25RrlUTmRWjgzs7cy
 9Ye2b7t1K83gbNEgxQjzRTcMmNoaEI5nerVlRSrnsaEnrAdr24S0w5sUlwFjIKPQcZzOeBa
 ugJoS/96YfCnMT/yfTh6D8pl9HY5j92ApY1RKTvTl9DU6GTlhzg7dXV+5FQ6v8M0DcSuJzP
 bpJzFZQYwzqyOX0ZCcQ2Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OqojHTPAX3Q=;oJDEECPFHEGzg0csiHSvDiVMMtW
 7X656/GoucVcmkCQxDSCYokEMr8BE1gsX/t925iSNIQiZRXJbKQLWnSEsE0twsXVVnWHHvppg
 ca2eeA/78cvMpwRl7MM1d/KFe3e+R8Bk8tqT1mTU0nzXeBK0kScbkb+jM557/Jth8AL0n1KXq
 LREDR5mUKpHAqILlfYH8B56heUKDk1tPeMa2ORdE9UdHKMSQvj7DLGe97h0FfrWGMwkRGbBme
 2rr5FPrdNReJ80fRok9guzYIwAoAaQqFjUmVU5udauVMr38LNzGbLAWCSBAzwDtVvVQ0LtURz
 QF57P8douMLkMp9ZW0xMVHPGPwQeJ9T3clGbEz9sRvIMogrkkJFV+T3mynjJ0c4URBkp6ifpj
 c5jRW8+552TwEuzlRtOam0adc4mCFbniKfUhIeJmxs5T4ElVZZplbvSa9kzrg6m+HtqLOGqz9
 BWbyLZjXzasTttdnFfdb6FlgXVvrpfYQK18bX3Mpfe56puOov2cmvyWSY54UHvWoD+Q44Ax/N
 5yP2dHPr29ReAfOKdnb0i3CjXSGq+/LV1qlYnybjJQaMqdp7sN+GZufeXRBG+ACBCO2lTer2q
 wj4gZBVIpmpdK0krjZDT0djnRpJoNEYBghE/rlk/qQUO8n9RoIEzMHpBxGdgrWuEtSxgrDlPq
 9IIEH69UL73eQMJqnNsdFdpFIRVsXxEdwR8v0RT7gLhCOd7L+FLvxMEBaQWGlSesbm6Cg4hnN
 HCiNwVZ2B8Hu8ZGJgv9TZvr7gQYfi4NmYz43i10FqabzUTstdyeta8FMi0oWtOmYbipSVIe3q
 M0GBHZg7rlc6hlDkzek5YCy5pbS6wCcYblHKTFYfH6FNujL8iBF6NOIjIW2PgMglH3C2W9CZV
 JKb41d8XrWVKuTLMQqGrzD1FiRKa0DfZzitaBlfHsPZu2fnZ57SLl6iE3MrOn6E83ARkU50r2
 vu1f9UHwfJnSvfmiS21dxe5BdHcrneY/m99ADizeFLa1r096hZYCMsLoOYi70tLIcXqF349nj
 E4WjeeTG7OAt0ddjg1jWZckSWKq3nMd2uq2jfgGcGAZXlFi9rF4hgzYXY+0koofwoGFS4cxyo
 3B7mquRqYx35p2m0AZ8A8TxwQ9kSPYSPwh2mDpD+blWhd4EyJ8VQq3jDusuk9itU16xNv7ud8
 smKXVBfEhHxqgoGsUcISGgAo65FG2wJJ/N3oqaT2Oh1WC+G1tpOc2KCojKbFQYmoZg7anyUMs
 miqfjVT4Dyk76yuRBKkHWqoKQt5IJoqAWmdwUVELb/7yStzpg2UVKThqF7ssfSIYeVOpa3/NC
 WmuXIzTClRCSfaGtTOqyCIhogDsYZed+VWFpI7sPvvVd5NGDIjUQ7LKWMQC28li+yqhGnwSL2
 nDKbCriJOjiwK+4z3gefJq6gTI1ZgfyLZ+pX7Q08RLRPBdGn9jGlxzlPzBZc1Joiabam6Owxx
 9z3KmjJCOTkbOhqrRlj2dM6dS4VePXQ+G9NuuQiJtQNLjjKH0

> The skb dequeued from tx_queue is lost when wl1251_ps_elp_wakeup fails
> with a -ETIMEDOUT error. Fix that by queueing the skb back to tx_queue.

* Please reconsider the distribution of email addresses over recipient lists
  once more.

* A corresponding subsystem specification can usually be helpful here.
  https://web.git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/drivers/net/wireless/ti/wl1251/tx.c?h=next-20250328

* Would you like to append parentheses to any function names?


Regards,
Markus

