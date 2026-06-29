Return-Path: <linux-wireless+bounces-38228-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pyPaMa24QWqltwkAu9opvQ
	(envelope-from <linux-wireless+bounces-38228-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 02:13:33 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C78CD6D5573
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 02:13:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=morsemicro-com.20251104.gappssmtp.com header.s=20251104 header.b=kuYRO2s6;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38228-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38228-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=morsemicro.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E92643004D3F
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 00:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B28540D57E;
	Mon, 29 Jun 2026 00:13:29 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF13A1367
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 00:13:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782692009; cv=none; b=bAzXF3ni9Ffux4gT9/CVW+P41BBg68VGaQ67tofjT1pNoKE2AyOj6aOLyf7jJ+I5elUsv4IdM/sseqyBtNA8APuR20EilLZX/myaobkc1ca/koFTbbJmT0e6BRfOLIM8qDR3Hh2SRO+Hp6ZJ1I5zc3b3p66qoeRFviqHhGOLYso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782692009; c=relaxed/simple;
	bh=VD/rmeMX1OvVeIY2AYHg9jDjZFfxwHoiyXQJYM6CQag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K58MEoHf/aCM+3swyDe2kmQcMBoMd/NoGZYv47pvyeEyMYz9+1QC6M4jBD6V8EB6OFWCp3C2F8wjSS9CS6VCVaxuukjyHim3xUf9HVVmWVRfhBXKNsnoUd7CIgWRgTX2JNlzpuDG1MgGsZRYc29TfPJLzt/BYtQTNAztaSMKiqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b=kuYRO2s6; arc=none smtp.client-ip=74.125.82.173
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-30e7eb50b83so1250094eec.1
        for <linux-wireless@vger.kernel.org>; Sun, 28 Jun 2026 17:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20251104.gappssmtp.com; s=20251104; t=1782692007; x=1783296807; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VD/rmeMX1OvVeIY2AYHg9jDjZFfxwHoiyXQJYM6CQag=;
        b=kuYRO2s6WhZ2Cs6kwxOJ0lBiFPmwpgMur0dlwxibGPC2qGZ/OPLHSF58dmZWnLY+U5
         ZZsiJbUnWWqE82t09ySshR25dZxTWatUqTY7MjfhmE/3YgzySS6Y9ky5BXPVcBGMzxF1
         XHRZoS9TPhxYsa5zV6zJecC7A9tPLEH9LQjsHhKScKA2ZnMyjGeWDytZeyLDnuQ2aFnz
         mfpOHsCkhZH6QzYJLdmvn8EU8vCeiDHxuf2tnWMW3GPz11kUBfFgZ/OKR8Ui1LUnQqED
         x5dCm2wHPDAduR+Qt62fXSdxRSEHLq8nYbekfWu5CMmF6ulom+aWBFeokIFXJLjY2+cx
         FeOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782692007; x=1783296807;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VD/rmeMX1OvVeIY2AYHg9jDjZFfxwHoiyXQJYM6CQag=;
        b=TngcN5reZUjB0Va9EEgClrJMQZFlgGszGkMIfeCcgpn4NqezLTa0u+eywUTWA+54cI
         jGQv//AOl45fZ2BFFvnclxLxytNuip95jtOdOYaPHJmE45bFsM5hXczzDlFXl71f+Ess
         7ieQ9lRZ9VXW22YgB4G3fgbO84BfOgdb0eI34idjC+J+j8+8UuQ3XmJf8lTbITJ8ZJmf
         9AO7ozb0haHxDvxplfdZ4U6dMT3GV46R4TzMpHAz5cFpD+Yfr74AGU92KQFa+R0FFU3d
         w9TaCMwHV/XMMect3HBOELzseCbCnPT9C902HPXAyM0Ykcsp+USrkFcquxY67ybQYtDA
         4kDQ==
X-Forwarded-Encrypted: i=1; AHgh+RrlhNJ2Bm0prJdSQqbCeLGbSv12Nxwq/w+sDqYV88JScGtfhymoPeuBR+cBxR7THXK18Zgoz2brwuadwkBbZg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZBasKUTjd9Eoqgdzvg1oMoHtK3MBXJYwuJt2zU+sCrNx+Ccq6
	MPe+YJlIZbisyqzEjIRyaBjgsleWmUTF1IfDQt1Stux4KBYNb4/oeCxQpoK1uoRK714=
X-Gm-Gg: AfdE7clL4Ro+NyDRvQ0IGbypHZN4JWXTo1R60CROe8k5qNohQBi1wkmmt99/ldyd9uZ
	JXbmSZNeRVWVhPzujHnkVrlHQnejwQfjrKbGjDQ0Y94STCN2jEI9XbuenUUnmV2C5aP+El1q1uR
	WW1CfoqbRb1Fu8YtHmF940fhvihRXZnsUcwM2miR5zJ2k85ibALR0Al/6amo8fCm8f4/E1mwC5u
	gVQxlhLBhtbJOWkUln4x6fDrXJocn7TYxWgI83ln8XUvcKk+ZP3+RtOTle1ANJoYeueO1NIbjUA
	rdFLdRUDjznAUaxhZFXuu/zoNJyfBWIXQ4Y1TFvCafj3LVPP/8WUfhrO2xbSvlrP2D9oGHC1ypR
	br/AXpOeqAdnrClK2nhXgNWM5fN7bqX+5l8panQjVpdI6vtUvWIFYYvnFShuMdokbYb4FLXlZcq
	4Z4l9Ymh9gJoO2PALub0/E4JgILBoLWXwwtlZ9+zmCe8U9chlHkB2OWYrrjotvR4iDGuMIeMrA3
	ovrKvfVOwxCC7qD2YLPvqI=
X-Received: by 2002:a05:7300:8b85:b0:304:d835:274 with SMTP id 5a478bee46e88-30c84cfb442mr11855684eec.24.1782692006532;
        Sun, 28 Jun 2026 17:13:26 -0700 (PDT)
Received: from localhost (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c52c664sm44039396eec.8.2026.06.28.17.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 17:13:26 -0700 (PDT)
Date: Mon, 29 Jun 2026 10:13:21 +1000
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: arien.judge@morsemicro.com, dan.callaghan@morsemicro.com, 
	ayman.grais@morsemicro.com, linux-wireless@vger.kernel.org, 
	Andrew Pope <andrew.pope@morsemicro.com>, Bassem Dawood <bassem@morsemicro.com>, 
	Chetan Mistry <chetan.mistry@morsemicro.com>, James Herbert <james.herbert@morsemicro.com>, 
	Sahand Maleki <sahand.maleki@morsemicro.com>, Simon Wadsworth <simon@morsemicro.com>
Subject: Re: [PATCH wireless-next v3 00/33] wifi: mm81x: add mm81x driver
Message-ID: <a6xdwxllzb6c24n2nehcc4b6xkten5ev5vg6mtr5ekgjyt33ou@wewipwdzl3i3>
References: <20260626063014.1275235-1-lachlan.hodges@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626063014.1275235-1-lachlan.hodges@morsemicro.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:arien.judge@morsemicro.com,m:dan.callaghan@morsemicro.com,m:ayman.grais@morsemicro.com,m:linux-wireless@vger.kernel.org,m:andrew.pope@morsemicro.com,m:bassem@morsemicro.com,m:chetan.mistry@morsemicro.com,m:james.herbert@morsemicro.com,m:sahand.maleki@morsemicro.com,m:simon@morsemicro.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-38228-lists,linux-wireless=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[morsemicro-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,wewipwdzl3i3:mid,morsemicro-com.20251104.gappssmtp.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C78CD6D5573

Hi,

I forgot to attach the firmware and board files to the cover letter.
They can be found below:

BCFS:
https://github.com/MorseMicro/morse-firmware/tree/65ca270dac4ad70d009db6c50b26502177aae9e4/bcf/morsemicro

Firmware:
https://github.com/MorseMicro/morse-firmware/blob/65ca270dac4ad70d009db6c50b26502177aae9e4/firmware/mm8108b2-rl.bin

lachlan

