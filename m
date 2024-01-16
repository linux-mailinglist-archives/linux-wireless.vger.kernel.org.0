Return-Path: <linux-wireless+bounces-2069-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 279FB82FD06
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jan 2024 23:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FDEB1C282C6
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jan 2024 22:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C44605C8;
	Tue, 16 Jan 2024 22:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Z3a1OGNv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD23605B0
	for <linux-wireless@vger.kernel.org>; Tue, 16 Jan 2024 22:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705442854; cv=none; b=MS8hMAHjPtDXhNEB9P9dxkYHHio0T4ZN/hMWtEBEf/0Z4RbpPDLWcGtBKxRfXetku+8F4zOr8qyEnDPTvLW2QCS17wr3dvXWwGUWdmst2XDysxLFRr03xxWAFjw7NhMLvdCqAEXTb+hRA7VI5hboJTVLijrNlLesrbNq4PDT6ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705442854; c=relaxed/simple;
	bh=8HbyhdNq5i5cOdX64qo255fpPIJ4KvI/Xt8HdsxAl9E=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type; b=GFzRW+MK+iWzLUIeKZClPJj0dK6ssNuRkPREvHNW1T36sLWuVjyALr3LjXacifIcckEhpYUQ4/8OIGwK3hWenuePFmqF1sbtx5SZ0L1oTAdS1erJvp5kbaazzJYsgDayvSOvF1s/vC9dnqv0pXrpu32PW5jhR7tR2s5xAic2P94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Z3a1OGNv; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d3eb299e2eso62537185ad.2
        for <linux-wireless@vger.kernel.org>; Tue, 16 Jan 2024 14:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1705442852; x=1706047652; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2njzd9If4l1tNfPFrSJsa6VwcJ1xY7G9RdJRZLc5hTw=;
        b=Z3a1OGNvpvHQUFUsOAM/A1Pi2akBw/hE2OBqh2ukulf+Q2CHI5PhHQFpnmU6aGaRqN
         6PaRnbQH+Ks96Dh95jzzwlK4Xq/SG8TAEnKCmszoyknDk2+sn+ib7k9XiKc+obR7q8oQ
         O7Nfq4P3CuBn/RblA8ioiztgO0uwqm69Yfhohw4oakjtyM2JCTatJ/0QhMOhWwZKINOF
         YSIlukbhrGdsxunNWnPCIJkCGkJni5b1lDjSzUcz9dBqIIqGYyqq5V8M1wWyZ+Bhyfsd
         zM2LN4oDM+KjDVcJKAkCyYoOJffgdfVuXPvUbJSESkwWgjcGjjAGHxGj/A1wkKIyITS4
         03mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705442852; x=1706047652;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2njzd9If4l1tNfPFrSJsa6VwcJ1xY7G9RdJRZLc5hTw=;
        b=slegOy3HluuUyFdugAywmIeWA3EjpqbXE9991wntwB4tGeyoP9pyyigX90p+/usy5z
         AXFsRx1e6kZMFBv2c9suJ5MTZIddC9srM993QLYZ8vdoaAwVx9xbHSQy+3SqFaOmdqey
         0fJdoBoCW8m+tFHGLY2jpQnooD4yQM+bBUFmVdhWlzJ0o73OLdNOjphCFHSiiv7L0lTy
         FJRMu2fT5KducCWUSskXgWIHX2EsIFrJFFldf1iFg6acVYHSlj2ILB3Cbm0aerKqIGpU
         gxdbvqRihfWo674CEeiQOcF3RtnFjj+Ar6WfxtlX5BmtQ7wksSNMDF157+1cxo9F003Q
         ufBQ==
X-Gm-Message-State: AOJu0YzZxsw+4xsB0+0S3lYHRDncU38RYLx/YMW56YX1XyEysvRNfRP3
	XqT0I29X68r6nO/rrVYJOmwp6zbLVrc0X8nolXY=
X-Google-Smtp-Source: AGHT+IGiYgk5Yc5t9nJFPZ/Wzuyk+pJ97jpp0GXFqcERsKjxMAVllrrAVWIClyxzEzE6PA8+ab9dzv74l7pWLIsVnh4=
X-Received: by 2002:a17:902:d4c7:b0:1d5:a557:e628 with SMTP id
 o7-20020a170902d4c700b001d5a557e628mr5723742plg.119.1705442851614; Tue, 16
 Jan 2024 14:07:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <36972ff5-0c48-4bd2-8f9a-9649bfa24225@lexina.in>
 <11c7333aee0d45fd9fbfc65f6e2a3aa2@realtek.com> <216e8522-fa56-4d54-ae32-74c6008a2075@lexina.in>
 <0969b1ca039e423dbcc41de18db023c6@realtek.com> <cc54a8b2-2fea-406c-8d4a-24ddfd34f983@lexina.in>
 <0be52db8941c4e609bfda6c69a14184e@realtek.com> <CAFBinCDT2Pj_BYqCtk+i7y8LPU2qwah-4Scdq29ONBqs3wt0pQ@mail.gmail.com>
 <8192e59807e14525b821317a5f550ea4@realtek.com>
