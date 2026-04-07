Return-Path: <linux-wireless+bounces-34492-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGfpGhls1Wm96AcAu9opvQ
	(envelope-from <linux-wireless+bounces-34492-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 22:42:01 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F333B4A0E
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 22:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D091301DAD3
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2026 20:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB742126C17;
	Tue,  7 Apr 2026 20:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q1cnBBcs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0B7379EEF
	for <linux-wireless@vger.kernel.org>; Tue,  7 Apr 2026 20:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775594518; cv=none; b=bc1diX5uXij4WyMuhTr6DHK9IP+XE0GcufKyI95LN78YcDQ1jsNjQ6WqxBPN3R3yrjDIlQw3Icq5+c93guJ9NO53RQ0Uve7TLbtjS47IlZ+dL8aTa1D0LUcPEND0/MWvqW8UaYgElVlorh9iBYRr8szVGUcI2x3YYJwVwqcmBwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775594518; c=relaxed/simple;
	bh=6E33cF5eENWn+ODPAABTPO0KklZ6lyAjIMWoWsddMW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cPXD/38rjxdpdjCdOd5cQtPKJuezloXligBJAmIYeFu2pF0DwY3gERt3TU5m/Z16hvaL7IkfmxX1LL/VPI3xi6N4YARrLtg/QJqoxwZ0CrNGoixvh3+nPUBNyAvNDt2hiZJQ7dzpLaNq/Zvzv6rTMeIzJNtRIkpIhwAeiAYRUsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q1cnBBcs; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so50812395e9.0
        for <linux-wireless@vger.kernel.org>; Tue, 07 Apr 2026 13:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775594515; x=1776199315; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IIZepUTaDX41TxFVMbEKDikeA0mvwv+R2Cxv0WTMC+k=;
        b=q1cnBBcsi2PrVN72qiickWQtUMMlXVFSFHkpBOUV0vt8TKj9RjUE4JvZ3qmc9pdlQG
         ENMHgzPdSp53QqdASOhCj2XOWdpXaufBgDj3PKYWxwO/ufkNwSp2Zty+kd3fU014iA/A
         U0Eay7TwO+wbO58iuYK/4m6T+QGC9OQSUQEE9ICvG56kkfPn+rd2cTBHRuhLa/Lz0woi
         Z8uLnv/eYgG9d36gTu6B0kr2GUTSN2iyT7G4v0WSq7ZRxUi5AKInr28NZVXmU69fJmef
         NW6eAZwN2qFpbxX5joRkk/liAmlfMaat1Ug6pmknuZ1xvbsRcVQfdObIPSyGUHSlqSZT
         YDRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775594515; x=1776199315;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IIZepUTaDX41TxFVMbEKDikeA0mvwv+R2Cxv0WTMC+k=;
        b=LFAxzHwoTSpcdL66/+ILLb8EoTjOWc7/QJEINrFFpRy5SezT9PVQ/gkpc9ECHhF4Dg
         oZ0HQkb1I2IP0bL09ftwyOShm/H41tHY7J+1RfTCWx7Q23+2uVUKwhuE/Of3E1JVac93
         +sRbPCEQ4cPuNU6+u9ENrxo6KSIBPH+XhrQzEPYaSyhRW4lmawDs9hk+TjEiDj9pFXny
         VbDIpENBYmILJTrxq5KOgT0W1p3+4L2iHlYoClYZFnax1f8z3apSnb0YfP+c/dxHL4uT
         BTIxhHOvkXouAY2FB7d/0pNoDLhlT03x+FYcApCUu1qA76mGIAlfjGJHoNuw6VGeTpRJ
         u5iQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmnbGRfZjjnBFDmjqL6WctmedBct8Sm2WoiDT6F4f0+M4BXuFojAVcL5/5yeClT95W18hK6juEXguepSKHLg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxcJOqCPi7y3Ru1Ghi+3Bs7UzYaOKYcIX+BoLQnOdRN0XKDfkQE
	/3rbUQ4FTzXYurpMwPTZx+VJRtLrJ4smhih2zuBz43pEH6RdLoMfNC0c+Wtvcg==
X-Gm-Gg: AeBDieuL/mj+e0DTJt+/ViNXL+FdO90tAPus45NFMD2aDCUqimUTla64kubpvjF5hPS
	M1rpg/yOyfdDG2md9873Mnr/u5qOIlWa0a4pFeYSyYyu+0lnoutUdPrkhMmtlny3V0IKoYKT2xn
	hJBL6eFwEzWV3kcYJjdgB6hndU2gI8YlJkvEC32x8r0EHUROT5EL5K1GyI1MrhrGFDgsNgna7MC
	98n5lDYp6QWQt6Fotu+j4n+t8gjXc5/0A+NDxo81aTq6ontXXrfH2tWP3gpSlKn/lDnNiw+uyvS
	TDsVie5vzkZc5FQBJFQqRjHkIz3XDdLPRxFPSnoDzfnNadew7U6byCA4IBFtJKzj7sOZnzMYrgC
	0YQYAnOo4KJJqKReT6joMNBHx6CRALHeESGz2PJ+RMEjJBPFfBs14Huf3RwDBMD/E6vjBFV+048
	bg1Tnp/NjI7VTBc9DC1A/Iauy3EmQx1g==
X-Received: by 2002:a05:600c:621a:b0:488:af7f:7707 with SMTP id 5b1f17b1804b1-488af7f7fd3mr137613935e9.18.1775594515142;
        Tue, 07 Apr 2026 13:41:55 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488c55d1347sm5918335e9.4.2026.04.07.13.41.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2026 13:41:54 -0700 (PDT)
Message-ID: <e8d10b96-f305-46f4-a473-2592f237f871@gmail.com>
Date: Tue, 7 Apr 2026 23:41:52 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rtw-next 00/12] wifi: rtw89: Add support for RTL8922AU
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <8549233f-dd83-4e77-be88-5e22ecd4f5f1@gmail.com>
 <25781f4aa6cc427caf396374ca46d380@realtek.com>
 <a90f22d6-bac0-4c76-86fb-517e7e7bf441@gmail.com>
 <0cbfd38ffd0b46e899885c83889d060b@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <0cbfd38ffd0b46e899885c83889d060b@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34492-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rtl8821cerfe2@gmail.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: B8F333B4A0E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 02/04/2026 03:48, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> On 30/03/2026 05:53, Ping-Ke Shih wrote:
