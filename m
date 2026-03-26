Return-Path: <linux-wireless+bounces-33965-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMhMAIQhxWmC7AQAu9opvQ
	(envelope-from <linux-wireless+bounces-33965-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 13:07:32 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68450334F0B
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 13:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8EFAA303A84D
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 12:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D1A364E8E;
	Thu, 26 Mar 2026 12:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ci22nx+6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DA33939DF
	for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 12:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774526689; cv=none; b=CMN7MuEakVck79ZTzgUizkPen89jE5sgIPHaqBWI1zWdloioXnqh1JkTMhUmAS9SPo9ZY9eCoSeEXcLake3r5ZIXJM/GkDuE6A+LqXfrj+yYxEd1QAg49koizAZIz3Gfzh7Cddub5oGCKy+OWLYD53+3F2BT+pj+ygbVi9SOv/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774526689; c=relaxed/simple;
	bh=HW1LfeLtIEoM0GoFebKEb5zJoULSOkvabYtx1yBYaRU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=b25FGRLaSVujkiYWstVXVfLL6zXcLhLFLHzUxj8Wh12YxEriJlkG9r0zbJRMDeMH6TIDkKEhDItnNPwrPp8yMvobJDKPMkcsk202hzVcH1nDKBU7nHTOrcmDupdzhSxFHaHjUC8vxfVu+aUjwe8P128/OSJNRfsb8O8QHBxfSt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ci22nx+6; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-439b611274bso452857f8f.3
        for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 05:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774526686; x=1775131486; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jjbPm0KCpfMLj8VkAJXpYX5vhwfhBPh2NKkyQ1aVTIQ=;
        b=ci22nx+6i1alBEbOrHXtWeWA/DFk1+o5SzYVB2L6ppShC4QRd5xA4Wg0B9fG1iTN9M
         X62MlOjrYVXWf9pcgbkhzKNZ6HLYtfIIyN8BqSm2K7evaHf2TT91FhubQ8/FwC/Xfb/r
         fIDtx9Z837evNQ8g8vumO/j3IRDuHTXhCVFMQ2XKB0SO6ZwKNARjqwy/7iMKelguIBLk
         pa6qm504IWc76BkfrLSS86MvWD+fCX2L4Udmkq64/H/jDruCZYV2WKuQ7pB0aEkVuqZ8
         sEOQHZtFCB0wz8kCNE+hpD/iFohoEr/eEV97rIEmcA/hDBUYb4Q75HmAzMBBmY7Ov8xO
         UeAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774526686; x=1775131486;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jjbPm0KCpfMLj8VkAJXpYX5vhwfhBPh2NKkyQ1aVTIQ=;
        b=ArDWM/nZ6OowVDUPsym+CQxnKOos+H9oQLODt7NqU3DpQOzQPtmQQaHCEOTFoOkhXR
         g+it/6PMIRcjF8FDc+uDLnJIPYEDiqnX6++mhyr2ZLiXMCLIC8ZtxY+UH4/0sglMhSRC
         d2Yw06Nn6W8nCCwESXGAYBM6f1GI63FbqZUh9V4HHd4M6BFu0hfZ10qPt5zjt1gbMkUe
         nfoB12lEQDRx0wsi5Sj2xmUwpHLMI9pE8JHCNXHDVjC3bdSfKt1CFqjQDCn/Kal/SNPZ
         KY0H+gfp0aPtR80uq+GefoHldjvkt1SMixdrhbBY8e13fINBUBpk1xgZb9PHiyy6fjSj
         WrgA==
X-Forwarded-Encrypted: i=1; AJvYcCWjXKoJ1oNi5hfUj38+eIHbAk82EVXgBhNU/pgPhrIEQZMbyiPUMG9u72AApjOK1l6Rhg4bwxowowmjY2UfHg==@vger.kernel.org
X-Gm-Message-State: AOJu0YynqBS4o1sgfFxTlLeywMOMKISTyYcIbAWglZNtZcGa84GHiGcc
	m82odkICwgWJq9KyAWHdYfYcg2z8FJV1htdnLr9YMeR1ICDDFJ37X7+v
X-Gm-Gg: ATEYQzxB4+XCRAPilVS+gEuVnDGUAAj5/2DlDkFzReO0/bII9dGIz5ElnWzvU6VTVO0
	hsix0RMtLQUECWJSsy8KemqfQ4b20Hei2TQunSwc3FkrZmYxp3dLDXpcMDW2k6U/+0+sLG4lViI
	RFC1XfNgd8g8vmVaTx0C59q94Naq1CSFTrlu418+242l+guhiGwzxfTse5cYRKTsXTvHzOTEkDq
	MIDdZFlSB1E7OFoKwHmR/E3KPQQ05tSCcdCDKDZFcEcmupD+darqPsAU7nMBVZDSWC8ubkvpex4
	sgaNBg42ze/CnfJdLZ4C63nO64nZzoDcY00hV6x9iZPezMVBtVDXUKtkKQCBy0kUdTQBnEhFS1i
	Xf5keU4SeXeitFuxYfMjH5hW618VQO/oq59sPRKe9lnbI51Lbghil8WxTWL7n3e4iD7US79vW1J
	LpUPzivY2NfxIYOPUGJvQrJl1kRgZfxQ==
X-Received: by 2002:a5d:44c3:0:b0:43b:8fa4:1937 with SMTP id ffacd0b85a97d-43b8fa41a01mr5869154f8f.5.1774526686296;
        Thu, 26 Mar 2026 05:04:46 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b919cf5aesm8433418f8f.24.2026.03.26.05.04.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 05:04:45 -0700 (PDT)
Message-ID: <857919ae-e0bb-4dc8-9145-4071ac28cec0@gmail.com>
Date: Thu, 26 Mar 2026 14:04:43 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rtw-next] wifi: rtw89: Fill fw_version member of struct
 wiphy
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <60bdb2f8-d5dd-46a3-8679-5b4a5fd0604b@gmail.com>
 <9c25a5eee4194356b4d0210b2bace5f2@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <9c25a5eee4194356b4d0210b2bace5f2@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33965-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rtl8821cerfe2@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 68450334F0B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 26/03/2026 03:55, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> Let userspace tools like lshw show the firmware version by filling the
