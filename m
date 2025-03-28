Return-Path: <linux-wireless+bounces-20924-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C17CA74655
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Mar 2025 10:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A32F1B60EA2
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Mar 2025 09:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B470E2139D4;
	Fri, 28 Mar 2025 09:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="m40ZuZeP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AA3213255;
	Fri, 28 Mar 2025 09:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743154009; cv=none; b=WtiQvKRmtNNIm5fcrvxccc7vhqJ1bsRzczHS8FnUs0RYTJj3upxPsfmUXoesZ3iN3p2AjLIqhna3Z2/9S8IWGohrV2TkMcI0acesNGVcTz8Ypil3GWfbPve7II72dQKSgOY0X1ibFlaJdzg2Jyrd399PTYJz1HnppofRR0x1Zvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743154009; c=relaxed/simple;
	bh=1i1NNF0+dJuPsu0zM6k4JXoUvkDU2r2PCmFqa89RDvM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WGqtsA2BYX9yeI+50pPnbaBiy29KOLExFo3jRBSRThPDw/qSTDVSBfXZEhXIYNd8a7XOg+nMRodK96ADUfIyj7Na8rd5s1pP6fyCOsBZ59MS1oxA8hFJ+77OfOqwlrqIkMyLwcAAIZEkQ6W1Di0EXaS1aJOEI1WzDHxGf+cAJC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=m40ZuZeP; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=1i1NNF0+dJuPsu0zM6k4JXoUvkDU2r2PCmFqa89RDvM=;
	t=1743154008; x=1744363608; b=m40ZuZeP3cKiT8K4FT5rqL7JjObW5Ev8aLy+YPoOhkzX6lo
	kIbOa2e/ryuKDFb7QPmbEdjGYuwNEoKJq7l962ENqsrJHhUQIucJgeEI/7Q3hf4K+hBcVpLXBrcQH
	Y03iNJ09pvVdECgXK6ZUnNdNwmMD+dlNEav/USLKJy4ewBXYUG+hxp7z4AeEuSULb+W8p9vhBK0Cl
	RWZPOM95egKKO0hLBXF99VXPCq2mOyVoJ1vBWVdsuMJ9vgIAqu08L6QWqKSo6TMKaeUKVRDcZnX4v
	Oeg5spA/Y5mzRO4eSavbNwN69GRHAcGszJta4xu4dJHAs5WOFCLcN5bLDRH6Q39A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ty5yy-00000008A1x-2ahc;
	Fri, 28 Mar 2025 10:26:34 +0100
Message-ID: <5f6aba8a6c6e04fc118fd3b5679f534ef28adf7a.camel@sipsolutions.net>
Subject: Re: [RFC PATCH] wifi: mac80211: Replace strncpy() with strscpy()
From: Johannes Berg <johannes@sipsolutions.net>
To: I Hsin Cheng <richard120310@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Date: Fri, 28 Mar 2025 10:26:26 +0100
In-Reply-To: <20250327141108.182585-1-richard120310@gmail.com>
References: <20250327141108.182585-1-richard120310@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2025-03-27 at 22:11 +0800, I Hsin Cheng wrote:
> The name of vif which is "vif_name" should be NULL-terminated to be a
> valid string

And why should it be a "valid string"? This is just a buffer here in the
trace code. We don't even (and cannot) suggest how to print this, so I
think the userspace tool that does will just need to be careful, as with
anything else. Don't see any issue here.

johannes

