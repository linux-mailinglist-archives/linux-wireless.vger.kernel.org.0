Return-Path: <linux-wireless+bounces-27829-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C61BBED07
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Oct 2025 19:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B75774E7613
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Oct 2025 17:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F8923D7E7;
	Mon,  6 Oct 2025 17:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="ugRtv0DM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CF323F42D
	for <linux-wireless@vger.kernel.org>; Mon,  6 Oct 2025 17:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759771727; cv=none; b=Dqzv/mbPjaNdhubYd4DS6LZsbKkTtqFnNiQsgYISE5fXxpjMtXFnIa8EQOn15bAnjghvPLyDLISb7D+GlIOvlKN5huretFJHynhDKdEFRI8M/YPUpQzcyIQ7eeLf01ruPUOVgwBrbrCS9NwdAwuyVUxhWf3fW537csNRpHcRf/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759771727; c=relaxed/simple;
	bh=uOx+j2RDF/ZC1EU6pFXofoUvpumHlDx0H4zYn6o80GE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rM6FUFiXNCYEoqtm7b22qIG2/GWrfUYVcMG5Y9T8Ih0jukkqBGFWBv6lMQFO7HuokjLxIheeMvISK85gSL9GXmmAVLcb9wnCxeEjaiyJDrPE/ex9bliC3d+luB7j32k4P8aRBrWJV6V8PqX+fY/joHCRAeNKs4C6Jot8PyQU7fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=ugRtv0DM; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1759771716; x=1760376516; i=wahrenst@gmx.net;
	bh=mrugMrB0bWTPWh8s5zjUzAcpKRApGUmtqTGmzwU+MOs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ugRtv0DMkjgbWOaNvCA9LNIQWrlps3kJyEtNVLqYdYHO/b6/25xnTHK7Sx/DUk6t
	 a6ZagwYBRe6sif8kxljshxhPqMfW/UIqLewfEdB5xgwP9DQ5w8FtHK+7mn+0/VVxC
	 9FRb3QbRSLzTJJdSxS4X1jf+i+jrHlgsyIlNqXGTGAWeUxYQfNUqqjbQdI5KU0QUY
	 /vSc7wKJvbUUsxLj4tXIrb10eFFDgt4RtVLY2p41/h0GpuTDnosjrcg1OP86KuyW/
	 qejVLX2yFW0ve4gd/3ZJB5gSBsRX3Bo5zF9j07uO+wWY8/YKhcKbiM7nkr3XDUDW8
	 QP2XnF7K+EcL2HC7dw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.156] ([79.235.128.112]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N5mKJ-1uBjnb2wLD-00rBU4; Mon, 06
 Oct 2025 19:28:36 +0200
Message-ID: <281c880e-9e7b-4826-a275-0d02a040a37c@gmx.net>
Date: Mon, 6 Oct 2025 19:28:36 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] brcmfmac: Fix NULL pointer dereference in P2P action
 frame handling
To: Richard Reigh <richard@govivid.ai>
Cc: brcm80211-dev-list.pdl@broadcom.com, brcm80211@lists.linux.dev,
 linux-wireless@vger.kernel.org,
 Arend van Spriel <arend.vanspriel@broadcom.com>, chris@streetlogic.pro,
 s311332@gmail.com
References: <b2e0bf04-f149-4a23-aba5-cad55a8923c1@broadcom.com>
 <20251002232002.124609-1-richard@govivid.ai>
 <199aacd7e50.2873.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <d1510cb6-a613-4e22-91aa-4fee1fdfa29b@gmx.net>
 <1bb08036-2569-454a-bd26-f1d713b4c299@broadcom.com>
 <f0352cba-0810-43c3-9c53-baa012f93513@gmx.net>
 <CAFwtOaWsS5U-gb3=DM0QZ6MuZgAHV-O-qLtC9-npQEjGsog1AA@mail.gmail.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
Autocrypt: addr=wahrenst@gmx.net; keydata=
 xjMEZ1dOJBYJKwYBBAHaRw8BAQdA7H2MMG3q8FV7kAPko5vOAeaa4UA1I0hMgga1j5iYTTvN
 IFN0ZWZhbiBXYWhyZW4gPHdhaHJlbnN0QGdteC5uZXQ+wo8EExYIADcWIQT3FXg+ApsOhPDN
 NNFuwvLLwiAwigUCZ1dOJAUJB4TOAAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEG7C8svCIDCK
 JQ4BAP4Y9uuHAxbAhHSQf6UZ+hl5BDznsZVBJvH8cZe2dSZ6AQCNgoc1Lxw1tvPscuC1Jd1C
 TZomrGfQI47OiiJ3vGktBc44BGdXTiQSCisGAQQBl1UBBQEBB0B5M0B2E2XxySUQhU6emMYx
 f5QR/BrEK0hs3bLT6Hb9WgMBCAfCfgQYFggAJhYhBPcVeD4Cmw6E8M000W7C8svCIDCKBQJn
 V04kBQkHhM4AAhsMAAoJEG7C8svCIDCKJxoA/i+kqD5bphZEucrJHw77ujnOQbiKY2rLb0pE
 aHMQoiECAQDVbj827W1Yai/0XEABIr8Ci6a+/qZ8Vz6MZzL5GJosAA==
