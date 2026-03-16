Return-Path: <linux-wireless+bounces-33297-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uI1+GLDkt2mzWwEAu9opvQ
	(envelope-from <linux-wireless+bounces-33297-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 12:08:32 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C54A22987AA
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 12:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FD073051CB0
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 11:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2EEB262FD0;
	Mon, 16 Mar 2026 11:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PIFaznI0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379FC265CC2
	for <linux-wireless@vger.kernel.org>; Mon, 16 Mar 2026 11:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773659011; cv=none; b=i5r8bm3GrAiyyY63bfzGvwBZ7KNG84ExwntwkJLdCVS0w+eVxdaI2IvsFPOWMfGUjW+7670wRmfyeIfabT2v362XemvlP08+484a8xkVFtMEEWuVqxAm2VbeR8fYdGEKOf1tWniWxqpLupKN1ewpH6mUqGTEQQiPAnT4v9iDjHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773659011; c=relaxed/simple;
	bh=XxGoizpqpSsLsjJkBY4+gF72PBU8BRAmqqkpAdkoFYI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=EYBmMGe4cCeB2Rx5wnoI0tHI/DZlZpcDnnEIPHBUxLLUkRv8JaguiNlAIjbOsxj4BUDMyOxok6vAtKQLTipvqlX/npwZdjCCDnGtcgnH8xmXK57f4wl4SbO2rkIGNfv15+Q648yhpqueJKr5wdHiJdAfjyonwoiYgNVCLsCjgl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PIFaznI0; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso39027025e9.3
        for <linux-wireless@vger.kernel.org>; Mon, 16 Mar 2026 04:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773659008; x=1774263808; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KBSmBV6S8JTwvGaEVUkXvibGMkQHgn3CnUkn+Fh7WWs=;
        b=PIFaznI0FmWJHOKsCKbW+5pqslxXgebhtCwmkzvxIDZmYwxZXPtYAOjlzmvZCmjICG
         3DWYvBpyPfO64OvMeWZHaD8a9GM3MegzE7aTNJ3CHqk5J65Mbnqka2DdMXxCgYW+Xj4p
         gbVFupjQNy48nUypzBvhZGQZZe0OtkA4tZotBKbRaLh/XLrBgiv+74AkkqRIK3EYIezp
         6ey6Ki9s9ryFURQf2AatGIyOk9RYpiODKrbw+PGicUOqOdr6/1SAInbmNXeZmXA1e3Mv
         6A62iIZBa737Cwdevcs04DLeMPIUy3nJ/hm/Jrv6R1fIFI8z/yp9wX6Ilu6OnJIhma23
         uV/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773659008; x=1774263808;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KBSmBV6S8JTwvGaEVUkXvibGMkQHgn3CnUkn+Fh7WWs=;
        b=S13rEVpIr2ojEAjLvIKetuJQ+fzrQz0JMzweZAHUgzW/i41bj6B8j+vMNu9vNXZJ0b
         7ldF1oKH2jgsGBcU+xs52f664DVuH9zMWYJP+RSzqHwKVEjQ+gpkXjKdLK6vP84bVo1W
         2SZ9Cib5176SwgTJA1LRRcXI9Y6X5w27m/ypysriDUw16+/gV8AjPL+eYkLwWCqGP/Kw
         NBThm5IYPBij4eBULD6Uoa1hOb05XLipxbEeFrszSLC7fqQA+nKOaeH3Jc6WoEcCYUFf
         JM23auexksoMFUQl+335O81YvPtvw7rBUiftkzCNJKMer0Jmx4diQDQ51yMpze5+ZSw9
         MyUg==
X-Forwarded-Encrypted: i=1; AJvYcCUzmvo3qa7n8I2msmgi4Q1fYl2KCYqn2q9Sx+VS5d1CLnkfARyYNVG7dnVLBglZm6PvUbrZC0AcNokmw7k3uA==@vger.kernel.org
X-Gm-Message-State: AOJu0YycsxRaiEgA4O9bDpQUo07Y2NfA5jhhhX755hUeKWF5Poh3kAwO
	r/4RjT5gop5lmUdZjmCpEGG0+rF6K/+5bHPaIYFiZJYvh8ggBsDQ45VO
X-Gm-Gg: ATEYQzxPU5tyXBiNoL0sF/OKIDUV+Pm74moY0Bn1LUbiYcUdHwm6R+nd+25puWrR5Qg
	27y+r1FbWMTc/hGsgS3aiGAHeRmVatvOYZDryGok54N7ECwCCUTFgMsm6kfeTEwUj1MtuUvRnAS
	rRb2at9kQNshuGvThFSi0q+gZrYAlkBuGkRP7xc/4mvtd8OtHz/uq9Bw7tveenTk8oIor/ux+lf
	x38xIEF0RURGuickq6pqpwrGdL9iuDftX9Pjqx4dAncV1tlC7e8Jb5f7pjDH3oNiVZhKTBhNCko
	oYrK24u1je9uUIYf9YzAIeRK/NPwLte+HZSMphPMMbhYq2p7hZrbEx2ye4ynBVfgBh5sF1VRHVj
	ElDdAxwSsz+dRpMQSx6uKW+0v5FTjIPKel3RM84zoyYzckkd0y5MnGBcytvFTG2yTUU32ETDoHW
	+nwQ9qbYMu5ExIVbUu4V/NXTO/ciI3CXVfYHFBK0zbKhDhiuYUw0/GgO7wZJeDsu5z/YNVBnhPZ
	wdiTkTis191Vqhgp4WHs4R+Kko=
X-Received: by 2002:a05:600c:4514:b0:485:2f6a:6ed with SMTP id 5b1f17b1804b1-4855670b701mr197056835e9.28.1773659008190;
        Mon, 16 Mar 2026 04:03:28 -0700 (PDT)
Received: from smtpclient.apple (static.253.36.98.91.clients.your-server.de. [91.98.36.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48558fd09d8sm257030845e9.7.2026.03.16.04.03.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Mar 2026 04:03:25 -0700 (PDT)
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
In-Reply-To: <a7d421b1d3074a00968f2902c9debb42@realtek.com>
Date: Mon, 16 Mar 2026 15:03:12 +0400
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <86F91944-A4B0-46D6-B2DE-7391EB5B38A7@gmail.com>
References: <20260301042422.195491-1-christianshewitt@gmail.com>
 <a7d421b1d3074a00968f2902c9debb42@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>
X-Mailer: Apple Mail (2.3864.400.21)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33297-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christianshewitt@gmail.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	APPLE_MAILER_COMMON(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: C54A22987AA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> On 16 Mar 2026, at 9:32=E2=80=AFam, Ping-Ke Shih <pkshih@realtek.com> =
wrote:
>=20
> Christian Hewitt <christianshewitt@gmail.com> wrote:
>> On Radxa Rock 5B with a RTL8852BE combo WiFi/BT card, the efuse
>> physical map dump intermittently fails with -EBUSY during probe.
>> The failure occurs in rtw89_dump_physical_efuse_map_ddv() where
>> read_poll_timeout_atomic() times out waiting for the B_AX_EF_RDY
>> bit after 1 second.
>>=20
>> The root cause is a timing race during boot: the WiFi driver's
>> chip initialization (firmware download via PCIe) overlaps with the
>> Bluetooth firmware download to the same combo chip over USB. This
>> can leave the efuse controller temporarily unavailable when the
>> WiFi driver attempts to read the efuse map.
>>=20
>> Add a retry loop (up to 3 attempts with 500ms delays) around the
>> physical efuse map dump in rtw89_parse_efuse_map_ax(). The firmware
>> download path already retries up to 5 times, but the efuse read
>> that follows has no retry logic, making it the weak link in the
>> probe sequence.
>=20
> I'd prefer adding a wrapper to retry 5 times without delay as bottom
> changes for reference. If you want to limit retry only for
> 'dav =3D=3D false' case, it is also fine to me.
>=20
>>=20
>> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
>=20
> [...]
>=20
>>=20
>> drivers/net/wireless/realtek/rtw89/efuse.c | 13 ++++++++++++-
>> 1 file changed, 12 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/net/wireless/realtek/rtw89/efuse.c
>> b/drivers/net/wireless/realtek/rtw89/efuse.c
>> index a2757a88d55d..d506f04ffd6c 100644
>> --- a/drivers/net/wireless/realtek/rtw89/efuse.c
>> +++ b/drivers/net/wireless/realtek/rtw89/efuse.c
>> @@ -270,6 +270,7 @@ int rtw89_parse_efuse_map_ax(struct rtw89_dev =
*rtwdev)
>>        u8 *log_map =3D NULL;
>>        u8 *dav_phy_map =3D NULL;
>>        u8 *dav_log_map =3D NULL;
>> +       int retry;
>>        int ret;
>>=20
>>        if (rtw89_read16(rtwdev, R_AX_SYS_WL_EFUSE_CTRL) & =
B_AX_AUTOLOAD_SUS)
>> @@ -289,7 +290,17 @@ int rtw89_parse_efuse_map_ax(struct rtw89_dev =
*rtwdev)
>>                goto out_free;
>>        }
>>=20
>> -       ret =3D rtw89_dump_physical_efuse_map(rtwdev, phy_map, 0, =
phy_size,
>> false);
>> +       for (retry =3D 0; retry < 3; retry++) {
>> +               if (retry) {
>> +                       rtw89_warn(rtwdev, "efuse dump failed, =
retrying
>> (%d)\n",
>> +                                  retry);
>> +                       fsleep(500000);
>> +               }
>> +               ret =3D rtw89_dump_physical_efuse_map(rtwdev, =
phy_map, 0,
>> +                                                   phy_size, false);
>> +               if (!ret)
>> +                       break;
>> +       }
>>        if (ret) {
>>                rtw89_warn(rtwdev, "failed to dump efuse physical =
map\n");
>>                goto out_free;
>> --
>> 2.43.0
>=20
> How about retrying 5 times without fsleep(500000)?
>=20
> diff --git a/drivers/net/wireless/realtek/rtw89/efuse.c =
b/drivers/net/wireless/realtek/rtw89/efuse.c
> index a2757a88d55d..89d4b1b865f8 100644
> --- a/drivers/net/wireless/realtek/rtw89/efuse.c
> +++ b/drivers/net/wireless/realtek/rtw89/efuse.c
> @@ -185,8 +185,8 @@ static int =
rtw89_dump_physical_efuse_map_dav(struct rtw89_dev *rtwdev, u8 *map,
>        return 0;
> }
>=20
> -static int rtw89_dump_physical_efuse_map(struct rtw89_dev *rtwdev, u8 =
*map,
> -                                        u32 dump_addr, u32 dump_size, =
bool dav)
> +static int __rtw89_dump_physical_efuse_map(struct rtw89_dev *rtwdev, =
u8 *map,
> +                                          u32 dump_addr, u32 =
dump_size, bool dav)
> {
>        int ret;
>=20
> @@ -208,6 +208,25 @@ static int rtw89_dump_physical_efuse_map(struct =
rtw89_dev *rtwdev, u8 *map,
>        return 0;
> }
>=20
> +static int rtw89_dump_physical_efuse_map(struct rtw89_dev *rtwdev, u8 =
*map,
> +                                        u32 dump_addr, u32 dump_size, =
bool dav)
> +{
> +       int retry;
> +       int ret;
> +
> +       for (retry =3D 0; retry < 5; retry++) {
> +               ret =3D __rtw89_dump_physical_efuse_map(rtwdev, map, =
dump_addr,
> +                                                     dump_size, dav);
> +               if (!ret)
> +                       return 0;
> +
> +               rtw89_warn(rtwdev, "efuse dump (dav=3D%d) failed, =
retrying (%d)\n",
> +                          dav, retry);
> +       }
> +
> +       return ret;
> +}
> +
> #define invalid_efuse_header(hdr1, hdr2) \
>        ((hdr1) =3D=3D 0xff || (hdr2) =3D=3D 0xff)
> #define invalid_efuse_content(word_en, i) \

I=E2=80=99ve run some boot tests and this also resolves my efuse map =
use-case, e.g.

ROCK5B:~ # dmesg | grep rtw89
[    6.506375] rtw89_8852be 0002:21:00.0: loaded firmware =
rtw89/rtw8852b_fw-1.bin
[    6.506539] rtw89_8852be 0002:21:00.0: enabling device (0000 -> 0003)
[    6.516069] rtw89_8852be 0002:21:00.0: Firmware version 0.29.29.15 =
(6fb3ec41), cmd version 0, type 5
[    6.516083] rtw89_8852be 0002:21:00.0: Firmware version 0.29.29.15 =
(6fb3ec41), cmd version 0, type 3
[   10.153731] rtw89_8852be 0002:21:00.0: efuse dump (dav=3D0) failed, =
retrying (0)
[   10.405347] rtw89_8852be 0002:21:00.0: chip info CID: 0, CV: 1, AID: =
0, ACV: 1, RFE: 1
[   10.408311] rtw89_8852be 0002:21:00.0: rfkill hardware state changed =
to enable

So far I haven=E2=80=99t observed more than 1x retry being required, and =
there are no
issues with loading the BT module.

Would you like me to send a v2 using your revised version? - or?

Christian=

