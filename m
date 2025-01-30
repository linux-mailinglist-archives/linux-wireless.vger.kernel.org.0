Return-Path: <linux-wireless+bounces-18215-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8ECA22A12
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2025 10:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E9C53A5FB4
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2025 09:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B59D1AF0BA;
	Thu, 30 Jan 2025 09:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="IwauUJz7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9D018DF60
	for <linux-wireless@vger.kernel.org>; Thu, 30 Jan 2025 09:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738228331; cv=none; b=fzJm/HRUL/Tn3eNGWMZesoyCvchsQf+kcGxKqqMYcF4t00Aq1v6itTPeqzjPKvS+rHxn+5C3gRTt1HBTTriZxAGFDIrFfwvMEru87AFFQ2MjwJNnVw3wYp64eAGEQZ3eGgC5eZpDRBmlP4jTpfX7eUiT0p1QX1R3M9BEANQz/ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738228331; c=relaxed/simple;
	bh=lWpC4n2+wSADaONz3+LH+66IIPTLHl9Ex/u2BxN5GqU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XtUmbH4ig0NII0IR2RLpe1OrgW+gluIZH+6hoa6mOjC8MH3FhBVldADduwMGPX5pNg9tqyJn9e9pn3VOohms8WDYj84ATKlljS0d0FZOLmpNEC8J77A6OXPHxq091ITwa1oZcI7MS9l2W/EWzZrm5PR92Ixxp06gEZMkWKmvrs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=IwauUJz7; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 50U9C3t543430072, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1738228323; bh=lWpC4n2+wSADaONz3+LH+66IIPTLHl9Ex/u2BxN5GqU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=IwauUJz7b6gHK7V2UNFygYEj339RfNL2PlqaUcf1rT+zi/56CK92gs4LsI0xwtVkh
	 jlxHkz1NtE8+jsf1BKwAHRRZjMeraPOKPvWb6485+Qzc86JmE9FW0u5ATfGF3qp3ZP
	 SgEgo+z3VUO3yTXzpOYmA2jJ5eXEJgP6Qp4Fv3+07PNp+12PrtHKibrtDYUADfTyQ0
	 /djTW8iazIwDqluWptXZSSf5zRe9HPDCHqqANLTvkQwyPVG10VKO3z/u8EKlcIHp/S
	 lg92IQ0lA+dCXEtTIJ9Iw6bes3baxyuVJX5eU/lGxllPDuzZnRtVed3Xun2zvplNol
	 tQBNbvDIIgohA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 50U9C3t543430072
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jan 2025 17:12:03 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 30 Jan 2025 17:12:01 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 30 Jan 2025 17:12:00 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553]) by
 RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553%5]) with mapi id
 15.01.2507.035; Thu, 30 Jan 2025 17:12:00 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 5/7] wifi: rtw88: Extend rtw_fw_send_ra_info() for RTL8814AU
Thread-Topic: [PATCH 5/7] wifi: rtw88: Extend rtw_fw_send_ra_info() for
 RTL8814AU
Thread-Index: AQHbcEWMDvUgah16k02kcTsE1TgourMqKWuBgACTdYCAAPJSlIAAOz8AgAEf/jWAANX6gIABKpN5
Date: Thu, 30 Jan 2025 09:12:00 +0000
Message-ID: <975cf4b88f43484e8411764fd72d8313@realtek.com>
References: <fb2c2ae6-6173-4b4a-9e1f-ff51759cdee6@gmail.com>
 <fa9ff2b4-6e1a-45e4-90de-db6fe0d4f433@gmail.com>
 <ca7380d8560046c4a2a2badde9302691@realtek.com>
 <d05ba9e5-d5e3-4761-bd1e-f7c2b63f5a36@gmail.com>
 <53740c9ec74a4aa0a5a3c51b895eb385@realtek.com>
 <d80fe4e2-1e38-4e84-b169-8c2699d7c764@gmail.com>
 <1f04331c713141c68e6892751611d01e@realtek.com>,<86aae394-be5d-4fca-a68c-2ee02e5ab6af@gmail.com>
