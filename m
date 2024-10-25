Return-Path: <linux-wireless+bounces-14553-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70DFB9B0A26
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 18:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CA7D1F21214
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 16:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086DA189F2F;
	Fri, 25 Oct 2024 16:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="xujGiWMJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD51170854;
	Fri, 25 Oct 2024 16:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729874509; cv=none; b=UGC4o1P2CzVHJni7MhbH5OcVCzOJ+56kVbXrBfnsTgYjrSTJjRkQPgwM2LY9fbAtjSWSz9WalAfVBJqgFSBVYeecfFdN4PZTM+nt6RnvLbyy7TDLOpzA+eDrkKxKK8N++XlP/2ri/vzMzufasrVbHhCIKgzBNtBMwx6C4y/3N28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729874509; c=relaxed/simple;
	bh=nNZLzG6TnBP/pPvPcHyPOR5Kiaqa/YGI4mMwJC3LSF0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gAu5/5TLrc+sXc0Bhfq6gIlWDLp92C2NfHrabfRhPxfW6enFqE3/fST3S9V6cAP1EHeA3WGINqgbFaq28LMuNsoo/yPCawdv29bZGxZK0nzBq5t8qHA8ufTh/5DsQKsD/3VarZKS9udnp14Tc4tyNHP4OnuJ4uvypcbza+/KZ6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=xujGiWMJ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=nNZLzG6TnBP/pPvPcHyPOR5Kiaqa/YGI4mMwJC3LSF0=;
	t=1729874508; x=1731084108; b=xujGiWMJqgHMlNAMh/xt16X+2Kq4QkACitIPEaha0R2CZAb
	a4Zsod6Km6o/8IKly10tcprku1XZoGQpDw/Ebelp/ubtfAzHlI37OjkLYw10O0GyFghePzvcOYZT5
	QJLhv3XwiUSWOnhE1Iowxuat4NGKTnKkbT/Jvmny3lTYlg7dzdTJEH1ZB4R/qMyt2vf7Ny8pyLu8W
	89Qitn3VFEjlKIFiLHFiALg7XWLHHLymtq94x4wkhon3qRttlEHIsPCpUEflOVl5avsPOgQAoQkBb
	TDP622IPaDXW1C0hsM2D1CYyKln5jy73onftyWVrLwwvjKmFO7H6oQbFVj75VPbQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t4NNN-00000004cQf-0N80;
	Fri, 25 Oct 2024 18:41:28 +0200
Message-ID: <afe1839843d8d4dd38dd9368b2e30f0aa6864b9a.camel@sipsolutions.net>
Subject: Re: [PATCH net-next] wifi: trace: Replace BOOL_TO_STR() with
 str_true_false()
From: Johannes Berg <johannes@sipsolutions.net>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 25 Oct 2024 18:41:05 +0200
In-Reply-To: <20241025163210.1395-2-thorsten.blum@linux.dev>
References: <20241025163210.1395-2-thorsten.blum@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2024-10-25 at 18:32 +0200, Thorsten Blum wrote:
> Replace the custom BOOL_TO_STR() macro with the str_true_false() helper
> function and remove the macro.

That's an inline function, I don't think that works - you'd have to
teach trace-cmd what it means?

johannes

