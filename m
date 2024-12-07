Return-Path: <linux-wireless+bounces-15993-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5A49E7E77
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Dec 2024 07:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 741802829FB
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Dec 2024 06:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F153B2BB;
	Sat,  7 Dec 2024 06:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J9yVFbkD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7D44A24;
	Sat,  7 Dec 2024 06:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733551834; cv=none; b=PBQegcsOgrPa0mtstz68d/8y63h3JzzmFhiwfVv2AP1Rq2dU0/sccq+yL1epA/Ge5LLdrN+WTaVWcJJUTUfOIMXKiqGjZcegos6D6a1GMrBdhuLj9kwbNEG9wy/Eukt0nup80jg+0jpb9qJF8wn2AE1DqxnSA6OfuVTIGO3AGrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733551834; c=relaxed/simple;
	bh=kXYaZ+2jouzdwILnxpbIaH5aUqP2Lsoho/tigW+6kRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D5LW4dfHAq4uIXxRcPb/JwnD8DYmdwUEm2cklLCFTpF/BCXXBg/qT5CQlBuaXYnd6sK8qE0rHvufan5fJ9bZbuQyCa+0Oy0W9+iVanAgHDgEQUlCvG8C/b74Ff9mpt1adcMiP9B8xpAz7PzgeI47rjyNVD7iQeb+DmHvsqiAkOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J9yVFbkD; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7258ed68cedso2779906b3a.1;
        Fri, 06 Dec 2024 22:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733551832; x=1734156632; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WS302FzxsUMqz5/SIjq4Dq3KB8bC9DgL1kzTjInTQxU=;
        b=J9yVFbkDJ6/tIF4hvP7SghuVLxtSehwTHKiQ7HJNiLZMEqlHKf73I2/8tnGAUlD070
         2pcWb00kFCaBM0YJT6I5Dy2036gV7W0fC20V4nxsSdP3SGEP53eSu8YJaTq112l+hb5X
         xRPaf64bJp1YJhq8tp1oYrdivTyniauVl1tqUkWMejlOykyIggnfi8RdYpXv09v5R0zr
         RLPW3W4BDGGKdUByrhweIT/bVuNsbvDs3XzKpOAFzem6XzWg0VRs0zuEKZZhI8WkpkVf
         7ODHp0dPhnwDofcDlSF+vhpYW5eWJKpGv8cq1aDNAQNUeazWCMxqo3oQTOk1YU50LdR3
         aFzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733551832; x=1734156632;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WS302FzxsUMqz5/SIjq4Dq3KB8bC9DgL1kzTjInTQxU=;
        b=HnNaq1xGxK+QfSsWJA2fiNeXdq/aAf2GX3ESWi4OopfSQxtvr1ZJIM/nsPUSPI2Qj5
         eYf85/m1/oOFlL4mcpg7WO6yLdZKxyrWguZ9g+FHVrkA80r7ODV1ZskRKHWkTo0L6QGT
         eQ/0YEgAF/OWtdWLcv9B5unbUEx6h5+yTqUR51U6RSpe9JNCmMFJP5wWAscZBntddZ8c
         W/3wvkgR/nIIg/4kEjwSOmlJhtHkMtDzP3MH0hY6i9gnLY1vinnq/pztcSWNtC4xT9sD
         iIjx7GYTyZOOPTQcr1YpjSg7GbTA3zjqMna2lrML9dICylM0Pt3rTlflh9yEgl07kwcB
         i2EA==
X-Forwarded-Encrypted: i=1; AJvYcCUSygqeBrW4a/eFOUoxC3PeyaD0Ld1mS2s3gtavfU8H2YqAw5JQKFm/V5CnUszWW31c8HoQEDmPLjeOE/w=@vger.kernel.org, AJvYcCXrctSzIoO3DQcVpaMSQHafo4LxzxLjg2heH0iIRuLgArBdLvHWSd8BSf0YDuzeyrK/5l2GNQU2dp+6xVIVQTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzomdJUGPaBVrw8cdGUPiqoPrjpOSKy4RU01gKdie4lF9vX60ps
	3JUjcYUeBszFlIK4RFj5CMMej6q/oV1P7/CBaZmIX/sfkxnGpjWCO9kbAyfv
X-Gm-Gg: ASbGncv72ZKjLlqHq6+//9mLcJSjbex+aTQJ9pdyw8Bc92ZKMkx3SGWBYCZRLc1AvC2
	n+dUjN99oU7Ke/jujR6Z+/MZyZCpbTlZe64QoXjIXI+w44nLsjlxSigSRPYXUabguUYM8Wgp/0Q
	lRqcFhI/3B2+xkgdJk1kRdZv1clWkdOX+6EP4zH1wtAmO5KnpoeIlaYCS2+XGXzehiz0pMOw/3P
	tVFL5Mb+gkO9JSzITzVjxoAaFzL8U0Cdi7MoYq4z7BqG3K5opk+Oye9txg=