>> fw_version member of struct wiphy.
>>
>> Before:
>>
>> configuration: broadcast=yes driver=rtw89_8852au
>> driverversion=6.19.6-arch1-1 firmware=N/A link=no multicast=yes
>> wireless=IEEE 802.11
>>
>> After:
>>
>> configuration: broadcast=yes driver=rtw89_8852au
>> driverversion=6.19.6-arch1-1 firmware=0.13.36.2 link=no multicast=yes
>> wireless=IEEE 802.11
>>
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> ---
>>  drivers/net/wireless/realtek/rtw89/fw.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/net/wireless/realtek/rtw89/fw.c
>> b/drivers/net/wireless/realtek/rtw89/fw.c
>> index 45d8c5e70084..55aee6eb8478 100644
>> --- a/drivers/net/wireless/realtek/rtw89/fw.c
>> +++ b/drivers/net/wireless/realtek/rtw89/fw.c
>> @@ -755,6 +755,14 @@ static int rtw89_fw_update_ver(struct rtw89_dev *rtwdev,
>>                    fw_suit->major_ver, fw_suit->minor_ver, fw_suit->sub_ver,
>>                    fw_suit->sub_idex, fw_suit->commitid, fw_suit->cmd_ver,
>> type);
>>
>> +       if (type == RTW89_FW_NORMAL || type == RTW89_FW_NORMAL_CE ||
>> +           type == RTW89_FW_NORMAL_B)
>> +               snprintf(rtwdev->hw->wiphy->fw_version,
>> +                        sizeof(rtwdev->hw->wiphy->fw_version),
> 
> nit: how about defining a local variable wiphy? as well as rtw88.
> 

Okay, I will do that.

>> +                        "%u.%u.%u.%u",
>> +                        fw_suit->major_ver, fw_suit->minor_ver,
>> +                        fw_suit->sub_ver, fw_suit->sub_idex);
>> +
>>         return 0;
>>  }
>>
>> --
>> 2.53.0
> 


