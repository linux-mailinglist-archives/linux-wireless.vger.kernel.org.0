Return-Path: <linux-wireless+bounces-31335-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMnFN72Oe2kKGAIAu9opvQ
	(envelope-from <linux-wireless+bounces-31335-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 17:45:49 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B303B2631
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 17:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2B5A83002D28
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 16:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA46678F2F;
	Thu, 29 Jan 2026 16:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="SmB64HbP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CBE2032D
	for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 16:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769705143; cv=none; b=uUUIct1CvWx/HXSaX+glQmfvHlXyncCLoiT/Gdz2b/eM3s37Hu0aX/wSBJ/ungra8omW/9wzutCYRtlwc0Nwku81CZooeGmdvG8pKNiFmmByGL4Kec19s016k6lwy3ujsaene3jxb1mPTP/+QAh8sayeCTqkZ9RV8/ibwL8YKUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769705143; c=relaxed/simple;
	bh=/65uhVzX3+tALM4U2l1UT9ePStTpDUYc8dwBuT3T0wY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uTfguW0PfHr28IkRZC1R/jb5q8bHNEyLvZQ7HYiXwRPWmrOTXJh4p1xG5LYfcYGiNumqVzPLN8kAXaMUbH+P31PBl3GSvCq/Af3Ge9qmxzfpKi4TakXTEUe7A9/TUsOxiEUtJtjxU3WK8sVQf2I3QFPcvn/+8kvYoEV+nlX/8NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=SmB64HbP; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=9hJeJFRtYC5M0a20NG84oRNVv8AOpwpuEnlFUCGcC5g=;
	t=1769705142; x=1770914742; b=SmB64HbP9l1EmtC6Fdkk7A33WFHpzqK4hMYhRI8YVYcpHJi
	DbK2Q+MXmrGbfTK3peDKAeGvPErAqfT8AztDXLa0RbRtc9kG7oLpVz7MlhQa05WJMMoEYzwy9Iic2
	GPu9L2ngYuf1eF1ykje9XG+9d9919TYAvy25sO4oFfUzmlcSxz+BCiFUwbNdum5gIac2enZE6I3qV
	aDuC2rBDCuYPrQfNye19hXlIylN74H0k7ig/H7nF2HTtpbl1Xix9uz+UhyokLfNbCtiAwG4lLzSRd
	Sjz980Cii/K05vH3FSaoOCiQpQ+HavmBeNDD1zGqEc42G5rY4PlyE8zgMBgOSRyA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vlV9H-00000006xxa-3Iis;
	Thu, 29 Jan 2026 17:45:39 +0100
Message-ID: <0d07eb7e74de33ff36fa11efde1323c3f81fb0b3.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v5 3/3] wifi: mac80211: add initial UHR
 support
From: Johannes Berg <johannes@sipsolutions.net>
To: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>, 
	linux-wireless@vger.kernel.org
Date: Thu, 29 Jan 2026 17:45:39 +0100
In-Reply-To: <104f3cd9-581c-402e-b4c3-898f1deaef5b@oss.qualcomm.com> (sfid-20260129_174406_583854_1A7C0963)
References: 
	<20260129092039.53d7f326bc8f.I5b11fb0345a933bf497fd802aecc72932d58dd68@changeid>
	 <20260129092039.09be5776db3d.Ieec940b58dbf8115dab7e1e24cb5513f52c8cb2f@changeid>
	 <104f3cd9-581c-402e-b4c3-898f1deaef5b@oss.qualcomm.com>
	 (sfid-20260129_174406_583854_1A7C0963)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31335-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,sipsolutions.net:mid,sipsolutions.net:dkim]
X-Rspamd-Queue-Id: 0B303B2631
X-Rspamd-Action: no action

On Thu, 2026-01-29 at 22:13 +0530, Karthikeyan Kathirvel wrote:
>=20
> > +		if (ieee80211_uhr_capa_size_ok(data, len, true)) {
>=20
> here it should be false isn't it ? since here UHR cap processed for STA

I _think_ I've been consistent in that 'ap=3Dtrue' means it's processed
*from* the AP?

johannes

