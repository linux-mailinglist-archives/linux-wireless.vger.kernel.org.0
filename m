Return-Path: <linux-wireless+bounces-13723-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B637994522
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 12:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1CE728380A
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 10:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C5F17D36A;
	Tue,  8 Oct 2024 10:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yzfcTRcY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2B6178CE4;
	Tue,  8 Oct 2024 10:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728382530; cv=none; b=j7Yx1Gi0UmIe258yFfkUUrJ5sC/hC0apMsjuY6qgQIN9xUQmhE2V/vCwyaTNUVvIQkdiSKxnXoFJKXythIHiG2v8W88Wd+f6pOjl5xn2sdisblspNyT7itGT4fkVhu7751l5jDDlG4asGRBCR59+IsdsIctJRSBnGL3ywMJPqsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728382530; c=relaxed/simple;
	bh=5uKeaqMt/GdqJEKlGCNjF5gmtpuDxfFOdgOPZVcDOek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q9j8+bJL3aITBq/tQAWNvJjiioS1F6wRhcvrxOxwUiYjExuUlh+mhpEUpoSM9uJPA/oso3q5cKPkRdaSWMoh5arzhh++z5pRnqjP1omSIR3FTfofx8sGGYNY8NlPId+sZd6wcCsOUKt34Q+zH3R1lsUH3rffXkzjfF549TvN8nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yzfcTRcY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8B1DC4CEC7;
	Tue,  8 Oct 2024 10:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728382530;
	bh=5uKeaqMt/GdqJEKlGCNjF5gmtpuDxfFOdgOPZVcDOek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yzfcTRcYPASnzRNOCsyrBKfMye3o19Sj4P3PFLOVPCmQgSw7NIInBWN4gJUgjkhkT
	 2e4ZS26ps8XcOp44kRb+L/+SD4smYDQ3oi3zzm/oA8rj4L67BJh2ICI9ULNHE6th3K
	 ijOC7PAReY0ySLl2LbR1mb0rUSlLl0P2OPtpAkhY=
Date: Tue, 8 Oct 2024 12:15:26 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-staging@lists.linux.dev,
	Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH v2 6/6] staging: don't recommend using lib80211
Message-ID: <2024100817-creation-emergency-9669@gregkh>
References: <20241007182706.66888-8-johannes@sipsolutions.net>
 <20241007202707.87481ddcfc00.I2cfb9940807e9c5017a052efcd3d1f2b6dc15fb1@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007202707.87481ddcfc00.I2cfb9940807e9c5017a052efcd3d1f2b6dc15fb1@changeid>

On Mon, Oct 07, 2024 at 08:26:56PM +0200, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> No longer document drivers should switch to lib80211,
> they really should never have done that. While at it,
> also remove the recommendation to use cfg80211, if it
> switches to mac80211 then it implicitly uses cfg80211
> but doesn't need to do anything about that, normally.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  drivers/staging/ks7010/TODO    | 2 --
>  drivers/staging/rtl8712/TODO   | 1 -
>  drivers/staging/rtl8723bs/TODO | 1 -
>  drivers/staging/vt6655/TODO    | 1 -
>  drivers/staging/vt6656/TODO    | 1 -
>  5 files changed, 6 deletions(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

