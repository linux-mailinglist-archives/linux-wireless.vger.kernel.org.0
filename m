Return-Path: <linux-wireless+bounces-30135-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30BECCDF573
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Dec 2025 10:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 745EE30057D5
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Dec 2025 09:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5C91EB5F8;
	Sat, 27 Dec 2025 09:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SsfBu7me"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834A2800
	for <linux-wireless@vger.kernel.org>; Sat, 27 Dec 2025 09:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766826454; cv=none; b=c5BgtGIbdFd2o1g/JEn20ja7Xknxdt1s9n3SgbrCey+k6fXcyToerZjdml/DK6iLPXMDZ9+7qR85pyR61fCxOlWD97O3WztDpYXTGCOaB0A/8MqcoqHN1LwojpdGlylrCWLbZV9WH/JSO74VI2W6tZbPtY4e2QDmfa7SHVB7FSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766826454; c=relaxed/simple;
	bh=ifUC8vCZeQOBq15C7xGgJzh5lsXNM+HByA9WfzvVCGY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=dAuKK9ygyqkXRLvtn6DT4YZo71ILDnOtIDuG5GUWp73GsK7O1Aarmmf8hj+IqD9r/E74YoTCR8UIpmt2jdt63RGSJaEDf7utQ02sZevK5xBJlNbytJ0VvLT/7z7DC0Y3RdJF+FKs+w1bqkMX8QeitvPTnP4rm/PoaXapbgaBY/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SsfBu7me; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7f651586be1so3653647b3a.1
        for <linux-wireless@vger.kernel.org>; Sat, 27 Dec 2025 01:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1766826452; x=1767431252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:content-language:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ifUC8vCZeQOBq15C7xGgJzh5lsXNM+HByA9WfzvVCGY=;
        b=SsfBu7mezWSj6T2eDxBx33NJVgLLNIETeWB+X3l8SfSsbo/7qmNX7WAD8b8JrOHepK
         D/mzK7vy0NC+fN8te6p2poEVMAg8vHceyQpyzjVp61Au8Fg63X0lhS5KBQnOBXT7wZyA
         8JrYKO0yqMYBVytuEmWOS9UxpZLKiKhwJZqRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766826452; x=1767431252;
        h=content-transfer-encoding:cc:to:content-language:subject:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ifUC8vCZeQOBq15C7xGgJzh5lsXNM+HByA9WfzvVCGY=;
        b=eDdyOVsni36biDja9hes7FG4VkswaGcvW26Z7oVYwFDus94FIHfeuBO786uUz2I50x
         VJvlEH1wKn3LxIvXqwACDMg2j2yH0ceWNmH/3UDFOLB5j8GJ4BXqQiubjiRWUrqnH0Js
         EZc14RX2p46ADVmmpIVWWOOESmkaYLb2MJt8fp2eoTBv9L7RADEOn8sbzJ+xCXqqgRTr
         qZb9h9rI61G9uzp++8foDkxMtzjMCQw0d/4LuCd4+Ao+MEkrNXOIM1x776d1UN1tJ50m
         Q5sj1cHsoLXq9pRV6uFsrEd5DvfGDpNp0JI2nkYWWamPb13P3mSOrF6sIUdhMU5FgoUk
         F9PA==
X-Gm-Message-State: AOJu0YzOV0ZXh86pRPXC9+RJDiiXaliqAsCn6ZeAYTn4dF6QEUDOri5m
	OxxBfa3Rp+Je/cF3hrJa1uT1B6vwG78crtKDY2IEy/b3z01LgNmeXS5I15tCOjUlzU8=
