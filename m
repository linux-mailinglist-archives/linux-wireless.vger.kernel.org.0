Return-Path: <linux-wireless+bounces-20971-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17545A759D6
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Mar 2025 13:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DE043A9124
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Mar 2025 11:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C99190470;
	Sun, 30 Mar 2025 11:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="IiyoRS7/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A04513B59B;
	Sun, 30 Mar 2025 11:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743335613; cv=none; b=syRC8DGZzXL2yaZRAErOHfRfi3+/SmuYHWj0X4xIMI+bOe3zd0sTcJAX+DNo3UKLsEulMUXGrmxvAd7CR65SXCPs6JZOGryhOO2xE/q17N498OpDlaHqiyAi+FEuOU+5MEitQLGUJQBoVz3opSJC9+4BEwC84U8PA9sb5MSyZL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743335613; c=relaxed/simple;
	bh=XtJbtevUkqr+6GTwn6rjqrUW7rcI2UCNWyRet4pQ01E=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=RBM0qkLlHHtdEvQKvqugGg8lIVCddMPHZeIk+6QHc3YrGoqKy8Ks78dMxGyoKL3HXKV4v/6z3nmfuW5LgWPTqcZJa+c0cDFORbLNkKwyyo73NCCjICRjWGhDM1oX+lKG/gAkiZFlmbRCiHGa5+zzG8Ddx/4syfvRmZJzYA8ZwsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=IiyoRS7/; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1743335595; x=1743940395; i=markus.elfring@web.de;
	bh=rIm1c9NF10GeWVSkFfVIVpsAHzV9Llg7tHlH6co2Zek=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=IiyoRS7/t6nvp9KDitTU8YPBgcS2KHTDjgRWIKpZ6zFDfOZAmDC7GZlCKE/ljZJs
	 4n0M1AC2dz31HNFuoCkl0w5ERf8co9tL87sADX3pk74DRptch9sHHAmdLae6VxdcH
	 HrOPQcMV3iOJO5VBzzYwWOppDc8+XBX0bHngCZ46kQtoBtdKmR3jUEVn5zptZdiLK
	 NMXZ1a63QrWzk1EBc5M8qCCCcZONorPuLDWPfBEvKtUFrdc9qca0qbfQgaB84o0jU
	 S0HfYimkCJRms6R2Os/UeR0AGEf3JOWROV6JUDqqbpCZ2ZRLOqRO/+AtmhnsOZGm7
	 JB8gJav0vN1uWA4c1Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.13]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MZSBQ-1teX5J03tO-00Lw7q; Sun, 30
 Mar 2025 13:53:15 +0200
Message-ID: <c9185d57-0c01-4f8b-80a9-dbdf5062586a@web.de>
Date: Sun, 30 Mar 2025 13:53:11 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Abdun Nihaal <abdun.nihaal@gmail.com>, linux-wireless@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Johannes Berg <johannes@sipsolutions.net>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Alexey Khoroshilov <khoroshilov@ispras.ru>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
 Erick Archer <erick.archer@outlook.com>,
 "John W. Linville" <linville@tuxdriver.com>, Kalle Valo <kvalo@kernel.org>,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>
