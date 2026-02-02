Return-Path: <linux-wireless+bounces-31477-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBM5I63tgGleCAMAu9opvQ
	(envelope-from <linux-wireless+bounces-31477-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Feb 2026 19:32:13 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9071D0344
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Feb 2026 19:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 513AA3002A05
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Feb 2026 18:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A462E92D2;
	Mon,  2 Feb 2026 18:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NBnmLbTy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f228.google.com (mail-qt1-f228.google.com [209.85.160.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FDD2E7BD6
	for <linux-wireless@vger.kernel.org>; Mon,  2 Feb 2026 18:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770057085; cv=none; b=a0s0VRk7QpAU95+lJ3eDrUvqBFdYCYnLwaRQz87lJKpS9j+X28jN+k++B9GvTs15/AW4kRW2pGdnDNMiaKPLpaLMxlm6X9aa/VLGGlmqOln6HD0vEJ7gbLltJxWjb+2kYxjVU8yNioQDk3F4AEkCfF4//7uT5C3W3G1oU7ujhYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770057085; c=relaxed/simple;
	bh=FFRMhOH0i4hv3RLO6HQP+kTxivBZeU2yKE5VeAYog18=;
	h=From:To:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=SEVlgPBPEkY96aURmttrdUpQRnS8EZ6Dv03DNB23b7gJk8br6RPW+jycpX2QkPyQokUagJL8m/Zxa7VfyFcQ2fQsq69YBWMYG7a7lDNNyd2ZairEW5ZX+9m8SQomRFcF/taVJs6F4CDmEew7BYQeVF4ZpibSRRRMLpEqYf0nG3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NBnmLbTy; arc=none smtp.client-ip=209.85.160.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f228.google.com with SMTP id d75a77b69052e-502a98c66f7so38911141cf.1
        for <linux-wireless@vger.kernel.org>; Mon, 02 Feb 2026 10:31:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770057082; x=1770661882;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:to:from:dkim-signature
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IgBc8O/BAmD5N4ZalAoTu4LjXQUHSz9aZWoFX8AATM8=;
        b=MatHARRX3xIqVZjknmj6XXM9jjnP2nAcaiNiZobYK++z7BLkLfl3eiAgzAjyJceB93
         ZWQh3XQOUlWWKm/P9e1+hKnpy7rSJNhkt7nx4qdwWvDX/MpyJsM9od/a+2FrlsQkhDi/
         U0aQUNO76H3wS5kuEUbVx36RN60JO0BybCsBeODFsQQ8kEP1TkQryFuG/aq+g5jQU8nl
         wlFtbLPUp2W0ZnTKH9y1jmMOw4Xyvq3yFhjjpwHtQzs2fqVU7nSuZFTIxDqu/ZF4wl86
         I6dbTvObVB+g+1jWmo+GQN5ZAln9TR6CBMHeCtGDEGAbpR0PJTi9by+w6W0eBkT7rZZE
         Dotw==
X-Forwarded-Encrypted: i=1; AJvYcCXol+JOEtt3u4CRtp4UNdCDKPQtHk0rBvDqi4Zk8XTghOun6qYj6oAZvCSgG2KRbBbJ/oLOT1MPgk8OBbR9YA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyWgOSBJ6Fzua+V9q702izyK7XtISLDFWnplyDSrFG8WNve3tET
	pPDqrbuUAN292FCr+gDo2AZ9GNGnKD8wIelzGM7QBokL/o3gGIXlFNsjXLUhqHezur8IqOylFfU
	CyzBkUX1qBbP4khXJ0zhPWPMYY93t++8v5RP7PxfvpG8fN1U9/xurMM99ay7BlT6n0g/cr1dtZb
	g3NCqMmpKfKU1KgxfuRAby3f1nOE0gV8R8msDlPBX9fE8r8TVC5kjvaftPvkD/NYEF2TWDA4bgW
	MjUVMuHR75Z+QQ+pdFwZXnev2gV
X-Gm-Gg: AZuq6aIn4589sBX+TeshnfJE7rAxr4l9Q2zBb5PA31ISGFAhH5JHF2QZwcYv2Vs8elj
	0Ne8ReayMfTKK45oMfUy94U2fa317hVTTIlSY/m//Ko91YRn3U1lV+X/rfI8qtXvzixKBgvJrlI
	dGd9PiAsbGhAhFwzctPIDwDSXGE8W5ZYzgRMvJgOh9+djq+/4OdquG3Q1gWD+M0Sg4ORiQ2C0KJ
	rcDdwvbey7NKWzv84ZsJtlPvIM3hdKzI+cI4FzzArfb3U7lGUIW5np0Jpu9jF3AVKsVP3Lf+kC5
	uEf3SYfekG3p5I1WB39VWd/OMPfB7/r7S2EuX/SJpHOVEzsqW/0qp+tDQPa7K2U0fVwsNDMMpq6
	JETDlvUnaMv1X80azgGMT/LBsJ4okdklxFOQyQhKAtSCohGdnuiLJEGpW6tyC5BUoMh/oHsY4co
	zYJDmMMc9T57D7LOD1csJ/FHqNI+OWMtN4QuZkV6fUo6ftj+6JNEM=
X-Received: by 2002:a05:622a:15c2:b0:4ee:168a:9ebb with SMTP id d75a77b69052e-505d2273959mr162089771cf.58.1770057082121;
        Mon, 02 Feb 2026 10:31:22 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-100.dlp.protect.broadcom.com. [144.49.247.100])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-895071c5562sm8161326d6.28.2026.02.02.10.31.21
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Feb 2026 10:31:22 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-4042a16a369so10566462fac.2
        for <linux-wireless@vger.kernel.org>; Mon, 02 Feb 2026 10:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1770057081; x=1770661881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IgBc8O/BAmD5N4ZalAoTu4LjXQUHSz9aZWoFX8AATM8=;
        b=NBnmLbTy85YNlL3Ktpu25PO5EkoVSQWJv41dAdBW8QEgfBIXrJ/592JVWomR6tv7Mr
         CZlDQxX5kVJ2QOdJ/rdSVfdGZpO5RftQ2CynmXgKeOFlxmOqFaDe9qtuj5DL9s8ciPiq
         rJljxifo2ieWNiQod+v43QZ+wnNPvFuUkOb00=
X-Forwarded-Encrypted: i=1; AJvYcCX0myAbQqN5JJRfA97F+g9GdPvTE4G4MaS5wvT8Xc0lWx+RyF2KPoVqy3gJ/ORCIueiP3jh9iUCX27G5lv+wg==@vger.kernel.org
X-Received: by 2002:a05:6820:2c0e:b0:663:126b:b8c8 with SMTP id 006d021491bc7-663126bba9emr3380300eaf.8.1770057081162;
        Mon, 02 Feb 2026 10:31:21 -0800 (PST)
X-Received: by 2002:a05:6820:2c0e:b0:663:126b:b8c8 with SMTP id 006d021491bc7-663126bba9emr3380288eaf.8.1770057080768;
        Mon, 02 Feb 2026 10:31:20 -0800 (PST)
Received: from [10.229.40.14] ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-662f9a4e491sm9980208eaf.16.2026.02.02.10.31.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 10:31:20 -0800 (PST)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>, <linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>, <brcm80211-dev-list.pdl@broadcom.com>
Date: Mon, 02 Feb 2026 19:31:17 +0100
Message-ID: <19c1f9f9108.2873.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <062fde49-7438-4001-a06e-50175547b54c@samsung.com>
References: <CGME20251231143556eucas1p141b278048039730d03edf85c6f3e5350@eucas1p1.samsung.com>
 <20251231143544.4158840-1-m.szyprowski@samsung.com>
 <74e3bb49-ebbe-4692-b278-c04f2a30bf96@broadcom.com>
 <062fde49-7438-4001-a06e-50175547b54c@samsung.com>
User-Agent: AquaMail/1.56.0 (build: 105600589)
Subject: Re: [PATCH] wifi: brcmfmac: Fix potential kernel oops when probe fails
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31477-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samsung.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arend.vanspriel@broadcom.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E9071D0344
X-Rspamd-Action: no action

Op 15 januari 2026 00:16:31 schreef Marek Szyprowski 
<m.szyprowski@samsung.com>:

> On 14.01.2026 14:45, Arend van Spriel wrote:
>> On 12/31/2025 3:35 PM, Marek Szyprowski wrote:
>>> When probe of the sdio brcmfmac device fails for some reasons (i.e.
>>> missing firmware), the sdiodev->bus is set to error instead of NULL,
>>> thus
>>> the cleanup later in brcmf_sdio_remove() tries to free resources via
>>> invalid bus pointer. Fix this.
>>
>> Hi Marek,
>>
>> Thanks for the fix. Please consider my suggestion below...
>>
>>> Fixes: 0ff0843310b7 ("wifi: brcmfmac: Add optional lpo clock enable
>>> support")
>>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>> ---
>>>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git
>>> a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
>>> b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
>>> index 6a3f187320fc..6615748fa5bb 100644
>>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
>>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
>>> @@ -954,6 +954,7 @@ int brcmf_sdiod_probe(struct brcmf_sdio_dev
>>> *sdiodev)
>>
>> Maybe use a local variable bus and assign it only on success:
>>
>>>      bus = brcmf_sdio_probe(sdiodev);
>>>      if (IS_ERR(bus)) {
>>>          ret = PTR_ERR(bus);
>>>          goto out;
>>>      }
>>> +    sdiodev->bus = bus;
>>> brcmf_sdiod_host_fixup(sdiodev->func2->card->host);
> Well, that would look much better, but sdiodev->bus is also assigned
> inside brcmf_sdio_probe() and I didn't check if this is required by the
> functions called there or not. Maybe brcmf_sdio_probe() should simply
> return error code to make things easier to track?

Sorry for the late response. Indeed the bus instance is allocated and 
assigned to sdiodev. So that is something the caller needs to repeat. So 
changing the return type of brcmf_sdio_probe() makes sense. The only thing 
that should be taken care of in the failure path of brcmf_sdio_probe() is 
to set sdiodev->bus to NULL after calling brcmf_sdio_remove().

Regards,
Arend



