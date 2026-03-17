Return-Path: <linux-wireless+bounces-33325-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKy5H5/xuGmTmAEAu9opvQ
	(envelope-from <linux-wireless+bounces-33325-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 07:15:59 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CAA2A43DB
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 07:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 487CE303BA57
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 06:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999744315F;
	Tue, 17 Mar 2026 06:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKcNtuNc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079A3247DE1
	for <linux-wireless@vger.kernel.org>; Tue, 17 Mar 2026 06:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773728118; cv=none; b=EwxYe5w5lZtGmiZRVcK3lYBPHcOrFgR9HaX0BcJ7a8PSiTKiOJbdHv6JFuezxJlA6WxrGQ3dwoHsGlgRqawlLmBb4NqRtDYMBoklLt+8s0W0/qvJJoD43o6rlGG8ZeMCinn5Or2kZD5j5+ynrBe3lzHqnET7cu0NjbsUhqdtPNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773728118; c=relaxed/simple;
	bh=9ayYyUpxUGmQhqTBRAZNSjJWWGEc1x7Gh9JnB3iWmK8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=EGFwD8a7fA2dPLQmW+Yu/22xoY2Dl8aw9YAOPLs4AmDtkVEYDE+lGPtzHhRsdNfNwQV4MNr5eSY3qdkLLXLlbUow9q2uWT96BhhzTp6uXglFjry18KXeNqomGdXQzDBcSipc83jtbXOzSDeUa0l1ygCaPaNpJcF2NPC1+tpZfn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kKcNtuNc; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48540355459so50742425e9.3
        for <linux-wireless@vger.kernel.org>; Mon, 16 Mar 2026 23:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773728115; x=1774332915; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ul6lc9W/ihLxzzyBefn2mCQEb+lh1IHjN9jY4TWkSzA=;
        b=kKcNtuNcYOSV7/4x2PLxuZC/KC08HjyzaX0XAuBn8Pzxyha9VQw9NNUk4tlby0MBO4
         JTuZPysewHDANX+HdgdDJ3OY1u1/U6dsLR8GG9oOH7Wgi/io8MMHz6HbbuAfGpd1Aw29
         KZRK8245KDzoCqycqXoj3H69Fr/6r/2H9GLWPCHYdL2efJ92tIdH+U88QFHYqOqThWpw
         Oxu6h8DYH106aMRiu8+5tjwZhpeIEScCZJj8dFRHDEsfm1mIwjh2VnnCbGT7xr5knjlz
         GlYJtS1rrBuj0uJcPqnc6OivNy2+dPstQysBBZ5AzJGIuTOm9kOmjubCoeHl6WyQMBmg
         RmZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773728115; x=1774332915;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ul6lc9W/ihLxzzyBefn2mCQEb+lh1IHjN9jY4TWkSzA=;
        b=NiqFzg1WABUA4VFxTSfCi5BAla2l8s9/ijLInq+AbcSQO7BDAL2SmG1Hvq5NoH4xkc
         9cLPKxbS0J0l9DIv/Lb+ojJ22hgYUeJdsjaiLebDOytg1x54x+UEAmsyY5KvrovOG9w8
         OSigPEq4DPWMHZ5nwBjFoWFkw6I6Tm5/YXdG1TBJd7TlTiQbApZhBkzXdAAhKew0C7sn
         g5X+NgN6+MSPPGS16977Fu+0cF6stR/tejFh1JVLFbMcyOEtkJvObT+t0V8eQfIeWxBP
         h4RVX5PKG/+cvGgOwk+olFyDXdy81b1txhODzYCRaGt1PEkI/PmX1UD6DIHiTdJnj0tx
         lsig==
X-Forwarded-Encrypted: i=1; AJvYcCV8orYRcfRBXwtxjCDpBfnw7uTkarJi/4hDQET3KjxaXwcfuw8VNnULxGXvlr1CaEdoRYMJVFhxTJ53gn7crA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyPH331rhq1W8uLQ/cvaNzEsP9qgDDTlW+io+cPpdPJmyts9/Go
	Vq6elVFhd5lENO0/37hP40SF9wG9MfM/GVbj8H1CtHcUYwnYcX8coFhj
X-Gm-Gg: ATEYQzzdTak8ySzFHHOVutmsChxJmMo572yalSbthmfoTR64gee9FxxhYNttOwCnnfw
	lOOgLfy+Ufj3IM/2b67Csqtn7egNwByXIrMhRtLcf94wVBHkGvrR+/ja119DKJAB0UUjZM1OKUJ
	O3Gn9CatYghOz2ey0B0j2q3FwiXeJnkhkUb8uL9ZEy1PRm4D0v5DG8L/bbDhCb9pEJFYTKyRPje
	jkRwqRSre6XAuP64rwH2nLRRNiPtQfDaYKhr5TUhEr2QSr8X4dcd4ZT6gMChBSQN+6JbItT7epM
	K+QoHCqkOq0QOGJ8QUichq2uNDXxQ5w0rdIE4eaD8kdfdYb0EzT1ovkkcywy77bUCnrNS/6xayO
	Zdc52uP8ysxab2JHyzetOJHtnTH5pOkxZQIEWxqlv6u4WKMXNxjP4evz/4oo3QhqGbVSaX4nFpM
	/QgATHfIovK28X0ElLbkoN2ZuSsZAtB8IHaPfqAN8vBBi7bh2tvbZ379r8jfHW4XYrYHxmW9aJ5
	Il3YxJa2jvnC0BP5pvgTv5gTEi+tgydwgkw3g==
X-Received: by 2002:a05:600c:154b:b0:485:40ed:2d1 with SMTP id 5b1f17b1804b1-48556706676mr261782455e9.17.1773728115122;
        Mon, 16 Mar 2026 23:15:15 -0700 (PDT)
Received: from smtpclient.apple (static.253.36.98.91.clients.your-server.de. [91.98.36.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe19aec5sm48752066f8f.4.2026.03.16.23.15.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Mar 2026 23:15:14 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH] wifi: rtw89: retry efuse physical map dump on transient
 failure
From: Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <43c8229cbe284b25bd1fd6b3a66a753d@realtek.com>
Date: Tue, 17 Mar 2026 10:15:01 +0400
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <BE076023-7D25-4AF0-B01C-4AA69E3666CD@gmail.com>
References: <20260301042422.195491-1-christianshewitt@gmail.com>
 <a7d421b1d3074a00968f2902c9debb42@realtek.com>
 <86F91944-A4B0-46D6-B2DE-7391EB5B38A7@gmail.com>
 <43c8229cbe284b25bd1fd6b3a66a753d@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>
X-Mailer: Apple Mail (2.3864.400.21)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33325-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christianshewitt@gmail.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROM(0.00)[];
	APPLE_MAILER_COMMON(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 10CAA2A43DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> On 17 Mar 2026, at 5:37=E2=80=AFam, Ping-Ke Shih <pkshih@realtek.com> =
wrote:
>=20
> Christian Hewitt <christianshewitt@gmail.com> wrote:
>>> On 16 Mar 2026, at 9:32=E2=80=AFam, Ping-Ke Shih =
<pkshih@realtek.com> wrote:
>>>=20
>>> Christian Hewitt <christianshewitt@gmail.com> wrote:
>>>> On Radxa Rock 5B with a RTL8852BE combo WiFi/BT card, the efuse
>>>> physical map dump intermittently fails with -EBUSY during probe.
>>>> The failure occurs in rtw89_dump_physical_efuse_map_ddv() where
>>>> read_poll_timeout_atomic() times out waiting for the B_AX_EF_RDY
>>>> bit after 1 second.
>>>>=20
>>>> The root cause is a timing race during boot: the WiFi driver's
>>>> chip initialization (firmware download via PCIe) overlaps with the
>>>> Bluetooth firmware download to the same combo chip over USB. This
>>>> can leave the efuse controller temporarily unavailable when the
>>>> WiFi driver attempts to read the efuse map.
>>>>=20
>>>> Add a retry loop (up to 3 attempts with 500ms delays) around the
>>>> physical efuse map dump in rtw89_parse_efuse_map_ax(). The firmware
>>>> download path already retries up to 5 times, but the efuse read
>>>> that follows has no retry logic, making it the weak link in the
>>>> probe sequence.
>>>=20
>>> I'd prefer adding a wrapper to retry 5 times without delay as bottom
>>> changes for reference. If you want to limit retry only for
>>> 'dav =3D=3D false' case, it is also fine to me.
>>>=20
>>>>=20
>>>> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
>>>=20
>>> [...]
>>>=20
>>>>=20
>>>> drivers/net/wireless/realtek/rtw89/efuse.c | 13 ++++++++++++-
>>>> 1 file changed, 12 insertions(+), 1 deletion(-)
>>>>=20
>>>> diff --git a/drivers/net/wireless/realtek/rtw89/efuse.c
>>>> b/drivers/net/wireless/realtek/rtw89/efuse.c
>>>> index a2757a88d55d..d506f04ffd6c 100644
>>>> --- a/drivers/net/wireless/realtek/rtw89/efuse.c
>>>> +++ b/drivers/net/wireless/realtek/rtw89/efuse.c
>>>> @@ -270,6 +270,7 @@ int rtw89_parse_efuse_map_ax(struct rtw89_dev =
*rtwdev)
>>>>       u8 *log_map =3D NULL;
>>>>       u8 *dav_phy_map =3D NULL;
>>>>       u8 *dav_log_map =3D NULL;
>>>> +       int retry;
>>>>       int ret;
>>>>=20
>>>>       if (rtw89_read16(rtwdev, R_AX_SYS_WL_EFUSE_CTRL) &
>> B_AX_AUTOLOAD_SUS)
>>>> @@ -289,7 +290,17 @@ int rtw89_parse_efuse_map_ax(struct rtw89_dev =
*rtwdev)
>>>>               goto out_free;
>>>>       }
>>>>=20
>>>> -       ret =3D rtw89_dump_physical_efuse_map(rtwdev, phy_map, 0, =
phy_size,
>>>> false);
>>>> +       for (retry =3D 0; retry < 3; retry++) {
>>>> +               if (retry) {
>>>> +                       rtw89_warn(rtwdev, "efuse dump failed, =
retrying
>>>> (%d)\n",
>>>> +                                  retry);
>>>> +                       fsleep(500000);
>>>> +               }
>>>> +               ret =3D rtw89_dump_physical_efuse_map(rtwdev, =
phy_map, 0,
>>>> +                                                   phy_size, =
false);
>>>> +               if (!ret)
>>>> +                       break;
>>>> +       }
>>>>       if (ret) {
>>>>               rtw89_warn(rtwdev, "failed to dump efuse physical =
map\n");
>>>>               goto out_free;
>>>> --
>>>> 2.43.0
>>>=20
>>> How about retrying 5 times without fsleep(500000)?
>>>=20
>>> diff --git a/drivers/net/wireless/realtek/rtw89/efuse.c
>> b/drivers/net/wireless/realtek/rtw89/efuse.c
>>> index a2757a88d55d..89d4b1b865f8 100644
>>> --- a/drivers/net/wireless/realtek/rtw89/efuse.c
>>> +++ b/drivers/net/wireless/realtek/rtw89/efuse.c
>>> @@ -185,8 +185,8 @@ static int =
rtw89_dump_physical_efuse_map_dav(struct
>> rtw89_dev *rtwdev, u8 *map,
>>>       return 0;
>>> }
>>>=20
>>> -static int rtw89_dump_physical_efuse_map(struct rtw89_dev *rtwdev, =
u8 *map,
>>> -                                        u32 dump_addr, u32 =
dump_size, bool
>> dav)
>>> +static int __rtw89_dump_physical_efuse_map(struct rtw89_dev =
*rtwdev, u8
>> *map,
>>> +                                          u32 dump_addr, u32 =
dump_size,
>> bool dav)
>>> {
>>>       int ret;
>>>=20
>>> @@ -208,6 +208,25 @@ static int rtw89_dump_physical_efuse_map(struct =
rtw89_dev
>> *rtwdev, u8 *map,
>>>       return 0;
>>> }
>>>=20
>>> +static int rtw89_dump_physical_efuse_map(struct rtw89_dev *rtwdev, =
u8 *map,
>>> +                                        u32 dump_addr, u32 =
dump_size, bool
>> dav)
>>> +{
>>> +       int retry;
>>> +       int ret;
>>> +
>>> +       for (retry =3D 0; retry < 5; retry++) {
>>> +               ret =3D __rtw89_dump_physical_efuse_map(rtwdev, map,
>> dump_addr,
>>> +                                                     dump_size, =
dav);
>>> +               if (!ret)
>>> +                       return 0;
>>> +
>>> +               rtw89_warn(rtwdev, "efuse dump (dav=3D%d) failed, =
retrying
>> (%d)\n",
>>> +                          dav, retry);
>>> +       }
>>> +
>>> +       return ret;
>>> +}
>>> +
>>> #define invalid_efuse_header(hdr1, hdr2) \
>>>       ((hdr1) =3D=3D 0xff || (hdr2) =3D=3D 0xff)
>>> #define invalid_efuse_content(word_en, i) \
>>=20
>> I=E2=80=99ve run some boot tests and this also resolves my efuse map =
use-case, e.g.
>>=20
>> ROCK5B:~ # dmesg | grep rtw89
>> [    6.506375] rtw89_8852be 0002:21:00.0: loaded firmware
>> rtw89/rtw8852b_fw-1.bin
>> [    6.506539] rtw89_8852be 0002:21:00.0: enabling device (0000 -> =
0003)
>> [    6.516069] rtw89_8852be 0002:21:00.0: Firmware version 0.29.29.15
>> (6fb3ec41), cmd version 0, type 5
>> [    6.516083] rtw89_8852be 0002:21:00.0: Firmware version 0.29.29.15
>> (6fb3ec41), cmd version 0, type 3
>> [   10.153731] rtw89_8852be 0002:21:00.0: efuse dump (dav=3D0) =
failed, retrying
>> (0)
>> [   10.405347] rtw89_8852be 0002:21:00.0: chip info CID: 0, CV: 1, =
AID: 0, ACV:
>> 1, RFE: 1
>> [   10.408311] rtw89_8852be 0002:21:00.0: rfkill hardware state =
changed to
>> enable
>>=20
>> So far I haven=E2=80=99t observed more than 1x retry being required, =
and there are no
>> issues with loading the BT module.
>=20
> My changes do retry for 5 times, because your patch does 3 times retry =
plus
> additional 500ms delay. I feel you want around 5 seconds for loading =
BT module.

Understood.

> Did you mean for now you can't reproduce the situation that long =
loading
> time of BT module? (But it took long time days ago?)

I=E2=80=99ve never noticed a long loading time for the BT module and =
timings seem
to be consistent both with and without the patch (and not a problem).

>> Would you like me to send a v2 using your revised version? - or?
>=20
> Yes, please help v2.

Thanks, will send v2 later today.

Christian=

