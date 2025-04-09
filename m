Return-Path: <linux-wireless+bounces-21311-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D61A82035
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Apr 2025 10:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED8337B74A4
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Apr 2025 08:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F1F25D1F1;
	Wed,  9 Apr 2025 08:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="S7fkvbQT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F1525D205;
	Wed,  9 Apr 2025 08:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744187798; cv=none; b=aCHXn99YwvmHUL5wfX+GaL07HkmRvwGM+3LgJ3I6RWl4lzsx7I5LaXryOG0OTRqegOozFknYOOcQ4KNXyRTD4PO1CcRjL+SASXJQrBg6qMi/AY0cY/EgzpkjnLQNL6NXVfoKM7o3NGz/k+4rqpDpLiIv4GsoBabFtzzeeRfe+sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744187798; c=relaxed/simple;
	bh=dblT+vI1D4rLfk7GKsy2LBpb658Ll7m+QcS8Ej8/oSI=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=sNNdQVMGmUUBmz9AS1+v2czCnVATHpi9GPa5ts4YNq5hMrpm6cq6NGVv5BIIGqmJqgWOBGq04JV+WUCgk7V8wCC9fLv9dwuuAuXkCSAWS1yFbSfJPHmdAEOTlX5BtqsM5Cn2AZI9vnWE7OqkoyYvjiUa+wpvaCf+1Lb/6UtnkeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=S7fkvbQT; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1744187793; x=1744792593; i=markus.elfring@web.de;
	bh=V+Z7eSGNVbrUGyqSXrzqP4ynnA+YZ7ZSJozkKmsrnzI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=S7fkvbQTlD1nzTl05FqiI5dzwANXbniRGU+w79v5enjn5CJr30fUBylRhsxc1TiO
	 AhnG5UMYohmfpi1UPKike2Zlr5ZM7wI53fc8mHSHBI879DnduIjm83RtFZMnXe+HU
	 0wansLsjhNNfJ/elYGoFMLotFuA8D7B7nIBuCpB0DPdKp7nhKksAMuE8yW+9eEff7
	 uRr6OTGFcSbfS9TZHn+iBYBkFxL/kB9ZD7spd8oE4FZxwXwPchTZClCIVDeH96XKR
	 M/QTpNBfG6q/AaHYBvFNoit8Gbnpy8kefHzigCRFLetuY2wx91FlQGmZClDRcU3r/
	 af74e1oc2lFKZIzoRA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.27]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M4KNZ-1u2hu41009-00Eof3; Wed, 09
 Apr 2025 10:36:33 +0200
Message-ID: <7cd21e2c-0a28-4eff-9dba-e5a730aa5a92@web.de>
Date: Wed, 9 Apr 2025 10:36:31 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: vulab@iscas.ac.cn, brcm80211-dev-list.pdl@broadcom.com,
 brcm80211@lists.linux.dev, linux-wireless@vger.kernel.org
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Arend van Spriel <arend.vanspriel@broadcom.com>,
 Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
 Kalle Valo <kvalo@kernel.org>, =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megi@xff.cz>,
 Sai Krishna <saikrishnag@marvell.com>
