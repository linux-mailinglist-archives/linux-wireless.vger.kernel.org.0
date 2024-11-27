Return-Path: <linux-wireless+bounces-15755-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5578A9DA5EF
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2024 11:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 038E9163F5E
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2024 10:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D79A195FEC;
	Wed, 27 Nov 2024 10:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="QAdUcBC0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2753155389;
	Wed, 27 Nov 2024 10:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732703811; cv=none; b=eGm5lAzi8e4NJFgPZpr5iNuK1feqxBUVOArpr4vfDX5QAl+bS/+/euQbaPBmgOU9Fz1rpWj+8J5RqApZ7GRm4Lx73DLZ+hLt5SZsMl1D4Mb4+NbtSmqvrQtvM6EdX59jgheY80FORtSO67jWmz4bKqpOyurpIujnKZXbDOiO7VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732703811; c=relaxed/simple;
	bh=Ndh/Lh5lvgOSKyACeAXDdhF0NYC7J9JBCAdOFVFWs8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sBGmk+6stiwwTJahGs3+j6XWULmlyya85wlm7h+/mSP6Mtx7qFjgI8/aobJBi+6mNX72PCqvVJ2ufRhIcl5xAEfje1iwZ9uj0zed0lUnttugk+kwSf0SvrYFwhxiC0U3klLRrAObJP6UMsnjIGON8mHobSyWm19+y76yGJTsyFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=QAdUcBC0; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1732703786; x=1733308586; i=markus.elfring@web.de;
	bh=TmYabh9bIkIqigNzwGNBZx27RPDTRniJlyb8xtwhRCQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=QAdUcBC0zKYJ0m5e9Iimdf7z/gGuiIFpwQINi/whCC5uf9NKwwvLUl24y9zqJn6U
	 hDfHX+z47ODQgpVyO2HCqDex+TtjDnwtnwb8Csh0YkUEJuCGAsNpbxMhtAYSTtFbE
	 m9nrt2TUKCGRyG4IDTfMG9SoqojpQFA99Ln+KTR63UWEfm2/Wbt1KwbvyQ/H4/7uD
	 M8TJw77odM1dp65cqr9PakENtC2YoNB2zkfnjH7AgnEiW4o/GMDXHFppERwBDT2lS
	 24ifynlJcaQT8uuAIOZX5VOz0DU9WCKHzjKkCP5dw+8mUV7S31GdZpaoueEZ3LtXO
	 jxZFzSyoc1ZqWIdJIw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MWzCt-1tEDDM3Wnp-00XC30; Wed, 27
 Nov 2024 11:36:25 +0100
Message-ID: <64d7fa52-b96c-4bff-b90c-98f0b1d15ac5@web.de>
Date: Wed, 27 Nov 2024 11:36:17 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4?] wifi: ath11k: Fix NULL pointer check in
 ath11k_ce_rx_post_pipe()
To: Baichuan Qi <zghbqbc@gmail.com>, ath11k@lists.infradead.org,
 linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Jeff Johnson <jjohnson@kernel.org>
References: <a77fe99d-079b-4ef3-a1ce-6aea10256860@web.de>
 <20241127094317.303815-1-zghbqbc@gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241127094317.303815-1-zghbqbc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Py1c9kYazIOa97Bl2d5McnNdohl31kJr34k0xDQ15O+y6nlbgR8
 TkkQ/CWVDJvhg2ysptEWlnxDa+lzxLWBaXhM+2U5TvgEnPgjf3juhLIzUvmqf6BE6eIetei
 KvjXJ/S8m9UeGx1WeBsBFXWCAA1UcUqy68rBGpE/LG4B1eCS4R7z7b4+/tIQtJjYckqmYxY
 iywyvxayCWpA8pNpS6WDg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hORuV1YLnf0=;WUqF6ybSNBXeLmjb3Kxfr7OM+X9
 mWgiW/9ePL1dLqAsFTznkBZnZu3/CjJOkPqYe8L10PGSI3E+nKicsPCGoQaQcBreNPt9G8Mmi
 gDEV4uJTpyTIPbqH61LICPlwAdN9gXoFBOR03EGNRP+MH03I3qmSj9Y893nRUa0MkjqAZc48j
 Z86G7FA09bxhI/suwcLd24JGo1+PfZI7tJX87zQWffKe1JsrgZGzC//agUGfDjdIaAFeaekFp
 SxMarSWeuhReCnfw2M3o9vT0HWN7OnKhyoaNdeKS9toaiOOwj2CrVzQUzQ33FZ0AWhoL1dLdc
 xM9n5+n5ktmNOigA4bROY9oJSKCStdT+x5CZgdZRBavb/Bke1wa8OLsnaWgzcMr1c4Rewv9ve
 PJ9sRUcRgAnkAJzgyjLQ46KdX36tXyc/5yAq/BqMnjK0UKlFq5SDhyS6OT1Vhyv4/4EDOXhMv
 avLAUtZSmDSwDqK5dlcoP4Nu+GI1NlcPTF/wzw+OZeT5wjSDPqbfBsHeyAFcZbXiKRt/c3r5B
 ITfrCFPFfs2Lu6zkSYjYUpLVBPKKe055Dl4I0m/AMWbf7vDQ8m3mOxne7sR+Jch7sMznk434m
 NJC3JVfCTvms0xuBMFhJQazDgp50O5T3rrtY+moDJCqBlnPbxYl2QktinfS4SjG9PmRWjAmCj
 D4DbB4ScbmxoHktxdwlO+VW0ubfZNZBzLLV0Wv3tYtDbvR1LWe6jkaJwCM2wnevZVkcEAkORk
 Rija1hFOhuJrQk1jEpr0DEnLDFAXkAZkzN97PJJ7zftDBMDxXB6pwHM3iD9CmU4JSKNckKhTM
 vhooEJd1XrY3slNSdcRyBQqUDirY8v7hfI3Xcoq1y2W8iTvOfIqjG81Fw4JIK7oe/3ycsNZ9J
 8lUttXBaAif96txnij/59AD0gbHsHEMk72JcMgMTcyjpzFQDuOgj8Sfhd

> Fix the NON-NULL check by =E2=80=A6

How do you think about to reorder any information from paragraphs?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.12#n45


=E2=80=A6
> ---
>  drivers/net/wireless/ath/ath11k/ce.c | 2 +-
=E2=80=A6

Will you become more familiar with patch version descriptions?
https://lore.kernel.org/all/?q=3D%22This+looks+like+a+new+version+of+a+pre=
viously+submitted+patch%22
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.12#n310

Regards,
Markus

