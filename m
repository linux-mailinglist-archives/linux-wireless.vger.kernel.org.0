Return-Path: <linux-wireless+bounces-6461-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4FE8A8A08
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Apr 2024 19:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81EAB1C22958
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Apr 2024 17:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B5714199C;
	Wed, 17 Apr 2024 17:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1O9kQ6j"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04F0171644
	for <linux-wireless@vger.kernel.org>; Wed, 17 Apr 2024 17:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713374036; cv=none; b=JlUTjxUgEhiYcZj819G0K2iKlXa5bH1R56ybzkiAOls/t+mGUyJv1SPtZv+3FLt8u4KmV+awP3nEopvFuDRNm4W8lcpM2Rbc4deJkeIBGMLssUCRR0yyFPC6qojPEVJbRCVp4H0ZAEmYPnfzev6lE/1HPTLmWf5q1RTE8XU4eSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713374036; c=relaxed/simple;
	bh=1IvqYcz/CE7rvYXzn0+cuNugMxFUnJR7ptn3yAoVOEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lbuPwRSY697vtOuK1OycqJPTIxtGzT2G2XHIyXnxAhXZk3P4segSGstc8omB9pcUaCv5gaV8wSwEFVmN3aH6Y4/iyJGIwSBqUiTf7rms4V6pmDFn0bG2cBmEDEzblsEqT5zLRXHBDDPzOPGAtXmCs7AJZ5S2vs/O7AQrTfUzWKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D1O9kQ6j; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-418c979dca2so4897055e9.0
        for <linux-wireless@vger.kernel.org>; Wed, 17 Apr 2024 10:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713374033; x=1713978833; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GI7x4NpUKFJ5ifkFtV2OPTI16lqdGeJff9wapqBKW9o=;
        b=D1O9kQ6jQyii4sbnccmSdee4SqUvVsNYRA9CJ0buCD+MKPtQfu8coNK7mHEbqdmuh/
         8AaeAhTkJhR/1aF80ZoV0Fnk5m6smf0yFI4Y7L78//vHC64Eh76RetTVjT9OazAVtZHv
         D3C2g22lWnhnrGOJcsuC2jkRBVvCByGst01HRtR811ZZ447hMegicdtgz2WgFx72XaAG
         WWn/2IehRRebHvc2KgM4B44wUVSDU6pb3xDdqStmQPrelI/Gj0GuGmsaqEQAMelmlshF
         dv4x2AzFqAc5w6JUsup3JyX4PDdGSdu/YSDvPO/8dfSuS1mgIvkj3xiXrVaT5N50iCTa
         EbDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713374033; x=1713978833;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GI7x4NpUKFJ5ifkFtV2OPTI16lqdGeJff9wapqBKW9o=;
        b=e5XsWd7aHeiPh1hRriMIJHa1NG+dclzZ1RHZuVQ68UMj/O/Oahgm6MA5pYczm3VlJt
         LKyN4cOBSgm5+z/uit2rwDcbZx8YH5oikKEt/NzheXewLB2GBuuLbPp8ZE+QEKb8DDnp
         RAI30Q7yymgcGy3FNvO/e+C+te+5Ewn3Nh7hepiQsfqdbPMxgX/Y4axLDA9ZX1cVZsSO
         k7eNBqxklNI5pVpswgE8o3Vohg/9/xx2sRK0nv5CYCiVTOGxFzjC+kzRNSrIOOuCEwak
         xPxSgsqDPYOapkQT0ky/eJ4kb7IXSI1dWnlpB7/1hV+Lhm7bOdMN7yNah/yicT2bwymi
         qAEg==
X-Forwarded-Encrypted: i=1; AJvYcCUtvzLRjHcVMhq0gMvFyVmQvPSBOyB/x1zmx7YHYSyfJdBoIoOJcnTwe5s9GnelLT9ySMkZNe8j88DUlRD19DaJqn6P5ImiVhpPJW+uqqU=
X-Gm-Message-State: AOJu0Yzik3BP44AWhljVzfbb1kZXxB02uYBmj0gzW1VCNDuTfvZbnpIL
	q0IpDnNX1fgZahe10yJrERMq99LHFUwI6C9dGu3tUJyVs9/4wrLRj6D6c+E8
