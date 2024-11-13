Return-Path: <linux-wireless+bounces-15284-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2F49C7EF8
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Nov 2024 00:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AAEE2845A3
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2024 23:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A5218BB82;
	Wed, 13 Nov 2024 23:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWEypVQ8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C0518A6A0
	for <linux-wireless@vger.kernel.org>; Wed, 13 Nov 2024 23:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731542026; cv=none; b=on8ErX6bLcNeSHxXCaVwYnSajniumxMrqU1r1I3b1Rm+GXxmUcb9TylI4y6gXaeMt5Wr6GlvZceJNhAfAf47Z/kuGzOUAtIIzsWpcMszhkGcAXhLusla/FA3tR8Chn00PGL6IiPwvM+JWX5lPHI4mxhaWZ+IWF1yebGJbsDMHUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731542026; c=relaxed/simple;
	bh=If1DvvIB6vkZ8JGD0CaaCCO3Trur9rplfNY8c1r/Udo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=D2V39g80clquX2disywZQ3qpfArhH5XdQN+RgceV0SP0QczEwvBEA34d7D1AjP04g7XolkrdrYE4i13QbivVZ+Kc93mkYeRXVHM7DzstrlhD8+/32VHzbSnBFCQ4zkUTd7FCx54YAfBVRRIYs9tye+5FAM7193KiN1CoBczX2HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FWEypVQ8; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c9693dc739so4454a12.3
        for <linux-wireless@vger.kernel.org>; Wed, 13 Nov 2024 15:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731542023; x=1732146823; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DRIx3vNpv/A2SIxwp5mIAG1lrj4ZG/XYEWQ5bACVJGk=;
        b=FWEypVQ802IXPilkwCe9nF7/ThwWW1vDD5O9OvCFFahI1UdyKwJcN6GRq7ZRakMhRA
         g2lbqo8MGKi4URhLM2LYUwp1jMVfcC7HiKZUoc0P8nqA6vQv00+fjDqrNU8jtDZMBA4i
         C60+HGUWdgAmQDmUsz9+0BHiQtfbTu1fZwG9n6nupHNML/XFyHwqaB+tvOeqNlieHvc+
         BjaYngTJ+98GaknIzfgEKr0C2OZN7SDjgE38NmiGdkPz4lVXr0iKXpJ1tPu3Yld0Dd46
         PHT1wuaVW/NR+JhDHBiwlpGzZz8sA2Wp8tToyFSdLnbSJH3F1eNd9KvfZGdGrEsaBTmJ
         a4Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731542023; x=1732146823;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DRIx3vNpv/A2SIxwp5mIAG1lrj4ZG/XYEWQ5bACVJGk=;
        b=L+UEuspa11nxfTbUviS13PgloGJDWORxEjtMb1JOTl8jm/GOYC1V1jW8G3ZK+sr5iF
         HiBkzwDFeB8y8PNtBGXPq1clB56flX/aE7W3Fs3PFkzPn+QSJXruM10/+lgSpet4j/Ew
         xhfkDIuBA4/dWx71/zLrlps+PlkluqZ7xFf93TcJrQ46TvC1pZDxaX2HpBuL3lgHAEKm
         zd9x7Dvn4CaSwzTfu29UV8NTJgI7WX8s+qnuGlZAzxaASfTH9XvUkr8ZK0IQN7Osvv9+
         xBNA42/rlNtRc+ykCVhTPXkA1vEXifynKq841DUd2r88yHBc+gxzaTePaZt3RmdUAJnj
         YdHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwPMx4GrNSkWDwX30pxqIAQrN/InjHDIVt1IVQDW/C5G+QTA/WENbwdlBsEV3/aOj4Aqko2L2/aNHUFksG4w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxJD+RUrdg1p4dpmMNb5NOHao8PKrptsVRSeAPGi8bCpjQdUA61
	WKB2iu2DUB2fqawMqZAvUat8lLe3fgQBfOJV9PiOWtT39yVy8l8y
X-Google-Smtp-Source: AGHT+IGwuLsQ1+N1U2LZdFevMsU+2ehwpNCqdS/cWBYxxVXcEWp1ZeY1Qlc65vqPCGW6s7/kdclDtQ==
X-Received: by 2002:a05:6402:6cc:b0:5cf:78b4:70c0 with SMTP id 4fb4d7f45d1cf-5cf78b47185mr68167a12.3.1731542022567;
        Wed, 13 Nov 2024 15:53:42 -0800 (PST)
Received: from [192.168.0.50] ([79.113.150.231])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03c4ee1fsm8087720a12.64.2024.11.13.15.53.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 15:53:41 -0800 (PST)
Message-ID: <8d43ed77-bac8-4748-a73f-dc7e5e234d10@gmail.com>
Date: Thu, 14 Nov 2024 01:53:38 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: [PATCH v4 3/7] wifi: rtw88: Add rtw88xxa.{c,h}
To: Kees Bakker <kees@ijzerbout.nl>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <435af284-0794-48e0-81a5-5a88b3c454bf@gmail.com>
 <b8590382-a954-412d-a96b-63e360b97acc@gmail.com>
 <9f95ac78-ed69-4554-825e-3ad294f49057@ijzerbout.nl>
