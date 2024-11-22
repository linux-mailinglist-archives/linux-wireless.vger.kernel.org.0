Return-Path: <linux-wireless+bounces-15593-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 558699D5A51
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2024 08:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCDB8B22D6F
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2024 07:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62688185B72;
	Fri, 22 Nov 2024 07:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="hlbin4P1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB97176AA1;
	Fri, 22 Nov 2024 07:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732261846; cv=none; b=HEgpCDVlLK7DZWhICzMQK5+EYImBYwpC+3o1LWSrFsJVz2wmt8t1Ac2qb3LFO9wU/Hftn4TxKqClnBcEohA22y2EgvoIDgyz5f62j18oPYBQ6WUCLHN/rkFUfFcrycOor2/ur6x6oTuL/3QE8jyw+aCpAh8K/g44l1XVeYxbvG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732261846; c=relaxed/simple;
	bh=Chk0jct/UEfFTBrFGgW+cRqElerrmow7Ab4tm+UCdaw=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=fnWoRANsHifxX5deybwcQsVkQOfjdBtQBTRDpB2Ahqx6KsjVvunq8LfxUygQ9/eq7HUFjuJyqWAt3YuGTMtFfMT2NQss9Nu/UWcyPZtDTlqPWH0r4CEXG2VOBWshI1aC7jeZK6/g3ugToIDVAzb8gQywXozt2XngwQFHXNBPAUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=hlbin4P1; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1732261820; x=1732866620; i=markus.elfring@web.de;
	bh=tUcZf+fADnYuxFdDTQYYrLURdRNVAux3JfUMmGIPZdk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=hlbin4P1PRLTyPWtasl7N6GIezhxqcpdu/VJTskHnirvv/KfNo8McKif5c3NptPW
	 4MBUv9dtbR7feqMttuOGieflrKuCCzEru1Dk4sevSyK7+JDrDx1zozaItPpX3C/ui
	 6cE8f6slKj4lijODXgGpFi3e0yON/vR4I3Hybymg47Up07z6O/Z17R3csVtKQ34FP
	 DWN96EMflD0ouKHz9PFsCV+jxHwVqDQtRJwmYxGygZFaFm3ceXGE15F42iVvZev+7
	 xit2OoJy2i41AjyWVKXCIlkXbs7Ze73pRcgXlS8z0i4HgRGu1uJ6hfbF3H5jUqjz6
	 Iws5WtawZdVErPmYsg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.88.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M7usw-1tJK6o2Qyo-006off; Fri, 22
 Nov 2024 08:50:20 +0100
Message-ID: <d01e7201-1a7d-4097-b9fb-7f9878591e31@web.de>
Date: Fri, 22 Nov 2024 08:50:18 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Paolo Perego <pperego@suse.de>, linux-wireless@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Benjamin Berg <benjamin.berg@intel.com>,
 Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
 Johannes Berg <johannes@sipsolutions.net>, Kalle Valo <kvalo@kernel.org>,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 Shaul Triebitz <shaul.triebitz@intel.com>,
 Yedidya Benshimol <yedidya.ben.shimol@intel.com>
References: <q3pul7n2axag5xcxzzjjrhwlu3m3vh64bz4ln6dt7w757z47hk@byhyujhanky4>
Subject: Re: wireless: Fix a dereference before null check issue
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <q3pul7n2axag5xcxzzjjrhwlu3m3vh64bz4ln6dt7w757z47hk@byhyujhanky4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:oLHWAOiTfN+/Ro8+iYsMuGQgriQpyXbw3RAf7wFJprsKkfUkoqy
 3TvMyDMWnVUR2D7rgXGaB1zwKOok3r7bzAtdOxJxPhas4/jdSG6BVtN+Fz/R6AbIlBWe3zS
 r5VUG27ttAVZzlVmTPcLbpY97byPYxPMdRr71vFb5Oc1Y78/KSO+cM3rmLSI2WxYOhxQBem
 oF9yIV0XYUIyjpzLkLeYA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:b3ToenVGJQk=;fLndjSoJsjyWqlD1XWPZju+Zv2J
 k+ZqNeK6KfZBSF6vThCweSACApq3eSzWy0fHIElUISlYSTDJYhdzyOViy2HsWkncZ9qu5UZw7
 8qqQN4uUq7r1g/Wumbn4vSUYpTgJJsMr8p3gMF3Sn12G8fSd5niiiNHn7Dms7GzklKkndkAiz
 Mvb7zHxmEJ02eLnwpLgu8SFTaD5t8kQBMJ1QQ3z78GBdzE6Oopm08556KaVuwMc4Y/OeaCwhn
 quCH5kvWCNjkmxkKshcAHpQcBsVdsqPKsTbxT1umZMd2r+tdRiFUM8kphBO0Hws+PrSa0Wprq
 C7rgoI9VNNfiE4FyjD0nLnr3Jv6X5rJWeYkWduidtFhPP12fTeKkAI+MrlGJHibMHpBps4zrx
 3j/zl/t5noYneGjcQ4EIzoCtLOrwmn0VeDCvKXVTg6eupzHuk1L54ifacArQNCncO8+UhsGIS
 BUnyxq0b++L7xuVnGganKMjqd+auEC21LTj3aVuOrhHAQyckFAWF3sCP50KTk4CFA8BJKZkPg
 R1vwQwQb4IQcGa0kWyyB/aikzMEDFHEtfbgFgwhpGHaCqJmQXvx949dTptPThJqumnv3sIQS9
 lQBF0o23hNDrz9OOMMMdPUOHVlIZ6m1POnQiLAo9MiaSL6I+TnAiKgj/meGmFV5g1yBEWDV/x
 ymVBwM33tqIawEatSuiVoXogEcle92trxEHr6jr95YjVTVnb9+gq/VpJUwWkpluIKE+fYRplk
 IkoLJhMHMrjJmguGEquW4GaMNRseJ136LozWldmV3DlzjhQWoxqnqEPBz6d+P805/4ZlyEoIv
 If9EiioTi3CCYYMh/KFpVG/K3EsEou1k/KpQWoVHE+a3WRdttz8lodwu+1rng/3RArIp5ybRm
 9CQGCiB62vGRP0yp6d677oaaWdg0aRYs2WPbpMcG7Mo1/rAw/GC8/vyqWBaU8acIy0zwWJGw2
 mmxkz9mf3DUG5548b9Cx/6kf/1LBaTsASEuZE1+BjapdCYsSaAgpPXxTkgZe1Z0qVGSsUQXVe
 JN8mYYG0swdbP9xVh32JmuWg0vxdC4lbY6WJP34/gD5EWfcqgYQ2UX99UJ8LYiceAz6vg7R0E
 8QUYJHaxE=

> Oops, I'm so sorry this was already fixed.

It can occasionally happen that some contributors would like to adjust
the same source code places somehow.


>                                            In Coverity dashboard the
> item seemed to be still open.

It might occasionally be unclear with which delay corresponding items
will be synchronised.


> Apart from that, did I followed the right steps?

Partly, yes.


>                                                  Was my submission good
> enough? (I'm new to kernel hacking and I'm still in the learning phase)

I find details improvable.

1. Change description

2. Patch subject


Regards,
Markus

