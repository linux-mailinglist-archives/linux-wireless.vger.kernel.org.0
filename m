Return-Path: <linux-wireless+bounces-31816-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNYSGb4uj2nTLgEAu9opvQ
	(envelope-from <linux-wireless+bounces-31816-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 15:01:34 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 22921136D8C
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 15:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C202A300DE17
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 14:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476E335FF59;
	Fri, 13 Feb 2026 14:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7HwRUjD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261DF274B44
	for <linux-wireless@vger.kernel.org>; Fri, 13 Feb 2026 14:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770991267; cv=none; b=Kq9Z0NjycbVDv2l4S7o/5ipTD+LoP1PqsRi5PK5pV+8Uti9gcyceeDmzRvnGhcdn2Ub2ePCP7tlBIvEk9+EiFuezTlwBzT7aiM1tq2NXkgt1Dofhqz8Rqt0k899Iw97vdQk7OPOxkMWQh30cC9YGfK9X41LuhoFdlbPucNi7wH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770991267; c=relaxed/simple;
	bh=VgAW1VuJWLeM5Vx/u6+gHu+VwgjVTT5c9sV7rWihXVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tPIxX8FAZUIL3i2ajp3tWuk9T5wE3rVTiZkh9CkTUohuVq+3ctx7WzhwPsFM/5hJZRid5ZT63wyQNZ5A//Cth8RAzHca8CCpK5/VzOXq2cPT/YKYRXZzluuPqixsTyKuRbHP2IS+R5Qz55MGiLO7ePcU3Mr6e1EMJJin94mGXO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b7HwRUjD; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a8fba3f769so4263495ad.2
        for <linux-wireless@vger.kernel.org>; Fri, 13 Feb 2026 06:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770991265; x=1771596065; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1owc5fSNao93rCPFWkK7NA9JKqo3uiZe2XxwFF/zRyk=;
        b=b7HwRUjDvIpsB38YQu40fbiX+4sUch/PKmmDYQ4rcE8jHwiMIJ9or2P0lETq3zw1nU
         gXDmZkULKgt1clNSJYZGMlvFViJ8QFvl2O0U8pNfkmcFpL6KqG8Jz1BIT5e+vTbfIa1P
         UfiY+Rpmo0/QDgbHnbSNMhpRYTVJedJZHKMcjwKsotgUESrwmnT4Rj5o3y62lOE++rri
         Xn2KL0ZBPvxQ/qNGdPeIqWUlZcUYS2N3Qa2Tdef2CU7+OrwdaARiNeK+cK8kK1D7YIvZ
         YZwq3650Q8F6DwnbDZwOwgo68YAI6r2io7On7OJxtULU/0ByVQOEojy/Z2jLvreD/TaH
         Z1jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770991265; x=1771596065;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1owc5fSNao93rCPFWkK7NA9JKqo3uiZe2XxwFF/zRyk=;
        b=boXfNUkDNjEilAa4UySS97gJsaGSD7zGHfMrLuSNxJVZCaYD8jKwc64skkm88nVEpM
         59NR4TvpC9qKz1WzQHXQxZN1P1JEWfQR0QAifCdfklGElSSFrjgzt/uX/Nv+PaNur7YE
         8aobCBdtmPpIhYC0xXZlamOFYyjpb5ugMSNRp+aF1RJb2aU42rCoh6vbXUo6O5uB4t80
         jZ3y9tmfiNb/GtaU/R8hrqLl3I78dCstJf3RY8daMYt+HutYXr7zYy69jJg80V8Z/WNI
         llz4SoToLKoSkIPtxj5Zq6AtWK9uS6kVJSJkPIAwB4fxUPB1BHmilJo2JtB4evi4DPyJ
         adrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjy8vfK4Vpqej4iT9KUWbLmTE8YjfYcbM556xxhEtOX20shAAZSyW97rgNf8BFa4eQqzlOVjMRU21j8mi71Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzUuxoliE3oJdZMJF7U87DptPn5DCSCL6+8XzkAsmi4+U4NmOkO
	CSn3OXfHqMit8Ee5NXf6J1ailnXjfCX/oAQ4pi2aIqXgXFR/nTqICUuQ
X-Gm-Gg: AZuq6aLfQSurNJF9FJh/1aAZOiMkRahU8B1MfhIYeDm8kNzUSBHSN3Q3eSJ2yJLOe24
	e6WcmGDTjfQPsrJBLHnfTXLCh/rj+HhyrqpUFBKENaqfml9xXLgCRcsD6CbkHoK8hvZKS6eCJ17
	WYYANJ13hfBtTQ1ekK9lcNwYwrT7fkx/5fwtzdFRMB0Kx+qnGAWy2uF0swVrPO7YJLhtAJ9IU9e
	4UVagSBzDxQgs7w3gQJshi+FfnxNnVtBxEiuZk7ymmJDAwj4ZVNzgZ1BOuL2OPn2jREXzbzrU3w
	ke1j1fZmG0xVW417TZzKSFas+jgSdu5yETTGw/baCROustblmqEeX0qEIRILr8ZHKw48axZ3iOi
	eWyotVjsFqbQ1rFOhWNVsGTMt8qD+AACT3aHgt/UkhgvaE9qeVvoegL7rDbRB0uuJ0N+NNvENY7
	2ROqPVYhuxqXCxwVSB0/8ptqf5xrkKHTv54rdKiM+OHmxF6KUM0Frw15Pc
X-Received: by 2002:a17:903:1904:b0:2a9:30d4:2b0c with SMTP id d9443c01a7336-2ab5060d2b9mr18764565ad.46.1770991263619;
        Fri, 13 Feb 2026 06:01:03 -0800 (PST)
Received: from [10.100.120.15] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ab29998eeasm88343145ad.87.2026.02.13.06.01.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Feb 2026 06:01:02 -0800 (PST)
Message-ID: <1c6a4aaa-b450-4843-8c44-930a8c3f6d66@gmail.com>
Date: Fri, 13 Feb 2026 06:00:59 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] wifi: ath10k: only wait for response to SET_KEY
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
 Richard Acayan <mailingradian@gmail.com>, linux-wireless@vger.kernel.org,
 ath10k@lists.infradead.org, Baochen Qiang <baochen.qiang@oss.qualcomm.com>
