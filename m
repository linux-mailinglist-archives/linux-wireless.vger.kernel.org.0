Return-Path: <linux-wireless+bounces-19892-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45FE1A54853
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 11:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5519F3AD02C
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 10:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28041A76BC;
	Thu,  6 Mar 2025 10:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="0bCRZKZK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117AA53BE;
	Thu,  6 Mar 2025 10:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741258030; cv=none; b=bmORlZwM2gZAuri9Fg+ZFAEQR1qvXzSyIf35IDXKJ+eWWKh2NqCo8orO1hYzzVV083GR4F8mubwtT136XyeEaHKdPBLutJKCYuvYTPlqa31yKcIBxqmbo1JrJzss4IPJe9Y0V/5IR5UQo7h8wmAfI9SmXdDXs42mAl2GJHxwXt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741258030; c=relaxed/simple;
	bh=Ei8/TdAUY4MIp/W0ZRr89XJzXkRIf8JF3XfjB2v/OUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OVbtZd1RM1Tefd9SCODG7pyBk+VrvC9J6o+fdZO3qfnClhJSWYKixAqd3jn23883eo8oigpmjp/7BCozwXCe+fpWdQkhQaBHAr7nSdeIEzDQ8yvHu5maioGir++lShU3mBYORI8ExNxfdaJqa0Fbtn+v4qvrNxpTTxzvolaGMtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=0bCRZKZK; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id C46B51FA1F;
	Thu,  6 Mar 2025 11:47:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1741258027;
	bh=4bFsppBmUI1sbWwR4MbcAjn9VKeKRasxbk8loR8DIas=; h=From:To:Subject;
	b=0bCRZKZKrcALGFzhDXi8RKinWDpJFspD3K7uXUPqJ9KdIqL5L1AVrNfBDObhR39Jn
	 hSBixTWeVEk6XT3v65+FbcezTAyy/3+z9eo7k2Yvs/5OWdFlhtc3wny3FcNNiWwx4X
	 Zglt2ysRuz5Bq2vRuw9el+JKFyGBztcdfLbTwFQ8tQAOayo4wNsF58BkLRoo3ari1B
	 VTL3vX5D8AwDxJe2uI/+ElEuhXcgApp4MfICqm7Vi+ktbSgpM/2s2B7gXcq35USsMQ
	 +WihhAAG8u/5uM4cDoSVemCHkYhEMF+byq+cPZHvl3DQbXrWdxvvns5if/MsXnpAHO
	 ULZM1lSiIFCyQ==
Date: Thu, 6 Mar 2025 11:47:05 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: linux@treblig.org
Cc: briannorris@chromium.org, francesco@dolcini.it, kvalo@kernel.org,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mwifiex: Remove unused mwifiex_uap_del_sta_data
Message-ID: <20250306104705.GD19853@francesco-nb>
References: <20250204012512.390209-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204012512.390209-1-linux@treblig.org>

On Tue, Feb 04, 2025 at 01:25:12AM +0000, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> The last use of mwifiex_uap_del_sta_data() was removed in 2014 by
> commit dda9ddeb2638 ("mwifiex: do not delete station entries in del_sta
> handler")
> 
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>


