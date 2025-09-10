Return-Path: <linux-wireless+bounces-27205-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4629B511B1
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Sep 2025 10:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FF314877AF
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Sep 2025 08:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B3B2AE99;
	Wed, 10 Sep 2025 08:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="rK2lkkFp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9A22BD586
	for <linux-wireless@vger.kernel.org>; Wed, 10 Sep 2025 08:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757493759; cv=none; b=Nd5thVMmvjRcc/qd3EihDzzNzYzHNFDqTKgkYwJNICFyXzWwR7nNfhLn7GzH9xHIkbjPDkvxaWwebzioOKXmE430FxY7J/IZTpRf6SuLQdCBcS5b3kqFOGz5i7MCF0blNnnvq44EiDv77rWmCUDDtdYJUoF1v8+7Q5RQyZlt/wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757493759; c=relaxed/simple;
	bh=rOl1FN82MLyzCETofQDAKLHvlTqr2mjR5LdlHaTSteo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AqQl6LZs3pAC/fx1wZv8ha5mf/B21fKRXuVqm2S8e9WwtTlTiIhvj3m/c8VLLvDAAsNng86gz2ELeX2epCj4gG1Fb33ytNYhFjrHq1woxDS6Ew8kNmd2A8I3XMA9x0pNI2PnIJh1ezuQZxMgUfGuPPQPXJjRRMG8lSUp1SobGck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=rK2lkkFp; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=XrjvAXLoHcgGjqU3FWWQAm4hGkVUJrq7+jkWC7byI2s=;
	t=1757493758; x=1758703358; b=rK2lkkFp5m+U7KjiXTweb+rnWnOhNiBMd+WzUSl3QyeNj35
	OUr8+icHXGLmr/tj+bsEz0aEz13MiSyVuaiHH75h+1HDQTxeUHEOkEhYx8NPge6sMAkuTzms6LFyu
	906R0H196nsl1GaIk5Kn2WFw5d4yKUCFebq9Zc+H2XQ1plpZB/2GI+p+H44e3pCwXw2OsoN9HqxXI
	t4MEYEyLpXW93UoXA/u0OO8rMR1HxeJ3hIq0jocBpstPYhTnAOvifO1iUZSnqc6v4Vj93C6ft0BLa
	jJOJL8iFgKohG1u4NdW8czi4dF2t1FLSjSK/YWNJE5OP45omFx/e+1ibz1qH02yg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uwGPS-0000000CTvC-0o9m;
	Wed, 10 Sep 2025 10:42:34 +0200
Message-ID: <d7f5ec2d5ffd5af8ddc45f419494d6abdf0f154f.camel@sipsolutions.net>
Subject: Re: [PATCH wireless v2] wifi: mac80211: fix reporting of all valid
 links in sta_set_sinfo()
From: Johannes Berg <johannes@sipsolutions.net>
To: Sarika Sharma <quic_sarishar@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Wed, 10 Sep 2025 10:42:33 +0200
In-Reply-To: <20250904104054.790321-1-quic_sarishar@quicinc.com>
References: <20250904104054.790321-1-quic_sarishar@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2025-09-04 at 16:10 +0530, Sarika Sharma wrote:
>=20
> +		/* currently assigning all valid links to sinfo in order
> +		 * to iterate over all possible links
> +		 */
> +		sinfo->valid_links =3D sta->sta.valid_links;
>  		ether_addr_copy(sinfo->mld_addr, sta->addr);
>  		for_each_valid_link(sinfo, link_id) {

To me, "currently" implies this code might change later (as in "the way
the code is currently"), not "at this place in the code"? Maybe that's
just my understanding of English, but anyway I've changed it to

                ether_addr_copy(sinfo->mld_addr, sta->addr);
+
+               /* assign valid links first for iteration */
+               sinfo->valid_links =3D sta->sta.valid_links;
+
                for_each_valid_link(sinfo, link_id) {


which seemed clearer.

johannes

