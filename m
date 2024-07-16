Return-Path: <linux-wireless+bounces-10265-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF16932976
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jul 2024 16:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E141D1C22B8F
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jul 2024 14:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62AC119DF86;
	Tue, 16 Jul 2024 14:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQ3/nhHI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C5F19D06B;
	Tue, 16 Jul 2024 14:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721140605; cv=none; b=A+nQd+NSJ9Kn7+d8HSCKV8KAuqJuGqinxrRLSfVMJgZrxe7yGc/FYqYQiKum8D5BymgoxQ5ogIWQxIOZsZcMDVBmYvN9LUZtaaXTVVAUsKOYLGYh5HhWYWIzc7Ytnp0SstWIETXzE9GdD73jBS6paRAbkpc6MqvLZVJYhgthjX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721140605; c=relaxed/simple;
	bh=rh/F+QHKEAkTOiReTIKrvCHD3pmWrMmymqO9bdbCLk0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=WZ/8FVWxM0e1z/lT7rRL2fyX6ik7x4yiDZv+6JSwIizRIPT7GnfuGSGZlbmBveA7yoFF6q5eivztIXxzxC32GQ6Dqkir1GukKX1uKxEalu4EfjpGMgDlihp9rmPTdnjweLh3Cds6eus0WwKKjePjOja1f1eUfNGICsIvuJUuv9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQ3/nhHI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99799C116B1;
	Tue, 16 Jul 2024 14:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721140604;
	bh=rh/F+QHKEAkTOiReTIKrvCHD3pmWrMmymqO9bdbCLk0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=OQ3/nhHIWj50RgNy0e57bnILEnJCTdv6PTadddklumZfgwIbpX4I2snJdhoGGTGuk
	 FRoTAmJSG01DaoW1c2+J4pAhEY/js7lZdfBfm48OFp89OEdsWQgQNEwJ/WKEefLGNg
	 /Ibd961fRNyySJmKIQPGpx8vbj5xfkSLDq/Yi3nf1kY59kYN1sPMTIJU8c4Nh1oaBk
	 9sKWCDJGB8IcySC4EoOAT3zQJuHKzcBWbAgBNP3PYgV69HQLf1TfaPbVu+w6w9kNeQ
	 QmJr6AlIPSZ785xXRxGt41PKvk5n1bHVgxyVxCQ4lyDFXYoOHJhbrbyymwRBg+E8dA
	 Wdo1Or2+VeELw==
Date: Tue, 16 Jul 2024 07:36:40 -0700
From: Kees Cook <kees@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, Kees Cook <keescook@chromium.org>,
 "Paul E . McKenney" <paulmck@kernel.org>
CC: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
 Baochen Qiang <quic_bqiang@quicinc.com>, linux-wireless@vger.kernel.org,
 ath12k@lists.infradead.org, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net] wifi: ath12k: fix build vs old compiler
User-Agent: K-9 Mail for Android
In-Reply-To: <93d282fb-4691-460a-aa5b-13e9ef054cdb@quicinc.com>
References: <3175f87d7227e395b330fd88fb840c1645084ea7.1721127979.git.pabeni@redhat.com> <a7950e7b-2275-4b6d-b8e1-4f50d0bc28e6@quicinc.com> <93d282fb-4691-460a-aa5b-13e9ef054cdb@quicinc.com>
Message-ID: <A4FF7C44-06C7-4241-B33E-1E9684A979E0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On July 16, 2024 7:03:55 AM PDT, Jeff Johnson <quic_jjohnson@quicinc=2Ecom=
> wrote:
>On 7/16/2024 7:00 AM, Jeff Johnson wrote:
>> On 7/16/2024 4:06 AM, Paolo Abeni wrote:
>>> gcc 11=2E4=2E1-3 warns about memcpy() with overlapping pointers:
>>>
>>> drivers/net/wireless/ath/ath12k/wow=2Ec: In function =E2=80=98ath12k_w=
ow_convert_8023_to_80211=2Econstprop=E2=80=99:
>>> =2E/include/linux/fortify-string=2Eh:114:33: error: =E2=80=98__builtin=
_memcpy=E2=80=99 accessing 18446744073709551611 or more bytes at offsets 0 =
and 0 overlaps 9223372036854775799 bytes at offset -9223372036854775804 [-W=
error=3Drestrict]
>>>   114 | #define __underlying_memcpy     __builtin_memcpy
>>>       |                                 ^
>>> =2E/include/linux/fortify-string=2Eh:637:9: note: in expansion of macr=
o =E2=80=98__underlying_memcpy=E2=80=99
>>>   637 |         __underlying_##op(p, q, __fortify_size);              =
          \
