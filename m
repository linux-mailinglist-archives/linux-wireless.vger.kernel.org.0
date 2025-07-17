Return-Path: <linux-wireless+bounces-25607-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 979E6B090F3
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jul 2025 17:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCE0B17FBB0
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jul 2025 15:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE88635963;
	Thu, 17 Jul 2025 15:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="irQUxr+7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E28C2F94A5
	for <linux-wireless@vger.kernel.org>; Thu, 17 Jul 2025 15:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752767507; cv=none; b=opFGuDKk15+7dV+UWYgTiANamlFDXdoe0ueb/bxdO9O9Qm3jNNK3EnN/mIZuUMDAM8LxByqqrWDCBGCkHIbJCrpq2xp4t27xnI8fuUiIRDjo9uAqUnXZ2Sgwl4v7ObKE0RaNNskXCIwjNIeM3qcZY/VicPVUn+N2BN5XbxdJfAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752767507; c=relaxed/simple;
	bh=V3iWEesYKQXOVuFQuTfoQdbC9dKoUqXHImg/IieJnh4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NzTs0DKTE+3pKs7WDNko0gfnOyaFpCDBc5ayS7J9vHEr2ZNdwTpAEI/MXmBHoc4JgxM+D82fb4PLEybu7WNs0XLSc6jPhcsJgnwroy939aRtwd2jazbapPfeYhXP+Cu3n0GSZo3x3ZOhlPKEmoS2pv16jo1IuLCfaABPDqvsznw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=irQUxr+7; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=+y/MvOuVIOTB6PU9Sc1+tBFRe99tNLCkZbcc2og+AwI=;
	t=1752767506; x=1753977106; b=irQUxr+7xzqXLL12doAJLCfY9yre1CYTbtINQMleXgjykhS
	2uc3CmjsWAZK8hbYPApDiwP7JuQv13GC+Odfqg7nS5h1RXuGMBXgVXmGLRYx+vHOeGPbhdrPuPpbh
	c4M8GqguEyPzQuZlP7KNUM5U2xyYtX/RrCZhzuQcGfEFjBpbdrLlsNRNS/NECd0oa5qLTQPKybBS+
	HmqddJeWyTTw2EBABD9gO5RBMWK2M6eaxQ0OXCZTZ/6rykwGsjh4iTltIjIOsMh1I57lviiJ0BYBz
	tZMgGPsrhngqGplWOj6OJmAwgeUR6R+eF0tcXbpf3d8z9TzTxDVnrnSrTW2mKIEA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ucQtY-0000000Ap75-2a8R;
	Thu, 17 Jul 2025 17:51:40 +0200
Message-ID: <fd87876c41346070ee6a3218b53e0864c038e731.camel@sipsolutions.net>
Subject: Re: BPCC in per-STA profile in link reconfiguration response
From: Johannes Berg <johannes@sipsolutions.net>
To: Mohan Kumar G <quic_mkumarg@quicinc.com>, Mohan Kumar G
	 <mkumarg@qti.qualcomm.com>
Cc: Yuvarani V <yuvarani@qti.qualcomm.com>, Manish Dharanenthiran
	 <manish.dharanenthiran@oss.qualcomm.com>, Jouni Malinen <j@w1.fi>, 
	hostap@lists.infradead.org, linux-wireless@vger.kernel.org
Date: Thu, 17 Jul 2025 17:51:39 +0200
In-Reply-To: <95f682da-8be0-49fb-875e-4200ee348903@quicinc.com> (sfid-20250717_111108_837148_1585D44F)
References: 
	<aa29ba3015d533796516a1fcf8036aa1e0090624.camel@sipsolutions.net>
	 <95f682da-8be0-49fb-875e-4200ee348903@quicinc.com>
	 (sfid-20250717_111108_837148_1585D44F)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Hi,

> As you mentioned, this commit was initially intended to fix ML Probe=20
> Response, which is why section 9.4.2.322.2.4 was referenced.

Right, makes sense.

> However, after reviewing section 35.3.6.4 =E2=80=94 which says that the
> Per-STA Profile in the ML Reconfiguration Response should be the
> same as in the Reassociation Response =E2=80=94 I agree that it makes sen=
se
> to include the BPCC in this case as well.

OK, so I guess we should have a hostapd patch to remove the comment
there about not including it. Do you want to do that?

> >=20
> >   2) Are you aware of any APs that don't include it, which would mean
> >      regardless of that, mac80211 should accept both?
>=20
> As far as I know, I'm not aware of any APs in the market that don't=20
> include it.

OK, cool, so at least we don't have any knowledge of this being
necessary.

> Maybe people in community can comment on this. If such APs do exist, we=
=20
> can consider accepting both.

I don't know either, and the only reason for now would be to accept it
only because of the spec inconsistency, but I guess we can leave it for
now.

Thanks!

johannes

