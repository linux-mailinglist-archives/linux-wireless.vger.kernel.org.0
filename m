Return-Path: <linux-wireless+bounces-21433-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A1AA855F3
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Apr 2025 09:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F33F1B67A2D
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Apr 2025 07:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8964B293440;
	Fri, 11 Apr 2025 07:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="Pg3+w1Tk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10321E7C0E;
	Fri, 11 Apr 2025 07:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744358308; cv=none; b=ETGRw07/NU0qy+O5B5DetomwX22eUViRx7lpLTP6BTCUmVGVbCDDcs96lF160eDL6+EDpqh4qyDQ1jm01+mCQ5H6jENyusWsFkNbj66V9FfMnJtvrL3G5t8oZexBnb5Ie0BPfnLjX7p1bKjMOJG93gGZVgWVzH6jHFjwzsoUmuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744358308; c=relaxed/simple;
	bh=RPYcAqD4y+hgyeMW2NJKkGGQDPPJG1ewfZv3Mzh/woc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gm29BKxSenwRG1XvoOrimDgfwDm+ZQ833IaWxxo3iB8lm3+wgC83erTtGW1yQmmdM1N/pM+BiJ1eKA8vd+CeLgjSp0ZIh23QVbguzoGQtCTQRAvmCAfbpLWeuMRIGnUHV80VCLATXF7e7I7gunHIA7mve7bvFPKYGWjdnUjPvCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=Pg3+w1Tk; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 31B1F1F95D;
	Fri, 11 Apr 2025 09:58:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1744358302;
	bh=jhFLKSiuMEHIVF1fYtgFDkjX7z90xWK4KoI2jpP6mFQ=; h=From:To:Subject;
	b=Pg3+w1TkdRCZg2QZGbZQGRD7HO7IKsprBmVvuMDem+CGtF4FKPugDC3PWt6kc/UpQ
	 ZIUiGHZQoVil7td6XlFXUMOK5SqiMuJWBUzLSPfHqCsAWYyjX+UQH7zql9jsahxBxV
	 dk6YSV0+8hkrq+h7B8z/zh+sgm2NQ95peP4wxcfweqInP8kTstnsyWdc6pFj0hpxTq
	 QsuKtlt4wQElvlTrvePVq+kQKqv08wzSO5yNxtP+RnPDSgce1z4TrbdHirgldKNUCv
	 VTDcvGgQjw9T4RIOha+GtE/u23ohjDjeSXt4xmLovcrvwqUsgnBZDagEcMaHhQm51O
	 OfTxXUSsaoqsA==
Date: Fri, 11 Apr 2025 09:58:20 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH 2/4] wifi: mwifiex: let mwifiex_init_fw() return 0 for
 success
Message-ID: <20250411075820.GB12707@francesco-nb>
References: <20250410-mwifiex-drop-asynchronous-init-v1-0-6a212fa9185e@pengutronix.de>
 <20250410-mwifiex-drop-asynchronous-init-v1-2-6a212fa9185e@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410-mwifiex-drop-asynchronous-init-v1-2-6a212fa9185e@pengutronix.de>

On Thu, Apr 10, 2025 at 12:28:44PM +0200, Sascha Hauer wrote:
> mwifiex_sta_init_cmd() returns -EINPROGRESS as sucess indication when
> the init param is true. Likewise mwifiex_init_fw() returns -EINPROGRESS
> as success indication: It will either return -EINPROGRESS directly when
> in mfg_mode or the return value of mwifiex_sta_init_cmd() when in normal
> mode.
> 
> -EINPROGRESS is a leftover from times when the initialization commands
> were sent asynchronously. Since 7bff9c974e1a ("mwifiex: send firmware
> initialization commands synchronously") the return value has become
> meaningless, so change mwifiex_sta_init_cmd() and mwifiex_init_fw()
> to return 0 for success.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>


