Return-Path: <linux-wireless+bounces-15424-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE059D074F
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2024 01:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AFC41F21735
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2024 00:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3913B7483;
	Mon, 18 Nov 2024 00:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QO1adpD3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C189610D;
	Mon, 18 Nov 2024 00:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731891068; cv=none; b=FQo0kee7A57rxivtYRAO++BH6wwOsXdVOzxzMu/N6sdV5eMrFbviYXsDXIdRVaTQtVQuCLNADW2BEH7vMdVqx4J/Ur0mN1w3G33uf+Ouhgy1Sbrpq4fQ1dLd2FmWNZ76JAKsMNh+s9F7R2tAzvIivIz8cieMD15GiNUkZCORWXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731891068; c=relaxed/simple;
	bh=gRfPS2fC3FpKaUHwr0q3NS+21KLRBFX5lozTsyknUBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hw+3y+EiHv4/AB9p6ofublKSRziERxPaKV2aNHz7Va70mIETPzYHHn90zTg4bq89Z42NOi+fJMsTSi8wOEF9UgJftpDxOeWnjJ28Xz+kX5IF+ySdMAc96r5VAewRI6HQ18Gw2DlaCZB6XDdZYXE11g6w/uR/X3uEbTk85gI17F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QO1adpD3; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4316a44d1bbso20408725e9.3;
        Sun, 17 Nov 2024 16:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731891064; x=1732495864; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G5OQZ+l9iJdKWwxA6WTwfv2vxQ6XtYMiuqoHYPo5RXc=;
        b=QO1adpD3W+NiYL3LUFJ7JsiAQ/+YaNFYAT6FNB9xwDFw7/7DABnDIduRfFVX+MtdgB
         3AH5+/CWljUxNSakLeNJwNxQ8Z96WeaDXu0Zg/HLKIkFt8Qk0MFHLMNeP1aW3J8vG8KK
         ByZHHryri0Yx+XENhUXrb/ngq5eap4ap4HGL1EJBXuKdlKueaHGX+Vl4YGNTL96pEDLJ
         uDzcRHfC/LXGU+p1oWlFsl9KYranIjx7pp9M5BZ6Z6WnH/h++Y0xwrTWA484scKIaci5
         G2if/XaDSwvBMsc57HBve9zoIku9cKaHpYUtoB0O/Jx/Mh4mZDuH9tIFtIUZJsQqLvYJ
         bhcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731891064; x=1732495864;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G5OQZ+l9iJdKWwxA6WTwfv2vxQ6XtYMiuqoHYPo5RXc=;
        b=StvIAmVxeDTJeHiULP62T7gNe8B8qqOoqQHsYclnYqEQjjQqGa2L2mge0wqWn+sli6
         eebqshk9mN5IFa5K1fvShRnp+oP+q4Qj3Ey0Ed7ilomtBlzW/kyzJdLUKbRHxlddf03N
         f4gm6LSPjHZQOuVLw9LNWdFNchIAGEBmF99DNfCUp320SdjoxQFeUHHRjvwLFMCLVAmP
         DpGjWxABkkcJruMRkHbODoTy8jbpdbWeGg9E7kMbxmteRp54rEyIA7w3idf5pBGx+Ag0
         X4YFBeU/k/E1YrtZlLqXBvkYXt2beH+YksImgSqjVzNuvuhzyVfcuf2yCzYoleKOKJX9
         XXDg==
X-Forwarded-Encrypted: i=1; AJvYcCU1KICUC7bjxGPTltMLcjEB5PkkpfXMBwOMaLBfev7YlKqT/r3gD9N+SIsCTKuOB/HO8tt6Srg3KEb3/RGLRA==@vger.kernel.org, AJvYcCWZyMI7Z/lhMQqanTSBI279XHQ8qpfk7h+oEUi5yMgyFtXkWHDkzQFQUgferFZec1rQyuPKhqXLdX4AxQoES6h3@vger.kernel.org
X-Gm-Message-State: AOJu0Yymy783hMX7iTFCOPyPhgfN/vFN9AjLYOWzQCDrC86bKsgJThYY
	Oc7dM0E9lHYzJb9WN2Y6urAtUgpRpowmGMBD5UBibOGqEEhY5zox
X-Google-Smtp-Source: AGHT+IHLISc727Ye5cl1x4+qPCaEeTksNA8IBK/zuzu7E/FlX0dK/Ylqsb6BswIzwlMOneUusyteCQ==
X-Received: by 2002:a05:600c:4693:b0:431:55af:a22f with SMTP id 5b1f17b1804b1-432df72c9e7mr91430075e9.13.1731891064366;
        Sun, 17 Nov 2024 16:51:04 -0800 (PST)
Received: from [192.168.0.2] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da265668sm137741345e9.10.2024.11.17.16.51.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Nov 2024 16:51:03 -0800 (PST)
Message-ID: <3b44c07e-1e1a-40de-8e99-56e16c6345b5@gmail.com>
Date: Mon, 18 Nov 2024 02:51:37 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: reformat kdoc return statements
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 pablo@netfilter.org, linux@armlinux.org.uk, richardcochran@gmail.com,
 johannes@sipsolutions.net, loic.poulain@linaro.org, dsahern@kernel.org,
 wintera@linux.ibm.com, hawk@kernel.org, ilias.apalodimas@linaro.org,
 jhs@mojatatu.com, jiri@resnulli.us, ecree.xilinx@gmail.com,
 przemyslaw.kitszel@intel.com, netfilter-devel@vger.kernel.org,
 linux-wireless@vger.kernel.org
References: <20241115163612.904906-1-kuba@kernel.org>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <20241115163612.904906-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.11.2024 18:36, Jakub Kicinski wrote:
> kernel-doc -Wall warns about missing Return: statement for non-void
> functions. We have a number of kdocs in our headers which are missing
> the colon, IOW they use
>   * Return some value
> or
>   * Returns some value
> 
> Having the colon makes some sense, it should help kdoc parser avoid
> false positives. So add them. This is mostly done with a sed script,
> and removing the unnecessary cases (mostly the comments which aren't
> kdoc).
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> LMK if I should have split this into smaller chunks, I don't really
> expect much review here, TBH.
> ---
> CC: pablo@netfilter.org
> CC: linux@armlinux.org.uk
> CC: richardcochran@gmail.com
> CC: johannes@sipsolutions.net
> CC: loic.poulain@linaro.org
> CC: ryazanov.s.a@gmail.com

For the WWAN part:

Acked-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>

