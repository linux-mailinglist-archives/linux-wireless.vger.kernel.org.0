Return-Path: <linux-wireless+bounces-23186-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4146EABE0BF
	for <lists+linux-wireless@lfdr.de>; Tue, 20 May 2025 18:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A31AB1BA2AEF
	for <lists+linux-wireless@lfdr.de>; Tue, 20 May 2025 16:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6CC25228B;
	Tue, 20 May 2025 16:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9CQM3kU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7DF24C07A;
	Tue, 20 May 2025 16:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747758763; cv=none; b=sKzmvjgOrW9ACngtwxkdDQX0R+HRaNN7MirG4aSMqNKuKyHTIK5HkpygN7HfGTnWdJ3xlN2CmQZyYJa4VEGlnbWqiFYNHC8sI7Q6E3kqyqQ0eZAqqLjJLxkzSly2KtwF7JIHmmcqDGvb99vRBu4XQxBg46PvN5KrBKfOds37n1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747758763; c=relaxed/simple;
	bh=VxL65GSY3jg0UxcejEQeHBF4bpS7AbjITpw7p8xiujU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iY/jn1kO0yl/4XarLmh2ukpy0TrmIRlW8YSDCRosCcRdpUBgt4p4KB1GbG3lfno1EDILg/cbo5Czp9IjQDdr2W0prp+NfauptSpj+YmVsUilMNNO6zb/0mHDZzLKo5lKQcaMOwyiR/OPU48rSmb8sULt6D8LRONKQieM5cTEaII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f9CQM3kU; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-231d4679580so39222415ad.1;
        Tue, 20 May 2025 09:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747758761; x=1748363561; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JfechbBoXh5EUb1CnvnuWI7jG3482+KAnoqrpf/01NM=;
        b=f9CQM3kUwVxNL1DrFEAbLvoPYVOB73Dwd3aR3Lq4ti61JPesesdyeKdEr9LIe/mtAf
         NhFZW869r4FXGBEiwVQFBIJ6AgQvfWwuvav8ERlm8QR6B1R2sexf0w/bAJv0FIgrzZna
         ZWCcMcH3Ya80WPbHnyKjNKKsggn7hlhIIyD6U2mqofKgE4c5mCNH89CHDp0kP6miV5Xd
         pvmv2zsI58/ucqa4PRJZCPBiobSgHpX/Lxr/aoCMijKEIyfs8Cq0H2V4M8m4Gor56uCR
         wP8cDadlRompDYc0FCif+MIT19xIVMALtrgNzA+j3alAA0gTUITkkOj72FRNGIaXIXST
         hqhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747758761; x=1748363561;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JfechbBoXh5EUb1CnvnuWI7jG3482+KAnoqrpf/01NM=;
        b=FtodKL7sru+U6sImu/rXRQaOIyVgQAPWYUqpmG4lnk20Zi0RGnon6DV67EFl1ZI7LZ
         7z6pEXWnwygilT21g7lyazljWzGMXnUo/j9Tc5HvsOl23NFFN9j7M0LO0ZQc8KRf8GwQ
         SH0s7xx9SyjHfSn5qwJ7GV490yRuch5L2YRJvQgGkX/YDgAFSKW62oK+oDuffC6zqjXD
         bUVTk6GrXygyx8JZogxJ/vdOyuxdORef2z8JFuG1AmdEpEmnMBYYKlMDNePSXodxlT6g
         /BfpqjMYecEnHPzGo+UYWbGDMDnGb1Dmv0bfoPHM7zSEcEOhsaYJmabkYduwC11e5UNt
         OFnw==
X-Forwarded-Encrypted: i=1; AJvYcCUkRzj5UAtiBrZD0UgD9tGbdXxCT1TeUeDUVNDSwCoY9yyOPpDz3+PnMFwrITFENhO63amHykD32rEm0VE=@vger.kernel.org, AJvYcCXdlZHrW/xjycvGZoEkQUN7lgNwfUV1wuPUTXTODqPVC6wVcB9pQDG5u3ao5qRzUngqmJ3q5rOvLMtw3ArsCKI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxalfDK6huSfMBz+jlVP25cJondBvWAsVhlU3+sI2QYB4Pz3eTC
	3Nqr9LO5lRtMreQZ6+uyH6IqDb49IOozeV8ATgLsNFhFnOCV1T2AucWWcH5xtg==