X-Google-Smtp-Source: AGHT+IEo3uH32pfBfTNv0r5+BKs191930sH+VxvbuLDPh833dY32UKzUwmpvTWmZcVDQe4TmnCrE/A==
X-Received: by 2002:a05:600c:3d9b:b0:418:d69e:6d0e with SMTP id bi27-20020a05600c3d9b00b00418d69e6d0emr176142wmb.39.1713374032695;
        Wed, 17 Apr 2024 10:13:52 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.154.240])
        by smtp.gmail.com with ESMTPSA id m4-20020a05600c4f4400b004186eb69a55sm3470119wmq.25.2024.04.17.10.13.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Apr 2024 10:13:52 -0700 (PDT)
Message-ID: <ad6057a1-9d3b-4b2c-ac47-5df688f5bed5@gmail.com>
Date: Wed, 17 Apr 2024 20:13:51 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/6] wifi: rtlwifi: Clean up rtl8192d-common a bit
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Larry Finger <Larry.Finger@lwfinger.net>,
 Stefan Lippers-Hollmann <s.l-h@gmx.de>,
 Christian Hewitt <chewitt@libreelec.tv>
References: <561cc9e4-3ddc-40cd-a076-2c14c44eea87@gmail.com>
 <4e47c56c-4b7f-4ae6-84b9-05f0cac97dac@gmail.com>
 <72bd1a7172154d4e9a79678e5151cdf3@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <72bd1a7172154d4e9a79678e5151cdf3@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/04/2024 09:48, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
> 
>> Improve readability:
>>  * add empty lines
>>  * use abs_diff in rtl92d_dm_txpower_tracking_callback_thermalmeter
>>  * roll up repeated statements into a for loop in
>>    rtl92d_dm_txpower_tracking_callback_thermalmeter
>>  * shorten lines by replacing many instances of "rtlpriv->dm" with "dm"
>>    pointer in rtl92d_dm_txpower_tracking_callback_thermalmeter
>>  * sort some declarations by length
>>  * refactor _rtl92d_get_txpower_writeval_by_regulatory a little
>>
>> Delete unused structs tag_dynamic_init_gain_operation_type_definition
>> and swat.
>>
>> Simplify rtl92d_fill_h2c_cmd a little and delete a pointless wrapper
>> function.
>>
> 
> [...]
> 
>> @@ -137,16 +135,18 @@ static void rtl92d_dm_rxgain_tracking_thermalmeter(struct ieee80211_hw *hw)
>>                 0x05, 0x04, 0x04, 0x03, 0x02
>>         };
>>         struct rtl_priv *rtlpriv = rtl_priv(hw);
>> +       int i, idx;
>>         u32 u4tmp;
>> -       int i;
>>
>> -       u4tmp = (index_mapping[(rtlpriv->efuse.eeprom_thermalmeter -
>> -                               rtlpriv->dm.thermalvalue_rxgain)]) << 12;
>> +       idx = rtlpriv->efuse.eeprom_thermalmeter - rtlpriv->dm.thermalvalue_rxgain;
>> +       u4tmp = index_mapping[idx] << 12;
>> +
>>         rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
>>                 "===> Rx Gain %x\n", u4tmp);
>> +
>>         for (i = RF90_PATH_A; i < rtlpriv->phy.num_total_rfpath; i++)
>>                 rtl_set_rfreg(hw, i, 0x3C, RFREG_OFFSET_MASK,
>> -                             (rtlpriv->phy.reg_rf3c[i] & (~(0xF000))) | u4tmp);
>> +                             (rtlpriv->phy.reg_rf3c[i] & ~0xF000) | u4tmp);
> 
> There are similar instances like 'tmp1byte &= ~(BIT(0));'
> Maybe, you can use coccinelle (spatch) as helper to convert all of them.
> 

