Return-Path: <linux-wireless+bounces-20974-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D82E4A759F9
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Mar 2025 14:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 865451681D4
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Mar 2025 12:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E919C1BE251;
	Sun, 30 Mar 2025 12:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="ITzfebjh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99F413665A;
	Sun, 30 Mar 2025 12:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743336899; cv=none; b=PrOa9VPCc1SLrh0xhtgoAkqsXGuXsMJyOd3esJu+29l8qsaiFwt+3JCBp8n7AHsJuaoPTRZCvyw8uMoocoZnc7l6CJc7rEP3C3jnt/nUtnuVpUZolz2iQGj4i4IS8dQUEsN90m5OZJcQcwYjCTkqNnV2dOu395+5XcbvecwIZdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743336899; c=relaxed/simple;
	bh=HV0oQ5EiU3W+SSX0BncrNd1kulTswQUaor4aYltdSAE=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=U2rYUJX2IKlmqWfOx0ko8PbmVoDVgfU2VRuXKfdshLPv+IEF6lCWsrOuPzA9xR2jBy4MSY7RKuIFa5dWn9sy/dSpB9TJFWUWk0rNViaVg8Ku/6gMOd3ApuOYuPJtSFzJWtaFiElymDzYt8D7vVvgATVHacAMRPooIqYKHDjx6lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=ITzfebjh; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1743336895; x=1743941695; i=markus.elfring@web.de;
	bh=HV0oQ5EiU3W+SSX0BncrNd1kulTswQUaor4aYltdSAE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ITzfebjh4hvt1qJbk2Ig8MVQFD0byQXuKxNXB6rvX1Nus67uLpAgYS5rHDF9kOvz
	 db14fiM1gB+a+EVda/LEPEiVRjvQTp6qxke1/gStz8b2zy03NDi/lB+LVJjI/jcV6
	 RH1jBZGQeR5lwvmAAdELhus/P/TQPGhSMkxIbB9qbJ/v2AZ0okgviAUDY24gt7q0X
	 O6rjgBPrSodeNYgVVA3QhRVh89Kax1QT5xpB46Oi55PKk1VFGqUxGyA1KnuFwnDDy
	 6/ybNdkU13O77nSx3xfp7FN2FnmD2+/Uvn8BMcNNdlyPTBDOE8osxWkZdB9SpKPTr
	 8hPxOg7MznKujra3og==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.13]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M9IOj-1u4cJs0HO3-0065M2; Sun, 30
 Mar 2025 14:14:55 +0200
Message-ID: <eb9d1bb1-349c-43c7-b8d5-5de6bd84e9ad@web.de>
Date: Sun, 30 Mar 2025 14:14:54 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Abdun Nihaal <abdun.nihaal@gmail.com>, linux-wireless@vger.kernel.org,
 Kalle Valo <kvalo@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "John W. Linville" <linville@tuxdriver.com>
