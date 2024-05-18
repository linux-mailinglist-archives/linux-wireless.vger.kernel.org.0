Return-Path: <linux-wireless+bounces-7821-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9748C903A
	for <lists+linux-wireless@lfdr.de>; Sat, 18 May 2024 11:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC61B1C20C2D
	for <lists+linux-wireless@lfdr.de>; Sat, 18 May 2024 09:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DD2D518;
	Sat, 18 May 2024 09:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b="W9kDv8HM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3C38BEA
	for <linux-wireless@vger.kernel.org>; Sat, 18 May 2024 09:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716025182; cv=none; b=fXpWDCSheZcTxbklfOEK3dFAAk2XChG8+x8qW/zuMIZANE3ZjyBSiu8BHAJoP1zbb1BLet3xV9KgD2F721GMF94qO4E0ma6uK5QU6J67qcqivpLlOAkBqwCY0cfligRL9kev7wz0kGWW1M1s/d1zr60d39voX8ZlfO2uIq8VYKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716025182; c=relaxed/simple;
	bh=GaW6SJ0y5ACHq40Q+snAE/jXdY+9vyZAvZFvfytqnTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cOzP4BY9oZ2dFqeipPF4TkKvKhEjQuw9GsIwDpe2sweKQVrrFs5CN6gL5h6HKkmsMkBa9ogfoIewiFd97YVcWB9EHz7EeLFM3hCNJwoXr4IdfEwfhq2+nnAY2JJLtPbWJ2+NLl5V6aZshiqdk0ukWQnFbxnomc1J1lmaEvCptu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b=W9kDv8HM; arc=none smtp.client-ip=212.77.101.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 15185 invoked from network); 18 May 2024 11:32:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1716024777; bh=gGODbJkICyAxfAiIi+NaeXR7OHBXZUSxs2djsM/glhg=;
          h=From:To:Cc:Subject;
          b=W9kDv8HMV1ZsvRjYBmjKCUwDXyGk4AqR34arxGtHsmJpRgxGMy2839isrEs7HYHik
           v9UBjmZV9lBC80Z/h9JF+iwk0WA//Yn1TgUaa4AWdSUsWQh5YuUST0/sMLjpSoN5/o
           V0zNZhhE0EfTxexzB0FWTST5negBoFkJk+4qUi+k=
Received: from 89-64-9-76.dynamic.chello.pl (HELO localhost) (stf_xl@wp.pl@[89.64.9.76])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <dmantipov@yandex.ru>; 18 May 2024 11:32:57 +0200
Date: Sat, 18 May 2024 11:32:56 +0200
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] rt2x00: remove unused delayed work data from link
 description
Message-ID: <20240518093256.GB643846@wp.pl>
References: <20240515152824.143537-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240515152824.143537-1-dmantipov@yandex.ru>
X-WP-MailID: e3cfb40634dbc975aaf87e1edd80b6f3
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [MWNk]                               

On Wed, May 15, 2024 at 06:28:24PM +0300, Dmitry Antipov wrote:
> Remove unused 'agc_work' and 'vco_work' members of 'struct link'.
> This follows commit d96324703ffa ("rt2x00: merge agc and vco works
> with link tuner") where AGC and VCO calibration code was completely
> redesigned. Compile tested only.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>


> ---
>  drivers/net/wireless/ralink/rt2x00/rt2x00.h | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00.h b/drivers/net/wireless/ralink/rt2x00/rt2x00.h
> index 82af01448a0a..bb648f95dfdd 100644
> --- a/drivers/net/wireless/ralink/rt2x00/rt2x00.h
> +++ b/drivers/net/wireless/ralink/rt2x00/rt2x00.h
> @@ -335,16 +335,6 @@ struct link {
>  	struct delayed_work watchdog_work;
>  	unsigned int watchdog_interval;
>  	unsigned int watchdog;
> -
> -	/*
> -	 * Work structure for scheduling periodic AGC adjustments.
> -	 */
> -	struct delayed_work agc_work;
> -
> -	/*
> -	 * Work structure for scheduling periodic VCO calibration.
> -	 */
> -	struct delayed_work vco_work;
>  };
>  
>  enum rt2x00_delayed_flags {
> -- 
> 2.45.0
> 