References: <20260210021249.12132-1-mailingradian@gmail.com>
 <20260210021249.12132-3-mailingradian@gmail.com>
 <dd019903-f8d9-4bd3-a90d-b4d505f489f3@gmail.com>
 <3e1274fd-fe95-420c-94e3-ac34f497b7ae@oss.qualcomm.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <3e1274fd-fe95-420c-94e3-ac34f497b7ae@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,gmail.com,vger.kernel.org,lists.infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-31816-lists,linux-wireless=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[prestwoj@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 22921136D8C
X-Rspamd-Action: no action

Hi Jeff/Baochen,

On 2/12/26 9:56 AM, Jeff Johnson wrote:
> On 2/11/2026 6:11 PM, James Prestwood wrote:
>> On 2/9/26 6:12 PM, Richard Acayan wrote:
>>> When sending DELETE_KEY, the driver times out waiting for a response
>>> that doesn't come. Only wait for a response when sending SET_KEY.
>> We've run into the exact same thing on the QCA6174 and have been
>> carrying an identical patch to this for at least a year.
>>
>> https://lore.kernel.org/linux-wireless/b2838a23-ea30-4dee-b513-f5471d486af2@gmail.com/
> Baochen,
> Were we ever able to reproduce this?
> Do we normally always get a response to DELETE_KEY but in some instances it
> comes very late (or not at all)?
> If we remove the wait, is there any concern that a late arriving DELETE_KEY
> response might be processed as a response to a subsequent SET_KEY command?

For some added color, we only see this oddly with some vendors of APs, 
primarily "classic" Cisco Aeronet equipment (not Meraki).

Its still a mystery why certain AP vendors are able to trigger this 
given its deleting a key locally on the device. The major issue here is 
on roams when deleting the key from the prior BSS where we time out, 
thereby delaying the roam for 3 seconds. This then causes downstream 
effects like the reassociation timeout expiring on the AP which causes a 
disassociation. With some customers using Cisco its actually happens 
near 100% of the time, killing roaming entirely.

Thanks,

James

>
> /jeff

