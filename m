Return-Path: <linux-wireless+bounces-11348-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB44D9502D1
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 12:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 099BD1C21722
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 10:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7454918991F;
	Tue, 13 Aug 2024 10:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bHMJSm1z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461D776025;
	Tue, 13 Aug 2024 10:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723546111; cv=none; b=jdfYZyqaLGU/3MO/mtKn3tiGUQ8JV36w+pj+oFi5QLuxBXB41nJEVA/YiVcgsTo6/nrW+CsNVv6B24I8GwtrykQjkMSAIThB511mMBegj1QnMc7ekyIUJhPs5tx2IxVs9tlxqKlECVRVkEdBUCKJ0wtiXcBRfubIkHdHBacFycU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723546111; c=relaxed/simple;
	bh=xSKWN1O6/DzG5D1crCsxvlcTo70Zzn+xL9TqroUdSqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Is29AXDPe9lTOhS980LCuLgoN9p/4Fgul+Nx06fy+weJQoWsJY4nscQzDByn0ZApOMtRuDDYaL72QLGMn5lWeRnwJivYIGTfsNsng5k9/2tnKMVyP02Bw/IYE4/ypSUEXZgqMvOvInqbl3JuSp6cav0cBJITPz1ndpCZFa8u3I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bHMJSm1z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 513DDC4AF09;
	Tue, 13 Aug 2024 10:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723546110;
	bh=xSKWN1O6/DzG5D1crCsxvlcTo70Zzn+xL9TqroUdSqY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bHMJSm1zhpf9pSiOwoVzSksc5OMm15FJzxB1VW75skwsQLhnfNrOFjiQnsCqUgGWe
	 YDmnbZ58BKSe/jj6t6f8Y2/OoGfL1+v9dD/NT3Ud1Kc6EX35axRWbCL9Acfc2nrXjm
	 YDRlwQ6eHEgrog9E4zHBrYCP8/ZUelN7X/B9R7as=
Date: Tue, 13 Aug 2024 12:48:27 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
Cc: johannes@sipsolutions.net, sashal@kernel.org,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	javier.carrasco.cruz@gmail.com, skhan@linuxfoundation.org,
	stable@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>,
	syzbot+19013115c9786bfd0c4e@syzkaller.appspotmail.com
Subject: Re: [PATCH v5.15 RESEND] wifi: mac80211: check basic rates validity
Message-ID: <2024081321-scanner-blunt-e1da@gregkh>
References: <20240810095432.89063-1-vincenzo.mezzela@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240810095432.89063-1-vincenzo.mezzela@gmail.com>

On Sat, Aug 10, 2024 at 11:54:31AM +0200, Vincenzo Mezzela wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> commit ce04abc3fcc62cd5640af981ebfd7c4dc3bded28 upstream.
> 
> When userspace sets basic rates, it might send us some rates
> list that's empty or consists of invalid values only. We're
> currently ignoring invalid values and then may end up with a
> rates bitmap that's empty, which later results in a warning.
> 
> Reject the call if there were no valid rates.
> 
> [ Conflict resolution involved adjusting the patch to accommodate
> changes in the function signature of ieee80211_parse_bitrates,
> specifically the updated first parameter ]
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Reported-by: syzbot+19013115c9786bfd0c4e@syzkaller.appspotmail.com
> Tested-by: syzbot+19013115c9786bfd0c4e@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=19013115c9786bfd0c4e
> Signed-off-by: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
> ---
> Hi,
> I'm resending the backport for v5.15 [1], following the one I previously
> sent for v6.1 [2].

Now queued up, thanks.

greg k-h

