Return-Path: <linux-wireless+bounces-25431-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4C9B04EAB
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 05:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B3A97A4216
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 03:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90572D0C76;
	Tue, 15 Jul 2025 03:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="MD2aeH+c"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494E67081E;
	Tue, 15 Jul 2025 03:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752549889; cv=none; b=G7KL4KOoTpuIW+85QSuuG1nafteivJEm/Sww0VpCfWXRcYT/yGPN0SMFh0llN6d41z+zRD/t0NelknQ26y5vPmiIqx+ePW3OkIl5jlfT+EUjwJEjt2Z9lR/Uf6x57373nUG33nrg+KZf4SEH20o3oAXl0ghmuqYXokEjDeeJATU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752549889; c=relaxed/simple;
	bh=uKoZoBLiQvZEVv5sNgc3TbKgYExtRbQiGXxdjBdy2rs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iBgvxcPhdC46EXi/2zwLpxCXOc/HG/PqADr8iyNKqbwJwA6bmIj+L5TJfnOlzkHwE3yo06gd5Izcm51e3AfRwNPgF+isTeb8VEPCh8FFQQq4iha5SSTimXYz4ufIEPDnWBh9dzZRpsljr6bDG4e20oK9vxGoxp+rh3cAV9T/xz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=MD2aeH+c; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1752549837;
	bh=uKoZoBLiQvZEVv5sNgc3TbKgYExtRbQiGXxdjBdy2rs=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=MD2aeH+cabB/6IB9u3A9Qw3gtnnUvR2zjLbjQppgfaz0R0/HXE6EcRMPmiw1/xprR
	 C1fY2hgZDxQlUFB14K8sDKQ4fOhMzyyKnSsMY54rUNHeX35wY7H6WVn0R0QVBUT/P7
	 U16UE+Rl9+qEl2grYJpRinfZ62eUSYfeBmrLLFX4=
X-QQ-mid: zesmtpip3t1752549825ta015b457
X-QQ-Originating-IP: gPo+Rg9dBF/Wn3/8bHgVxJuFxW4nl67Kf+kTqQA0+Gc=
Received: from [IPV6:240e:668:120a::212:232] ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 15 Jul 2025 11:23:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 5126880462787841085
EX-QQ-RecipientCnt: 14
Message-ID: <C17A7B492949C5EC+1ddb2dab-9bb0-43d9-a022-118a34180a87@uniontech.com>
Date: Tue, 15 Jul 2025 11:23:43 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: iwlwifi: Fix typo "ransport"
To: Johannes Berg <johannes@sipsolutions.net>,
 miriam.rachel.korenblit@intel.com, akpm@linux-foundation.org
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 emmanuel.grumbach@intel.com, yanzhen@vivo.com, shenlichuan@vivo.com,
 yujiaoliang@vivo.com, colin.i.king@gmail.com, cvam0000@gmail.com,
 zhanjun@uniontech.com, niecheng1@uniontech.com, guanwentao@uniontech.com
References: <03DFEDFFB5729C96+20250714104736.559226-1-wangyuli@uniontech.com>
 <791111506ac7772108f00b9dae92fc4fce4217d3.camel@sipsolutions.net>
Content-Language: en-US
From: WangYuli <wangyuli@uniontech.com>
Autocrypt: addr=wangyuli@uniontech.com; keydata=
 xjMEZoEsiBYJKwYBBAHaRw8BAQdAyDPzcbPnchbIhweThfNK1tg1imM+5kgDBJSKP+nX39DN
 IVdhbmdZdWxpIDx3YW5neXVsaUB1bmlvbnRlY2guY29tPsKJBBMWCAAxFiEEa1GMzYeuKPkg
 qDuvxdofMEb0C+4FAmaBLIgCGwMECwkIBwUVCAkKCwUWAgMBAAAKCRDF2h8wRvQL7g0UAQCH
 3mrGM0HzOaARhBeA/Q3AIVfhS010a0MZmPTRGVfPbwD/SrncJwwPAL4GiLPEC4XssV6FPUAY
 0rA68eNNI9cJLArOOARmgSyJEgorBgEEAZdVAQUBAQdA88W4CTLDD9fKwW9PB5yurCNdWNS7
 VTL0dvPDofBTjFYDAQgHwngEGBYIACAWIQRrUYzNh64o+SCoO6/F2h8wRvQL7gUCZoEsiQIb
 DAAKCRDF2h8wRvQL7sKvAP4mBvm7Zn1OUjFViwkma8IGRGosXAvMUFyOHVcl1RTgFQEAuJkU
 o9ERi7qS/hbUdUgtitI89efbY0TVetgDsyeQiwU=
