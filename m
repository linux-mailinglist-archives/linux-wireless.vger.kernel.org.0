Return-Path: <linux-wireless+bounces-28201-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D8048C026EF
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Oct 2025 18:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F04914E89AD
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Oct 2025 16:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B0231354A;
	Thu, 23 Oct 2025 16:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="zeAEAE17"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026962D739C
	for <linux-wireless@vger.kernel.org>; Thu, 23 Oct 2025 16:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761236603; cv=none; b=DQP8Bc5zfBQL9DBJWS9riI5tu5qe32CO8QWX/v89TRNwK9NPRhvSvt7soHzFKbXuEDo0dofGNwdv9QKLIfhfvqwWuzZYR7rhYJq8ltIAS5bOd8r6FZG8FdGFK1G3LSrEnaIrUJh1QqyuCaPjiVQNk0CWX2n3k9L8h7MWHmwsh8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761236603; c=relaxed/simple;
	bh=oyBjQq+opdQ5Q3Ghkw4WepBxEqc65c8S54AaIatzO1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gy53JW3YtkoqSyzbFiiVPyymTADxj7Z8PlaMWvcTrOFULiP274gtII6u2WhOemyVIaRekYHzSBzn9U5pQggX/dUPKLhjX2Y3RQafskPh6xu8t6BSNenuvJ/rcC5QL27+oMEZLXFfXGLRqN1SBtcUimWvaRpWGLF/uWmDLKTmv+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=zeAEAE17; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47495477241so8664095e9.3
        for <linux-wireless@vger.kernel.org>; Thu, 23 Oct 2025 09:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1761236598; x=1761841398; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4QodlJJz7OBBOSw1T2Nek/nON+Bq4NCC6Jlg48xbTac=;
        b=zeAEAE17k9mR1yd4h8CbyHg/hR/x1mvXnn65gRrhltKsusytBpovYxtXtgdtncUDnv
         KpQ8/zPxt0MgHBt7PJmPOsCzsH0Z1XvX3VMkBtagr7XQWToEgP4UueNbxAjA3x2W3U69
         LpfMz99KuK2W1pRIuxqMTcU2XvOgl2PpcPD/tSm45LwX6aLNMWPsEOagFoY1KCbXesWi
         6UuGJ8wD6ABOuVQa6RWWB4/cwKq6b9ABKJxzHk+WBCLf0s3iPxBHfSE+PsIGB6iGUwib
         Sn5ji70gQejGVM917Q5CFPl0XXh9lPMGAKWp7OD5TqRq6+O/X6DFBXmeFBNxzvKqjod5
         af0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761236598; x=1761841398;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4QodlJJz7OBBOSw1T2Nek/nON+Bq4NCC6Jlg48xbTac=;
        b=UcJOg9/pnr7EOpRC3Wqb3yvnPpBLefZTo90VvYm9FvUaV3eHMWwko+ZY18rkmJjj1u
         HLh49JHahsyntrArS4D4rqZ3U9yrXmARhsjcuNIg41bd91/R9wOGpBKFSxEMSBf6nzQS
         sXFxa9llcLtwYsCKD197XDApGPGIQjc3NZhViAZKSWzF6HRNp7ts7kNlKZUmHhjs8sp5
         SrgUmAVt1aKrluq/qBHkcKs7cZa3OBBrb6H8PD6SAYGgRJ+k69BaDy7laSEjfWhMVEin
         o3NoO2Ou0BdHYuURhtetn7OI5fJDRnf0pLnutKQYGafVZO8FzEVWWapSlpVWZTgjah2k
         Qy2w==
X-Forwarded-Encrypted: i=1; AJvYcCWmNdweCsVxld6VezjkOgqNxDqfv0PZxhWt3FPhUdaXt7GxVYva/fkCfPI+N5TRNcpyYJn9S05A7jPHpAiJNA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/dMUYqI7kwyZ39d+DXon1Y7KIl9NYgSK0cpzeGes+FJVRvDg+
	Q4UAb7iF0Ss3HuUzl38SaJGNorI0xJmHQ1KXhxfeNQfLpz2qbJuH06cqxSXXsn1r+/o=
