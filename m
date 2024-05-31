Return-Path: <linux-wireless+bounces-8366-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB9F8D6B4A
	for <lists+linux-wireless@lfdr.de>; Fri, 31 May 2024 23:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A80DE1F2A793
	for <lists+linux-wireless@lfdr.de>; Fri, 31 May 2024 21:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F77E7FBA3;
	Fri, 31 May 2024 21:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ERmm+edW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4F978C6F
	for <linux-wireless@vger.kernel.org>; Fri, 31 May 2024 21:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717189833; cv=none; b=Y3eOudBnzb1umVF1BVf11KWeu9NgF2PxGhENsQIJEvnZwJ7GyLPu+JH2H4leNObarYzoZE2e70iuY7WDar2npk+JpTEP72KPuMcL6kNxlBgGdeiSZbx37g/FmgN3ZKxmUBXdrNq9utaAR+/D9CiY1chEnkhrUhOhExp6JAulCw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717189833; c=relaxed/simple;
	bh=l7RroDrsayCA/oexVYeIPg+q9TYUAlpowWmIABNkvQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mEPZU3gaGxIBJnnAjYYpx1GKosn00trhUUi/6xgfEJFlAaSQcK1q1bH+JhINvyHW1JAA81BBa7uRGmxTuzUwpg0MsvQ2XeSVP40Efi+st9R1pqFVHAgyEJXTycXKiUzhjqdCSdMijnI0CDVFd7TDuFsbE86RaE79E8sr/Neh968=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ERmm+edW; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-35a264cb831so2116124f8f.2
        for <linux-wireless@vger.kernel.org>; Fri, 31 May 2024 14:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717189829; x=1717794629; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CpvOdzD6SH4b19hLcPsehVs7J2qb/3ZgTdIuyb0YZiQ=;
        b=ERmm+edWF00IK2npyH4xWAMKoeZopcyNw0DdlnvVg63hjiS8Z3CaQyAhZS1tCSBM2f
         eNx+T1Qxuwv/+9/MYoOfgLp2C7vdeNwm/LUKv0A0ytiBwbflMa/qKFBCki37NW9sSyWJ
         EchZxaSqiZ9t+3BYVq5cckx57M/qP6+UYNKNprxrJqk7e1WEZIMcNpVt8x8ngL2BKjS8
         bw1a9RUGKLyTMiiUGLfayIE8mVlPOnz3rDa+HM3wNDKopg4Z8h8L9y2fEBc7dYuHd2bs
         sZwFDrEl1fdea412zTPVIxPCJ6ILmQ0Fj2u0vOKY3q1/ypgvN1N/xvh+daTJIjfOF0NA
         qp+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717189829; x=1717794629;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CpvOdzD6SH4b19hLcPsehVs7J2qb/3ZgTdIuyb0YZiQ=;
        b=RxA6T3Rm0jRJuQAwdvOGbFi7TZAtXrPV9YizE1fhbodYzNyIrb0M1DxqqjNZKVVKll
         KKdGLuXxdg8RTBaqqLNhIpeNO49638WadViwrto51UpvaZDr/KC97YPg3uSel0hi3bjE
         EXFjwqq7V1zXWbaGDGI27sp128+lMZXGNG81Xk+Xu+1H+AMR5KBoBrkRgh2OC/7vTi4o
         m71rEgEAdJvemmg+CSAoeax6OU5T8LeK5bTq92lHymmj+D8qhdbYInnNauol27RUEBnm
         dppVzUiAh0TqS+mfOZgEt6xdgiOeLv5hxuRXDR5xglEmD3FVKAOp4A4Sx5P4pXdbahrB
         BEkQ==
X-Forwarded-Encrypted: i=1; AJvYcCW055LCeX23je5jm6CyroGUnpe7FHk2UBWIE+dHR5CdVJxIGpJSug8FCfCzXR6xK2VMd0IllXIE4U4lc0J8CG65dSMnWkVe3Nabt6uBiu0=
X-Gm-Message-State: AOJu0Yx0iDzZjRn7k0ZcHefjZh4d2UJpiWfErO1YrDwPPq1zcshN4aCz
	Hs66Q7TD251RL7NP2RB609M9JIrvdW3yMGCFSKTWe9cT/ffl9C6D