References: <20250330093320.22293-1-abdun.nihaal@gmail.com>
Subject: Re: [PATCH] Fix use after free access in at76_disconnect
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250330093320.22293-1-abdun.nihaal@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:rwOVgU3D4C7MNdwpCTnZQF6oa1WOs5sfVQvAiOWuLvll5THd0Tl
 CZNcCjzK6mMP4LdB0k6cmYu9nfDWSL1ZQwJ1TcHJ7UFTycNhB8CDLk+5ItEEe0BZJhGElL8
 JKP/WtPGEOjsv8X1/RDXth7L0n4HawHrsyEJqKoVciuHXTricG8rax9aq+cbbSCGH/ZqtYL
 ErJc9FcBuXx58XLkryDgA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ljiPSMIkKl8=;/Nbour1tvGmoG9VVBjzVX5xf6ym
 9m5KipU6c5dSSREqaZ4veuOue4ozkKeYz3IeNyaezFW+7riZOKhiwWRRiHFSzhz0jdQVA8zz9
 b532tsgSZ/g8VDE4nkHkr2vf1jcqZblOKn6E/t49wXQYPdweRmhn52ZiKEk6I8Pnrep9YXPN1
 +yQuk1TVtZZEN3T+zXWx0cvYgwXTXt5cnGeAC/JLthT5Ri+RYqMz6LMjCLjkt3BjBmdxlS76i
 yON3lS0lGiRMWxK18PyWFt6a24Q+0A4HmZ3Gsmx8BcXbq7BD83tFjbUyuZvyrrrpZx2zkOfgm
 0njUBcT+XOY1OidTnp7H69KYjvteu3irro5nw6EMlPjBgTNcGLf7MZxUb1dGVQnqDgP/A6FjP
 PD9aUFXZeN2gIcPV9DTpljZTpgCQougPP0ltnw1p6bYrKhM6UT3Syot4Jm3jYIpgHkBthGCkr
 Op7Ed7VS8GybC6Orodte8pq/9f+hDx+sbz/1MAFtk3qsqsbeQPiyUn+E+TuJmEGxiFso5+x+q
 vAXtDSmu1eEx19CJpSaziuSA8saqVUSPnf9r+NrBHQbQ5rVJKLUdcnB6Ooj1IYza+hyIZqF21
 1EJ8Lmxqq49Otjmp4Y/9VBT2bg2KsosaD00nktNLf4pAovw0X5Bu97Cpv2u1B+U3Sdf7sYQHh
 K/RpAwWlS16pEUjhNKkyagWBjCCV6ld93ywosjO3KIpp+rh+8iTFH2a4Td8YUbEAQ8B6SyPM5
 91RMUjYhcIaVHzRmJtB5cofounC6P4P/Qq5g/Av3jR9K0UAL4py1eCCd0K6zADwme+gVYr6Hd
 spWtSEHkDkWnAt+KuO4KbSUo9yfOkwuA7sO85VTmi5nJB32m+kI1WlJHgoNDayuxLa2gvFVd2
 Kze6YupR1Rx9gr/pOvo5paUY2RbpfD/IFeEtaX4DIDZ/ymbQuz1qP2KvlHC/60ayMOTLNe2rO
 TPsbvV3joiw+UPT54SLwhQ5ZP06roVfHEXRSxZISXa68rD770fkUGJosqwOL1/nTKX67nketa
 QKfqNYhYcUQ0AZI9uuJz6d3btGIRRM9kVQg5q4SNfVZUPku28BE1cDIrH45FIqRBPETEsqra2
 iIO711VyPMTa1LcMKaUE4nu0Lq/EmiXCMBEimUTkL4HIFizfnYfAetk1koXNpe5ip6cPdhFS4
 xHyYdFU+skkDCGq+oZDDnj3XRoGXDEl2y5XMwpKY/o2g6kNON/+c5Kh7L7oX94noiYDXL3AGQ
 m7p0WbPZAAm3KdTwAVVqHFUlbCmvJu+auV251Z4HEGBC4enwMTAxCRv0gPvi4aQ96E0AzGATO
 RcPYt1+Jg5cQ7Z0VG1mO5rLtWLhh4n9egooHY+tZmx2/Y8gh5bRDMlF66NbG/9MFXtVPyPpsL
 JMfUjduqNnd71Nai2y07UU26aKuL6urJJN334FuVzerHQfv1RgxyZmPbGG3N+ofN/lwrMI7d1
 0aauhp1FfOw3EmqpFUkCSLvLxmAtlnXN0u1iVQPCS7F13qNAY45QJIqPMjorbJt4Yev6kVQ==

> The memory pointed to by priv is freed at the end of at76_delete_device
> function (using ieee80211_free_hw). But the code then accesses the udev
> field of the freed object to put the USB device. This may also lead to a
> memory leak of the usb device. Fix this by using udev from interface.

* A corresponding subsystem specification can usually be helpful here.
  https://web.git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/drivers/net/wireless/atmel/at76c50x-usb.c?h=next-20250328

* Would you like to append parentheses to any function names?


Regards,
Markus