In-Reply-To: <8192e59807e14525b821317a5f550ea4@realtek.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Tue, 16 Jan 2024 23:07:20 +0100
Message-ID: <CAFBinCBf2XM-W8-_YEGXydy4kLHHar7Fv5=GoKddjE9f0hTkAw@mail.gmail.com>
Subject: Re: rtw88: rtl8822cs AP mode not working
To: Ping-Ke Shih <pkshih@realtek.com>, Viacheslav <adeep@lexina.in>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
	=?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000005b144c060f175b28"

--0000000000005b144c060f175b28
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ping-Ke and Viacheslav,

On Mon, Jan 15, 2024 at 3:17=E2=80=AFAM Ping-Ke Shih <pkshih@realtek.com> w=
rote:
[...]
> > > I don't have this kind of wifi cards, could you help to check if AP m=
ode
> > > works in your side?
> > I'll check that in the next few days.
AP mode is also not working for me, I get the same problem as
Viacheslav reported.

> > Also I'm wondering where code enables beacons (is it
> > rtw_core_enable_beacon() or is there another relevant function?).
> > Knowing that would be helpful to analyze this further.
>
> The main function to get and set beacon template to firmware is
> rtw_fw_download_rsvd_page(). The basic concept is to put beacon frame via
> qsel=3DBCN to a special TX FIFO area called "reserve page", and then
> hardware/firmware will send beacon in interval of 100ms.
Thanks for the explanation - that helped me find a better starting point!

I didn't have much time in the past few days, but I have some findings
and questions:
1) I found the following comment/code in the downstream driver [0]:
/*
 * Disable Hw protection for a time which revserd for Hw sending beacon.
 * Fix download reserved page packet fail that access collision with
the protection time.
 */
val8 =3D rtw_read8(adapter, REG_BCN_CTRL_8822C);
restore[1] =3D val8;
val8 &=3D ~BIT_EN_BCN_FUNCTION_8822C;
val8 |=3D BIT_DIS_TSF_UDT_8822C;
rtw_write8(adapter, REG_BCN_CTRL_8822C, val8);

This is not part of the upstream rtw88 driver, so I made a patch and
attached it.
Unfortunately it doesn't fix the problem.

2) PCI is the only HCI which does not need the checksum in the
pkt_Info (USB and SDIO need the checksum).
The checksum is added by rtw_tx_fill_txdesc_checksum() which is only
called in usb.c and sdio.c.
My understanding is that for reserved pages we can have more than one
pkt_info in the buffer (my starting point for this thought is
rtw_fill_rsvd_page_desc() from fw.c).
In usb.c and sdio.c we're only calculating the checksum for the very
first pkt_info, not for any subsequent ones (I didn't even know that
it's possible to have more than one pkt_Info outside of RX and TX
aggregation).
However, it seems that the downstream code calculates the TX checksum
for *all* pkt_info in the buffer, see [1]
This code is missing from rtw88 at the moment. Since I didn't have
time I did not try to implement this yet.

3) Has anybody tried AP mode with rtw88 on a (supported) USB chipset?
If my thought (from #2) is correct then AP mode would show the same
problems there.

4) Viacheslav, I think you previously mentioned that you did a bit of
work with the downstream driver.
It would be awesome if you could also take a look at the rtw88 and
downstream driver code and start comparing them (logic that's
different or completely missing from rtw88 is suspicious).


Best regards,
Martin


[0] https://github.com/chewitt/RTL8822CS/blob/60cd82134d63aa9436b43c42933a8=
6d6e5a191ba/hal/rtl8822c/rtl8822c_ops.c#L1885-L1893
[1] https://github.com/chewitt/RTL8822CS/blob/main/hal/rtl8822c/sdio/rtl882=
2cs_xmit.c#L311-L312

