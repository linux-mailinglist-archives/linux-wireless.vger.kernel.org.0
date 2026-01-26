Return-Path: <linux-wireless+bounces-31184-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AHeLESnd2lrjwEAu9opvQ
	(envelope-from <linux-wireless+bounces-31184-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 18:41:24 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6CF8B978
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 18:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 196DB30138B2
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 17:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB30934D4C1;
	Mon, 26 Jan 2026 17:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="lVCPtbFl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F64D34C124
	for <linux-wireless@vger.kernel.org>; Mon, 26 Jan 2026 17:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769449280; cv=none; b=hkjvDhBZk0IOH0jAEPMCS0B59ysQrBqo7tGib3UlzML1j21EP+sJrbQ2rF2NBWBAFjW4TBkcNKQi16n7ZnudOiIP3hPvkk8dxPuq99MCCTMbltyspfbKBt8dqz5Sfyg4FQb40fVUwezDHaPdQY2TVy1z2Z+UkzT6aS9gjq+VJnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769449280; c=relaxed/simple;
	bh=f6sRW+OjiJKtFGszBDJ3KI8aEkT1gEIHN0sodVn2HIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pKiTiK+2FyWbLdbmK039yd/BY7c9DFpBlxiQpT71NrSFMAK2l/3OXotajl+e65jqV/DoXS/KP0RcrqngBuBat1c/roMkiV/ueOyqmuaF3iJWf+AfbpCAO5A4w5D9BGcRZz7ZkYb08499NMUmR77en42QlPrKvL15VNauT+DDt8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=lVCPtbFl; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-47ee9817a35so36591845e9.1
        for <linux-wireless@vger.kernel.org>; Mon, 26 Jan 2026 09:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1769449277; x=1770054077; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TxWCDGOalC1xTYHIkVlYbNPnVuMBEdIAI2IdHhYbv0E=;
        b=lVCPtbFlXnutH0pux2U8PHdrpJ3t1tDPhPaR/pNED8+HCTW2Si3ykPxccgofiKgjQa
         AFUc9eWHhMVb1ZMIDGmghr69sCjsJ9d8DrNgHX4HSdk0viOjIfGHrC9w72baAJAc1FWK
         GSRnGzBoySyuvepE4sDP6iJuEy9rzSTyFmjcR9B3NvQk0MD4Vo5Q+fBgnQeAT8P22jdK
         1YUyLJLG8D89qXBePRWJz9HcUrdtPi9x1EqD4neykUGPJ8+bE9fiPSkFmwp7hZoyM4+P
         +vOyqxngSTuk7+m+Hc9aVi5QRgA9H/NR0c2RpY5nxaObZTreS2BpRXMfe9gL/cHsul/N
         ponw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769449277; x=1770054077;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TxWCDGOalC1xTYHIkVlYbNPnVuMBEdIAI2IdHhYbv0E=;
        b=QZ2jWZrnknpUIKxRq2FI7JvjF4t9wCnfWIxIHgyNH2gUJwsIcGjd3z/2b76gFsKYD5
         9g16Y5x3xG7Q+1dsaFEli8flQxN3+lJ96ZY9WfM/0w4+8VEEF87XFw1v9gd/eEOnt7Ei
         hDld/s4TkV1fEhyMRnuCSp8VBwWv8PyEt/CsiZvzkB2319pFfdDhiwHbtjj+HxaURSO5
         OvHnmBBpgZHNcXZ301K/dGqGW34A5D0qtfnVovuX+fHiwVrBw2IH2eymHU+gvI3+FbbF
         XWYdgoHw10q4lKZxATeRpb8DYon40hcam2KRk59lJ6BQO3ZJMV0HBWcOeGmuEwzV3ymM
         0Llw==
X-Gm-Message-State: AOJu0YzQaLCJqEYCRQp/O4FXbejZDFYkDz5rddZPK5J4SjP89OQSf07+
	e/QMTOupzOxw/3b5lBl8UuVCrj4e9KIPvgdD8LY3P/A2mYwslrYMncpVAHhPn+CPGJniQA9cinF
	2eIkVFh4=
X-Gm-Gg: AZuq6aJNQcxpMOZq/bGan/ssAfVm37iz6oXHEam16nLmRV4kO8lnId8VBzTuCgsaVGS
	AkUKY/LC5soCtq/UrCjQ+URvXQQAuv670rElnH+JFy30PCkcV45eoYClCRbgsByUl2WpoyrUBwJ
	p0uzXa1s3Jv2tEM41LjdmKipZgfaGKv8xsq/auppCcZU4JEoAz1k1YEJHFDEy6z7QWdTNjVQaLd
	hxsJUEwBH85E7i0oWdD05ggoGmguXWCyIZhhZ5zuLhY0V+PCUfkMbc6nNTJwrZFJxHjkzprGjN7
	WG5T0n9RTT2v2tyRykaMDzjkh+oANrw78koupfmpa+wa6G0ageS2T2cvsN7fTCmflcD+yahhCbq
	6AcyidGARUlEEARAR0NTsMLyyRGkJDz/dhWCte5Cu88XhshY1j5wMYnLYwPG91qVd3Qq1ij8clr
	ALs34Og/DgMQaYr/os4/J83+4+QKSxUuJJrDzNh9hy6Mp6Y14ya2N2
X-Received: by 2002:a05:600c:4eca:b0:47a:7fd0:9eea with SMTP id 5b1f17b1804b1-4805ce3fdddmr78475835e9.3.1769449277609;
        Mon, 26 Jan 2026 09:41:17 -0800 (PST)
Received: from [192.168.108.101] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804d4faecbsm109407095e9.1.2026.01.26.09.41.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jan 2026 09:41:17 -0800 (PST)
Message-ID: <45cd1b88-105c-486b-975f-a5fcd5bf78e9@freebox.fr>
Date: Mon, 26 Jan 2026 18:41:16 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-current] wifi: ath12k: fix wrong TID passed when
 stopping AMPDU session
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <2633095a-9555-45bf-b143-ad2bdaa1ab01@freebox.fr>
 <9c6369f4-c80c-4a59-a17a-7b4ed0d8a032@oss.qualcomm.com>
