Return-Path: <linux-wireless+bounces-74-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4B47F8BD8
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Nov 2023 15:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 079DB1C20BA8
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Nov 2023 14:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE1628DB8;
	Sat, 25 Nov 2023 14:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v5mRcIDQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E6C28DAD
	for <linux-wireless@vger.kernel.org>; Sat, 25 Nov 2023 14:48:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CDEFC433C7;
	Sat, 25 Nov 2023 14:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700923729;
	bh=tS+XD1FVGDo2P6LA3feC8M3YjSB4G+skn0rfq45uNdA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=v5mRcIDQ6F27z7/oqY8Xb1ZybREwiZ5PAqpxWzHIf/EXMsVjqqSCMZ+dnRtrswOGd
	 2tr+gHbd6GirIGI6Hxb7VIaiXEYX9rv+6qtX6rTGECG6Ws8SsLrvuJKaQ2cgWriEuQ
	 c86kEduv8S8KIKER09womRbefHoPWj0Xo1W7+jFk=
Date: Sat, 25 Nov 2023 14:48:46 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH v2 3/6] debugfs: add API to allow debugfs operations
 cancellation
Message-ID: <2023112537-anyhow-bottle-f499@gregkh>
References: <20231124162522.16344-7-johannes@sipsolutions.net>
 <20231124172522.8c5d739c69e7.If54cd017d5734024e7bee5e4a237e17244050480@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124172522.8c5d739c69e7.If54cd017d5734024e7bee5e4a237e17244050480@changeid>

On Fri, Nov 24, 2023 at 05:25:26PM +0100, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> In some cases there might be longer-running hardware accesses
> in debugfs files, or attempts to acquire locks, and we want
> to still be able to quickly remove the files.
> 
> Introduce a cancellations API to use inside the debugfs handler
> functions to be able to cancel such operations on a per-file
> basis.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

