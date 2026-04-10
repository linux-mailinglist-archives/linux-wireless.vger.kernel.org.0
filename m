Return-Path: <linux-wireless+bounces-34576-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qN+bNuTP2GngiQgAu9opvQ
	(envelope-from <linux-wireless+bounces-34576-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 12:24:36 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 422F03D5A18
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 12:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D83F2309FD48
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 10:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B73346AD7;
	Fri, 10 Apr 2026 10:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="iP05JMmO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493AE2E63C
	for <linux-wireless@vger.kernel.org>; Fri, 10 Apr 2026 10:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775816174; cv=none; b=Mq1coeOEhpG/bcldqLvPbwdOorNPKefcV4hQOcF4p37t3lXSyPp8UfGkJLiR01swP2aAPdZ6m3XR7XYlsOFX0b9jLYJOvATbEWOWrkBysLubOPpz+8jsirJ+6haWgIqErwg0KxPyam0l35+hyMSIPxQeqCygGfgq0Y/JrJoV6n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775816174; c=relaxed/simple;
	bh=GcLz2LOdn69oMR/U/+jIrB4QCxc3iTKKqt8tQAamlWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s4XCvtaQHIH8xvXYhsIT3sQh1PFxkJhAXPWHeTMCRlF10l6ufi9LkCfK069fYACebe79PSt3OhXIeab2wfqy7/U2bjOwQzQqWbohrKBe7VXxce5G9LKeDx1xAc6PcB/K3DXKPcedp9Fq20ZCimM28jeMp1cv8VXJuB8MOzVSIEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=iP05JMmO; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=421oOQdqRUSBpJJMXGjrvwmRojU+NSkZgq43IEe5ll4=; b=iP05JMmOAEPAagcycVHO4I+OC7
	B41TstBB6rfmkv1V/sFeVcs3qogPzs2uM3Vquz/pI9pGByVbEjz+/2EMV3SihwUSE/Sqh7sIp2gn/
	yQCB3c0DTA0thKwj/ae5s27LjmjOBaK5Fi8LzMC+9gdGGadiU/GFOWwpweSSR7szgsXnKOotWJTiz
	vXtsyOh5Jh1zTYZ4JnyP98IqshaKZwnJ9E0RHlSaU4CtmSeBHGRRNKaWoBcDuo3JVfkkeyfhUmCxk
	AHSp3iRM3zIbiOy0dex3SNaP5cB8UUvBB4YQbBkfNqjSuRdYVa8ZSWGr6sch41qF1Z3ykuUR1W8qp
	hPwL7QGA==;
Received: from 179-125-64-254-dinamico.pombonet.net.br ([179.125.64.254] helo=quatroqueijos.cascardo.eti.br)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wB8u3-00EKNi-Ge; Fri, 10 Apr 2026 12:15:56 +0200
Date: Fri, 10 Apr 2026 07:15:49 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Kalle Valo <kvalo@kernel.org>, Yan-Hsuan Chuang <yhchuang@realtek.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"kernel-dev@igalia.com" <kernel-dev@igalia.com>
Subject: Re: [PATCH] rtw88: add TX power limit support to 114 and 130 channels
Message-ID: <adjN1Tl1N_xpzBHd@quatroqueijos.cascardo.eti.br>
References: <20260306-rtw88_channel130-v1-1-ff25a5bc930a@igalia.com>
 <55c23c5551354c6f8752d620f268b37b@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55c23c5551354c6f8752d620f268b37b@realtek.com>
X-Spamd-Result: default: False [-0.36 / 15.00];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-34576-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cascardo@igalia.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[igalia.com:-];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,igalia.com:email,quatroqueijos.cascardo.eti.br:mid]
X-Rspamd-Queue-Id: 422F03D5A18
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026 at 03:56:11AM +0000, Ping-Ke Shih wrote:
> Thadeu Lima de Souza Cascardo <cascardo@igalia.com> wrote:
> > Though 114 and 130 are not usual channels, they are found in the wild with
> > setups using 5350MHz as the center frequency of a 80MHz setup.
> 
> What did the AP setup? channel 114 160MHz?
> I wonder why rtw88 can select a not usual channel 114 80MHz.
> 
> Please share your environment setup. 
> 

This is a Mikrotik that uses channel 130 at 80MHz.

> > 
> > rtw88 supports that, but issues a WARNING because it cannot find the TX
> > power limit for those channels.
> 
> Actually, rtw88 hardware can't support that, so we are working on patch
> to avoid selecting unusual channels. Can it work properly with
> the AP after this patch?
> 

It does work just fine even without the patch. The only issue is the
WARNING that is triggered.

Regards.
Cascardo.

> Ping-Ke
> 

