Return-Path: <linux-wireless+bounces-19683-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9446DA4B820
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Mar 2025 08:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23F863A7222
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Mar 2025 07:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109DD1E3DF4;
	Mon,  3 Mar 2025 07:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ShSSPLgl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8CD4C85;
	Mon,  3 Mar 2025 07:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740985864; cv=none; b=O5iq5ljJXYyfysLUkOXWnGa355LA3AriQTaeZ4CBDBFc360VRD47dSpQ4HyBiDPY7ttUsWX+h8cI7EoVAHMwAu+BN9QZU7U6xY4X8CmuQk9sqtdcBWo7ztZWB84DZF0fC0AERDKA62jCDxGwbAu76CZOtjnvdQfqp3QbVupmyc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740985864; c=relaxed/simple;
	bh=zmZzLghaj28fS0mz2nIeCdQRxgIUthXc2QKh7/R57yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jEctv0lePHOVf9GHiJbiivbwUbPV6svkvs7wjwnRzUCYM+HH9HE5RZTiDpGYTP63m8j+M6JThOTEDKzPRg4P06m79/O914hNFlvwgkP/Vu+Pge9MopQlTVX/O0Sh1+J/i2dHccZJuRyQhylInYzzRkXOzuUPIp5/do/HeOyjVak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ShSSPLgl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44B5EC4CED6;
	Mon,  3 Mar 2025 07:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740985863;
	bh=zmZzLghaj28fS0mz2nIeCdQRxgIUthXc2QKh7/R57yc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ShSSPLglfGBf5GWuTrRSWIvj4kuRLoz500gaDN1pxsQJJzHv3sB6Sg9iqnX4Bm6li
	 Iq3+PFl9ZtZEOeAiYcptv08smtq8qcrNOPHMlTpupxKzgvJnouerFs8APsMisCANFG
	 riPK5L/nVsA05XxlOfEc89YJrShVc+KBlCn4R3Bm+C6KL3enpUeX/0pXmLhD6uqPOF
	 GnsNya3n3Q2uNdDiQxZM1PXwjB5SaPTRL5kXPm1TznxYz3jG+1KOLbhzvemuOjueiz
	 r3OVJttLG3i747qq9zd3VzLdashpsTjpueR6MIIEOEA0eDOdLxYQqlGJBuKN1UsRuu
	 kHBaPq4Io3HwA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1tozx3-0000000059s-0qJS;
	Mon, 03 Mar 2025 08:10:57 +0100
Date: Mon, 3 Mar 2025 08:10:57 +0100
From: Johan Hovold <johan@kernel.org>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: Jeff Johnson <jjohnson@kernel.org>, ath11k@lists.infradead.org,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kalle Valo <kvalo@kernel.org>
Subject: Re: ath11k: WCN6855: possible ring buffer corruption
Message-ID: <Z8VWAWl5UdZQYGgr@hovoldconsulting.com>
References: <Zh6b-38tGGXo-ee7@hovoldconsulting.com>
 <Z8Gr-IMD-UZTU-X5@hovoldconsulting.com>
 <1f8fa248-c18a-4bb9-b995-0961f7f3fa37@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f8fa248-c18a-4bb9-b995-0961f7f3fa37@oss.qualcomm.com>

On Fri, Feb 28, 2025 at 09:07:32AM -0800, Jeff Johnson wrote:
> On 2/28/2025 4:28 AM, Johan Hovold wrote:

> > The ath11k ring-buffer corruption issue is hurting some users of the
> > Lenovo ThinkPad X13s quite bad so I promised to try to escalate this
> > with you and Qualcomm.
> 
> I've escalated this with the development team.

Thanks, Jeff. Just let me know if you need any help with testing patches
or firmware updates. We have a couple of users that can reproduce this
very easily and that are also able to test patches.

Johan