X-Google-Smtp-Source: AGHT+IGe6VcGaKpZbcpvZdkxQZCGjjMF7U/K1ixBi320ruF5KD7w8WzgXtUQ8pR3lbo6WwUU5D5f7A==
X-Received: by 2002:adf:f787:0:b0:354:fc03:b44 with SMTP id ffacd0b85a97d-35e0f25c39amr1894521f8f.4.1717189828723;
        Fri, 31 May 2024 14:10:28 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd062ee05sm2651203f8f.82.2024.05.31.14.10.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 May 2024 14:10:28 -0700 (PDT)
Message-ID: <6c341295-0f2b-4b8d-af6d-4e2746e56ddc@gmail.com>
Date: Sat, 1 Jun 2024 00:10:26 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: rtw88: usb: Further limit the TX aggregation
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Sascha Hauer <sha@pengutronix.de>
References: <0996d2d0-e7b8-4e43-ba12-63074ba9df1b@gmail.com>
 <c1f41ca8bd7d49e4801d620089ae0a4d@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <c1f41ca8bd7d49e4801d620089ae0a4d@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/05/2024 09:36, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> Currently the number of frames sent to the chip in a single USB Request
>> Block is limited only by the size of the TX buffer, which is 20 KiB.
>> Testing reveals that as many as 13 frames get aggregated. This is more
>> than what any of the chips would like to receive. RTL8822CU, RTL8822BU,
>> and RTL8821CU want at most 3 frames, and RTL8723DU wants only 1 frame
>> per URB.
>>
>> RTL8723DU in particular reliably malfunctions during a speed test. All
>> traffic seems to stop. Pinging the AP no longer works.
>>
>> Fix this problem by limiting the number of frames sent to the chip in a
>> single URB according to what each chip likes.
>>
>> Also configure RTL8822CU, RTL8822BU, and RTL8821CU to expect 3 frames
>> per URB.
>>
>> RTL8703B may or may not be found in USB devices. Declare that it wants
>> only 1 frame per URB, just in case.
>>
>> Tested with RTL8723DU and RTL8811CU.
>>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> ---
>>  drivers/net/wireless/realtek/rtw88/mac.c      | 12 ++++++++++++
>>  drivers/net/wireless/realtek/rtw88/main.h     |  2 ++
>>  drivers/net/wireless/realtek/rtw88/reg.h      |  1 +
>>  drivers/net/wireless/realtek/rtw88/rtw8703b.c |  1 +
>>  drivers/net/wireless/realtek/rtw88/rtw8723d.c |  1 +
>>  drivers/net/wireless/realtek/rtw88/rtw8821c.c |  1 +
>>  drivers/net/wireless/realtek/rtw88/rtw8822b.c |  1 +
>>  drivers/net/wireless/realtek/rtw88/rtw8822c.c |  1 +
>>  drivers/net/wireless/realtek/rtw88/usb.c      |  4 +++-
>>  9 files changed, 23 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/wireless/realtek/rtw88/mac.c b/drivers/net/wireless/realtek/rtw88/mac.c
>> index 0dba8aae7716..fca90759c268 100644
>> --- a/drivers/net/wireless/realtek/rtw88/mac.c
>> +++ b/drivers/net/wireless/realtek/rtw88/mac.c
>> @@ -1186,6 +1186,7 @@ static int __priority_queue_cfg(struct rtw_dev *rtwdev,
>>  {
>>         const struct rtw_chip_info *chip = rtwdev->chip;
>>         struct rtw_fifo_conf *fifo = &rtwdev->fifo;
>> +       u8 val8;
>>
>>         rtw_write16(rtwdev, REG_FIFOPAGE_INFO_1, pg_tbl->hq_num);
>>         rtw_write16(rtwdev, REG_FIFOPAGE_INFO_2, pg_tbl->lq_num);
>> @@ -1201,6 +1202,17 @@ static int __priority_queue_cfg(struct rtw_dev *rtwdev,
>>         rtw_write16(rtwdev, REG_FIFOPAGE_CTRL_2 + 2, fifo->rsvd_boundary);
>>         rtw_write16(rtwdev, REG_BCNQ1_BDNY_V1, fifo->rsvd_boundary);
>>         rtw_write32(rtwdev, REG_RXFF_BNDY, chip->rxff_size - C2H_PKT_BUF - 1);
>> +
>> +       if (rtwdev->hci.type == RTW_HCI_TYPE_USB) {
>> +               val8 = rtw_read8(rtwdev, REG_AUTO_LLT_V1);
>> +               u8p_replace_bits(&val8, chip->usb_tx_agg_desc_num,
>> +                                BIT_MASK_BLK_DESC_NUM);
>> +               rtw_write8(rtwdev, REG_AUTO_LLT_V1, val8);
> 
> rtw_write8_mask(rtwdev, REG_AUTO_LLT_V1, BIT_MASK_BLK_DESC_NUM, chip->usb_tx_agg_desc_num);
> 
>> +
>> +               rtw_write8(rtwdev, REG_AUTO_LLT_V1 + 3, chip->usb_tx_agg_desc_num);
>> +               rtw_write8_set(rtwdev, REG_TXDMA_OFFSET_CHK + 1, BIT(1));
>> +       }
>> +
>>         rtw_write8_set(rtwdev, REG_AUTO_LLT_V1, BIT_AUTO_INIT_LLT_V1);
>>
>>         if (!check_hw_ready(rtwdev, REG_AUTO_LLT_V1, BIT_AUTO_INIT_LLT_V1, 0))
>> diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
>> index 49894331f7b4..49a3fd4fb7dc 100644
>> --- a/drivers/net/wireless/realtek/rtw88/main.h
>> +++ b/drivers/net/wireless/realtek/rtw88/main.h
>> @@ -1197,6 +1197,8 @@ struct rtw_chip_info {
>>         u16 fw_fifo_addr[RTW_FW_FIFO_MAX];
>>         const struct rtw_fwcd_segs *fwcd_segs;
>>
>> +       u8 usb_tx_agg_desc_num;
>> +
> 
> Please keep order of field and instance declaration, like rtw8703b_hw_spec.
> 
>>         u8 default_1ss_tx_path;
>>
>>         bool path_div_supported;
>> diff --git a/drivers/net/wireless/realtek/rtw88/reg.h b/drivers/net/wireless/realtek/rtw88/reg.h
>> index b122f226924b..572651b3aa4b 100644
>> --- a/drivers/net/wireless/realtek/rtw88/reg.h
>> +++ b/drivers/net/wireless/realtek/rtw88/reg.h
>> @@ -270,6 +270,7 @@
>>  #define BIT_MASK_BCN_HEAD_1_V1 0xfff
>>  #define REG_AUTO_LLT_V1                0x0208
>>  #define BIT_AUTO_INIT_LLT_V1   BIT(0)
>> +#define BIT_MASK_BLK_DESC_NUM  0xf0
> 
> 0xf0 --> GENMASK(7, 4)
> 
>>  #define REG_DWBCN0_CTRL                0x0208
>>  #define BIT_BCN_VALID          BIT(16)
>>  #define REG_TXDMA_OFFSET_CHK   0x020C
>> diff --git a/drivers/net/wireless/realtek/rtw88/rtw8703b.c
>> b/drivers/net/wireless/realtek/rtw88/rtw8703b.c
>> index 8919f9e11f03..222608de33cd 100644
>> --- a/drivers/net/wireless/realtek/rtw88/rtw8703b.c
>> +++ b/drivers/net/wireless/realtek/rtw88/rtw8703b.c
>> @@ -2013,6 +2013,7 @@ const struct rtw_chip_info rtw8703b_hw_spec = {
>>         .tx_stbc = false,
>>         .max_power_index = 0x3f,
>>         .ampdu_density = IEEE80211_HT_MPDU_DENSITY_16,
>> +       .usb_tx_agg_desc_num = 1, /* Not sure if this chip has USB interface */
> 
> The position to declare this field is very different from others. 
> 
> Not sure when we messed up the order, but please don't feel free to add one,
> keep the order. 
> 
> If you have time, could you help to align all of them across chips?
> If not, I will take my time to do that after your patch. 
> 

Sure, I will do that.

