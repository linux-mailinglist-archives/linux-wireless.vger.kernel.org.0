Return-Path: <linux-wireless+bounces-14220-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 756309A4400
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2024 18:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20B301F23602
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2024 16:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520F056B81;
	Fri, 18 Oct 2024 16:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NN07WTjX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F649202F9A
	for <linux-wireless@vger.kernel.org>; Fri, 18 Oct 2024 16:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729269721; cv=none; b=nAxjH3bPxEWnfqlaS9LrL2lDiY9ZEZNqOq7fLmNhDrMJooBvDKXpnjkvSrZ1cz0XcKwsVL+xstIO9ZpoRVed/B4rGsM4lReNa1XBi3ya8mSGLydN44nM/rGC1X+ziZPfQedHgjtbYt/yp1LevquiT6eggw5QtUAdHCeqSl3bBes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729269721; c=relaxed/simple;
	bh=Z0PSUxMs5C8rL8r1FMjVfS1mhHkld6BaVmO+JiwO8uU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=RxkCnfBrplgqTKHot7sK52aYI1hio2HXL+WDb7tp0+C1jL0KWysxoA0uluVXpMiizoIJr5xopya5Im2m240yYLyeymjP1gVE7qIJS/tL3vSc9DbK7c7/h1EbJr7O6s89RMc5h22d8TjrpsMUhx+YfTyjTUZXfju0ChWMCra4zEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NN07WTjX; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37d808ae924so1581946f8f.0
        for <linux-wireless@vger.kernel.org>; Fri, 18 Oct 2024 09:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729269717; x=1729874517; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I3pMffVc5TJktf3tfTSI/BahiZHf9zbHayzCeZ+ShD4=;
        b=NN07WTjXDgDOkMrmb2OEq0Uz6y8olYaJ1lVuRgdI6Wq23ytiBAJRbMJUbd5XB9GGPF
         qXARIuH99KP5hefBgBdTEYjt1Ui3mtmkdKR2JHBeL3YFtG6rWoAjxV3qqE861o00P65N
         mZHw6tr1s/7eBQ0xsEIW0eql3LWELfvlN6p5GG6p8ylk2OvKhCT25OGo9syMO0C0p5KO
         OnW85G+IcK6J4Ca0N16slOid37MVWqOfx/aK40gVRC/mWd5pQCWYpnjgb0L0gszW/M+D
         ZjNvSeB/AuiJJTzWTXisoypow8lbgaMcVQCAEDawosuk9D+2Zcvjzps88I0F9eajIWJh
         ZMaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729269717; x=1729874517;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I3pMffVc5TJktf3tfTSI/BahiZHf9zbHayzCeZ+ShD4=;
        b=wQ9OJVZJ/6xs2/Ncgdt0EKJgSrBA8RLPvMekBskxjXEAtXzO+Rsd2prlypcHVMAbVX
         i7zqiW6jrT19vrnIntZDGZ1o1aO3L1DsiaLJTlmYN7aO8GKkLBEQGhjTRhkhlcxwLfUq
         H+KITmeESX45urLcBNYwPJz2trJGu1+qjdE9BikyC3K4GHKmeQ8KW1fMZuJCe58wlo/v
         pKavGELUkp3c8tKOAeHqJ52UrX/OeNjITfCkE/ofqlcmBE+nBPWcMAaczrhB4IIrFFyp
         hGlEJKxPad7POCHufvbnC1aFm7SJvh94b/iMzBkOlIK2ASMSTjRP9r5Ebb7ESvz6+csE
         oSjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRPp0Fsd5D3150ZkQuo9x20GIR27huRiETMEjr0H16I1phobxa9tFZugjom1EpyW3CBSG8CS+BC3GYoOqzDA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyU4Nq/m8h4raMJN0jCnc9qAGt4m6NeiowJ7FWOofiaOeIS/4KS
	re5qFQjuENv6PGgPYx8iKJVhWVqwk8qc8rjDzy1oxTUNc4ufQrWId+UwKQ==
X-Google-Smtp-Source: AGHT+IEfXtHZB5P1N1Vs0sYEQZLNr0xksGCm+HF8z44HQmf8n2NLJ3Qp3kawSz74ToHRMqEuV7IgTA==
X-Received: by 2002:a5d:6d03:0:b0:37d:47b0:6adc with SMTP id ffacd0b85a97d-37eab4d1248mr2946900f8f.4.1729269717274;
        Fri, 18 Oct 2024 09:41:57 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.150.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ecf0ed7bfsm2317544f8f.84.2024.10.18.09.41.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2024 09:41:56 -0700 (PDT)
Message-ID: <fbbc4a6c-dd51-4c7e-bc25-d0a53691d807@gmail.com>
Date: Fri, 18 Oct 2024 19:41:56 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: [PATCH v2 10/22] wifi: rtw88: Move pwr_track_tbl to struct
 rtw_rfe_def
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <d2870a44-9b91-4090-9a25-873eb62997f5@gmail.com>
 <46e4f978-7dc3-447b-a744-a4ea7654ab5b@gmail.com>
 <2429b39cb60941bca351455e1eed7a24@realtek.com>
Content-Language: en-US
In-Reply-To: <2429b39cb60941bca351455e1eed7a24@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/10/2024 09:41, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
>> index ef82e60d5c19..072d09a7d313 100644
>> --- a/drivers/net/wireless/realtek/rtw88/main.h
>> +++ b/drivers/net/wireless/realtek/rtw88/main.h
>> @@ -1100,16 +1100,19 @@ struct rtw_rfe_def {
>>         const struct rtw_table *phy_pg_tbl;
>>         const struct rtw_table *txpwr_lmt_tbl;
>>         const struct rtw_table *agc_btg_tbl;
>> +       const struct rtw_pwr_track_tbl *pwr_track_tbl;
>>  };
>>
>> -#define RTW_DEF_RFE(chip, bb_pg, pwrlmt) {                               \
>> +#define RTW_DEF_RFE(chip, bb_pg, pwrlmt, track) {                                \
>>         .phy_pg_tbl = &rtw ## chip ## _bb_pg_type ## bb_pg ## _tbl,       \
>>         .txpwr_lmt_tbl = &rtw ## chip ## _txpwr_lmt_type ## pwrlmt ## _tbl, \
>> +       .pwr_track_tbl = &rtw ## chip ## _pwr_track_type ## track ## _tbl, \
>>         }
>>
>> -#define RTW_DEF_RFE_EXT(chip, bb_pg, pwrlmt, btg) {                      \
>> +#define RTW_DEF_RFE_EXT(chip, bb_pg, pwrlmt, track, btg) {                       \
> 
> Why not keep the same order of struct declaration? 
> 
> I guess you want first three arguments of RTW_DEF_RFE() and RTW_DEF_RFE_EXT()
> are the same, right?

Yes.

> Move ' pwr_track_tbl' entry in struct upward one line as
> below order?
> 

Right, I didn't consider that.

>>         .phy_pg_tbl = &rtw ## chip ## _bb_pg_type ## bb_pg ## _tbl,       \
>>         .txpwr_lmt_tbl = &rtw ## chip ## _txpwr_lmt_type ## pwrlmt ## _tbl, \
>> +       .pwr_track_tbl = &rtw ## chip ## _pwr_track_type ## track ## _tbl, \
>>         .agc_btg_tbl = &rtw ## chip ## _agc_btg_type ## btg ## _tbl, \
>>         }
>>
> 


