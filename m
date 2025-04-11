Return-Path: <linux-wireless+bounces-21432-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F551A855AA
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Apr 2025 09:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BA017A7FAE
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Apr 2025 07:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C96128EA47;
	Fri, 11 Apr 2025 07:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="HD1Z8DLC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA73928EA52;
	Fri, 11 Apr 2025 07:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744357322; cv=none; b=SiGK6c18Ugyq3YhmL5T/8ujrNVOHbrWSWIRLqOAJFCKVudg2qoUxjIArXIPiZnS6V3aQE171D1OJSxJLZd8V0W6VbLhHc/E77ohE28K0d3i4I/zNgKQH9rA99M33P9QJjzGKe0Q9H+/L6XLF7AqdMS02FC3fpuNyFmkZxj8X9Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744357322; c=relaxed/simple;
	bh=lDciwDSB+Q8RHrtpBmFw8CuEsorY9NR80tu5cfO+FKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GJhfCLfiujhy3+X8oGbtV3t1RQO0eHvxYGdIKz1hLRWa485r7gL/wljwtFhZj5C3rEfUv7HtUiE1dkpn6iZJE+HvIwugAzaIXlS8nT9R2OJz1Z7B+UlxdmLSaXlo85td+TiaysUo7xU4qXMf1dmwo3vXjeTNrSQvxwaXvlmhHdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=HD1Z8DLC; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 921A71F902;
	Fri, 11 Apr 2025 09:41:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1744357308;
	bh=qzlruQ0UPIPGDnxKdS/af/06MdcIsKAg/0N3dWvtqv8=; h=From:To:Subject;
	b=HD1Z8DLCvxEj8dKDHipjhqUxD17mn+N+6lil99+0xgT6qAZd4ll6CcqkJSWq5lZ82
	 FbMbmwpZ0Kp6FLMco83BoYIe6aBZgKY3R6fNgF5VwjSY9ELXCx+657dOiLfKFrYeR3
	 qnieKVJHADn6kv0PgOUFny5T1x4vzIdBmXI8iOJMrkbVLn7/eEwGgL6qLz5G3oTeGT
	 HNlce8SYkL9T1g6vpcZfuC518M4fHEN4WdnZ1jsGLkmX1+LlWws/YI03OX6L1/svDi
	 oS3Qj1RftqZBLNVb2SF4BwQSSAuSqiv7+8mpX4c3bNhUh5G1plhUPgZUQvatGLDVup
	 l25mdgW/OGVjA==
Date: Fri, 11 Apr 2025 09:41:44 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH 1/4] wifi: mwifiex: remove unnecessary queue empty check
Message-ID: <20250411074144.GA12707@francesco-nb>
References: <20250410-mwifiex-drop-asynchronous-init-v1-0-6a212fa9185e@pengutronix.de>
 <20250410-mwifiex-drop-asynchronous-init-v1-1-6a212fa9185e@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410-mwifiex-drop-asynchronous-init-v1-1-6a212fa9185e@pengutronix.de>

On Thu, Apr 10, 2025 at 12:28:43PM +0200, Sascha Hauer wrote:
> Since 7bff9c974e1a ("mwifiex: send firmware initialization commands
> synchronously") all initialization commands are sent synchronously which
> means the command queue is empty when mwifiex_sta_init_cmd() returns. No
> need to check for entries in the command code then, so remove the check.
> 
> Add a WARN_ON() just in case there is something wrong with the
> reasoning.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>


