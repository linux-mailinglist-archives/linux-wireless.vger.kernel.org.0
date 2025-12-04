Return-Path: <linux-wireless+bounces-29487-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E4248CA2B8E
	for <lists+linux-wireless@lfdr.de>; Thu, 04 Dec 2025 09:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 56DA63007750
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Dec 2025 08:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A8731B131;
	Thu,  4 Dec 2025 08:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jkdW+wqi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139CE3195FB
	for <linux-wireless@vger.kernel.org>; Thu,  4 Dec 2025 08:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764835229; cv=none; b=CxM4gHJAy3tu3CVT/jiUPtiMgBJh1EKQZ+reUvU1J/VRl4HuFSHgJikEaw5WtiDY6g1CgiqOjhxxYV64c+eW8SvCss67gpO4eMzJ0Ihy+EDXIFOHIPO0q1UVhZb71OgWVEQGhtFt24SmuayaKCUigFDwJwlLKM6SNY4wEKhCosA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764835229; c=relaxed/simple;
	bh=mpXehTimxHuWE6mnLV4ozTZQoHXKjbajrye4tph+rFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bmcY/FcZndNODdHdig2Bl4MJIMNhqHFVYm3cWyanGT6/izWw0M0VMgbogPKHE2rm9+LAV3rH1sfyyUNBXFnM2DH2QMKVa6oByh98ZDWMED+p9YxRmvh+hgjpLqOyg71KcPoz4IvLj867I78R0bkIEj4Td23zvEr7Ro5LTsrzfJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jkdW+wqi; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47795f6f5c0so3883935e9.1
        for <linux-wireless@vger.kernel.org>; Thu, 04 Dec 2025 00:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764835214; x=1765440014; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6QEa29b69GI0rC02Aibnushx1/FXePKSOU65F2tmdXo=;
        b=jkdW+wqijDvQqXLEQBBnu7maV3vpgMya06CWTb9+JL8j7WGZ/KnDsx+Y7XqrJZldUH
         iLiAVBgHzS5vhEPbX3qtQ9So69FWdQQ5ZNEIWX5XF64/SRD9v18rGsTLsDEjrctH71PP
         nk+Q+a/xRL2TLfpn4br4sAv1UERU2QhLa1MCcCPANYNUF8AWtJxsnmwitYdqbRMaJYq2
         3zoidnLxc9l3a5QibWpvOzTOqkehg6GeXLcCjJqJxcu73qaNjvNHAl9r43Oa0H4qEay/
         l/+6C1hAspMnM9PwyYqZhhEyhrcHXfZQx68iPkOpVQ+G3N439+VhkDheAnbPr8n+KF0+
         xB8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764835215; x=1765440015;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6QEa29b69GI0rC02Aibnushx1/FXePKSOU65F2tmdXo=;
        b=YKXQfYvhDgGBxQQwz1qCPXbmLfP9j8dlwo9DfXxdDPlvfgefSQCZNDGP3kqvL7/7LQ
         5xstZ79vMqfoSvxwfsyqjZ3exl8sGGmT+paLB7ffobEs6e7qEd7+0azJn7bcBFZJO0pR
         qv/edrbXCwKMwm4rIi1jcGBufRwzqnkqRPCNDicgM/70bRApdd6qEy/W0wGQD2McvaNY
         U8QpbYgy7Ors2jLJK4HqLWbmfaMMpDcGabreSiLFSz/saBZrwKHb4axRh8QQ/IX18h4e
         u4whbDCMbX4XNkFCjAJ6pGRe9d/1w0Z0GzyDk4iRfvszmIR3xdDrsTLM+bUl0tQ6krIu
         JQZg==
X-Forwarded-Encrypted: i=1; AJvYcCXwk64H6HGerlopnJRrrL67bFDCYJmyUYoqb53o5Dyly9I9ETc8bRH/BFPnUU9+/Zgu4kg71cY6aOXRfu8V8A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqgg4gt0U0ci/vkl25unmi2Xgc16U/HPsZaM0BtjK1dWk/Syda
	MpCv5WpPLIXPFJpBA4gE8QJZ0z25bunzfP6Zmncy/NF5A3ZD5xPT7IGlb9NQIj0wjeI=
X-Gm-Gg: ASbGncv3HEYIuA5w/y3vkqvHpWumB7qfS+gRusvZWPYyF3EbpJYiz2s/ddXEdrJ3RqF
	s1hPt7IQCb7XJn2hAb3krp5pBAu0fawTQIr1+wBziOwWkV0kMThQ5mivDbIP6BT8jZuszMiZ22k
	e0uG9SOqa2QiwwImBHPQpeYgHgfHrD1B1G4vyX7ARs7SRJFBi6vrFnLpTBtCeC95sx+ZDlk2664
	MEnbXO7VECcDccWM4FNBoa/p2G+tHbA7XblOx7/7Xqcq673uvXFicxz7KksGYtD2krtEXEkiy03
	W0HPQSVY6b6ptzZ2e9cfThm9qU9TeHdHkkjoXv+nb9NwBa05CYqSqXdbjqzwvkDXjg0tO9rp7iP
	bnQgbZbAwYe9txLSPD07dR9C7pe3gQIwBdR1cn9Wu1bR0dXOV+EO0qWhv2mLFX2KwF3EzFUmDoI
	jAofO8JZ2y7OF4Q2BI
X-Google-Smtp-Source: AGHT+IGx5G8xtyphAgFt4tRJbC9NrnKU8miK7j8D7kDLQyGFN6stlYrbqZkU/BhypULqvMfdR89/XQ==
X-Received: by 2002:a05:600c:4fc5:b0:477:a977:b8c5 with SMTP id 5b1f17b1804b1-4792af505ffmr62760335e9.31.1764835214446;
        Thu, 04 Dec 2025 00:00:14 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-42f7cbe9065sm1740877f8f.8.2025.12.04.00.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 00:00:13 -0800 (PST)
Date: Thu, 4 Dec 2025 11:00:10 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Rolf Reintjes <rolf.reintjes@web.de>
Cc: qgeniecore@qualcomm.com, Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] wifi: cfg80211: sme: store capped length in
 __cfg80211_connect_result()
Message-ID: <aTE_iu1lAA7ww4g0@stanley.mountain>
References: <aTAbp5RleyH_lnZE@stanley.mountain>
 <3204ebc0-4432-467c-81fe-9f09427b1671@web.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3204ebc0-4432-467c-81fe-9f09427b1671@web.de>

On Wed, Dec 03, 2025 at 06:57:42PM +0100, Rolf Reintjes wrote:
> Hello Dan,
> 
> Am 03.12.2025 um 12:14 schrieb Dan Carpenter:
> > The QGenie AI code review tool
> 
> Could you tell us more about this tool? Is there a web page of this tool,
> how do you use this tool?
> 
> I found https://qgenie.ai/ but this is not a code review tool.
> 

No idea.  To be honest, I think it CC'd me by mistake.

regards,
dan carpenter