>>> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>>>> Often one or more of these messages appears when the chip powers on:
>>>>
>>>> [  +2.167037] rtw89_8922au 1-2:1.0: failed to wait RF DACK
>>>>
>>>> [  +2.942749] rtw89_8922au 1-2:1.0: failed to wait RF TSSI
>>>>
>>>> [  +0.019006] rtw89_8922au 2-4:1.0: failed to wait RF PRE_NTFY
>>>>
>>>> [  +5.985900] rtw89_8922au 2-4:1.0: failed to wait RF DPK
>>>>
>>>> It's unclear why.
>>>
>>> RTL8922D done RF calibrations by firmware one by one, so driver should
>>> wait for previous one done, and trigger next one. However, it'd be
>>> well to just do waiting at the last to wait for all calibrations.
>>>
>>> Try to enlarge waiting time in rtw8922a_rfk_channel().
>>>
>>
>> I was convinced I tried that already, but no.
>>
>> After increasing all delays a bit the warnings are much more rare.
> 
> Turn of debug mask RTW89_DBG_RFK and set a very large timeout time, and
> do connection >20 times and then check "RF %s takes %lld ms to complete"
> to see the maximum value in your environment.
> 
> Please share the number for each RF calibration after your experiments.
> 

I changed every delay to 500, then ran this, once with the adapter in
USB 2, once in USB 3:

for i in {01..20}; do nmcli connection up "<2.4 GHz SSID>"; sleep 10; nmcli connection up "<5 GHz SSID>"; sleep 10; done

There were no "failed to wait RF" warnings.

These are the results after processing with "sort --unique":

RF DACK takes 15 ms to complete
RF DACK takes 16 ms to complete
RF DACK takes 44 ms to complete
RF DACK takes 72 ms to complete

RF DPK takes 23 ms to complete
RF DPK takes 24 ms to complete
RF DPK takes 27 ms to complete
RF DPK takes 30 ms to complete

RF IQK takes 48 ms to complete
RF IQK takes 49 ms to complete
RF IQK takes 50 ms to complete

RF PRE_NTFY takes 0 ms to complete
RF PRE_NTFY takes 1 ms to complete

RF RX_DCK takes 8 ms to complete
RF RX_DCK takes 9 ms to complete
RF RX_DCK takes 11 ms to complete
RF RX_DCK takes 23 ms to complete
RF RX_DCK takes 24 ms to complete
RF RX_DCK takes 27 ms to complete
RF RX_DCK takes 38 ms to complete
RF RX_DCK takes 39 ms to complete
RF RX_DCK takes 53 ms to complete
RF RX_DCK takes 54 ms to complete
RF RX_DCK takes 58 ms to complete
RF RX_DCK takes 70 ms to complete
RF RX_DCK takes 110 ms to complete

RF TSSI takes 1 ms to complete
RF TSSI takes 2 ms to complete
RF TSSI takes 23 ms to complete
RF TSSI takes 24 ms to complete

RF TXGAPK takes 9 ms to complete
RF TXGAPK takes 10 ms to complete
RF TXGAPK takes 17 ms to complete
RF TXGAPK takes 18 ms to complete

I also left it unconnected and constantly scanning for a few minutes.
RTW89_TSSI_SCAN always takes 1-2 ms.

>>
>>>>
>>>> It seems to work well anyway.
>>>>
>>>
>>> If you can yield the highest rate (MCS13), I'd say it is fine.
>>>
>>> Ping-Ke
>>>
>>
>> Testing with RTL8832CU (Brostrend AX8) in AP mode, the RTL8912AU can
>> reach 1.5 Gbps (MCS10) RX, 1 Gbps TX.
>>
>> I used the RTL8832CU because my router is not working well with 160
>> MHz.
> 
> Since rtw89 only support beamformee (no beamformer), beamforming can't
> work between two rtw89 devices. More, two antenna can't have good
> beamforming performance. I think this is a point that it is hard to
> yield the highest rate. 
> 
> Another point may be the RF performance. If the warning messages of
> RF calibration disappeared, I'd say this might not a problem.
> 
> Let's mention this in commit message of 12/12.
> 
> Ping-Ke
> 


