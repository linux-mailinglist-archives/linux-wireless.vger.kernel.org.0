Return-Path: <linux-wireless+bounces-16128-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C52029EA726
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2024 05:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE1E5162C7C
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2024 04:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68CDD54727;
	Tue, 10 Dec 2024 04:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UzsQiNiW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7654DF58;
	Tue, 10 Dec 2024 04:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733804351; cv=none; b=WEmFyLIJqVw7qItqEcj8Tj5OR+TBqhTIlPBnwFTMYQbdtbSp1LqSfUgxs930JpHPGr+NFFUrrrvLcn3oW9swY3ucnjhB596TqO9gJ9A98c2ZruaFF15dPz/sWM+oUWojosj2cczrN0o260W+DE2rdXo6olChRo2ft0pqgH6Ovfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733804351; c=relaxed/simple;
	bh=4TI5Iaty/OJmO21fowePBYL8u4K4f+zgozKQZrnDnKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Geer0Nd0nXNYM23u/iFyPGMrkhasNPAobFTv1kfK7NjPyzmVcSoKWFIyl8VQveutH6MAXbZF1MmA32zfuaX8EqgHsV7jLbuvCnBxNxPd9dKI1R0bQqEjH2SizJo7A669Y0ydS5FWI7IRx1RsygI4kwn8psrLLosb/vLNDdcZowc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UzsQiNiW; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-216426b0865so16777335ad.0;
        Mon, 09 Dec 2024 20:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733804349; x=1734409149; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=da6AsHE3Yk7Iu5Y2wCs+pnA5htOu4IQpp1PaojY+e3U=;
        b=UzsQiNiWzoMDJyjgoadHflN/tq7YAVEqN1yGsk6oRjUcGN99fGgozeyCi3U27mBSGK
         POBwxPsmpsfcVbIMd4Eq+ONDx8Q1lXR4L2Nn2x56207IJjdDHaJEdGvMEf1pr4X8LIF5
         wI9dFLBZiRMxtxcMwn2wrHrZi53iwOuXYa2N/HtMZmoN9Xh/Jq7ddZ2UI+Q9hNmy4HRC
         GlQZRGcxA7v9Ez/pm/8hvKNohlpNzLIDk0pvy2/Cl2/DnxbXoropX15lwvL9G7fBkngk
         MZCloyoFQ1SzjJww8nA/SoENbmyyOEGkskktiabqF1oOWbNw6pnwIffdBgmAAV0qvXZt
         wKvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733804349; x=1734409149;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=da6AsHE3Yk7Iu5Y2wCs+pnA5htOu4IQpp1PaojY+e3U=;
        b=TdY+kvJjkWBx/WwkiCIa1lhhflWAf1mnIMPJNZdM1UCdL0IbttWkYl4TqtA2RzGtNz
         MDWJRzjt/ApzRpsdt2y6uGpAQjl3o9eHPMkHeNuu6IzLA6C8T35E7godjiXSfnsdfQvf
         t7iC7mmZwse1EJyraQnWubeSWcibo0xJBLDgdM9W2ozD3ma8urIc5Wswf+/G9PNnwcrA
         1be82HqgxN7Qs10lJRU2arhBRkyZ+XXNN4YbZciyXlWJFwZ2ZZaAP5kxpSDeC4bfXSSJ
         lZNY8klu60O1QUH+PAb7x68x6mbJwZ5arGbuAPTtMsNs4dlx8FH1qiKpu1VlR6RqzUf9
         bNpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVy6PaWR15IfEcWLpsiGQjERSQi3r5+yHO2RWp7jhuWnaeY9IFfL2uE4Fyu3UcxUngtUHhL4z/WAO+ratI=@vger.kernel.org, AJvYcCX/l+I129+5+ney2u4uRJGl5r7cZkX32YyWF8ucfvVdMsvliqe5DVGQkweX6WN4f43CAaHBYcxgkayJup/eiLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVSXZVhlOk6CFRj5APOeCMoEfVl3xSYB4qzk/INcXKpvkuecVN
	r0fyKh6lsW1RSaQeTnXpJ0DTSJz4+v7BMa++RT1Wf2KaW9NfJ20CvvuF+ymY
X-Gm-Gg: ASbGnctRZsF58h/lBeTHNAqG1/8sghQhtiEH2I3cXDD8S9SMqKsfYPt/m4WWUdJe7Rb
	yGe5OdyDis5LlqPIN3HOC4AjCNpLBXRE4dn5NTY3/ZFHEIjb/N/BENyNjtmSsESqACisVWGvJfp
	dnV2cZmBkVE7ZH3RbzR7rDNQL1eOSffqtDRYj9VwxYyjFAxtWfjTVUBqQxL8AaOzlTxXK4pEqQL
	bcb9uLuMrxdfSQyZo2HN8GOTqLZsxEkXebWvGiZdnbq/KCZ/Y75zdQRitM=