In-Reply-To: <CAFwtOaWsS5U-gb3=DM0QZ6MuZgAHV-O-qLtC9-npQEjGsog1AA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FLyCt9RAV15rEBdNwgjUh7kS9klL+VC2LInvTW8uX+3/mKZ87Nr
 TKCfxvkTmNn9RU6rhwbR910fFh2Z6MXfq5o5cV+/1eUJ4xMEy2kLrsigG9TUhFK0bbDAjWx
 beSyGqnoTXlY5zKGn+0FoVQwCSYdt2198YxGd7wdIDWZOqnr9WVRbVCHRvVvnwkFDFkT4cf
 ElNrctwBj+/ipyATgd4Vw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:C/+qA9Rm1tg=;RMo7dMUo05B59NMyV5PDX8DCk3h
 17c8pNRv/mDZ+TA9FNbRfCJmTQJqwhgDdz4lWfDPFPKuj8qdC1tAsiqM6HjnIWwhBoqMIjcTN
 O3Y+MLPi7S8XD/39fR0tJaX1igyAfAk1fPb8Y/dwBv+eqRe+zrDAp5Ug8QHvwTtqgfdQS2nON
 rEDCtYA8AevL11kkWR1mWnBEf+cNIxBFkHtCuE/CkmEEqx1Avplw3KRmBYTovT6P5bSaaicZp
 wYx+gYWomHths1gLoBdjGSIdJry9hji/V+evklq/Xs5hJ7sjq/YfV+8HTfOW/MVE5kyJHY573
 yI8ihVs2eyV2ixy5S5ie0VyNBh7D+ZoGe+znhs1BonAXjaFWu7upPPCOtLUL+UOP3wdS0q5rm
 8mZQA7i95ozyAZKhsbwSx1E7Dri2ZM3nu4+bE1kS0KkBSnLkSabo7W6bauEkXRcGm/piJ74OF
 Km8UStiY/5Cur+JKN3lUuZ75eqCCzIQN4Yz5lEvdApO6kmmoxO6pPTJHhthIaS6GunIeIxj2v
 orAdy8Tv2nHjWPuJYldpL5Y3XrdMTj389BuLSI9hKy4kUj0H2MXEF7Cl8g/WrCkQq4ZQ3tkDC
 DJW2skxw+MVeiTZGky0xYLpnVg+sam4wQquiOdc45ZPF+UW8DWzKZFJ7FMDR73DTsGxwfkVeA
 eWOVDhcXcAZu+h+SvFnzGH3LZtT9+qKJRNcahXaywLC6O9ka/0Kq+pgsFQy+14TWj2+33OWRH
 vGJySrlwnMZ8ZzziluT74H45J79UDhQQWKDLI+pSFDnvd/D3LcSy/vVtW1KgvcGveGdqwU8Pw
 J+gSZS4A+7tgOKyYYDe4ZpJBwnJuwWJzWz2cmW5272bzkNH8ZUMmXe8SznxE6gF19QpiuLyIy
 BKqR9MFK12yNp0CtWfOluswrILTAgfoHQDlhoudFhDi4onPO+okN67sadMl315m3TiHZjM0ya
 RbHwmNPk6XTfgibWbWgt18kmrbn5hwGXaGUmSo1nbu5z3aEJEwIndH4mGX94M1BHFFXKdnwzb
 NppKufl2RWJsPfmjVt+6xw/Bd+tPN5UdsLwKUp1a8yhoprpKFcivXp8H//aP1fMEVa041PWpx
 TQSDxbdasacdxYpLZ+5MhobMia1HzYYwC0q6Bs8adOaMUTUrhnbsYbaRU2W/fNRCj2rWIuFBH
 17Ph2iPwXU60sC9f72LXItQezHFnyNoR+0QsYm79JIBUdOQyLvtTZdNoMIXiFb0sFbkIl7l+k
 44Mg9WlpTc2PyIiyMpKiPqW2UdTYhj+7hO+yBUg8WoETQuih8AWU+w0tLVOjRvqa+L4dMdctw
 wcoF1OusoqkVd+SEAubSDMnvYMO6wtqmYjx5M0D7RMmJLthmA7ZLzdEs3pdPv63paX9YWi9Ox
 +rjgozjQW9II/A2amEGk5wBgGcmHBja7WtQgA76ao80DhVOPs2qYKrsCqkRUU1G1YtpfrUOse
 hZhDOtEegtXuDRTsxwDsTSnwvYQCc3XsSfaZ+cuVXzwuKuj+g641zBasTlAHpRByC5h+AyraN
 xL9Nf1dJNr5tuhVFL2J2H92Xx6ACU0llc0q6ZuTOEjYgkjW49vgyQs12NJbdO37mUjHX/psku
 fWEOsEpyFFVvq8NvI7Tvai1nt9Qs5apwr9GLNl25pE+9MN0TqHbgydvPUSMxK+LBR7DYduxnw
 VzMbi3svu4Dwn2SON2PXSwkcF4rB6XkAssRNNL/oPwVa3rs+88rpYqtu3c/r3aLaMHhXQhcrS
 NV9x+9gdYI4lV9njMwpj5TxL7B1pW5MtdYLVsmg0/AoFttOC0n4fmZdP6b7V3uqtVDWPKxY0t
 qfDV6IlA0H+uJJpBZ2coSf3WcgckdUNk/GLTUADb/EseigChlyoY1YRYtkfNVdJ6yF0PTwCnr
 CgN2ajBI1/Ds4C6nzD/w5Px7KMueEx5E661SqXBol3HCGnzLFp8FUFsyDhRYeyDEIjSZCMXaW
 iMPDjNulZC6cN8QXwe7nLZrwLLostL0VtF0zeX80gTe1zHxDV+awWOoGT2/DqVXOmU/3z6wut
 aEnThc0iFgi9p/E+QtVckfMVQ78NhiUcQKgS95g68A/ivcD7h6klEIln4mVy6QtXYMbdxQwGE
 WnAkO1I7zKBwuW8vFOWuucmeOMTRWN3vhxl2cCPXhC+Ce5d+3he0p2yUvPLFQWUAtbMXbWAcU
 AWEIT5eNL9whs3jxP4oV6b43fYyj3sqnxsQ8/jkY61PfH/vB/OtEvn8pZN2K8mVtOyjprS6bd
 8dpoZnW2w9bD55Q59Fv6cNxQyFXvRpeTG/G1TzkhYHYtde7AmIUzDGEyzjEQZ3zZwxApcMg3N
 xovxal6JlqigAFHJHiTo320vkHG/RCg8R6VjTZSbZY3xIGXVexob1FbLzlrkEGJeC1e9jt/Ad
 or5zcnkA8hTiKgUh2sL1949v0ynTpenfnJ5+xInR1jkEbBHXBNGv2/CPeAqx6+jwPC7qGWZ8K
 XVzbRJ79At+cs0rywZ7ei5+8m5I/NSQLzIadADAKhBZW0KXfoACTGmCmFpnIMBpHM4nzFLGBd
 7oVR6NN9vGbOSHzc9T8Xs7dUfCKOmIeps40zSm58PM048YB8PWSonu1St4uk5v4RgBVk4mMpu
 z2eyaZZuNA/dr5xH30CAJr3v+3tcydBESiBOcGSkJNNTsPRkWKztJhieWkaol+ZgPijLc7eJK
 +xKBLlIfconRuznYLD+E9w7MK/8rs3a/BtfY7Dlp7b+AMesb7ayDAGDG1X5ZTG35J6EpI5FgQ
 oYP62zZVhIexBz0kk6dwOTUi/kVX38Di0Tmvw25HaV/5EtKCpm1xuofGWDZZm4HN4xnvS1JNV
 eJhhJbTyq5ET6+XiE9YNfImXZo1LnkRrsgVwEgPrgv9ZvwiqVzi4dkTSp7OJTUEeQdzzIGCXl
 c8Vo4Q8iUrhhOe+WxQa4oEtyFRwM7cayNja8pRYn2lfi9eBoajkPOCbE3qInYATQwzoImS8Q4
 gMk7ftppbhihl5qimFc7YAsWVW+lKm4QuK4bEZemaoN4I5PWnGp5icQyD6bNM6G2wRXkxiNl3
 f15QCho+JCHuvRNqXm88NZqEa+T+8eMf+4206kZ6hdv03YemYeCK+irZ8ymU51AaPwdM49WkM
 7lhmDe8qmpMcGybnqqnvcdaDLfG/RRp41ua4l+v8v+YG4djL9FjHSba3M/SVkWX5aOieJeAdK
 cD99LwhdVRR5YxKw20W+glYbUD5D9Dkwt+ZHHc1k7Nxqjfm6unvOiseh6qsHPtGakwgintuGk
 +Vebb6QmZBBT+gqY8ilu4h4088NIEiEupBESB2KsMF3N7dUowbBCw8L+uV5P824kG+KAii8Rb
 kSxlPb23juMqV8OOBfvbjjKR27os4BjC44Vz0NXVKQZQWZEnIYjINx0ERUpk9reKQIh9e4cds
 URGXA/X0ObSlNkR/4hd8mLRHb5QLxBMAfj0ve8I5zEm1nx98ow1pyXGihDGeYTjkSQSrY6STb
 uooQWE/ymlbgbcK/VAgZ1eOenMOE1qXpwh5+lfmoiQyo5xwvfZJJtKJfKtkxNXvbCoQrRwE6N
 tiVhxUYZgrHGaXafJXIEnSmBlbw1l4x9BmxyBtJwHS37FDdjsyAgP+q0TDJTGbGBw5llwxfnJ
 wGdnDP11aTK0a27xYXt0op4NYBkLz2fEyFodU6J6dTsgxjRwPraJtxAD+sOgkXEFY2v3LsKMH
 SYRydOV0V0DozS6TsHWg2TpKrlb2UqOa0HmHcPRgpE54ABq5LBQELLQqusilU5pn5ZTig9A2e
 DiHNDClP9eq4OW2vx5uYDbFCpb1eEVjSPx5EkBGWUJsRM7ZELtURWy7gORbz0EznwFVgtk9cJ
 IR8qgUS4qNkLFUXBSI+2k7p/v7lAtNzgY6xQKkCK5OXkgLcbv2WDCCgl9Huv70AQxu3Kc0MlM
 04I0hVo8bbsroQDcobWdod8r1HGZ4WyuXYiqqGxhF2HKfto+Cd5XLPZX5f9bEd14iNmuWWEw2
 Xy4cwW0uKJ6rl+KOHwQ4UFG1VsGEQYmbl0MRb8JgE5MSSmwrKDyLO7lm4kPM6CTsDXtCv0jfB
 8zWuGjCeNfZGHJo/Fkr/rR9ZkVrGQRNF7yTBZpu8MDHKqiKCnsQrvapGUdb/rwPjaD0BRLc3l
 pTpxhFFHePTgJQ0tWppjZMzJw6/Vxc43lGEybmZmgKc99YZ7XDBM+0ig5lUmx7psqlMGaNuTz
 gN8OjkoN4uBuXHhkmte248E0ZP32vPUVZGCQqY9kuafCdEiKAIN/sT7Xzia5lrOR9CCwaz2o1
 U2CIduHgFfMQVxSrjdDT+ASDteIWMgbERFq3/Y1WStl5Xf95gyCkGFBA4sgS0M9CLwKX2LBPy
 GZ6rVzzlvuvCpdG1eX80aFxJqlBYuORCB5nAa2wdRPo4xWQWMsHraba4fEHdcejp83u5f0sHM
 O0aPFpntD6bh8I/J3paqrQZUzZfv53Kd4ORfYljwxHjwKhFGWqkh/UCHDe01abo+dk+2Wag3+
 PihhXwY47F0QK1a5rFSOvlbanqFnxKh0VUOLW6e3JfrFLabQLhbG89DLjQGNRsAnFJWsgY7Um
 AW957tHiR3HGI1i9rxBQ6dQa7jczxLSwQBDfBMFLhrPNjz5pIgqcEy+mRuCxI3wBeOAzeRZ81
 AUCvy2Fy0XK5Aq2/VePTpozTqs561ofYIqlyyzDX9CQMgrp0cDOdjh6xRskT1AVnpAeCEfV5o
 7i6Iy0gDqggEdRQg+LT975voVQTqTf+Pwphb8cCgtpWIAsFEtGga3d2ep9Pf90QRzhxfGkolY
 qRmBaIzWvU5wE2p/BTS1nL++ydWYwBrD8771+DB9xDqQQRYT5qLRMwFqL4W3D1LVqlT3ACPIx
 X+WfpMoOiqvW040yTfswQl5b4Nb8/hEWBD3mvGhTzCfpZChvF+IxcJizVSxeGM/yUH8Yb/N0Q
 rcBKPwJNNMIZx+xhKr35xYtwDBbMvYVRnU45wjWfktN60pbe1uLaIIftxVidRQDZ69UqXO3Rp
 yFnl+bglZxg/2ArkcRc/0s70kllfpVhNERmdmfarrnlmMH1Wyli2JBvftYt4PK7wMbalnYkPu
 osxOkLsP81dbaOxh+Yoe6G5Du78fc3UoyfWVFic6CFtj/NjA5KNOKcrLK7bKghi0NesX1OB3Q
 ojy8ayDrJ44dZrlTpzKoehOZBeXCuhmwn2wnEB