Ehh, I don't want to learn one more tool right now.

> [...]
> 
>> @@ -713,22 +696,17 @@ void rtl92d_dm_false_alarm_counter_statistics(struct ieee80211_hw *hw)
>>                 falsealm_cnt->cnt_cck_fail = 0;
>>         }
>>
>> -       /* reset false alarm counter registers */
>> -       falsealm_cnt->cnt_all = falsealm_cnt->cnt_fast_fsync_fail +
>> -                               falsealm_cnt->cnt_sb_search_fail +
>> -                               falsealm_cnt->cnt_parity_fail +
>> -                               falsealm_cnt->cnt_rate_illegal +
>> -                               falsealm_cnt->cnt_crc8_fail +
>> -                               falsealm_cnt->cnt_mcs_fail +
>> +       falsealm_cnt->cnt_all = falsealm_cnt->cnt_ofdm_fail +
>>                                 falsealm_cnt->cnt_cck_fail;
> 
> Not sure why you did this change.
> 

It's repeated code. Those things are already added up into
cnt_ofdm_fail a few lines above.

> [...]
> 
>> @@ -228,35 +238,25 @@ static void _rtl92d_fill_h2c_command(struct ieee80211_hw *hw,
>>                         break;
>>                 }
>>         }
>> +
>>         while (!bwrite_success) {
>>                 wait_writeh2c_limmit--;
>>                 if (wait_writeh2c_limmit == 0) {
>>                         pr_err("Write H2C fail because no trigger for FW INT!\n");
>>                         break;
>>                 }
>> +
>>                 boxnum = rtlhal->last_hmeboxnum;
>>                 switch (boxnum) {
>> -               case 0:
>> -                       box_reg = REG_HMEBOX_0;
>> -                       box_extreg = REG_HMEBOX_EXT_0;
>> -                       break;
>> -               case 1:
>> -                       box_reg = REG_HMEBOX_1;
>> -                       box_extreg = REG_HMEBOX_EXT_1;
>> -                       break;
>> -               case 2:
>> -                       box_reg = REG_HMEBOX_2;
>> -                       box_extreg = REG_HMEBOX_EXT_2;
>> -                       break;
>> -               case 3:
>> -                       box_reg = REG_HMEBOX_3;
>> -                       box_extreg = REG_HMEBOX_EXT_3;
>> +               case 0 ... 3:
>> +                       box_reg = REG_HMEBOX_0 + boxnum * 4;
>> +                       box_extreg = REG_HMEBOX_EXT_0 + boxnum * 2;
> 
> Should be "* 4" as well?
> 
> box_extreg = REG_HMEBOX_EXT_0 + boxnum * 4;
> 

No, because they are only two bytes apart in this old chip:

#define REG_HMEBOX_EXT_0		0x0088
#define REG_HMEBOX_EXT_1		0x008A
#define REG_HMEBOX_EXT_2		0x008C
#define REG_HMEBOX_EXT_3		0x008E

>>                         break;
>>                 default:
>> -                       pr_err("switch case %#x not processed\n",
>> -                              boxnum);
>> +                       pr_err("switch case %#x not processed\n", boxnum);
>>                         break;
>>                 }
>> +
>>                 isfw_read = _rtl92d_check_fw_read_last_h2c(hw, boxnum);
>>                 while (!isfw_read) {
>>                         wait_h2c_limmit--;
>> @@ -266,78 +266,63 @@ static void _rtl92d_fill_h2c_command(struct ieee80211_hw *hw,
>>                                         boxnum);
>>                                 break;
>>                         }
>> +
>>                         udelay(10);
>> +
>>                         isfw_read = _rtl92d_check_fw_read_last_h2c(hw, boxnum);
>>                         u1b_tmp = rtl_read_byte(rtlpriv, 0x1BF);
>>                         rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD,
>>                                 "Waiting for FW read clear HMEBox(%d)!!! 0x1BF = %2x\n",
>>                                 boxnum, u1b_tmp);
>>                 }
>> +
>>                 if (!isfw_read) {
>>                         rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD,
>>                                 "Write H2C register BOX[%d] fail!!!!! Fw do not read.\n",
>>                                 boxnum);
>>                         break;
>>                 }
>> +
>>                 memset(boxcontent, 0, sizeof(boxcontent));
>>                 memset(boxextcontent, 0, sizeof(boxextcontent));
>>                 boxcontent[0] = element_id;
>> +
>>                 rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD,
>>                         "Write element_id box_reg(%4x) = %2x\n",
>>                         box_reg, element_id);
>> +
>>                 switch (cmd_len) {
>> -               case 1:
>> -                       boxcontent[0] &= ~(BIT(7));
>> -                       memcpy(boxcontent + 1, cmdbuffer + buf_index, 1);
>> -                       for (idx = 0; idx < 4; idx++)
>> -                               rtl_write_byte(rtlpriv, box_reg + idx,
>> -                                              boxcontent[idx]);
>> -                       break;
>> -               case 2:
>> -                       boxcontent[0] &= ~(BIT(7));
>> -                       memcpy(boxcontent + 1, cmdbuffer + buf_index, 2);
>> -                       for (idx = 0; idx < 4; idx++)
>> -                               rtl_write_byte(rtlpriv, box_reg + idx,
>> -                                              boxcontent[idx]);
>> -                       break;
>> -               case 3:
>> -                       boxcontent[0] &= ~(BIT(7));
>> -                       memcpy(boxcontent + 1, cmdbuffer + buf_index, 3);
>> -                       for (idx = 0; idx < 4; idx++)
>> -                               rtl_write_byte(rtlpriv, box_reg + idx,
>> -                                              boxcontent[idx]);
>> -                       break;
>> -               case 4:
>> -                       boxcontent[0] |= (BIT(7));
>> -                       memcpy(boxextcontent, cmdbuffer + buf_index, 2);
>> -                       memcpy(boxcontent + 1, cmdbuffer + buf_index + 2, 2);
>> -                       for (idx = 0; idx < 2; idx++)
>> -                               rtl_write_byte(rtlpriv, box_extreg + idx,
>> -                                              boxextcontent[idx]);
>> +               case 1 ... 3:
>> +                       boxcontent[0] &= ~BIT(7);
>> +                       memcpy(boxcontent + 1, cmdbuffer, cmd_len);
>> +
>>                         for (idx = 0; idx < 4; idx++)
>>                                 rtl_write_byte(rtlpriv, box_reg + idx,
>>                                                boxcontent[idx]);
>>                         break;
>> -               case 5:
>> -                       boxcontent[0] |= (BIT(7));
>> -                       memcpy(boxextcontent, cmdbuffer + buf_index, 2);
>> -                       memcpy(boxcontent + 1, cmdbuffer + buf_index + 2, 3);
>> +               case 4 ... 5:
>> +                       boxcontent[0] |= BIT(7);
>> +                       memcpy(boxextcontent, cmdbuffer, 2);
>> +                       memcpy(boxcontent + 1, cmdbuffer + 2, cmd_len - 2);
> 
> After reading these statements of "case 4...5", I eventually know how BIT(7) works.
> With BIT(7) additional two command buffers are introduced, and argument[0...1] are
> put into the new buffers. Maybe, we can add a comment to help people to understand
> this part.
> 
> case 1...3
>   BOX:      | ID | A0 | A1 | A2 |
>   BOX_EXT:  --- N/A ------
> 
> case 4...5
>   * ID ext = ID | BIT(7)
>   BOX:      | ID ext | A2 | A3 | A4 |
>   BOX_EXT:  | A0     | A1 |
> 
> [...]
> 

Okay, I will add it.