X-Gm-Gg: ASbGncsX7GWICDCUdUF8IDIm1+GZhRm1SHYREq3WfllxnoJXkEAst5fwGU+5PdKpd9P
	qQK7B0J0koA/fZpUHrqQPxoeAkqkta3dIEJ3+TRyALMIRXTP0gPd+w9KCNk1FVcvxKX6HWoI+Ia
	nuoLhFonu3W7/5JzDkXGvGn9iGLbWek9V5VAhDR6nrY4lwZDhkBo3RynHerWVwHsgo9S6U2XApG
	zzIhdu8QwaCuzNqmuJHbrD3XgMWzR8MrnGZIY62awK/9M8ZLjSM70coaMbZjEArRNvq7H77i6Jx
	ACfm5j4vsWUNy2kRetib/ypBTeYsiIjRWZ8VKNEcaxafjKL0DNd5Li+N0AloF96a17U/cMNBOum
	7GACKf0WI94I+vYF/rNmHdT8qt96nr8xzkZnvFkPS3N581geUvZnmBhRhMkEOl20uMC2PHiIdLS
	lY3ZZq16oqLItziA0ZTkxb3EKguEKqahk=
X-Google-Smtp-Source: AGHT+IGwQRC5KB/Hu+rraE9JlKM6GDwHr5qkHnIr5TrDAT466qZImWIg5fl0pscs/OszEp+d6FlRag==
X-Received: by 2002:a05:6000:1a8e:b0:428:1dca:ffdc with SMTP id ffacd0b85a97d-4298a0c0625mr2640658f8f.47.1761236598088;
        Thu, 23 Oct 2025 09:23:18 -0700 (PDT)
Received: from [192.168.108.124] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429898ecabdsm4963845f8f.47.2025.10.23.09.23.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 09:23:17 -0700 (PDT)
Message-ID: <189e59d4-95c4-4580-82b6-d6e952e87807@freebox.fr>
Date: Thu, 23 Oct 2025 18:23:16 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Extended Capabilities bit values overwritten by the kernel
To: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org,
 "hostap@lists.infradead.org" <hostap@lists.infradead.org>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
References: <cd2ec7dc-1987-4f8b-8c5a-1f420a2de3c7@freebox.fr>
 <1062167f6dfed8384d36f8f9f1d61a46c4b04c61.camel@sipsolutions.net>
Content-Language: en-US
From: Pablo MARTIN-GOMEZ <pmartin-gomez@freebox.fr>
In-Reply-To: <1062167f6dfed8384d36f8f9f1d61a46c4b04c61.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 23/10/2025 17:24, Johannes Berg wrote:
> On Thu, 2025-10-23 at 15:13 +0200, Pablo MARTIN-GOMEZ wrote:
>> Hello all,
>>
>> I've encountered an issue with an ath12k & hostapd based AP: whatever
>> value I put in `he_twt_responder` and `he_twt_responder` in the hostapd
>> config, I always have the bit `TWT Responder Support` set to 1 in the
>> Extended Capabilities IE. This happens because hostapd overwrites all
>> the bit values of the Extended Capabilities bitmap set in the config
>> with the values coming from the kernel (ext_capa_mask) since commit
>> 8cd6b7bce8b8f1fe2803bc17ddf0f51bd07330b1 (hostapd), and in the case of
>> the ath12k (and also ath11k), the driver sets
>> WLAN_EXT_CAPA10_TWT_RESPONDER_SUPPORT in ext_capa_mask. I'm unsure on
>> how to fix this: should hostapd be change so the kernel values can be
>> overwritten by the config, or are the kernel values an invariant that
>> shall not be overwritten and therefore ath12k should be modified
>> so WLAN_EXT_CAPA10_TWT_RESPONDER_SUPPORT is only set in the user space
>> or elsewhere in the driver dynamically. I'm taking the example with TWT
>> Responder and ath12k, but I believe other drivers are concerned (e.g.
>> TWT Requester Support and iwlwifi).
> You're probably the only/first person to ever want to _remove_
> capabilities that the driver has :)
It is more a question of testing a capability and its performance's 
impact than to remove it completely :)
> Somehow it appears that we never considered the case of a capability
> that's _completely_ implemented in mac80211/driver/device but someone
> explicitly does _not_ want to advertise it.
It's bit more complicated than that, at least in the case of TWT 
Responder in ath12k.  When we don't set NL80211_ATTR_TWT_RESPONDER flag 
in hostapd, the ath12k driver sends a command to the device to disable 
TWT, so we end up in a situation where the device does not support the 
feature anymore but we are still advertising its support in the 
capabilities IE.
> I'm not sure I know what the right solution is ... Obviously not
> advertising some features could easily be done in hostapd/wpa_s by just
> clearing the bits you don't want, but that wouldn't actually disable the
> feature in the lower level. So it'd probably work for TWT responder, but
> not for TWT requester maybe, if the request would be triggered by
> something in lower levels?
Ok, so for my case, I just need to clear the bit, the feature is already 
disabled in the lower levels. If I go for that solution in 
hostapd/wpa_s, the issue is going to be can it break another driver?
>
> johannes

