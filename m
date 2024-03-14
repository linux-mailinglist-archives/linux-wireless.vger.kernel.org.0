Return-Path: <linux-wireless+bounces-4735-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D9387B9F0
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 10:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D62461F22DF8
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 09:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8406BB56;
	Thu, 14 Mar 2024 09:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="C2p1C5nj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5EB6BB45;
	Thu, 14 Mar 2024 09:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710406948; cv=none; b=SBjqOqJ1WaMgdGltnARJC1Udyv0+gkwOLif+/UCEHWWxnkIWpqju73mH4zHjo2xWGXDlncmudgd+P7+H3jESbZv1yU3utYYvUkJg+hCU4WYJ7X3YWwNUi9e0Hfrg7WkkueZvcrNX4AhNZu93pjTIxiFu4OfaYq3yTXuT8PX5Hz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710406948; c=relaxed/simple;
	bh=9TkzJHwQvqGY2QMDScZZ+MsjsfGwgb2RbE4BeRY1nsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j553Qus7NjTKWl4WtBfLjKnCZYR/fBKlgTad+oyhbczEQQCvIrkFvrAJLanTaqS6toQzKfvlcBKzl8fZtJTnry233QUeusyQM1y70jWB9JqKRCQRyGf49/EsO0d1AxezJb288VzfhatH+nRpYcTEjygYBlAC7HpUPu8791wWpPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b=C2p1C5nj; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1710406934; x=1711011734; i=fiona.klute@gmx.de;
	bh=9TkzJHwQvqGY2QMDScZZ+MsjsfGwgb2RbE4BeRY1nsY=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=C2p1C5njGDodbNLtCGAYAYIsemlQ4nRvmpqj05OqdtbvUJNkKMhcqi06W50Tvwy5
	 qDF3YwyGuBgAMI1PzwtWsvm6NZMcbZNyXqa7AlHPMM59sHmLs1Ca9PmzxG3gpwOf3
	 FtxrCCLMNMU2zCNLee4io+s06iuqVb0RGRxpj/HQYqgogkyKJjFky4A3hzBnrwn8h
	 yiihgy05h5AHfHOa91S5iN/fUX1ZKvHb6IdF7zdr7xXSBZYdFW9jbsg+0MLeYmnMg
	 FbCtYXtAG1D4aN5ejWbol57Qjco6DQR22gq8j0u+v83m3fh0f5l3SqVmMfKsddZ0B
	 fsAZOEkCwXE7Oj3dgg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.7.2] ([85.22.114.134]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MJmKh-1rVcy71GP3-00K7gR; Thu, 14
 Mar 2024 10:02:14 +0100
Message-ID: <454c22b3-bea0-4df7-81b6-3541795bc53e@gmx.de>
Date: Thu, 14 Mar 2024 10:02:12 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/9] rtw88: Add support for RTL8723CS/RTL8703B
To: Ping-Ke Shih <pkshih@realtek.com>, "pavel@ucw.cz" <pavel@ucw.cz>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "kvalo@kernel.org" <kvalo@kernel.org>, "megi@xff.cz" <megi@xff.cz>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
References: <20240311103735.615541-1-fiona.klute@gmx.de>
 <e540243c657043f9a6d0a8d5314191d3@realtek.com> <ZfAVlEhsMwYMq9BY@amd.ucw.cz>
 <6c73784ecc04cadbcaae3f7e073ffb120e13853c.camel@realtek.com>
 <38fc27be-0e46-4677-bbe3-c0b9689dfbd5@gmx.de>
 <063926329b2507ce4073dd05fdfc47929f3bb038.camel@realtek.com>
Content-Language: de-DE, en-US
From: Fiona Klute <fiona.klute@gmx.de>
Autocrypt: addr=fiona.klute@gmx.de; keydata=
 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
In-Reply-To: <063926329b2507ce4073dd05fdfc47929f3bb038.camel@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4qlg5w9wH5FMIoKpVgA4PznusRMhHIFdzmFdVdDLE4B1luWXMMq
 9vsVmKnf81MKy/KwkYT9tnCiBHZ5Ybnnkk7/Md6kWtg0A5C+DFGbu10bt5EbP5xDzeOKJsp
 abm29f9HDfB8miDiN85nS6nOB+XaL5U5EEm17SNwW6IALpWgU/MdJc6cVUQ6oSyts5MqGUH
 Mv86CSmYR08qUYZxRqhhQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IMoVLnfgkKI=;YLrwAMQlBUOVBHt2tvav4SJxQIb
 jChAWRJWaHAdFiDnHeQSSOihpWfL8HAxfFqzckNumRMaMGkWCNlTIpDKesdH1GTVaRfD4MP2T
 2dmr7REBikZYC+TW3R9wf16bUYOpYbj5Sa0Ld8hbf7pppD2oWiPzmGljjB1njtrZWWM7esk34
 kjTR6zlMCnGAuAzdSJESumePLo5r/zKcuVeW1aFuxvxbg/Y8fq3uOsdn/t/An4qkkpVSU/rhX
 P2YTNz0zZ6mtHjMyYO1pUfBiX/lCJu1XWDTJuUzK3UCuhbmEJ6j4Yqc6yMBQkGICnzmcdFRR3
 D359KW0TyyoF1zevxOLStofEC0HCc5cJ33SbN+HpFYsBCZOLekmKSs7hcatigCrhfOOalTsCM
 sKWbZAThFnwcGVnYffeuALFQBNCX8gUcaaUZ2c2kyptFyTuqetnsysRxtu4aUrmDl+zaKTpdr
 l2S2kbVROpd1cPkrnADhkcjmeUmnl7MSKXathqk2j5g8sBybOfmR/cHiWj6g10EqZEgbJet5i
 8ynfSinA1UeDnNsym7+oja6NMELoCMZlDwldZ8Lk0DlTBK8fA4lmmCSuAViC2XO1W+iw0CMHB
 ++0m3suXdZZ0PslfSv9ZRf8IEBCbD3bGvkXAmeoELvWx7KC6cbglJQy0cnL1YnBT7vHzvuwrt
 vhOtBVsuR3tmgLYK6nLMFX1MlqK7jSFNXwQhWkYd7Q8Veg/zfdmi5Ct2Gja9YjdYF5yXe9G2k
 8ZmUwrDrp95MbApeJUNSZmsLMBmGvZR9aHCqI68X0yJWweDPhftjc+hECTajNkyJQhBdzz6uW
 gJFXVlVlfl0v8G+Sj89ksDEM5Paaf/Md2Y9oengbs235w=

Am 14.03.24 um 01:18 schrieb Ping-Ke Shih:
>
>>
>> Is there anything I still need to do to get the firmware into
>> linux-firmware?
>>
>
> Please send me a firmware patch again. In case I send wrong firmware to
> liunx-firmware.

I've just sent it. Thanks for taking care of this!

Fiona



