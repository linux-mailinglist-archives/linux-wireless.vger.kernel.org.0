Return-Path: <linux-wireless+bounces-28640-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2334C3811A
	for <lists+linux-wireless@lfdr.de>; Wed, 05 Nov 2025 22:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13FD53AFB01
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Nov 2025 21:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8148921CC6A;
	Wed,  5 Nov 2025 21:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="K4WEAYPN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBA0225760
	for <linux-wireless@vger.kernel.org>; Wed,  5 Nov 2025 21:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762378116; cv=none; b=d9I5S2fuY47I/OKlORPY442RVc5TIMy58iUl+PPaPxZlZ3x79QD8IS34ZKbpM4o/+QSnPRDDweBtF8BGvG0k9xbheYDHxYWTFHOxnTTt2nZMBBzxoGwONitaAFMEPATizOQxtSRtE72mB+RpYhaZKa4PHhxorz/0oXYVDtfAwBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762378116; c=relaxed/simple;
	bh=iGgQM1NUA/jBnzd1959ic7ko5gicd5Yv3iA0lVN3Yls=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OMLc0Rnppv2twctvcyiy5SjYQ6oyzLVPP1n8v3fOKAwhV4VJ5sb5Xa9CJEKp2dwYNJERqykqIA3WCfgjkG9PRS83uDN8CivkZmk25E5xQMBquy6ppQTvx/Yc7tWtVEJKfHSs7WDLfIcIRUncY4g2PcwybAweDIEmvS3DniLsVPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=K4WEAYPN; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=iGgQM1NUA/jBnzd1959ic7ko5gicd5Yv3iA0lVN3Yls=;
	t=1762378114; x=1763587714; b=K4WEAYPNqSdDzKqRBc8nixIxY4g77ZHG3f3gfyt2wa6J+B9
	yDixCZcdkk8v/bx968MFNUjObl5oJfULLW3nPlTgSP7UVXe68BnWBBf1LOvlgdBxLmQOQgUKSk1dS
	cTiz0i5uuLkm/Mnz+HiA4GkNDeydncp+g7BIZExUMtEjnsqldhZW9CG6pI8DT097GI+jb7CnlGb8z
	yXwdS97G9HyvRKVwM9a3UZa372QZ5zyVFoVI2gd8+fYe80qmCo+2AsXMdhweMjTy1bFMX57ydnGpI
	PGbsUnAvB6Cjhw2w47O2uS13FrjwoqzPAsIM8jOxKun1IWEJomRIjPCB+bCseRag==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vGl3N-0000000FsAo-1Eiy;
	Wed, 05 Nov 2025 22:28:29 +0100
Message-ID: <f7eb31d19a013f9d1375db5db6b1423d1b2ac36f.camel@sipsolutions.net>
Subject: Re: [RFC][v1][Design] AP Architecture for Roaming with Wi-Fi 8
 Seamless Mobility Domain (SMD)
From: Johannes Berg <johannes@sipsolutions.net>
To: Aditya Sathish <quic_asathish@quicinc.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, 
	hostap@lists.infradead.org
Date: Wed, 05 Nov 2025 22:28:28 +0100
In-Reply-To: <ca61c6dd-b1a6-4f5f-aff1-341a8c5f88c6@quicinc.com>
References: <fbf4209c-4fd8-4047-96d7-7fa34d9ba44d@quicinc.com>
	 <c618e0e8fdee9f7aa2628aefdf2dc04c48e6e9b7.camel@sipsolutions.net>
	 <ca61c6dd-b1a6-4f5f-aff1-341a8c5f88c6@quicinc.com>
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

On Wed, 2025-11-05 at 13:26 -0800, Aditya Sathish wrote:
> Continuing on a message excerpt I missed from Johannes' earlier response,
> since it is in a similar vein to Benjamin's response:
>=20
> On 10/12/2025 06:51, Johannes Berg wrote:
> > That's not _really_ a good argument though - mac80211 will likely have
> > to process this in process context, likely acquire wiphy mutex, etc.
> The ST Execution sequence =E2=80=94 which includes receiving the ST Execu=
tion
> Request, sending context, receiving a status code from the target AP MLD,
> and ultimately sending the ST Execution Response =E2=80=94 is largely cli=
ent-
> driven. It primarily involves parsing management frame content and
> handling context data embedded in the skb as extensions by the vendor
> driver.
>=20
> From the target AP MLD side, we do need to access the generated group key=
s
> to include in the ST Execution Response to the client. However, beyond th=
at,
> interaction with core wiphy data structures is minimal.

Fair.

> While it's likely that mac80211 will operate in process context, if our g=
oal
> is to minimize latency as much as possible, we believe it should be feasi=
ble
> to implement the ST Execution logic without acquiring the wiphy mutex. Th=
is
> could be achieved by isolating the ST Execution path and leveraging a
> high-priority workqueue, thereby avoiding unnecessary contention and
> improving latency. However, this is, admittedly, dependent on the toleran=
ce
> for complexity in the mac80211 versus the demonstrated benefit - which is
> something we are gathering experimental data for.

There _is_ a possibility also that nl80211 operations do not need to
take the wiphy mutex, though of course that might be more complex.
Probably less complex than pushing everything into the kernel though :)

But yeah, I think data on it would be the best way to settle it.

johannes