In-Reply-To: <791111506ac7772108f00b9dae92fc4fce4217d3.camel@sipsolutions.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Tbdwz2Q3DgQFtomI7hfmjYVm"
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: Mm8VRyTxzGuAoZe/X649Ny1sD9hfMKoEjp/sEXnbOkJsRI+zgmJ/ZVJ1
	lnKAKqfJaE7fU9Le+LVTaN366gAY/lryxA6LLGCWX5WYrBosCHKZF42lxSknBPcvwdDqgJw
	VbqpZBPdZDTaIy2xgD5jMD7LLsb/UUUGXa8Z4nvLggiCoLfEJ3mgFg1QFANyLJgfcCi19Is
	KinvfgF9XKK47xRdJjWxl4ZSRVWX/UMIkIHn6ca9IyDSCACx/iYQ+KSgRndZw5GI8u43ENY
	pk5B5GW5mwG+QX1BDPLw9JnloyMGu3X3SDxkSDZ5qkcsG2ro4HzbLCDQSuz6WvIaNk8ASXl
	3HPEZ+K/gcWi0/S7UG3/iwdlZgI5893Vmfunpas/62hjA2mM0D3usFDdMP7qEij0bLwH6Es
	8o3dVaLUaYP8WKOcJ1GHZxhikDLK4eyrADmgPaOLN7h7FMHMuwncGgRKD4apNGigD/fXDZt
	yME6LmkGLl4jAiwxNZ/0NM3cV0JIdrOaweaITPevlH0/wfqAiJOFg0NqE+croCmdXJnDG8C
	IpR5Kgo2WR6hhoQaG4qLfs9wG789bEc/O6cEmCJiX2509wYLwEyehbdn5E8PkiOA6FhXi4B
	nJG2Ylop9oBNy/g73mvJf+voAQ74bL+ukC0dESuC31encRb7Fk/NLkRzSUCYMHsktQV00AE
	kIFZl+enyxtBvfWAgditkLd6o713Jkv4/trhCxwNHatIYyFnWXCTaQ1io1PteoyHVWSVuLR
	/ziPLTuwSieHWKxlp4KskrlRVzG7Q4ik3DP4PAMp/GJ787LvuwX0ZAAr7iPNI724IfTNyOB
	pw1hOELQq3LkgVMMeotgOl19XIeGSXqYOrRyNIYbKgB8E/hiIyNP6yHr0GJNDlYFFL1IQBA
	a/dRaLeMP+PSkD4Wpw3lK3si+oGn0+3WV0JGmEc7C+IWRhhGDu/3dsv0E8054vQA+ucIaIj
	JdSXEzms+lbvA15G+LbmlSy3s5iTPSjZqeb8Kl3Odl2oHHvP9ZVpO0avsiV2kq1OBsAxWYO
	3IEa41sLRVbjvu2qdwJRczUw8kOGkZD9nQgcqXKpfamhCUMiRswL23CYHHwQRf2E+7q3ykP
	Q==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------Tbdwz2Q3DgQFtomI7hfmjYVm
Content-Type: multipart/mixed; boundary="------------0DXW2O0a7QW4e1MkvyHJ6BpX";
 protected-headers="v1"
From: WangYuli <wangyuli@uniontech.com>
To: Johannes Berg <johannes@sipsolutions.net>,
 miriam.rachel.korenblit@intel.com, akpm@linux-foundation.org
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 emmanuel.grumbach@intel.com, yanzhen@vivo.com, shenlichuan@vivo.com,
 yujiaoliang@vivo.com, colin.i.king@gmail.com, cvam0000@gmail.com,
 zhanjun@uniontech.com, niecheng1@uniontech.com, guanwentao@uniontech.com
Message-ID: <1ddb2dab-9bb0-43d9-a022-118a34180a87@uniontech.com>
Subject: Re: [PATCH] wifi: iwlwifi: Fix typo "ransport"
References: <03DFEDFFB5729C96+20250714104736.559226-1-wangyuli@uniontech.com>
 <791111506ac7772108f00b9dae92fc4fce4217d3.camel@sipsolutions.net>