Am 06.10.25 um 19:08 schrieb Richard Reigh:
> On Mon, Oct 6, 2025 at 10:47=E2=80=AFAM Stefan Wahren <wahrenst@gmx.net>=
 wrote:
>> Hi Richard,
>>
>> Am 04.10.25 um 11:22 schrieb Arend van Spriel:
>>> On 10/3/2025 7:02 PM, Stefan Wahren wrote:
>>>> Hi,
>>>>
>>>> Am 03.10.25 um 18:00 schrieb Arend van Spriel:
>>>>> Op 3 oktober 2025 01:20:21 schreef Richard Reigh <richard@govivid.ai=
>:
>>>>>
>>>>>> When iPhones query network information via the WiFi settings "i"
>>>>>> button,
>>>>>> the brcmfmac driver crashes with a NULL pointer dereference. This
>>>>>> occurs
>>>>>> because the P2P device vif is not initialized when handling certain
>>>>>> action
>>>>>> frames.
>>>>> That does make a lot more sense than the line that gdb gave me with
>>>>> my driver rebuild attempt.
>>>>>
>>>>>> Add NULL check for vif before dereferencing in
>>>>>> brcmf_p2p_tx_action_frame()
>>>>>> and return -ENODEV when vif is NULL. Also modify
>>>>> Now I don't think it is necessary to bail out here. See my
>>>>> suggestion below...
>>>>>
>>>>>> the retry loop in
>>>>>> brcmf_p2p_send_action_frame() to stop immediately on permanent
>>>>>> failures
>>>>>> rather than retrying.
>>>>>>
>>>>>> Tested on Raspberry Pi Zero 2 W with kernel 6.1.21-v8+
>>>>>>
>>>>>> Signed-off-by: Richard Reigh <richard@govivid.ai>
>>>>>> ---
>>>>>> .../wireless/broadcom/brcm80211/brcmfmac/p2p.c   | 16 +++++++++++++=
++-
>>>>>> 1 file changed, 15 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
>>>>>> b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
>>>>>> index 10d9d9c63..2c73156fa 100644
>>>>>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
>>>>>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
>>>>>> @@ -1559,6 +1559,12 @@ static s32 brcmf_p2p_tx_action_frame(struct
>>>>>> brcmf_p2p_info *p2p,
>>>>>> else
>>>>>> vif =3D p2p->bss_idx[P2PAPI_BSSCFG_DEVICE].vif;
>>>>>>
>>>>>> + /* add NULL check */
>>>>>> + if (!vif) {
>>>>>> + brcmf_err("vif is NULL, cannot send action frame\n");
>>>>>> + return -ENODEV;
>>>>>> + }
>>>>> Instead of giving up and surrender we can use primary vif, ie. p2p-
>>>>>> bss_idx[P2PAPI_BSSCFG_PRIMARY].vif:
>>>>> if (!vif) {
>>>>>         brcmf_dbg(TRACE, "no P2P device setup\n");
>>>>>         vif =3D p2p->bss_idx[P2PAPI_BSSCFG_PRIMARY].vif;
>>>>> }
>>>> this looks much better. But the whole patch needs a fixes tag.
>>> Sure.
>>>
>>>> In case this issue is reproducible before Linux 5.8, the tag should
>>>> reference:
>>>> 18e2f61db3b7 ("brcmfmac: P2P action frame tx.")
>>>>
>>>> otherwise it should reference:
>>>> d524d5ce3655 ("brcmfmac: p2p cert 6.1.9-support GOUT handling p2p
>>>> presence request")
>>> Both good suggestions. Looking at the code I would say that
>>> 18e2f61db3b7 ("brcmfmac: P2P action frame tx.") is the best choice.
>> thanks. @Richard Do you plan to submit a V2 patch?
>>
>> Best regards
>>> Regards,
>>> Arend
> Stefan,
>
> Yes, I plan on submitting a V2 patch, after I finish testing the change.
>
> I will also add the suggested fixes tag to the patch submission.
Sure, take your time.

Thanks
>
> Thanks,
> Richard


