Return-Path: <linux-wireless+bounces-30900-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF06ED2DE81
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 09:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D11063035A84
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 08:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA9E2F5461;
	Fri, 16 Jan 2026 08:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="WMByAKQO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98E82DB7B5
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 08:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768551469; cv=none; b=No0Fz+hqyPxHP89fs+C7kDPCCX9M6QgvFT6IAqEOV3Vewu2cncE2N3e/LhEP/EbLOEAItNdpPzear+obF9P4o3XxK+qDMwQmH+tN3XSN/QC+OuhHzcoEAAMIpgbfcvpNi8qmyxiM7bTQVhbiBu8Ap62o/0jrSLqQA4RtagrjVH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768551469; c=relaxed/simple;
	bh=r8EC3nznQQtDHRD3AB8WPeaDSOKHJzvu9fNtVddTDxE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SvKQuwIIoAg99ZSiiQJT3PAW1c63++ijXAuqzxCyfjj94S4Blwb1/YlxPAh5dblLkEwtEsn2XycZAQP2NeFQPWSbkIEXI1FmrKDuomZ8Q1go9GXJJZt2M2LXj5F8aUNJmN1eV24Mv6EG03haY11u56Y1gjH36bInzzt6smkftGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=WMByAKQO; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=r8EC3nznQQtDHRD3AB8WPeaDSOKHJzvu9fNtVddTDxE=;
	t=1768551467; x=1769761067; b=WMByAKQOtRqETTylOUVdlPzALrXEX3v8B5WBef7EK2U+Z+N
	610UMBErMdOObwfBYwtMrxA0ZSt4Qx3PikKjE7J6G80iKubFP814PvFeMuzJSDByGoCi8NAaV66a5
	2msmjcYqwBex3DYawhOQebUypsAzIw8Eg2bb7a3MxsDtguJFSKcuVm0KXET/qlvU0+Jz4KvHSf0/1
	iC1eMlEohiq0f0Kmc2oo8VkzIgMmfJr7JYvnZzhd/bkflCd9zVYbuNfOIg5vSYss+0bw6wZ7ZG1FT
	t592zMk+QqzoqDXJFNO2pzbZbyBgbo5ca34ml3YuVJrptldN4zh9r3ZI+sBCRNuA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vgf1c-0000000DKpG-1MFx;
	Fri, 16 Jan 2026 09:17:44 +0100
Message-ID: <4f8e174edf63c00f3c277e86e7de472fb7520422.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v4 0/9] wifi: cfg80211/mac80211: Add
 Support for EPPKE Authentication
From: Johannes Berg <johannes@sipsolutions.net>
To: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ainy.kumari@oss.qualcomm.com, 
	sai.magam@oss.qualcomm.com, quic_drohan@quicinc.com
Date: Fri, 16 Jan 2026 09:17:43 +0100
In-Reply-To: <20260114111900.2196941-1-kavita.kavita@oss.qualcomm.com> (sfid-20260114_121913_253851_D5948AC7)
References: <20260114111900.2196941-1-kavita.kavita@oss.qualcomm.com>
	 (sfid-20260114_121913_253851_D5948AC7)
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

On Wed, 2026-01-14 at 16:48 +0530, Kavita Kavita wrote:
> This patch series introduces support for the Enhanced Privacy
> Protection Key Exchange (EPPKE) authentication protocol, as defined in
> "IEEE P802.11bi/D3.0, 12.16.9". The implementation covers both AP and
> non-AP STA modes, with clear separation in the commit descriptions.
>=20
> The changes have been validated end-to-end using the hwsim tool.
>=20
> During development and testing of EPPKE feature, we encountered an
> issue in mac80211 related to incorrect AAD/Nonce computation for
> management frames when MLO address translation is involved.
> Depends-on: [PATCH wireless-next] wifi: mac80211: Fix AAD/Nonce
> computation for management frames with MLO
>=20
> Without the patch, EPPKE functionality will fail for MLO connection.

Because of that, I've only applied patches 1-8 for now, so the feature
isn't enabled anywhere until we fix that issue.

johannes

