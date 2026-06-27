Return-Path: <linux-wireless+bounces-38201-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ded+BHy9P2pGXwkAu9opvQ
	(envelope-from <linux-wireless+bounces-38201-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jun 2026 14:09:32 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0691B6D1E13
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jun 2026 14:09:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=IZVOSjUF;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38201-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38201-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EB1FA30091F0
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jun 2026 12:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098A83AD508;
	Sat, 27 Jun 2026 12:09:24 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f98.google.com (mail-qv1-f98.google.com [209.85.219.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3850391E4B
	for <linux-wireless@vger.kernel.org>; Sat, 27 Jun 2026 12:09:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782562163; cv=none; b=s+YVv5AqEbf0Yq7QhbUheIRb0JK5/d5C/x71SA8/KDpEzdNuA73t9swdRxlOI73nwL88Rzp5gxuc7DzjwEluIC+gFYGhpuFG9Ab2+yxV7s1ecXJlFZOpnaTR541vOrcy1xMSacadR79VMI1N0eab8xRG7ZK43R5ZZg+UNP/gU0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782562163; c=relaxed/simple;
	bh=Qz5V/qZ1e2NMwyP/pVi6BiSztUfVHSA7XJ1uHZTnzNU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JP6EunElgqWjhAXf8y9yipeAP8r6iXhLpYa3P1KjnvRBzU6xAt9OdgO9fIKTDDOCOEFxHkkD0SWFHWcNOxOmhQsTbncvVWv9LtWEboG4bDUGpU1jBmuxucFgiIuKYOrVeXEjPzDwXXeLlhlJOj5zFEsQeajBslJ/gt9Kbsi1Uyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=IZVOSjUF; arc=none smtp.client-ip=209.85.219.98
Received: by mail-qv1-f98.google.com with SMTP id 6a1803df08f44-8dedb44ed1fso19113156d6.1
        for <linux-wireless@vger.kernel.org>; Sat, 27 Jun 2026 05:09:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782562162; x=1783166962;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nfFcnLrFbJ0cBvqWefNxS93tH3j42/SSWzQHOvhNJQg=;
        b=loHPCslvCPZd465HtJRaz1E+txmQ93X9vMIr4li/a1guuC1V6wY4RfaiHsQmbr4+2g
         cUDM56YSKdJnkzwbHlUqgwMH53Ng/sPedsElBeqCT+1pvKZHC8zOPHagyPCB+iL5LKI8
         9RpPB7CmVpb7r+lKkfV/Iad4x3BiSZfMQ08wXDMcTbPihepfKL0dQpw5pUZxijPFvdDu
         lUg0jH+EVLsM7kYUz5F3/Epp5WRNhJ7S/nZbsSXHh2p/eF5BlDGFkJxVkhrSUo/pDD2L
         XbV1zRtaVPHKlDLWuoYYVrZ4fLtX1lDclKOBjJHpBv6mdw6WYVSd/CnnwY8BKRBDbCHi
         MxZg==
X-Gm-Message-State: AOJu0YyxkyADBzX277XAmxZn2psjfJYyz5mW37Gk4fk/Cl4sZgh9jCe0
	OgpyUbftf/X9NhkXLpwtw6edwOCJRTc/SEXoFlw2zaFdNc6/GthaCf1Uvey8755W8aWaENFfPuq
	cGru2ixvIArgI9f0g4p0x3VtkKd6RUaFYKGCtD63UxflckpZ55ObydcToit+B5P7C2+zMalxm26
	f/m4JNvGUdXOAk7cloijwxfbFsKHv+5nB9CQOTJrKDNl4yzANsWMqBdJ+zL9H4xQfGlS3wTkQ5E
	FmNPDq7tcnOxw5K7G4TQBtNzTdJ
X-Gm-Gg: AfdE7ckK/8PlENVeDs5PHOPjSm0+7Q8QzwENf5TgAUpMDq/TOovSryr+MpdcQXkhDpy
	KK1CGuvkVigkgjPtlV7H6GrMms72wkJ5iRIskLLJ9vBLS3diPfEwNNeN02Nx99zU/SDL2fxhbLb
	s9qoi3yZoCJftWRV65qIVKYGCVJmlmy3C3SO6Oo/E48e5I08RIBEK7fTT5XbBtBVLqluzFoNXpp
	TdJC8LXNsGPv7o+vDNKFFSsACVXfZXUJ5QFu9zMIB2SZORwpr/xKeX0PRIP1NEj4r9NnkvjuXlx
	4Lkxnm/b6KOl15AIyN09UMq7p8npRrGaeKUBXfndd7ZLK96Na3Nm14d+NcHP+5OrIU5dxtPobpw
	uQOH8RVBRq3qqzp6HTaRxGy2rjGQUAZWq7/xMwpULkfgNJWnwEG9FNEiah6a5qi/y8gij/MVAxY
	EyxImY1yR0CG5QMDbkuKc9KtUrA70T+3H22HboPkv1JnyYnXt6gA==
X-Received: by 2002:a05:6214:2c08:b0:8cc:d066:54d with SMTP id 6a1803df08f44-8e6d50e1892mr177328086d6.24.1782562161384;
        Sat, 27 Jun 2026 05:09:21 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8e89fd924c7sm2679346d6.13.2026.06.27.05.09.20
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Jun 2026 05:09:21 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30c95b0e22aso6133946eec.1
        for <linux-wireless@vger.kernel.org>; Sat, 27 Jun 2026 05:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1782562159; x=1783166959; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nfFcnLrFbJ0cBvqWefNxS93tH3j42/SSWzQHOvhNJQg=;
        b=IZVOSjUF9ywGqcDYhfvLo02KYxY09rmaWWjAKFDWEZUgWc/eM9UhmhU5TLScLuTFrP
         mEyNV7vn7T551KfN0OzzLlL8YI22VmpX+LvkRVRfJ+6ecu4EVZzKNjrOZh64TcH+EOTt
         AEkamupRT+jJJAlSAKFj+QuFBIUbuOwm3G428=
X-Received: by 2002:a05:7300:23cb:b0:2c5:b23e:48a6 with SMTP id 5a478bee46e88-30c84dfad18mr11468878eec.23.1782562158940;
        Sat, 27 Jun 2026 05:09:18 -0700 (PDT)
X-Received: by 2002:a05:7300:23cb:b0:2c5:b23e:48a6 with SMTP id 5a478bee46e88-30c84dfad18mr11468858eec.23.1782562158317;
        Sat, 27 Jun 2026 05:09:18 -0700 (PDT)
Received: from [192.168.178.26] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c9d39e7besm18507657eec.26.2026.06.27.05.09.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Jun 2026 05:09:17 -0700 (PDT)
Message-ID: <cfecc1ba-09c5-41da-b60f-c1d4da3b23e6@broadcom.com>
Date: Sat, 27 Jun 2026 14:09:15 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: brcmfmac: heap overflow in brcmf_notify_auth_frame_rx() on a
 short auth frame
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <178214417708.2368577.16740907093694208834@maoyixie.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
In-Reply-To: <178214417708.2368577.16740907093694208834@maoyixie.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[broadcom.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-38201-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:maoyixie.tju@gmail.com,m:linux-wireless@vger.kernel.org,m:brcm80211@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:maoyixietju@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[arend.vanspriel@broadcom.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arend.vanspriel@broadcom.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0691B6D1E13

On 22/06/2026 18:02, Maoyi Xie wrote:
> Hi all,
> 
> I think brcmf_notify_auth_frame_rx() in
> drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c can overflow the
> heap when the firmware reports a short external auth frame. I would
> appreciate it if you could take a look.
> 
> The handler takes the frame length from the event, then allocates a buffer
> for it.
> 
> 	u32 mgmt_frame_len = e->datalen - sizeof(struct brcmf_rx_mgmt_data);
> 	...
> 	if (e->datalen < sizeof(*rxframe)) {
> 		...
> 		return -EINVAL;
> 	}
> 	...
> 	mgmt_frame = kzalloc(mgmt_frame_len, GFP_KERNEL);
> 
> The only length check is e->datalen >= sizeof(*rxframe). So mgmt_frame_len
> can be anything from 0 up. The frame body is then copied with a length that
> subtracts the management header offset.
> 
> 	memcpy(&mgmt_frame->u, frame,
> 	       mgmt_frame_len - offsetof(struct ieee80211_mgmt, u));
> 
> offsetof(struct ieee80211_mgmt, u) is 24. If mgmt_frame_len is less than 24,
> the subtraction wraps around as an unsigned value to a huge number. The
> memcpy then runs far past the small kzalloc buffer. That is a heap overflow
> driven by the frame the firmware passes up. A malicious or malfunctioning AP
> can make the frame short during the external SAE auth exchange.
> 
> The p2p path in the same driver allocates with the header offset included,
> so it does not have this shape.
> 
> I reproduced the overflow on 7.1-rc7. With mgmt_frame_len set below the 24
> byte header offset, the subtracted length wraps to a huge value and the copy
> faults.
> 
>    BUG: unable to handle page fault ... in memcpy_orig
> 
> A check that mgmt_frame_len is at least offsetof(struct ieee80211_mgmt, u)
> before the copy would close it.
> 
> Does this look like a real bug to you, and is that the right place to bound
> it? If so I am happy to send a proper patch with a Fixes tag and Cc stable.
> 
> Kaixuan Li and I found this together.
Thanks for reaching out although it would have been fine to just send 
the patch straight away. I do agree with the assessment given so this is 
a real bug.

Regards,
Arend

