Return-Path: <linux-wireless+bounces-36828-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0nCZLYoNEmpSugYAu9opvQ
	(envelope-from <linux-wireless+bounces-36828-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 23 May 2026 22:26:50 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5D35C0C19
	for <lists+linux-wireless@lfdr.de>; Sat, 23 May 2026 22:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DCC2D30060BF
	for <lists+linux-wireless@lfdr.de>; Sat, 23 May 2026 20:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13B4305E28;
	Sat, 23 May 2026 20:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0hzSx9w"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C29523815B
	for <linux-wireless@vger.kernel.org>; Sat, 23 May 2026 20:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779568003; cv=pass; b=T1EBFR8Pr554bARneVAzIOfUXUGL1XKtGnjbwoV1BPOVYiUxNKi2pPCjFH2BtM6aqbN7h4n5LDUNUY9c1zVFdzdWGvsnIv/iTD1cIIXoz9Ua/ZcZjM5tymwaKbpEUAKzvy4QAfUgCEcrSrTLbOOHb5saWCU74SOoaCCA1CRSQMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779568003; c=relaxed/simple;
	bh=ZlTqI7/Esz6racKcJLmPp0H32Q+er7razNZXlboazKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z/vtTKNnZgWHtUMYD3zBCYLVjQDawqoKuGjAq83rb5y0GyvIj6Gfe2QAPqnfO1y3eflYD9HZeGl4sqnvODXv0+ISkQXmN9vECCqK4BkHYuJweI8dPOrsdvf12zqAlOJMC2JiT8e4z20MIgEtvOxrJ1DVH68iuDK4A8NbSeEIyo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e0hzSx9w; arc=pass smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3042a388168so2051021eec.1
        for <linux-wireless@vger.kernel.org>; Sat, 23 May 2026 13:26:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779568001; cv=none;
        d=google.com; s=arc-20240605;
        b=ix0Sxkyo8bBZoC+V16HtIFBX1uIAj8xjw6U/mOf0CZAHiOpNYWteH99udXCDI0uwxD
         sQIlQbe70/mbuOshgOI1sQYMb5UGMfCCQeL7bXSVcPxHjdD0MDM5ObgFREZ+3ti8PCpQ
         MJDKr4FaIZ6alk++CPQKR5eNeoKJS+h9V/ksGAVpC0fV1LvDb4ALleMO0l0b0MfthUpw
         nzaI+eCKSEcy+pOluALrh+uD+dVT7wLH0kLiVB1fH/gOLsBnhc3DvUi5vYxJYkDt9NX/
         hCNG86/5tlWxMB12wo4AtkB9Tk8vYA6TqRaQ3197mQOnc/ly724ZaBJ+2y4OoDm0Myii
         y6zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=K0RRuOCVndtk9EZIwaESanvVJKl8ey89m4jFMnjBZdo=;
        fh=teK194+dSkJTUyQvGFnW+kIauoA8qv8LSRfoI0yF+zo=;
        b=DNSklDimpP9Yd5fSzu7EeMos+8IQngVdz/RXYVATcANoGPBdhKhl4eUANAc92LsajJ
         4oaeBWfJPsfT58dZzRoj+YROpGQ8fNiGyA2l6BFNG3lQdEJLFrgb3A0WgzwE9fycV5Yy
         Pr2iAmF5QCcId0dzcJNTC098yKohR7MhYBmIZmb5LRyZrbo+/zKGQEnVGCeJgOn/GJ08
         3x5MAuFk14TNQP9utLEZHzLDsQm6nhoVS9025DUohfHiz27UPWXbIUQlWVWWtbFMeSaM
         chsJzlKiG4Ga5620fHd03qKNbmTT3cvZN+j9ZED9zgBZPIGrF7XE7FPIP9tuZyhR+VVd
         TxFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779568001; x=1780172801; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K0RRuOCVndtk9EZIwaESanvVJKl8ey89m4jFMnjBZdo=;
        b=e0hzSx9w02vcnGUZfe2zhNudeWcqak4espKUYj/HOBoKqOK8z2KcGuaop8UEPy2xlX
         j26xT2z25TA9uS5ovRsTC6Nqxw4KOMDZ/NtnAWUzlY7xU8oWHGl/I9OZlhN4lJ/6Ey0u
         Y4RbWbSBAY6Zsl9XIdqps3rNvBNPlMsBTNVfrR/8dbWUsIPNPnhPoAIGbIXnvFAtB3Os
         JpPlM3rt11XMhrJE6Z6Y9FiR9RKKxMiebqq8NbWsitRZaReToG6wLjwZkgoi5xt/VS+N
         RyceuwX1w1jX7sOqCVPzY8YtvTHAjZXBzw2fjP/pl/mPqQWGQKd+qIJhOsBh21fjPrVM
         4Ppg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779568001; x=1780172801;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K0RRuOCVndtk9EZIwaESanvVJKl8ey89m4jFMnjBZdo=;
        b=k/mOdiDQtIdteDuPZrLUEtinqvxCDD5/WfaGUcjVUvxkjZQvDiOmqATB8BiPM1P7wb
         +418Era5hi/KaUpfMtLFTj48prFu+dxJV+6e0YZVMG1CmpKNBXwE9WP4rGRCtQGkWVSy
         ZxYmu+esZsz4AuI+zj/2NwKi9J7V//L11MLm9BpNovO0swmGNMakny2LEcXtCup+fVIY
         mjSBDfD4nk/FCpFPK6zdH4ZT3A+q6RQkD1rrOqxP0eavRThdrPJVtqqCQqzcdYMCkdV3
         8vbYsLlMkblzWFe5hYXjDbmFVT/xHLxs/tQn2ELylVbpJQxyQ32IBHGiwJksUk/zcShh
         4zVw==
X-Gm-Message-State: AOJu0Ywgqj5J03JoKXvgNxQ6MliU7faPCaM9KBSUv7nGsWlOGELvjgNR
	eeDKCNDlOj3HSp0+K2UoJ7d2R9UDsg6WxLcaY+keWazl8cgHo+xDmQM/PJKqKiNe6SybMC9S2/Q
	IJ9/Ux/gPC37uF0Y+3CnYOPFCmw18aeI=
X-Gm-Gg: Acq92OEN5rI9/H9C22QSL5hCdM0Wvlf7wDTABOtjcT0XNEJnQRg4eWJ9SKhdwcGCF65
	N10d2nJt9BNXdckT/3K5R3GXFUE/N5Z+GVybYZGmKFVTZTuGhvr4XzJbunWggIv+siPa2tIyZZ4
	by21Ob/mt8QtzKmxZSmDz7aSYDj1oQ/r5qYxVVePRVwAFRqjUfGiAKBeZFdAKslYNJGczCWe0yj
	NJUV6FXR6Okx+8mk0r/mAm2W4LVTj/KeC3Y4RjKNEneU0ea5S2y//ahmEvQ0C06Y3pVIa0WeQ2i
	DFrCwponHXp5DPXQv3kN6KJ1Dgdvokg2+gvqtblD0Gd1mUZsS6o=
X-Received: by 2002:a05:7301:5f14:b0:2ed:a58c:956 with SMTP id
 5a478bee46e88-304305282f1mr5832027eec.8.1779568001257; Sat, 23 May 2026
 13:26:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAecyrWNVtgywvchgHe1XLoGKcubEm_pgSQiv+i=6F4zdQhStQ@mail.gmail.com>
In-Reply-To: <CAAecyrWNVtgywvchgHe1XLoGKcubEm_pgSQiv+i=6F4zdQhStQ@mail.gmail.com>
From: Emmanuel Grumbach <egrumbach@gmail.com>
Date: Sat, 23 May 2026 23:26:29 +0300
X-Gm-Features: AVHnY4LX5BM5aXue3ONb3szI--rLt6I5HwNvehlbZC_HFh_i6Sia87U0PzwkNBw
Message-ID: <CANUX_P3v7Ecf_C=OUiLk-UZZFevLVTe_1uByEN4C6hLzox3Gaw@mail.gmail.com>
Subject: Re: iwlwifi: HE not negotiated on Wi-Fi 7 BE201 (iwlmld, kernel 7.0.9)
To: Michael Blake <mgblake7@gmail.com>
Cc: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-36828-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[egrumbach@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: 9D5D35C0C19
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

>
> Hi,
>>
>   iwlwifi 0000:00:14.3: Detected Intel(R) Wi-Fi 7 BE201 320MHz
>   iwlwifi 0000:00:14.3: loaded firmware version 101.6e695a70.0
>                        bz-b0-fm-c0-c101.ucode op_mode iwlmld
>   iwlwifi 0000:00:14.3: Microcode SW error detected. Restarting 0x0.
>   iwlwifi 0000:00:14.3: 0x00000071 | NMI_INTERRUPT_UMAC_FATAL
>   iwlwifi 0000:00:14.3: FW error in SYNC CMD CTDP_CONFIG_CMD
>   iwlwifi 0000:00:14.3: cTDP command failed (err=-5)
>

Can you attach the full message?
Or even better, open a bug on bugzilla.kernel.org.
Pick the drivers network wireless intel as the componen.

> Is HE expected to engage on BE201 with the current iwlmld driver?
> Happy to capture more detailed logs (mac80211 trace, iwlwifi debug
> masks, association IE dumps) or test patches if useful.
>

That would be another bug.
You can run
trace-cmd record -T -e iwlwifi -e iwlwifi_dbg -e mac80211 -e cfg80211
and provide the trace.dat file it'll create.

