Return-Path: <linux-wireless+bounces-593-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 657AA80B5EF
	for <lists+linux-wireless@lfdr.de>; Sat,  9 Dec 2023 19:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E23CF280FD1
	for <lists+linux-wireless@lfdr.de>; Sat,  9 Dec 2023 18:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99428199AA;
	Sat,  9 Dec 2023 18:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuta.io header.i=@tuta.io header.b="I9rTTj9q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from w1.tutanota.de (w1.tutanota.de [81.3.6.162])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D6B12E
	for <linux-wireless@vger.kernel.org>; Sat,  9 Dec 2023 10:55:17 -0800 (PST)
Received: from tutadb.w10.tutanota.de (unknown [192.168.1.10])
	by w1.tutanota.de (Postfix) with ESMTP id D0D82FBFB77;
	Sat,  9 Dec 2023 18:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1702148115;
	s=s1; d=tuta.io;
	h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Cc:Date:Date:In-Reply-To:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:References:Sender;
	bh=thtgBQ/tVExwZLEtEXEA/ltDX0mw9KGAZRgAcA1fGq8=;
	b=I9rTTj9qy5ET8LHk0oXGwaik8VUjKZIVF6EBzEAtYcLu5SA1a803fDRJnWQSHv4o
	N2ZA8KjrQAHPQ8VjyoZl5MyBk+zM6LbXOhVMyMqxWITSlbaJs9fB84ThQf4Ttc3Akpy
	0ISY75DIR+vH9lA4Jv2rQjNIy12qd8rUg5zvwFVajlMjAl4BrySzpvCQphha39Kfj6R
	D0GTLffvUNCriptHZgZ5fH/5jybt17CZON/Ans//0/5zEeVK5Y8Zh0sY8CJ5MQoT+Fz
	e18SWxZX3orXUsUDlNRSOouscbf18wWZoJXsYs0/V2NX+Y0WYKckpoeF+pjdLePcXTl
	x+T53x8Tyw==
Date: Sat, 9 Dec 2023 19:55:15 +0100 (CET)
From: marco.rodolfi@tuta.io
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Linux Wireless <linux-wireless@vger.kernel.org>,
	Pkshih <pkshih@realtek.com>
Message-ID: <NlEvkht--3-9@tuta.io>
In-Reply-To: <60d366ff-8145-4f9d-a9f3-e27b82da31c2@lwfinger.net>
References: <NlE3B0K--3-9@tuta.io> <60d366ff-8145-4f9d-a9f3-e27b82da31c2@lwfinger.net>
Subject: Re: Wireless P2P support for rtw88 families cards
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Oh, so there is already a test in. It's not in the main driver since it's missing testing or it's not that much stable?

Thanks by the way Larry,

Marco.

9 dic 2023, 19:34 da Larry.Finger@lwfinger.net:

> On 12/9/23 08:52, marco.rodolfi@tuta.io wrote:
>
>> I have seen in the past that this feature was already requested and Ping-Ke was trying to see what was needed to be implemented. I also have seen that this has been implemented in rtw89 family of drivers around one year ago.
>>
>> Is there any progress on this feature?
>>
>
> I added the tentative patch that Ping-Ke suggested to the rtw88 repo at https://github.com/lwfinger/rtw88.git. If you pull that repo, you will get the changes.
>
> Larry
>

