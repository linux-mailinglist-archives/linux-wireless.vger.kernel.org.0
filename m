Return-Path: <linux-wireless+bounces-31425-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id XORWE+Mef2k3kQIAu9opvQ
	(envelope-from <linux-wireless+bounces-31425-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 01 Feb 2026 10:37:39 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 931B2C558A
	for <lists+linux-wireless@lfdr.de>; Sun, 01 Feb 2026 10:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A24C300FEDD
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Feb 2026 09:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E987131B10B;
	Sun,  1 Feb 2026 09:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PaQktTRk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f225.google.com (mail-pg1-f225.google.com [209.85.215.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA732E22AB
	for <linux-wireless@vger.kernel.org>; Sun,  1 Feb 2026 09:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769938655; cv=none; b=aI6nTgjnMB9lb7jJVOauUKGZdU26aqCBaweRSSoMAVWBovuBEGDLB6tJm4GHw8+CfeHs5W2AKwG+xtMwFb/2dFeUDu5XD2O8GDobE77vbdKuEtVkaJulMayYe/0WasVrxQ0K0jYMJQCrNehpAzQCijCpHkfhPyR8rM/j4loZg1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769938655; c=relaxed/simple;
	bh=M/0Hnb+R8Dq1QHIiwBEGpxuUzbSdVZOGIUxFZsjTxVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZesbkhQDdQ/WsTzUGYKqE6oeCSHc6i6WmQ5hAZ7ILWIxU+qRaAmKi7mzG+QqGxaNrDGV+5wSq6C8h4p7YhwbNJDMsKRZdfMaHvWGKuDlyJhXBGMFZS1kafTbXh412DvXtlsg5cU0cQLJJEnZvpULQfBwM5vSOoPHzmIVyVIzA0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PaQktTRk; arc=none smtp.client-ip=209.85.215.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f225.google.com with SMTP id 41be03b00d2f7-c46d68f2b4eso2158214a12.2
        for <linux-wireless@vger.kernel.org>; Sun, 01 Feb 2026 01:37:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769938653; x=1770543453;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qnu/SgU92pbwPypfmo2wXrvY+QLkc8ZneC/N+w9GCAU=;
        b=MExwfYVFEnQatktx2YPhYmbXhrN5mliQpTkg2ibrUZ+2dt9b8i/HjPl0gpBXeGgzlL
         vMYWnX3zSy5ik9c4YNIkgy3bTnnTYrnwyYhbLaF8NmulwMFXV8ZApcYtXAVK55t2BBT2
         JeTmuQGMctWjMuj5YHWjPATRqWo7AVWUbZLz8dFoEj7HL3nEbhgoT7cUjtVkpchcLymY
         dcbu8puz9S4t8XbxEQu7TD8qXiFP9LQCXfh0Ku4uH0pucS83aTu6Lty8pmBrDZ9b8HYP
         aAphWcAfWoXdAr/Ir5f7LgXuO4xHiJaiEQg5lwMGgFYxgd0/F+FeUyHIAPRCIBpCGjk8
         ++oQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1RsioONoG1XK/W11rfoplI2cmrf42w0RhBfpQqiztLoTR6MjRFTG3qjqWLD0UaJ7Pwipl+1VeYPvep0WaRQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwsasdbaG+ctXtTtyOyRiN70pfKIjb2Zm3EuH+W+RuPb8QOwNao
	KMuOOcef3tm2VRs611PTMJTCPucSi/Apj/lVu0n/ZviVWo/jLWtfX9Ht/89w6ooDFWaIl2Loo1H
	/OHUsHClubOTS6bY8bkCbYiCY3bqagEBNLhGe+l0b4VP5QsQjlEyCVooZQYnPg0p1RzIFprdabL
	vdlnrfTzQbhYgSWUY1YAvunDE+94BtTnGWPgKMXfZlgKWmaGxZk8qoGTPgxo2jd74B0wDsYAzWJ
	RNRoozQm1juGzxgJvF4JFXFe1Ed
X-Gm-Gg: AZuq6aI2WM/VEv4Zc9AVQM8zrAQLS1GlM1VhMBEJsgy96+1WaXz/rTed9BhiMF5AXlz
	8265JzRK2Jm3rQ0Gon7hbS2uA9YKaluyUtTQL3JznvMHl7sNzwqHM/8cXtlqdpO/nDob6PRlYKU
	2mb1s3GFNFUrzEc6LS/20amDrpUpkjP0p94EhTu23b9z7NDHdbArsdbMh+IMQPKn5XpHhBA0ddj
	mRhmTJdY2ZX9y0g/+cMD0yy1pjlSW6HTMavTIV0d2khNnZJ4OQn0dRCoZ5p1Gid9jZZL5uPepyy
	WvdyZqvwNMZ2W2iswCr1ak7WXktWlBLneUKsy7Rfj0Nse55Esym4/FoslUQLFO9UFpzFlUs5RJi
	qbnH32UfHlAvJUkG/q435dmoxkr5mtAXOfxjPN1Nxk50POSqfyNrACo4PltQ+OrYx4IymtCIKmr
	H98CsVg6ePGNpoSF6rEpGFyRrRC5fsHQgeU1G/UcpY1m8d0A==
X-Received: by 2002:a05:6a21:3a85:b0:35f:46d3:f28e with SMTP id adf61e73a8af0-392e0116a48mr8929360637.43.1769938653451;
        Sun, 01 Feb 2026 01:37:33 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-353f6255654sm2297601a91.3.2026.02.01.01.37.32
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Feb 2026 01:37:33 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-65811843ecbso4226628a12.0
        for <linux-wireless@vger.kernel.org>; Sun, 01 Feb 2026 01:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1769938651; x=1770543451; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qnu/SgU92pbwPypfmo2wXrvY+QLkc8ZneC/N+w9GCAU=;
        b=PaQktTRk0ioLO64Yj8A42ROwxbYqSP0STk5yH9FdYyNtMudtRYP6zmyMHH12334vyR
         Oca3GLGipbO647cwI1mvCTlJbzlX0rdfygyFMkEpKt2PUgymrEOrAduA2n5+I5zEz9G8
         xSHH+VtJBGEptEtE3szcaD+PSJJ2pK9HvOvVM=
X-Forwarded-Encrypted: i=1; AJvYcCUDQpe2bwdsMtipUrPWpbV6LCKOHoljB+igELeTo0rm52kXOlRmSHiXVpTPgs3hp8R82PUTKnTPgcKjy4TVpg==@vger.kernel.org
X-Received: by 2002:a17:906:6a12:b0:b88:58e5:86ff with SMTP id a640c23a62f3a-b8dfeb307f0mr597041066b.0.1769938651316;
        Sun, 01 Feb 2026 01:37:31 -0800 (PST)
X-Received: by 2002:a17:906:6a12:b0:b88:58e5:86ff with SMTP id a640c23a62f3a-b8dfeb307f0mr597038766b.0.1769938650846;
        Sun, 01 Feb 2026 01:37:30 -0800 (PST)
Received: from [192.168.178.26] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8de289bdf4sm554275666b.44.2026.02.01.01.37.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Feb 2026 01:37:30 -0800 (PST)
Message-ID: <9dfb36bb-07be-4559-be83-39fe5c4dc9aa@broadcom.com>
Date: Sun, 1 Feb 2026 10:37:31 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: brcmsmac: phy: Remove unreachable error handling
 code
To: Ingyu Jang <ingyujang25@korea.ac.kr>, linux-wireless@vger.kernel.org
Cc: brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com
References: <20260131172355.3367673-1-ingyujang25@korea.ac.kr>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <20260131172355.3367673-1-ingyujang25@korea.ac.kr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31425-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:email,broadcom.com:dkim,broadcom.com:mid];
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
X-Rspamd-Queue-Id: 931B2C558A
X-Rspamd-Action: no action

On 31/01/2026 18:23, Ingyu Jang wrote:
> wlc_phy_txpwr_srom_read_lcnphy() in wlc_phy_attach_lcnphy() always
> returns true, making the error handling code unreachable. Change the
> function's return type to void and remove the dead code, similar to
> the cleanup done for wlc_phy_txpwr_srom_read_nphy() in commit
> 47f0e32ffe4e ("wifi: brcmsmac: phy: Remove unreachable code").

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

> Signed-off-by: Ingyu Jang <ingyujang25@korea.ac.kr>
> ---
>   .../wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c   | 9 ++-------
>   1 file changed, 2 insertions(+), 7 deletions(-)