X-Google-Smtp-Source: AGHT+IFfgCMQaMB8Kpin1tc6oNoG54Lk9s6R9r0BKlNu56dLiRQin18Y4EQqibfwk5KkVLKohEpC6g==
X-Received: by 2002:a17:902:d2d0:b0:205:4721:19c with SMTP id d9443c01a7336-2166a03eecdmr46675515ad.37.1733804348735;
        Mon, 09 Dec 2024 20:19:08 -0800 (PST)
Received: from HOME-PC ([223.185.132.235])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8efa2b9sm80119605ad.168.2024.12.09.20.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 20:19:08 -0800 (PST)
Date: Tue, 10 Dec 2024 09:49:05 +0530
From: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: kvalo@kernel.org, ath12k@lists.infradead.org, jjohnson@kernel.org,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 wireless-next] wifi: ath12k: Fix out-of-bounds read in
 ath12k_mac_vdev_create
Message-ID: <Z1fBOUqYGB5hNP1e@HOME-PC>
References: <20241207071306.325641-1-dheeraj.linuxdev@gmail.com>
 <cd5ef876-d849-4d7b-b8b7-94377e8720f0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd5ef876-d849-4d7b-b8b7-94377e8720f0@oss.qualcomm.com>

On Mon, Dec 09, 2024 at 10:39:36AM -0800, Jeff Johnson wrote:
> On 12/6/2024 11:13 PM, Dheeraj Reddy Jonnalagadda wrote:
> > Add a bounds check to ath12k_mac_vdev_create() to prevent an out-of-bounds
> > read in the vif->link_conf array. The function uses link_id, derived from
> > arvif->link_id, to index the array. When link_id equals 15, the index
> > exceeds the bounds of the array, which contains only 15 elements.
> > 
> > This issue occurs in the following code branch:
> > 
> >     if (arvif->link_id == ATH12K_DEFAULT_SCAN_LINK && vif->valid_links)
> >         link_id = ffs(vif->valid_links) - 1;
> >     else
> >         link_id = arvif->link_id;
> > 
> > When the first condition in the if statement is true and the second
> > condition is false, it implies that arvif->link_id equals 15 and
> > the else branch is taken, where link_id is set to 15, causing an
> > out-of-bounds access when vif->link_conf array is read using link_id
> > as index.
> > 
> > Add a check to ensure that link_id does not exceed the valid range of the
> > vif->link_conf array. Log a warning and return -EINVAL if the check fails
> > to prevent undefined behavior.
> > 
> > Changelog:
> > 
> > v2:
> > 	- Updated the commit message as per the reviewer's suggestions
> > 	- Clarified the description of the bug in the commit message
> > 	- Added Fixes and Closes tags with relevant information
> 
> As Kalle already mentioned, the changelog should come "after the cut"
> Please refer to:
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#the-canonical-patch-format
> 
> Namely:
> One good use for the additional comments after the --- marker is for a
> diffstat...
> Other comments relevant only to the moment or the maintainer, not suitable for
> the permanent changelog, should also go here. A good example of such comments
> might be patch changelogs which describe what has changed between the v1 and
> v2 version of the patch.
> 
> > 
> > Fixes: 90570ba4610 ("wifi: ath12k: do not return invalid link id for scan link")
> > Closes: https://scan7.scan.coverity.com/#/project-view/52337/11354?selectedIssue=1602214
> 
> there should not be a blank line here
> 
> Also I just joined the Coverity "linux" project. I have access to the
> dashboard, but don't see that particular CID. Since you've been a member for a
> few months, is there something special I need to do to see that CID?
> Or is this CID in a project other than "linux"? I ask because I'm looking at
> A CID in the latest snapshot of "linux" and the URL is:
> https://scan5.scan.coverity.com/#/project-view/63541/10063?selectedIssue=1636666
> 
> So I'm guessing your CID is from a different project?
> 
> > 
> > Signed-off-by: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
> > ---
> 
> to reiterate, the changelog goes here, with the latest version described first.
> 
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
> Note that I don't need you to send a new patch if Kalle ACKs the current one;
> I can fixup the patch in the "pending" branch. But I would like to make
> sure I can see the CID in Coverity, so please let me know if I'm subscribed to
> the correct project.
> 
> /jeff

Thank you for the feedback once again. The Coverity issue is from the
"linux-next weekly scan" project and you would have to be subscribed to it. 
The link to that project is here:
https://scan.coverity.com/projects/linux-next-weekly-scan?tab=overview

-Dheeraj