References: <20250330104532.44935-1-abdun.nihaal@gmail.com>
Subject: Re: [PATCH v2] wifi: wl1251: fix memory leak in wl1251_tx_work
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250330104532.44935-1-abdun.nihaal@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:AxU/d51iqiynyz3Z05V3/yBzjziBmIzrBalYPhEtUJLkKFATxXX
 0l3ITh3GO2vnEJ/1JFRyG2NWrk7Uju6GuhSCB9pgKqvd+c2mtWew2XtDjTHHMJEweAYWmYS
 enmOsUpUDcDp74wvkLndll+ywngRjLIVhN7Ll7QPxL+yppUZYJ3ZMcaFft8ajRz7BZKOvXE
 bcxWW9dPdNheaONQUQmWQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:g1kxIRJVlcE=;WtGBbSlpjLeVlxgsovze4yhUkWe
 OwBBxgGP0Pq+V2zkJAcLHOvaBCTNwCljlRWc8WAqMFDTr3gE86gOEA71C/eLbr8nCadw+0KCh
 VeyZbk7MgkjGTyF/eh6g/UBEodxdD0+Ny2SZgFTgClINqyRHFxHfB2/OYVZ8E5VohAnDI8TQy
 3gdvgvUq/THWDpjvuyZUJ0g5aElqdhX5wVTYVA28RWiUMgA3I2CPbP7ePSMCtERWRD1Bxi+As
 jvlS5mAOV9BIbpeiChANlE/LhdwCS2Iswg5zYKhHbFfnFJ0wpKWvTLT9y8MDx6atIX022N0K8
 qQALX9BK6q0/gS90L3up6cKFwAHw7FXHTVH+CzZik06hS0yPeSUBDNtVFrrU/tVJBzD5aFUof
 RbAVkjWNLbY2gR0916fHiLBddbnWgAtt2prNwQtnmMnjWWt9CB6V9XOk9RN5rj+SDX4ct9Xh2
 VOaTfc2FCaFbwhSRCPGDmo1m/OSmthhI9cMCUPkdKMgyrramRv22X2wuu3UiKvu9PPR+vqnxV
 D9NIwYtnkztqwxcHmqs0cnPFxtlfBMAFDtnEKk874xBOqM5hBFlTOQ0RfSbXVdH0x9mB6iUwu
 MtYseYXSP+B4FTe6qkLKDz9J87mvj4rchfOktgYPbwBqrpE/EhdyL3aPbtXAZHkQ0zF+zsKAP
 ii0pn5s/lH63VjcOzUqBJEdgKKNis00v0g9bOjOSyug9MiYOj9xSUqdetcQHzKLUm1RUjdfJT
 1yzvGvPWkAljsW7MGhugJHKnAtKLT0v21MVAeo20ZRbSSFcqy7HmU7mo/WrqG69pkg6wxZFEr
 KLnt9TmXKg+5IJ8BtjzK6DjtIDxkOy7rmsiAfUkWp+iFT8btX8BnQL1k50yvpHfMywqOc3U5B
 Cw+iWUIRKGXwZajmEGvMg8UeYhHZnXjHw74l9ymsx4KSzBbhYBjZRg/e9t/xGwJyfPP95fl34
 i5LY1Qchx5C6lkFSmWE1Meabiav9Y3tObXuiHTESSt04JzOSrnwOFansZXkDxFkAmClOpkQ4m
 vem6+RiL336XvmPhcE9N9Sxt0Bv9Nu2XUTb9rWiU3smq56Xe7qKrIuwaHIGGNUEShkL4cL5Pr
 5kyEt1zoapZm85v5Q+nWf3mYDh4gE7x3OV/CRgc++AsISrjrJDABuZMtkvD50HRxMk2PkBcq3
 mh555dyUjTIiLWUtwynojZ/YLylfo+NJI3TqwO946H7MmEfUiB83h7GodkvsqUcaIfwQD7h+l
 O1/dyMk+XP/PkTDOaW71rzKcQYgmdnrIvJw2a2oMfzTp3nUSM3IN+v9U3e1NNiLDuZbNe16f3
 f+ExbMYdsSZrSBF0TwWI5W366BOFJnxQA4iukuX/z+rvrOcPM0P8exOMMHe/xWUxiLkhEJsd8
 M7a57jHZLMmBTl6aJnZroz0WPCTflTKME3C75AEcdtrvJ2k5hfRO0MDfH7Ub6pjqSxfffPhwV
 euNEiryNaDQ6BsAmpnjaaTEfU34juQiaMF29UOO9pK9KHMvnT8t7sE9T71ZvPwUdCqcNAsg==

> The skb dequeued from tx_queue is lost when wl1251_ps_elp_wakeup fails
> with a -ETIMEDOUT error. Fix that by queueing the skb back to tx_queue.

Would you like to append parentheses to any function names?

Regards,
Markus

