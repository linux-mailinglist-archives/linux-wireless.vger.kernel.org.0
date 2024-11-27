Return-Path: <linux-wireless+bounces-15749-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 361E99DA4A0
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2024 10:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0C34281FA0
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2024 09:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63EE190685;
	Wed, 27 Nov 2024 09:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="dU6HQfRK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F0A47F69
	for <linux-wireless@vger.kernel.org>; Wed, 27 Nov 2024 09:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732699038; cv=none; b=OkXIzixZCz73r+bBlPpLs/OOKU2nwlLSWu/ub1YEdMK4lIIt0T7fIeELu3w5G4Pg83T5FKy7ljqUe72kUiO+AO3tK1ofk99smgRRcYCXmk50ZHBA2jcahQer0iCgm4JWeKzZrsgkMGLfE1Qgh2CliDkzdi3Rj86p5ave4I+VZ+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732699038; c=relaxed/simple;
	bh=yU8VnIfd9ueAtH1yvZwh7LIae02ywSDhelW2p3GAyQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JlT9cGmKvqt2dHPyvMT03FmLCdwjcp6hIJSFgbymtO9TQrH0bRU7yi28Tp84NUF3mPqzbZQdJkrrLaaVvHnBCLbEi7rqtOYfyaMDiY5FBwcFGozkSmqBkJ5MxHOtXK4dGI0yxxiMPmN3DjQ2ImBKHS9swoKCOuQPriszAvVLEmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=dU6HQfRK; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=OYZy7hV2grEDsvvjkCO6Oerw6OCHBUCsHWSuOpP9xZ4=; b=dU6HQfRKLocWkfu3bN96PlWNOm
	V5rCsvmUKB2BP08HyEvyvCSROBHwZ68RygtfEegQDqoh8A/Ue5kaUpDSDJmn5lHLxDmeGLNAyFJte
	hknVK/YUMddkDHSL7AdiIRoKiRPL5QKFJQ2RAMeCESdMUvpbDJoaq5I3ad/vTrPtOgx29XNSw8k6G
	YpoF+YRfsJGfoji633lk2HEh0iaVoY6k78ysxfE5ksLRSbIsYbnUHB14Kdy5te59whd12QP/xXfoK
	1A0HEtnE/3qOUWiuhyiyQ5poL4wbZm2JlqWZ7298vDWt5fT8gQ/3gs+fE4E47sCvVqaoGnrCzvXLs
	cFbQMjPg==;
Received: from 179-125-64-246-dinamico.pombonet.net.br ([179.125.64.246] helo=quatroqueijos.cascardo.eti.br)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tGEAa-00DXWb-E1; Wed, 27 Nov 2024 10:17:13 +0100
Date: Wed, 27 Nov 2024 06:17:08 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	Kalle Valo <kvalo@kernel.org>,
	"kernel-dev@igalia.com" <kernel-dev@igalia.com>
Subject: Re: [PATCH 1/4] wifi: rtlwifi: remove unused check_buddy_priv
Message-ID: <Z0bjlC5kU5Yk8Puy@quatroqueijos.cascardo.eti.br>
References: <20241122172718.465539-1-cascardo@igalia.com>
 <20241122172718.465539-2-cascardo@igalia.com>
 <65b5fa04242744bc93e26a137f1fbe58@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65b5fa04242744bc93e26a137f1fbe58@realtek.com>

On Wed, Nov 27, 2024 at 05:32:41AM +0000, Ping-Ke Shih wrote:
> Thadeu Lima de Souza Cascardo <cascardo@igalia.com> wrote:
> > Commit 2461c7d60f9f ("rtlwifi: Update header file") introduced a global
> > list of private data structures.
> > 
> > Later on, commit 26634c4b1868 ("rtlwifi Modify existing bits to match
> > vendor version 2013.02.07") started adding the private data to that list at
> > probe time and added a hook, check_buddy_priv to find the private data from
> > a similar device.
> > 
> > However, that function was never used.
> > 
> > Besides, though there is a lock for that list, it is never used. And when
> > the probe fails, the private data is never removed from the list. This
> > would cause a second probe to access freed memory.
> > 
> > Remove the unused hook, structures and members, which will prevent the
> > potential race condition on the list and its corruption during a second
> > probe when probe fails.
> > 
> > Fixes: 26634c4b1868 ("rtlwifi Modify existing bits to match vendor version 2013.02.07")
> 
> This is a cleanup patch, so I don't think we need a strong Fixes tag. 
> 
> 

Well, there is a real bug here. Since the private data is not removed in
the probe error path, a second probe leads to the corruption of the list.
But since that list is not used for anything useful (the check_buddy_priv
is removed as part of this patch as it was never used), instead of adding
the list removal in the error path, we simply remove the entire list.

Thanks.
Cascardo.