X-Gm-Gg: AY/fxX689WvliCy1Y16jWPeM/ot9rORnSoinm/wWL/ZKarVrPot5S5snADJBZhRnTS+
	6FHIXnCkLTRVRyXnxNttfHHL9UEg+HYiifYq+jNtXk/+CE4kj9LypL8qKXVr6AcK+VavBL+fWQU
	pI+Bwr+hSEyhWC67cMZYsYqHCMnapal8WJP4bzzc3waFvoFo/4ykcm7FiK8MnCFntwjLRqHpXxz
	+KhOzO2c+ESTv9k3Rf95R6+x8eZSJ+SEdZ2hoZGRKLqqB/CYQuExNCxe7YVnZ3clBvtNebzKEgC
	8iHxfx66Y7TfpS4IAFusSzS+7gt9T3vCnx8cUV8WaSQShx8EbiSrYq0zRLDKcPHGdp9dHEH3bYq
	yOXVD7zvTNHys2mpxFV2ihA65/crwCjdNsQaqkoQ3Kq3aiC+Nq3NHm0KpPbmCrYU+12pBPU3MTP
	IdpsCbrVvySaYkGIsw7uTm+cDw
X-Google-Smtp-Source: AGHT+IHFE6P6W0KNJpo0Rcyj79nO8yWZp/ADp0FPoeOXmnhH0hpzYXHfdC+BhTP+JpyW7wtzFaLnQA==
X-Received: by 2002:aa7:868f:0:b0:7f0:61d:d092 with SMTP id d2e1a72fcca58-7fe0d7a28a8mr22142128b3a.21.1766826451847;
        Sat, 27 Dec 2025 01:07:31 -0800 (PST)
Received: from [192.168.88.64] ([182.54.168.177])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7a939ea2sm23811761b3a.4.2025.12.27.01.07.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Dec 2025 01:07:31 -0800 (PST)
Message-ID: <d7f3b00d-beec-41f0-b157-7cfb871f9a46@linuxfoundation.org>
Date: Sat, 27 Dec 2025 02:07:24 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Shuah Khan <skhan@linuxfoundation.org>
Subject: Linux 6.19-rc1 mediatek mt7921e broke badly
Content-Language: en-US
To: quan.zhou@mediatek.com, Felix Fietkau <nbd@nbd.name>, lorenzo@kernel.org,
 ryder.lee@mediatek.com, Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-wireless@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 linux-mediatek@lists.infradead.org, Shuah Khan <skhan@linuxfoundation.org>,
 shuah <shuah@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

