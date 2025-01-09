Return-Path: <linux-wireless+bounces-17250-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8451A07D8C
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 17:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFB3C1691A0
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 16:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0511621B18C;
	Thu,  9 Jan 2025 16:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mWpsZD7N"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3875421B192
	for <linux-wireless@vger.kernel.org>; Thu,  9 Jan 2025 16:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736440263; cv=none; b=Kf3FH7m/IyL94rB11exeA95vTc6G0DAuAuWFPb/JvK8JQubBp5A+bzUTuuhscoQlEkO4XIWC4JjaffgB2fo6XHZhZ7W2W2gCmSULZbFH7GzVocrmnXWUBxJqezzgxyz0LCAmgXzhaAR3gz5rCnTKOkkamyoR/pc6i9wUGHTgksQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736440263; c=relaxed/simple;
	bh=oRnYeIOnuWC95SmBfEcCp3VRJBQGt9FCRwhkajjQKxQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=nDD0Tl2br+6s9yIqcIczxf1SXwW0qE7ZPw08/ZfXlSAVuI7VL507rzCMkCy4zagYOaM+ff/nAspA5Q/0EqN4uCnt+F63D+Bxz3kH1j4Qx2GrbiD/WAWTYkxidDtH5fx/kREDbJnscEceJk8Z0IFru3isZDfMDIygHkGOR80fkow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mWpsZD7N; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43624b2d453so12645375e9.2
        for <linux-wireless@vger.kernel.org>; Thu, 09 Jan 2025 08:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736440260; x=1737045060; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oRnYeIOnuWC95SmBfEcCp3VRJBQGt9FCRwhkajjQKxQ=;
        b=mWpsZD7NPtJSKBrMWQkaZI2g8sNfzZgXbZo9fXZ3+SwWSRwzATYP1nt6Y0gLViwGBT
         JmuU1iCcW1PXyzb7dHh9zbhvJK+XRglxnw2l+nHOv5Y0c9i2GhhI9aJsyusRgRjuYRVC
         JmDtX7IvvplmGMPTbmizsJgd5tGqATDESn/KyGf5ILunEraNVh+BJj0YAbAQlX9WrFFh
         DUNkgwdMRVCz0wJHpNgky5BTq/d3P7+unJ2I1W5LiIbJWA6ya5gJgSu5PWxLu7tj4ol6
         /fWS6cflWePfUrxarUqRECo4Jdf6OVXQP4pgRh7QaKzpYepIu+JqGw/EZzHmf/cpH3qe
         7YvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736440260; x=1737045060;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oRnYeIOnuWC95SmBfEcCp3VRJBQGt9FCRwhkajjQKxQ=;
        b=onXcGNj2Wb5D685ZgsIJTEIYLjYpWFf93Q0P1JYHSQkuxfomDLQTxE72tQThh2e7Ie
         KYLXxVnnNmy4Ek5KfCP0PzhIgwfs7PRucZ1jxhJf6cSoYs0tUtCFvcQPbBujDT8uhtkT
         1dB7MFMXm+PHWpccEmcJBP1d1GjmcE88nWSfeDawrErPgW2WyMm4QLe7o1HUAIPjE/yh
         ipnnRPSvV3fLNfswac7gk5Bzj0fdF6xItlD9iSo6HfqqVQymDLsKEktzBh+mr3GXqmj/
         1ZM95EXTSB6P7IMKRqW7WjW110e+R+n7gRlh1uBAnpVvo4gQPC240pEourR+H2/h8k3a
         lbfw==
X-Forwarded-Encrypted: i=1; AJvYcCWXfFOKgUFUN0owjzNjPSoi9YYrpkJ+1U4MKDR5hfFkNs+cwS5wW8as4rJmcYaiDAgzgbPUlD+Zk2UJ5IsmfA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwuEduYQIc7cxMeIgEY7DfStECjviR3QbJ0co7FObrWdLSGr4U6
	uSmOaI8rRY/ZvdpFuNC6EuE+8Cc8XbDW+UXvhPkfw6tKLqmbyigCUtCiwA==
X-Gm-Gg: ASbGncsJXhI+bXCZfXd+ksloUmimgwJN57Z1axZpzoTN8jLSPg1m56jWZSUzTe21mu5
	64eDu5a6mJEDSDLpQ+nCS/LS1ZZq42zgEmgKAebW4KjWGmITQPruaJq/tTmF4YwReTKIBYMwM5P
	HOw6N/0mmxGOaYblab1i5vhTMh8xx7QzIUqCmdSLbNbPdfW89ybqmAQULre6ar3iElWhwVg9P8K
	UTZwW6kI6S3BgIHaP6jQxHntac+uvsw8/XTle7xBwNJpPgCCEYG6xWMGxtcmBRWfGeEzog5Gp0=
X-Google-Smtp-Source: AGHT+IHWfQFGsjf4+Y+aFqbNEF+ExZXERgNKPIjkUWTWO20jHQ2IDfvj88w08hTEa83JRpGzFJXLzQ==
X-Received: by 2002:a05:600c:314e:b0:434:f5c0:329f with SMTP id 5b1f17b1804b1-436e2697947mr78812065e9.14.1736440260337;
        Thu, 09 Jan 2025 08:31:00 -0800 (PST)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e9dc860bsm26105725e9.9.2025.01.09.08.30.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2025 08:30:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 09 Jan 2025 17:30:59 +0100
Message-Id: <D6XOP6P8Z4J9.1ZIE5L6I8DSRQ@gmail.com>
Cc: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>, "Steffen
 Moser" <lists@steffen-moser.de>
Subject: Re: Potential Broadcast Issues After GTK Key Exchange on ath11k
 with IPQ8072A (QCN5024/QCN5054)
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Kalle Valo" <kvalo@kernel.org>, <quic_ramess@quicinc.com>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <c6366409-9928-4dd7-bf7b-ba7fcf20eabf@steffen-moser.de>
 <Z2Q9POuV-6MIdzRf@pilgrim>
 <b18ede18-0c33-4d14-a7c5-0066cbec39c9@steffen-moser.de>
 <D6VX7M6MGZQB.3LU3FBYJK6CZH@gmail.com> <878qrkdsr7.fsf@kernel.org>
In-Reply-To: <878qrkdsr7.fsf@kernel.org>

On Thu Jan 9, 2025 at 2:25 PM CET, Kalle Valo wrote:
[...]
>
> Good question, I don't have an answer to that. Could someone (also
> outside of Qualcomm) send a proper patch ASAP so that we can solve this?
> And it's good ot include the link to this discussion and describe the
> symptoms the revert is fixing.
>
> This is the patch in question:
>
> https://git.codelinaro.org/clo/qsdk/oss/system/feeds/wlan-open/-/blob/win=
.wlan_host_opensource.3.0.r24/patches/ath11k/350-ath11k-Revert-clear-the-ke=
ys-properly-when-DISABLE_K.patch

I'm not so sure as how to proceed to post a patch from someone else while
editing the commit message to add more info...
Rameshkumar Sundaram is surely the best person to do it, no ?=20

Thanks

