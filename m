Return-Path: <linux-wireless+bounces-33587-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KA2qB1wcvWnG6QIAu9opvQ
	(envelope-from <linux-wireless+bounces-33587-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 11:07:24 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 797532D87B4
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 11:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4D6A73013706
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 10:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6350F361DB9;
	Fri, 20 Mar 2026 10:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="Q+9QG7kt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793B7355F3E
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 10:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774001174; cv=none; b=RzbSx8YA9SDFJT34tEJcdK7XP9ZT2I0OntBY2tQufqsgv1DXLhUYJ2dEYdEjwpWB0Qg7BPeANU4SmxGA17BAWSgyR4uHxDf2f5C8avuGFIK9J4kwxMB1xtC4oxABCW9qgxE0Y2RHskL8pIwQ2ijbyOpLOb4X53qwF5LV/bAW1k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774001174; c=relaxed/simple;
	bh=fKQq08ZEQm1jO/U9H/4N0YaMl955sh5+5UGEGazN4es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Txk4xynXnHebN2aC1KOv2WjMVLWLCeL/hm6OzKAsnGioPzqN4vOBb+wFEH2WykKiLaVDxCZk6Eayu8mVuf1Y09zQoAQTiqEnvKVW9AnGJ/nN0FL/y/qKXm7YBnIabvW+hu5NMUnsOQtfaKIN9N/+siWaRzYcv6h+vCLxTOare8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=Q+9QG7kt; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2aaf43014d0so10877365ad.2
        for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 03:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1774001172; x=1774605972; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w8IQbZdokb5MZcLriE99rlLeL24BfIJ3o+6efr97+kQ=;
        b=Q+9QG7ktK1GquQanIUKljDRQzbX9qVAdnqO6IleLtavFNkqFGnzW7kB5ZSXXmgJ7tm
         lIZyR+voL4kqRIRCmzswbM+UvP+oB9oqRFA3qoTVlvEg+gH/rd/Vjx2jnem4pQMH12Qf
         CatqdVTRYqEpsnP88wUu1TzsUgOvhr+bRhiVSngdY1ldz1OqS3ef5/tIu8NskshfiT9J
         KrMS2wWR3BcIoFdfn7SONOADAmCmzVauJlWw3mi5xB/Q4Q78NcBm3Z3I7rE9a3mRymOC
         Wt31pE9vjVp1nATTIW9v2CInUP+uc5Vq4716fLX5ovFrfLLre0+2fB1UedcZdiJPWZk6
         EQ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774001172; x=1774605972;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w8IQbZdokb5MZcLriE99rlLeL24BfIJ3o+6efr97+kQ=;
        b=mlC+fY3bXr+HNAtIruJpZKsOLTZeVY9HY2ujdlGHXEHHm7jpM4u2VOvmx0DkgA4Ay+
         SyRXB6rGhPvR9WGEoIRCcCYRHRDsZ5p4yYF0Kkc9RNMJlGRSFwmxPQjIYOVJjmbgRQ/U
         Ci0LV3Cusrt9GDY26Dm24yxkBag4x8clMcJsB7H9xP97CGu3tAdS1JVR1dXk1oC5DBZ+
         9qe6C8x3y+0J4olL4BZ/SsWzIIHNiQ+c5OzRT8TfYbQIuXmSOzYQ1GwfaM3zXHg3H6qp
         xzpF6D6iJZExicPhiPoS6k3aOBsA+6HcIrjuOKrOcGV6V7X74YKPgKo42t7VK9nOWDys
         RoKw==
X-Forwarded-Encrypted: i=1; AJvYcCUNNfR/7zMubvR3aD9rP/8Z//zSNOOU++UZXgfDXDscjX4P746J5Wil3/WkFLPqtiKAqGHzes0zZra7j4nCow==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx640QKVOg1OQ8Ho7OUz9ok297BDro+iNg4kmXAmNujs8/7wvt0
	JoH6Pg24A6oog9fECMOCBDoVUvYQHL6d4kN80eiGBmYimV2sg6ICZ9y8OvxkEI45s3A=
X-Gm-Gg: ATEYQzx6dkU7Ls3dlgKuaMw9zZbMe52mBq+niaJZz7BZamk+oeASnMt5/mG78DGligz
	tMj2DgVrKesDQOKkezuu+oSc7Iz7F8BZUhjSpoJ0EXSb03DEqg+0LMnpU0IOgPhswWshKHrbDgR
	EueBi6Lb0reGenm5xk8CRrsrZ3jn5/aTvr44tR/EDE63T0cPdOFumbD3OXHIMHc0b05cpy8KUsG
	MqICZ8W54QKBALgww/DZiAkDooW/IPPH4y5Lbxmp8dsASgqy7unpO94M/luTNnDkAOAusD+eEZz
	VHIUU4TbREcUnvG0mI4AGhb2aCwHWcFb9ZIR7+IKb/i/d1yiYjA0w4nUP8GZ3VZnnixwaR5+AzN
	AjQWqbgQmyMuaDD/OctkKV7k4X3x/LXTqelsDeLuaEQtdmfNlc67GtNVskvfk/KI7wCdbVMK1OJ
	wneK1rOgaY5EBv2hots5j/lAcyhNcfc85KksUjMyOO3lJ1Ix2CZEv3syyvflqESWK9/eXLvHst3
	jc3ToY1xyX8x4Zd4hQ=
X-Received: by 2002:a17:902:e74b:b0:2b0:5b4e:370c with SMTP id d9443c01a7336-2b082793bb0mr24247525ad.32.1774001171860;
        Fri, 20 Mar 2026 03:06:11 -0700 (PDT)
Received: from DESKTOP-U69D987.localdomain (60-240-109-119.tpgi.com.au. [60.240.109.119])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08366c4f1sm17994645ad.59.2026.03.20.03.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 03:06:11 -0700 (PDT)
Date: Fri, 20 Mar 2026 21:06:03 +1100
From: Arien Judge <arien.judge@morsemicro.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Lachlan Hodges <lachlan.hodges@morsemicro.com>, 
	Dan Callaghan <dan.callaghan@morsemicro.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, ayman.grais@morsemicro.com, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH wireless-next 14/35] wifi: mm81x: add mac.c