In-Reply-To: <86aae394-be5d-4fca-a68c-2ee02e5ab6af@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>On 29/01/2025 04:43, Ping-Ke Shih wrote:
>> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>>> On 28/01/2025 07:52, Ping-Ke Shih wrote:
>>>> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>>>>> On 27/01/2025 08:36, Ping-Ke Shih wrote:
>>>>>> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>>>>>>> The existing code is suitable for chips with up to 2 spatial stream=
s.
>>>>>>> Inform the firmware about the rates it's allowed to use when
>>>>>>> transmitting 3 spatial streams.
>>>>>>>
>>>>>>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>>>>>>> ---
>>>>>>>  drivers/net/wireless/realtek/rtw88/fw.c | 14 ++++++++++++++
>>>>>>>  drivers/net/wireless/realtek/rtw88/fw.h |  1 +
>>>>>>>  2 files changed, 15 insertions(+)
>>>>>>>
>>>>>>> diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/=
wireless/realtek/rtw88/fw.c
>>>>>>> index 02389b7c6876..0ca1b139110d 100644
>>>>>>> --- a/drivers/net/wireless/realtek/rtw88/fw.c
>>>>>>> +++ b/drivers/net/wireless/realtek/rtw88/fw.c
>>>>>>> @@ -735,6 +735,7 @@ void rtw_fw_send_ra_info(struct rtw_dev *rtwdev=
, struct rtw_sta_info *si,
>>>>>>>  {
>>>>>>>         u8 h2c_pkt[H2C_PKT_SIZE] =3D {0};
>>>>>>>         bool disable_pt =3D true;
>>>>>>> +       u32 mask_hi;
>>>>>>>
>>>>>>>         SET_H2C_CMD_ID_CLASS(h2c_pkt, H2C_CMD_RA_INFO);
>>>>>>>
>>>>>>> @@ -755,6 +756,19 @@ void rtw_fw_send_ra_info(struct rtw_dev *rtwde=
v, struct rtw_sta_info *si,
>>>>>>>         si->init_ra_lv =3D 0;
>>>>>>>
>>>>>>>         rtw_fw_send_h2c_command(rtwdev, h2c_pkt);
>>>>>>> +
>>>>>>> +       if (rtwdev->chip->rf_tbl[RF_PATH_C]) {
>>>>>>
>>>>>> Using `efuse->hw_cap.nss >=3D 3` would be consistent with latter pat=
ch.
>>>>>>
>>>>>
>>>>> I would like that, but nss is 2 when RTL8814AU is in USB 2 mode.
>>>>> I assume this is to keep the current draw under the 500 mA limit
>>>>> of USB 2.
>>>>>
>>>>> What about rtwdev->hal.rf_path_num >=3D 3 ? I don't remember why
>>>>> I didn't do that.
>>>>
>>>> I think `rtwdev->hal.rf_path_num >=3D 3` is suitable to initialize/con=
figure
>>>> hardware registers, because no matter USB 2 or 3 mode should be the sa=
me.
>>>>
>>>> For this case (RA info), this is related to protocol, so I feel
>>>> `efuse->hw_cap.nss >=3D 3` is suitable, but I have not seen a patch to=
 declare
>>>> supported NSS in register_hw(), or I missed it? Or, without RA_INFO_HI=
,
>>>> it gets abnormal rate to RTL8814AU in your test?
>>>>
>>>
>>> You didn't miss it, that will be in part 3. You can see the code here:
>>>
>>> https://github.com/lwfinger/rtw88/blob/21a3fa7ec11a0cbb3be14145f45cdca3=
5c3d3217/rtw8814a.c#L82
>>>
>>
>> I feel we should clearly define the meaning. What I thought for 8814AU a=
re:
>>  - hal->rf_type: hardware capability. Should be RF_3T3R no matter USB 2 =
or 3.
>>  - hal->antenna_tx: the antenna for current TX. Can be 2 antenna.
>>  - hal->antenna_rx: the antenna for current RX. Can be 2 antenna.
>>  - efuse->hw_cap.nss: read from efuse. So this will be 3SS for USB 2/3.
>> If you have better defnitiion, please share your ideas.
>>
>
> If efuse->hw_cap.nss is always 3, how to limit the spatial streams
> to 2 in USB 2 mode?

That's a proposal only, because I felt `efuse->hw_cap.nss` read from efuse
should be persistent, but it is fine to define desired meaning.=20

I would like to confirm if USB devices will not switch USB 2/3 mode
after USB probe? If so, `efuse->hw_cap.nss` is also a kind of persistent.
Then, using `efuse->hw_cap.nss` seems fine.=20


