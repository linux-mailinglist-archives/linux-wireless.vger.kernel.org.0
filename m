Return-Path: <linux-wireless+bounces-22108-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E7CA9E3BC
	for <lists+linux-wireless@lfdr.de>; Sun, 27 Apr 2025 17:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9730B3BF694
	for <lists+linux-wireless@lfdr.de>; Sun, 27 Apr 2025 15:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68AC6199E9A;
	Sun, 27 Apr 2025 15:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iekzx66J"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0918F4A;
	Sun, 27 Apr 2025 15:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745767543; cv=none; b=sVIqKp8F99KvvlrPpYxhcNuKvDJ50XrBv9Qo3NkxPvcgzJhH1F956EokJ00At2xtrsJX7IDU5riL/GK60YcvqmJh2XYZpiZhp0IASnCMkRFxDPuuyE1PFv+CA28wnqnB4HMUd179csBk3V8LWMkmjZaluOTVzTNpu9igPgGL1kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745767543; c=relaxed/simple;
	bh=dDM3xZQh/HEEZTN+srmzrk74t+843z+KTcKKgQBih4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=otlzPckDLLamuCYzDQLSl+4qGal02k9BX0u4suTAKHN4q92lMYT1fdGwdBKERGEYvK54NGUN0oWVbYeyBPqvwYRgXVVqq9cxQbuAkqcrPYbxCUeCBX26EuOQH0TjEnfshVlgAZCeqaNW/IbyyWEaAZz27owA7YZUHuJvnrqLNjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iekzx66J; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22928d629faso40985945ad.3;
        Sun, 27 Apr 2025 08:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745767540; x=1746372340; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=u/gZS038FMqma3eyZXWrsfA/OFWa0HKbwBHrRHNs90w=;
        b=Iekzx66JDXsOTRCa63ZVIS0NLLLED/HPS0JWUqBjCcTDOrn5H+OvkTznMPNJwNeetb
         jXmeUb+2yvqtwDya4tMVh6CL0zv7EN3/8MQGUE/EHgqEMbA39l5gOuM07SIzrKLrgJ/V
         KPuQbFgTL9LoRWpDKUMsSl0jlkTHFNbQHtrjC7Z8F92/P9ViJGSIk7abMbq5oaUe5Ken
         IVSB70JshcjQQGv9zCei0fE7vryj9k2ysEwTcAwfoY+3CSGSzL0QfyJrxOBdK/yfqMfc
         IbdOPUx0D35aE7aMZ/VXSKy+mKRIUiFVpAqlW5qmDcRfre1/1Xmv0uUdQf7X2WBLyRR0
         399w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745767540; x=1746372340;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u/gZS038FMqma3eyZXWrsfA/OFWa0HKbwBHrRHNs90w=;
        b=sa3YUsUGyJEROwFOr3glyai/JgOGITDJRhbAUQ0rzh/lgwzlnr5WqFovW4i/p8em4q
         kMLGRarUL9l6+IwahufVVJmHI+8Uw9F4/mpgrZ9SeN6ZhY24y2uXaaGCk+KvqwFGBGNf
         6fLCcYhmk15fUy0lgxxvZ1fiw6zli8e/X6EFO4uHiO9TjfV1ErnjYq81ecfMLQmfsGHR
         BzXkpTzFdhFqyv39dYXX+Zycx1u9c0I6sTziukyPFwI4Zz/CwQ3ySholSUHQ9HVbH0Iz
         PQtRreZB3lXjmDVxHO34ZiFVYu6HEZF/wjDMPuBdSq97owHgGN0LyXpEGxUp64VXTPE5
         Bqiw==
X-Forwarded-Encrypted: i=1; AJvYcCXefP2GDHYCPS4+DCw1kYBGrrppfAyK9p++m8ngjvRYveBnUSLyUcu6Q8w/fJJx9C/oFsN1XkMYl2NiO2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrUz0RQhdAoLcZO1In/R4JF8e5OpT8AK5LKwvA8BHFrXWDOSwG
	474MxcuwDGCAOWUa4pgzwtBpLlznHpWVKa19H/oAaoG4GgkjA02sSqUWsBdh
X-Gm-Gg: ASbGncs1ZoJZ6W/D7m2tkl5z/G8bHvjsittNTS6ti3Exdzru/kKEDqqBqr5IgF9HjUD
	ypZ9NzDA4q4Fc5aWeipxFlHmyaBsZ0OI5ROC0sNyRgx7+S1D28aKZTSSLSLCaGYBBuKMoIcW3YA
	JkMdfi3dTtGLmIXyiknXXDDLFtJGeOp0cml6gcv0H7QrvimVeoGdBN50mpX1481EcAEQoaVCg/w
	93Es0qlP4aSws/lQLwjlN1I1KseDdj2nNIZNGGKX1kX/DXHnR5eiCNHSkqK5Pd9atDL8zlcv7Pd
	jdqpigInf/M7iXp/fjeWJoL+mUtGaAF935adQEsJ
X-Google-Smtp-Source: AGHT+IEL1FGcoYUvOw05T4HuRQd+I8TcaIyUPzAn5BZ/Flj1zpQljkOrsRavU888oLN0DSx6vgrQDw==
X-Received: by 2002:a17:902:c94f:b0:223:33cb:335f with SMTP id d9443c01a7336-22dbf5d3142mr112394355ad.3.1745767539943;
        Sun, 27 Apr 2025 08:25:39 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4d76cfasm65403835ad.47.2025.04.27.08.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 08:25:39 -0700 (PDT)
Date: Sun, 27 Apr 2025 11:25:37 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Christian Lamparter <chunkeey@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: carl9170: micro-optimize carl9170_tx_shift_bm()
Message-ID: <aA5McagnQw49MElr@yury>
References: <20250326155200.39895-1-yury.norov@gmail.com>
 <CAAd0S9BDCqw9XZSe=r5fcJuncUagJoJJ0jOe3fB2=UkyXgjozQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAd0S9BDCqw9XZSe=r5fcJuncUagJoJJ0jOe3fB2=UkyXgjozQ@mail.gmail.com>

On Wed, Mar 26, 2025 at 09:00:33PM +0100, Christian Lamparter wrote:
> Hi,
> 
> On Wed, Mar 26, 2025 at 4:52 PM Yury Norov <yury.norov@gmail.com> wrote:
> >
> > The function calls bitmap_empty() just before find_first_bit(). Both
> > functions are O(N). Because find_first_bit() returns >= nbits in case of
> > empty bitmap, the bitmap_empty() test may be avoided.
> >
> 
> I looked up bitmap_empty():
> <https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/bitmap.h#n423>
> 
> apart from the small_const_nbits stuff (which carl9170 likely does not qualify
> for since from what I remember it's a 128bits bitmap) the function just does:
> 
> |   return find_first_bit(src, nbits) == nbits;
> 
> so yes, find_first_bit runs twice with same parameters... Unless the
> compiler is smart
> enough to detect this and (re-)use the intermediate result later. But
> I haven't check
> if this is the case with any current, old or future compilers. Has anyone?
> 
> Anyway, Sure.
> 
> > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> 
> Acked-by: Christian Lamparter <chunkeey@gmail.com>

Thanks, Chrustian. So, how is that supposed to be merged?
I can move it with bitmap-for-next, unless there's no better
branch.

Thanks,
Yury

