Return-Path: <linux-wireless+bounces-37689-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Zfz9CPJuK2r/9QMAu9opvQ
	(envelope-from <linux-wireless+bounces-37689-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 04:29:06 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A754067647E
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 04:29:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=morsemicro-com.20251104.gappssmtp.com header.s=20251104 header.b=twaQxo7Q;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37689-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37689-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=morsemicro.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 211E3302E919
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 02:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BF0390603;
	Fri, 12 Jun 2026 02:29:04 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5133148A7
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jun 2026 02:29:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781231344; cv=none; b=f4T/PA+l5mgyC8bu5fJsROXv1K1e3c/nTA9HsyhYz5vegucppxdPmFe1apMSC+0oW4jkyFWsXT1IdTUOayYaf2VMb2Y2cS2sOApOcYABbUoBdGQ75f/wINcpwxGgaeztCl6C+t7/m5S6ghtlfIApdJJIaxFYwVXHyYshNTObl20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781231344; c=relaxed/simple;
	bh=7Iqd72ncQvRQKUtOsv57UJkiBgYzW1kb6U9Ky0hglWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=of7Of4UbcREmNPRdHVTb8mpolo234qau01ZodyWLkPiJkCMh3nupkd8vOT5RW9y4cRZsiqWoQD+gIV5M3HrpIwyfShnK/jc8vbZ6batyVTCV2bYnRxZMHCtbB85NGg8voqamgsPbVNOlZCzb8e5iv8qJnbMAgxOwIPS8reN/eco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b=twaQxo7Q; arc=none smtp.client-ip=209.85.214.181
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2c0c1e0d00bso4232655ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 11 Jun 2026 19:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20251104.gappssmtp.com; s=20251104; t=1781231342; x=1781836142; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bgU70E34PD3X1yhIwgVvpjjd0mgVE/TPAEH2m3iVtzI=;
        b=twaQxo7Qa4Wxhdxe128gyoII3L8LIsd9YsFSrCZdlsUV/slimGEZTUAXYV0sDGxm+K
         t2c5UvaGNVga3geif7U6zX31VeDGsbTsCvf7JLyEO/FfH5fO5ONSOEyxIJTlyQv2dnwO
         SOxxYziWIs+Qrh24K/ow3/10+BmseOysapNsO+UIVTbTC2QmKeug7vcuZmqPKmNanGf4
         AGdloaKnJD78cu8lHuU5TwgymuT0YZMqS2ft7CqlEAOY1joe3Ft6YuBjY1jI1+LRyVle
         KSFi4tAcEd2I4uMuYKZqLHDD0Q8XtTJdwiZXhtXIw5HIbuvNFOT1Zurggae5fROKKanU
         HGcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781231342; x=1781836142;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bgU70E34PD3X1yhIwgVvpjjd0mgVE/TPAEH2m3iVtzI=;
        b=VyNAOrebrGYg4tzd79nsZhHAGaNORFlull9mHOjsetzPky8yZSXaKyCJtaq2T5tfh3
         wFl5T5mipSQk/+8v9+gWgaD85wOaZAlg+7deAcvBL/mT6V3kUi9OzutPX6+9Hb31TJBn
         lyhKuqwFOioC+bDaNvZXty49YIe3SdMkgFcv3sRE4EFJ6LUQ+YV8wzXy0lyisJyYnrMy
         /gn8nQoIvowLpFqObR1WZY9JoliOHykYY3ymTg0jRngTF5UtNY+3ZRWMTzWIVmXtqvJv
         qei2kav5MyNZTOqtLKwEQUeu7Fh60uWdZy6dcw3KxL//3oz+bvEJTU/A/WrskfMLsy03
         meaw==
X-Forwarded-Encrypted: i=1; AFNElJ/VgFA6kTSG2S9m4zFk6P2o6qaJl/KlX4ZYZGtatTk+I07Cw9ArFFRo/68urmAINAQNu3FV8Tqw8j9JQFaaYA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwpO7ZKBFNrKyuBggAvR7XqmkTC3n0oePoh7V39wVOzXHDVN2sJ
	9HFtmZEZmx96INPGs5tpNlq5DGhtzG2dOdl/9zNZ+yxSov5I8zIoRStVepco8h8+72eXEZOomj3
	r9oe4
X-Gm-Gg: Acq92OF5Nsb1DHTgYsxRXTlwXHAe5/inRjWIaicqOKUOoT1S+x1XfeYDM1Frricmaec
	7FmTnpSHiwFeG81CSLtlRylZOiXXy1ThHuIC2Mhjf1Ys00aI8E7jh+GBmRe6ua3WTBtyttbVSF9
	oMbYKHm4y48UshoJWdUnGBWeNNoP9m1Vn8Ggf9JxGCTMKIVU9bEc7fWFfhk6yUqRiFQd8fyTF3k
	Q7P+4Ox/r1UlOa4uIwda0dZNnnzWJNZMJOwgY8QIy2nt8AQk5lgsvq/7fUM2UU7E0VpOJCTpjnQ
	IUWclTntpTmfYA1wmBBE6s9ByaPliSJEtn28Sn8u8Fuxidv3OvKmeBwK/CwCBbAfMH38QTApMA9
	M9Ao5vJU2hDUtMadypdrxWd13LhqE7foVkSE2nkGQGRqHEfvj/+vxOB38TgUXOAVpomI4iF0yp3
	KSmQPxoDRV+YantIkxRiua/2xYV+huQRy1wEQJwypAo9DEI0E+vsfLHg2ZYsg9Mo7u
X-Received: by 2002:a17:902:e750:b0:2c1:e04d:7cb5 with SMTP id d9443c01a7336-2c412841372mr11649715ad.34.1781231341705;
        Thu, 11 Jun 2026 19:29:01 -0700 (PDT)
Received: from localhost ([60.227.167.223])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42f7c651dsm2952795ad.26.2026.06.11.19.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 19:29:01 -0700 (PDT)
Date: Fri, 12 Jun 2026 12:28:58 +1000
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: Zhao Li <enderaoelyther@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, 
	Thomas Pedersen <thomas@adapt-ip.com>, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] wifi: cfg80211: derive S1G beacon TSF from S1G
 fields
