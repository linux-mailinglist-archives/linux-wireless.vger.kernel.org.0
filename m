Return-Path: <linux-wireless+bounces-35240-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDw5AMWn6WmzgQIAu9opvQ
	(envelope-from <linux-wireless+bounces-35240-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Apr 2026 07:01:57 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D3344D1FC
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Apr 2026 07:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5AC2330039AE
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Apr 2026 05:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937E329E113;
	Thu, 23 Apr 2026 05:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="eCpWQugj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="umy7pxb2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6736121E098;
	Thu, 23 Apr 2026 05:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776920513; cv=none; b=dDf+xs5EyNDuVR9lySRYpb2Or/+7lkFShY3U1R6NUl58mnBORYDKVWp6LnBJZxmgiIF9j1sAmwJUAbCnF9lYBSx18Ihl4HDV60ctWYPNbfcx0uaOwQIDpqffWOCr7NapLTjumMzOCQTq/VSWz4OKLsLDyw80WkBOt7HLqRPpPyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776920513; c=relaxed/simple;
	bh=V6XxX8QLhSgwswgLGUirkEZJrtdVcYmqMU8s2ZkSZ1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dHOqVqoOS/yqV+HqqUoG4X9MEKu7b+BueqtHbyarUPEqRpMrXrcRYTnrz6w9/s7nxod6FhhygTlO0tt0pDR5dS+oyyBsrsX60iC53to7bBtatxmbcDCaxsTH50g8pJnGT+W+XFMj4H3d8/6XaQBMYLWozAzPki36z4a4PmyCRag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=eCpWQugj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=umy7pxb2; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 740C31400093;
	Thu, 23 Apr 2026 01:01:50 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 23 Apr 2026 01:01:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1776920510; x=1777006910; bh=JeZ0eQ1N+i
	62g85dcr6rfQmz3jxz9fSJ7G8cYPR8Hzg=; b=eCpWQugjDSAFfQ7utr5Xp4Derz
	RxRtb/n4r8/BJs3EmTzzlTuMw38reptlBgiZSfRowKIeRzbYoa+1iRxq99tBCbI9
	cW2Z/1iTuE4mtu0OHKSoPuM0EkETLKnsuR6BvZSdU8pS3qD2xF1cx2QJiOwxwlVC
	YUJyPxStPNPwRdyVAGseXa3SgJTYkU2MaeL93I4t9K91Nrwpwmaw8c8kS3JCwzKg
	VNvc0T5ZVmg5T+ItDDPm05kkFBNsh1o49f/C0uZfABVd1vHPRuTocueOjrhx6aWw
	2IIhqfb3cysr6Lys619OJUpICqbYE8E+1N4R6ibnhCqvQWu5vNUSDHNdXHDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776920510; x=1777006910; bh=JeZ0eQ1N+i62g85dcr6rfQmz3jxz9fSJ7G8
	cYPR8Hzg=; b=umy7pxb2C2+g7aJSFQnp1htnGB1zNwktRbNSFBl4PX6BjgRLOJQ
	zQyGD8bL1z6Pxc3bi1K8K4WcBg0Et8Py2AGdUC0SPkc+w1g0N5ISy0M5fHFQGhgm
	Zfr5HCTpblhsHflmDAWOnI8EnS7uoD9xEqL4+ibuO+zhobfgeLIkQ6sk8bDuZjUO
	ouatJiL94XlXB4ag8xUEeo9qLBHmLaeSp8dbeG8vRyWbO8/fVNqUk/KKU/YYcj61
	KR8Da9VDqfJ+I9o9nhHhwqe0b8wl3wMquG9D3+MhyXIOC6nPv2PXGZF/rP09SnuP
	RN9JeOi9tTOXR7dnZoizaNejL55aMjORUOw==
X-ME-Sender: <xms:vafpaZG0x_QjHPR_Sj304wnwh5Yn5UxG9U5pOH3lY8R-wvobWqueww>
    <xme:vafpaf5knAvz7MSzn260V0m6uGB6SqlNYCWxpT-5s9GA0pEZmwabQty6wqOfQL6wq
    ZyzciwXAIB66poPwM4OIm3zt8EA2jQvgzXiQ7u81NjeW9kyOG0>
X-ME-Received: <xmr:vafpaabKBRmJYMRWEncKxjO3-DtJQHifp54Aer3Ilh0UWeOCcLgzOqg0_kEPA5HuenYy8nkqW9PzGoi0seYXySfhiQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeiiedviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcumffj
    uceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehgedvvedvle
    ejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtg
    homhdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehjvghffhdrjhhohhhnshhonhesohhsshdrqhhurghltghomhhmrdgtohhmpdhrtghpth
    htohepnhhitghordgvshgtrghnuggvsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprght
    hhduvdhksehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinh
    hugidqfihirhgvlhgvshhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    shhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:vafpaVg-j8utCR_6r2vWMmStMH1PgY4cCNqBDEUCRzMA6y-bSzaPZQ>
    <xmx:vafpaUepufAr-kaZiXdx6-JlOm2wKI60n6tn-DW-_e3rkNLZ7VH3vg>
    <xmx:vafpaclbAT9ctQw3RdyrJGDDRPEeJojaL5qku9-rrMRvL4qf8lfM_w>
    <xmx:vafpaRzMRnTQd3WPOUaDPc6bDlQ_IUPIeBaPpqlnDmY_qRQSWhyvNQ>
    <xmx:vqfpaViYSJumZaVsKB3_7F06R7gi0IrQ_Vo_ZNT63BdPvV3JCCJIkdSs>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Apr 2026 01:01:49 -0400 (EDT)
Date: Thu, 23 Apr 2026 07:01:48 +0200
From: Greg KH <greg@kroah.com>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: Nicolas Escande <nico.escande@gmail.com>, ath12k@lists.infradead.org,
	linux-wireless@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH ath] wifi: ath12k: fix leak in some ath12k_wmi_xxx()
 functions
