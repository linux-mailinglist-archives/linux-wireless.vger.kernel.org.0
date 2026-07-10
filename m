Return-Path: <linux-wireless+bounces-38858-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5QTTORlHUWoJBwMAu9opvQ
	(envelope-from <linux-wireless+bounces-38858-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jul 2026 21:25:13 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD3973DBB9
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jul 2026 21:25:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=UW1a+Ba9;
	dmarc=pass (policy=reject) header.from=broadcom.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38858-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38858-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E775C3038299
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jul 2026 19:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE94383980;
	Fri, 10 Jul 2026 19:18:33 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-vk1-f225.google.com (mail-vk1-f225.google.com [209.85.221.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE771624C5
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jul 2026 19:18:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783711113; cv=none; b=amvyDVCkJqgbl0FDtw6n2aSagBJA8gss/E9qlBVuvygJNZfImRKlKTHrdIgxsm98z001pxacPo8bhScwRXr+4VPwQ4JLsRuEeCaCp5Gh4Wwm/V0WZ8cwM7h0/1lou3CW+c42oNMGdS3Z+PBSvDVPCPS/1edigYQQymGNzvFCqVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783711113; c=relaxed/simple;
	bh=Pkzq93VysouvMV4sOok85BWiz22/o2bRhcPNPa9P+iM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RfeJWldmv45ZQrySFKUsg/d8S6JRCmZC2hw+YkUc5/JERbYzxmTnftecq5OympRGDsxgERG2ZL2q0jHc6dCji/IMx6+DSvrfyeSUQC+3O0R2mLWFJacfOvQtouavhG9/BNihnZm+Ufg9GbIvzd1oihtRGtSbJEbdXkAQcd50ywk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UW1a+Ba9; arc=none smtp.client-ip=209.85.221.225
Received: by mail-vk1-f225.google.com with SMTP id 71dfb90a1353d-5bfb3347ce0so217319e0c.2
        for <linux-wireless@vger.kernel.org>; Fri, 10 Jul 2026 12:18:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783711111; x=1784315911;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ivQlEJtZ0zxa8yf3dIj+FATasL8wavCjCs0e2VSoqvc=;
        b=kG3SfU0kxYKixZ6RQRaYCjIo05UOgSF5KDkYFTvp3BRfR4nWsbAGEP3SLG4Msyuvf5
         VdJDsnlEzvVOkU0Ah/Wo9PZFFNkbeinK0H6egVkGGlNgzQC9EvuYr0B1RD4MF/LvL7I5
         aRXX8D5P46ceozDcdoRADkCGQ/39f0d5BIJY5IHHxhwG1Dcplw+B/6Uqp9nZvLL+UQTs
         Nl29HU2s8ZGqYvaTM7d1+YDLwi54DgIzfwwlDvTkxlDY1fj7x1vXsi6Q2gWFq2i6jZ6H
         zRc5VQ9alEOuvWmno5SJp7L0ZD+k2jYkZ/0g5WJMMiS/nUMn7F9HoGavJlbxYk2zv5RO
         ZTbw==
X-Forwarded-Encrypted: i=1; AHgh+RoeOWIwZWXaYxQ6lkyMsnxicrwDQWhq27bZN1vCPf8WUEtDUpzVwrznJTvi/HpEtVb4bwDIoSIJ/hvgIdRS6g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8rDQZL0rV6UfVkoBbw7H0x8sBA99gkJ2dvVRS4d+7/NRmTjz1
	3ObdfgJnpt9JbsxGJb01rByXPoKlZhw7tJ/pH4/wpvTYkNSBJvvHSrrC4f2mT8/silT+25i6PCG
	E8kYrY44/UPS41sZWesHhE9XFsY1SxpL/zbadfqjt5klP4EBiFv29h+mFW5orqjo+T9xaJJQtDC
	dy2GIulP3DqZWpmVcvPH/VHhIhkGFeGWEMpKKq2ud7+bg/8puZHON9ISZpUhr+wJbIkDrD4u70M
	23Y6OW81a3B1keybgwN36tEco1w
X-Gm-Gg: AfdE7cmxzZs39GUs1Kt/KkXylfbs+Uek2NvZC2JnJ+NpE9Nl1ipCSt1TeIA+lKmb/ZV
	1JGoEwNQi+VftaC71rfvi709Twz0J0JRfYJYJRG5DJcP6Q/5mTJ9oGrPf+YKH5/CCcsMhut8eXQ
	mOnhxIXfhOGoMFsSh5UllkvH0ePOvAzr5zKzMMfRKz6inKy+3+soz/mZc3cRYpTwVf4LL/jCUnB
	txkUR2A5JYFCS0PTxETKrfESMfLDMXIwqy4IGKbgS/KMdxcuUCHdj/NhJi3WVtkk3EL44LFnMC6
	jX3gYyTBhqGTOpVjSjJwW+wyTAtG7KjjCd4VNHagmUuByYZjOseQwx4+d7q2Z6P/hmfOCshpTEa
	zl2xUfe8jY7BmistsLyFClPScNYcuUaxdPPb42+pnW63M4s928VBlSk9ojkj7f/4gvLx0BdLfHH
	K4jpMThRso58UPpX06TOJSsYJAfm7J0nKk1tec7eawxPOsPY/mqA==
X-Received: by 2002:a05:6122:4892:b0:5bd:a214:c933 with SMTP id 71dfb90a1353d-5bfbf384810mr412132e0c.14.1783711110620;
        Fri, 10 Jul 2026 12:18:30 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-5bf6f822c20sm1055193e0c.7.2026.07.10.12.18.29
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Jul 2026 12:18:30 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38001e788d6so2250563a91.3
        for <linux-wireless@vger.kernel.org>; Fri, 10 Jul 2026 12:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1783711108; x=1784315908; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ivQlEJtZ0zxa8yf3dIj+FATasL8wavCjCs0e2VSoqvc=;
        b=UW1a+Ba9mKpKD3E0Z2kHXNb4l0TG6mayushTeTSklwRjJ6PNHrxgKz1ZXcqunapdZX
         diBwBli0u7DuszUEaWQyEmRuyz7UKoAcoMccu471dSYzJib8CAhxNTWeUR+leSLojxsz
         vBiaGWe1gfA/Dn5sEoXxEh/lu43X9KlWvngG0=
X-Forwarded-Encrypted: i=1; AHgh+RpM2FZ1jkGPcELUsISiZ9cI0EHMkfLVSImP+RjnV2y5T2VP11nQvphSGtMm8Qy9sfqweWXJlZV2+VVfTZJQIg==@vger.kernel.org
X-Received: by 2002:a17:90b:3805:b0:380:83fc:4315 with SMTP id 98e67ed59e1d1-38dc77ee67cmr215914a91.21.1783711108631;
        Fri, 10 Jul 2026 12:18:28 -0700 (PDT)
X-Received: by 2002:a17:90b:3805:b0:380:83fc:4315 with SMTP id 98e67ed59e1d1-38dc77ee67cmr215891a91.21.1783711108045;
        Fri, 10 Jul 2026 12:18:28 -0700 (PDT)
Received: from [192.168.178.26] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311838c9235sm39074609eec.21.2026.07.10.12.18.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 12:18:27 -0700 (PDT)
Message-ID: <caae46b1-50c6-495d-94fe-c95229d489ce@broadcom.com>
Date: Fri, 10 Jul 2026 21:18:21 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: brcmfmac: drain bus_reset work on device removal
To: Eddie Phillips <eddiephillips@google.com>, Fan Wu <fanwu01@zju.edu.cn>
Cc: Arend van Spriel <aspriel@gmail.com>, Kalle Valo <kvalo@kernel.org>,
 Franky Lin <franky.lin@broadcom.com>,
 Hante Meuleman <hante.meuleman@broadcom.com>,
 Chi-Hsien Lin <chi-hsien.lin@infineon.com>,
 Wright Feng <wright.feng@infineon.com>,
 Chung-Hsien Hsu <chung-hsien.hsu@infineon.com>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 linux-wireless@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com,
 SHA-cyfmac-dev-list@infineon.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260709101635.103005-1-fanwu01@zju.edu.cn>
 <20260710002451.500112-1-eddiephillips@google.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
In-Reply-To: <20260710002451.500112-1-eddiephillips@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[broadcom.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,broadcom.com,infineon.com,davemloft.net,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-38858-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:eddiephillips@google.com,m:fanwu01@zju.edu.cn,m:aspriel@gmail.com,m:kvalo@kernel.org,m:franky.lin@broadcom.com,m:hante.meuleman@broadcom.com,m:chi-hsien.lin@infineon.com,m:wright.feng@infineon.com,m:chung-hsien.hsu@infineon.com,m:davem@davemloft.net,m:kuba@kernel.org,m:linux-wireless@vger.kernel.org,m:brcm80211-dev-list.pdl@broadcom.com,m:SHA-cyfmac-dev-list@infineon.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[arend.vanspriel@broadcom.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,zju.edu.cn:email,vger.kernel.org:from_smtp,broadcom.com:from_mime,broadcom.com:dkim,broadcom.com:mid];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arend.vanspriel@broadcom.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3DD3973DBB9

On 10/07/2026 02:23, Eddie Phillips wrote:
> On Thu,  9 Jul 2026 10:16:35 +0000 Fan Wu <fanwu01@zju.edu.cn> wrote:
> 
>> brcmf_fw_crashed() and the debugfs "reset" entry both schedule
>> drvr->bus_reset, whose callback recovers drvr through container_of()
>> and dereferences it.  The teardown paths free drvr (brcmf_free ->
>> wiphy_free) without draining the work, so a bus_reset callback pending
>> or running during removal can outlive drvr.
>>

[...]

>>
>> This issue was found by an in-house static analysis tool.
>>
>> Fixes: 4684997d9eea ("brcmfmac: reset PCIe bus on a firmware crash")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
>> Assisted-by: Codex:gpt-5.5
>> ---
>>   .../broadcom/brcm80211/brcmfmac/bcmsdh.c      | 13 ++++++++
>>   .../broadcom/brcm80211/brcmfmac/bus.h         |  6 ++++
>>   .../broadcom/brcm80211/brcmfmac/core.c        | 33 +++++++++++++++++--
>>   .../broadcom/brcm80211/brcmfmac/pcie.c        |  6 ++++
>>   .../broadcom/brcm80211/brcmfmac/sdio.c        |  6 ++++
>>   .../broadcom/brcm80211/brcmfmac/sdio.h        |  1 +
>>   .../broadcom/brcm80211/brcmfmac/usb.c         |  3 ++
>>   7 files changed, 66 insertions(+), 2 deletions(-)

[...]

>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
>> index fed9cd5f2..b934feb9b 100644
>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
>> @@ -1164,6 +1164,35 @@ static int brcmf_revinfo_read(struct seq_file *s, void *data)
>>   	return 0;
>>   }
>>   
>> +/* Serialize bus_reset arming (debugfs reset write, brcmf_fw_crashed) against the
>> + * teardown drain: the remove path takes bus_reset_lock, sets ->removing and cancels
>> + * the work under it, so a racing armer either schedules before the cancel (and is
>> + * drained) or observes ->removing and desists.
>> + */
>> +static void brcmf_bus_schedule_reset(struct brcmf_bus *bus_if)
>> +{
>> +	mutex_lock(&bus_if->bus_reset_lock);
>> +	if (bus_if->drvr && bus_if->drvr->bus_reset.func && !bus_if->removing)
>> +		schedule_work(&bus_if->drvr->bus_reset);
>> +	mutex_unlock(&bus_if->bus_reset_lock);
>> +}
> 
> Is this safe in a softIRQ context?
> mutex_lock() sleeps until it can get the lock.

What softIRQ context? brcmf_fw_crashed() is called by PCIe (thread) and 
SDIO (worker).
>> +
>> +void brcmf_bus_cancel_reset_work(struct brcmf_bus *bus_if)
>> +{
>> +	mutex_lock(&bus_if->bus_reset_lock);
>> +	bus_if->removing = true;
>> +	if (bus_if->drvr)
>> +		cancel_work_sync(&bus_if->drvr->bus_reset);
>> +	mutex_unlock(&bus_if->bus_reset_lock);
>> +}
> 
> How about if brcmf_pcie_remove() calls brcmf_bus_cancel_reset_work(),
> takes the lock and calls cancel_work_sync(), sleeps. If debugfs
> path is already running, it can invoke the worker thread. Is there
> potential that both try to reset?

What is "both" here?
Regards,
Arend