X-Gm-Gg: ASbGncu4NP7A3sIDr03UEN2iwb9j1K7tTH6LrLiQQ7+I++rb6GinsnvdpaHpv6GkBTP
	ScekCBhfft2xNdceXO+8yAgn5ZULRNA4qvYnpGVZSe2fqVR5NOO92iqULiCiRpZ65ZFxjx5DcLw
	Fcnmjam0ZWcMoFNHNROmlnE6cw+roLDObk4vulrr3XatRjJYKn+mHGSMfO0fpktbBsO/+mNck63
	lVjip/YN+81d91LvCIAuzbPDaTPc3B3CJlPvzInpvcBRhWmsDYuZg5MpWN2wAP7VV12LBKXmt+F
	FJGI5y03C8Hi4OEOc5vPd3HLZld7RV+NSJCeug6obb7BjCt4QpM=
X-Google-Smtp-Source: AGHT+IG2s3iNB/QZDUNIt9beVD907qupAKc92c9ZClxDz8HYPKBX6cGcKZgHh8UEcx4pM/i/DPC5sg==
X-Received: by 2002:a17:902:e5d1:b0:223:54aa:6d15 with SMTP id d9443c01a7336-231d44e4599mr265064745ad.12.1747758761099;
        Tue, 20 May 2025 09:32:41 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4ebaa21sm78890125ad.162.2025.05.20.09.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 09:32:40 -0700 (PDT)
Date: Tue, 20 May 2025 12:32:38 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: Christian Lamparter <chunkeey@gmail.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: carl9170: micro-optimize carl9170_tx_shift_bm()
Message-ID: <aCyupkU1tK-bUlZV@yury>
References: <20250326155200.39895-1-yury.norov@gmail.com>
 <CAAd0S9BDCqw9XZSe=r5fcJuncUagJoJJ0jOe3fB2=UkyXgjozQ@mail.gmail.com>
 <aA5McagnQw49MElr@yury>
 <54f50afa-3267-4829-8be6-1542c3fef606@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <54f50afa-3267-4829-8be6-1542c3fef606@oss.qualcomm.com>

On Tue, May 20, 2025 at 09:24:14AM -0700, Jeff Johnson wrote:
> On 4/27/2025 8:25 AM, Yury Norov wrote:
> > On Wed, Mar 26, 2025 at 09:00:33PM +0100, Christian Lamparter wrote:
> >> Hi,
> >>
> >> On Wed, Mar 26, 2025 at 4:52 PM Yury Norov <yury.norov@gmail.com> wrote:
> >>>
> >>> The function calls bitmap_empty() just before find_first_bit(). Both
> >>> functions are O(N). Because find_first_bit() returns >= nbits in case of
> >>> empty bitmap, the bitmap_empty() test may be avoided.
> >>>
> >>
> >> I looked up bitmap_empty():
> >> <https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/bitmap.h#n423>
> >>
> >> apart from the small_const_nbits stuff (which carl9170 likely does not qualify
> >> for since from what I remember it's a 128bits bitmap) the function just does:
> >>
> >> |   return find_first_bit(src, nbits) == nbits;
> >>
> >> so yes, find_first_bit runs twice with same parameters... Unless the
> >> compiler is smart
> >> enough to detect this and (re-)use the intermediate result later. But
> >> I haven't check
> >> if this is the case with any current, old or future compilers. Has anyone?
> >>
> >> Anyway, Sure.
> >>
> >>> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> >>
> >> Acked-by: Christian Lamparter <chunkeey@gmail.com>
> > 
> > Thanks, Chrustian. So, how is that supposed to be merged?
> > I can move it with bitmap-for-next, unless there's no better
> > branch.
> > 
> > Thanks,
> > Yury
> > 
> 
> Yury, did you take this?
> If not, I'll take it through the ath tree.

No. Please take with ath.

