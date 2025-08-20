Return-Path: <linux-wireless+bounces-26481-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB743B2E517
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Aug 2025 20:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55921A2751F
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Aug 2025 18:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BBF274B3C;
	Wed, 20 Aug 2025 18:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=comcast.net header.i=@comcast.net header.b="ZSOgbLWk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from resdmta-c2p-566137.sys.comcast.net (resdmta-c2p-566137.sys.comcast.net [96.102.19.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B735D28E0F
	for <linux-wireless@vger.kernel.org>; Wed, 20 Aug 2025 18:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.102.19.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755715156; cv=none; b=FkSNd1Gf36wUt6R7ilXvaST4VgDpfgMl6xpPG6wV2+ac6GFkgZG8JO4+q9EAXBpCqxOC67gX/u2jsVrI5sDuGP0yRhIRBK1jhOwp26msE/X8rxb6GEJxqvpaO7oIDpS8ynAtS03Mjh8Fw7RqBX9rF3o+eIqFHiV8jhTKtddCvcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755715156; c=relaxed/simple;
	bh=yx9tDzVnt2UCcod+hBGleC6/LhT/OguWs/OKq8aq0Wc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=fB+fpSpIHoLt9zSL3a+hwDoRvWXVS0hmGiENyEJiEHHf7yeIjmj3vAa+VwEp1jrxBWEXBNG0f0b0IzQWZsmX36I6ftneq93KZaUKOmmpfFt8NjffxuFI0A7JXqnaNlXt37PrGgcugEvkE/ZJCd1H3q2ahlFoDVEo1Tg88Y/AIcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=comcast.net; spf=pass smtp.mailfrom=comcast.net; dkim=pass (2048-bit key) header.d=comcast.net header.i=@comcast.net header.b=ZSOgbLWk; arc=none smtp.client-ip=96.102.19.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=comcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=comcast.net
