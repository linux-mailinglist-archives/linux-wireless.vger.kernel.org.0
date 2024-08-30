Return-Path: <linux-wireless+bounces-12248-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F64E9659CB
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 10:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 160B7286F12
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 08:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF2116C685;
	Fri, 30 Aug 2024 08:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="r7ctkKkY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C995B16BE02;
	Fri, 30 Aug 2024 08:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725005579; cv=none; b=j8UAlxcH+hwe2i8jjCf8WUSwhRgyvHMKyaS2Hgcq/A8UP9epEIiUXQLvCjrwpp8F4fTOzUORketA6QqI76udJs6yBtm4CqMRjzFHKh9jqQXYBV1lRqDIlQAUFGCoID011u5Pj/BG41afJ+bf1/mzAGRD3YDHpW0v6ITpRVqsrpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725005579; c=relaxed/simple;
	bh=v3DB7/wfkuj2OXRpDZqsy5JFYbQMU6MuQaoFr8qCt/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X7VxW4VZGaSygzaupwsDgbm3wyjuhw9G6pehhtLDtsXliiLOnWd64XVzKtOJUAgd4C1m5Q0hMb9QbRg+sfqOoWztG7E1hW+HOEi+OVS3VA7atfuNfGPIhOCReKf1lVr+GHR+X/ihGudUaJHgSOkqH8DI6bc2OmZh3woWKqbgGdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=r7ctkKkY; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id D04AB21155;
	Fri, 30 Aug 2024 10:12:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1725005574;
	bh=fiD5XQzLCAeAEkNXH//mXB8vAMuGfPbI0F9peufA/ss=;
	h=Received:From:To:Subject;
	b=r7ctkKkYVxvuai87H+EJpBu1XXbhtGY9dhGEWZXh/oEZResaGPQ3cWvbrZK6bBcvc
	 T7q/sLrgC0Qog5PpUUpUtbXG1eyQHe4BM8ft0lxl8V++Poj5Q+O3FY88jhJJC5KdAf
	 td4F/eK5/MejW+9f3pD5pZIBxJvDxLto10eD3INlpdcvNRvaf7lTjpeg78DsMilAG6
	 qVNaB9g/fKi1BIADyoWj/qiq0xZ5FibRYRjWaien7kCuCOyzHtB8S3Xelw1MXYhuPM
	 DWXIsak5SCxo+aJ1fcCGeIQ0R03Qo1kkVCdrxbWXOrKMVru0uzmOrojNIDKsIi1und
	 aukWfUl7MUwKA==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
	id 7C32D7FCE6; Fri, 30 Aug 2024 10:12:54 +0200 (CEST)
Date: Fri, 30 Aug 2024 10:12:54 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: David Lin <yu-hao.lin@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	briannorris@chromium.org, kvalo@kernel.org, francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com
Subject: Re: [PATCH] wifi: mwifiex: fix firmware crash for AP DFS mode
Message-ID: <ZtF_BnSHrrm15IY2@gaggiata.pivistrello.it>
References: <20240830080719.826142-1-yu-hao.lin@nxp.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830080719.826142-1-yu-hao.lin@nxp.com>

+Sascha

On Fri, Aug 30, 2024 at 04:07:19PM +0800, David Lin wrote:
> Firmware crashes when AP works on a DFS channel and radar detection occurs.
> This patch fixes the issue, also add "fake_radar_detect" entry to mimic
> radar detection for testing purpose.
> 
> Signed-off-by: David Lin <yu-hao.lin@nxp.com>

Sascha: FYI, given you are working on this driver lately.

Francesco