Message-ID: <2026042326-sediment-earring-4050@gregkh>
References: <20260422163258.3013872-1-nico.escande@gmail.com>
 <0456ecb5-130e-481d-97d9-e88a7aaca02d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0456ecb5-130e-481d-97d9-e88a7aaca02d@oss.qualcomm.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kroah.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[kroah.com:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35240-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lists.infradead.org,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greg@kroah.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kroah.com:+,messagingengine.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,kroah.com:dkim,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 28D3344D1FC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 22, 2026 at 05:08:59PM -0700, Jeff Johnson wrote:
> On 4/22/2026 9:32 AM, Nicolas Escande wrote:
> > Some wmi functions were using plain 'return ath12k_wmi_cmd_send(...)'
> > without explicitly handling the error code. This leads to leaking the skb
> > in case of error.
> > 
> > Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00218-QCAHKSWPL_SILICONZ-1
> > 
> > Fixes: 66a9448b1b89 ("wifi: ath12k: implement hardware data filter")
> > Fixes: 593174170919 ("wifi: ath12k: implement WoW enable and wakeup commands")
> > Fixes: 4a3c212eee0e ("wifi: ath12k: add basic WoW functionalities")
> > Fixes: 16f474d6d49d ("wifi: ath12k: add WoW net-detect functionality")
> > Fixes: 1666108c74c4 ("wifi: ath12k: support ARP and NS offload")
> > Fixes: aab4ae566fa1 ("wifi: ath12k: support GTK rekey offload")
> > Fixes: 7af01e569529 ("wifi: ath12k: handle keepalive during WoWLAN suspend and resume")
> 
> @Stable team:
> 
> are you OK with one patch that fixes a bunch of places, or would you prefer a
> separate patch per fixed commit?

I do not understand, we take what is in Linus's tree, so the same rules
apply here.  If the patch should be broken up for Linus's tree, that's
good for us in stable.  If it is one "big" one, then you have to deal
with the fall-out if it doesn't apply to all relevant stable releases by
providing a working backport for us :)

thanks,

greg k-h

