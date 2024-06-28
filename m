Return-Path: <linux-wireless+bounces-9686-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE3D91BA9E
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jun 2024 11:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 500E01F24594
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jun 2024 09:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC6114EC4C;
	Fri, 28 Jun 2024 08:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="oDu0HWje"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A86B154420
	for <linux-wireless@vger.kernel.org>; Fri, 28 Jun 2024 08:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719565189; cv=none; b=Zw6z3Uq/sT8XeJFt+Nf1IYQNsPebe5IeFB/+hwXw8UBAj8h7LlOJkmrQU/Q7HQiIk9NLVUoXnD0pPXsN9seK6MeEQH2v0gLJ7gl+m275T/3/DxV09toE/vKf3KYRLJni4lf62GKhgx7O+PFmNUdf0qjr/x2Qz7LvuSM+dG/xV2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719565189; c=relaxed/simple;
	bh=wR3DqYYLCdwo0i2VmLqhRCsHO+QKESwSY3RwvczqvIg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cJfwzfUZEAAbZSZVOLQiyCQs4EXEO9zsmEN2eMk46QCt/++pKB8v2D4KwDwfw1zIoQxweDvYNOV+kWuwNRMzl+AtzV1jXkS6vZ/BNNQcyzTlOWGfj4JdJGt8DvjfNOhJ/9hXSYWtk0PevbM4srjPelgbnFOrScB4t1IS67d+sHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=oDu0HWje; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=v6Ch0YZOio7c5n9ilLbqDEUfrkVA/kXga6MUKdEpYPA=;
	t=1719565178; x=1720774778; b=oDu0HWjew4GEe3JrP1fIBpvO7AlcL+RsRBN0ba9Em9j+ruN
	vDvdaLo1CaJ0b8uTM1sa7i7NFevXIlVlyLFHapcZk4TGm9iD1/nQsARK8Tnb9QBNhdtoX+xBXNfGg
	TxZX68dLQInnnIyEy2W45EkTCpYAcgsED2nLrmcaRL76MLZE6U6bcdBl4mqPy4bpxkdaSYkQHrwiN
	8X+KvolLYEvFBSxJmK7YcRyLvX+1Ch0bNIeFr++MMNRdgpuVTy6fc379tAheSxOVZFPG7Jn8PV0XV
	KG9wPM9LM5NLTFpbFk/qniq9OGvowVBIXCc6XTV9frIVvwP0jZwKnhYIaTI9AY6g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sN7S5-00000009aEZ-3C8Z;
	Fri, 28 Jun 2024 10:59:30 +0200
Message-ID: <a9d518e9c53ed8e36bbb020b3eb3dfc4c8de772e.camel@sipsolutions.net>
Subject: Re: [PATCH v2 8/9] wifi: mac80211: handle
 ieee80211_radar_detected() for MLO
From: Johannes Berg <johannes@sipsolutions.net>
To: Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Fri, 28 Jun 2024 10:59:28 +0200
In-Reply-To: <8117e952-e189-41d6-9ed2-ed10d96f3b51@quicinc.com>
References: <20240626045216.3754013-1-quic_adisi@quicinc.com>
	 <20240626045216.3754013-9-quic_adisi@quicinc.com>
	 <9cf07d0861d6c8ee8a2004361a37a3ebb9860ea9.camel@sipsolutions.net>
	 <8117e952-e189-41d6-9ed2-ed10d96f3b51@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2024-06-27 at 09:38 +0530, Aditya Kumar Singh wrote:
> > Couldn't we just have a flag in the channel context or so - there must
> > be one, after all? And perhaps pass the chanctx from the driver instead
> > of the channel?
>=20
> Not really. So this linked list thing came into picture for drivers=20
> supporting split-band 5 GHz wiphy and both of them are grouped together
> for MLO. Now, each one of them will use different chanctx as such and=20
> there is a possibility of radar being detected simultaneously.

Right so ... I don't see how that answers my question in the negative?
You necessarily have a channel context for each channel you're listening
(even for radar) on [unless you have the extra radar chain API thing],
so if radar is detected, can't you just set a flag in that chanctx and
kick off the processing?

> Could do but, logic in worker will be little bit complex?
>=20
> for each ctx in local:
> 	if ctx radar_detected flag is set:
> 		append to local ctx list/array
> 		num_ctx++
>=20
> if num_ctx > 1 :
> 	if wiphy supports mlo:
> 		for each local ctx list/array:
> 			call cfg80211_radar_event with the ctx chandef
> 	else:
> 		warn that mulit channel is not supported
> else:
> 	call cfg80211_radar_event with the first element in local ctx=20
> list/array chandef
>=20
> -----
>=20
> This is because, in split-band devices, ieee80211_radar_detected can be=
=20
> called simultaneously with different channel contexts and then there is=
=20
> a possibility that before worker gets a chance to execute, both of the=
=20
> calls have marked their chanctx radar detected flags.

Yeah, but no need to make that complex - simply doing

for each ctx in local:
	if ctx radar_detected flag is set:
		call cfg80211_radar_event() with ctx chandef
		clear ctx radar_detected flag

no?

You don't have to restrict the worker to processing a single one, in
fact you must not since scheduling it again while scheduled (and not yet
running) won't run it again. And if it races then worst case you have a
worker run that does nothing?

johannes