--0000000000005b144c060f175b28
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="rtw_fw_write_data_rsvd_page-write-REG_FWHW_TXQ_CTRL_2.diff"
Content-Disposition: attachment; 
	filename="rtw_fw_write_data_rsvd_page-write-REG_FWHW_TXQ_CTRL_2.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lrgwbgai0>
X-Attachment-Id: f_lrgwbgai0

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvZncuYyBiL2Ry
aXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvZncuYwppbmRleCAzZjAzN2RkY2VjZjEu
LjIyZDI2NjViOWY1OCAxMDA2NDQKLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9y
dHc4OC9mdy5jCisrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvZncuYwpA
QCAtMTQzNyw3ICsxNDM3LDcgQEAgdm9pZCBydHdfYWRkX3JzdmRfcGFnZV9zdGEoc3RydWN0IHJ0
d19kZXYgKnJ0d2RldiwKIGludCBydHdfZndfd3JpdGVfZGF0YV9yc3ZkX3BhZ2Uoc3RydWN0IHJ0
d19kZXYgKnJ0d2RldiwgdTE2IHBnX2FkZHIsCiAJCQkJdTggKmJ1ZiwgdTMyIHNpemUpCiB7Ci0J
dTggYmNrcFsyXTsKKwl1OCBiY2twWzNdOwogCXU4IHZhbDsKIAl1MTYgcnN2ZF9wZ19oZWFkOwog
CXUzMiBiY25fdmFsaWRfYWRkcjsKQEAgLTE0NjIsOCArMTQ2MiwxNCBAQCBpbnQgcnR3X2Z3X3dy
aXRlX2RhdGFfcnN2ZF9wYWdlKHN0cnVjdCBydHdfZGV2ICpydHdkZXYsIHUxNiBwZ19hZGRyLAog
CXZhbCB8PSBCSVRfRU5TV0JDTiA+PiA4OwogCXJ0d193cml0ZTgocnR3ZGV2LCBSRUdfQ1IgKyAx
LCB2YWwpOwogCi0JdmFsID0gcnR3X3JlYWQ4KHJ0d2RldiwgUkVHX0ZXSFdfVFhRX0NUUkwgKyAy
KTsKKwl2YWwgPSBydHdfcmVhZDgocnR3ZGV2LCBSRUdfQkNOX0NUUkwpOwogCWJja3BbMV0gPSB2
YWw7CisJdmFsICY9IH5CSVRfRU5fQkNOX0ZVTkNUSU9OOworCXZhbCB8PSBCSVRfRElTX1RTRl9V
RFQ7CisJcnR3X3dyaXRlOChydHdkZXYsIFJFR19CQ05fQ1RSTCwgdmFsKTsKKworCXZhbCA9IHJ0
d19yZWFkOChydHdkZXYsIFJFR19GV0hXX1RYUV9DVFJMICsgMik7CisJYmNrcFsyXSA9IHZhbDsK
IAl2YWwgJj0gfihCSVRfRU5fQkNOUV9ETCA+PiAxNik7CiAJcnR3X3dyaXRlOChydHdkZXYsIFJF
R19GV0hXX1RYUV9DVFJMICsgMiwgdmFsKTsKIApAQCAtMTQ5MCw3ICsxNDk2LDggQEAgaW50IHJ0
d19md193cml0ZV9kYXRhX3JzdmRfcGFnZShzdHJ1Y3QgcnR3X2RldiAqcnR3ZGV2LCB1MTYgcGdf
YWRkciwKIAlyc3ZkX3BnX2hlYWQgPSBydHdkZXYtPmZpZm8ucnN2ZF9ib3VuZGFyeTsKIAlydHdf
d3JpdGUxNihydHdkZXYsIFJFR19GSUZPUEFHRV9DVFJMXzIsCiAJCSAgICByc3ZkX3BnX2hlYWQg
fCBCSVRfQkNOX1ZBTElEX1YxKTsKLQlydHdfd3JpdGU4KHJ0d2RldiwgUkVHX0ZXSFdfVFhRX0NU
UkwgKyAyLCBiY2twWzFdKTsKKwlydHdfd3JpdGU4KHJ0d2RldiwgUkVHX0ZXSFdfVFhRX0NUUkwg
KyAyLCBiY2twWzJdKTsKKwlydHdfd3JpdGU4KHJ0d2RldiwgUkVHX0JDTl9DVFJMLCBiY2twWzFd
KTsKIAlydHdfd3JpdGU4KHJ0d2RldiwgUkVHX0NSICsgMSwgYmNrcFswXSk7CiAKIAlyZXR1cm4g
cmV0Owo=
--0000000000005b144c060f175b28--

