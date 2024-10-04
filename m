Return-Path: <linux-wireless+bounces-13539-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A69E991270
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Oct 2024 00:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C3ED1C22B06
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2024 22:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C6F1B4F19;
	Fri,  4 Oct 2024 22:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z++65vcB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1161474B9;
	Fri,  4 Oct 2024 22:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728081728; cv=none; b=oQpiblb1ZCc99BWmwTyvcf+qKQf/WDI5b0RRAc4NPr5beX0qroJA/d+MoDc4Ub/ZItMQwEPsX+dM9op7CIpyEGurWlEcZr6sbEJKBs/rjm4BzRV99QHClLlQaijvoc3yPnALkVBYqUQqF+kYAFpK17lVlUB4PX2D4QMxuqt1qBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728081728; c=relaxed/simple;
	bh=DLwyO9Ncz6BOMfBaVFAXwE5KZHjpGHovfZ+mWg0ekiI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kyk5weGW+eWes51pGV65R0uZiozfEevaM6qQ2b2MyB1GagyoG1SnQ6MWwr3gHrfithM4ZkZxF6tjUN65wzKbvUYufinjrA+aY6HWjmdVZHceEXqga3HBhWyfIJVizkDqjoelOXdqV3oLp0d0hqmRRcsVd+E/km8GDLe8TdtrHVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z++65vcB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55ED9C4CEC6;
	Fri,  4 Oct 2024 22:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728081727;
	bh=DLwyO9Ncz6BOMfBaVFAXwE5KZHjpGHovfZ+mWg0ekiI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Z++65vcBDOMSZo4YWC+EUQPSi/YxgagQdrmHEb7SFhuOHzkvHvpZNvPIVRq5u0GPa
	 1N7pQthTiqZEBYSz7uuAvm5kBLilEJIemLOIf3TqSI5o3mbVFBnT2MXjBKkXSOLsmh
	 1Y2AwinwR5utgo3kkzFQrze9CXgoBt9qVMN8cjn+1XTax5u2iD0qh7J5WpblgsdBEc
	 grM86Fb0of9+MQ909EgQcstag+Mz/cG51/GYBYD5pLNgNj5pGgI++3h4WB32IJ8rdp
	 XtmrjmnR6GXGAIOI4EPJmeaX/JkSsky4p/i7x0JqWJAfGZUPD1dLqIr9JUhiFTB+aa
	 vh/ChPi0ufbVQ==
Date: Fri, 4 Oct 2024 15:42:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Johannes Berg
 <johannes@sipsolutions.net>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, linux-kernel@vger.kernel.org,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH RFC net 0/2] MAINTAINERS: Networking file coverage
 updates
Message-ID: <20241004154206.543718f5@kernel.org>
In-Reply-To: <20241004-maint-net-hdrs-v1-0-41fd555aacc5@kernel.org>
References: <20241004-maint-net-hdrs-v1-0-41fd555aacc5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 04 Oct 2024 11:03:20 +0100 Simon Horman wrote:
> 2. Excluding some files relating to Wireless from NETWORKING [GENERAL],
>    making their handling consistent with other files related to
>    Wireless.

LGTM, FWIW, on the wireless side I generally add stuff which seems like
it causing people to mis-post. But no objections to listing more files
either way.

