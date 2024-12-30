Return-Path: <linux-wireless+bounces-16904-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7ED19FE9E5
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2024 19:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D72C43A2A74
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2024 18:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C5215746E;
	Mon, 30 Dec 2024 18:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M76ZiBZ6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBACEAD0;
	Mon, 30 Dec 2024 18:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735583727; cv=none; b=uhd+p0vC1zBNXSFBlKQDpA2FBM8i4vL79PGf3K3ts6CFc84ulBLcxaHtalHVJf3u1Ovx6jHTk6To9bawdO9byVOwP891xyjR/GkmiQfHYtIDxAbwxrCo1yaYClSmdg9Dr3w7So54ehKAP3SBzBE1OVam0nQROigj4f8yQTPuiJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735583727; c=relaxed/simple;
	bh=zwDNZZ12ROo3lHb0+PRLe7IckEi8MMjuQAn4UZi1DZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ffsR0Twt2FEcY+cw7kzmOwGj16yQ1UVHe7VxpuyRH8tLoM7eTNDp24NgpmQOsl1v+aJyMtisJfa7kFH+7/dZXbHecsQGfmOlHctmv14nJaKIKzjFqJF3GlhIoLxQpBdMFYNPSADNHvHh/HSdVHQR2RJp/vgOgRMtne1UxuDmYVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M76ZiBZ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECC2BC4CED6;
	Mon, 30 Dec 2024 18:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735583727;
	bh=zwDNZZ12ROo3lHb0+PRLe7IckEi8MMjuQAn4UZi1DZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M76ZiBZ6GaqsxRTU+yv9vR06ujnT3fU/qqzbAG7DMv6ypQVCUXpOWPWWhN1Oe97bZ
	 u05HPPpbAICK556leBaETCdjm1OmXgVRSYelZwixvRMUxNd4HBcahuF+ywol/gLlpM
	 R8GiK0SluXy8f93pIWirjY2W7gPHRBFliQjGyU0VwVDo5i7U/ScDR3duaYGGgh48Wu
	 WQA5mzglMGdDZkwjBFKobWXYQW23uhPFh5rODCgdEtXXMOZUbSpDTkADnjEsooxIyE
	 uxKTKMTdAAjAUdx7o8oj3KEIdlrqDQ1Y2JHWJELQNmvamABJDHTp/+yk1lHotJhlyE
	 i0rqr9NrbiYZA==
Date: Mon, 30 Dec 2024 10:35:23 -0800
From: Kees Cook <kees@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: John Rowley <lkml@johnrowley.me>, johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org, stable@vger.kernel.org,
	gustavoars@kernel.org, linux-hardening@vger.kernel.org
Subject: Re: UBSAN array-index-out-of-bounds: cfg80211_scan_6ghz
Message-ID: <202412301022.BCAC61BD6C@keescook>
References: <1815535c709ba9d9.156c6a5c9cdf6e59.b249b6b6a5ee4634@localhost.localdomain>
 <20241230053806.GA129354@ax162>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241230053806.GA129354@ax162>

On Sun, Dec 29, 2024 at 10:38:06PM -0700, Nathan Chancellor wrote:
> Hi John,
> 
> On Sat, Dec 28, 2024 at 11:21:27AM +0000, John Rowley wrote:
> > Hi, I'm experiencing UBSAN array-index-out-of-bounds errors while using
> > my Framework 13" AMD laptop with its Mediatek MT7922 wifi adapter
> > (mt7921e).
> > 
> > It seems to happen only once on boot, and occurs with both kernel
> > versions 6.12.7 and 6.13-rc4, both compiled from vanilla upstream kernel 
> > sources on Fedora 41 using the kernel.org LLVM toolchain (19.1.6).
> > 
> > I can try some other kernel series if necessary, and also a bisect if I
> > find a working version, but that may take me a while.
> 
> This looks related to UBSAN_BOUNDS and the fact that version of clang
> supports the __counted_by attribute. I do not have much time at the
> moment to look at this but I have added Kees, Gustavo, and
> linux-hardening for further analysis.
> 
> Cheers,
> Nathan
> 
> > I wasn't sure if I should mark this as a regression, as I'm not sure
> > which/if there is a working kernel version at this point.
> > 
> > Thanks.
> > 
> > ----
> > 
> > [   17.754417] UBSAN: array-index-out-of-bounds in /data/linux/net/wireless/scan.c:766:2
> > [   17.754423] index 0 is out of range for type 'struct ieee80211_channel *[] __counted_by(n_channels)' (aka 'struct ieee80211_channel *[]')

This is this line:

        request->channels[n_channels] = chan;

and later:

        request->n_channels++;

Patch should be:

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 1c6fd45aa809..ccdbeb604639 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -763,12 +763,11 @@ static  void cfg80211_scan_req_add_chan(struct cfg80211_scan_request *request,
 		}
 	}
 
+	request->n_channels++;
 	request->channels[n_channels] = chan;
 	if (add_to_6ghz)
 		request->scan_6ghz_params[request->n_6ghz_params].channel_idx =
 			n_channels;
-
-	request->n_channels++;
 }
 
 static bool cfg80211_find_ssid_match(struct cfg80211_colocated_ap *ap,


-- 
Kees Cook

