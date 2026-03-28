Return-Path: <linux-wireless+bounces-34110-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDHtGYYpyGnEhQUAu9opvQ
	(envelope-from <linux-wireless+bounces-34110-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Mar 2026 20:18:30 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A1734FC4B
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Mar 2026 20:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 07FCE300D553
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Mar 2026 19:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE24285CAD;
	Sat, 28 Mar 2026 19:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eLyvur1Q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F63A344DA4
	for <linux-wireless@vger.kernel.org>; Sat, 28 Mar 2026 19:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774725503; cv=none; b=e/hcia5Nrcc9wFrnrdm76o+NvUp++H+NgX/IPDYQ5I/OgrTbLpFJS/Y4B2HMjVvMfFa88lYdnOCTCH1wrQf/XTqvfR9Y2/59lSFe9dBWV3wrbhFb95cpLoBReAfkIlVQhp9EPLouOiWQ3buK53CM9qgAe/L3GHr/AMdN0En5Xfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774725503; c=relaxed/simple;
	bh=tQs1ClQrClVJHcSzIehuuDLOW0l4tjAOpKioVlkUUdo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N6IziDODybA1JgE2gq8f6TQY6PppzDF7lw961LzB3zsEE3MyTEMgGmy/z6SHdxA+oWrpOvVMRmMm8KuYrSGqH2F9XVm5fRB7zEJWf5r1B6jcKtyYK+ji0HJ9oGj0nVnhQi4sqqGJKQu5p/1AmUL7gVbdkuor6T3lEpkTD2phpDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=eLyvur1Q; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-2ad9a9be502so19885005ad.0
        for <linux-wireless@vger.kernel.org>; Sat, 28 Mar 2026 12:18:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774725502; x=1775330302;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dCzW69THXEF5HvH8lblgi0nh+8npufR2fKyClTNTePE=;
        b=g2Juq4MP+wRcFfZhOV01zlDUOiT8m8L8wI72ewIcllqw3LBMrQbeW2jIQpH3r5brAg
         a2Hb80inCsEtdqkQJKKKCsnbFze0p36jHyi6zbkjSFjKsLKSo89eqZ8iHLK1V+abmgHf
         xvdg4Vlozkzc16jRY2SvYbuQDPbZqWjVArOc0W2P9vG5H3MM3q4MzhzzRf24ICIbRP1m
         HYjy78gy3lvEvTBhtZm++GB/g/gvd7/tASsnv1rR1/Q63NmU3NW/7dWkYl0cKxciwkTt
         NmOA7TJfNSNyiTcPFfSNWWxQUyEHJl81kSCjlhvfSKpa0elIILO6+QgdME+8bt9O6T/X
         U1EA==
X-Gm-Message-State: AOJu0YwM+syNBX2yeJwsPE1r1Vq8yCxdFOEXGJCryQ33/wiyGa2/S+l0
	iqylt3/IhUSPWkDp8HIN4eS3H+M9INf5xWcKitKDsMsGCIhyfeaG9kOAlHdZkstdypVs6KQ/pln
	nYmDCONJ3Pkk8p1019bDbMNVNu76tEn/oiNj/C4TBD7ziUsHdyfhCdtAIHJe2gJVvPy5Ew5lXQA
	GNyT4WTh/gveHzNJSfYauoROReYYXyNNwx4niJhfm631efJBg6AsyTpUawQp0KjtC7BKoMB3cAY
	qUkkYeWx3DDhG9B+xhwiOZuUmX8
X-Gm-Gg: ATEYQzwrpEQumHbSGKzQl6TzZ5V5qvbIuptJsbIKeA4QMub8lXytKjiLrrZ6TVHYRnu
	+aIzqP9w/7nbmZGpaTY99hanrGZnuChYq2mJ/x2bCIvkKJexg46lSeTrCOk5gJZHK744DhEcqGD
	1kPTXDt6RnS+ZMELxdY72J0swCfWBLCKbVWR4HCb1SOjPLMlRdiNKm9MS1mEFnarqsbo+lS8vpC
	ZYXpnEHqbBRewdT9Ib+4TE3mu0boheeAF43IauZfTOYW8a2HMlVYjtj3cuhNJtSy1399h7WDpF+
	Jy0pO7DOCD2jM+rR36H2JEmjIVqy4jWkatUV4qBBVHZoUz9gfr0lC7hj8XR1NfteecZvbCDcdu8
	DMXnQqMzmdzB5UXe0OxCendsI8Pkjy4OMpwADxOq/6sSCXBkTs567voETJB2OU1As18X1k7oH/P
	kaugLeD/g9
X-Received: by 2002:a17:903:1a03:b0:2b2:3bb6:fbf8 with SMTP id d9443c01a7336-2b23bb6ff9amr59293895ad.16.1774725501629;
        Sat, 28 Mar 2026 12:18:21 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com ([144.49.247.127])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2b24272989bsm3470475ad.25.2026.03.28.12.18.21
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Mar 2026 12:18:21 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cfd0a23243so1246075785a.2
        for <linux-wireless@vger.kernel.org>; Sat, 28 Mar 2026 12:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774725499; x=1775330299; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dCzW69THXEF5HvH8lblgi0nh+8npufR2fKyClTNTePE=;
        b=eLyvur1QfPGvafrqlNaUmS9+iU83vOWukqXgUryH808pLVnokRThvRl52cmmW7GUIC
         0s1o38/9qCAUwmVGz09WscO1kPGcfg39SGsuTTa0S9PoYcMbzVPgyIE5BEWH95ZwEr7O
         IvA57WOc2Rn41MGxrqn+yXEs2sJsT3gQi9CgE=
X-Received: by 2002:a05:620a:1788:b0:8cd:c037:8522 with SMTP id af79cd13be357-8d01c7b705bmr925533685a.45.1774725499000;
        Sat, 28 Mar 2026 12:18:19 -0700 (PDT)
X-Received: by 2002:a05:620a:1788:b0:8cd:c037:8522 with SMTP id af79cd13be357-8d01c7b705bmr925530485a.45.1774725498394;
        Sat, 28 Mar 2026 12:18:18 -0700 (PDT)
Received: from [192.168.178.26] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d027edb8ebsm223819485a.7.2026.03.28.12.18.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Mar 2026 12:18:16 -0700 (PDT)
Message-ID: <f8eadf0e-6c05-40ed-85fb-316cf4151258@broadcom.com>
Date: Sat, 28 Mar 2026 20:18:15 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] wifi: brcmfmac: silence warning for non-existent,
 optional firmware
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
 brcm80211-dev-list.pdl@broadcom.com, linux-kernel@vger.kernel.org
References: <20260317111202.1074675-1-alexander.stein@ew.tq-group.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <20260317111202.1074675-1-alexander.stein@ew.tq-group.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-34110-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,tq-group.com:email];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arend.vanspriel@broadcom.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 98A1734FC4B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 17/03/2026 12:12, Alexander Stein wrote:
> The driver tries to load optional firmware files, specific to
> the actual board compatible. These might not exist resulting in a warning
> like this:
> brcmfmac mmc2:0001:1: Direct firmware load for brcm/brcmfmac4373-sdio.tq,imx93-tqma9352-mba93xxla-mini.bin failed with error -2
> 
> Silence this by using firmware_request_nowait_nowarn() for all firmware
> loads which use brcmf_fw_request_done_alt_path() as callback. This one
> handles optional firmware files.

Thanks, Alexander

I revised the patch hopefully addressing the other firmware related 
warning that Christian Hewitt referred to. I have sent the revised patch 
to the mailing list:

https://lore.kernel.org/linux-wireless/20260328140121.2583606-1-arend.vanspriel@broadcom.com/T/#u

Regards,
Arend

> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>   .../broadcom/brcm80211/brcmfmac/firmware.c         | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)