Message-ID: <oip22c53ulpajci7obr4mqowqlnmdgicwiizzw4k2akl7d4cma@berjxsn26u5e>
References: <20260227041108.66508-1-lachlan.hodges@morsemicro.com>
 <20260227041108.66508-15-lachlan.hodges@morsemicro.com>
 <a04a91f1203609e89df97cc950bb2af37a66aee5.camel@sipsolutions.net>
 <vttdls7sm4h3br7y5kcea5i4teqnuiuzgq3miswg6r45asvng7@jto3tksuvofj>
 <1ca86ec4a1af1edfb791ca65023ab1979507c5bc.camel@sipsolutions.net>
 <zcuk2lw4crrx77pel7rjzy6g4dae77psra3sfiytto4ap3b2nt@io3xv6gob7dz>
 <888ab7ed9c72d19765e87f00b17dd95963cbca18.camel@sipsolutions.net>
 <x2c5mvplhtdfl7u2m54roosjtxjhzab2kq6tpqmehbmauiwvi2@gsktg3ztlhng>
 <7339202222542df9858308d3a42f438b4abf516d.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7339202222542df9858308d3a42f438b4abf516d.camel@sipsolutions.net>
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33587-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[morsemicro.com,kernel.org,gmail.com,google.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[morsemicro-com.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arien.judge@morsemicro.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.927];
	TAGGED_RCPT(0.00)[linux-wireless,lkml];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 797532D87B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Johannes,

> I'd still somewhat prefer to have the initial commit as a pull request,
> but if you really don't have a public git tree now you can also send a
> big single commit with all the right things to me in private, and then
> I'll put it somewhere and send it to the list. We can figure this out
> either way, no big deal.

We have a public git tree we can repurpose with a wireless-next branch for
a one off pull request at [1], but we're not yet committed to make this a 
T: entry at this time - processes are yet to be determined.

We will be sending a v2 as a patchset up shortly, in a per-file format 
addressing some fixes and dropping dt related code for now to reduce
review surface area. Once given the OK with those changes we can send a
PR.

[1] https://github.com/MorseMicro/linux

Cheers,
Arien