References: <20250406084515.2991-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] brcm80211: fmac: Add error handling for
 brcmf_usb_dl_writeimage()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250406084515.2991-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DHvd88JSmsZy5sKX8NacvZmigOG3VNQUVNpwcHQckyz7fSoapoO
 Ks0mB4jb1Tls+X+Xj4H8XiNWNL4A7b96Bb+ayJlyePCCltGMInRkeBFgQSJuV4df1Mua8FF
 VozqFAB/MkxL4azAil+UBu3msy4kTMKYYaLujYyHrKdlMmU1ydvi2tQquzIv0mwudhzEouF
 owP/rlqoWsn8o0M4ch1Gg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:cxsI77KtDlw=;ADsK1gT386ZgI+QWsPqvZz55IHy
 XNiiFmbaeNQhe2xiqQ45NU+nRARK2fDBnk4t2O7YDw+DeFx8uqskZelvprtfpfT1TIGHKHy0P
 B/5RL7LC06SsV1OzoMldJqYpXn6jrrqT5BC87oTO30OyTU38wrlVhXwxom0aw85yWoxILGnlX
 Ry3Md7EnM/A+FtOzq3lkGDkTGRsDh/+GDW2XHrh04VpiqksKQf9206iNf7yJfGrassbUAT7NQ
 zfwPhqGqTlpmLSazkjkmCSX9zGc1E1RJcJOBUHgIwx1uSfh9ULRsRsAioqLdXMT+QPQAAP9Lr
 kUHzOitl5bNWz+E5Mnxp4qC9ZFZ/JudwPS8hnMKBwKm4YQgl/nDo5H/1fweDhu8xW57CIjPvf
 mMBUMg1hmSK3GY4sv4OS/Nykv3aqETzjhTVxSNoclNyZS3SmdwVWtqrP5RWvCzDZjmefCJ1M3
 Ysox/X2xdKhUl28kWv/lA7tveajS/vD1OhvRiY0CNpXj6LOpHQH1JTJE/qXvjn2PxSDHKc93X
 PXux0f6lJlvJIke2AnR/bS953T/ufO5WarP2o/17d609TnCMBSNTWTWgONKfx8+myOPZJkQ44
 x6rBOjNvgyMQq9qEa+OpGM9LOxesMZ/fp5UWrPqOdaCEkXVoSRSDFYR7WIE2y3jyzOUW/0hrV
 nAqtuYOCYEXE5bGOIUAA1rjDuiUsaZkAfz1fwkNGOwXuTbAXJaWU1wpJTltHUsnBNiLPtq164
 BGNg9A//HoWZN/Q0bLIr5rqoxTGOrKoKeFs3u1y2nr4oVSAfzkilKmqCUUd5wfo9EG29kTPHq
 OWg5q0TSsN804aVwlYOxdsn7o+grS2nHZbDqsdOswko15fNJFDFWvgM1zyY/4kb2CqT9Li1yL
 DxnzmnvWvAHEMvnYKzA78SZatQRYrU4b6Hgz34tHbWr0DRJoL248+CXRG71IVP5CU6RsQDwai
 B8gPvkGKja0LToRV1U+0m+hc0+GB3ZwFbxiab2KSmMaVHnQFqiy7M39txRS+8bDyQPL7zMRQV
 QzXX0AmT6SmzHR/Q8GZjxsdHsZpzV9kNoRbJ5a5yalaTv/QM1tThodwO2v10mQluXdRzNnQUB
 WZX19JtlZ/nK5JRdivfFQUFcXxDWnDXeofkqc075Tq3rvU0KRf5qC/vgDwYTOzHFXM/v4ri4v
 YaFabhxS6KTA48BlTSZysstgIkk2/mFyy9GbF89a+9b9qMA4OmsSEqIF/R69SQ4KqZkA8MnDS
 kIqbyWcquFFYT64W/HzoFvsKPJcJG6uFOtHq/PoxK/HEg98+ZpkiTbUycOKOqiwMdKmdzKtyd
 XUeYrFPBUx+Ozi8YSP4Ruq3/aZMgOXT5+5sRpCCeuomZym1s1YjHwX4L9QmpI30crLmcodFTp
 mDsse14J9PYUVYTfh7VWgNC6eh9lLXF2g1KPDjQI6QFONm/sUm0LGuZbifYjsZhU+ztSu4MrA
 iEG9kLLCtIeEvqLcgNssqAXwNdLOL7Up3psa/7DxN8DRkuv/cDCUw3VSnr8MwEuL+MEMQwA==

> The function brcmf_usb_dl_writeimage() calls the function
> brcmf_usb_dl_cmd() but dose not check its return value. The

* Wording suggestion:
  The brcmf_usb_dl_cmd() function is called here.
  Unfortunately, its return value was not checked so far.

* You may occasionally put more than 60 characters into text lines
  of such a change description.

* I propose to replace the word =E2=80=9Cfor=E2=80=9D by =E2=80=9Cin=E2=80=
=9D (before function names)
  in some summary phrases.


Regards,
Markus