>>>       |         ^~~~~~~~~~~~~
>>> =2E/include/linux/fortify-string=2Eh:682:26: note: in expansion of mac=
ro =E2=80=98__fortify_memcpy_chk=E2=80=99
>>>   682 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,        =
          \
>>>       |                          ^~~~~~~~~~~~~~~~~~~~
>>> drivers/net/wireless/ath/ath12k/wow=2Ec:190:25: note: in expansion of =
macro =E2=80=98memcpy=E2=80=99
>>>   190 |                         memcpy(pat, eth_pat, eth_pat_len);
>>>       |                         ^~~~~~
>>> =2E/include/linux/fortify-string=2Eh:114:33: error: =E2=80=98__builtin=
_memcpy=E2=80=99 accessing 18446744073709551605 or more bytes at offsets 0 =
and 0 overlaps 9223372036854775787 bytes at offset -9223372036854775798 [-W=
error=3Drestrict]
>>>   114 | #define __underlying_memcpy     __builtin_memcpy
>>>       |                                 ^
>>> =2E/include/linux/fortify-string=2Eh:637:9: note: in expansion of macr=
o =E2=80=98__underlying_memcpy=E2=80=99
>>>   637 |         __underlying_##op(p, q, __fortify_size);              =
          \
>>>       |         ^~~~~~~~~~~~~
>>> =2E/include/linux/fortify-string=2Eh:682:26: note: in expansion of mac=
ro =E2=80=98__fortify_memcpy_chk=E2=80=99
>>>   682 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,        =
          \
>>>       |                          ^~~~~~~~~~~~~~~~~~~~
>>> drivers/net/wireless/ath/ath12k/wow=2Ec:232:25: note: in expansion of =
macro =E2=80=98memcpy=E2=80=99
>>>   232 |                         memcpy(pat, eth_pat, eth_pat_len);
>>>       |                         ^~~~~~
>>>
>>> The sum of size_t operands can overflow SIZE_MAX, triggering the
>>> warning=2E
>>> Address the issue using the suitable helper=2E
>>>
>>> Fixes: 4a3c212eee0e ("wifi: ath12k: add basic WoW functionalities")
>>> Signed-off-by: Paolo Abeni <pabeni@redhat=2Ecom>
>>> ---
>>> Only built tested=2E Sending directly to net to reduce the RTT, but no
>>> objections to go through the WiFi tree first
>>> ---
>>>  drivers/net/wireless/ath/ath12k/wow=2Ec | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/net/wireless/ath/ath12k/wow=2Ec b/drivers/net/wir=
eless/ath/ath12k/wow=2Ec
>>> index c5cba825a84a=2E=2Ebead19db2c9a 100644
>>> --- a/drivers/net/wireless/ath/ath12k/wow=2Ec
>>> +++ b/drivers/net/wireless/ath/ath12k/wow=2Ec
>>> @@ -186,7 +186,7 @@ ath12k_wow_convert_8023_to_80211(struct ath12k *ar=
,
>>>  	if (eth_pkt_ofs < ETH_ALEN) {
>>>  		pkt_ofs =3D eth_pkt_ofs + a1_ofs;
>>> =20
>>> -		if (eth_pkt_ofs + eth_pat_len < ETH_ALEN) {
>>> +		if (size_add(eth_pkt_ofs, eth_pat_len) < ETH_ALEN) {
>>>  			memcpy(pat, eth_pat, eth_pat_len);
>>>  			memcpy(bytemask, eth_bytemask, eth_pat_len);
>>> =20
>>> @@ -228,7 +228,7 @@ ath12k_wow_convert_8023_to_80211(struct ath12k *ar=
,
>>>  	} else if (eth_pkt_ofs < prot_ofs) {
>>>  		pkt_ofs =3D eth_pkt_ofs - ETH_ALEN + a3_ofs;
>>> =20
>>> -		if (eth_pkt_ofs + eth_pat_len < prot_ofs) {
>>> +		if (size_add(eth_pkt_ofs, eth_pat_len) < prot_ofs) {
>>>  			memcpy(pat, eth_pat, eth_pat_len);
>>>  			memcpy(bytemask, eth_bytemask, eth_pat_len);
>>> =20
>>=20
>> Duplicate of https://msgid=2Elink/20240704144341=2E207317-1-kvalo@kerne=
l=2Eorg ??
>
>Let me add Kees & Paul to see if they prefer your solution

Heh, yeah, that works too! Avoid the overflow via saturating addition=2E

Reviewed-by: Kees Cook<kees@kernel=2Eorg>

--=20
Kees Cook

