Return-Path: <linux-wireless+bounces-11080-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 028F694A707
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 13:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A9A2B21FAC
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 11:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8401D1DF68A;
	Wed,  7 Aug 2024 11:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dZ6GJ7cX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEB61B86DB
	for <linux-wireless@vger.kernel.org>; Wed,  7 Aug 2024 11:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723030534; cv=none; b=FaiDLut5oIpdBbvmbN1KuDCucFEV9QtVSMC6pEKA+y7cOPccpoqIVbCIeexIK9qqYbdK1lN8rZimZL9x4/qjrzTtbpUePI2Wt2AZjUVYG2JQA/h1LkDEkbpukWT6DlgwCMBmY0gcgJ/iHGloDvvljii/R19BP3I0mMCSafMjx1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723030534; c=relaxed/simple;
	bh=lHPDC25jghZhCKrwT8ViNX9ORfgOdHuHsedcGDBbTAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T8DsEjf9iDBTs9WNfnMhubW6UgQjhitV9xmBJQNLzYeBdxdM5Scvd1zWKgSFpzuaoch0+0nPHfOhjOmLYJxsNEIW1CftfUqtr0Axo8hY6x8/HBV6eiX64Vf2MRivRQvTPcKsiumqD8avPFNThF71pw5kOKxS0pttuCuyK7/ueGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dZ6GJ7cX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723030532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0il9oSJyGAZ+C9csZ4ni4torbJ/NsnGzP7AJupcpQIM=;
	b=dZ6GJ7cXMHGv8H9eFgPqJVnCl6xPyDaAL9zyv9rPahxZI+CiMWRm8PgRW8PCijVp3Kpfnz
	mmVT3mapfBltGQ23iI/TVOEvgVnIi+Rl5Q5+H+4WNFG3pZ8ru8/HFBcbVpNw0ID7VgFeaq
	EoXgf9PKKMuM7LFWhOFsh8+hWwhUa+E=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-zznpxTn3Mxq-GIsRttcCBg-1; Wed, 07 Aug 2024 07:35:30 -0400
X-MC-Unique: zznpxTn3Mxq-GIsRttcCBg-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-44fe92025d8so19126541cf.1
        for <linux-wireless@vger.kernel.org>; Wed, 07 Aug 2024 04:35:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723030530; x=1723635330;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0il9oSJyGAZ+C9csZ4ni4torbJ/NsnGzP7AJupcpQIM=;
        b=eMIPuWEAtYTRMM2KYjrz9uI4kXTQVU4sdH/yD8fQbnPZMZQi9A2NVmNR7Rk5+dU6vG
         ZwoCZ1tFBwi0lR/p2X4lc70dRCUbbyJsvB+PKaPZeqXFewqLuLl9l5GewRJTDsda5zxO
         CarSGC/UXyaizI9hKweZtRK+qIkfGh2pH7j9bsHrlxvYxF6TTn0aXlnIKXBhO4i7tc1y
         VulltAK4+HRhK4DhzpKQUrwA9aznUHOvDcAfVHL8w0mED1UDBU4T85bkfvRE7tk+Ao/f
         NYgsee3rWHtkmn3MmaAtm4GqyFevXViohV/L+3Gud39YvbBkRXu19r61EqKVH52hXKVq
         eaRw==
X-Forwarded-Encrypted: i=1; AJvYcCX6vjIGqii0O0j19g4QXhbuC10yrXk70E+X9fVnbXeUL6dxhnGDuAUIEr3VEnwJ6ZPKhzTtTlHqI4SBD3BNDMBSLL4CeHXd4qaGnLrS9Zs=
X-Gm-Message-State: AOJu0YwIsk7jJxV38YYpPJvEvBRl1LuOIUM6n/xlNlzqwqrM3/l5oIEr
	ys6sFt3GHga+POinlmqh0Uysn91OsOwfUCvhi5hC2JjH40+ahPolwZ77gWpkbwhmAdzzDDusZTf
	KkLWX5YTLvIWrQ5j7PZ+DDfK6XeEkOptBpjFOiioZbpHFjGgAbR1zsRfQiNbLjWlZ
X-Received: by 2002:a05:622a:2d2:b0:445:2e9:330e with SMTP id d75a77b69052e-451892a8fabmr174819051cf.37.1723030530245;
        Wed, 07 Aug 2024 04:35:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQldDPCbezXKy6XTDGMyMJ4k78IFbZjvkY4tr+TtV0lv80CwndDivLxMRaVvCFRbPjWXffsw==
X-Received: by 2002:a05:622a:2d2:b0:445:2e9:330e with SMTP id d75a77b69052e-451892a8fabmr174818841cf.37.1723030529776;
        Wed, 07 Aug 2024 04:35:29 -0700 (PDT)
Received: from debian ([92.62.32.42])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-451c87d934asm4026961cf.65.2024.08.07.04.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 04:35:29 -0700 (PDT)
Date: Wed, 7 Aug 2024 13:35:23 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: Simon Horman <horms@kernel.org>, hhorace <hhoracehsu@gmail.com>,
	johannes@sipsolutions.net, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	Ido Schimmel <idosch@nvidia.com>
Subject: Re: [PATCH] wifi: cfg80211: fix bug of mapping AF3x to incorrect
 User Priority
Message-ID: <ZrNb+3YJsuRV9GLl@debian>
References: <20240805071743.2112-1-hhoracehsu@gmail.com>
 <20240806090844.GR2636630@kernel.org>
 <ZrIDQq1g6w/zO25l@debian>
 <87ttfwiyn6.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ttfwiyn6.fsf@kernel.org>

On Wed, Aug 07, 2024 at 10:24:13AM +0300, Kalle Valo wrote:
> Guillaume Nault <gnault@redhat.com> writes:
> 
> > On Tue, Aug 06, 2024 at 10:08:44AM +0100, Simon Horman wrote:
> >> + Guillaume and Ido
> >> 
> >> On Mon, Aug 05, 2024 at 03:17:42PM +0800, hhorace wrote:
> >> > According to RFC8325 4.3, Multimedia Streaming: AF31(011010, 26), 
> >> > AF32(011100, 28), AF33(011110, 30) maps to User Priority = 4 
> >> > and AC_VI (Video).
> >> > 
> >> > However, the original code remain the default three Most Significant
> >> > Bits (MSBs) of the DSCP, which makes AF3x map to User Priority = 3
> >> > and AC_BE (Best Effort).
> >> > 
> >> > Signed-off-by: hhorace <hhoracehsu@gmail.com>
> >> 
> >> Adding Guillaume and Ido as this relates to DSCP.
> >
> > Thanks. The patch looks good to me (only missing a Fixes tag).
> >
> > Just a note to hhorace: the entry for CS5 (case 40) is useless as CS5
> > is 101000. So the value of the 3 high order bits already is 5 (in case
> > you want to make a followup patch for net-next).
> 
> Minor clarification: cfg80211 patches go to wireless-next, not net-next.

Yes, sorry for the confusion :-/.

> -- 
> https://patchwork.kernel.org/project/linux-wireless/list/
> 
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
> 


