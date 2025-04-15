Return-Path: <linux-wireless+bounces-21548-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A1EA89CA4
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Apr 2025 13:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2E9A3A318C
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Apr 2025 11:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E213289371;
	Tue, 15 Apr 2025 11:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="pXYh3jNQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0EB279909;
	Tue, 15 Apr 2025 11:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744717097; cv=none; b=pVB1U4CVNuVeurm3FxqMw3LqPYINbiPphSJoL9xgueffXhURcSpwTMbMEtiBBhdJRYNdFi9aXl3NJFgzjLpnC14AgHgMNaSb4nYRdjRYilX/8D5uvs9vPi+2w7pR0nJdEcH7alf63mVNBKYIgpZxzb4c/uWm6qvE3i9pWwGiTYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744717097; c=relaxed/simple;
	bh=kjo6IRvzkCC3risEmToLUUkO8D1OU0OGdt0kp0+AUOs=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=VPzkwKlarGUQJSd6kAOFv/NWUgymxZBi+/9PLN0Akqe6qIPj4E4iktht5sooKQi1om8jZ1MWioLT8oe5fLtWt41U3lFUFwaoCwmVky42N8OwF/xIgY1bCiYGCDrTMamni0sgBOSq+35qM0exs/Zxl+LtqNMKhUw2YOFsjWU6wpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=pXYh3jNQ; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1744717092; x=1745321892; i=markus.elfring@web.de;
	bh=/AxfGj1jg7STs/RGwgUS+HXv51Pl0ygjhkUcrv2qAig=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=pXYh3jNQ1TJCVPzQjM371r664f5BVQ2TeQkkyKjwgeUIYYFffERIUY4/0FxbuYgQ
	 PR3ykC+KEkP5p8WFJXId0GAYlaJhiL6B4oKGmyPeoEQVJjxf7cOau35Bjz/dPaDzI
	 uSRrbAsP7Zq103I95xObsT9z01aYBs/Tph8tCpEtj2lnU0L7gj7HHk2hPmKQWEy9s
	 oEf+qfrAck7dwgGIN63trVD8nWQCODrwyhNXnsp714PMdadsW7tp1lISl19BvN6nm
	 xNl+H4tjf1ByUJHP1Orjl9LRTT2pAdfZEOqquI+Ow2LQiM6Xp3Z6sGMN36L5NoAxq
	 97lCtlz5lOZIJ0xCtg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.24]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MC0LJ-1tsrpx1Xi9-0028wp; Tue, 15
 Apr 2025 13:38:12 +0200
Message-ID: <e739b726-a710-400e-9fa9-ee4da8d2f843@web.de>
Date: Tue, 15 Apr 2025 13:38:10 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: vulab@iscas.ac.cn, brcm80211-dev-list.pdl@broadcom.com,
 brcm80211@lists.linux.dev, linux-wireless@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Arend van Spriel <arend.vanspriel@broadcom.com>,
 Kalle Valo <kvalo@kernel.org>
References: <20250415084239.2906-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH v3] brcm80211: fmac: Add error log in brcmf_usb_dl_cmd()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250415084239.2906-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/6LsddDbKZsIcSzN4fRSJ5GaBD9vDX/5GMxFP9ktr4jJdtLysyb
 +Re4/snWePla705EMjXptRS5FiviZ8N5oVuzcQZ5UCpoltCHh3Xg9vf2z6bdNhxHdRFvSGz
 5yH3JrD5EypBbPRYHvRAv+/ZYGstYiCjcEwH6fVetzS7yHcaGnKROM7Lt6cChBRWFQCmtfa
 vmiK5OTEpjvPZT6UBMNlg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JQF7uXTfCyk=;rDQL0ZE3gTb9ZD6utuvVq7iksrX
 yzne6f40jJFjJ0fptZJolkuanDuTikllstoFwO6wqYAmeTDGnbyAlkPDYXdpZ7KcGb1jqExQ4
 6PyTqMa7bsh6o9FlrKJMKgvQx/iqTQNtCOxiqwnppHeAQGp8ohwBTrAPpBOetGiRWje+4xuaa
 fOEnhc6gLmk6EPGa8+BR/WrCH+tt7eAJZ9s9MFDzoL72dekC4W4vGwSIb3pWQ2w3gBNG0LqhC
 tKGiG7NVABJDANJOBOcTCp2NjHVP9MhYUIK+F6wI4V939ytXEHgVoxpaKzJYXSDl9fq6uV5bG
 /Pr5MPoqVtmPAo4/A7wmXykd8UfAkRg846kosuzBibpPN5Ob42L29f18nsyjPDGwxavBezBPm
 Zh1BygWo33nfMm3nOYPp7x8JIfkABn6XxjLdT21mSB68EgM2KsQOiGmB5XoWSev4odMYP7e5e
 0PoFstG8NO8EDPpKB90MuhlD3awMVcRidSkT6x/GrT4bUsUDjgSft7YI7d9rV7Sfhkw6LaSfy
 s6CcQs/40ervuECySHc0JxFFsE/tVYQ8AnL+DQexscqzk/d5m94CbZOmr1+GQ29hXDunq7v+7
 pqCPodEGf1HGQgv2J0Ul6bHe7sIJhIxzrBwflBY8sAZZnd672DBXDC+oeJ9/UoSEz9RNJO9LH
 REOxDqDRNBEG7jB8Tk2U9mHDBcg1uHlgUYJrIbMCPULxHy2LF9NFzj3n1BYdVKXEFhRtbcDGy
 Xz61A/MiiwyKZ6Ge1ZzfMnJgH9bSDc7KnNsBV3NN9INbQe6z45+jeCrsUGnpuCrmASaMVTVYw
 4o8slr2RLOOFQL4M0i4JN0oI+vmDRhpwSsSCjN8cj5lVU2DpPdOepBk6MB3BDgCNLlHsLtE5Q
 /U3myp+NLmequ3T7xEJsezhuv+X3G4Qwm04aLTUuPmmsTkYcX9APtQmE70vVvSmHHtlj7n4FJ
 4cW/0hUWevhQAuI1DjL0m8RGUNl6qdzURevROpm+y26jCdtTF5LC6/ZuDwlmuxkRGvlhptBNL
 NtKYKEwAoFIRqdiNdXdQLf1DQGrfRWRIn9WN3otNjyrD5LjSTqknqjXdNsEkMjN25NqbAgOPa
 j66bvV9U+tZGW39JDO6IYAx+aKDkSBfnDBMHNWyOWsuO+xS0Aa9Dttgq4Pf4aRt7Cae4TArKJ
 BoybXgMU4wQY7Hp/62kwmRJtBPXssaHF+y+qCi86O1HssVlLkogrneBrYB2klNks1ADm8hUET
 lhwR0CPBq+xArAIpv/kdZ+MKlLwFAogzX9alZfIKJ9tMyQSP+nM2Psd7Y1RP4wZ44GyfLzeH0
 9BDYqlOlT9Pi43LvZ9snP4XuCLmLnIYC4dojTPF1DtZACqwZIZxzVpdTX8v+kHaxUxv6z9cj2
 pmVMnxLERaipCvcnuz0g8mTNvMSpEBYQTnD4rb4ks0HzL5nFgE3LGW3+PP/YdRa3OiKyimGgo
 Sh9XOA/uucszAabv5l17utnhV0AtKbSeQN1IR8cm+EsgunbHZgjXJRWOdusMtYZCXKSNGJw==

=E2=80=A6
> haddel its error. An error log in brcmf_usb_dl_cmd is needed to
=E2=80=A6

  handle?                                           ()?

Regards,
Markus