Message-ID: <d65nudgv7m4s4ymi6vplknhibbqo44vetpt6fjdig65tahz5dh@7p4wzkmpjbm2>
References: <20260610162700.58722-1-enderaoelyther@gmail.com>
 <20260611161943.91069-4-enderaoelyther@gmail.com>
 <20260611161943.91069-6-enderaoelyther@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611161943.91069-6-enderaoelyther@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:enderaoelyther@gmail.com,m:johannes@sipsolutions.net,m:thomas@adapt-ip.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-37689-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[morsemicro-com.20251104.gappssmtp.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,morsemicro-com.20251104.gappssmtp.com:dkim,7p4wzkmpjbm2:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A754067647E

On Fri, Jun 12, 2026 at 12:19:46AM +0800, Zhao Li wrote:
> cfg80211_inform_bss_frame_data() parses S1G beacons with the extension
> frame layout, but still reads the TSF from the regular probe response
> layout after the S1G branch. For S1G beacons that reads bytes at the
> regular management-frame timestamp offset instead of the S1G timestamp.
> 
> Use the 32-bit S1G beacon timestamp and the S1G Beacon Compatibility
> element's TSF completion field when informing an S1G BSS. Keep the
> regular management-frame timestamp read in the non-S1G branch.
> 
> Fixes: 9eaffe5078ca ("cfg80211: convert S1G beacon to scan results")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhao Li <enderaoelyther@gmail.com>

Looks much better now when passive scanning, thanks :)

Tested-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
Reviewed-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>

