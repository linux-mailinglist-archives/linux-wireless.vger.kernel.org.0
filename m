Return-Path: <linux-wireless+bounces-12269-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E54096670B
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 18:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B117A284E81
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 16:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC7114A4DF;
	Fri, 30 Aug 2024 16:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="dtdolGEx";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="Rh4Hr1jQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from e3i110.smtp2go.com (e3i110.smtp2go.com [158.120.84.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB8413BAE2
	for <linux-wireless@vger.kernel.org>; Fri, 30 Aug 2024 16:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.84.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725035737; cv=none; b=nQMFMP7ALyy3AeUYj1nA0gC9gTpEujDJFbIvMdlrc6+Mo014qVbwweT0sOWid/eqXu9qrPCqBnndkXhAatKNv+eK+puHV5M0ofvPHkaB/57DSwW6oSgMlrpbJyfRijCjtCi8YmPV7Xt3ZBPY6MCjarJKoVo/DVIXUGuhmKKfn8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725035737; c=relaxed/simple;
	bh=LmxirJlfnOsptE+isNTt5/FBE5gu9GL4B/w8zRlweyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qFlztBBsDwLJHr1509P/JswZDilqLcSkpxlWDF5w0cAjcZpYBSFU3BLAeIIp3mV3bBlXDLgJgjOV6/t78QSt4WTMaYKM7HXpSLAxIlFV31oW1yJ6VhLdG4y0IGr+UT6touywCOTlMfYKxQpCwAo4rU3mIzkdem6ZTitCzKK+qg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=pass (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=dtdolGEx; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=Rh4Hr1jQ; arc=none smtp.client-ip=158.120.84.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1725034823; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe : list-unsubscribe-post;
 bh=n40eqImWNJaJ1eZyhml6lDvg7HoUmFqBfkd7fEOtuGA=;
 b=dtdolGEx0K/4qcf1lKE3AHOsHt+r/sOcon+OFSGZYw3iypgobO7IRCFAD9wdsQSDNIDBE
 SNfhCpWBpIH82C6W9aMYN0XdJkjVgUI9Kffgv0u5V6Si4rjTH4Rzqs8auxgcNRmc4b4iiBm
 vvrhurgHmOVxGiQb8+qnrorsltGaxOkBGupLHJW9wGM64Frne0sRe4fvpkbwJwq8T8Wq3sX
 y7e38Nmw8WcGhvFyTfZCAXOcSa/WqlHrYh50acmVnijcT11us16aUWk5dhSNyEG2jbQ5ekG
 XYkDc6D/TU+YikbHq38aUkmcWTGWsoRB9m8t6c54k54iVn7mvLHUO5Kg9UUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1725034823; h=from : subject
 : to : message-id : date;
 bh=n40eqImWNJaJ1eZyhml6lDvg7HoUmFqBfkd7fEOtuGA=;
 b=Rh4Hr1jQP7wfrX75/ENxzq74ngtu2g1thOkYPskFWCK87cYAfRmz2iBiGgr+cMFZJB512
 kTgqeEK7mfTJP0Khxw+B9TVoRkJ4WvFAePWYe1csiloxfUdXRYilMVTXKj8xZhfdTyho8MU
 IJ+k70eh/hC0AKS1WUNJwVtLxcN+e7/PaRQzSqJOg0FM/VtkF/669C7/B4mabOqUVHi3fH5
 FcdsCf4f5B50Q2a6PvlRdjlIRED+IpABl0AWidFGS1zLErze0wDF+KT3/1uL5w+otJOD+W5
 IvHO7BAYeF/isAYBIU+0L81fvwT+UhfDPj5Iy1TrkwuuAjbbMthfkT3u5W7g==
Received: from [10.12.239.196] (helo=localhost)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97.1-S2G)
	(envelope-from <repk@triplefau.lt>)
	id 1sk4MG-4o5NDgrw4Fa-nsAO;
	Fri, 30 Aug 2024 16:20:20 +0000
Date: Fri, 30 Aug 2024 18:21:50 +0200
From: Remi Pommarel <repk@triplefau.lt>
To: Nicolas Escande <nico.escande@gmail.com>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: ath12k: move txbaddr/rxbaddr into struct ath12k_dp
Message-ID: <ZtHxnk0weaxYUIwZ@pilgrim>
References: <20240830081942.3623380-1-nico.escande@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830081942.3623380-1-nico.escande@gmail.com>
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 510616m:510616apGKSTK:510616su41D9LAPX
X-smtpcorp-track: 15zYQ3KWAbul.9LGn4OZxyeQl.a7LHAgWroYp

Hi Nicolas,

On Fri, Aug 30, 2024 at 10:19:42AM +0200, Nicolas Escande wrote:
> Those two fields are used to store the per SPT page of tx/rx descriptors send to
> the firmware for cookie conversion. Right now they are in struct ath12k_spt_info
> which means they are duplicated PPT page times while we only need one instance
> of them. This works for now as we always use the first spt_info as a global
> storage for all PPT pages.
> 
> Let's move them into struct ath12k_dp where they belong, alongside of the
> spt_info array they are tied to, to avoid waisting a good bit of memory.
> 
> Tested-on: QCN9274 hw2.0 PCI CI_WLAN.WBE.1.3-03283.1-QCAHKSWPL_SILICONZ-2
> 
> Signed-off-by: Nicolas Escande <nico.escande@gmail.com>

Looks good to me. For what it worth:

Reviewed-by: Remi Pommarel <repk@triplefau.lt>

-- 
Remi

