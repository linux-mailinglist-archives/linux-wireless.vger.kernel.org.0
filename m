Return-Path: <linux-wireless+bounces-29920-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59713CCEDF9
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 09:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2FAE33013737
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 08:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EEEC25A2DE;
	Fri, 19 Dec 2025 08:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iLmpEgbr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615E6261B9B
	for <linux-wireless@vger.kernel.org>; Fri, 19 Dec 2025 08:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766131411; cv=none; b=oDhjHMdt36G1uqNzcXaouBxQ/TXAgbEd24mGI1lSJ7K3vOCM3RaoyOX28kIowYBrYJwG0LHu6zE+baAy93Q43867gFZKMvOu9O8CxEMRzBcLSyK71jWuAk6eQcrUCTU5jSqvw1wR77Pr1Ydh+KW2SJoqRvh4HVlKlBgzo9cQQFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766131411; c=relaxed/simple;
	bh=/bGIY46cuc38cb1abi/sHCeSyn+CEKg0h0yfcmVi7wM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PmrZhZxTT6Ixb349cCZzMKB7j6WuT09Xdj5/5d89h9CT3JPlvBbbYXn+x2eCD1EkPVxJ1oQnNgu8JFN1Yq82k2FQUtQOL4Lrzp2NCJC/XvNLVLd1bo9atTUknmP9YuqJKe1e1CLyD7VAwHmhB8628y/estJxByimS8+yGl7uP+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iLmpEgbr; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42fbc305552so1079573f8f.0
        for <linux-wireless@vger.kernel.org>; Fri, 19 Dec 2025 00:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1766131408; x=1766736208; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J+/ZRMSQfz2Pe5W3+kCSEEPyZ++ydw0qjFUACnxc7Hc=;
        b=iLmpEgbrNkqpJeLCyEr9TjVU+3Jd3Tf/BfK6tpxbTLl0EFjGPuuIFWWF4DM8I209KD
         Y36n73zfJ2AcLx7QWIqk0y2EQh70ls8vhkZJiecwfTON/TwATsW/x6B75KKUl4ojMwnD
         JwEqH1HkDuYf5RhndIQTQ2yyVBdt6SxnGpxZHnNJBIMFjfl4eXNggDN+hjZ1kVN0YuwA
         8u37BLy1JNLPQ5MLFNT5rYS+cTjbq6wM2KSTy2YK1a0AWi1EP6imoZTLNCj+6imfImaX
         FtzE9SRZl1MabzIX+jIJr0Yt/sUJYbX84TR3fKb4MvqcHI+cJil0CN+1U1YmmrlqLtJZ
         z48A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766131408; x=1766736208;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J+/ZRMSQfz2Pe5W3+kCSEEPyZ++ydw0qjFUACnxc7Hc=;
        b=MxxwLNiMJXbAJ85z81XcDOTxf4F4ADX51hZZoVw6/GraxxCEJ+d2xBXX9rl8bldGw3
         rLt9nqL84Yqa/ihni1sHEPwEt4xOy92Bz5dnY1qzvPnpO144w+w42626Fg5wGV9jYEfQ
         jGkqkJOm3WQiR62OfvybJ+BH1N0SqBLE/42QFfb86GJn/noFCSxY0ozOi1apcvOF67MJ
         K1QYwod4FDcIk6JYgr1J4irqB2YhvUcxkPfk3fqACnYuepyHZ/BrALZfva9R5DBGDnif
         wiVyI8shAFbpGgrLdD9t/O/0mr9qUaBK/nMQgETiSmVfRV638GnJBpm4nbOU27KLqFpN
         KRcw==
X-Forwarded-Encrypted: i=1; AJvYcCXJSJByI277QsRMoPY6WwSfTZcEEdOURsA1W5WCe5YWDsluSgbLDi1BzwO/8tbwlXa3I3Q5EKP2prmtemIVrg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1QTcEgijoNPRaVENLRcp0q9I8EHMMGLvk75btqe6JExn2d6R3
	R+psv0ep6M+/s5Y/iTmjorFrILHgvYejifHEpUnkTlrEIkiIRIrmcRlimM7HnvJkfw8=
