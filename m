Return-Path: <linux-wireless+bounces-11615-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5909568C9
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 12:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84D171F22226
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 10:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E0C165EE9;
	Mon, 19 Aug 2024 10:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cT4kPh8T"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7325416193C;
	Mon, 19 Aug 2024 10:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724065012; cv=none; b=uwdj1dNYs7wNzDEPvxEmzvr+IFq5gGUNCXsJ7erhf+TZIVxLolfHyZksHvKhPjp3eVGMZ5S7ahaZmXsAljzc+cgSSPxhzF3mNcDRr0tazNln4hsNeKIxyhE8APsrYrktE7rYH8JaEQXV8PBTrWZpjbExYM88hqd4w1EmVYM3ugQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724065012; c=relaxed/simple;
	bh=krKWk/uvZl/f9E5k+1tVWHW21F0jEo8yrBSRmeEula4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rKv9n5yyhWbIa4zc8vxuRCb29YG+RcZISWv4BwJVDznQqaF+tiYsOoguxi8VUXpcga5yy9SnZ4mCVGH2b3CinGrJ2X+gGtcQc5w4b5KchcC+fDznDObSds+G0/FzSsorL4DP6axV6S+jSbbKTh2ARpkvjFKCR6ffYiArfGXZkVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cT4kPh8T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4AB0C32782;
	Mon, 19 Aug 2024 10:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724065012;
	bh=krKWk/uvZl/f9E5k+1tVWHW21F0jEo8yrBSRmeEula4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cT4kPh8TnX9XyRByVl/mUHDsFPZvFkprXy+bsorPtN0xzO3SPzlppd2OQXHslzKJC
	 rwSI818ar17gxJT6mZQSorQnyr5OWOlxQCef4J9N+DX/iV9K61S/1rrmszWkOxCCKY
	 4ridjtw1PohcZggP5idfAj1i97TQdFVi+Fk9Pi84=
Date: Mon, 19 Aug 2024 12:56:43 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: color Ice <wirelessdonghack@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, kvalo@kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-wireless@vger.kernel.org, mark.esler@canonical.com,
	stf_xl@wp.pl, tytso@mit.edu
Subject: Re: Ubuntu RT2X00 WIFI USB Driver Kernel NULL pointer
 Dereference&Use-After-Free Vulnerability
Message-ID: <2024081946-designate-dioxide-c59d@gregkh>
References: <2024080359-getaway-concave-623e@gregkh>
 <20240814055816.2786467-1-wirelessdonghack@gmail.com>
 <91e19cf3-216b-48ac-a93d-f920dd2a7668@rowland.harvard.edu>
 <CAOV16XEsgkLWz3rOQsAdve-qKsPEDw-QxJNoo4hJfXdLnowHfw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOV16XEsgkLWz3rOQsAdve-qKsPEDw-QxJNoo4hJfXdLnowHfw@mail.gmail.com>

On Mon, Aug 19, 2024 at 06:49:42PM +0800, color Ice wrote:
> How is the patch development progressing? We would like to conduct a
> full verification test. It’s possible that many drivers have this
> issue, so you could try a simple fix, and we’ll see how it works.

This should be unique to this driver, but please, test others.

> Recently, we tested some embedded devices where the operating systems,
> due to automated operations involving WiFi drivers, had UDEV rules
> built-in or granted significant permissions to USB. This allows the
> PoC to cause a kernel crash without needing root or sudo.

But how are you allowed to run local programs on systems that have those
types of permissions?

thanks,

greg k-h

