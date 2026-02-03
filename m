Return-Path: <linux-wireless+bounces-31494-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGyKK7OUgWl/HAMAu9opvQ
	(envelope-from <linux-wireless+bounces-31494-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Feb 2026 07:24:51 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 510D2D52FD
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Feb 2026 07:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9D01B300C011
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Feb 2026 06:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE37C3783DA;
	Tue,  3 Feb 2026 06:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WUMBVJKC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f98.google.com (mail-ot1-f98.google.com [209.85.210.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE47377547
	for <linux-wireless@vger.kernel.org>; Tue,  3 Feb 2026 06:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770099888; cv=none; b=kpUkbv7WRpCQnLEY2hKXhZpaY9T1Cwtp5P7bVsVVswLJZLVb/wjPKEF2qf4+fvvbzC3EJPyWEPszUyj6U0AH5XSiS/cVdFhm/cymu3NT6YPNVeU/WRjsTTgXdUkN6FIgzDK2xccNusXA/qhCeFAfsE0DNlw4AhAAKYxFG6hYsOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770099888; c=relaxed/simple;
	bh=DnqXyytA3eHd4isuuaVxZ2pCH8gO8AVLcQwRj1P4L+c=;
	h=From:To:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=dbgaMQ+yDrAXzcA3ys9Pfcvrqx9UVui2dkXxfVNnUFkeWFI8IlPNNiTYrnH4JWlSda43mLcH/xkgkkoNmfqm1DNCI4xaMWtckDUBtbg3WDNPlEMdDYn6mPvFdyBSkKnUKjynLeVmzGl02SQURNbiKjZGd5lrBXL9xWCdydeS+GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WUMBVJKC; arc=none smtp.client-ip=209.85.210.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f98.google.com with SMTP id 46e09a7af769-7cfd0f349c4so3232454a34.1
        for <linux-wireless@vger.kernel.org>; Mon, 02 Feb 2026 22:24:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770099886; x=1770704686;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:to:from:dkim-signature
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Fyzv4BpF2csRiKuM0EcuzOyp2n6OQjgXIRPBKETqRE=;
        b=QX9mRHSpGdxFUqJ4d2ZXQn69AwgoOVhtZVe+oBtGfvRU2ablkH8ANsGUQBS6q2v/OD
         RecYJQ+3RgwNTmVpm+ZIJIfIAbWmChFCAQdhvTRn4dR2vCRa1C3YGHU2AWZmYlBfgaO4
         sGfq/EZtl5cv0O4OjIyyJSI9/gFdPj0AmDG0GhQIrLF4adgoNIxyeXGnL4F1DrZ8Rv/A
         Pg2pFIwue3wX6N9zJ7IEQmSM1+9HyTtOknc4UvyhiPFscWR6Vcl8wMi372PT6BwF0CW0
         5CJEfpvQCMIegfDl8KWqXUkNUTHHu+nZvoWNhJA4UQx3Al6OnmadU55AqZDOO0r9UPHy
         L/yA==
X-Forwarded-Encrypted: i=1; AJvYcCUmDiTk6vN45n+5En/rygv+BQhPkXGiHYpnXTxMq0mi0YRqYvBl+sUeR9mmEnpwD0heTdzXn9Xlv5y18u/fgQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzulQxUk8n6AJH/Owv0ZXWiDEvqMFPj+zIr6oEEa2OEuhHKudLu
	yAoYZoLsP/1wQx58BWzo1qcSkqFX6EvmcDbEhDeCVPOvksyDNWOcW54VW62hQJWGchGJ3Ug73Iz
	b4cg9aWtoqqON/uvFDUx77qmWpo2DeUddzIiVDmmcw1m+dbnG8/fv3ejLOQD6/apFHcXTKEYQjQ
	B0z+h+sMHg16WRTZrd9gjOWOH8vtQCblk2vYcEzqaLJjqxhzYlr7pwEYLnEm+wkrDvr4mCT2reJ
	PBxd8qJi4CZGC+joCxGXjjxOe74
X-Gm-Gg: AZuq6aJl5Qwmm/Dlvs6bdJtK0KqMtT3S+QH0gpD5JK/DdE70gdQuFwplvCKr2TpU0pm
	3adbEatOZrByXRt4o8plmHvyQxdnRf3WiPVMkMA+fRWuJ7G4SEQzErz/MaNTPhtOOJBvhMtOK6I
	MANa4BPpxV1v+JAo4YWMuH8quYQJVgqNG36QGWjmPVZRTph2voSIzimY9X38itHLasKMTe6iQMl
	YLnTi17KjbR8vBYjOJuTR+MkVlYZ8AQQlRIy52NUP+ZcFHiyvDcSp+uq9WLrhzzK6BqTcW2GTgp
	nIAdCHy59bmgK7L+f5vgi1L4uCkNv54PO7riVUmcShQDnwNpNXsv6T9S+ldTldGZxdSiQNTBvw2
	krNI+14IOTRr1SuDM5y3wMFyxIZdkeSuImPiHnT1obab72jNq0dq/zIlKVQrgb2ctEMJzkdE+PC
	2a4N9EMNcA9z2kcgxAWnfvD2AmfhX9omH8t6U7PZfftfNoTJJxgxE=
X-Received: by 2002:a05:6830:82cb:b0:7cf:d88d:5dd5 with SMTP id 46e09a7af769-7d1a5233029mr8963046a34.5.1770099885865;
        Mon, 02 Feb 2026 22:24:45 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-100.dlp.protect.broadcom.com. [144.49.247.100])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-7d18c768bedsm2907119a34.5.2026.02.02.22.24.44
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Feb 2026 22:24:45 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b8842248611so510956666b.0
        for <linux-wireless@vger.kernel.org>; Mon, 02 Feb 2026 22:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1770099882; x=1770704682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5Fyzv4BpF2csRiKuM0EcuzOyp2n6OQjgXIRPBKETqRE=;
        b=WUMBVJKC8gmD8CU8Zpk7lXV7hCguMf1ZP97K1w3PXszZTeCdZgE93kWJN4EwtwyQWK
         BV/DNukdApv51kKzyME47JiaZSGiV6qYVtxRVDx4MyswHb2AcxmDwEWvspNrBC02086U
         dXpu6t2y47UL2RawF9j8OPXLE8/kjABM7BDT4=
X-Forwarded-Encrypted: i=1; AJvYcCXbd/qe6zCGF8keSah7fDp83lcydjIsJX37eGRFfcB0vfJy2fLKe0d7lwBfxbgUQ8LuATTMmfjxhcnjBKcHRw==@vger.kernel.org
X-Received: by 2002:a17:907:6eac:b0:b88:64e9:899d with SMTP id a640c23a62f3a-b8dff653203mr854870666b.34.1770099882512;
        Mon, 02 Feb 2026 22:24:42 -0800 (PST)
X-Received: by 2002:a17:907:6eac:b0:b88:64e9:899d with SMTP id a640c23a62f3a-b8dff653203mr854869566b.34.1770099882103;
        Mon, 02 Feb 2026 22:24:42 -0800 (PST)
Received: from [192.168.178.58] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-658b4691d15sm8546954a12.19.2026.02.02.22.24.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 22:24:41 -0800 (PST)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>, <linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>, <brcm80211-dev-list.pdl@broadcom.com>
Date: Tue, 03 Feb 2026 07:24:40 +0100
Message-ID: <19c222cb040.2873.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <19c1f9f9108.2873.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
References: <CGME20251231143556eucas1p141b278048039730d03edf85c6f3e5350@eucas1p1.samsung.com>
 <20251231143544.4158840-1-m.szyprowski@samsung.com>
 <74e3bb49-ebbe-4692-b278-c04f2a30bf96@broadcom.com>
 <062fde49-7438-4001-a06e-50175547b54c@samsung.com>
 <19c1f9f9108.2873.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31494-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,broadcom.com:email,broadcom.com:dkim,broadcom.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arend.vanspriel@broadcom.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 510D2D52FD
X-Rspamd-Action: no action

Op 2 februari 2026 19:31:17 schreef Arend van Spriel 
<arend.vanspriel@broadcom.com>:

> Op 15 januari 2026 00:16:31 schreef Marek Szyprowski 
> <m.szyprowski@samsung.com>:
>
>> On 14.01.2026 14:45, Arend van Spriel wrote:
>>> On 12/31/2025 3:35 PM, Marek Szyprowski wrote:
>>>> When probe of the sdio brcmfmac device fails for some reasons (i.e.
>>>> missing firmware), the sdiodev->bus is set to error instead of NULL,
>>>> thus
>>>> the cleanup later in brcmf_sdio_remove() tries to free resources via
>>>> invalid bus pointer. Fix this.
>>>
>>> Hi Marek,
>>>
>>> Thanks for the fix. Please consider my suggestion below...
>>>
>>>> Fixes: 0ff0843310b7 ("wifi: brcmfmac: Add optional lpo clock enable
>>>> support")
>>>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>>> ---
>>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c | 1 +
>>>> 1 file changed, 1 insertion(+)
>>>>
>>>> diff --git
>>>> a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
>>>> b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
>>>> index 6a3f187320fc..6615748fa5bb 100644
>>>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
>>>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
>>>> @@ -954,6 +954,7 @@ int brcmf_sdiod_probe(struct brcmf_sdio_dev
>>>> *sdiodev)
>>>
>>> Maybe use a local variable bus and assign it only on success:
>>>
>>>> bus = brcmf_sdio_probe(sdiodev);
>>>> if (IS_ERR(bus)) {
>>>>   ret = PTR_ERR(bus);
>>>>   goto out;
>>>> }
>>>> +    sdiodev->bus = bus;
>>>> brcmf_sdiod_host_fixup(sdiodev->func2->card->host);
>> Well, that would look much better, but sdiodev->bus is also assigned
>> inside brcmf_sdio_probe() and I didn't check if this is required by the
>> functions called there or not. Maybe brcmf_sdio_probe() should simply
>> return error code to make things easier to track?

Correcting some typos here...

>>
> Sorry for the late response. Indeed the bus instance is allocated and 
> assigned to sdiodev

...in brcmf_sdio_probe.

> So that is

*NOT*

> something the caller needs to repeat. So changing the return type of 
> brcmf_sdio_probe() makes sense. The only thing that should be taken care of 
> in the failure path of brcmf_sdio_probe() is to set sdiodev->bus to NULL 
> after calling brcmf_sdio_remove().

Regards,
Arend