X-Gm-Gg: AY/fxX5DOPbd+XWhwa//6Yl2VHdbfweBkpOlykrI8LN1Nzd7A+teSkAsu3rtAA04Pge
	SyiC3vt3mX8D0yoKBGZS5qHZGLeDGkxy+R1sT4OIHJNeZP85MNGcArJrC1bcCERNgxYngmZM9NF
	53gnwRYhR7PUjRvEAKPmqsUE9RI1I7MfFKI8GTFLHC4Bla9OwVMvPZkpdD+jw2Kmp7o9Ih6QtnA
	1nh71PpSjKJoZtWvKzteStrvo6LJkpBU5Y2mRpnY8UFqTPSSLL+z//q+Rlshb7PRU1/XKjzpn6W
	WIpdeYx1S8qA7nMhlQNBrOqWdbVbsC+V8dPw994QTYdsVC+P247FS1j3ef2hC1QvtlTbkurT/6q
	BOWOxXXKzit6xdt5S5Nx+Ao6am4bXm89R9wBrarpbA8b40d9eXQm7hKpX00/TB4DQ6KkdJcYxVU
	+xaQXYadskn6oLb6c7
X-Google-Smtp-Source: AGHT+IF2eEWgioDzK9v88hc7zvDgUmt9tMsxScJV1o/NErRD5qEO8zTzXYks9Hy32CtcRV+DzuDAtw==
X-Received: by 2002:a05:6000:2303:b0:431:342:ad42 with SMTP id ffacd0b85a97d-4324e50d6d7mr2001778f8f.44.1766131407550;
        Fri, 19 Dec 2025 00:03:27 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea1af2bsm3644036f8f.1.2025.12.19.00.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 00:03:27 -0800 (PST)
Date: Fri, 19 Dec 2025 11:03:24 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Cc: Harsh Kumar Bijlani <quic_hbijlani@quicinc.com>,
	Jeff Johnson <jjohnson@kernel.org>,
	Ripan Deuri <quic_rdeuri@quicinc.com>,
	Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
	linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] wifi: ath12k: clean up on error in ath12k_dp_setup()
Message-ID: <aUUGzCA-M-D3VFj9@stanley.mountain>
References: <aUOw1J0TU4VgeXj6@stanley.mountain>
 <1fa108fc-a06d-a9cf-a56a-c905e4982b41@oss.qualcomm.com>
 <aUT8KrV36wF8ITIK@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUT8KrV36wF8ITIK@stanley.mountain>

On Fri, Dec 19, 2025 at 10:18:02AM +0300, Dan Carpenter wrote:
> On Fri, Dec 19, 2025 at 10:54:03AM +0530, Vasanthakumar Thiagarajan wrote:
> > 
> > 
> > On 12/18/2025 1:14 PM, Dan Carpenter wrote:
> > > Destroy the rhash_tbl before returning the error code.
> > > 
> > > Fixes: a88cf5f71adf ("wifi: ath12k: Add hash table for ath12k_dp_link_peer")
> > > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > 
> > nit: The next branch in ath is actually ath-next.
> 
> I'm working with over 400 different branches, right?  I can't keep track
> of them all so I just put "next" if it's in linux-next and leave it
> blanke if it's in Linus's tree.  It's automated.

For automated QC, it's really easy to automate on the recieving side.
In some ways, since there is only one place which recieves code and
does QC and a hundred different people sending patches, then it makes
more sense to do it on the recieving side.

This rule started with Dave Miller.  He was handling a hundred patches
a day.  Everything in networking except for wireless.  Also Sparc and
ata.  This was before I invented the Fixes tag, so that wasn't an
option.  Greg and Andrew still handle that level of traffic but they
just use Fixes tags to automate their process.

regards,
dan carpenter