X-Google-Smtp-Source: AGHT+IHKDVI0M1a9Yctm/CBV7psH86jb7o8aNJEMRvdEppICbZuFYbzAkh2rPSAoS8q4SjeJHMHktw==
X-Received: by 2002:a05:6a00:1747:b0:724:eac3:576a with SMTP id d2e1a72fcca58-725b81a3dfcmr9611046b3a.25.1733551831714;
        Fri, 06 Dec 2024 22:10:31 -0800 (PST)
Received: from HOME-PC ([223.185.130.193])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725b7f51b65sm2448612b3a.108.2024.12.06.22.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 22:10:31 -0800 (PST)
Date: Sat, 7 Dec 2024 11:40:27 +0530
From: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: kvalo@kernel.org, ath12k@lists.infradead.org, jjohnson@kernel.org,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH wireless-next] wifi: ath12k: Fix out-of-bounds read
Message-ID: <Z1Pm0xsOVbV3rpjc@HOME-PC>
References: <20241206073542.315095-1-dheeraj.linuxdev@gmail.com>
 <8c019176-6bb5-467c-bcea-10517675de7d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8c019176-6bb5-467c-bcea-10517675de7d@oss.qualcomm.com>

On Fri, Dec 06, 2024 at 12:06:51PM -0800, Jeff Johnson wrote:

Hi Jeff,
Thank you for taking the time to provide valuable feedback. I will make the
necessary changes and send the patch.

> On 12/5/2024 11:35 PM, Dheeraj Reddy Jonnalagadda wrote:
> 
> The subject should be as specific as possible while still fitting on one line.
> Ideally the subject should be unique. So at a minimum I'd add "in
> ath12k_mac_vdev_create()"
> 
> > This patch addresses the Out-of-bounds read issue detected by
> > Coverity (CID 1602214). The function ath12k_mac_vdev_create() accesses
> > the vif->link_conf array using link_id, which is derived from
> > arvif->link_id. In cases where arvif->link_id equals 15, the index
> 
> How can arvif->link_id equal 15? Does Coverity actually identify a code path
> where this can occur?
In the code below, when the first condition in the if statement is true and 
the second condition is false, it implies that arvif->link_id equals 15 and 
the else branch is taken, therefore, assigning link_id to 15. The same
code path is shown by coverity. I will attach the link to the coverity report
to the updated patch.

	if (arvif->link_id == ATH12K_DEFAULT_SCAN_LINK && vif->valid_links)
                link_id = ffs(vif->valid_links) - 1;
        else
                link_id = arvif->link_id;

> 
> > exceeds the bounds of the array, which contains only 15 elements.This
> 
> nit: space after .
> 
> > results in an out-of-bounds read.
> > 
> > This issue occurs in the following branch of the code:
> > 
> >     if (arvif->link_id == ATH12K_DEFAULT_SCAN_LINK && vif->valid_links)
> >         link_id = ffs(vif->valid_links) - 1;
> >     else
> >         link_id = arvif->link_id;
> > 
> > When arvif->link_id equals 15 and the else branch is taken, link_id is
> > set to 15.
> > 
> > This patch adds a bounds check to ensure that link_id does not exceed
> 
> See
> <https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes>
> and specifically:
> <quote>
> Describe your changes in imperative mood, e.g. “make xyzzy do frotz” instead
> of “[This patch] makes xyzzy do frotz” or “[I] changed xyzzy to do frotz”, as
> if you are giving orders to the codebase to change its behaviour.
> </quote>
> 
> So this should start: "Add a bounds check...
> 
> > the valid range of the vif->link_conf array. If the check fails, a
> > warning is logged, and the function returns an error code (-EINVAL).
> 
> again use imperative mood (log a warning, return an error)
> 
> > 
> 
> Prior to the SOB you should at least have two other tags:
> Fixes: <refer to the patch that introduced the bug>
> Closes: <the public url of the coverity report>
> 
> > Signed-off-by: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
> > ---
> >  drivers/net/wireless/ath/ath12k/mac.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> > index 129607ac6c1a..c19b10e66f4a 100644
> > --- a/drivers/net/wireless/ath/ath12k/mac.c
> > +++ b/drivers/net/wireless/ath/ath12k/mac.c
> > @@ -7725,6 +7725,12 @@ int ath12k_mac_vdev_create(struct ath12k *ar, struct ath12k_link_vif *arvif)
> >  	else
> >  		link_id = arvif->link_id;
> >  
> > +	if (link_id >= ARRAY_SIZE(vif->link_conf)) {
> > +		ath12k_warn(ar->ab, "link_id %u exceeds max valid links for vif %pM\n",
> > +			    link_id, vif->addr);
> > +		return -EINVAL;
> > +	}
> > +
> >  	link_conf = wiphy_dereference(hw->wiphy, vif->link_conf[link_id]);
> >  	if (!link_conf) {
> >  		ath12k_warn(ar->ab, "unable to access bss link conf in vdev create for vif %pM link %u\n",
> 