In-Reply-To: <791111506ac7772108f00b9dae92fc4fce4217d3.camel@sipsolutions.net>

--------------0DXW2O0a7QW4e1MkvyHJ6BpX
Content-Type: multipart/mixed; boundary="------------7RiO27RoJcoxc10bLXJOUvvz"

--------------7RiO27RoJcoxc10bLXJOUvvz
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgam9oYW5uZXMsDQoNCk9uIDIwMjUvNy8xNCAxOTowMiwgSm9oYW5uZXMgQmVyZyB3cm90
ZToNCj4gSSBkb24ndCBrbm93IHdobyBtYWludGFpbnMgc3BlbGxpbmcudHh0LCBidXQgSSBn
dWVzcyB3ZSB3b24ndCBtZXJnZSB0aGF0DQo+IHRocm91Z2ggb3VyIHRyZWUocykuIEFsc28g
ZG9lc24ndCByZWFsbHkgc2VlbSB3b3J0aCBpdCBmb3IgYSBzaW5nbGUNCj4gaW5zdGFuY2Ug
YW55d2F5Pw0KDQpPa2F5LiBJJ2xsIHNlbmQgYSBwYXRjaCB2MiB0aGF0IG9ubHkgZml4ZXMg
dGhlIHNwZWxsaW5nIGVycm9yLg0KDQpQZXJzb25hbGx5LCBJIHN0aWxsIHRoaW5rIGl0IHdv
dWxkIGJlIGJldHRlciB0byBpbmNsdWRlIGl0IGluIA0Kc3BlbGxpbmcudHh0LCBidXQgSSds
bCBzZW5kIGEgc2VwYXJhdGUgcGF0Y2ggc3BlY2lmaWNhbGx5IGZvciB0aGF0Lg0KDQpUaGFu
a3MsDQoNCi0tIA0KV2FuZ1l1bGkNCg==
--------------7RiO27RoJcoxc10bLXJOUvvz
Content-Type: application/pgp-keys; name="OpenPGP_0xC5DA1F3046F40BEE.asc"
Content-Disposition: attachment; filename="OpenPGP_0xC5DA1F3046F40BEE.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xjMEZoEsiBYJKwYBBAHaRw8BAQdAyDPzcbPnchbIhweThfNK1tg1imM+5kgDBJSK
P+nX39DNIVdhbmdZdWxpIDx3YW5neXVsaUB1bmlvbnRlY2guY29tPsKJBBMWCAAx
FiEEa1GMzYeuKPkgqDuvxdofMEb0C+4FAmaBLIgCGwMECwkIBwUVCAkKCwUWAgMB
AAAKCRDF2h8wRvQL7g0UAQCH3mrGM0HzOaARhBeA/Q3AIVfhS010a0MZmPTRGVfP
bwD/SrncJwwPAL4GiLPEC4XssV6FPUAY0rA68eNNI9cJLArOOARmgSyJEgorBgEE
AZdVAQUBAQdA88W4CTLDD9fKwW9PB5yurCNdWNS7VTL0dvPDofBTjFYDAQgHwngE
GBYIACAWIQRrUYzNh64o+SCoO6/F2h8wRvQL7gUCZoEsiQIbDAAKCRDF2h8wRvQL
7sKvAP4mBvm7Zn1OUjFViwkma8IGRGosXAvMUFyOHVcl1RTgFQEAuJkUo9ERi7qS
/hbUdUgtitI89efbY0TVetgDsyeQiwU=3D
=3DBlkq
-----END PGP PUBLIC KEY BLOCK-----

--------------7RiO27RoJcoxc10bLXJOUvvz--

--------------0DXW2O0a7QW4e1MkvyHJ6BpX--

--------------Tbdwz2Q3DgQFtomI7hfmjYVm
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQRrUYzNh64o+SCoO6/F2h8wRvQL7gUCaHXJvwUDAAAAAAAKCRDF2h8wRvQL7ibM
AQDGWcfZkqVU64F7e61SS7NixPc8/4R+RtEQ79AksTIYnAEAzR/dSTajpnigXpVYN3yNQ4sPjNi2
0w70OOsX7xXDBQk=
=9qDJ
-----END PGP SIGNATURE-----

--------------Tbdwz2Q3DgQFtomI7hfmjYVm--


