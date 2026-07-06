Return-Path: <linux-wireless+bounces-38667-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jPZcF+yLS2oFVQEAu9opvQ
	(envelope-from <linux-wireless+bounces-38667-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 13:05:16 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1204F70FA03
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 13:05:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=dE69HcGc;
	dmarc=pass (policy=reject) header.from=broadcom.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38667-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38667-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E5452A63B6
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jul 2026 10:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270023E4C95;
	Mon,  6 Jul 2026 10:20:35 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ua1-f100.google.com (mail-ua1-f100.google.com [209.85.222.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCF439E9C8
	for <linux-wireless@vger.kernel.org>; Mon,  6 Jul 2026 10:20:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783333235; cv=none; b=Ty3RpqSu9Qxx1lLNUDzBEeEq00j+w7+u7yIcC0oKFVvjmW+F2hJFHb23L2oOIDCAZaqYwYxgV5uM3GaO5SvuQ3a/Cz0uB4NnERKKM/reQwElwJjgiqh7Qelihk3nMQL7ovXaW1J04rRn4En4XZy4RNfX3xQ2UrZ7b32SdYIO0aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783333235; c=relaxed/simple;
	bh=EPJvLH2XrWxrxvvyY/KtJ0wRKmsinl2RvhB2I6CrPkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MPAsy+CU+2fx+CzibJC2BLnR7WY32wrADI5mmiGaGw7eVw3kxX1QOZKA9rcsUEBMDlGTlmvmmgIyX3IBb/mj67cES5b1cCk4MwnGbNw34f0ouCCc5oiKONlsdXaj6y2N/SH1lqDeU9Qba+hWJ2OA6cu5SOPebIa7qmbXzm8fhvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dE69HcGc; arc=none smtp.client-ip=209.85.222.100
Received: by mail-ua1-f100.google.com with SMTP id a1e0cc1a2514c-967327a0c7dso552333241.1
        for <linux-wireless@vger.kernel.org>; Mon, 06 Jul 2026 03:20:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783333232; x=1783938032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4zvBHBDRPKRPOI0v0RR4KjA0joSfTR2SBxREQR5gjHw=;
        b=pMP14OXlPrVqPUx2znrvtksP18BXjjNXISctvrHsQGVdcpOejrNr1G0KhA9ebAU66p
         B582+xSasGrZwFXhjWFurb7QDUAPcddqzZD4TLLwBhcPgR8lSp3plp6qPlErrUMFVEsn
         hHdqqtD9jb1UeyYMkU6Zpd5LO3jE1Mawn/daGziNc9PeCC2WnEVZu96uQ1c1Hh6y1aBq
         gv5M8iFMETcML4PkW5JCJG2QxoDDwq+9mjauDnVmXsm97S+XGU9jmj5FfApjnTOLsY03
         2AP9oXlcPzVCrH82KPt7k6mON3tz9OJ4qPqcozi7+PSkIB3y8JvpCGHGF6aKxVYlHNKM
         ZkLA==
X-Gm-Message-State: AOJu0Yz2g2H/SAlBFTk0wYRoxN32fdh2LFM984rR2akJQwvUTLaIPSI2
	sM5Cu7s4v6l3hQE7O96oSVzMFCDn5vJK3qTXn7m0H3Iysw97kb++GLUQicXz+D3o4kXFi34QAkj
	CDOG3T+ZWtldXwCATw5gHWT5ubL0dCUSa34q8maCHKfI+OzpaaQwpVtiBMMbolAi7Ofo74ygiA8
	BffQZrLsAP0Ow5YmTHZN/EpMiuHEXD9cFe0d90h7h9f6Rx1dqj5NsuWkWDcDWeXTKftY4smgg32
	lH0e6kRQEfP9n3Z557ug9vOcikb
X-Gm-Gg: AfdE7cldS4JKZnacG42CeldggpkD5nvBdtlg0hWOoHRfPBZxeGyhniZNr9FZVthbzg/
	21tMRszAW2yfcpC6UQM7KGTHGGQXOQqwQ8XHtkCZnM+sA6kr3xVDkVdXR7A8DFwlHNIc7KIBIzQ
	AWIZM/4jAPpoi371U0PfSkuxioQwtkUhhOcO1fCWLnHjJPTiBtH9R2AAHFiWhDXnlY0hbh3Pwmq
	0Jz89P5NHLbUNeLzXHoPTF4a7ACYVDI+4moYrW1hJK1SgxLRMUkifn7masosgwSGbD60l3efqS6
	/4lBdXbHI+/+2UN/rZTpiDbeaJA2S/pwoeLPydrh3m4PbYoAtg6ChHQ5jTpiJoNpWmoIFbGVCxb
	CGEKKsTOH9CO2OKkBYHQburZjIdXqbElSd0qO4/TT2tD0glaeoxJxg5wom7YmKoDq8gVpxdOxTD
	+NzG026qJAt/440bnbInQAWl/frfh4EO1VXvOoxKPJ92fs962BeRqn
X-Received: by 2002:a05:6102:e0a:b0:737:fce1:3277 with SMTP id ada2fe7eead31-7427f4924cemr2586038137.26.1783333232393;
        Mon, 06 Jul 2026 03:20:32 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-73e1c2b6c9dsm1027369137.20.2026.07.06.03.20.32
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jul 2026 03:20:32 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c889d1eedcdso4569265a12.1
        for <linux-wireless@vger.kernel.org>; Mon, 06 Jul 2026 03:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1783333231; x=1783938031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4zvBHBDRPKRPOI0v0RR4KjA0joSfTR2SBxREQR5gjHw=;
        b=dE69HcGc8RSsY4XpDZ+r5uqPgccJN9pcGlg6IpDKli4+t4bCbPsZ61cubAkpxu39eH
         dhC4nLgKLFa5lo7P9F8pfUxzByA6bnDLUKtk912JkOc/kGqyuawh5S38kz+D5Bgqpem3
         klCADKcNk0no34cqY/4KbgALHnfFHNwYnOGNk=
X-Received: by 2002:a05:6a21:a94:b0:3bf:9e25:1a17 with SMTP id adf61e73a8af0-3c03e1fa52fmr10502631637.12.1783333231266;
        Mon, 06 Jul 2026 03:20:31 -0700 (PDT)
X-Received: by 2002:a05:6a21:a94:b0:3bf:9e25:1a17 with SMTP id adf61e73a8af0-3c03e1fa52fmr10502599637.12.1783333230852;
        Mon, 06 Jul 2026 03:20:30 -0700 (PDT)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31151fff32fsm17754589eec.21.2026.07.06.03.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 03:20:30 -0700 (PDT)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Shelley Yang <shelley.yang@infineon.com>
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	wlan-kernel-dev-list@infineon.com,
	Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: Re: [PATCH] wifi: brcmfmac: fix 802.11x-SHA256 call trace warning
Date: Mon,  6 Jul 2026 12:20:26 +0200
Message-ID: <20260706102026.1338235-1-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260525083859.581246-1-shelley.yang@infineon.com>
References: <20260525083859.581246-1-shelley.yang@infineon.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[broadcom.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:shelley.yang@infineon.com,m:linux-wireless@vger.kernel.org,m:johannes@sipsolutions.net,m:wlan-kernel-dev-list@infineon.com,m:arend.vanspriel@broadcom.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[arend.vanspriel@broadcom.com,linux-wireless@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:from_mime,broadcom.com:email,broadcom.com:mid,broadcom.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38667-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arend.vanspriel@broadcom.com,linux-wireless@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1204F70FA03

On Mon, 25 May 2026 16:38:59 +0800, Shelley Yang wrote:
> Based on wpa_auth as 1x_256 mode, need to set up
> "use_fwsup" with BRCMF_PROFILE_FWSUP_1X.
> Or it will happen trace warning when call brcmf_cfg80211_set_pmk().

[...]

> Fixes: 2526ff21aa77 ("brcmfmac: support 4-way handshake offloading for 802.1X")
> Signed-off-by: Shelley Yang <shelley.yang@infineon.com>
> ---
>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 2 +-
>  1 file changed, 2 insertions(+), 2 deletions(-)

Nit: the subject says "802.11x-SHA256" but the correct notation is "802.1X-SHA256".

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

Regards,
Arend