bXQ3OTIxZSBkb2Vzbid0IGxvYWQgb24gbXkgcHJpbWFyeSBsYXB0b3BuIG9uIExpbnV4IDYu
MTktcmMxIGFuZCBwcm9ibGVtDQpzdGlsbCB0aGVyZSBvbiA2LjE5LXJjMi4NCg0KICBGcm9t
IHdoYXQgSSBjYW4gdGVsbCBmcm9tIGRtZXNnIGl0IGF0dGVtcHRzIHRvIGRvIGxvYWQgZmly
bXdhcmUNCmluIG10NzkyeF9sb2FkX2Zpcm13YXJlKCkgZHVyaW5nIGFuZCB0aGVuIGdlbmVy
YXRlcyB3YXJucyBhbmQNCmZhaWxzIHRvIGxvYWQgdGhlIG1vZHVsZS4gZG1lc2cgZXhjZXJw
dCBiZWxvdy4NCg0KY29tbWl0IDA2NmY0MTdiZTVmZDhjN2ZlNTgxYzU1NTAyMDYzNjQ3MzVk
YWQ3YTMNCkF1dGhvcjogUXVhbiBaaG91IDxxdWFuLnpob3VAbWVkaWF0ZWsuY29tPg0KRGF0
ZTogICBUdWUgTm92IDE4IDE5OjU0OjU0IDIwMjUgKzA4MDANCg0KICAgICAgd2lmaTogbXQ3
NjogbXQ3OTJ4OiBmaXggd2lmaSBpbml0IGZhaWwgYnkgc2V0dGluZyBNQ1VfUlVOTklORyBh
ZnRlciBDTEMgbG9hZA0KDQpUaGUgYWJvdmUgY29tbWl0IGNoYW5nZXMgd2hlbiB0aGUgTUNV
X1JVTk5JTkcgYml0IGlzIHNldCBpbiBtdDc5MjVfcnVuX2Zpcm13YXJlKCksDQpjaGFuZ2lu
ZyBpdCB0byBzZXQgdGhpcyBiaXQgb25seSBhZnRlciBtdDc5MjFfbG9hZF9jbGMoKSBjb21w
bGV0ZXMuDQoNCkkgZGlkbid0IGdldCBhIGNoYW5jZSB0byBiaXNlY3QgeWV0IGFuZCBhIHF1
aWNrIHJldmVydCBvZiB0aGUgcGF0Y2ggZGlkbid0IHNvbHZlDQp0aGUgcHJvYmxlbS4gVGhp
cyBpcyBhIHNlcmlvdXMgcHJvYmxlbSBmb3IgbWUgc2luY2UgbXkgd2lmaSBpcyBkZWFkIG9u
IG15DQpwcmltYXJ5IGxhcHRvcC4gSG9wZSBhIGZpeCBpcyBjb21pbmcgc29vbi4NCg0KSSBh
bSBhdmFpbGFibGUgZm9yIGRlYnVnL3Rlc3RpbmcgaGVscCBlYXJseSBuZXh0IHdlZWsuDQoN
CnRoYW5rcywNCi0tIFNodWFoDQoNCmRtZXNnDQo9PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09DQoNCmtlcm4gIDpjcml0ICA6IGtlcm5lbCBCVUcgYXQgbGliL3N0cmluZ19oZWxw
ZXJzLmM6MTA0MyENCmtlcm4gIDp3YXJuICA6IE9vcHM6IGludmFsaWQgb3Bjb2RlOiAwMDAw
IFsjMV0gU01QIE5PUFRJDQprZXJuICA6d2FybiAgOiBDUFU6IDE0IFVJRDogMCBQSUQ6IDYx
IENvbW06IGt3b3JrZXIvMTQ6MCBUYWludGVkOiBHICAgICAgICBXDQogICAgICAgICA2LjE5
LjAtcmMxICMxIFBSRUVNUFQodm9sdW50YXJ5KQ0Ka2VybiAgOndhcm4gIDogVGFpbnRlZDog
W1ddPVdBUk4NCmtlcm4gIDp3YXJuICA6IEhhcmR3YXJlIG5hbWU6IEZyYW1ld29yayBMYXB0
b3AgMTMgKEFNRCBSeXplbiA3MDQwU2VyaWVzKS9GUkFOTURDUDA3LCBCSU9TIDAzLjE2IDA3
LzI1LzIwMjUNCmtlcm4gIDp3YXJuICA6IFdvcmtxdWV1ZTogZXZlbnRzIG10NzkyMV9pbml0
X3dvcmsgW210NzkyMV9jb21tb25dDQprZXJuICA6d2FybiAgOiBSSVA6IDAwMTA6X19mb3J0
aWZ5X3BhbmljKzB4ZC8weGYNCmtlcm4gIDp3YXJuICA6IENvZGU6IDY2IDJlIDBmIDFmIDg0
IDAwIDAwIDAwIDAwIDAwIDBmIDFmIDAwIDkwIDkwIDkwIDkwIDkwIDkwIDkwIDkwIDkwIDkw
IDkwIDkwIDkwIDkwIDkwIDkwIGYzIDBmIDFlIGZhIDQwIDBmIGI2IGZmIGU4IGMzIDU1IDcx
IDAwIDwwZj4gMGIgNDggOGIgNTQgMjQgMTAgNDggOGIgNzQgMjQgMDggNGMgODkgZTkgNDgg
YzcgYzcgMDAgYTIgZDUgYTANCmtlcm4gIDp3YXJuICA6IFJTUDogMDAxODpmZmZmYTdhNWMw
M2EzZDEwIEVGTEFHUzogMDAwMTAyNDYNCmtlcm4gIDp3YXJuICA6IFJBWDogZmZmZmZmZmZh
MGQ3YWFmMiBSQlg6IDAwMDAwMDAwMDAwMDAwMDAgUkNYOiBmZmZmZmZmZmEwZDdhYWYyDQpr
ZXJuICA6d2FybiAgOiBSRFg6IDAwMDAwMDAwMDAwMDAwMTEgUlNJOiBmZmZmZmZmZmEwZDVh
MTcwIFJESTogZmZmZmZmZmZhMTI4ZGIxMA0Ka2VybiAgOndhcm4gIDogUkJQOiBmZmZmOTE2
NTBhZTUyMDYwIFIwODogMDAwMDAwMDAwMDAwMDAxMCBSMDk6IGZmZmZhN2E1YzMxYjIwMDAN
Cmtlcm4gIDp3YXJuICA6IFIxMDogZmZmZmE3YTVjMDNhM2JmMCBSMTE6IDAwMDAwMDAwZmZm
ZmZmZmYgUjEyOiAwMDAwMDAwMDAwMDAwMDAwDQprZXJuICA6d2FybiAgOiBSMTM6IGZmZmZh
N2E1YzMxYjIwMDAgUjE0OiAwMDAwMDAwMDAwMDAxMDAwIFIxNTogMDAwMDAwMDAwMDAwMDAw
MA0Ka2VybiAgOndhcm4gIDogRlM6ICAwMDAwMDAwMDAwMDAwMDAwKDAwMDApIEdTOmZmZmY5
MTc0M2U2NjQwMDAoMDAwMCkga25sR1M6MDAwMDAwMDAwMDAwMDAwMA0Ka2VybiAgOndhcm4g
IDogQ1M6ICAwMDEwIERTOiAwMDAwIEVTOiAwMDAwIENSMDogMDAwMDAwMDA4MDA1MDAzMw0K
a2VybiAgOndhcm4gIDogQ1IyOiAwMDAwN2YxMDc4NmMyNDFjIENSMzogMDAwMDAwMDNlY2Ey
NDAwMCBDUjQ6IDAwMDAwMDAwMDBmNTBlZjANCmtlcm4gIDp3YXJuICA6IFBLUlU6IDU1NTU1
NTU0DQprZXJuICA6d2FybiAgOiBDYWxsIFRyYWNlOg0Ka2VybiAgOndhcm4gIDogIDxUQVNL
Pg0Ka2VybiAgOndhcm4gIDogIG10NzZfY29ubmFjMl9sb2FkX3BhdGNoLmNvbGQrMHgyYi8w
eGE0MSBbbXQ3Nl9jb25uYWNfbGliXQ0Ka2VybiAgOndhcm4gIDogID8gc3Jzb19hbGlhc19y
ZXR1cm5fdGh1bmsrMHg1LzB4ZmJlZjUNCmtlcm4gIDp3YXJuICA6ICBtdDc5MnhfbG9hZF9m
aXJtd2FyZSsweDM2LzB4MTUwIFttdDc5MnhfbGliXQ0Ka2VybiAgOndhcm4gIDogIG10Nzky
MV9ydW5fZmlybXdhcmUrMHgyYy8weDRhMCBbbXQ3OTIxX2NvbW1vbl0NCmtlcm4gIDp3YXJu
ICA6ICA/IHNyc29fYWxpYXNfcmV0dXJuX3RodW5rKzB4NS8weGZiZWY1DQprZXJuICA6d2Fy
biAgOiAgPyBtdDc5MjFfcnIrMHgxMi8weDMwIFttdDc5MjFlXQ0Ka2VybiAgOndhcm4gIDog
ID8gc3Jzb19hbGlhc19yZXR1cm5fdGh1bmsrMHg1LzB4ZmJlZjUNCmtlcm4gIDp3YXJuICA6
ICA/IF9fX19tdDc2X3BvbGxfbXNlYysweDc1LzB4YjAgW210NzZdDQprZXJuICA6d2FybiAg
OiAgbXQ3OTIxZV9tY3VfaW5pdCsweDRjLzB4N2EgW210NzkyMWVdDQprZXJuICA6d2FybiAg
OiAgbXQ3OTIxX2luaXRfd29yaysweDUxLzB4MTkwIFttdDc5MjFfY29tbW9uXQ0Ka2VybiAg
Ondhcm4gIDogIHByb2Nlc3Nfb25lX3dvcmsrMHgxOGIvMHgzNDANCmtlcm4gIDp3YXJuICA6
ICB3b3JrZXJfdGhyZWFkKzB4MjU2LzB4M2EwDQprZXJuICA6d2FybiAgOiAgPyBfX3BmeF93
b3JrZXJfdGhyZWFkKzB4MTAvMHgxMA0Ka2VybiAgOndhcm4gIDogIGt0aHJlYWQrMHhmYy8w
eDI0MA0Ka2VybiAgOndhcm4gIDogID8gX19wZnhfa3RocmVhZCsweDEwLzB4MTANCmtlcm4g
IDp3YXJuICA6ICA/IF9fcGZ4X2t0aHJlYWQrMHgxMC8weDEwDQprZXJuICA6d2FybiAgOiAg
cmV0X2Zyb21fZm9yaysweDI1NC8weDI5MA0Ka2VybiAgOndhcm4gIDogID8gX19wZnhfa3Ro
cmVhZCsweDEwLzB4MTANCmtlcm4gIDp3YXJuICA6ICByZXRfZnJvbV9mb3JrX2FzbSsweDFh
LzB4MzANCmtlcm4gIDp3YXJuICA6ICA8L1RBU0s+DQprZXJuICA6d2FybiAgOiBNb2R1bGVz
IGxpbmtlZCBpbjogc25kX2hkYV9jb2RlY19hbGMyNjkoKykgc25kX3NvZl9hbWRfcmVtYnJh
bmR0IG10NzkyMWUgc25kX2hkYV9zY29kZWNfY29tcG9uZW50IHNuZF9zb2ZfYW1kX2FjcCBz
bmRfaGRhX2NvZGVjX3JlYWx0ZWtfbGliIG10NzkyMV9jb21tb24gc25kX3NvZl9wY2kgc25k
X3NvZl94dGVuc2FfZHNwIHNuZF9oZGFfY29kZWNfZ2VuZXJpYyBidHVzYiBhbWRfYXRsIG10
NzkyeF9saWIgdXZjdmlkZW8gc25kX2hkYV9jb2RlY19hdGloZG1pIGludGVsX3JhcGxfbXNy
IG10NzZfY29ubmFjX2xpYiBzbmRfc29mIGJ0cnRsIGludGVsX3JhcGxfY29tbW9uIHNuZF9o
ZGFfY29kZWNfaGRtaSBidGludGVsIHZpZGVvYnVmMl92bWFsbG9jIG10NzYgdmlkZW9idWYy
X21lbW9wcyBidGJjbSB1dmMgc25kX3NvZl91dGlscyB2aWRlb2J1ZjJfdjRsMiBrdm1fYW1k
IGJ0bXRrIGhpZF9zZW5zb3JfYWxzIHNuZF9oZGFfaW50ZWwgbWFjODAyMTEgaGlkX3NlbnNv
cl90cmlnZ2VyIHNuZF9zb2NfY29yZSB2aWRlb2RldiBibHVldG9vdGggc25kX2hkYV9jb2Rl
YyBpbmR1c3RyaWFsaW9fdHJpZ2dlcmVkX2J1ZmZlciBoaWRfc2Vuc29yX2lpb19jb21tb24g
c25kX2NvbXByZXNzIHZpZGVvYnVmMl9jb21tb24ga3ZtIHNuZF9od2RlcCBsaWJhcmM0IGtm
aWZvX2J1ZiBzbmRfcGNpX3BzIGluZHVzdHJpYWxpbyBzbmRfc29jX2FjcGlfYW1kX21hdGNo
IG1jIHNuZF9oZGFfY29yZSBzbmRfcnBsX3BjaV9hY3A2eCBpcnFieXBhc3MgY2ZnODAyMTEg
c25kX2ludGVsX2RzcGNmZyBzbmRfcGNpX2FjcDZ4IGFtZF9wbWYgcmFwbCBzbmRfcGNpX2Fj
cDV4IHNuZF9wY20gYW1kdGVlIGxlZHNfY3Jvc19lYyBzbmRfcm5fcGNpX2FjcDN4IGhpZF9z
ZW5zb3JfaHViIHdtaV9ibW9mIHNuZF90aW1lciBsZWRfY2xhc3NfbXVsdGljb2xvciBzbmRf
YWNwX2NvbmZpZyBzbmRfc29jX2FjcGkgY3Jvc19lY19od21vbiBzbmQgc3BkNTExOCBjY3Ag
c25kX3BjaV9hY3AzeCBwY3Nwa3IgcGxhdGZvcm1fcHJvZmlsZQ0Ka2VybiAgOndhcm4gIDog
IHNvdW5kY29yZSByZmtpbGwgazEwdGVtcCBhYyBidXR0b24gYW1kX3NmaCB0ZWUgYW1kX3Bt
YyBqb3lkZXYgZXZkZXYgbXNyIHBhcnBvcnRfcGMgcHBkZXYgbHAgcGFycG9ydCBjb25maWdm
cyBlZmlfcHN0b3JlIG5mbmV0bGluayBlZml2YXJmcyBhdXRvZnM0IGV4dDQgbWJjYWNoZSBq
YmQyIGRtX2NyeXB0IGRtX21vZCB1c2JoaWQgYW1kZ3B1IGFtZHhjcCBpMmNfYWxnb19iaXQg
ZHJtX2NsaWVudF9saWIgZHJtX3R0bV9oZWxwZXIgdHRtIHVjc2lfYWNwaSB0eXBlY191Y3Np
IGRybV9leGVjIGRybV9wYW5lbF9iYWNrbGlnaHRfcXVpcmtzIHJvbGVzIGdwdV9zY2hlZCBo
aWRfbXVsdGl0b3VjaCB0eXBlYyBkcm1fc3ViYWxsb2NfaGVscGVyIGRybV9idWRkeSBoaWRf
Z2VuZXJpYyB4aGNpX3BjaSBkcm1fZGlzcGxheV9oZWxwZXIgY3Jvc19lY19kZWJ1Z2ZzIGNy
b3NfZWNfc3lzZnMgY3Jvc19jaGFyZ2VfY29udHJvbCBjcm9zX2VjX2NoYXJkZXYgY3Jvc19r
YmRfbGVkX2JhY2tsaWdodCBpMmNfaGlkX2FjcGkgeGhjaV9oY2QgaTJjX2hpZCBoaWQgZHJt
X2ttc19oZWxwZXIgc3A1MTAwX3RjbyB3YXRjaGRvZyBjcm9zX2VjX2RldiB0aHVuZGVyYm9s
dCBkcm0gdXNiY29yZSBudm1lIGdoYXNoX2NsbXVsbmlfaW50ZWwgY2VjIGFlc25pX2ludGVs
IG52bWVfY29yZSByY19jb3JlIHNlcmlvX3JhdyBpMmNfcGlpeDQgaTJjX3NtYnVzIGNyYzE2
IHZpZGVvIHVzYl9jb21tb24gYmF0dGVyeSB3bWkgY3Jvc19lY19scGNzIGNyb3NfZWMgY3Jv
c19lY19wcm90bw0K