Content-Language: en-US
In-Reply-To: <9f95ac78-ed69-4554-825e-3ad294f49057@ijzerbout.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/11/2024 22:04, Kees Bakker wrote:
> Op 30-10-2024 om 19:27 schreef Bitterblue Smith:
>> These contain code shared by both RTL8821AU and RTL8812AU chips.
>>
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> ---
>> v2:
>>   - Rename rtw8821a.{c,h} to rtw88xxa.{c,h}.
>>   - Rename functions to use the "rtw88xxa" prefix.
>>   - Rename struct rtw8821a_efuse to rtw88xxa_efuse.
>>   - Keep only the common code in this patch. The rest is in the next
>>     two patches now.
>>   - Fix copyright year.
>>   - Print hw_cap in rtw88xxa_read_usb_type.
>>   - Use pointer to rtwdev->efuse in rtw88xxa_get_bb_swing instead of
>>     making a copy of the struct.
>>   - Make rtw88xxa_get_swing_index return 24 instead of 0 by default.
>>   - Use new register definitions.
>>   - Delete rtw8821a_query_rx_desc. Use the new rtw_rx_query_rx_desc
>>     function instead.
>>   - Use u32_get_bits instead of FIELD_GET in
>>     rtw88xxa_false_alarm_statistics.
>>   - Use existing bit definitions for REG_CR bits instead of creating new
>>     ones.
>>   - Use existing name of REG_CCK0_FAREPORT instead of adding a new name.
>>   - Delete unnecessary braces and semicolons in switch statements.
>>   - Initialise arrays with {} instead of {0}.
>>   - Empty functions should have the braces on separate lines.
>>   - Include reg.h in rtw88xxa.h.
>>   - Make struct rtw8821au_efuse and rtw8812au_efuse __packed.
>>   - Delete most macros from rtw88xxa.h. Some were moved to reg.h, some
>>     were unused (inherited from rtw8821c.h).
>>   - Fix some indentation.
>>   - Use the correct IQK function for 8812au in the tx power tracking.
>>     v1 was accidentally using the IQK function meant for 8821au.
>>   - Rename struct rtw8821a_phy_status_rpt to rtw_jaguar_phy_status_rpt.
>>     It's shared by RTL8821AU and RTL8812AU, and maybe RTL8814AU in the
>>     future. These are all "Jaguar" chips.
>>   - Make struct rtw_jaguar_phy_status_rpt __packed.
>>   - Access struct rtw_jaguar_phy_status_rpt with le32_get_bits instead
>>     of bit fields.
>>
>> v3:
>>   - No change.
>>
>> v4:
>>   - No change.
>> ---
>>   drivers/net/wireless/realtek/rtw88/rtw88xxa.c | 1989 +++++++++++++++++
>>   drivers/net/wireless/realtek/rtw88/rtw88xxa.h |  175 ++
>>   2 files changed, 2164 insertions(+)
>>   create mode 100644 drivers/net/wireless/realtek/rtw88/rtw88xxa.c
>>   create mode 100644 drivers/net/wireless/realtek/rtw88/rtw88xxa.h
>> [...]
> 
>> +static void rtw88xxau_init_queue_reserved_page(struct rtw_dev *rtwdev)
>> +{
>> +    const struct rtw_chip_info *chip = rtwdev->chip;
>> +    struct rtw_fifo_conf *fifo = &rtwdev->fifo;
>> +    const struct rtw_page_table *pg_tbl = NULL;
>> +    u16 pubq_num;
>> +    u32 val32;
>> +
>> +    switch (rtw_hci_type(rtwdev)) {
>> +    case RTW_HCI_TYPE_PCIE:
>> +        pg_tbl = &chip->page_table[1];
>> +        break;
>> +    case RTW_HCI_TYPE_USB:
>> +        if (rtwdev->hci.bulkout_num == 2)
>> +            pg_tbl = &chip->page_table[2];
>> +        else if (rtwdev->hci.bulkout_num == 3)
>> +            pg_tbl = &chip->page_table[3];
>> +        else if (rtwdev->hci.bulkout_num == 4)
>> +            pg_tbl = &chip->page_table[4];
>> +        break;
>> +    case RTW_HCI_TYPE_SDIO:
>> +        pg_tbl = &chip->page_table[0];
>> +        break;
>> +    default:
> All other switch (rtw_hci_type(rtwdev)) in this module handle
> the default with an error. Shouldn't you be doing that here too?

I guess, if you want. I don't remember why there is no error here.

> In the default case the code continues with pg_tbl == NULL
> and thus it will crash.

The default case should be impossible to reach because we don't
have other interface types. And probably one of those other switch
statements is executed earlier, so this function wouldn't run.

>> +        break;
>> +    }
>> +
>> +    pubq_num = fifo->acq_pg_num - pg_tbl->hq_num - pg_tbl->lq_num -
>> +           pg_tbl->nq_num - pg_tbl->exq_num - pg_tbl->gapq_num;
>> +
>> +    val32 = BIT_RQPN_NE(pg_tbl->nq_num, pg_tbl->exq_num);
>> +    rtw_write32(rtwdev, REG_RQPN_NPQ, val32);
>> +
>> +    val32 = BIT_RQPN_HLP(pg_tbl->hq_num, pg_tbl->lq_num, pubq_num);
>> +    rtw_write32(rtwdev, REG_RQPN, val32);
>> +}
>> [...]