Received: from resomta-c2p-555955.sys.comcast.net ([96.102.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 256/256 bits)
	(Client did not present a certificate)
	by resdmta-c2p-566137.sys.comcast.net with ESMTPS
	id okNtu5Qu0fRqsonfqulgAH; Wed, 20 Aug 2025 18:36:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=20190202a; t=1755714998;
	bh=yx9tDzVnt2UCcod+hBGleC6/LhT/OguWs/OKq8aq0Wc=;
	h=Received:Received:Date:From:To:Message-ID:Subject:MIME-Version:
	 Content-Type:Xfinity-Spam-Result;
	b=ZSOgbLWkFB+FYpDhPwrSLYO29ezHJ+ANjmKhHEAbKA8XoeeorbdfQH5Mihj4JHIWR
	 7EalSfywpAMpqXxJE/AyVrcm6fHM40GbsV5X/IfDWem9wH+OHokU1s25GYu5XNFi5h
	 +xATWSgUaNyIKPGDPEKQreuuvRMBq71nmLhYP0Gmxv/Im5KEeUA3xthSJkCle8hJXG
	 bX9C+/ZHjwUb+wiKVFHJZwko/sWNPJ5YA8a6uDBFc4L0d8wXafJH11fc70I1Vd4R0I
	 C6oSN/zwdpTeqtA6ys5ejbRcYSoPc1WlNzB9l90PF/+nTlrvpCPq1/Y8dCEwyH9ZXO
	 P/EODtqBuNzRA==
Received: from boobie.home ([73.69.89.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 256/256 bits)
	(Client did not present a certificate)
	by resomta-c2p-555955.sys.comcast.net with ESMTPSA
	id onfnu9te9lltSonfnu6YiG; Wed, 20 Aug 2025 18:36:37 +0000
Date: Wed, 20 Aug 2025 14:36:35 -0400 (EDT)
From: Ameer Antar <ameerantar@comcast.net>
To: Balsam Chihi <balsam.chihi@moment.tech>
Cc: Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
	linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
	jjohnson@kernel.org
Message-ID: <1664582047.0.1755714995989@boobie.home>
In-Reply-To: <CAONkfw452N+cOrLo4p7KXOE_W6p=CFHanBReDdnenXrgEY6Cww@mail.gmail.com>
References: <20250611164004.38580-1-balsam.chihi@moment.tech>
	<91fa8b1d-7bd0-4beb-80ef-eb65d2562f17@oss.qualcomm.com> <CAONkfw5Xyk8CGmVDpWZfkWnuCcFq6400jUkqyeMDtS0UNSh9vg@mail.gmail.com>
	<ecab2156-b234-4fba-a2ad-13a2d9b4693f@oss.qualcomm.com> <CAONkfw4hkDQtJyOj4RVsR3V=FJDJYKnjtmqzD=jBMy1ax=tC_A@mail.gmail.com>
	<0dfe48fc-085f-4dce-933d-e0f132d2ff9c@oss.qualcomm.com> <CAONkfw4p1AuE-MhGiZNMmi-PXR+CjoY63K2Yx_dmv2vnjo-Eyg@mail.gmail.com>
	<CAONkfw58jcGRxotm2zJasQd56oDR-h0b3Z0Yi+pE8hdrmN=Ucg@mail.gmail.com> <1321153053.0.1755624998195@boobie.home>
	<CAONkfw452N+cOrLo4p7KXOE_W6p=CFHanBReDdnenXrgEY6Cww@mail.gmail.com>
Subject: Re: [PATCH] ath11k: pci: avoid unsafe register access during
 shutdown
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CMAE-Envelope: MS4xfKe8auRrZYTHKBGgeCQqUdjSZxZZVltNgukOtPQwSJS35J/eX45Pu99AK0J46AHJ79ZC7FwZoCOnYxq/SJhQu5mNnkCXYjPuNpFEh53O26OQKsjW3o7L
 mQF2Ga4/Jsj0dof2fbkcxWR0xgfeqkKedKm0YldXPvQt1tisuEkYuR+tON4RZdGeQ44zuF1ERqQ5dUOvEei3PIDiIr530DDsBBdQMQsRCibX1vWW2BCEJNvI
 70E6vm6lsAa1zxLMOSXhwC71O12YgpQNx+bR2ipHMrFXJVmssDJMFE720n6C0d65P6fOqWDNJWrYyRz1QHXWlmGGLorUzHEY9OOZ7jpza02cFrtf7qys9Vzh
 1HJwrHIh

----- Original Message -----
From: Balsam Chihi <balsam.chihi@moment.tech>
To: Ameer Antar <ameerantar@comcast.net>
Cc: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
, linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
jjohnson@kernel.org
Subject: Re: [PATCH] ath11k: pci: avoid unsafe register access during shutd=
own
Date: 8/20/25 4:14:11 AM

>On Tue, Aug 19, 2025 at 7:36=E2=80=AFPM Ameer Antar <ameerantar@comcast.ne=
t>
>wrote:
>>
>> Balsam, do you have a patch for this? I also have cards that require
different
>> bin files for each band. I haven't been able to figure out how to do thi=
s via
>> configuration rather than rebuilding drivers.
>>
>
>Hello Ameer,
>
>Yes, indeed we have to rebuild ath11k but once with the patched
>core.c, not each time we add a card.
>Then you can add text files named with the pci device address and the
>path to your board-2.bin inside,
>for each instance of the driver.
>That way we avoid building the driver or the kernel each time we add a
>wifi card.
>I'm cleaning up the patch and I will send it to the mailing list if
>you are interested.
>
>Best regards,
>Balsam
>

Hi Balsam, yes that would be great to have as all of my cards use 0xFF for =
the
board id and I have been unable to use any multi-band setup using the same
driver. I'm sure there are others on the list with similar setups that woul=
d
appreciate that as well.

-Ameer