Content-Language: en-US
From: Pablo MARTIN-GOMEZ <pmartin-gomez@freebox.fr>
In-Reply-To: <9c6369f4-c80c-4a59-a17a-7b4ed0d8a032@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[freebox-fr.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[freebox-fr.20230601.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-31184-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[freebox.fr];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmartin-gomez@freebox.fr,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,freebox-fr.20230601.gappssmtp.com:dkim,freebox.fr:mid]
X-Rspamd-Queue-Id: 2B6CF8B978
X-Rspamd-Action: no action

Hello,

On 26/01/2026 18:28, Jeff Johnson wrote:
> On 1/26/2026 3:35 AM, Pablo MARTIN-GOMEZ wrote:
>
> -    ret = ath12k_peer_rx_tid_reo_update(ar, peer, peer->rx_tid, 1, 0,
> false);
> +    ret = ath12k_peer_rx_tid_reo_update(ar, peer,
> &peer->rx_tid[params->tid], 1, 0, false);
> FYI your e-mail client is munging your patch, adding a line break.
> And using "view source" it looks like other artifacts are being added.
> My tooling (using 'b4') cannot process your patch...
Oh, my bad. I've resent both my patches for ath11k & ath12k with git 
send-email to be sure.
> Applying: wifi: ath12k: fix wrong TID passed when stopping AMPDU session
> error: git diff header lacks filename information when removing 1 leading pathname component (line 6)
>
> Suggest using https://b4.docs.kernel.org/en/latest/contributor/overview.html
>>        spin_unlock_bh(&ab->base_lock);
>>        if (ret) {
>>            ath12k_warn(ab, "failed to update reo for rx tid %d: %d\n",

Best regards,

Pablo MG


