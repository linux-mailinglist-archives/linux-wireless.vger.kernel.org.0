Return-Path: <linux-wireless+bounces-14690-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DDB9B5430
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 21:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56D771F2459C
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 20:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B6C207A14;
	Tue, 29 Oct 2024 20:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="WnyR2iTP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339021DAC8E;
	Tue, 29 Oct 2024 20:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730234269; cv=none; b=n1YBxg9E/rv6BjWCgrhpysOKcmq/UKjpvD9o6Z8FRnp5rgz9Un3Oc/Mnpci6ypRwGV8EuVSSR3c4HJN/U6bfkVqC+YhqONnsDeqdGo7f2TDNinKYeSqbz6qgJvs7OBi5c2JaidSvHnzOcay5m4EIPtKI+svnWTBsz17rnxZ3LXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730234269; c=relaxed/simple;
	bh=Pn8IbOM6PQjhBS/svTx7c3FqVGthgO85lsYlDjWydoo=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=rjzSWGHPfT4UkE8N1SFjn+tDNLvF24Rc+ci6cQpqBwzbhRtTgKU7mVWqGxHGUT5P8uoW4E9XOo3O47v3sDY4X5FiH/Khu0JaWLjCFbhlptERHce2syUtNv/W+JBZ7q/mBCfpohAvWx5SzibDZa+RGQ0fuwkqEiUOixgTzRIA2Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=WnyR2iTP; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1730234240; x=1730839040; i=markus.elfring@web.de;
	bh=2F5NLKTLbfCBtP5K8Zr8KlJO4E66JAmj/qGsj6/+jJU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=WnyR2iTPdbo2iQ7TWsj2m6ytwCR2cAvdEp8AH6iiBdvfYh0vwUre1YEQsB4U/29N
	 SZLR2+zEB1V+UMdhcy6n4lYEqfa0qqc6PFpLoyKlQsgHRm9sHalj2fVGA1FQtMAJx
	 F/+bKy823YuQK7LQWwLKpBn1CaG3mrxGxvORd0d7THQRh1CKwazlXH/e5tml5HDTg
	 QuMVHWb7QzXxVv5h6wyfkcXIgTlymS3cG6CC2Ne9xsFmVcE2cXRJ9/ncjxpsGgChB
	 48IoJuyEbh0s4w576lyQ+hkCvzA4YjZ2rjtLfgypGdBasPx5Jejm7hHthJ3uPQT+G
	 rdcRpY82o30zJnP2nQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MfKxj-1tm7LP2RcB-00iCKo; Tue, 29
 Oct 2024 21:37:20 +0100
Message-ID: <7d8df935-d1b2-4416-88e1-052113038f54@web.de>
Date: Tue, 29 Oct 2024 21:37:13 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Pei Xiao <xiaopei01@kylinos.cn>, linux-wireless@vger.kernel.org,
 Kalle Valo <kvalo@kernel.org>, Ping-Ke Shih <pkshih@realtek.com>
Cc: LKML <linux-kernel@vger.kernel.org>, xiaopeitux@foxmail.com,
 xiongxin@kylinos.cn
References: <82dd45fe7faed8f558841643a0593202b2da90c5.1730192926.git.xiaopei01@kylinos.cn>
Subject: Re: [PATCH] net: wireless: realtek/rtw89: Add check null return of
 kmalloc
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <82dd45fe7faed8f558841643a0593202b2da90c5.1730192926.git.xiaopei01@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:geAUZc1ce26bBTfHNfhlEr9aHDHHrYeL3lHIVOiDQSXYrlSNMbm
 jYs60swgvMcxaNwe0UKyJzFGxad+r2ymapVZONMdUJtpbUJsNn4nd/sWaA99J7/yiAuKuHr
 qVeOJwIzdPvC6srNQYcjqzmRZ3VCQN2twOxCXmsZDlUETimsgPNG3Pd50qIQLUeGZt/aJuM
 YVS5BcRIRdEvMTMsrhhNA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DgCvXnav4KI=;V2ACIpGjoGj1ItCbRzGCEUz6jIe
 ZIvJtSTtRmNXyQ1XLrfe44kkvceIQgUzKw5B+PIGYmn9q8tese6SWMzHvRZkiCWdtM9D4Mlqe
 vcZ/VvWZiwszGELQywIxNAEzHLpJJ9KamuHvpKfPZY7m4HHZvsmpGVhc+7Ry39FierQ7QkvqX
 yRsCLCeDXlhJocVneLE71y9sbxVhLHQG4dc3J3Uxh0wJLhhALMzjTNHQdn9ZzGTFIc5EhwqEV
 bVubpjMQNUtN8ufXEPRY4SCfF7ZCdDPnck9IBCTdG1Yq/hqIvv72PAEdTERunlTAvw9ryIhdK
 c7ubmgPyn0ODHbtMcaeK2qyU5bxKXw522A1ZXNLZY4oLX0J1tO5wTVpi49gG7VcXh2XdgZZky
 PP5imhw3+7DWfHTzzNByhP0Rf2e0R9iui69Y1V3GKONkkYUenR7zQmhtodfimtgAZif0dx2GY
 hBCDv+KlKq/QT8xjOMEijOYt8lY7pdWz5UXsMiFIYzhXoOKyVk+GRzxr10imvheTAQ6Ze1tGd
 WwCm/iuDeEjYHIZR2Eyf1UHbbUjCvhaLgk26GdCTEhZd91UEQJlouPgRoQPX21m/p9ih9ATHw
 Y2zEfk2NO6JIC1jocryQIcY7LyvH7yTBXp/+/mw6w2YIdp24Xf47iq2PmLNOU/e4NzsEDtHA8
 CYI5U8OOtSk1NJu03T5TiCnZHShpJAfxTXiTBNMX7Qn7tHNXUKHNk59MLB0g/w3IERzC3Jfu2
 7cTJSVtD99Q3VIvCr13HYdnrb46ZjZ5GSArlfJJMfYq7s/E7Tn4B/IHGrxIaxXR9NIZpA2esG
 FA6CTAJ0feAEgsqOXTmDrvhA==

> kmalloc may fail, return might be NULL and will cause

                           value?


> NULL pointer dereference later.

* An imperative wording is more desirable for such a change description,
  isn't it?
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.12-rc5#n94

* Would you like to add any tags (like =E2=80=9CFixes=E2=80=9D and =E2=80=
=9CCc=E2=80=9D) accordingly?
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.12-rc5#n145


Regards,
Markus

