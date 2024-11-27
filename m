Return-Path: <linux-wireless+bounces-15760-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CA69DA7FF
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2024 13:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 984CB16565F
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2024 12:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE90D1FC7ED;
	Wed, 27 Nov 2024 12:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="pvlo/KHC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053EC1BC3C;
	Wed, 27 Nov 2024 12:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732711229; cv=none; b=N0IEyxQYWfOBqh8PF/up5JVqMgDLiJ4iwNshw9H2k2ErO9J3dpnY1bpL326zobaAwSaF6jjkyjMryZIZE0zE1zIavs9nTNGuDjcI2Z95w+ewqkcfNVgAGDIeAVoP/hAG4wj0Awht/vu06d5aTzbeotB7r5jK/y7gWVoeyfjTWBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732711229; c=relaxed/simple;
	bh=i0PC18Ag6j9i/4GRYJF1IIehRwmX1aMZgwBOZJqy7xA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OCZIIIjc/Fei/Qvr1FahN04VNlW2/kuOv0hLRmouJEK/biFNBcc98qqkKk0tly/ob1hU83cRvIByQ3lsRWWuD7EOvjZ+hm4gpkHLSUQwKhG244tTqT+j6MgavX2OWZ9qkCsFqdvGmsBPGXebWjCeDQBhmQbxhaui9vGzneB1G64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=pvlo/KHC; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1732711210; x=1733316010; i=markus.elfring@web.de;
	bh=fpewDsh7yobJLaWUslG8bxbswQX0jqbSuiTLLXCbYJ0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=pvlo/KHCSbLP8cZbzImcZt0xMgqjXXMFztLLmb7enGMNdG5xogqvlgXv0ugpvSNT
	 V3VfN3ewFyrZk2YkbUPk8SGwYZLRSrVNXcokA6Hl3VlFNHQf5/rTgm/FzplurL8BE
	 3boBkyOMsO0dcVPrJ3AUt0jzaKB54DxmNS8yb1vM0h3Ql/QqjnYK3L/5ev2t0B6IT
	 Cc9IrJij9GqOEqflBTqt8aGDNA3XQIpx4kyy74uqF2ReGKopknyio9Liz5Gtgpqml
	 7VRX/YVMbXDkBcaIYge/1v30mOqyEQlVxylxuID5FSrh6T9n2UNGc1WMIkiYIIt0A
	 hybLSef0oBNdGXootQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MECCd-1tNjyu4A4b-00HFGe; Wed, 27
 Nov 2024 13:40:10 +0100
Message-ID: <30b208e0-55a2-400f-9638-1765e7ed3bfa@web.de>
Date: Wed, 27 Nov 2024 13:40:09 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: wifi: ath11k: Fix NULL pointer check in ath11k_ce_rx_post_pipe()
To: Baichuan Qi <zghbqbc@gmail.com>, ath11k@lists.infradead.org,
 linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Jeff Johnson <jjohnson@kernel.org>
References: <a9ccc947-20b2-4322-84e5-c96aaa604e63@web.de>
 <20241127032821.57468-1-hbczqbc@163.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241127032821.57468-1-hbczqbc@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LVu/Ji+o6eubGrNMXXAgVq6F/AKt6uw/930Y/eLxbGkhzSwJz2h
 JOI7w0JPyoOko/iZWnHSZRdPWHMadzEN4zpkaXwa1reapplPQy/mJZzRcekJr0bRmbZaFPf
 msoHLzwRvSrs0acCW1XcxoZYhJyXhjOXSv0vQ9kU02Nc1K+IhfofvSOwSrdvzyX0yyxhZdf
 ph65CwuL3yx60NXHhZESA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bDKwGBQ2AXM=;zVmvMiej+8akaBmIA8831siJ9+x
 aaFLK+PPR7o/TiWKddMyOtjZKVDVTjDVmjI/VxRbZOeNQqo9QqXRRscKrZuFpiWlzzEIFbztW
 XpfbrbI7IgIWX+61fTJ1MFXeFqp2zPnUTgzRASWM5c2u9QsNpNifHyln7POukBy/esu2d7ty/
 4ASvuSdd1/WRjndLyv/zjh6qY3aH4UV+2hr/r9o5y1CTrORFwSLZJPTlPAMSndd1+hlcr6AmB
 H535oHz2PzLSQX8/NspKQLlmRB/E/bX1LK10/SQYfiGgeHc3xwWvZDIjOeS7WdrOi7U3YOB8K
 7F26tI3USkiDHEcMDOgZweSyzIMMiyZHU0kL9a7AbAzVI+0c5IOW/wRf6TCzQhqSTYMx9Y3P6
 yv2cVSLT6PyLboJaSK3LqdZRDjf1T33W3Y35V5PEQPMCAoScZ3Z8e2c1KMKCfH6RX51kOk3d+
 u/jmYpFf8lIfIvLE3SqQ9wz0w3nffT5FGde5k6W8Vu/ehigo3XBn4WNYyyfUlMQA9tvxJDpFJ
 QCfOWf8o0Xe1HFuTbiha8oXKxsvPZFcaoHYdsV3N1D4T4+AmpRDzestAYL4FPs9ieCNQYr07X
 lQblkvyouOAAfAPJNfk2NJ4J9rm4wYJ7ckNmOUJFG1U4n6cGzLqwg4ev0EvE1WzCEuJFF8gHB
 XBWvpWgj7g8jz0zrDmJfZ7/hDvGvoCT0yNV/jUO1NVE9Y7zOBXseZKKPoHerLidAUVnuqBfFU
 f88fexrf11GqaMRWoUwbyLps2JOWUs49UUFp2DwkR1FJJGNgnYB0DM7/xJi0wbTVgHwGuNEsJ
 BwgiW9T3cEXktoAn51h0PXYlxl0O8NpR0RZ3ptXu37W/Lx2tkQbKr7VWDcr45pc2IDfuXPqoq
 TAZpqTuBB3Wy2nnEgKCD8wkqK6aVrDSAi82lS6IofATol1ZqpDH4YGN812K5iRlf8SPfvdMzl
 v9AcaWqy8VK+3PihbTpPFRs1YchxA0ZtiPd0DZltmTimqg50orU79NYq9Bs1i+bGwKIlGa/Nw
 b+FiN/e6Lk1KTWpF+mcA71s0TH2Gis0IKScsXWwuTw4pQ58Qi3crnz60OGHTa9XcEwrEqYf7Z
 2AkOWDu54=

>> Is there a need to reconsider also such a return value?
>
> According to the current code (commit d5c65159f289) of
> this function, this function should be terminated directly
> after checking the null pointer, the return value may be
> meaningless.
The return value is checked at two source code places at least.

* ath11k_ce_recv_process_cb():
  https://elixir.bootlin.com/linux/v6.12.1/source/drivers/net/wireless/ath=
/ath11k/ce.c#L450

* ath11k_ce_rx_post_buf():
  https://elixir.bootlin.com/linux/v6.12.1/source/drivers/net/wireless/ath=
/ath11k/ce.c#L893


May the detection of a null pointer for the data structure members
=E2=80=9Cdest_ring=E2=80=9D or =E2=80=9Cstatus_ring=E2=80=9D really be int=
erpreted as a successful execution
of the function =E2=80=9Cath11k_ce_rx_post_pipe=E2=80=9D?

Regards,
Markus

