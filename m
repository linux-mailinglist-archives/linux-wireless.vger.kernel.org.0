Return-Path: <linux-wireless+bounces-31115-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id zvZ6IAB8c2lowwAAu9opvQ
	(envelope-from <linux-wireless+bounces-31115-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 14:47:44 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B7B76728
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 14:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F0A4930089AE
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 13:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D68235977;
	Fri, 23 Jan 2026 13:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mnxdY5Jz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2331B394F
	for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 13:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769176062; cv=none; b=u6VDMZiTx+avmsQBM2DzE9XduoSJdBODHYnqWXJ5KfoPk6t2LJ/83W6C6QEatxLxDc4oGwjfWv6rnFTmZ1QGgW57f3z0MlPpbfks8CuKGFKkTlLy0awMck0VgWtW68AmYaMuA+Fz8cJgb2XVO2P0eiWVtOHjAK1T9SmLaHYTy3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769176062; c=relaxed/simple;
	bh=vDw6xmuKifeBebBIrOxzyi9SXbfOM6lDcV75mlsnFzQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=Y2012oadHkNjYXMXUpDGYuZzpizuwEPGjtGpm0TDg22NEjVR/p0qcQKFFHsGHp+eOoS5lC5+Q36GIYDPmeJSnoB53/RHa4wDqgFRMWBdAB9iCeeMjec3kwZCnjBDFJAd5n2pLyw16TLGvQAzGAU2qBK9hAmGfmjYfHrKuOUFLgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mnxdY5Jz; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4801c1ad878so22882395e9.1
        for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 05:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769176059; x=1769780859; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vDw6xmuKifeBebBIrOxzyi9SXbfOM6lDcV75mlsnFzQ=;
        b=mnxdY5JzRE6HOzy637FPS5ex6gzlAsNXvPsIqjiKfRVuqXt4IOVkpwCAcOZ0OoJFW3
         1SrHNWlytlzG1y28j9C1VI33LqZJVp2n9pB+wRFQKitTRFMy6KQwgVxtDUW/nsEEeKaQ
         50PGd7CPKlv9JXPHWWpvGjjGftYqFJw3xxVIqT4RtNwY1m940VANHgWnCCtSRcqFjuh/
         eYGKMoAjM8WtfnPl56AzLRgc0lo9v8BoDQSqbKI27u8rzsyQoFIYmmsjvDgiWtk7+kL2
         FNun4rXw0VFu1mQ/FjDtse+zTL8brCIbclE2DpvgJflgaZcL6xFap0CxvtDOFnd4oaaU
         +5mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769176059; x=1769780859;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vDw6xmuKifeBebBIrOxzyi9SXbfOM6lDcV75mlsnFzQ=;
        b=b8Mx3g+SZLKadIqvXtKd51e3jM2VkZPN9CldBLNz6DvTXZFl3rS9qVsZeZjL3dZj3T
         +ZLefdJb0Ghc13i6IW4ivdhthiNUjTL1AsphbNjKprNuxBp+w2tViMSvectU8Cbqi5MZ
         +Owq/GcLzTW0rGo6B6QTj2ON/3OjaS8gIXwFYj+QwxuFI8YvRwYznOpgGhD/QMEdE1xh
         4o9AfzGW3JKfrdAVF6pwZU0k87sXyjvfIY0ltxmn+tiiOLEaeJhiFKUo3nOEAqKk5f59
         EnYHbKz15HNo29PD+l+d+9722lM1m6nhArp6/K8MEdQrQmEIbDBYXxw+MkmKiyUQgOBv
         izkw==
X-Forwarded-Encrypted: i=1; AJvYcCVXFrmNEdCyVrY37M/5/nT6AancRbq6uw2KTJ3HnCCUI/lRrmrPbk4uZUBYaK9JDF0vFTVI/WB30caB9FEXmw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyR/I2evpAzNAE3qhhXL/ekY7oJBC8H0FH/HGC5/qcg5NPL03Rq
	4Y8pFFAjRfelQWTMizHtZoWwg7TqaXvoj8CqHf0qmMY87FDgJlGaWGg1
X-Gm-Gg: AZuq6aKUHK+7lljmksKWTi0g9Kavdu5dODWHiM98yl4TFeMN0o5DW+w8D6NWUXxkA4q
	cIzt7sxfktoTie0IMDyN/363velU6cFyoAr+o2E8wfqlomSb9+Van+WZCjCA8ZkyYx9OP3eO8PL
	4AGJqCqeUKuykDMSEFNilxKnfAB6MuNh4cCHsloLqDoL3m5f5j49XDHDxG7DDyYj/q6UdeYhayn
	M+DoRfna4rfBYQPE7binpcHej45TuMlNdKaNHicpCmYm3gzRNtuudg1yUl0xN3Mmp9yBFT1F31L
	harlILu9wLFtSN/yK33vhEpNcYcoLFQguBqozWF6nQwQVsz6kk7lJNvQ8iXXDLFXxtHCEB0AYGc
	UQXQ7ApPPxih40JwSY5bVKYrErXSj/13j5epmDjaRNYkDB8REoNcWPSv/qls5zw5l8KCfzC9CBf
	z5vdmDEV7UC7CF97Jt005Rf/Vz1d9/CA==
X-Received: by 2002:a05:600d:640e:20b0:477:7991:5d1e with SMTP id 5b1f17b1804b1-4804d3c9da2mr37374905e9.25.1769176059113;
        Fri, 23 Jan 2026 05:47:39 -0800 (PST)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1c24acdsm7382309f8f.13.2026.01.23.05.47.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jan 2026 05:47:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 23 Jan 2026 14:47:38 +0100
Message-Id: <DFW0KL08YQEF.1KG7J1I78VTQ2@gmail.com>
Subject: Re: [PATCH] wifi: mac80211: do not set 320MHz EHT capabilities on
 non 6GHz band
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Johannes Berg" <johannes@sipsolutions.net>, "Nicolas Escande"
 <nico.escande@gmail.com>, <linux-wireless@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260122145620.861355-1-nico.escande@gmail.com>
 <829488acfdbf7ecfe6418bfb2c5669dae18392ed.camel@sipsolutions.net>
 <DFV9KI49QEP2.2TMVJXR5EK0B7@gmail.com>
 <b2cc421f0416cc1ab42a937ccd78b4a8c27d47cb.camel@sipsolutions.net>
In-Reply-To: <b2cc421f0416cc1ab42a937ccd78b4a8c27d47cb.camel@sipsolutions.net>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31115-lists,linux-wireless=lfdr.de];
	FREEMAIL_TO(0.00)[sipsolutions.net,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicoescande@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 20B7B76728
X-Rspamd-Action: no action

On Thu Jan 22, 2026 at 5:41 PM CET, Johannes Berg wrote:
> On Thu, 2026-01-22 at 17:38 +0100, Nicolas Escande wrote:
>> For context I initially encountered this problem on an ath12k AP which h=
as a
>> single phy with both 5GHz & 6GHz bands available but only had a 5GHz AP =
started.
>> On such a platform, we set this '320MHz in 6G' operation on the 5GHz no =
matter
>> what beacause of the phy's capabilities.
>
> But that's what I'm saying why it's a driver bug - the PHY capabilities
> are advertised *per interface type* and *per band* by the driver. It
> shouldn't set this one on 2.4/5 GHz bands.
>

Arf I missed the per band part of the equation. I'll fix it there.
Sry for wasting your time.

> johannes

Nico,

