Return-Path: <linux-wireless+bounces-23985-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0577AD4A16
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 06:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D0867A1F0F
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 04:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A841C862C;
	Wed, 11 Jun 2025 04:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j5Hx88Ko"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C2319924D
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 04:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749616673; cv=none; b=GVWeCHeJ4brsA/zOMorc3IDSR9Rj3nbw4SNU7blomGkIaMcJsoE2mpTZb3JYewq1FN25myPwLWBcQUSrOqXWIkds7HPna/0yMygztGRbVeYbwALymvzE6mzOXLw4orCwBVuVqO+2b43A3cAj7LlilJ8bGP/28Hym3gwPUinasJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749616673; c=relaxed/simple;
	bh=TfZ07W2uCkBNI9p2iHLuOlIUrxn9e1xYgknUoZFI+hE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F6XFTdXZu1EEQ68DlwOIOXaBc24aHHsjA8p0X/KKMkOkSMHsQpetwmyjstEQO3F2eiyIzHBs+xtwx3Wkhxjpj20IuyN71LNbBJRSu2vfy8Wb8TAmb15ZkMnNWpow1gc6pco5VEViiUYNmF8TYAyoC1/pWtmEOALke6e2fGK7+Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=j5Hx88Ko; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b26df8f44e6so6245166a12.2
        for <linux-wireless@vger.kernel.org>; Tue, 10 Jun 2025 21:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1749616671; x=1750221471; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FE1cAWbg11FBslkXTnrUJG3ETee3kwzfdEhvTNzCUjg=;
        b=j5Hx88KoSICauE7LHZgBDDf1nljkDh7ihDMZDxP/b+tVds4tZhxR3UO9kgiPc246lG
         xxeKvFlHn0ZCsMXEhJtAfaJBkgNY+3AHE89r+3J8Uy9pOXrm+EEimF73a9IcAtM+Vlm+
         y7FIKusQXLROG4bdc7J8ASrAYoaVs7T6ZsMo0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749616671; x=1750221471;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FE1cAWbg11FBslkXTnrUJG3ETee3kwzfdEhvTNzCUjg=;
        b=BlJLYSVpw1AnU0y53NVkVFfaeBZRARjep36+Alporz5p+6jESfC/AmUqXxEvN2W5h1
         8vG8pYrK8BEacVcd5hlowA1ExFlOwaGX0cRSOJOuHC2xdlsVuePtPFSiKE6BN3nds3Fm
         ULmk274VC0hnFJ2Vq7aMWFM43KJ77ZX3KaiUygNl+6yEK+dX85lPI+Ggt8fNMk1+zOy0
         G32bx4zapVHgR262jfrxrSdxS5Qt3mA6EmhUk5zjX1uXr3oeMJES3dQDa+OqK70s/KcI
         aXaogqksIZfQOueL9H8TlCVrOQHN3rkTmqH1YBn/W04DfnvqRqhKBUwonkvrMuoGo0+g
         liew==
X-Gm-Message-State: AOJu0YyT1+nR7sOqZc8/ILTLTBDfvGG8hUhMlmUbjG0qeLwmh4P8oJM3
	CZMG7v8BARQSxkIc4HpKr9MTZxBh8IkX0dATqDIcUuDGGyegD1RoxaFkCMjnF36jew==
X-Gm-Gg: ASbGncsYeLlrRFQDBFupwiJUMHTHHZ3AMqjXTvbmmfSNOwrM5oh096X26WxwADjSB2v
	zTjAp641hNqeJ/41+EH/KstNdocVGU9bt/t+C+hTz4rfKUPx75GAUquh5KwYPyMOIZx0JfZiyp3
	wjb2Y5sIdKxBYOZFJrbP8ProLESQskBoFrBUg/pIbRVm6n/BFLxGKQ1ZguBITDdVR668roq4mTb
	Vsv2SP69IjR17qRMXBDrFS9F7R3uMKHokjOgpkqDn02GQpgAJzZ1WeRbODkBhv9SAWCq7/RZWfj
	xQGV7wvXqfiKzEYHo/iL/Xh7uZUmjJiS5o0aJijsrKsn0MwFamZnwxgWgiW45gInTTLNEem9lNe
	B
X-Google-Smtp-Source: AGHT+IFM8NgLpiLIoUkojJ3i2pht8cBR3G2XAm5m39HTWlGcYeBr0M+6D9ErnNi2+LitOkchPJZG1g==
X-Received: by 2002:a17:903:32c1:b0:235:a9b:21e7 with SMTP id d9443c01a7336-23641b2654bmr26834905ad.48.1749616671102;
        Tue, 10 Jun 2025 21:37:51 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:eac8:ff09:e566:df3a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23603077eb7sm78450355ad.39.2025.06.10.21.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 21:37:50 -0700 (PDT)
Date: Wed, 11 Jun 2025 13:37:46 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCHv2] wifi: ath11k: mark reset srng lists as uninitialized
Message-ID: <74caimlaibla7rge2eoiubeesp6pz7e6u7ifvbw57t4e6q4qso@iypz4pqd7kpr>
References: <20250529035708.3136232-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529035708.3136232-1-senozhatsky@chromium.org>

On (25/05/29 12:56), Sergey Senozhatsky wrote:
> ath11k_hal_srng_deinit() frees rdp and wrp which are used
> by srng lists.  Mark srng lists as not-initialized.  This
> makes sense, for instance, when device fails to resume
> and the driver calls ath11k_hal_srng_deinit() from
> ath11k_core_reconfigure_on_crash().
[..]

Gentle ping.

